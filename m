Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 9/9] PCI: only enable pci realloc when SRIOV bar is not assigned
Date: Sat,  4 Feb 2012 22:55:08 -0800
Message-Id: <1328424908-6385-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1328424908-6385-1-git-send-email-yinghai@kernel.org>
References: <1328424908-6385-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If bios does not assign those BAR or wrong address, then kernel will
try to do pci realloc.

in that case, user still can use pci=realloc=off to override it.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9526038..520f256 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1293,6 +1293,31 @@ static bool __init pci_realloc_enabled(void)
 	return pci_realloc_enable >= enable_yes_user;
 }
 
+static void __init pci_realloc_detect(void)
+{
+	struct pci_dev *dev = NULL;
+
+	if (pci_realloc_enable != enable_not_set)
+		return;
+
+#ifdef CONFIG_PCI_IOV
+	for_each_pci_dev(dev) {
+		int i;
+
+		for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
+			struct resource *r = &dev->resource[i];
+
+			/* Not assigned, or rejected by kernel */
+			if (r->flags && !r->start) {
+				pci_realloc_enable = enable_yes_detected;
+
+				return;
+			}
+		}
+	}
+#endif
+}
+
 /*
  * first try will not touch pci bridge res
  * second  and later try will clear small leaf bridge res
@@ -1314,6 +1339,7 @@ pci_assign_unassigned_resources(void)
 	int pci_try_num = 1;
 
 	/* don't realloc if asked to do so */
+	pci_realloc_detect();
 	if (pci_realloc_enabled()) {
 		int max_depth = pci_get_max_depth();
 
@@ -1348,6 +1374,8 @@ again:
 	if (tried_times >= pci_try_num) {
 		if (pci_realloc_enable == enable_not_set)
 			printk(KERN_INFO "Some pci devices resources are not assigned, please try to boot with pci=realloc\n");
+		else if (pci_realloc_enable == enable_yes_detected)
+			printk(KERN_INFO "Automatically enabled pci realloc, if you have problem, please try to boot with pci=realloc=off\n");
 
 		free_list(&fail_head);
 		goto enable_and_dump;
-- 
1.7.7

