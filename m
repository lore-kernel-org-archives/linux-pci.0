Return-Path: <SRS0=VV4o=JT=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=VV4o=JT=h08.hostsharing.net=foo00@kernel.org>
Date: Tue, 3 Jul 2018 09:51:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv3 2/4] drivers/base: utilize device tree info to shutdown
 devices
Message-ID: <20180703075106.GA21136@wunner.de>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <1530600642-25090-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530600642-25090-3-git-send-email-kernelfans@gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 03, 2018 at 02:50:40PM +0800, Pingfan Liu wrote:
> commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> places an assumption of supplier<-consumer order on the process of probe.
> But it turns out to break down the parent <- child order in some scene.
> E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> have been probed. Then comes the bridge's module, which enables extra
> feature(such as hotplug) on this bridge. This will break the
> parent<-children order and cause failure when "kexec -e" in some scenario.
> 
> The detailed description of the scenario:
> An IBM Power9 machine on which, two drivers portdrv_pci and shpchp(a mod)
> match the PCI_CLASS_BRIDGE_PCI, but neither of them success to probe due
> to some issue. For this case, the bridge is moved after its children in
> devices_kset. Then, when "kexec -e", a ata-disk behind the bridge can not
> write back buffer in flight due to the former shutdown of the bridge which
> clears the BusMaster bit.

If you revert commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services
during shutdown"), does the issue go away?
