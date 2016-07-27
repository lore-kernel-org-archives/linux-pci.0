Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34600 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757365AbcG0VqV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Jul 2016 17:46:21 -0400
Date: Wed, 27 Jul 2016 16:46:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.or>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, john_mazzie@dell.com,
	Mark Wenning <mark.wenning@canonical.com>
Subject: Re: [Regression][3.18-rc1 -> mainline] PCI: Configure *all* devices,
 not just hot-added ones
Message-ID: <20160727214616.GA23857@localhost>
References: <5798FC1C.40405@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5798FC1C.40405@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 27, 2016 at 02:23:24PM -0400, Joseph Salisbury wrote:
> A kernel bug report was opened against Ubuntu [0].  After a kernel
> bisect, it was found that reverting the following commit resolved this bug:
> 
> commit 1302fcf0d03e6ea74846c7fee14736306ab2ce4b
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date: Sat Aug 30 07:23:01 2014 -0600
> 
>     PCI: Configure *all* devices, not just hot-added ones
> 
> The regression was introduced as of v3.18-rc1 and the bug still exists
> in current mainline.
> 
> [0] http://pad.lv/1571798

I added the following response to the Launchpad bug report; pasting it
here for better visibility:

The register in question is the Advanced Error Capabilities and
Control register, at offset 0x18 in the Advanced Error Reporting
capability, which starts at 0x148 in the config space of device
80:02.0.

In the pre-boot value of 0x00a0, the following bits are set (per PCIe
spec r3.0, sec 7.10.7, these bits are read-only):

  PCI_ERR_CAP_ECRC_GENC 0x00000020 /* ECRC Generation Capable */
  PCI_ERR_CAP_ECRC_CHKC 0x00000080 /* ECRC Check Capable */

In the value of 0x01e0 after Linux boots, the following additional
bits are set:

  PCI_ERR_CAP_ECRC_GENE 0x00000040 /* ECRC Generation Enable */
  PCI_ERR_CAP_ECRC_CHKE 0x00000100 /* ECRC Check Enable */

Linux is setting these bits in program_hpp_type2() because there is
apparently an ACPI _HPX method that applies to this device, and it
returns a PCI Express setting record (ACPI spec 5.0, sec 6.2.8.3) with
an "Advanced Error Capabilities and Control Register OR Mask" that has
PCI_ERR_CAP_ECRC_GENE and PCI_ERR_CAP_ECRC_CHKE set.

Can you collect an ACPI dump to confirm that this is the case?

As I mentioned in the 1302fcf0d03e changelog, it's not completely
clear from the spec (ACPI 5.0, sec 6.2.8) when to apply these _HPX
settings. It says OSPM should use them to "configure devices not
configured by the platform firmware during initial system boot." The
question is how OSPM can tell whether a device has been configured by
platform firmware.

Since I don't know how to tell if a device has been configured by
platform firmware, I chose to apply the _HPX settings to *all*
devices.

Any BIOS folks want to suggest a way to tell whether firmware has
configured a device?
