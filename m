Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35814 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013AbcDSJmE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 19 Apr 2016 05:42:04 -0400
Date: Tue, 19 Apr 2016 11:41:48 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org,
	=?utf-8?B?0J7Qu9C10LPQnNC+0YDQvtC3?= <oleg.moroz@mcc.vniiem.ru>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>,
	Rob Groner <rgroner@rtd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH 0/3] v4.4: Revert "PCI: Implement pcibios_alloc_irq() and
Message-ID: <20160419094148.GG3886@suse.de>
References: <20160413055439.6877.68183.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160414155044.GB3886@suse.de>
 <20160415150821.GA7973@localhost>
 <20160418115015.GE3886@suse.de>
 <20160418144336.GA17863@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160418144336.GA17863@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 18, 2016 at 09:43:36AM -0500, Bjorn Helgaas wrote:
> That might work, but the problem seems to be that we aren't enabling
> IRQs correctly, so I'd rather have a fix that explicitly addresses
> IRQs than one that relies on some non-obvious connection between
> enabling BARs and IRQs.

Yeah, either we or the BIOS does something wrong. The bugzilla entry
states that it works with pci=routeirq. The dmesg from kernel 4.3 shows
that per default ACPI routing is used for IRQs.

The difference this makes in the code is the pcibios_enable_irq function
pointer. For ACPI it points to acpi_pci_irq_enable and in the
pci=routeirq case to pirq_enable_irq.

So the problem appears when acpi_pci_irq_enable is used with device
resources disabled. This might very well also be a bios issue that we
have to work around, no?



	Joerg

