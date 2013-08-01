Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:48278 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757250Ab3HAQIT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 12:08:19 -0400
Message-ID: <51FA87EE.60601@wwwdotorg.org>
Date: Thu, 01 Aug 2013 10:08:14 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/01/2013 07:25 AM, Thomas Petazzoni wrote:
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

Recall that Grant gave up most/all of his maintainerships, so you
probably want someone else to approve patches 5/6/7. It looks like
Benjamin Herrenschmidt <benh@kernel.crashing.org> is listed in
MAINTAINERS for those patches.
