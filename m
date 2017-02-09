Return-Path: <SRS0=kA2g=ZW=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=kA2g=ZW=wunner.de=lukas@kernel.org>
Date: Thu, 9 Feb 2017 05:06:48 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Christoph Hellwig <hch@lst.de>, Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170209040648.GA1304@wunner.de>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170208192256.GB31395@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170208192256.GB31395@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 08, 2017 at 01:22:56PM -0600, Bjorn Helgaas wrote:
> Bjorn Helgaas (1):
>       Revert "PCI: pciehp: Add runtime PM support for PCIe hotplug ports"

What's the rationale for reverting this?

You've received patches to fix the issue on both affected machines,
so a revert seems unnecessary:

https://patchwork.kernel.org/patch/9557113/
https://patchwork.kernel.org/patch/9562007/

Lukas
