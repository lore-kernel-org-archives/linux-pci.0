Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gg0-f177.google.com ([209.85.161.177]:52377 "EHLO
	mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab3JHAEj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2013 20:04:39 -0400
Received: by mail-gg0-f177.google.com with SMTP id t2so1280228ggn.36
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2013 17:04:38 -0700 (PDT)
Subject: [PATCH] PCI: designware: Make dw_pcie_rd_own_conf(), etc., static
To: Jingoo Han <jg1.han@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Mon, 07 Oct 2013 18:04:35 -0600
Message-ID: <20131008000435.12954.92136.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The following variables and functions are used only in pcie-designware.c,
so make them static:

  global_io_offset
  dw_pcie_rd_own_conf()
  dw_pcie_wr_own_conf()
  dw_pcie_setup()
  dw_pcie_scan_bus()
  dw_pcie_map_irq()

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |   16 ++++++++--------
 drivers/pci/host/pcie-designware.h |    7 -------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index c10e9ac..900e875 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -64,7 +64,7 @@
 
 static struct hw_pci dw_pci;
 
-unsigned long global_io_offset;
+static unsigned long global_io_offset;
 
 static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
 {
@@ -115,8 +115,8 @@ static inline void dw_pcie_writel_rc(struct pcie_port *pp, u32 val, u32 reg)
 		writel(val, pp->dbi_base + reg);
 }
 
-int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
-				u32 *val)
+static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
+			       u32 *val)
 {
 	int ret;
 
@@ -128,8 +128,8 @@ int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
 	return ret;
 }
 
-int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
-				u32 val)
+static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
+			       u32 val)
 {
 	int ret;
 
@@ -438,7 +438,7 @@ static struct pci_ops dw_pcie_ops = {
 	.write = dw_pcie_wr_conf,
 };
 
-int dw_pcie_setup(int nr, struct pci_sys_data *sys)
+static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 {
 	struct pcie_port *pp;
 
@@ -461,7 +461,7 @@ int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
+static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 {
 	struct pci_bus *bus;
 	struct pcie_port *pp = sys_to_pcie(sys);
@@ -478,7 +478,7 @@ struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	return bus;
 }
 
-int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	struct pcie_port *pp = sys_to_pcie(dev->bus->sysdata);
 
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index 133820f..401b154 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -51,15 +51,8 @@ struct pcie_host_ops {
 	void (*host_init)(struct pcie_port *pp);
 };
 
-extern unsigned long global_io_offset;
-
 int cfg_read(void __iomem *addr, int where, int size, u32 *val);
 int cfg_write(void __iomem *addr, int where, int size, u32 val);
-int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size, u32 val);
-int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size, u32 *val);
 int dw_pcie_link_up(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
-int dw_pcie_setup(int nr, struct pci_sys_data *sys);
-struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys);
-int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin);

