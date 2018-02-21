Return-Path: <SRS0=WqYm=FP=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=WqYm=FP=wunner.de=lukas@kernel.org>
Date: Wed, 21 Feb 2018 10:54:35 +0100
From: Lukas Wunner <lukas@wunner.de>
To: George Cherian <gcherian@caviumnetworks.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, Jayachandran.Nair@cavium.com,
	Robert.Richter@cavium.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Message-ID: <20180221095435.xe5lmes7mpxca3en@wunner.de>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <2323301.ORZpb3hFRe@aspire.rjw.lan>
 <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
 <2858019.9TUCWsDpTB@aspire.rjw.lan>
 <20180220015433.GA9656@wunner.de>
 <20180220190037.GB32228@bhelgaas-glaptop.roam.corp.google.com>
 <c8454323-06b2-e758-0d38-550c6b31b15e@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c8454323-06b2-e758-0d38-550c6b31b15e@caviumnetworks.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 21, 2018 at 02:58:13PM +0530, George Cherian wrote:
> I will explain the setup used
> To the Cavium ThunderX RC the following PLX device is connected.
> PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI Express Gen 3 (8.0 GT/s)
> Switch
> There is no device connected downstream to the PLX switch.
> 
> AFAIU the pcie_port driver probes PLX and enters autosuspend after 100ms
> since pci_bridge_d3_possible() returns true.
> 
> And later pci_sysfs_init() ends up doing a config access of PLX which fails
> with a "synchronous external abort"

Then you're missing a pci_config_pm_runtime_get() in pci_sysfs_init() or
further down in the call stack, rather than a quirk which just papers
over the issue.

Thanks,

Lukas
