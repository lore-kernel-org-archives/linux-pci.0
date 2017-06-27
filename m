Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753605AbdF0Vbt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jun 2017 17:31:49 -0400
Date: Tue, 27 Jun 2017 16:31:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Anvin <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [patch 7/7] x86/pci/mmcfg: Switch to ECAM config mode if possible
Message-ID: <20170627213146.GF764@bhelgaas-glaptop.roam.corp.google.com>
References: <20170316215002.726697858@linutronix.de>
 <20170316215057.452220163@linutronix.de>
 <20170317002656.GO32070@tassilo.jf.intel.com>
 <alpine.DEB.2.20.1703170709300.3701@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1703170709300.3701@nanos>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Fri, Mar 17, 2017 at 07:15:21AM +0100, Thomas Gleixner wrote:
> On Thu, 16 Mar 2017, Andi Kleen wrote:
> 
> > > +	/*
> > > +	 * The pointer to root_pci_ops has been handed in to ACPI already
> > > +	 * and is already set in the busses.
> > > +	 *
> > > +	 * Switch the functions over to ECAM for all config space accesses.
> > > +	 */
> > > +	pci_root_ops.read = pci_ecam_read;
> > > +	pci_root_ops.write = pci_ecam_write;
> > > +	pr_info("PCI: Switch to ECAM configuration mode\n");
> > 
> > That patch is fine, but it's generally called MMCONFIG (don't know
> > where this ECAM term comes from).
> 
> ECAM is the official name for the memory mapped configuration mechanism
> according to the PCI express specification.
> 
> > So please use MMCONFIG or MCFG everywhere, not ECAM.
> 
> While I prefer using names which match specifications, I let Bjorn decide
> on that one.

I've definitely seen "MMCONFIG" used many places, especially
internally.  I've been trying to use names that correspond to the
public specs in an arch-independent way, so here's my thinking:

"MCFG" is the ACPI table name and appears in the PCI Firmware spec.
The x86-specific MCFG parser is called arch/x86/pci/mmconfig-shared.c,
but we named the arch-independent parser drivers/acpi/pci_mcfg.c.

"MMCONFIG" appears only in an implementation note in the PCI Firmware
spec r3.2, sec 4.1.4.  The x86 ECAM/MMCONFIG/MCFG code is in
arch/x86/pci/mmconfig*.  I wouldn't name it that way today because I
don't see "MMCONFIG" used much in public specs, but it doesn't seem
worth changing to me.

The PCIe spec doesn't mention MCFG or MMCONFIG, but it uses "ECAM" many
times, so that's what we used for the arch-independent code in
drivers/pci/ecam.c.

Bottom line, I'm fine with the names in this patch as-is.

Bjorn
