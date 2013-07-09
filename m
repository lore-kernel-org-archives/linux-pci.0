Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:35739 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab3GIOBi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jul 2013 10:01:38 -0400
Date: Tue, 9 Jul 2013 16:01:32 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv4 05/11] of: pci: add registry of MSI chips
Message-ID: <20130709160132.7f5e7a8e@skate>
In-Reply-To: <CAL_Jsq+h=y5SNo4qO5-5u_w8rW++9MKDZK8rASNjhtVcjh-iyQ@mail.gmail.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1372686136-1370-6-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAL_Jsq+h=y5SNo4qO5-5u_w8rW++9MKDZK8rASNjhtVcjh-iyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rob,

On Tue, 9 Jul 2013 08:43:36 -0500, Rob Herring wrote:

> > +int of_msi_chip_add(struct msi_chip *chip)
> 
> Perhaps of_pci_msi_chip_add instead.

Sure, makes sense.

> > +{
> > +       struct msi_chip *c;
> > +       list_for_each_entry(c, &msi_chip_list, list) {
> 
> Need the safe variant here?

As suggested by Bjorn, I've changed this function to grab the
msi_chip_mutex while traversing the list.

Does your e-mail implies that the general approach seems ok? If so,
I'll resend an updated v5 version taking into account the comments
that I have received on this v4.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
