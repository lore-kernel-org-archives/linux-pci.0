Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:43037 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212Ab3JJUdq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Oct 2013 16:33:46 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so1127085wgg.20
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2013 13:33:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0E83723C55F66F43A6041464FE31119D408C77@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
	<201310082256.28474.marex@denx.de>
	<0E83723C55F66F43A6041464FE31119D401869@039-SN2MPN1-011.039d.mgd.msft.net>
	<201310101225.10455.marex@denx.de>
	<0E83723C55F66F43A6041464FE31119D408C77@039-SN2MPN1-011.039d.mgd.msft.net>
Date: Thu, 10 Oct 2013 13:33:45 -0700
Message-ID: <CAJ+vNU3OhvPNvBY2ZJ_jg2E+c0f+062n2Wj2PZnQ472UXTHOVQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q
From: Tim Harvey <tharvey@gateworks.com>
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: Marek Vasut <marex@denx.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 10, 2013 at 3:40 AM, Zhu Richard-R65037
<r65037@freescale.com> wrote:

>      host=10.192.242.95, domain=ap.freescale.net, nis-domain=(none)
>      bootserver=0.0.0.0, rootserver=10.192.225.216, rootpath=
>      nameserver0=10.192.130.201, nameserver1=10.211.0.3, nameserver2=10.196.51.200
> ALSA device list:
>   #0: wm8962-audio
>   #1: imx-hdmi-soc
> VFS: Mounted root (nfs filesystem) on device 0:11.
> devtmpfs: mounted
> Freeing unused kernel memory: 300K (80c29000 - 80c74000)
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b   <--System panic here sometimes. :(

Marek,

This is where an imprecise abort is triggered - refer to my comments
regarding the abort handler at
http://thread.gmane.org/gmane.linux.drivers.devicetree/44659/focus=46171
- you should disable the bumping of the PC and/or the handler.

Did this patch ever get applied and if so what git tree?  I would like
to continue testing it as well with the boards I have that have a
switch.

Tim
