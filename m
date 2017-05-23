Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 23 May 2017 12:17:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: [PATCH v4 0/2] Tango PCIe controller support
Message-ID: <20170523171758.GC24431@bhelgaas-glaptop.roam.corp.google.com>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
MIME-Version: 1.0
In-Reply-To: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mason <slash.tmp@free.fr>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Liviu Dudau <liviu.dudau@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 David Laight <david.laight@aculab.com>, Thomas Gleixner <tglx@linutronix.de>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 20, 2017 at 04:24:39PM +0200, Marc Gonzalez wrote:
> Hello,
> 
> This patch was split in two, to ease review of two orthogonal
> parts (MSI controller and host bridge). NB: the patch is
> just split in two where host bridge support starts.

The split is backwards.  The first patch should add basic host bridge
support that is functional, though lacking MSI support.  The second should
add the MSI support.

> Changes from v3 to v4
> 
> In the MSI part:
> - Support 256 MSIs instead of only 32
> - Define tango_{ack,mask,unmask} callbacks for the HW irq_chip
> - Use a spinlock instead of a mutex
> - Rename msi_mask register to msi_enable
> 
> In the host bridge part:
> - Move several quirk-handling snippets out of the config space read function
> - Check whether the PCIe link is up at probe-time
> 
> Other files
> - Let the framework compute the bus-range from the config space width
> - Be slightly more verbose in the Kconfig help
> 
> 
> What has *not* changed, waiting from feedback from Bjorn:
> 
> - Pray that config and mem space accesses NEVER occur concurrently.

This is a pretty major issue that needs to be addressed in a more
concrete way than praying.  

> - Using of_device_is_compatible() vs of_device_get_match_data()
> 
> 
> Marc Gonzalez (2):
>   PCI: Add tango MSI controller support
>   PCI: Add tango PCIe host bridge support
> 
>  Documentation/devicetree/bindings/pci/tango-pcie.txt |  32 ++++
>  drivers/pci/host/Kconfig                             |   8 +
>  drivers/pci/host/Makefile                            |   1 +
>  drivers/pci/host/pcie-tango.c                        | 393 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h                              |   2 +
>  5 files changed, 436 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-tango.c
> 
> -- 
> 2.11.0

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
