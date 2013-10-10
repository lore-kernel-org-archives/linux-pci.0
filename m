Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:53674 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756113Ab3JJUkV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 16:40:21 -0400
From: Marek Vasut <marex@denx.de>
To: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q
Date: Thu, 10 Oct 2013 22:40:12 +0200
Cc: "Zhu Richard-R65037" <r65037@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org> <0E83723C55F66F43A6041464FE31119D408C77@039-SN2MPN1-011.039d.mgd.msft.net> <CAJ+vNU3OhvPNvBY2ZJ_jg2E+c0f+062n2Wj2PZnQ472UXTHOVQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU3OhvPNvBY2ZJ_jg2E+c0f+062n2Wj2PZnQ472UXTHOVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201310102240.13181.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tim,

> On Thu, Oct 10, 2013 at 3:40 AM, Zhu Richard-R65037
> 
> <r65037@freescale.com> wrote:
> >      host=10.192.242.95, domain=ap.freescale.net, nis-domain=(none)
> >      bootserver=0.0.0.0, rootserver=10.192.225.216, rootpath=
> >      nameserver0=10.192.130.201, nameserver1=10.211.0.3,
> >      nameserver2=10.196.51.200
> > 
> > ALSA device list:
> >   #0: wm8962-audio
> >   #1: imx-hdmi-soc
> > 
> > VFS: Mounted root (nfs filesystem) on device 0:11.
> > devtmpfs: mounted
> > Freeing unused kernel memory: 300K (80c29000 - 80c74000)
> > Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b 
> >  <--System panic here sometimes. :(
> 
> Marek,
> 
> This is where an imprecise abort is triggered - refer to my comments
> regarding the abort handler at
> http://thread.gmane.org/gmane.linux.drivers.devicetree/44659/focus=46171
> - you should disable the bumping of the PC and/or the handler.

Good point.

> Did this patch ever get applied and if so what git tree?  I would like
> to continue testing it as well with the boards I have that have a
> switch.

V7 has the handler, yes.

http://patchwork.ozlabs.org/patch/278088/
http://patchwork.ozlabs.org/patch/278087/

You will also need to dig out the arm-specific portion from v6 3/3 so that the 
PCIe would probe:

http://patchwork.ozlabs.org/patch/275169/

And apply the clock patch:

http://patchwork.ozlabs.org/patch/275167/

Do you have any luck working with the bridge? I have this resource collision as 
seen in this thread.

Best regards,
Marek Vasut
