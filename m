Return-Path: <ak@linux.intel.com>
Return-Path: <ak@linux.intel.com>
Date: Mon, 9 May 2016 13:34:24 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Myron Stowe <mstowe@redhat.com>, x86@kernel.org
Subject: Re: [PATCH] x86/PCI: Fix Broadwell-EP Home Agent & PCU non-compliant
 BARs
Message-ID: <20160509203424.GK11177@tassilo.jf.intel.com>
References: <1462818195-6533-1-git-send-email-prarit@redhat.com>
 <20160509192030.GA18166@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160509192030.GA18166@localhost>
List-ID: <linux-pci.vger.kernel.org>

> > The first is that there is another device, Home Agent 1 & PCU, that must
> > also be quirked in the same way.
> > 
> > \# lspci -n -s 7f:12.4
> > 7f:12.4 0880: 8086:6f60 (rev 01)

I think I had this in the later versions of my patches.
Perhaps the second ID got lost somewhere when the patches
got changed around. Change looks good to me.

> 
> I think we should split this into two patches: one to add quirks for
> the Home Agent 1 & PCU, and a second for the resource assignment
> issue.
> 
> Can you dig up a spec for these devices?  I should have asked Andi for
> that the first time around, but I didn't.  Maybe there's something
> we're not interpreting correctly.  I still have a hard time believing
> that Intel would produce a PCI device with non-BAR registers where the
> BARs are supposed to be.  Maybe there's supposed to be an EA
> capability or something that tells us to ignore these registers.

It's not a real register, but due to a hardware problem it
still returns non zero on reads.

The issue is documented in the Xeon v4 specification update (but unfortunately
missing the second device ID there)

http://www.intel.com/content/www/us/en/processors/xeon/xeon-e5-v4-spec-update.html

BDF2
PCI BARs in the Home Agent Will Return Non-Zero Values During 
Enumeration
Problem:
During system initialization the Operating System may access the standard PCI BARs 
(Base Address Registers). Due to this erratum, accesses to the Home Agent BAR 
registers (Bus 1; Device 18; Function 0,4; Offsets 0x14-0x24) will return non-zero 
values.
Implication:
The operating system may issue a warning. Intel has not observed any functional 
failures due to this erratum.
Workaround:
None identified.

-Andi
