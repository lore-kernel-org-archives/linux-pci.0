Return-Path: <linux-kernel-owner@vger.kernel.org>
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] Fix NULL ptr dereference in pci_bus_assign_domain_nr() on ARM
Date: Tue, 01 Mar 2016 07:07:18 +0100
Message-ID: <m337sapw89.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Many ARM platforms use a wrapper:
/*
 * Compatibility wrapper for older platforms that do not care about
 * passing the parent device.
 */
static inline void pci_common_init(struct hw_pci *hw)
{
        pci_common_init_dev(NULL, hw);
}

which means that pci_bus_assign_domain_nr() can be called without
a parent. This patch fixes the NULL pointer dereference.

Signed-off-by: Krzysztof Hałasa <khalasa@piap.pl>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 602eb42..f89db3a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4772,8 +4772,10 @@ int pci_get_new_domain_nr(void)
 void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
 {
 	static int use_dt_domains = -1;
-	int domain = of_get_pci_domain_nr(parent->of_node);
+	int domain = -1;
 
+	if (parent)
+		domain = of_get_pci_domain_nr(parent->of_node);
 	/*
 	 * Check DT domain and use_dt_domains values.
 	 *

-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
