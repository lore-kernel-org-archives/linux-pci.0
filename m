Return-Path: <SRS0=6EQm=IQ=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=6EQm=IQ=linux.intel.com=mika.westerberg@kernel.org>
Date: Tue, 29 May 2018 16:41:29 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 0/7] PCI: Fixes and cleanups for native PCIe, SHPC and
 ACPI hotplug
Message-ID: <20180529134129.GV15419@lahna.fi.intel.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180529132617.GB79098@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180529132617.GB79098@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 29, 2018 at 08:26:17AM -0500, Bjorn Helgaas wrote:
> I only see these on the mailing list and in patchwork:
> 
>   [PATCH v8 1/7] PCI: Take all bridges into account when calculating bus numbers for extension
>   [PATCH v8 2/7] PCI: Introduce shpchp_is_native()
>   [PATCH v8 3/7] PCI: Introduce hotplug_is_native()
>   [PATCH v8 6/7] PCI: Move resource distribution for a single bridge outside of the loop
>   [PATCH v8 7/7] PCI: Document return value of pci_scan_bridge() and pci_scan_bridge_extend()
> 
> Looks like patches 4 and 5 are missing for some reason.

Hmm, weird. I'll resend those in a moment.
