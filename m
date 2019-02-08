Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099B5C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDFEA2146E
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 14:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549635199;
	bh=dXIofY2YeXA/ZJaKecf3mgmXm6vF+WyXOcPwQr3jdmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LbBG+rzCDrHeHId5e7LXC3jIfcYGGAcsrdI3Dcx8vL7CCC3yOqOoKiBoujoU9+Bgy
	 wU+6riT0Ji/cjTo8iHURbr9tMJHD12axXIZodAmBZtL1qyAAtiH9yVygvt79wdd0x3
	 UI/J4MdXbGQq3bKWNNTKIpS19IfSp3iluEMbPIz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfBHONT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:13:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbfBHONT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 09:13:19 -0500
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6390020844;
        Fri,  8 Feb 2019 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549635197;
        bh=dXIofY2YeXA/ZJaKecf3mgmXm6vF+WyXOcPwQr3jdmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Do8jFUfYqrHu/SScyMLw6FCUJwCseAmkAHYohHRggGQpqg8yGdk17bXeM4zkxVMTT
         dMa3NFlLl/esqCBuZAQBNusVO8EkdPomcDkwGz59+VSp9q+Fu8xR0MaQcQPlqUTFOA
         bcVLnjqpzqsBKq/PjIo/GNKANrGasBMb1/EZ7h3Q=
Date:   Fri, 8 Feb 2019 08:13:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCHv3 17/27] PCI: mobiveil: fix the checking of valid device
Message-ID: <20190208141315.GU7268@google.com>
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com>
 <20190129080926.36773-18-Zhiqiang.Hou@nxp.com>
 <CAFZiPx0faPHN1mqPV28XTZfOxA2GgDPuc=RVdXEiGGNAUe=Fxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFZiPx0faPHN1mqPV28XTZfOxA2GgDPuc=RVdXEiGGNAUe=Fxw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas]

On Fri, Feb 08, 2019 at 06:11:15PM +0530, Subrahmanya Lingappa wrote:
> On Tue, Jan 29, 2019 at 1:40 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> >
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Avoid to issue CFG transactions to link partner when the PCIe
> > link is not up. And allow CFG transactions to all functions of
> > Endpoint implemented multiple functions.
> >
> > Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
> > Bridge IP driver")
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > ---
> > V3:
> >  - No change
> >
> >  drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> > index dc5324d94466..1ae82e790562 100644
> > --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> > +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> > @@ -29,6 +29,10 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
> >  {
> >         struct mobiveil_pcie *pcie = bus->sysdata;
> >
> > +       /* If there is no link, then there is no device */
> > +       if (bus->number > pcie->rp.root_bus_nr && !mobiveil_pcie_link_up(pcie))
> > +               return false;
> > +
> >         /* Only one device down on each root port */
> >         if ((bus->number == pcie->rp.root_bus_nr) && (devfn > 0))
> >                 return false;
> > @@ -37,7 +41,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
> >          * Do not read more than one device on the bus directly
> >          * attached to RC
> >          */
> > -       if ((bus->primary == pcie->rp.root_bus_nr) && (devfn > 0))
> > +       if ((bus->primary == pcie->rp.root_bus_nr) && (PCI_SLOT(devfn) > 0))

> here change "primary" to "number", as it's a bug in the original driver too.

This looks like it should be split into two patches: (1) checking for
link up, and (2) checking root_bus_nr.

And if you mean "bus->primary == pcie->rp.root_bus_nr" is a bug in
pci-aardvark.c, too, it is imperative to fix that bug also (with a
separate patch).

> >                 return false;
> >
> >         return true;
> > --
> > 2.17.1
> >
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
