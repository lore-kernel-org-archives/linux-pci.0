Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C6EC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 09:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAEC21872
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 09:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ul03ior8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfDLJcJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:32:09 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50248 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfDLJcJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 05:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=efoaWiVaTatF3CC7rGPOcvdGb1z0qD+BggWPJWcyRd4=; b=ul03ior8GvNvB7udMZN7/JApK
        e9fRp/czatLgWBPyUMK3qfZkF2+6g1vcnEf8sxasmBRAn8yY/2wJKcS2eRVe5M0GbZYrNfmGP5JW+
        dtgdOSUlKlMQ+TqHThJO9GNSwCA682Ca2qQJW9PkGyekX8SGlJjdN1UZQeeKZVltYe7gcX6Oi7W3v
        1O2y47qX2OHcxyb0g4GBgdGX+8M1klPnhmB741ha7aFxOH/4JQr0XhplB5BYBasBmoVBiCeo/fXyc
        oT4votLxxbNrUDK7Qen/UlnASfoOF/JBfRlRaSkqGQ0SDRxJlA6ppIgdlmmSQsU51PJ4kP2FfTHnr
        9YWzBFoaQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55426)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hEsXR-0008SW-RB; Fri, 12 Apr 2019 10:32:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hEsXK-0004lH-OA; Fri, 12 Apr 2019 10:31:54 +0100
Date:   Fri, 12 Apr 2019 10:31:54 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@axis.com, Minghuan Lian <minghuan.Lian@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, linux-omap@vger.kernel.org,
        Roy Zang <roy.zang@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 12/26] PCI: keystone: Prevent ARM32 specific code to
 be compiled for ARM64
Message-ID: <20190412093154.7wj4dmm3oppvv32m@shell.armlinux.org.uk>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-13-kishon@ti.com>
 <20190411150332.GC6862@red-moon>
 <ee9d27e6-c653-4965-b552-3cf1ce5bdf51@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee9d27e6-c653-4965-b552-3cf1ce5bdf51@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 02:20:06PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 11/04/19 8:33 PM, Lorenzo Pieralisi wrote:
> > On Mon, Mar 25, 2019 at 03:09:33PM +0530, Kishon Vijay Abraham I wrote:
> >> hook_fault_code is an ARM32 specific API for hooking into data abort.
> >> Since pci-keystone.c will be used for AM65X platforms which is an
> >> ARM64 platform,
> > 
> > Hi Kishon,
> > 
> > How is the problem plugged by the fault hook fixed on ARM64 ?
> 
> At least in AM654 platform, I don't see a bus error when PCIe device is not
> connected but returns 0xffffffff. So there is no necessary for hook_fault_code
> in AM654 platform.

... which needs to be explained somewhere, either in the commit
message or comments in the file, so that years later when someone
has to look at this code, they know why it is the way that it is.

When writing commits, please think about whether there is enough
information to understand the change in ten years time.

> 
> Thanks
> Kishon
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> >> allow hook_fault_code to be compiled only for ARM32.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/pci/controller/dwc/pci-keystone.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> >> index dfe54553d832..93296d434f40 100644
> >> --- a/drivers/pci/controller/dwc/pci-keystone.c
> >> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> >> @@ -710,6 +710,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
> >>  	return ret;
> >>  }
> >>  
> >> +#ifdef CONFIG_ARM
> >>  /*
> >>   * When a PCI device does not exist during config cycles, keystone host gets a
> >>   * bus error instead of returning 0xffffffff. This handler always returns 0
> >> @@ -729,6 +730,7 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
> >>  
> >>  	return 0;
> >>  }
> >> +#endif
> >>  
> >>  static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
> >>  {
> >> @@ -778,12 +780,14 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
> >>  	if (ret < 0)
> >>  		return ret;
> >>  
> >> +#ifdef CONFIG_ARM
> >>  	/*
> >>  	 * PCIe access errors that result into OCP errors are caught by ARM as
> >>  	 * "External aborts"
> >>  	 */
> >>  	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
> >>  			"Asynchronous external abort");
> >> +#endif
> >>  
> >>  	ks_pcie_start_link(pci);
> >>  	dw_pcie_wait_for_link(pci);
> >> -- 
> >> 2.17.1
> >>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
