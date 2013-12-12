Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:57483 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab3LLWMO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 17:12:14 -0500
Received: by mail-ob0-f176.google.com with SMTP id vb8so1124857obc.7
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2013 14:12:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7C4rJZBuBUDRN6L_fkQZNthfeY=_oJ=_WCcqAxoj2Xig@mail.gmail.com>
References: <1386757818-5154-1-git-send-email-marex@denx.de>
	<201312121122.33746.marex@denx.de>
	<CAJ+vNU0aoOtZEdq6GDPpwZAgu+EN3FjHnr8JAdXCxOiDfJ5m6A@mail.gmail.com>
	<201312121925.27591.marex@denx.de>
	<CAErSpo7C4rJZBuBUDRN6L_fkQZNthfeY=_oJ=_WCcqAxoj2Xig@mail.gmail.com>
Date: Thu, 12 Dec 2013 23:12:13 +0100
Message-ID: <CAB5oZtBUTnA3FdO9_YyORfUx7Joqy96NF55o1-XQkFPXsWLoig@mail.gmail.com>
Subject: Re: [PATCH 1/7] PCI: imx6: Make reset-gpio optional
From: Harro Haan <hrhaan@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Marek Vasut <marex@denx.de>,
	Zhu Richard-R65037 <r65037@freescale.com>,
	Tim Harvey <tharvey@gateworks.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12 December 2013 22:07, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, Dec 12, 2013 at 11:25 AM, Marek Vasut <marex@denx.de> wrote:
>> Bjorn, would you mind picking 2/7...6/7 of this series so we are done with
>> those? I will re-post 1/7 as a self-standing patch afterwards, it has no impact
>> on the rest of the series.
>
> Sure.  I can't really evaluate these myself, so I'm looking for acks
> from Richard or Shawn.
>
> I noticed Pratyush, Tim, and Harro had some questions the first time
> around, and I don't know whether they got resolved.

Yes, Marek resolved the build warning comment in [PATCH V2 3/7]. Regards, Harro
