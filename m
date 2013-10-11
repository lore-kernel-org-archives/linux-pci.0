Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:39445 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126Ab3JKUNp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2013 16:13:45 -0400
From: Marek Vasut <marex@denx.de>
To: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q
Date: Fri, 11 Oct 2013 22:13:42 +0200
Cc: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Zhu Richard-R65037" <r65037@freescale.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org> <201310111644.22844.marex@denx.de> <CAJ+vNU0HJs9NxPy8Erer1ZUzCAkzhQn+c0atmEZ=ZZWLgXb6Kw@mail.gmail.com>
In-Reply-To: <CAJ+vNU0HJs9NxPy8Erer1ZUzCAkzhQn+c0atmEZ=ZZWLgXb6Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310112213.42221.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Tim Harvey,

> Marek,
> 
> Looks like you and I are getting the same results now.  Device
> enumeration is working fine through the switch however when I attempt
> to use a device behind the switch (gige adapter in my case) I find
> that I get a few interrupts to that devices irq handler then the
> system hangs (like what occurs when a read is done to dbi without the
> pcie controllers clock running).
> 
> Anyone have any ideas?

Certainly. My Intel "igb" card now shows Link UP, sends about two packets and 
then the whole system freezes entirely. Not even my BDI3000 is able to "halt" it 
via JTAG.

btw. Tim, just a nit-pick. Top-posting into a public ML is frowned upon.

Best regards,
Marek Vasut
