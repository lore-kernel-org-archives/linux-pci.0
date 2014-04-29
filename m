Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <535FC269.2000808@amd.com>
Date: Tue, 29 Apr 2014 10:16:57 -0500
From: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@suse.de>,
	Andreas Herrmann <herrmann.der.user@googlemail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Robert Richter <rric@kernel.org>,
	Myron Stowe <myron.stowe@gmail.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>,
	linux-pci <linux-pci@vger.kernel.org>, <kim.naru@amd.com>,
	Daniel J Blueman <daniel@numascale.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
	Steffen Persvold <sp@numascale.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Jan Beulich" <JBeulich@suse.com>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 2/5] x86/PCI: Support additional MMIO range capabilities
References: <20140419025308.2408.51252.stgit@amt.stowe>
 <20140419025323.2408.88764.stgit@amt.stowe> <20140419135219.GC8109@pd.tnic>
 <20140420075936.GA19672@pd.tnic>
 <CAL-B5D1rJmf9vLSnV2izsXcbCu1idXsTsnSwoFRKFNTM7BnyfA@mail.gmail.com>
 <20140426091031.GA10166@pd.tnic>
 <CAErSpo4Jqo_opj=QqjcquS_6HqckZfP5-oQHkmY5FSAyyLNYMg@mail.gmail.com>
 <20140428214036.GA32143@pd.tnic> <20140429073309.GE10997@alberich>
 <20140429102013.GA4726@pd.tnic>
In-Reply-To: <20140429102013.GA4726@pd.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/29/2014 5:20 AM, Borislav Petkov wrote:
> On Tue, Apr 29, 2014 at 09:33:09AM +0200, Andreas Herrmann wrote:
>> I am sure, it's because some server systems had MMIO ECS access not
>> enabled in BIOS. I can't remember which systems were affected.
>
If you are referring to accessing PCI ECS ranges via 0xCF8, then yes, 
BIOS disable this as described below in the BKDG.

"The BIOS may use either configuration space access mechanism during 
boot. Before booting the OS, BIOS must disable IO access to ECS, enable 
MMIO configuration and build an ACPI defined MCFG table. BIOS ACPI code 
must use MMIO to access configuration space."

> Ok, now AMD people: what's the story with IO ECS, can we assume that on
> everything after F10h, BIOS has a sensible MCFG and we can limit this to
> F10h only? I like Bjorn's idea but we need to make sure a working MCFG
> is ubiquitous.
>
> Which begs the real question: Suravee, why are you even touching IO ECS
> provided F15h and later have a MCFG? Or, do they?
>

As I was trying to generalize the logic inside amd_bus.c, which seems to 
be used mainly as a fallback mechanism, I tried to maintain the existing 
code, which does many things:
     1. Setup numa_node information (if PXM doesn't exist)
     2. Probe NB for MMIO resources (if MCFG doesn't exist)
     3. Probe NB for IO resources
     4. Setup IO ECS

In the new code, the IO ECS was needed to retrieve the 
AMD_NB_F1_MMIO_BASE_LIMIT_HI_REG (offset 0x180) during the early 
initialization as part of (2) logic. However, this register exists only 
on the newer systems.  However, as you mentioned, for (2) we can assume 
that the MCFG exists for most of the systems (family10h and later), and 
should be used instead.

The main purpose of this patch set is mainly to deal with the the node 
information (1).  So, we might need to split these all up and handle 
them separately as needed where (2) and (3) will be used as fallback for 
older systems where MCFG does not exist. I am not sure if where we need (4).

Suravee

