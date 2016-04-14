Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 14 Apr 2016 17:50:44 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org,
	=?utf-8?B?0J7Qu9C10LPQnNC+0YDQvtC3?= <oleg.moroz@mcc.vniiem.ru>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sunjin Yang <fan4326@gmail.com>,
	Rob Groner <rgroner@rtd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH 0/3] v4.4: Revert "PCI: Implement pcibios_alloc_irq() and
Message-ID: <20160414155044.GB3886@suse.de>
References: <20160413055439.6877.68183.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160413055439.6877.68183.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Wed, Apr 13, 2016 at 12:56:59AM -0500, Bjorn Helgaas wrote:
> We reverted the following changes from v4.5 to fix a regression:
> 
>   8affb487d4a4 ("x86/PCI: Don't alloc pcibios-irq when MSI is enabled")
>   811a4e6fce09 ("PCI: Add helpers to manage pci_dev->irq and pci_dev->irq_managed")
>   991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and pcibios_free_irq()")

Do you have a link to the thread about these issues? I'd like to have a
look at what has been tried to solve the regressions before the revert.

I had a look at commit 991de2e59090 and noted that the main difference
it introduces is that the pcibios-irq is allocated earlier (probe time,
before the commit it was pci_enable_device() time). In fact, it is now
allocated before pci_enable_resources() has been called on the device
(as far as I can see). I wonder if the regression can be fixed by
also moving pci_enable_resources() to probe time.


Regards,

	Joerg
