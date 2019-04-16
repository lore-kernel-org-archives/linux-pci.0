Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2760AC10F14
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 14:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E60223E9
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 14:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfDPOP2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:15:28 -0400
Received: from foss.arm.com ([217.140.101.70]:56072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfDPOP2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Apr 2019 10:15:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B95BEEBD;
        Tue, 16 Apr 2019 07:15:27 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C58003F59C;
        Tue, 16 Apr 2019 07:15:24 -0700 (PDT)
Date:   Tue, 16 Apr 2019 15:15:25 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH v3 14/26] PCI: keystone: Add support for PCIe RC in
 AM654x Platforms
Message-ID: <20190416141525.GD14705@red-moon>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-15-kishon@ti.com>
 <20190413152633.GF126710@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413152633.GF126710@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 13, 2019 at 10:26:33AM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 25, 2019 at 03:09:35PM +0530, Kishon Vijay Abraham I wrote:
> > Add PCIe RC support for AM654x Platforms in pci-keystone.c
> 
> > +static int ks_pcie_am654_msi_host_init(struct pcie_port *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct device *dev = pci->dev;
> > +
> > +	dev_vdbg(dev, "dummy function so that DW core doesn't configure MSI\n");
> 
> Drive-by nit: this is the first occurrence of dev_vdbg() in
> drivers/pci, and while dev_vdbg() might be useful somewhere, I'm not
> sure this is the place.
> 
> It took me 10 minutes of archaeology to figure out what it is and how
> to use it.  Apparently it does nothing at all unless you define
> VERBOSE_DEBUG, which can be set via Kconfig in a few cases:
> 
>   drivers/dma/Makefile:subdir-ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
>   drivers/usb/dwc2/Makefile:ccflags-$(CONFIG_USB_DWC2_VERBOSE)    += -DVERBOSE_DEBUG
>   drivers/usb/gadget/Makefile:subdir-ccflags-$(CONFIG_USB_GADGET_VERBOSE) += -DVERBOSE_DEBUG
> 
> but is more commonly set by adding "#define VERBOSE_DEBUG" manually
> in a source file.  Neither one applies here, so I don't think this
> actually does anything.
> 
> Anyway, I suspect this particular message would make a lot of sense as
> a *comment*, but maybe not as a mysterious dev_vdbg() that never
> actually does anything.

I agree. Kishon ? I would do what Bjorn suggests here, please let me
know.

Lorenzo
