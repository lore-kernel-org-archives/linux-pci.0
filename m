Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33973 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751259AbdFKEMg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Jun 2017 00:12:36 -0400
Received: by mail-pg0-f42.google.com with SMTP id v18so36303019pgb.1
        for <linux-pci@vger.kernel.org>; Sat, 10 Jun 2017 21:12:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170608163614.GB2216@red-moon>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <20170608141342.2018-3-lorenzo.pieralisi@arm.com> <0eb77019-9945-592c-375d-e2de742b3237@broadcom.com>
 <20170608163614.GB2216@red-moon>
From: Oza Oza <oza.oza@broadcom.com>
Date: Sun, 11 Jun 2017 09:42:34 +0530
Message-ID: <CAMSpPPe6bXfu=ntMedrt0w4UfqJLy1a9ZBu_kXy1j4B63x1Nww@mail.gmail.com>
Subject: Re: [RFT PATCH v2 02/42] drivers: pci: host: iproc: Convert link
 check to raw PCI config accessors
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Ray Jui <ray.jui@broadcom.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Matthew Minter <matt@masarand.com>,
        Rob Herring <robh@kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 8, 2017 at 10:06 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> [dropped rock-chips maintainers, email bounces]
>
> On Thu, Jun 08, 2017 at 08:56:05AM -0700, Ray Jui wrote:
>> Hi Lorenzo,
>>
>> Thanks, I'll try my best to find time to test this along 15/42 and
>> 33/42 patches. Hopefully I can get to that some time next week.
>>
>> I have not yet reviewed these patches in details. Do they have
>> dependency on other patches to the generic framework code you
>> changed?
>>
>> If so, is there a repo I can pull them?
>
> I added it in the cover letter but anyway here it is:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git pci/pci-fixup-irqs-removal-v2

Hi Lorenzo,

I picked up your changes, and tested on iproc based SOC,
and ran basic fio data transfer.. and it looks okay.


Hi Bjorn,

please help to review following changes, to avoid merge conflicts
since Lorenzo's changes in iproc driver is touching basic config APIs.

[PATCH v3 1/2] PCI: iproc: Retry request when CRS returned from EP
[PATCH v3 2/2] PCI: iproc: add device shutdown for PCI RC

Regards,
Oza.



