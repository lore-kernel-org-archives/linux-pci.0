Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr50130.outbound.protection.outlook.com ([40.107.5.130]:35424
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031227AbeBNQIM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Feb 2018 11:08:12 -0500
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz
Cc: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Subject: [PATCH v2 1/2] lspci: Add printing info in JSON format
Date: Wed, 14 Feb 2018 19:07:40 +0300
Message-Id: <20180214160741.8958-2-viktor.prutyanov@virtuozzo.com>
In-Reply-To: <20180214160741.8958-1-viktor.prutyanov@virtuozzo.com>
References: <20180214160741.8958-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds saving objects and lists and printing them in JSON format

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
---
 common.c   |   2 +-
 ls-info.c  | 328 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lspci.h    |  54 ++++++++++
 pciutils.h |   2 +-
 4 files changed, 384 insertions(+), 2 deletions(-)
 create mode 100644 ls-info.c

diff --git a/common.c b/common.c
index 8ea52fa..9654feb 100644
--- a/common.c
+++ b/common.c
@@ -45,7 +45,7 @@ xrealloc(void *ptr, unsigned int howmuch)
 }
 
 char *
-xstrdup(char *str)
+xstrdup(const char *str)
 {
   int len = strlen(str) + 1;
   char *copy = xmalloc(len);
diff --git a/ls-info.c b/ls-info.c
new file mode 100644
index 0000000..e1430aa
--- /dev/null
+++ b/ls-info.c
@@ -0,0 +1,328 @@
+/*
+ *	The PCI Utilities -- Save PCI info
+ *
+ *	Copyright (c) 2017 Virtuozzo International GmbH
+ *
+ *	Can be freely distributed and used under the terms of the GNU GPL.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdarg.h>
+
+#include "lspci.h"
+
+struct info_list *
+info_list_create(enum info_val_type type)
+{
+  struct info_list *list = xmalloc(sizeof(struct info_list));
+
+  list->node = NULL;
+  list->type = type;
+
+  return list;
+}
+
+struct info_list *
+info_list_create_in_obj(struct info_obj *parent_obj, char *key, enum info_val_type type)
+{
+  struct info_list *list = info_list_create(type);
+
+  info_obj_add_list(parent_obj, key, list);
+
+  return list;
+}
+
+static void
+info_list_delete(struct info_list *list)
+{
+  struct info_list_node *node = list->node, *next;
+
+  while (node)
+    {
+      switch (list->type)
+	{
+	case INFO_VAL_STRING:
+	  free(node->val.str);
+	  break;
+	case INFO_VAL_LIST:
+	  info_list_delete(node->val.list);
+	  break;
+	case INFO_VAL_OBJECT:
+	  info_obj_delete(node->val.obj);
+	  break;
+	default:
+	  break;
+	}
+      next = node->next;
+      free(node);
+      node = next;
+    }
+  free(list);
+}
+
+struct info_obj *
+info_obj_create(void)
+{
+  struct info_obj *obj = xmalloc(sizeof(struct info_obj));
+
+  obj->pair = NULL;
+
+  return obj;
+}
+
+struct info_obj *
+info_obj_create_in_obj(struct info_obj *parent_obj, char *key)
+{
+  struct info_obj *obj = info_obj_create();
+
+  info_obj_add_obj(parent_obj, key, obj);
+
+  return obj;
+}
+
+static void
+info_pair_delete(struct info_pair *pair)
+{
+  switch (pair->type)
+  {
+  case INFO_VAL_STRING:
+    free(pair->val.str);
+    break;
+  case INFO_VAL_LIST:
+    info_list_delete(pair->val.list);
+    break;
+  case INFO_VAL_OBJECT:
+    info_obj_delete(pair->val.obj);
+    break;
+  default:
+    break;
+  }
+  free(pair->key);
+  free(pair);
+}
+
+void
+info_obj_delete(struct info_obj *obj)
+{
+  struct info_pair *pair = obj->pair, *next;
+
+  while (pair)
+    {
+      next = pair->next;
+      info_pair_delete(pair);
+      pair = next;
+    }
+  free(obj);
+}
+
+void
+info_obj_delete_pair(struct info_obj *obj, char *key)
+{
+  struct info_pair *pair = obj->pair, *next, *prev = NULL;
+
+  while (pair)
+    {
+      next = pair->next;
+      if (!strcmp(pair->key, key))
+	{
+	  info_pair_delete(pair);
+	  if (prev)
+	    prev->next = next;
+	  else
+	    obj->pair = next;
+	  break;
+	}
+      prev = pair;
+      pair = next;
+   }
+}
+
+static struct info_list_node *
+info_list_add_node(struct info_list *list)
+{
+  struct info_list_node *new_node = xmalloc(sizeof(struct info_list_node));
+
+  new_node->next = NULL;
+
+  if (list->node)
+    {
+      struct info_list_node *node;
+
+      for (node = list->node; node && node->next; node = node->next);
+      node->next = new_node;
+    }
+  else
+    list->node = new_node;
+
+  return new_node;
+}
+
+void
+info_list_add_str(struct info_list *list, const char *str)
+{
+  struct info_list_node *new_node = info_list_add_node(list);
+
+  new_node->val.str = xstrdup(str);
+}
+
+void
+info_list_add_obj(struct info_list *list, struct info_obj *obj)
+{
+  struct info_list_node *new_node = info_list_add_node(list);
+
+  new_node->val.obj = obj;
+}
+
+static struct info_pair *
+info_obj_add_pair(struct info_obj *obj, const char *key, enum info_val_type type)
+{
+  struct info_pair *new_pair = xmalloc(sizeof(struct info_pair));
+  new_pair->key = xstrdup(key);
+  new_pair->next = NULL;
+  new_pair->type = type;
+
+  if (obj->pair)
+    {
+      struct info_pair *pair;
+
+      for (pair = obj->pair; pair && pair->next; pair = pair->next);
+      pair->next = new_pair;
+    }
+  else
+    obj->pair = new_pair;
+
+  return new_pair;
+}
+
+void
+info_obj_add_flag(struct info_obj *obj, const char *key, char flag)
+{
+  struct info_pair *new_pair = info_obj_add_pair(obj, key, INFO_VAL_FLAG);
+
+  new_pair->val.flag = flag;
+}
+
+void
+info_obj_add_str(struct info_obj *obj, const char *key, const char *str)
+{
+  struct info_pair *new_pair = info_obj_add_pair(obj, key, INFO_VAL_STRING);
+
+  new_pair->val.str = xstrdup(str);
+}
+
+void
+info_obj_add_fmt_buf_str(struct info_obj *obj, const char *key, char *buf, size_t size, const char *fmt, ...)
+{
+  va_list ap;
+
+  va_start(ap, fmt);
+  vsnprintf(buf, size, fmt, ap);
+  va_end(ap);
+
+  info_obj_add_str(obj, key, buf);
+}
+
+void
+info_obj_add_fmt_str(struct info_obj *obj, const char *key, size_t size, const char *fmt, ...)
+{
+  va_list ap;
+  char *buf = xmalloc(size);
+
+  va_start(ap, fmt);
+  vsnprintf(buf, size, fmt, ap);
+  va_end(ap);
+
+  info_obj_add_str(obj, key, buf);
+  free(buf);
+}
+
+void
+info_obj_add_list(struct info_obj *obj, const char *key, struct info_list *list)
+{
+  struct info_pair *new_pair = info_obj_add_pair(obj, key, INFO_VAL_LIST);
+
+  new_pair->val.list = list;
+}
+
+void
+info_obj_add_obj(struct info_obj *obj, const char *key, struct info_obj *new_obj)
+{
+  struct info_pair *new_pair = info_obj_add_pair(obj, key, INFO_VAL_OBJECT);
+
+  new_pair->val.obj = new_obj;
+}
+
+static void
+info_pair_print_json(struct info_pair *pair);
+
+void
+info_obj_print_json(struct info_obj *obj)
+{
+  struct info_pair *pair;
+
+  printf("{");
+  for (pair = obj->pair; pair; pair = pair->next)
+    {
+      info_pair_print_json(pair);
+      if (pair->next)
+	printf(", ");
+    }
+  printf("}");
+}
+
+static void
+info_list_print_json(struct info_list *list)
+{
+  struct info_list_node *node;
+
+  printf("[");
+  for (node = list->node; node; node = node->next)
+    {
+      switch (list->type)
+	{
+	case INFO_VAL_STRING:
+	  printf("\"%s\"", node->val.str);
+	  break;
+	case INFO_VAL_LIST:
+	  info_list_print_json(node->val.list);
+	  break;
+	case INFO_VAL_OBJECT:
+	  info_obj_print_json(node->val.obj);
+	  break;
+	case INFO_VAL_FLAG:
+	  printf("%s", node->val.flag ? "true" : "false");
+	  break;
+	default:
+	  break;
+	}
+      if (node->next)
+	printf(", ");
+    }
+  printf("]");
+}
+
+static void
+info_pair_print_json(struct info_pair *pair)
+{
+  printf("\"%s\": ", pair->key);
+  switch (pair->type)
+    {
+    case INFO_VAL_STRING:
+      printf("\"%s\"", pair->val.str);
+      break;
+    case INFO_VAL_LIST:
+      info_list_print_json(pair->val.list);
+      break;
+    case INFO_VAL_OBJECT:
+      info_obj_print_json(pair->val.obj);
+      break;
+    case INFO_VAL_FLAG:
+      printf("%s", (pair->val.flag == '+') ? "true" :
+		   ((pair->val.flag == '-') ? "false" : "null"));
+      break;
+    default:
+      break;
+    }
+}
diff --git a/lspci.h b/lspci.h
index bcd007e..ba5a56b 100644
--- a/lspci.h
+++ b/lspci.h
@@ -74,6 +74,60 @@ void show_ext_caps(struct device *d, int type);
 
 void show_vendor_caps(struct device *d, int where, int cap);
 
+/* ls-info.c */
+
+enum info_val_type {
+    INFO_VAL_STRING,
+    INFO_VAL_OBJECT,
+    INFO_VAL_LIST,
+    INFO_VAL_FLAG
+};
+
+struct info_obj {
+  struct info_pair *pair;
+};
+
+union info_val {
+  char *str;
+  struct info_obj *obj;
+  struct info_list *list;
+  char flag;
+};
+
+struct info_pair {
+  char *key;
+  enum info_val_type type;
+  union info_val val;
+  struct info_pair *next;
+};
+
+struct info_list {
+  enum info_val_type type;
+  struct info_list_node *node;
+};
+
+struct info_list_node {
+  union info_val val;
+  struct info_list_node *next;
+};
+
+struct info_obj *info_obj_create(void);
+struct info_obj *info_obj_create_in_obj(struct info_obj *parent_obj, char *key);
+void info_obj_add_str(struct info_obj *obj, const char *key, const char *str);
+void info_obj_add_list(struct info_obj *obj, const char *key, struct info_list *list);
+void info_obj_add_obj(struct info_obj *obj, const char *key, struct info_obj *new_obj);
+void info_obj_add_flag(struct info_obj *obj, const char *key, char flag);
+void info_obj_add_fmt_str(struct info_obj *obj, const char *key, size_t size, const char *fmt, ...);
+void info_obj_add_fmt_buf_str(struct info_obj *obj, const char *key, char *buf, size_t size, const char *fmt, ...);
+void info_obj_print_json(struct info_obj *obj);
+void info_obj_delete_pair(struct info_obj *obj, char *key);
+void info_obj_delete(struct info_obj *obj);
+
+struct info_list *info_list_create(enum info_val_type type);
+struct info_list *info_list_create_in_obj(struct info_obj *parent_obj, char *key, enum info_val_type type);
+void info_list_add_str(struct info_list *list, const char *str);
+void info_list_add_obj(struct info_list *list, struct info_obj *obj);
+
 /* ls-kernel.c */
 
 void show_kernel_machine(struct device *d UNUSED);
diff --git a/pciutils.h b/pciutils.h
index e433e6b..53a868b 100644
--- a/pciutils.h
+++ b/pciutils.h
@@ -22,7 +22,7 @@ extern const char program_name[];
 void die(char *msg, ...) NONRET PCI_PRINTF(1,2);
 void *xmalloc(unsigned int howmuch);
 void *xrealloc(void *ptr, unsigned int howmuch);
-char *xstrdup(char *str);
+char *xstrdup(const char *str);
 int parse_generic_option(int i, struct pci_access *pacc, char *optarg);
 
 #ifdef PCI_HAVE_PM_INTEL_CONF
-- 
2.14.1
