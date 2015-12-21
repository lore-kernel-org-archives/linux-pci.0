Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33742 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbbLUVFL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Dec 2015 16:05:11 -0500
Received: by mail-ob0-f173.google.com with SMTP id bx1so14100371obb.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Dec 2015 13:05:11 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 21 Dec 2015 13:05:10 -0800
Message-ID: <CAJ+vNU1RhaJrrwznkfpPdmu8BSLifvRXt=5yK3C=WqqT-G1BoQ@mail.gmail.com>
Subject: IMX6 PCIe - use LVDS2 clock as input instead of LVDS1 as an ouput
From: Tim Harvey <tharvey@gateworks.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>, Sean Cross <xobs@kosagi.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lucas / Shawn / Sean,

Do any of you know what should be done in order to use the LVDS2 clock
as an 'input' for IMX6 PCIe?

Due to the fact that Freescale's internal clock does not pass Gen2
jitter tests, we have designed an IMX6 based board that follows
Freescale's recommendation to use an external Gen2 compliant clockgen
running to one of the LVDS clocks and now need to configure the kernel
to use this as an input. I had this run to LVDS2 because LVDS1 is
configured by the kernel as a clock output for all IMX6 (see
74b8031307c5d33d36742c26dd0921991bd5a255).

My understanding is that if nothing is changed the host controller
would use its internal reference clock, and the PCIe socket would use
the external clkgen and all would be well and fine for Gen1 because
they don't need to have synchronized clocks, but if Gen2 is needed we
must change the clock routing such that LVDS2 is an input and that it
is routed to the PCIe host controller reference clock.

I know that I can use IMX6QDL_CLK_LVDS2_IN instead of
IMX6QDL_CLK_LVDS1_GATE in the clocks property of the PCIe node in the
device-tree to configure LVDS2 as an input instead of LVDS1 as an
output, but I'm not sure what to do with the rest of the clock tree
and how to handle this dynamically at runtime.

Any ideas would be greatly appreciated.

Regards,

Tim

Tim Harvey - Principal Software Engineer
Gateworks Corporation - http://www.gateworks.com/
3026 S. Higuera St. San Luis Obispo CA 93401
805-781-2000
