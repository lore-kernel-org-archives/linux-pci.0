Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88103C43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 17:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BBF2083A
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 17:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKWeXiop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BBF2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeI2AKt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbeI2AKt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Sep 2018 20:10:49 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FAAA20685;
        Fri, 28 Sep 2018 17:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538156757;
        bh=XJul/8q10cC/oriH02/Lg/6poG9zUlyk0ZDzUYP9ZPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dKWeXiopPh7Pnlu+iUrioCFtROBMeghDEmwKFS89FbgHU8Mq5s80T42t8qq/2TNBH
         tNhGcNIPfutcSRW4yrqApVv3z71gwj6n0OHCI6MHNdjlAx3xK+OZY+IBfYn5MsMxlh
         Ye44+gqHBNTBzDt5OS3J0SfYw0P8G5fKlRQvg5kU=
Date:   Fri, 28 Sep 2018 12:45:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 00/10] PCI: Allow D3cold for PCIe hierarchies
Message-ID: <20180928174556.GD18434@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 13, 2018 at 05:33:12PM +0300, Mika Westerberg wrote:
> Hi all,
> 
> This patch series aims to allow PCIe hierarchies enter D3cold both during
> system sleep and runtime, including PCIe hotplug ports.
> 
> The motivation of this series are recent systems such as Lenovo Thinkpad X1
> Carbon 6th gen and upcoming Dell laptops where the Thunderbolt controller
> is always present in the system (pretty much like what Apple systems have
> been doing for years). Because it is always present it consumes energy so
> it is important to power it off when idle.
> 
> The PCIe root port hosting the Thunderbolt controller and all the connected
> external PCIe devices includes a standard ACPI power resource and related
> methods _PR3, _PR0, _PRW and _DSW that take care of the actual transition
> to D3cold and back to D0.
> 
> With current kernels entering system sleep states leaves the root port into
> D3hot which means the ACPI power resource is still on. This is bad when
> system enters suspend-to-idle (all these systems are s2idle only) because
> the BIOS is not involved and the devices are effectively left on, consuming
> battery unnecessarily.
> 
> Patches 1-4 add D3cold support for system sleep and the subsequent patches
> do the same for runtime PM.
> 
> In case someone wants to try out runtime PM, the xHCI controller that is
> part of the PCIe switch below the root port needs to have runtime PM
> "unblocked" manually (this will be automatic in future).
> 
> For Thinkpad:
> 
>   # echo auto > /sys/bus/pci/devices/0000:3b:00.0/power/control
> 
> For Dell:
> 
>   # echo auto > /sys/bus/pci/devices/0000:39:00.0/power/control
> 
> Note if the root port enters D3cold, running things like 'lspci' brings it
> back t0 D0 (because PCI config space is not accessible in D3cold) so if one
> wants to check out the power state without accidentally bringing the device
> back into D0 needs to do that indirectly. If the root port is 1d.0 power
> state can be checked:
> 
>   # cat /sys/bus/pci/devices/0000:00:1d.0/power/runtime_status
>   suspended
>   # cat /sys/bus/pci/devices/0000:00:1d.0/firmware_node/real_power_state
>   D3cold
> 
> Even if this again revolves around Thunderbolt I think these apply to any
> PCIe system supporting D3cold.
> 
> These patches apply on top of pci.git pci/hotplug. The previus version of
> the series can be viewed here:
> 
>   https://www.spinics.net/lists/linux-acpi/msg83841.html
> 
> Changes from v1:
> 
>   * Updated comment in patch [1/10] according what Rafael suggested
>   * Added empty line in patch [2/10]
>   * Check for !pciehp_poll_mode in [4/10]
>   * Use DPM_FLAG_NEVER_SKIP instead of DPM_FLAG_SMART_PREPARE which
>     simplifies patch [5/10] signicantly 
>   * Use const in acpi_data_get_property() and change int -> unsigned int
>     in patch [9/10]
>   * Added tags 
> 
> Mika Westerberg (10):
>   PCI: Do not skip power managed bridges in pci_enable_wake()
>   PCI / ACPI: Enable wake automatically for power managed bridges
>   PCI: pciehp: Disable hotplug interrupt during suspend
>   PCI: pciehp: Do not handle events if interrupts are masked
>   PCI: portdrv: Resume upon exit from system suspend if left runtime suspended
>   PCI: portdrv: Add runtime PM hooks for port service drivers
>   PCI: pciehp: Implement runtime PM callbacks
>   PCI/PME: Implement runtime PM callbacks
>   ACPI / property: Allow multiple property compatible _DSD entries
>   PCI / ACPI: Whitelist D3 for more PCIe hotplug ports
> 
>  drivers/acpi/property.c           | 97 ++++++++++++++++++++++---------
>  drivers/acpi/x86/apple.c          |  2 +-
>  drivers/gpio/gpiolib-acpi.c       |  2 +-
>  drivers/pci/hotplug/pciehp.h      |  2 +
>  drivers/pci/hotplug/pciehp_core.c | 37 ++++++++++++
>  drivers/pci/hotplug/pciehp_hpc.c  | 16 ++++-
>  drivers/pci/pci-acpi.c            | 57 +++++++++++++++++-
>  drivers/pci/pci.c                 | 18 +++++-
>  drivers/pci/pci.h                 |  3 +
>  drivers/pci/pcie/pme.c            | 27 +++++++++
>  drivers/pci/pcie/portdrv.h        |  4 ++
>  drivers/pci/pcie/portdrv_core.c   | 20 +++++++
>  drivers/pci/pcie/portdrv_pci.c    | 14 ++---
>  include/acpi/acpi_bus.h           |  8 ++-
>  include/linux/acpi.h              |  9 +++
>  15 files changed, 273 insertions(+), 43 deletions(-)

Applied the whole series (not just 01/10, which I applied by itself for
some reason) to pci/hotplug for v4.20, thanks!
