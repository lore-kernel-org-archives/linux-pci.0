Return-Path: <SRS0=whaY=5S=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E76AC43331
	for <linux-pci@archiver.kernel.org>; Thu,  2 Apr 2020 19:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402D02078B
	for <linux-pci@archiver.kernel.org>; Thu,  2 Apr 2020 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585856306;
	bh=pwPtTd+4KW+g8YHAiKRR3T9hCq/0VHHvJwxJjB4MjIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Z3nK+Rj5ZCb0gjBEa0dUKcq2p1YJgZiBeIJvX24Yprq9nPRyi6POZ8N8n1myEqI55
	 M71AGzo+w58gHXd8tXAuLZtqObuoJqstbt4aL57i4iBBdw9n1iw0uUfNObuC1nJlt6
	 G/U8yD0Y7OfV3ZqhOEFJH0sN4wMKlAJGtjcFxsTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgDBTiZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbgDBTiZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Apr 2020 15:38:25 -0400
Received: from localhost (mobile-166-170-223-166.mycingular.net [166.170.223.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95D6C206F8;
        Thu,  2 Apr 2020 19:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585856304;
        bh=pwPtTd+4KW+g8YHAiKRR3T9hCq/0VHHvJwxJjB4MjIE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mT0VCqJ6EcoVw211LaBPy1qvgmqjcZAnwvjzKdB0RRFAWx8dGPeHA7yHsFuOIgZQr
         ctKevWwLWABji7HsKVUgdUEjz333xjlZUyCoO1I+KGYnF61tlS6M2gIGm4W2ncraLr
         kaNX6JrIKH64KAeQ2hOH96KrZhsvKG7EhgNJiylA=
Date:   Thu, 2 Apr 2020 14:38:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net, sergei.shtylyov@cogentembedded.com,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 3/4] PCI: brcmstb: Wait for Raspberry Pi's firmware
 when present
Message-ID: <20200402193820.GA32107@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47c543e2144d5247743548b00d1931e9fc217f43.camel@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob for DT platform device dependency question]

On Thu, Apr 02, 2020 at 04:27:23PM +0200, Nicolas Saenz Julienne wrote:
> On Wed, 2020-04-01 at 15:41 -0500, Bjorn Helgaas wrote:
> > On Tue, Mar 24, 2020 at 07:28:11PM +0100, Nicolas Saenz Julienne wrote:
> > > xHCI's PCI fixup, run at the end of pcie-brcmstb's probe, depends on
> > > RPi4's VideoCore firmware interface to be up and running. It's possible
> > > for both initializations to race, so make sure it's available prior to
> > > starting.
> > > 
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c
> > > b/drivers/pci/controller/pcie-brcmstb.c
> > > index 3a10e678c7f4..a3d3070a5832 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -28,6 +28,8 @@
> > >  #include <linux/string.h>
> > >  #include <linux/types.h>
> > >  
> > > +#include <soc/bcm2835/raspberrypi-firmware.h>
> > > +
> > >  #include "../pci.h"
> > >  
> > >  /* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config regs */
> > > @@ -917,11 +919,24 @@ static int brcm_pcie_probe(struct platform_device
> > > *pdev)
> > >  {
> > >  	struct device_node *np = pdev->dev.of_node, *msi_np;
> > >  	struct pci_host_bridge *bridge;
> > > +	struct device_node *fw_np;
> > >  	struct brcm_pcie *pcie;
> > >  	struct pci_bus *child;
> > >  	struct resource *res;
> > >  	int ret;
> > >  
> > > +	/*
> > > +	 * We have to wait for the Raspberry Pi's firmware interface to be up
> > > +	 * as some PCI fixups depend on it.
> > 
> > It'd be nice to know the nature of this dependency between the
> > firmware interface and the fixups.  This may be useful for future
> > maintenance.  E.g., if PCI config access doesn't work until the
> > firmware interface is up, that would affect almost everything.  But
> > you say "some PCI fixups", so I suppose the actual dependency is
> > probably something else.
> 
> Sorry it wasn't clear enough, I'll redo this comment. Also note that
> the PCIe bus and the XHCI chip are hardwired, so that's the only
> device that'll ever be available on the bus.
> 
> VIA805's XHCI firmware has to be loaded trough RPi's firmware
> mailbox in between the PCIe bus probe and the subsequent USB probe.
> Note that a PCI reset clears the firmware. The only mechanism
> available in between the two operations are PCI Fixups. These are
> limited in their own way, as I can't return -EPROBE_DEFER if the
> firmware interface isn't available yet. Hence the need for an
> explicit dependency between pcie-brcmstb and raspberrypi's firmware
> mailbox device.
>
> Your concern here showcases this series' limitations. From a high
> level perspective it's not clear to me who should be responsible for
> downloading the firmware. 

I think it's fairly common for drivers to download firmware to their
devices.  I guess there's not really any need to download the firmware
until a driver wants to use the device, right?

> And I get the feeling I'm abusing PCI fixups. I haven't found any
> smart way to deal with this three way dependency of
> platform/non-platform devices.

So IIUC, the three-way dependency involves:

  1) brcm_pcie_probe(), which initialize the PCI host controller
  platform device, enumerates PCI devices, and makes them available
  for driver binding,

  2) the firmware mailbox initialization (maybe
  rpi_firmware_probe()?),

  3) quirk_usb_early_handoff(), which downloads firmware to the VL805
  PCI USB adapter via rpi_firmware_init_vl805(), which uses the
  firmware mailbox?

Is there some way to express a dependency between
"raspberrypi,bcm2835-firmware" (the platform device claimed by
rpi_firmware_probe() and "brcm,bcm2711-pcie"?  If we could ensure that
rpi_firmware_probe() runs before brcm_pcie_probe(), would that solve
part of this?

Bjorn
