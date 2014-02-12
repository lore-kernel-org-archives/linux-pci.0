Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:34984 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaBLVvw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2014 16:51:52 -0500
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host controller
From: Kumar Gala <galak@codeaurora.org>
In-Reply-To: <1392236171-10512-4-git-send-email-will.deacon@arm.com>
Date: Wed, 12 Feb 2014 15:51:48 -0600
Cc: linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	jgunthorpe@obsidianresearch.com
Message-Id: <D2AE4AE6-E8FA-4DD8-B92B-E37205A2548C@codeaurora.org>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com> <1392236171-10512-4-git-send-email-will.deacon@arm.com>
To: Will Deacon <will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On Feb 12, 2014, at 2:16 PM, Will Deacon <will.deacon@arm.com> wrote:

> This patch adds support for a generic PCI host controller, such as a
> firmware-initialised device with static windows or an emulation by
> something such as kvmtool.
> 
> The controller itself has no configuration registers and has its address
> spaces described entirely by the device-tree (using the bindings from
> ePAPR). Both CAM and ECAM are supported for Config Space accesses.
> 
> Corresponding documentation is added for the DT binding.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
> .../devicetree/bindings/pci/arm-generic-pci.txt    |  51 ++++
> drivers/pci/host/Kconfig                           |   7 +
> drivers/pci/host/Makefile                          |   1 +
> drivers/pci/host/pci-arm-generic.c                 | 318 +++++++++++++++++++++
> 4 files changed, 377 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/pci/arm-generic-pci.txt
> create mode 100644 drivers/pci/host/pci-arm-generic.c
> 
> diff --git a/Documentation/devicetree/bindings/pci/arm-generic-pci.txt b/Documentation/devicetree/bindings/pci/arm-generic-pci.txt
> new file mode 100644
> index 000000000000..cc7a35ecfa2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/arm-generic-pci.txt
> @@ -0,0 +1,51 @@
> +* ARM generic PCI host controller
> +
> +Firmware-initialised PCI host controllers and PCI emulations, such as the
> +virtio-pci implementations found in kvmtool and other para-virtualised
> +systems, do not require driver support for complexities such as regulator and
> +clock management. In fact, the controller may not even require the
> +configuration of a control interface by the operating system, instead
> +presenting a set of fixed windows describing a subset of IO, Memory and
> +Configuration Spaces.
> +
> +Such a controller can be described purely in terms of the standardized device
> +tree bindings communicated in pci.txt:
> +
> +- compatible     : Must be "arm,pci-cam-generic" or "arm,pci-ecam-generic"
> +                   depending on the layout of configuration space (CAM vs
> +                   ECAM respectively)

What’s arm specific here?  I don’t have a great suggestion, but seems odd for this to be vendor prefixed with "arm".

> +
> +- ranges         : As described in IEEE Std 1275-1994, but must provide
> +                   at least a definition of one or both of IO and Memory
> +                   Space.
> +
> +- #address-cells : Must be 3
> +
> +- #size-cells    : Must be 2
> +
> +- reg            : The Configuration Space base address, as accessed by the
> +                   parent bus.

Isn’t the size fixed here for cam or ecam?

> +
> +Configuration Space is assumed to be memory-mapped (as opposed to being
> +accessed via an ioport) and laid out with a direct correspondence to the
> +geography of a PCI bus address by concatenating the various components to form
> +an offset.
> +
> +For CAM, this 24-bit offset is:
> +
> +        cfg_offset(bus, device, function, register) =
> +                   bus << 16 | device << 11 | function << 8 | register
> +
> +Whilst ECAM extends this by 4 bits to accomodate 4k of function space:
> +
> +        cfg_offset(bus, device, function, register) =
> +                   bus << 20 | device << 15 | function << 12 | register
> +
> +Interrupt mapping is exactly as described in `Open Firmware Recommended
> +Practice: Interrupt Mapping' and requires the following properties:
> +
> +- #interrupt-cells   : Must be 1
> +
> +- interrupt-map      : <see aforementioned specification>
> +
> +- interrupt-map-mask : <see aforementioned specification>

Examples are always nice :)

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

