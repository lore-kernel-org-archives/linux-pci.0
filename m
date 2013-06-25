Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:41386 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab3FYJzy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2013 05:55:54 -0400
Date: Tue, 25 Jun 2013 11:55:52 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
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
	Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCHv3 02/11] pci: use weak functions for MSI arch-specific
 functions
Message-ID: <20130625115552.7ebdad17@skate>
In-Reply-To: <CAErSpo6Mm6kYZKN_n-fMRD2T1-F0sf9GStmOTA8tT0wVLedCgw@mail.gmail.com>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1371660979-21588-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130620185707.GA8888@mithrandir>
	<CAErSpo6Mm6kYZKN_n-fMRD2T1-F0sf9GStmOTA8tT0wVLedCgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Mon, 24 Jun 2013 19:52:45 -0600, Bjorn Helgaas wrote:

> I agree; the whole point of __weak is to provide a "default"
> implementation, so I hope you can just remove any empty default_*()
> functions and fold the others into the arch_*() functions directly.
> 
> If there actually are callbacks from arch-specific strong functions
> back to the stuff in the default_*() functions, that suggests that we
> should refactor and rename that bit of functionality.

There is one such case, as highlighted in the commit log of this patch:

"""
This is needed because the x86 Xen implementation of
teardown_msi_irqs() needs to do some work, and then call the default
implementation of this hook.
"""

Any suggestion on how to solve this particular case?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
