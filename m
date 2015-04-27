Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50910 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964964AbbD0U11 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Apr 2015 16:27:27 -0400
Message-ID: <553E9B9A.5090000@ti.com>
Date: Mon, 27 Apr 2015 16:27:06 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>, Mohit Kumar <mohit.kumar@st.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	KISHON VIJAY <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC] PCI: designware: missing *config* reg space
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

All,

I would like to take action to resolve the following print message 
thrown by PCI designware core driver when kernel boots up on Keystone.

[    0.415778] keystone-pcie 21801000.pcie: missing *config* reg space

As per DT documentation introduced by commit 
4dd964df36d0e548e1806ec2ec275b62d4dc46e8 "PCI: designware: Look for 
configuration space in 'reg', not 'ranges'

This is introduced to stop abusing the range property for defining 
resource for config space. However if the device binding doesn't have
reg-name = "config" defined, this throws out an unnecessary log message
at boot which seems to me not right. AFAIK, reg-names is not mandatory.
config space address in Keystone case is defined using index. So for
keystone this needs to be fixed.

I propose to add the following check in the designware code to address
this. Keystone uses an older version of the Designware IP and doesn't 
have the ATU support. So va_cfg0_base and va_cfg1_base are already set 
up in ks_dw_pcie_host_init() before calling dw_pcie_host_init() and 
points to the remote config space address (both same for keystone). I 
think for other DW drivers, these variables are NULL. So add a check and 
avoid this error message for Keystone. Any comments?


--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -348,7 +348,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
         struct platform_device *pdev = to_platform_device(pp->dev);
         struct of_pci_range range;
         struct of_pci_range_parser parser;
-       struct resource *cfg_res;
+       struct resource *cfg_res = NULL;
         u32 val, na, ns;
         const __be32 *addrp;
         int i, index, ret;
@@ -359,7 +359,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
         of_property_read_u32(np, "#address-cells", &na);
         ns = of_n_size_cells(np);

-       cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, 
"config");
+       if (!pp->va_cfg0_base && !pp->va_cfg0_base)
+               cfg_res = platform_get_resource_byname(pdev,
+                                                      IORESOURCE_MEM,
+                                                      "config");
+
         if (cfg_res) {
                 pp->cfg0_size = resource_size(cfg_res)/2;
                 pp->cfg1_size = resource_size(cfg_res)/2;
@@ -372,7 +376,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
                 pp->cfg0_mod_base = of_read_number(addrp, ns);
                 pp->cfg1_mod_base = pp->cfg0_mod_base + pp->cfg0_size;
         } else {
-               dev_err(pp->dev, "missing *config* reg space\n");
+               if (!pp->va_cfg0_base && !pp->va_cfg1_base)
+                       dev_err(pp->dev, "missing *config* reg space\n");
         }



-- 
Murali Karicheri
Linux Kernel, Texas Instruments
