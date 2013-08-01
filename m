Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from up.free-electrons.com ([94.23.35.102]:55296 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751428Ab3HAR7A (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 13:59:00 -0400
Date: Thu, 1 Aug 2013 19:58:56 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
Message-ID: <20130801195856.00f78934@skate>
In-Reply-To: <CAErSpo67t2D=bLMq3fxU6Hj9FX+MBAbaLNbF42-uufWug-x8Tg@mail.gmail.com>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAErSpo67t2D=bLMq3fxU6Hj9FX+MBAbaLNbF42-uufWug-x8Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Thu, 1 Aug 2013 10:50:25 -0600, Bjorn Helgaas wrote:
> On Thu, Aug 1, 2013 at 7:25 AM, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > Hello,
> >
> > This set of patches introduces Message Signaled Interrupt support in
> > the Marvell EBU PCIe driver. It has been successfully tested on the
> > Armada XP GP platform with an Intel e1000e PCIe network card that
> > supports MSI.
> >
> > This patch set is intended for merging in 3.12, so the respective
> > maintainers of the different areas are invited to review/ack the
> > patches, see below for the details. Note that several of those patches
> > are also needed for the Tegra PCIe driver.
> >
> > There are still missing ACKs from Grant Likely (5, 6, 7), Thomas
> > Gleixner (8, 9) and Bjorn Helgaas (2, 12).
> 
> I just acked 2, and my ack is already on 12.  Let me know if you need
> anything else from me.

That's good, thanks a lot!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
