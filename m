Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1on0142.outbound.protection.outlook.com ([157.56.110.142]:25796
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750828AbaIWDKx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 23:10:53 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: RE: [PATCH RFC 1/2] PCI: imx6: enable pcie on imx6qdl sabresd and
 sabreauto
Date: Tue, 23 Sep 2014 03:11:06 +0000
Message-ID: <5ee51ba972f34d36b73aba791e5c8a67@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1411376498-14653-1-git-send-email-r65037@freescale.com>
 <1411376498-14653-2-git-send-email-r65037@freescale.com>
 <20140922131519.GA30055@kroah.com>
In-Reply-To: <20140922131519.GA30055@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Monday, September 22, 2014 9:15 PM
> To: Zhu Richard-R65037
> Cc: linux-pci-owner@vger.kernel.org; stable@vger.kernel.org; linux-
> pci@vger.kernel.org; l.stach@pengutronix.de
> Subject: Re: [PATCH RFC 1/2] PCI: imx6: enable pcie on imx6qdl sabresd and
> sabreauto
> 
> On Mon, Sep 22, 2014 at 05:01:37PM +0800, Richard Zhu wrote:
> > - enable pcie support on imx6qdl sabresd and asbreauto boards.
> > - sabresd board has the pcie power on and reset gpios, but sabreauto
> > doesn't have these two gpios.
> >
> > Signed-off-by: Richard Zhu <r65037@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
> >  arch/arm/boot/dts/imx6qdl-sabresd.dtsi   | 2 ++
> >  2 files changed, 6 insertions(+)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the stable
> kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 
> </formletter>
[Richard] Roger that, thanks for your reminder.
It's my fault to make a mistake to send the patch review to table kernel mail-list. Sorry about that.

Best Regards
Richard Zhu

