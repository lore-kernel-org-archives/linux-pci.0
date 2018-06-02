Return-Path: <SRS0=OP+v=IU=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=OP+v=IU=linux.intel.com=mika.westerberg@kernel.org>
Date: Sat, 2 Jun 2018 21:49:33 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v1 2/2] PCI: shpchp: Fix AMD POGO identification
Message-ID: <20180602184933.GU15419@lahna.fi.intel.com>
References: <152791788214.257724.13044360353832574147.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152791813206.257724.14863139556803168986.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <152791813206.257724.14863139556803168986.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 02, 2018 at 12:42:12AM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The fix for an AMD POGO erratum related to SHPC incorrectly identified the
> device.  The workaround should be applied only for AMD POGO devices, but it
> was instead applied to:
> 
>   - all AMD bridges, and
>   - all devices from any vendor with device ID 0x7458

Good catch.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
