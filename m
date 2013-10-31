Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:56753 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab3JaRgo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Oct 2013 13:36:44 -0400
Received: by mail-ie0-f180.google.com with SMTP id e14so5439123iej.39
        for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2013 10:36:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201310301552.28866.marex@denx.de>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <CAErSpo6v4nvKQ4W9BhnUsNEjzsXoCiLxeFY-K=z=bMZ4AFOyGg@mail.gmail.com> <201310301552.28866.marex@denx.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 31 Oct 2013 11:36:23 -0600
Message-ID: <CAErSpo7Bba=b_eH=TpxM7E8xqvSJQdfeCUuTSPsDKiOAkiSOrA@mail.gmail.com>
Subject: Re: [PATCH 0/6] PCI: imx6: Random fixes
To: Marek Vasut <marex@denx.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 30, 2013 at 8:52 AM, Marek Vasut <marex@denx.de> wrote:
> Dear Bjorn Helgaas,
>
>> On Tue, Oct 15, 2013 at 10:06 AM, Marek Vasut <marex@denx.de> wrote:
>> > Set of random fixes for the PCIe driver for i.MX6 . With these fixes, my
>> > setup with MX6Q -> PCIe bridge -> i210 ethernet adapter works as
>> > expected.
>> >
>> > NOTE: I'm sure this will start some discussion. There are quite a few
>> > patches
>> >
>> >       that are more of a hacks. Shawn, I didn't ignore your remark about
>> >       the clock patches, I will test it ASAP, I just want to have these
>> >       fixes in the public so others can comment/test.
>> >
>> > Marek Vasut (6):
>> >   PCI: imx6: Make reset-gpio optional
>> >   PCI: imx6: Fix the clock for PCIe
>> >   ARM: dts: imx6qdl: Fix the clock for PCIe
>> >   PCI: imx6: Probe the PCIe in fs_initcall()
>> >   PCI: imx6: Force Gen1 operation
>> >   PCI: designware: Fix DT resource retrieval
>> >
>> >  .../devicetree/bindings/pci/designware-pcie.txt    |  2 +-
>> >  arch/arm/boot/dts/imx6qdl.dtsi                     |  4 +-
>> >  drivers/pci/host/pci-imx6.c                        | 63
>> >  ++++++++++++++++------ drivers/pci/host/pcie-designware.c
>> >    | 17 +++---
>> >  4 files changed, 55 insertions(+), 31 deletions(-)
>>
>> I'm ignoring this series for now.  I assume you'll post an updated
>> series as mentioned in your Oct 17 response to "[Patch 5/6] PCI: imx6:
>> Force Gen1 operation."  Please mark that series as "v2" when you post
>> it.  My assumption is still that Shawn Guo will ack the
>> drivers/pci/host/ pieces before I apply them [1].
>
> Can you maybe pick at least these two:
>
> PCI: imx6: Make reset-gpio optional
> PCI: imx6: Probe the PCIe in fs_initcall()

Applied "Probe the PCIe in fs_initcall()" with Shawn's ack to my
pci/host-imx6 branch for v3.13, thanks.

Bjorn
