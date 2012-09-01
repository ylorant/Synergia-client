/* window.c generated by valac 0.16.0, the Vala compiler
 * generated from window.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <SDL.h>
#include <gee.h>
#include <stdlib.h>
#include <string.h>
#include <SDL_ttf.h>
#include <SDL_gfxPrimitives.h>


#define STK_TYPE_WIDGET (stk_widget_get_type ())
#define STK_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STK_TYPE_WIDGET, StkWidget))
#define STK_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), STK_TYPE_WIDGET, StkWidgetClass))
#define STK_IS_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STK_TYPE_WIDGET))
#define STK_IS_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), STK_TYPE_WIDGET))
#define STK_WIDGET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), STK_TYPE_WIDGET, StkWidgetClass))

typedef struct _StkWidget StkWidget;
typedef struct _StkWidgetClass StkWidgetClass;
typedef struct _StkWidgetPrivate StkWidgetPrivate;

#define STK_TYPE_CONTAINER (stk_container_get_type ())
#define STK_CONTAINER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STK_TYPE_CONTAINER, StkContainer))
#define STK_CONTAINER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), STK_TYPE_CONTAINER, StkContainerClass))
#define STK_IS_CONTAINER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STK_TYPE_CONTAINER))
#define STK_IS_CONTAINER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), STK_TYPE_CONTAINER))
#define STK_CONTAINER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), STK_TYPE_CONTAINER, StkContainerClass))

typedef struct _StkContainer StkContainer;
typedef struct _StkContainerClass StkContainerClass;
typedef struct _StkContainerPrivate StkContainerPrivate;

#define STK_TYPE_WINDOW (stk_window_get_type ())
#define STK_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STK_TYPE_WINDOW, StkWindow))
#define STK_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), STK_TYPE_WINDOW, StkWindowClass))
#define STK_IS_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STK_TYPE_WINDOW))
#define STK_IS_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), STK_TYPE_WINDOW))
#define STK_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), STK_TYPE_WINDOW, StkWindowClass))

typedef struct _StkWindow StkWindow;
typedef struct _StkWindowClass StkWindowClass;
typedef struct _StkWindowPrivate StkWindowPrivate;
#define _g_free0(var) (var = (g_free (var), NULL))
#define _SDL_FreeSurface0(var) ((var == NULL) ? NULL : (var = (SDL_FreeSurface (var), NULL)))

struct _StkWidget {
	GObject parent_instance;
	StkWidgetPrivate * priv;
	SDL_Rect rect;
	gboolean focused;
};

struct _StkWidgetClass {
	GObjectClass parent_class;
	gboolean (*draw) (StkWidget* self, SDL_Surface* screen);
};

struct _StkContainer {
	StkWidget parent_instance;
	StkContainerPrivate * priv;
	GeeList* widgets;
};

struct _StkContainerClass {
	StkWidgetClass parent_class;
};

struct _StkWindow {
	StkContainer parent_instance;
	StkWindowPrivate * priv;
	SDL_Color background;
	SDL_Color titlebg;
	SDL_Color border;
	gchar* title;
	guchar opacity;
	gboolean bubble;
};

struct _StkWindowClass {
	StkContainerClass parent_class;
};


static gpointer stk_window_parent_class = NULL;
extern TTF_Font* stk_stk_font;

GType stk_widget_get_type (void) G_GNUC_CONST;
GType stk_container_get_type (void) G_GNUC_CONST;
GType stk_window_get_type (void) G_GNUC_CONST;
enum  {
	STK_WINDOW_DUMMY_PROPERTY
};
StkWindow* stk_window_new (void);
StkWindow* stk_window_construct (GType object_type);
StkContainer* stk_container_new (void);
StkContainer* stk_container_construct (GType object_type);
gboolean stk_window_draw (StkWindow* self, SDL_Surface* screen);
guint32 stk_stk_color_to_uint32 (SDL_Color c);
gboolean stk_widget_draw (StkWidget* self, SDL_Surface* screen);
void stk_window_set_size (StkWindow* self, gint width, gint height);
void stk_window_set_position (StkWindow* self, gint x, gint y);
static void stk_window_finalize (GObject* obj);


StkWindow* stk_window_construct (GType object_type) {
	StkWindow * self = NULL;
	gchar* _tmp0_;
	SDL_Color _tmp1_ = {0};
	SDL_Color _tmp2_ = {0};
	self = (StkWindow*) stk_container_construct (object_type);
	_tmp0_ = g_strdup ("");
	_g_free0 (self->title);
	self->title = _tmp0_;
	memset (&((StkWidget*) self)->rect, 0, sizeof (SDL_Rect));
	_tmp1_.r = (guchar) 255;
	_tmp1_.g = (guchar) 255;
	_tmp1_.b = (guchar) 255;
	_tmp1_.unused = (guchar) 255;
	self->background = _tmp1_;
	_tmp2_.r = (guchar) 0;
	_tmp2_.g = (guchar) 0;
	_tmp2_.b = (guchar) 0;
	_tmp2_.unused = (guchar) 255;
	self->border = _tmp2_;
	return self;
}


StkWindow* stk_window_new (void) {
	return stk_window_construct (STK_TYPE_WINDOW);
}


gboolean stk_window_draw (StkWindow* self, SDL_Surface* screen) {
	gboolean result = FALSE;
	guint32 rmask;
	guint32 gmask;
	guint32 bmask;
	guint32 amask;
	const gchar* _tmp0_;
	SDL_Rect _tmp2_;
	guint16 _tmp3_;
	SDL_Rect _tmp4_;
	guint16 _tmp5_;
	SDL_Surface* _tmp6_;
	SDL_PixelFormat* _tmp7_;
	guchar _tmp8_;
	guint32 _tmp9_;
	guint32 _tmp10_;
	guint32 _tmp11_;
	guint32 _tmp12_;
	SDL_Surface* _tmp13_;
	SDL_Surface* subsurface;
	SDL_Rect _tmp14_;
	guint16 _tmp15_;
	SDL_Rect _tmp16_;
	guint16 _tmp17_;
	SDL_Surface* _tmp18_;
	SDL_PixelFormat* _tmp19_;
	guchar _tmp20_;
	SDL_Surface* _tmp21_;
	SDL_Surface* background;
	SDL_Surface* _tmp22_;
	SDL_Color _tmp23_;
	guint32 _tmp24_ = 0U;
	SDL_Surface* _tmp25_;
	SDL_Surface* _tmp26_;
	guchar _tmp27_;
	gboolean _tmp28_;
	gint16 ypos = 0;
	const gchar* _tmp40_;
	SDL_Surface* _tmp78_;
	SDL_Rect _tmp79_;
	gint16 _tmp80_;
	gint16 _tmp81_;
	SDL_Rect _tmp82_;
	guint16 _tmp83_;
	SDL_Rect _tmp84_;
	gint16 _tmp85_;
	SDL_Rect _tmp86_;
	guint16 _tmp87_;
	SDL_Rect _tmp88_;
	gint16 _tmp89_;
	SDL_Color _tmp90_;
	guint32 _tmp91_ = 0U;
	const gchar* _tmp92_;
	g_return_val_if_fail (self != NULL, FALSE);
	g_return_val_if_fail (screen != NULL, FALSE);
	rmask = (guint32) 0xff000000U;
	gmask = (guint32) 0x00ff0000U;
	bmask = (guint32) 0x0000ff00U;
	amask = (guint32) 0x000000ffU;
	_tmp0_ = self->title;
	if (g_strcmp0 (_tmp0_, "") == 0) {
		gint16 _tmp1_;
		_tmp1_ = ((StkWidget*) self)->rect.y;
		((StkWidget*) self)->rect.y = (gint16) (_tmp1_ - 20);
	}
	_tmp2_ = ((StkWidget*) self)->rect;
	_tmp3_ = _tmp2_.w;
	_tmp4_ = ((StkWidget*) self)->rect;
	_tmp5_ = _tmp4_.h;
	_tmp6_ = screen;
	_tmp7_ = _tmp6_->format;
	_tmp8_ = _tmp7_->BitsPerPixel;
	_tmp9_ = rmask;
	_tmp10_ = gmask;
	_tmp11_ = bmask;
	_tmp12_ = amask;
	_tmp13_ = SDL_CreateRGBSurface ((guint32) ((SDL_HWSURFACE | SDL_HWACCEL) | SDL_SRCALPHA), (gint) _tmp3_, (gint) _tmp5_, (gint) _tmp8_, _tmp9_, _tmp10_, _tmp11_, _tmp12_);
	subsurface = _tmp13_;
	_tmp14_ = ((StkWidget*) self)->rect;
	_tmp15_ = _tmp14_.w;
	_tmp16_ = ((StkWidget*) self)->rect;
	_tmp17_ = _tmp16_.h;
	_tmp18_ = screen;
	_tmp19_ = _tmp18_->format;
	_tmp20_ = _tmp19_->BitsPerPixel;
	_tmp21_ = SDL_CreateRGBSurface ((guint32) (SDL_HWACCEL | SDL_HWSURFACE), (gint) _tmp15_, (gint) _tmp17_, (gint) _tmp20_, (guint32) 0, (guint32) 0, (guint32) 0, (guint32) 0);
	background = _tmp21_;
	_tmp22_ = background;
	_tmp23_ = self->background;
	_tmp24_ = stk_stk_color_to_uint32 (_tmp23_);
	SDL_FillRect (_tmp22_, NULL, _tmp24_);
	_tmp25_ = subsurface;
	STK_WIDGET_CLASS (stk_window_parent_class)->draw ((StkWidget*) STK_CONTAINER (self), _tmp25_);
	_tmp26_ = background;
	_tmp27_ = self->opacity;
	SDL_SetAlpha (_tmp26_, (guint32) SDL_SRCALPHA, _tmp27_);
	_tmp28_ = self->bubble;
	if (!_tmp28_) {
		SDL_Surface* _tmp29_;
		SDL_Surface* _tmp30_;
		SDL_Rect _tmp31_;
		SDL_Surface* _tmp32_;
		SDL_Surface* _tmp33_;
		SDL_Rect _tmp34_;
		_tmp29_ = background;
		_tmp30_ = screen;
		_tmp31_ = ((StkWidget*) self)->rect;
		SDL_UpperBlit (_tmp29_, NULL, _tmp30_, &_tmp31_);
		_tmp32_ = subsurface;
		_tmp33_ = screen;
		_tmp34_ = ((StkWidget*) self)->rect;
		SDL_UpperBlit (_tmp32_, NULL, _tmp33_, &_tmp34_);
	} else {
		SDL_Surface* _tmp35_;
		SDL_Surface* _tmp36_;
		SDL_Surface* _tmp37_;
		SDL_Surface* _tmp38_;
		SDL_Rect _tmp39_;
		_tmp35_ = subsurface;
		_tmp36_ = background;
		SDL_UpperBlit (_tmp35_, NULL, _tmp36_, NULL);
		_tmp37_ = background;
		_tmp38_ = screen;
		_tmp39_ = ((StkWidget*) self)->rect;
		SDL_UpperBlit (_tmp37_, NULL, _tmp38_, &_tmp39_);
	}
	_tmp40_ = self->title;
	if (g_strcmp0 (_tmp40_, "") != 0) {
		SDL_Rect _tmp41_;
		guint16 _tmp42_;
		SDL_Surface* _tmp43_;
		SDL_PixelFormat* _tmp44_;
		guchar _tmp45_;
		SDL_Surface* _tmp46_;
		SDL_Surface* titlebar;
		SDL_Surface* _tmp47_;
		SDL_Color _tmp48_;
		guint32 _tmp49_ = 0U;
		SDL_Surface* _tmp50_;
		guchar _tmp51_;
		guchar _tmp52_;
		gboolean _tmp53_ = FALSE;
		TTF_Font* _tmp54_;
		gboolean _tmp56_;
		SDL_Rect _tmp64_;
		gint16 _tmp65_;
		SDL_Rect _tmp66_;
		gint16 _tmp67_;
		SDL_Rect _tmp68_;
		guint16 _tmp69_;
		SDL_Rect _tmp70_ = {0};
		SDL_Rect dst;
		SDL_Surface* _tmp71_;
		SDL_Surface* _tmp72_;
		SDL_Rect _tmp73_;
		SDL_Rect _tmp74_;
		gint16 _tmp75_;
		_tmp41_ = ((StkWidget*) self)->rect;
		_tmp42_ = _tmp41_.w;
		_tmp43_ = screen;
		_tmp44_ = _tmp43_->format;
		_tmp45_ = _tmp44_->BitsPerPixel;
		_tmp46_ = SDL_CreateRGBSurface ((guint32) (SDL_HWACCEL | SDL_HWSURFACE), (gint) _tmp42_, 20, (gint) _tmp45_, (guint32) 0, (guint32) 0, (guint32) 0, (guint32) 0);
		titlebar = _tmp46_;
		_tmp47_ = titlebar;
		_tmp48_ = self->background;
		_tmp49_ = stk_stk_color_to_uint32 (_tmp48_);
		SDL_FillRect (_tmp47_, NULL, _tmp49_);
		_tmp50_ = titlebar;
		_tmp51_ = self->opacity;
		SDL_SetAlpha (_tmp50_, (guint32) SDL_SRCALPHA, _tmp51_);
		_tmp52_ = self->opacity;
		self->border.unused = _tmp52_;
		_tmp54_ = stk_stk_font;
		if (_tmp54_ != NULL) {
			const gchar* _tmp55_;
			_tmp55_ = self->title;
			_tmp53_ = g_strcmp0 (_tmp55_, "") != 0;
		} else {
			_tmp53_ = FALSE;
		}
		_tmp56_ = _tmp53_;
		if (_tmp56_) {
			TTF_Font* _tmp57_;
			const gchar* _tmp58_;
			SDL_Color _tmp59_;
			SDL_Surface* _tmp60_ = NULL;
			SDL_Surface* title;
			SDL_Surface* _tmp61_;
			SDL_Surface* _tmp62_;
			SDL_Rect _tmp63_ = {0};
			_tmp57_ = stk_stk_font;
			_tmp58_ = self->title;
			_tmp59_ = self->border;
			_tmp60_ = TTF_RenderText_Blended (_tmp57_, _tmp58_, _tmp59_);
			title = _tmp60_;
			_tmp61_ = title;
			_tmp62_ = titlebar;
			_tmp63_.x = (gint16) 4;
			_tmp63_.y = (gint16) 1;
			SDL_UpperBlit (_tmp61_, NULL, _tmp62_, &_tmp63_);
			_SDL_FreeSurface0 (title);
		}
		_tmp64_ = ((StkWidget*) self)->rect;
		_tmp65_ = _tmp64_.x;
		_tmp66_ = ((StkWidget*) self)->rect;
		_tmp67_ = _tmp66_.y;
		_tmp68_ = ((StkWidget*) self)->rect;
		_tmp69_ = _tmp68_.w;
		_tmp70_.x = _tmp65_;
		_tmp70_.y = (gint16) (_tmp67_ - 20);
		_tmp70_.w = _tmp69_;
		_tmp70_.h = (guint16) 20;
		dst = _tmp70_;
		_tmp71_ = titlebar;
		_tmp72_ = screen;
		_tmp73_ = dst;
		SDL_UpperBlit (_tmp71_, NULL, _tmp72_, &_tmp73_);
		_tmp74_ = ((StkWidget*) self)->rect;
		_tmp75_ = _tmp74_.y;
		ypos = (gint16) (((gint16) _tmp75_) - 20);
		_SDL_FreeSurface0 (titlebar);
	} else {
		SDL_Rect _tmp76_;
		gint16 _tmp77_;
		_tmp76_ = ((StkWidget*) self)->rect;
		_tmp77_ = _tmp76_.y;
		ypos = _tmp77_;
	}
	_tmp78_ = screen;
	_tmp79_ = ((StkWidget*) self)->rect;
	_tmp80_ = _tmp79_.x;
	_tmp81_ = ypos;
	_tmp82_ = ((StkWidget*) self)->rect;
	_tmp83_ = _tmp82_.w;
	_tmp84_ = ((StkWidget*) self)->rect;
	_tmp85_ = _tmp84_.x;
	_tmp86_ = ((StkWidget*) self)->rect;
	_tmp87_ = _tmp86_.h;
	_tmp88_ = ((StkWidget*) self)->rect;
	_tmp89_ = _tmp88_.y;
	_tmp90_ = self->border;
	_tmp91_ = stk_stk_color_to_uint32 (_tmp90_);
	rectangleColor (_tmp78_, (gint16) _tmp80_, _tmp81_, (gint16) (_tmp83_ + _tmp85_), (gint16) (_tmp87_ + _tmp89_), _tmp91_);
	_tmp92_ = self->title;
	if (g_strcmp0 (_tmp92_, "") == 0) {
		gint16 _tmp93_;
		_tmp93_ = ((StkWidget*) self)->rect.y;
		((StkWidget*) self)->rect.y = (gint16) (_tmp93_ + 20);
	}
	result = FALSE;
	_SDL_FreeSurface0 (background);
	_SDL_FreeSurface0 (subsurface);
	return result;
}


void stk_window_set_size (StkWindow* self, gint width, gint height) {
	gint _tmp0_;
	gint _tmp1_;
	g_return_if_fail (self != NULL);
	_tmp0_ = width;
	((StkWidget*) self)->rect.w = (guint16) ((gint16) _tmp0_);
	_tmp1_ = height;
	((StkWidget*) self)->rect.h = (guint16) ((gint16) _tmp1_);
}


void stk_window_set_position (StkWindow* self, gint x, gint y) {
	gint _tmp0_;
	gint _tmp1_;
	g_return_if_fail (self != NULL);
	_tmp0_ = x;
	((StkWidget*) self)->rect.x = (gint16) _tmp0_;
	_tmp1_ = y;
	((StkWidget*) self)->rect.y = (gint16) (((gint16) _tmp1_) + 20);
}


static void stk_window_class_init (StkWindowClass * klass) {
	stk_window_parent_class = g_type_class_peek_parent (klass);
	G_OBJECT_CLASS (klass)->finalize = stk_window_finalize;
}


static void stk_window_instance_init (StkWindow * self) {
	self->opacity = (guchar) 255;
	self->bubble = FALSE;
}


static void stk_window_finalize (GObject* obj) {
	StkWindow * self;
	self = STK_WINDOW (obj);
	_g_free0 (self->title);
	G_OBJECT_CLASS (stk_window_parent_class)->finalize (obj);
}


GType stk_window_get_type (void) {
	static volatile gsize stk_window_type_id__volatile = 0;
	if (g_once_init_enter (&stk_window_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (StkWindowClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) stk_window_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (StkWindow), 0, (GInstanceInitFunc) stk_window_instance_init, NULL };
		GType stk_window_type_id;
		stk_window_type_id = g_type_register_static (STK_TYPE_CONTAINER, "StkWindow", &g_define_type_info, 0);
		g_once_init_leave (&stk_window_type_id__volatile, stk_window_type_id);
	}
	return stk_window_type_id__volatile;
}