>
> Thanks for testing it, please let me know.
>
> Thank you !
> Lorenzo
>
>>
>> Thanks,
>>
>> Ray
>>
>>
>> On 6/8/2017 7:13 AM, Lorenzo Pieralisi wrote:
>> >Current iproc driver host bridge controller driver requires struct
>> >pci_bus to be created in order to carry out PCI link checks with standard
>> >PCI config space accessors.
>> >
>> >This struct pci_bus dependency is fictitious and burdens the driver
>> >with unneeded constraints (eg to use separate APIs to create and scan
>> >the root bus).
>> >
>> >Add PCI raw config space accessors to PCIe iproc driver and remove the
>> >fictitious struct pci_bus dependency.
>> >
>> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> >Cc: Scott Branden <sbranden@broadcom.com>
>> >Cc: Ray Jui <rjui@broadcom.com>
>> >Cc: Jon Mason <jonmason@broadcom.com>
>> >---
>> >  drivers/pci/host/pcie-iproc.c | 94 ++++++++++++++++++++++++++++++++++---------
>> >  1 file changed, 74 insertions(+), 20 deletions(-)
>> >
>> >diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
>> >index 0f39bd2..e48b8e2 100644
>> >--- a/drivers/pci/host/pcie-iproc.c
>> >+++ b/drivers/pci/host/pcie-iproc.c
>> >@@ -452,14 +452,13 @@ static inline void iproc_pcie_apb_err_disable(struct pci_bus *bus,
>> >   * Note access to the configuration registers are protected at the higher layer
>> >   * by 'pci_lock' in drivers/pci/access.c
>> >   */
>> >-static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>> >+static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
>> >+                                        int busno,
>> >                                         unsigned int devfn,
>> >                                         int where)
>> >  {
>> >-    struct iproc_pcie *pcie = iproc_data(bus);
>> >     unsigned slot = PCI_SLOT(devfn);
>> >     unsigned fn = PCI_FUNC(devfn);
>> >-    unsigned busno = bus->number;
>> >     u32 val;
>> >     u16 offset;
>> >@@ -499,6 +498,58 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
>> >             return (pcie->base + offset);
>> >  }
>> >+static void __iomem *iproc_pcie_bus_map_cfg_bus(struct pci_bus *bus,
>> >+                                            unsigned int devfn,
>> >+                                            int where)
>> >+{
>> >+    return iproc_pcie_map_cfg_bus(iproc_data(bus), bus->number, devfn,
>> >+                                  where);
>> >+}
>> >+
>> >+static int iproc_pci_raw_config_read32(struct iproc_pcie *pcie,
>> >+                                   unsigned int devfn, int where,
>> >+                                   int size, u32 *val)
>> >+{
>> >+    void __iomem *addr;
>> >+
>> >+    addr = iproc_pcie_map_cfg_bus(pcie, 0, devfn, where & ~0x3);
>> >+    if (!addr) {
>> >+            *val = ~0;
>> >+            return PCIBIOS_DEVICE_NOT_FOUND;
>> >+    }
>> >+
>> >+    *val = readl(addr);
>> >+
>> >+    if (size <= 2)
>> >+            *val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
>> >+
>> >+    return PCIBIOS_SUCCESSFUL;
>> >+}
>> >+
>> >+static int iproc_pci_raw_config_write32(struct iproc_pcie *pcie,
>> >+                                    unsigned int devfn, int where,
>> >+                                    int size, u32 val)
>> >+{
>> >+    void __iomem *addr;
>> >+    u32 mask, tmp;
>> >+
>> >+    addr = iproc_pcie_map_cfg_bus(pcie, 0, devfn, where & ~0x3);
>> >+    if (!addr)
>> >+            return PCIBIOS_DEVICE_NOT_FOUND;
>> >+
>> >+    if (size == 4) {
>> >+            writel(val, addr);
>> >+            return PCIBIOS_SUCCESSFUL;
>> >+    }
>> >+
>> >+    mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
>> >+    tmp = readl(addr) & mask;
>> >+    tmp |= val << ((where & 0x3) * 8);
>> >+    writel(tmp, addr);
>> >+
>> >+    return PCIBIOS_SUCCESSFUL;
>> >+}
>> >+
>> >  static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
>> >                                 int where, int size, u32 *val)
>> >  {
>> >@@ -524,7 +575,7 @@ static int iproc_pcie_config_write32(struct pci_bus *bus, unsigned int devfn,
>> >  }
>> >  static struct pci_ops iproc_pcie_ops = {
>> >-    .map_bus = iproc_pcie_map_cfg_bus,
>> >+    .map_bus = iproc_pcie_bus_map_cfg_bus,
>> >     .read = iproc_pcie_config_read32,
>> >     .write = iproc_pcie_config_write32,
>> >  };
>> >@@ -556,12 +607,11 @@ static void iproc_pcie_reset(struct iproc_pcie *pcie)
>> >     msleep(100);
>> >  }
>> >-static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
>> >+static int iproc_pcie_check_link(struct iproc_pcie *pcie)
>> >  {
>> >     struct device *dev = pcie->dev;
>> >-    u8 hdr_type;
>> >-    u32 link_ctrl, class, val;
>> >-    u16 pos = PCI_EXP_CAP, link_status;
>> >+    u32 hdr_type, link_ctrl, link_status, class, val;
>> >+    u16 pos = PCI_EXP_CAP;
>> >     bool link_is_active = false;
>> >     /*
>> >@@ -578,7 +628,7 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
>> >     }
>> >     /* make sure we are not in EP mode */
>> >-    pci_bus_read_config_byte(bus, 0, PCI_HEADER_TYPE, &hdr_type);
>> >+    iproc_pci_raw_config_read32(pcie,  0, PCI_HEADER_TYPE, 1, &hdr_type);
>> >     if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE) {
>> >             dev_err(dev, "in EP mode, hdr=%#02x\n", hdr_type);
>> >             return -EFAULT;
>> >@@ -588,13 +638,16 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
>> >  #define PCI_BRIDGE_CTRL_REG_OFFSET 0x43c
>> >  #define PCI_CLASS_BRIDGE_MASK      0xffff00
>> >  #define PCI_CLASS_BRIDGE_SHIFT     8
>> >-    pci_bus_read_config_dword(bus, 0, PCI_BRIDGE_CTRL_REG_OFFSET, &class);
>> >+    iproc_pci_raw_config_read32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
>> >+                                4, &class);
>> >     class &= ~PCI_CLASS_BRIDGE_MASK;
>> >     class |= (PCI_CLASS_BRIDGE_PCI << PCI_CLASS_BRIDGE_SHIFT);
>> >-    pci_bus_write_config_dword(bus, 0, PCI_BRIDGE_CTRL_REG_OFFSET, class);
>> >+    iproc_pci_raw_config_write32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
>> >+                                 4, class);
>> >     /* check link status to see if link is active */
>> >-    pci_bus_read_config_word(bus, 0, pos + PCI_EXP_LNKSTA, &link_status);
>> >+    iproc_pci_raw_config_read32(pcie, 0, pos + PCI_EXP_LNKSTA,
>> >+                                2, &link_status);
>> >     if (link_status & PCI_EXP_LNKSTA_NLW)
>> >             link_is_active = true;
>> >@@ -603,20 +656,21 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
>> >  #define PCI_TARGET_LINK_SPEED_MASK    0xf
>> >  #define PCI_TARGET_LINK_SPEED_GEN2    0x2
>> >  #define PCI_TARGET_LINK_SPEED_GEN1    0x1
>> >-            pci_bus_read_config_dword(bus, 0,
>> >-                                      pos + PCI_EXP_LNKCTL2,
>> >+            iproc_pci_raw_config_read32(pcie, 0,
>> >+                                      pos + PCI_EXP_LNKCTL2, 4,
>> >                                       &link_ctrl);
>> >             if ((link_ctrl & PCI_TARGET_LINK_SPEED_MASK) ==
>> >                 PCI_TARGET_LINK_SPEED_GEN2) {
>> >                     link_ctrl &= ~PCI_TARGET_LINK_SPEED_MASK;
>> >                     link_ctrl |= PCI_TARGET_LINK_SPEED_GEN1;
>> >-                    pci_bus_write_config_dword(bus, 0,
>> >-                                       pos + PCI_EXP_LNKCTL2,
>> >-                                       link_ctrl);
>> >+                    iproc_pci_raw_config_write32(pcie, 0,
>> >+                                            pos + PCI_EXP_LNKCTL2,
>> >+                                            4, link_ctrl);
>> >                     msleep(100);
>> >-                    pci_bus_read_config_word(bus, 0, pos + PCI_EXP_LNKSTA,
>> >-                                             &link_status);
>> >+                    iproc_pci_raw_config_read32(pcie, 0,
>> >+                                            pos + PCI_EXP_LNKSTA,
>> >+                                            2, &link_status);
>> >                     if (link_status & PCI_EXP_LNKSTA_NLW)
>> >                             link_is_active = true;
>> >             }
>> >@@ -1260,7 +1314,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>> >     }
>> >     pcie->root_bus = bus;
>> >-    ret = iproc_pcie_check_link(pcie, bus);
>> >+    ret = iproc_pcie_check_link(pcie);
>> >     if (ret) {
>> >             dev_err(dev, "no PCIe EP device detected\n");
>> >             goto err_rm_root_bus;
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
