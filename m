Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Tue, 31 May 2016 14:20:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Peter Wu <peter@lekensteyn.nl>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	dri-devel@lists.freedesktop.org, Bjorn Helgaas <helgaas@kernel.org>,
	nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
Subject: Re: [Nouveau] [PATCH 4/4] drm/nouveau/acpi: fix lockup with PCIe
 runtime PM
Message-ID: <20160531122026.GA14129@wunner.de>
References: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
 <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
 <20160525135535.GN1789@lahna.fi.intel.com>
 <20160527111037.GA1436@al>
 <20160530095709.GK1789@lahna.fi.intel.com>
 <20160530122010.GB1149@al>
 <20160530130909.GA1743@lahna.fi.intel.com>
 <20160530161351.GA1355@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160530161351.GA1355@al>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 06:13:51PM +0200, Peter Wu wrote:
> Do you have any suggestions for the case where the pcieport driver
> refuses to put the bridge in D3 (because the BIOS is too old)? In that
> case the nouveau driver needs to fallback to the DSM method (but not
> when runtime PM is deliberately disabled by writing control=on).

The BIOS cut-off date is meant to avoid issues when suspending ports
on older chipsets. However if the port is used for an Optimus GPU
and we can clearly identify that, and there's a _PR3 method provided,
it's probably safe to say that the port is *intended* to be suspended.

So you may want to consider amending pci_bridge_d3_possible() to
allow D3 for such ports regardless of the BIOS date, as I've done
for Thunderbolt in this commit:
https://github.com/l1k/linux/commit/3cb8549cd4e5

Not sure how to uniquely identify such ports though. Perhaps check
if there's a device in slot 0 below the port which has
	(pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY &&
	(pdev->vendor == PCI_VENDOR_ID_NVIDIA ||
	 pdev->vendor == PCI_VENDOR_ID_ATI)

Best regards,

Lukas
