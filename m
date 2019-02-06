Return-Path: <SRS0=okY7=QN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DFEC282C2
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 09:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470E12081B
	for <linux-pci@archiver.kernel.org>; Wed,  6 Feb 2019 09:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbfBFJ2B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Feb 2019 04:28:01 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46045 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbfBFJ2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Feb 2019 04:28:01 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1grJUq-0007kz-5c; Wed, 06 Feb 2019 10:27:56 +0100
Message-ID: <1549445274.2544.57.camel@pengutronix.de>
Subject: Re: [PATCH RESEND] PCI: Check for USB xHCI class for HAPS platform
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Trent Piepho <tpiepho@impinj.com>,
        John Youn <john.youn@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
Date:   Wed, 06 Feb 2019 10:27:54 +0100
In-Reply-To: <20190205233159.GC7268@google.com>
References: <a28cfcee61f0842efe114c97b566bb3d967ba3d3.1549326366.git.thinhn@synopsys.com>
         <20190205233159.GC7268@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Am Dienstag, den 05.02.2019, 17:31 -0600 schrieb Bjorn Helgaas:
> [+cc Richard, Lucas]
> 
> On Tue, Feb 05, 2019 at 01:04:28PM -0800, Thinh Nguyen wrote:
> > The Synopsys HAPS USB controller has a VID PID (16c3,abcd) that
> > matches
> > to an existing PCIe controller. This quirk is intended for USB HAPS
> > devices only. To fix this, check for the PCI class USB xHCI to
> > prevent
> > matching the PCIe controllers.
> 
> So there are at least three different parts with the same Vendor &
> Device ID ([16c3:abcd]):
> 
>   1) Synopsys HAPS USB3 controller
>   2) Synopsys PCIe IP in the NXP i.MX6QP (reported by Lukas)

The first incorporation of this IP in a Freescale SoC (i.MX6Q) also
uses the device ID 0xabcd.

So this seems to be a major miscommunication between NXP/Freescale and
Synopsys.

Regards,
Lucas

>   3) Synopsys PCIe IP in the NXP i.MX7D (reported by Trent)
> 
> I don't know if Synopsys is to blame for 2 & 3, or if NXP was
> expected
> to change the Vendor ID when incorporating the Synopsys IP into the
> i.MX designs.  But even leaving the default Device ID of the PCIe IP
> the same as another Synopsys device was probably a bad idea.
> 
> dwc3-haps claims by Vendor & Device ID; it doesn't look at the Class
> Code.  What happens when it tries to claim the PCIe IP in i.MX?
> 
> lspci also doesn't look at the Class Code when it looks up the text
> name of devices, so it will print the same name for both.  Of course,
> the Linux PCI ID database at https://pci-ids.ucw.cz/read/PC/16c3
> shows
> basically no information for the 0x16c3 Vendor ID, so it won't print
> anything useful no matter what.  You could add some things there :)
> 
> > Fixes: 03e6742584af ("PCI: Override Synopsys USB 3.x HAPS device
> > class")
> > Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
> > ---
> >  drivers/pci/quirks.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index b0a413f3f7ca..e2a879e93d86 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -639,8 +639,9 @@ static void quirk_synopsys_haps(struct pci_dev
> > *pdev)
> >  		break;
> >  	}
> >  }
> > -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
> > -			 quirk_synopsys_haps);
> > +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, PCI_ANY_ID,
> > +			       PCI_CLASS_SERIAL_USB_XHCI, 0,
> > +			       quirk_synopsys_haps);
> >  
> >  /*
> >   * Let's make the southbridge information explicit instead of
> > having to
> > -- 
> > 2.11.0
> > 
