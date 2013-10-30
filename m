Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:36932 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab3J3Jy5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2013 05:54:57 -0400
From: Marek Vasut <marex@denx.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: imx6: increase link startup
Date: Wed, 30 Oct 2013 10:54:50 +0100
Cc: Tim Harvey <tharvey@gateworks.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Frank Li <lznuaa@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
References: <1382505138-23286-1-git-send-email-tharvey@gateworks.com> <20131029222036.GB15159@google.com>
In-Reply-To: <20131029222036.GB15159@google.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310301054.50502.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

> On Tue, Oct 22, 2013 at 10:12:18PM -0700, Tim Harvey wrote:
> > An increase link startup delay is required when certain PCI switches are
> > attached to the root complex.  This was tested with a Pericom switch
> > and a PLX switch.
> > 
> > From: Marek Vasut <marex@denx.de>
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Acked-by: Tim Harvey <tharvey@gateworks.com>
> 
> I applied this with Shawn's ack to my pci/host-imx6 branch for v3.13,
> thanks!
> 
> I assume the intent was that this patch was written by Marek, per the
> "From:" line you added above, so I fixed that in the patch so Marek
> appears as the author.  Let me know if this is incorrect.

I'm really glad Tim split this patch while I am being totally unhelpful here on 
the PCIe front in last few days. Thank you!

Best regards,
Marek Vasut
