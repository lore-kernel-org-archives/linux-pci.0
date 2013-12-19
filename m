Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:40978 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab3LSSFe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2013 13:05:34 -0500
Received: by mail-ie0-f175.google.com with SMTP id x13so1801197ief.34
        for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2013 10:05:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131219060921.GX6691@S2101-09.ap.freescale.net>
References: <1386885004-10252-1-git-send-email-marex@denx.de>
 <20131218200645.GF15119@google.com> <20131219060921.GX6691@S2101-09.ap.freescale.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 19 Dec 2013 11:05:11 -0700
Message-ID: <CAErSpo6O3uVNXo2HbYVaNnmmFg=D6HTTHFxEuUb-PKSs1L3wCA@mail.gmail.com>
Subject: Re: [PATCH V2 1/7] PCI: imx6: Make reset-gpio optional
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Marek Vasut <marex@denx.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Frank Li <lznuaa@gmail.com>, Harro Haan <hrhaan@gmail.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 18, 2013 at 11:09 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Dec 18, 2013 at 01:06:45PM -0700, Bjorn Helgaas wrote:
>> On Thu, Dec 12, 2013 at 10:49:58PM +0100, Marek Vasut wrote:
>> > Some boards do not have a PCIe reset GPIO. To avoid probe
>> > failure on these boards, make the reset GPIO optional as
>> > well.
>> >
>> > Signed-off-by: Marek Vasut <marex@denx.de>
>> > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> > Cc: Frank Li <lznuaa@gmail.com>
>> > Cc: Harro Haan <hrhaan@gmail.com>
>> > Cc: Jingoo Han <jg1.han@samsung.com>
>> > Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
>> > Cc: Pratyush Anand <pratyush.anand@st.com>
>> > Cc: Richard Zhu <r65037@freescale.com>
>> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> > Cc: Sean Cross <xobs@kosagi.com>
>> > Cc: Shawn Guo <shawn.guo@linaro.org>
>> > Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
>> > Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
>> > Cc: Tim Harvey <tharvey@gateworks.com>
>> > Cc: Troy Kisky <troy.kisky@boundarydevices.com>
>> > Cc: Yinghai Lu <yinghai@kernel.org>
>> > ---
>> >  .../devicetree/bindings/pci/designware-pcie.txt    |  2 ++
>> >  drivers/pci/host/pci-imx6.c                        | 29 +++++++++++-----------
>> >  2 files changed, 17 insertions(+), 14 deletions(-)
>>
>> Richard or Shawn, can you ack/nak these (patches 1-6)?  I'd like to dispose
>> of them one way or the other.
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

I assume this ack applies to all the patches (1-6).  I applied these
to my pci/host-imx6 branch for v3.14.    Thanks!

Bjorn
