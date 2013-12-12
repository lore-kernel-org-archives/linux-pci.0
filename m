Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:43812 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab3LLVua (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 16:50:30 -0500
From: Marek Vasut <marex@denx.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/7] PCI: imx6: Make reset-gpio optional
Date: Thu, 12 Dec 2013 22:38:28 +0100
Cc: "Zhu Richard-R65037" <r65037@freescale.com>,
	Tim Harvey <tharvey@gateworks.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Frank Li <lznuaa@gmail.com>, Harro Haan <hrhaan@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
References: <1386757818-5154-1-git-send-email-marex@denx.de> <CAErSpo7C4rJZBuBUDRN6L_fkQZNthfeY=_oJ=_WCcqAxoj2Xig@mail.gmail.com> <CAErSpo682q3TkjsZvtR4Qhvvwfmx7FUB2QZTfQV+3Q+nK0C-7w@mail.gmail.com>
In-Reply-To: <CAErSpo682q3TkjsZvtR4Qhvvwfmx7FUB2QZTfQV+3Q+nK0C-7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201312122238.28413.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 12, 2013 at 10:20:30 PM, Bjorn Helgaas wrote:
> On Thu, Dec 12, 2013 at 2:07 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > On Thu, Dec 12, 2013 at 11:25 AM, Marek Vasut <marex@denx.de> wrote:
> >> Bjorn, would you mind picking 2/7...6/7 of this series so we are done
> >> with those? I will re-post 1/7 as a self-standing patch afterwards, it
> >> has no impact on the rest of the series.
> > 
> > Sure.  I can't really evaluate these myself, so I'm looking for acks
> > from Richard or Shawn.
> > 
> > I noticed Pratyush, Tim, and Harro had some questions the first time
> > around, and I don't know whether they got resolved.
> 
> By the way, I tried to apply patches 2-6 to my pci/host-imx6 branch,
> but patch 6 ("PCI: imx6: Fix bugs in PCIe startup code") didn't apply
> cleanly.
> 
> I pushed the branch to
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host
> -imx6 if you want to try it yourself.

That's because of Fabio's patch. I will rebase and repost, thanks.

Best regards,
Marek Vasut
