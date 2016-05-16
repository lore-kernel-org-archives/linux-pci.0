Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36754 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbcEPVLs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 May 2016 17:11:48 -0400
Date: Mon, 16 May 2016 16:11:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 0/2 v2] Fix Broadwell-EP Home Agent & PCU non-compliant
 BARs
Message-ID: <20160516211143.GD20759@localhost>
References: <1462984036-32084-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462984036-32084-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 11, 2016 at 12:27:14PM -0400, Prarit Bhargava wrote:
> commit b894157145e4 ("x86/PCI: Mark Broadwell-EP Home Agent & PCU as having
> non-compliant BARs") marks Home Agent 0 & PCU has having non-compliant
> BARs.  commit b84106b4e229 ("PCI: Disable IO/MEM decoding for devices with
> non-compliant BARs") introduces a check for non_compliant_bars to avoid
> assigning resources to the individual BARs for a device.
> 
> Before these commits,
> 
> pci 0000:ff:12.0: BAR 2: failed to assign [mem size 0x00000040]
> pci 0000:ff:12.0: BAR 4: failed to assign [mem size 0x00000040]
> pci 0000:ff:12.4: BAR 2: failed to assign [mem size 0x00000040]
> pci 0000:ff:12.4: BAR 4: failed to assign [mem size 0x00000040]
> pci 0000:ff:12.0: BAR 1: failed to assign [mem size 0x00000010]
> pci 0000:ff:12.0: BAR 3: failed to assign [mem size 0x00000010]
> pci 0000:ff:12.0: BAR 5: failed to assign [mem size 0x00000010]
> pci 0000:ff:12.4: BAR 1: failed to assign [mem size 0x00000010]
> pci 0000:ff:12.4: BAR 3: failed to assign [mem size 0x00000010]
> pci 0000:ff:12.4: BAR 5: failed to assign [mem size 0x00000010]
> pci 0000:7f:12.0: BAR 2: failed to assign [mem size 0x00000040]
> pci 0000:7f:12.0: BAR 4: failed to assign [mem size 0x00000040]
> pci 0000:7f:12.4: BAR 2: failed to assign [mem size 0x00000040]
> pci 0000:7f:12.4: BAR 4: failed to assign [mem size 0x00000040]
> pci 0000:7f:12.0: BAR 1: failed to assign [mem size 0x00000010]
> pci 0000:7f:12.0: BAR 3: failed to assign [mem size 0x00000010]
> pci 0000:7f:12.0: BAR 5: failed to assign [mem size 0x00000010]
> pci 0000:7f:12.4: BAR 1: failed to assign [mem size 0x00000010]
> pci 0000:7f:12.4: BAR 3: failed to assign [mem size 0x00000010]
> pci 0000:7f:12.4: BAR 5: failed to assign [mem size 0x00000010]
> 
> After the commits, there are still "failed to assign" messages,
> as well as new "failed to assign" messages for ff:12.0, ff:1e.3,
> 7f:12.0, and 7f:1e.3.
> 
>  pci 0000:ff:12.4: BAR 2: failed to assign [mem size 0x00000040]
>  pci 0000:ff:12.4: BAR 4: failed to assign [mem size 0x00000040]
>  pci 0000:ff:12.4: BAR 1: failed to assign [mem size 0x00000010]
>  pci 0000:ff:12.4: BAR 3: failed to assign [mem size 0x00000010]
>  pci 0000:ff:12.4: BAR 5: failed to assign [mem size 0x00000010]
>  pci 0000:ff:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
>  pci 0000:ff:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
>  pci 0000:7f:12.4: BAR 2: failed to assign [mem size 0x00000040]
>  pci 0000:7f:12.4: BAR 4: failed to assign [mem size 0x00000040]
>  pci 0000:7f:12.4: BAR 1: failed to assign [mem size 0x00000010]
>  pci 0000:7f:12.4: BAR 3: failed to assign [mem size 0x00000010]
>  pci 0000:7f:12.4: BAR 5: failed to assign [mem size 0x00000010]
>  pci 0000:7f:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
>  pci 0000:7f:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
> 
> There are two issues that need to be fixed.  The first is that there is another
> device, Home Agent 1 & PCU (device ID 0x6f60) that must also be "blacklisted"
> in the same way. After applying the first patch in this patchset the log still
> contains these messages:
> 
> pci 0000:ff:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
> pci 0000:ff:12.4: BAR 6: failed to assign [mem size 0x00000001 pref]
> pci 0000:ff:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
> pci 0000:7f:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
> pci 0000:7f:12.4: BAR 6: failed to assign [mem size 0x00000001 pref]
> pci 0000:7f:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
> 
> This second patch fixes these issues by moving the non_compliant_bars_check to
> pci_read_bases() where it applies to all of a device's BARs.
> 
> v2: Separate into two patches.  Applied non_compliant_bars check to
> pci_read_bases().  Added additional explanation to the commit log from
> the BDW errata for the Home Agent devices.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> 
> Prarit Bhargava (2):
>   x86/PCI: Add pci_bdwep_bar() quirk entry for Broadwell-EP Home Agent
>     1
>   x86/PCI: Disable IO/MEM decoding for ROM BARs for devices with
>     non-compliant BARs
> 
>  arch/x86/pci/fixup.c |    9 +++++++++
>  drivers/pci/probe.c  |    6 +++---
>  2 files changed, 12 insertions(+), 3 deletions(-)

I applied these to pci/resource and intend to merge them for v4.7.
