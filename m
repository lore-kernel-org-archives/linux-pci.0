Return-Path: <SRS0=C1HO=IR=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=C1HO=IR=linux.intel.com=mika.westerberg@kernel.org>
Date: Wed, 30 May 2018 16:27:04 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 3/9] PCI: pciehp: Clear Presence Detect and Data Link
 Layer Status Changed on resume
Message-ID: <20180530132704.GU15419@lahna.fi.intel.com>
References: <20180416103453.46232-1-mika.westerberg@linux.intel.com>
 <20180416103453.46232-4-mika.westerberg@linux.intel.com>
 <20180501215211.GD11698@bhelgaas-glaptop.roam.corp.google.com>
 <20180502115509.GF2355@lahna.fi.intel.com>
 <20180502134148.GF11698@bhelgaas-glaptop.roam.corp.google.com>
 <20180503104250.GJ2355@lahna.fi.intel.com>
 <20180503230108.GD15790@bhelgaas-glaptop.roam.corp.google.com>
 <20180530104050.GA3954@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180530104050.GA3954@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 12:40:50PM +0200, Lukas Wunner wrote:
> JFYI, I've added the below patch to my upcoming series which reworks
> pciehp event handling and adds runtime PM support:
> https://github.com/l1k/linux/commits/pciehp_runpm_v2
> 
> The patch removes pciehp_force and reverts db63d40017a5 as requested.

Thanks for taking care if it! I can remove it from my todo list now :-)
