Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rajat Jain <rajatja@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, rajatxjain@gmail.com,
	Rajat Jain <rajatja@google.com>
Subject: [PATCH] kobject: Ensure child's resources get released before parent's resources
Date: Mon, 14 Dec 2015 11:04:11 -0800
Message-Id: <1450119851-28190-1-git-send-email-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the only remaining reference to a parent, is the one taken by
the child (in kobject_add_internal()), then when the last
reference to the child goes away, both child and its parents
shall be released. However, currently the resources of parent
get released first, followed by the child's resources:

kobject_cleanup(child)
    ....
    kobject_del(child)
        ....
        kobject_put(child->parent) -> results in parent's release()
        ...
    child->kobj_type->release() -> Child's release()

This is a problem because the child's release() method may still
need to use parent resources or memory for its own cleanup. E.g.
child may need parent pointer for dma_free_coherent() etc.

Signed-off-by: Rajat Jain <rajatja@google.com>
Signed-off-by: Rajat Jain <rajatxjain@gmail.com>
---
resending after an email address that bounced.

 lib/kobject.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index 7cbccd2..8f325ac 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -616,6 +616,7 @@ static void kobject_cleanup(struct kobject *kobj)
 {
 	struct kobj_type *t = get_ktype(kobj);
 	const char *name = kobj->name;
+	struct kobject *parent = kobj->parent;
 
 	pr_debug("kobject: '%s' (%p): %s, parent %p\n",
 		 kobject_name(kobj), kobj, __func__, kobj->parent);
@@ -632,6 +633,8 @@ static void kobject_cleanup(struct kobject *kobj)
 		kobject_uevent(kobj, KOBJ_REMOVE);
 	}
 
+	kobject_get(parent);
+
 	/* remove from sysfs if the caller did not do it */
 	if (kobj->state_in_sysfs) {
 		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
@@ -645,6 +648,8 @@ static void kobject_cleanup(struct kobject *kobj)
 		t->release(kobj);
 	}
 
+	kobject_put(parent);
+
 	/* free name if we allocated it */
 	if (name) {
 		pr_debug("kobject: '%s': free name\n", name);
-- 
2.6.0.rc2.230.g3dd15c0

