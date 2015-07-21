Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 22 Jul 2015 00:02:50 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Alexander Gordeev <agordeev@redhat.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC Patch V1 09/12] genirq: Move msi_list from struct pci_dev
 to struct device
In-Reply-To: <20150710001936.GD6957@windriver.com>
Message-ID: <alpine.DEB.2.11.1507220000260.18576@nanos>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com> <1436428847-8886-10-git-send-email-jiang.liu@linux.intel.com> <20150710001936.GD6957@windriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 9 Jul 2015, Paul Gortmaker wrote:

> [[RFC Patch V1 09/12] genirq: Move msi_list from struct pci_dev to struct device] On 09/07/2015 (Thu 16:00) Jiang Liu wrote:
> 
> > Move msi_list from struct pci_dev into struct device, so we could support
> > non-PCI-device based generic MSI interrupts.
> 
> This is not just a simple move, as the new instances are within a
> Kconfig option.  I did not get the 0/12 so I don't know if this is
> expected, but the commit log here does not seem stand-alone enough
> to get through on its own merits; it needs more details.

config PCI_MSI
       select GENERIC_MSI_IRQ

So it's not changing anything, but I agree it might be mentioned in
the changelog.
 
Thanks,

	tglx
