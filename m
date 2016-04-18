Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 18 Apr 2016 13:50:15 +0200
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
Message-ID: <20160418115015.GE3886@suse.de>
References: <20160413055439.6877.68183.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160414155044.GB3886@suse.de>
 <20160415150821.GA7973@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160415150821.GA7973@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Fri, Apr 15, 2016 at 10:08:21AM -0500, Bjorn Helgaas wrote:
> I assume you're thinking about doing pci_enable_resources() before
> the core calls the driver's probe method?  One question there is how
> we would deal with pci_enable_device_mem().  If the core calls
> pci_enable_resources(), it has to assume the driver requires all BARs,
> and there are quite a few drivers that don't need the I/O BARs.

Yes, I think that the problem might be fixed when the resources are
enabled during the pcibios-call.

What do you think of enabling the the resources at probe time for the
pcibios-call and disable them afterwards? Then the driver can re-enable
whatever it needs and keep the rest disabled.



	Joerg
