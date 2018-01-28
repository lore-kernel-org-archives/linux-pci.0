Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 28 Jan 2018 15:47:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com,
        stelford@cadence.com, dgary@cadence.com, kgopi@cadence.com,
        eandrews@cadence.com, thomas.petazzoni@free-electrons.com,
        sureshp@cadence.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 00/11] PCI: Add support to the Cadence PCIe controller
Message-ID: <20180128214741.GA232763@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1517170521.git.cyrille.pitchen@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 28, 2018 at 09:40:14PM +0100, Cyrille Pitchen wrote:
> Hi all,
> 
> this series of patches adds support to the Cadence PCIe controller.
> It was tested on a ARM64 platform emulated by a Palladium running the
> pci-next kernel.
> 
> The host mode was tested with some PCIe devices connected to the Palladium
> through a speed-bridge. Some of those devices were a USB host controller
> and a SATA controller. The PCIe host controller was also tested with a
> second controller configured in endpoint mode and connected back to back
> to the first controller.
> 
> The EndPoint Controller (EPC) driver was tested with 2 PCI functions, both
> handled by the pci-epf-test driver, using the pcitest userspace program.
> I used the "-D" optional command line parameter to select the proper PCI
> function.
> 
> Best regards,
> 
> Cyrille
> 
> ChangeLog
> 
> v4 -> v5:
> - rebase on today's (20180128) linux-pci/next

Don't bother rebasing onto linux-pci/next.

If your patches actually *depend* on something that has already been
merged onto a PCI topic branch, you should mention that and say which
branch.

But otherwise, it's easiest if they are based on linux-pci/master,
because that's how Lorenzo and I apply them.

linux-pci/next is ephemeral and I frequently rebuild it to fix errors,
add acks, etc.

It doesn't *hurt* that you rebased, but it doesn't help anything
either, and it's a little needless work for you.

Bjorn
