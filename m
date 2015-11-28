Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:54248
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751230AbbK1J70 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Nov 2015 04:59:26 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Arnd Bergmann <arnd@arndb.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"tinamdar@apm.com" <tinamdar@apm.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"rjui@broadcom.com" <rjui@broadcom.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"dhdang@apm.com" <dhdang@apm.com>,
	"sbranden@broadcom.com" <sbranden@broadcom.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v10] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Date: Sat, 28 Nov 2015 09:59:19 +0000
Message-ID: <8520D5D51A55D047800579B09414719825866D71@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1448636523-20503-1-git-send-email-bharatku@xilinx.com>
 <2717087.4cxEA98ZJk@wuerfel>
In-Reply-To: <2717087.4cxEA98ZJk@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: [PATCH v10] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
> PCIe Host Controller
> 
> On Friday 27 November 2015 20:32:03 Bharat Kumar Gogada wrote:
> > +       do {
> > +               err = nwl_pcie_link_up(pcie, PHY_RDY_LINKUP);
> > +               if (err != 1) {
> > +                       check_link_up++;
> > +                       if (check_link_up > LINKUP_ITER_CHECK)
> > +                               return -ENODEV;
> > +                       mdelay(1000);
> > +               }
> > +       } while (!err);
> 
> mdelay(1000) is not something anyone should do. Why can't you call a
> sleeping function here?
> 
Agreed will use sleep function, will address it in next patch.

Regards,
Bharat

