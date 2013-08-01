Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:57227 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278Ab3HAQuq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 12:50:46 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so4268003obb.23
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2013 09:50:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 1 Aug 2013 10:50:25 -0600
Message-ID: <CAErSpo67t2D=bLMq3fxU6Hj9FX+MBAbaLNbF42-uufWug-x8Tg@mail.gmail.com>
Subject: Re: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
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
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 1, 2013 at 7:25 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> This set of patches introduces Message Signaled Interrupt support in
> the Marvell EBU PCIe driver. It has been successfully tested on the
> Armada XP GP platform with an Intel e1000e PCIe network card that
> supports MSI.
>
> This patch set is intended for merging in 3.12, so the respective
> maintainers of the different areas are invited to review/ack the
> patches, see below for the details. Note that several of those patches
> are also needed for the Tegra PCIe driver.
>
> There are still missing ACKs from Grant Likely (5, 6, 7), Thomas
> Gleixner (8, 9) and Bjorn Helgaas (2, 12).

I just acked 2, and my ack is already on 12.  Let me know if you need
anything else from me.

Bjorn
