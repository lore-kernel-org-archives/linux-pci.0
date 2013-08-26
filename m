Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:59463 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab3HZPi3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2013 11:38:29 -0400
Date: Mon, 26 Aug 2013 11:38:21 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: root <root@dhcp47-16.lab.bos.redhat.com>,
	Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: Fix osc flag setup ordering to allow pcie
 hotplug use when available
Message-ID: <20130826153821.GB30662@hmsreliant.think-freely.org>
References: <1377278379-9054-1-git-send-email-nhorman@tuxdriver.com>
 <1377531381-14695-1-git-send-email-nhorman@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1377531381-14695-1-git-send-email-nhorman@tuxdriver.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 26, 2013 at 11:36:21AM -0400, Neil Horman wrote:
> From: root <root@dhcp47-16.lab.bos.redhat.com>
> 
> Somewhere between 3.9 and 3.10 it seems the order in which pcie and acpi probed
> slots for hotplug capabilites got reversed.  While this isn't a big deal, it did
> uncover a bug in the ACPI bus setup path.  Specifically, acpi_pci_root_add calls
> pci_acpi_scan_root before setting the osc flags for the device handle.
> pci_acpi_scan_root, among other things uses device_is_managed_by_native_pciehp()
> to determine if a given slot has pcie hotplug capabilties, whcih checks the
> devices OSC_PCI_EXPRESS_NATIVE_HP_CONTROL flag.  Since that flag is not set
> until after pci_acpi_scan_root_completes, the acpi code never sees that pcie
> slots are hotplug capable and configures them all to use acpi instead.
> 
> Fix is pretty simple, just defer the scan until after the osc flags have been
> set on the device.  Tested by myself and it seems to work well.
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> CC: Len Brown <lenb@kernel.org>
> CC: "Rafael J. Wysocki" <rjw@sisk.pl>
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: linux-acpi@vger.kernel.org
> CC: linux-pci@vger.kernel.org
> 
Sorry, self NAK on this, sorry, I forgot to fix up authorship from my
development machine.  I'll resend in a second.
Neil
