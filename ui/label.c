/* label.c generated by valac 0.16.0, the Vala compiler
 * generated from label.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <SDL.h>
#include <stdlib.h>
#include <string.h>
#include <SDL_ttf.h>


#define STK_TYPE_WIDGET (stk_widget_get_type ())
#define STK_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STK_TYPE_WIDGET, StkWidget))
#define STK_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), STK_TYPE_WIDGET, StkWidgetClass))
#define STK_IS_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STK_TYPE_WIDGET))
#define STK_IS_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), STK_TYPE_WIDGET))
#define STK_WIDGET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), STK_TYPE_WIDGET, StkWidgetClass))

typedef struct _StkWidget StkWidget;
typedef struct _StkWidgetClass StkWidgetClass;
typedef struct _StkWidgetPrivate StkWidgetPrivate;

#define STK_TYPE_LABEL (stk_label_get_type ())
#define STK_LABEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), STK_TYPE_LABEL, StkLabel))
#define STK_LABEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), STK_TYPE_LABEL, StkLabelClass))
#define STK_IS_LABEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), STK_TYPE_LABEL))
#define STK_IS_LABEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), STK_TYPE_LABEL))
#define STK_LABEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), STK_TYPE_LABEL, StkLabelClass))

typedef struct _StkLabel StkLabel;
typedef struct _StkLabelClass StkLabelClass;
typedef struct _StkLabelPrivate StkLabelPrivate;

#define STK_TYPE_ALIGNMENT (stk_alignment_get_type ())
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

typedef enum  {
	STK_ALIGNMENT_LEFT,
	STK_ALIGNMENT_RIGHT,
	STK_ALIGNMENT_CENTER,
	STK_ALIGNMENT_TOP,
	STK_ALIGNMENT_MIDDLE,
	STK_ALIGNMENT_BOTTOM
} StkAlignment;

struct _StkLabel {
	StkWidget parent_instance;
	StkLabelPrivate * priv;
	gchar* text;
	gboolean translucent;
	SDL_Color color;
	StkAlignment halign;
	StkAlignment valign;
};

struct _StkLabelClass {
	StkWidgetClass parent_class;
};


static gpointer stk_label_parent_class = NULL;
extern TTF_Font* stk_stk_font;

GType stk_widget_get_type (void) G_GNUC_CONST;
GType stk_label_get_type (void) G_GNUC_CONST;
GType stk_alignment_get_type (void) G_GNUC_CONST;
enum  {
	STK_LABEL_DUMMY_PROPERTY
};
StkLabel* stk_label_new (void);
StkLabel* stk_label_construct (GType object_type);
StkWidget* stk_widget_new (void);
StkWidget* stk_widget_construct (GType object_type);
StkLabel* stk_label_new_with_text (const gchar* text);
StkLabel* stk_label_construct_with_text (GType object_type, const gchar* text);
StkLabel* stk_label_new_colored_text (const gchar* text, SDL_Color color);
StkLabel* stk_label_construct_colored_text (GType object_type, const gchar* text, SDL_Color color);
static gboolean stk_label_real_draw (StkWidget* base, SDL_Surface* screen);
gboolean stk_widget_draw (StkWidget* self, SDL_Surface* screen);
static void stk_label_finalize (GObject* obj);


StkLabel* stk_label_construct (GType object_type) {
	StkLabel * self = NULL;
	SDL_Color _tmp0_ = {0};
	self = (StkLabel*) stk_widget_construct (object_type);
	_tmp0_.r = (guchar) 0;
	_tmp0_.g = (guchar) 0;
	_tmp0_.b = (guchar) 0;
	_tmp0_.unused = (guchar) 255;
	self->color = _tmp0_;
	return self;
}


StkLabel* stk_label_new (void) {
	return stk_label_construct (STK_TYPE_LABEL);
}


StkLabel* stk_label_construct_with_text (GType object_type, const gchar* text) {
	StkLabel * self = NULL;
	const gchar* _tmp0_;
	gchar* _tmp1_;
	g_return_val_if_fail (text != NULL, NULL);
	self = (StkLabel*) stk_label_construct (object_type);
	_tmp0_ = text;
	_tmp1_ = g_strdup (_tmp0_);
	_g_free0 (self->text);
	self->text = _tmp1_;
	return self;
}


StkLabel* stk_label_new_with_text (const gchar* text) {
	return stk_label_construct_with_text (STK_TYPE_LABEL, text);
}


StkLabel* stk_label_construct_colored_text (GType object_type, const gchar* text, SDL_Color color) {
	StkLabel * self = NULL;
	const gchar* _tmp0_;
	SDL_Color _tmp1_;
	g_return_val_if_fail (text != NULL, NULL);
	_tmp0_ = text;
	self = (StkLabel*) stk_label_construct_with_text (object_type, _tmp0_);
	_tmp1_ = color;
	self->color = _tmp1_;
	return self;
}


StkLabel* stk_label_new_colored_text (const gchar* text, SDL_Color color) {
	return stk_label_construct_colored_text (STK_TYPE_LABEL, text, color);
}


static gboolean stk_label_real_draw (StkWidget* base, SDL_Surface* screen) {
	StkLabel * self;
	gboolean result = FALSE;
	SDL_Surface* _tmp0_;
	const gchar* _tmp1_;
	TTF_Font* _tmp2_;
	const gchar* _tmp3_;
	SDL_Color _tmp4_;
	SDL_Surface* _tmp5_ = NULL;
	SDL_Surface* text;
	SDL_Rect dst = {0};
	StkAlignment _tmp6_;
	StkAlignment _tmp15_;
	gboolean _tmp24_;
	SDL_Surface* _tmp26_;
	SDL_Surface* _tmp27_;
	SDL_Rect _tmp28_;
	SDL_Rect _tmp29_;
	gint16 _tmp30_;
	SDL_Rect _tmp31_;
	gint16 _tmp32_;
	SDL_Surface* _tmp33_;
	gint _tmp34_;
	SDL_Surface* _tmp35_;
	gint _tmp36_;
	self = (StkLabel*) base;
	g_return_val_if_fail (screen != NULL, FALSE);
	_tmp0_ = screen;
	STK_WIDGET_CLASS (stk_label_parent_class)->draw (STK_WIDGET (self), _tmp0_);
	_tmp1_ = self->text;
	if (g_strcmp0 (_tmp1_, " ") == 0) {
		result = FALSE;
		return result;
	}
	_tmp2_ = stk_stk_font;
	_tmp3_ = self->text;
	_tmp4_ = self->color;
	_tmp5_ = TTF_RenderText_Blended (_tmp2_, _tmp3_, _tmp4_);
	text = _tmp5_;
	memset (&dst, 0, sizeof (SDL_Rect));
	_tmp6_ = self->halign;
	switch (_tmp6_) {
		case STK_ALIGNMENT_LEFT:
		{
			dst.x = (gint16) 1;
			break;
		}
		case STK_ALIGNMENT_RIGHT:
		{
			SDL_Surface* _tmp7_;
			gint _tmp8_;
			SDL_Surface* _tmp9_;
			gint _tmp10_;
			_tmp7_ = screen;
			_tmp8_ = _tmp7_->w;
			_tmp9_ = text;
			_tmp10_ = _tmp9_->w;
			dst.x = (gint16) ((_tmp8_ - _tmp10_) - 1);
			break;
		}
		default:
		case STK_ALIGNMENT_CENTER:
		{
			SDL_Surface* _tmp11_;
			gint _tmp12_;
			SDL_Surface* _tmp13_;
			gint _tmp14_;
			_tmp11_ = screen;
			_tmp12_ = _tmp11_->w;
			_tmp13_ = text;
			_tmp14_ = _tmp13_->w;
			dst.x = (gint16) ((_tmp12_ / 2) - (_tmp14_ / 2));
			break;
		}
	}
	_tmp15_ = self->valign;
	switch (_tmp15_) {
		case STK_ALIGNMENT_TOP:
		{
			dst.y = (gint16) 1;
			break;
		}
		case STK_ALIGNMENT_BOTTOM:
		{
			SDL_Surface* _tmp16_;
			gint _tmp17_;
			SDL_Surface* _tmp18_;
			gint _tmp19_;
			_tmp16_ = screen;
			_tmp17_ = _tmp16_->h;
			_tmp18_ = text;
			_tmp19_ = _tmp18_->h;
			dst.y = (gint16) ((_tmp17_ - _tmp19_) - 1);
			break;
		}
		default:
		case STK_ALIGNMENT_MIDDLE:
		{
			SDL_Surface* _tmp20_;
			gint _tmp21_;
			SDL_Surface* _tmp22_;
			gint _tmp23_;
			_tmp20_ = screen;
			_tmp21_ = _tmp20_->h;
			_tmp22_ = text;
			_tmp23_ = _tmp22_->h;
			dst.y = (gint16) ((_tmp21_ / 2) - (_tmp23_ / 2));
			break;
		}
	}
	_tmp24_ = self->translucent;
	if (!_tmp24_) {
		SDL_Surface* _tmp25_;
		_tmp25_ = text;
		SDL_SetAlpha (_tmp25_, (guint32) 0, (guchar) 0);
	}
	_tmp26_ = text;
	_tmp27_ = screen;
	_tmp28_ = dst;
	SDL_UpperBlit (_tmp26_, NULL, _tmp27_, &_tmp28_);
	_tmp29_ = dst;
	_tmp30_ = _tmp29_.x;
	((StkWidget*) self)->rect.x = _tmp30_;
	_tmp31_ = dst;
	_tmp32_ = _tmp31_.y;
	((StkWidget*) self)->rect.y = _tmp32_;
	_tmp33_ = text;
	_tmp34_ = _tmp33_->w;
	((StkWidget*) self)->rect.w = (guint16) ((gint16) _tmp34_);
	_tmp35_ = text;
	_tmp36_ = _tmp35_->h;
	((StkWidget*) self)->rect.h = (guint16) ((gint16) _tmp36_);
	result = FALSE;
	_SDL_FreeSurface0 (text);
	return result;
}


static void stk_label_class_init (StkLabelClass * klass) {
	stk_label_parent_class = g_type_class_peek_parent (klass);
	STK_WIDGET_CLASS (klass)->draw = stk_label_real_draw;
	G_OBJECT_CLASS (klass)->finalize = stk_label_finalize;
}


static void stk_label_instance_init (StkLabel * self) {
	gchar* _tmp0_;
	_tmp0_ = g_strdup (" ");
	self->text = _tmp0_;
	self->translucent = FALSE;
	self->halign = STK_ALIGNMENT_CENTER;
	self->valign = STK_ALIGNMENT_MIDDLE;
}


static void stk_label_finalize (GObject* obj) {
	StkLabel * self;
	self = STK_LABEL (obj);
	_g_free0 (self->text);
	G_OBJECT_CLASS (stk_label_parent_class)->finalize (obj);
}


GType stk_label_get_type (void) {
	static volatile gsize stk_label_type_id__volatile = 0;
	if (g_once_init_enter (&stk_label_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (StkLabelClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) stk_label_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (StkLabel), 0, (GInstanceInitFunc) stk_label_instance_init, NULL };
		GType stk_label_type_id;
		stk_label_type_id = g_type_register_static (STK_TYPE_WIDGET, "StkLabel", &g_define_type_info, 0);
		g_once_init_leave (&stk_label_type_id__volatile, stk_label_type_id);
	}
	return stk_label_type_id__volatile;
}



