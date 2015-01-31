Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:38872 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbbAaO4X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 31 Jan 2015 09:56:23 -0500
Received: by mail-oi0-f42.google.com with SMTP id i138so38640631oig.1
        for <linux-pci@vger.kernel.org>; Sat, 31 Jan 2015 06:56:22 -0800 (PST)
Date: Sat, 31 Jan 2015 08:56:11 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: matt@masarand.com
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH V3] Delay allocation of PCI device IRQs from boot time
 until bus scan time to fix PCI hotplugging
Message-ID: <20150131145611.GA23416@google.com>
References: <1412222866-21068-1-git-send-email-matt@masarand.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412222866-21068-1-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 02, 2014 at 05:07:28AM +0100, matt@masarand.com wrote:
> Sorry, the previous submission was damaged by my editor which purged the sign off lines from the patches,
> this is a fixed version.
> 
> pci_fixup_irqs is the current method used in most arches to assign IRQs to
> PCI devices. This has a number of flaws including it requiring an extra walk
> of the PCI bus and most importantly not running for devices which are added
> after boot time, this includes hot-added devices on boards that support this.
> 
> This patch set modifies the IRQ mapping and swizzling infrastructure
> such that functions are registered by the boot code (instead of being
> run directly by the boot code) and then run later in the enable_device
> path such that it will apply to all devices and not only those inserted
> at boot time.
> 
> This is cleaner as it unifies how each architecture allocates PCI IRQs as much
> as possible (some arches were particularly resistant to these changes so some
> work-arounds have been used or the change disabled completely).
> 
> The caveat here is that I have been forced to modify some architecture specific
> code for various architectures which I cannot test due to not having such boards
> available. The code seems correct and the changes in most cases are small and
> trivial however I have not tested all the patches for rare arches.
> 
> NEW: Since the last version all changes and suggested bug fixes have been implemented
> the patch-set has also been rebased onto the latest kernel version to ease merging.

Hi Matthew,

I'm not sure where we are with this.  This has a lot of good fixes that I'd
like to merge, but I think there were some comments that needed to be
addressed.  But I might have missed something, so I'm just checking to see
if I accidentally dropped the ball.

Bjorn
