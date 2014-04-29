Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 29 Apr 2014 12:20:13 +0200
From: Borislav Petkov <bp@suse.de>
To: Andreas Herrmann <herrmann.der.user@googlemail.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Robert Richter <rric@kernel.org>,
	Myron Stowe <myron.stowe@gmail.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>,
	linux-pci <linux-pci@vger.kernel.org>, kim.naru@amd.com,
	Daniel J Blueman <daniel@numascale.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
	Steffen Persvold <sp@numascale.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Jan Beulich <JBeulich@suse.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v2 2/5] x86/PCI: Support additional MMIO range
 capabilities
Message-ID: <20140429102013.GA4726@pd.tnic>
References: <20140419025308.2408.51252.stgit@amt.stowe>
 <20140419025323.2408.88764.stgit@amt.stowe>
 <20140419135219.GC8109@pd.tnic>
 <20140420075936.GA19672@pd.tnic>
 <CAL-B5D1rJmf9vLSnV2izsXcbCu1idXsTsnSwoFRKFNTM7BnyfA@mail.gmail.com>
 <20140426091031.GA10166@pd.tnic>
 <CAErSpo4Jqo_opj=QqjcquS_6HqckZfP5-oQHkmY5FSAyyLNYMg@mail.gmail.com>
 <20140428214036.GA32143@pd.tnic>
 <20140429073309.GE10997@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140429073309.GE10997@alberich>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 29, 2014 at 09:33:09AM +0200, Andreas Herrmann wrote:
> I am sure, it's because some server systems had MMIO ECS access not
> enabled in BIOS. I can't remember which systems were affected.

Ok, now AMD people: what's the story with IO ECS, can we assume that on
everything after F10h, BIOS has a sensible MCFG and we can limit this to
F10h only? I like Bjorn's idea but we need to make sure a working MCFG
is ubiquitous.

Which begs the real question: Suravee, why are you even touching IO ECS
provided F15h and later have a MCFG? Or, do they?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
