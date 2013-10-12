Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:39696 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab3JLCaI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2013 22:30:08 -0400
From: Marek Vasut <marex@denx.de>
To: "Zhu Richard-R65037" <r65037@freescale.com>
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q
Date: Sat, 12 Oct 2013 04:30:04 +0200
Cc: Tim Harvey <tharvey@gateworks.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org> <CAJ+vNU0HJs9NxPy8Erer1ZUzCAkzhQn+c0atmEZ=ZZWLgXb6Kw@mail.gmail.com> <0E83723C55F66F43A6041464FE31119D40A9C9@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <0E83723C55F66F43A6041464FE31119D40A9C9@039-SN2MPN1-011.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310120430.04282.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

> Hi Tim:
> As I know that the clock of pcie controller should be always running.
> There are not clock gate on/off operations in host driver after the
> initialization.

I think the problem might happen when the PCIe device (Ethernet adapter) is bus-
master and either initiates PCIe->AXI->memory write or memory->AXI->PCIe read 
transfer. This is because when the Intel ethernet (igb) is probed, it only uses 
the MEM window that's mapped into the AXI space (that window at 0x01100000). On 
the other hand, when some packet is transfered, the Intel controller operates 
with structures in DRAM directly. And the stall only happens when the interface 
either receives or attempts to send a packet.

Is this theory of mine even reasonable? If this doesn't work properly, could 
this stall the CPU? How can I check if this works correctly? What can I try if 
it does not?

Thanks!

btw. Please be careful about the top-posting ;-)

Best regards,
Marek Vasut
