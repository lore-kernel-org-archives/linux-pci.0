Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:51313 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab3LLVIP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 16:08:15 -0500
Received: by mail-ig0-f181.google.com with SMTP id k19so203412igc.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2013 13:08:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201312121925.27591.marex@denx.de>
References: <1386757818-5154-1-git-send-email-marex@denx.de>
 <201312121122.33746.marex@denx.de> <CAJ+vNU0aoOtZEdq6GDPpwZAgu+EN3FjHnr8JAdXCxOiDfJ5m6A@mail.gmail.com>
 <201312121925.27591.marex@denx.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 12 Dec 2013 14:07:54 -0700
Message-ID: <CAErSpo7C4rJZBuBUDRN6L_fkQZNthfeY=_oJ=_WCcqAxoj2Xig@mail.gmail.com>
Subject: Re: [PATCH 1/7] PCI: imx6: Make reset-gpio optional
To: Marek Vasut <marex@denx.de>,
	Zhu Richard-R65037 <r65037@freescale.com>
Cc: Tim Harvey <tharvey@gateworks.com>,
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
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 12, 2013 at 11:25 AM, Marek Vasut <marex@denx.de> wrote:
> Bjorn, would you mind picking 2/7...6/7 of this series so we are done with
> those? I will re-post 1/7 as a self-standing patch afterwards, it has no impact
> on the rest of the series.

Sure.  I can't really evaluate these myself, so I'm looking for acks
from Richard or Shawn.

I noticed Pratyush, Tim, and Harro had some questions the first time
around, and I don't know whether they got resolved.

Bjorn
