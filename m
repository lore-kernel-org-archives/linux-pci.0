Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56103 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751611AbcCWKso (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2016 06:48:44 -0400
Message-ID: <1458730121.2171.44.camel@pengutronix.de>
Subject: Re: iMX6q: Kernel panic when enabling interrupt for more than 2
 cards behind a PCIe-to-PCI bridge
From: Lucas Stach <l.stach@pengutronix.de>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Fabio Estevam <festevam@gmail.com>
Date: Wed, 23 Mar 2016 11:48:41 +0100
In-Reply-To: <56F2727F.8080205@tekno-soft.it>
References: <56F1747A.7080602@tekno-soft.it>
	 <CAOMZO5Ccu-w9cSRwSP0gQC+JAWh9Mn6VW3+33wzVW1nfRdbQcw@mail.gmail.com>
	 <1458728766.2171.39.camel@pengutronix.de> <56F2727F.8080205@tekno-soft.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 23.03.2016, 11:39 +0100 schrieb Roberto Fichera:
> On 03/23/2016 11:26 AM, Lucas Stach wrote:
> 
> Hi Lucas,
> 
> > Am Mittwoch, den 23.03.2016, 07:13 -0300 schrieb Fabio Estevam:
> >> On Tue, Mar 22, 2016 at 1:36 PM, Roberto Fichera <kernel@tekno-soft.it> wrote:
> >>> Hi All,
> >>>
> >>> I'm getting a kernel panic with a kernel v4.4.x when enabling interrupt for 2 cards behind a PCIe-to-PCI bridge
> >>> not sharing the same IRQ. If they don't share the same IRQ most often I'm getting a message claiming the emmc
> >>> is stuck. I've disabled MSI from PCI config because the cards are not getting any interrupt delivered.
> > Is the interrupt-map on your PCIe-to-PCI bridge correct? If it isn't the
> > CPU may drown in unhandled IRQ storms.
> 
> Can you please be more specific? Are you talking about INTA/B/C/D mapping?
> 
Yes. If you are using legacy interrupts that are not shared between
devices I suppose you are using multiple IRQ pins.

The interrupt-map on the i.MX6 PCI controller maps those legacy IRQs to
the internal ARM GIC IRQs, but it doesn't say anything about how your
bridge maps them.

If it doesn't map them 1:1, you need to have an interrupt-map property
at the bridge to define how the mapping is done.

Regards,
Lucas


