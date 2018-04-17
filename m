Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 17 Apr 2018 15:04:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: RFC on MCFG Table Support
Message-ID: <20180417200441.GL28657@bhelgaas-glaptop.roam.corp.google.com>
References: <bd3f4d3a-f641-7385-4ce2-d62a28bc9cd3@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bd3f4d3a-f641-7385-4ce2-d62a28bc9cd3@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 17, 2018 at 12:18:22PM -0400, Sinan Kaya wrote:
> Hi,
> 
> QDT is working with PCI-SIG to revisit some of the spec language
> ambiguity on the definition of PCI Segment Group in PCI FW
> Specification. 

I assume you're looking at the PCI Firmware Spec, r3.2, sec 4.1.2.  I
agree this could use some clarification.

> PCI spec is currently requiring a single entry per segment in the
> MCFG table with a contiguous 256MB range. 

I see the statement that "Multiple [MCFG] entries corresponding to a
single PCI Segment Group is (sic) not allowed."

Since the MCFG entry contains both the start and end bus number, I
assume it only describes a 256MB range if start == 0 and end == 255
(256 buses * 32 devices * 8 functions * 4K config space = 256MB).

If start > 0 or end < 255, I'd say the entry describes a range smaller
than 256MB, and it would be an error to use space outside that range.

But the existing language says you still only get one entry per
segment group.  It seems reasonable to me to relax that restriction.

> Based on our research, this rule is being violated in the industry
> for existing platforms due to the different ways spec is
> interpreted.
> 
> We are trying to remove this restriction in the spec and have
> multiple entries per segment as long as <segment, bus start number,
> bus end number> tuple is unique. 

I hope you mean the <start, end> tuples are more than just unique;
they shouldn't overlap, i.e., a given <segment, bus number> should
match at most one MCFG entry.

I think it is permissible for a <segment, bus number> to not be
described via MCFG at all for the case of hot-plugged host bridges
that use _CBA instead of MCFG.

> AFAIS, generic ACPI Linux driver already supports this via
> pci_mcfg_lookup(). 

Looks like it to me.  And if it doesn't, it sounds reasonable to fix
it so it does.

Of course, pci_mcfg_lookup() is currently only used by arm64.  I
didn't look at x86 or ia64, which also use MCFG, to see what they
would do with this.

Thanks for working on this!

Bjorn
