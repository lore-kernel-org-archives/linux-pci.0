Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20120106084901.GD14188@elte.hu>
References: <20120105212719.3965.40406.stgit@bhelgaas.mtv.corp.google.com>
 <20120105212724.3965.30193.stgit@bhelgaas.mtv.corp.google.com>
 <CAErSpo6=yHFspY_L0rQa6iVD692nYyL=BR=3qBwc3UV8M16xbw@mail.gmail.com> <20120106084901.GD14188@elte.hu>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 6 Jan 2012 10:18:49 -0700
Message-ID: <CAErSpo57X-rqHgGPk0JsLLjNOAd9TKPSXotx7srcavuSEdCS0w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PNP: work around Dell 1536/1546 BIOS MMCONFIG bug
 that breaks USB
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, thuban@singularity.fr,
	dann frazier <dann.frazier@canonical.com>,
	Lisa Salimbas <lisa.salimbas@canonical.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 6, 2012 at 1:49 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Bjorn Helgaas <bhelgaas@google.com> wrote:
>
>> On Thu, Jan 5, 2012 at 2:27 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> > Some Dell BIOSes have MCFG tables that don't report the entire
>> > MMCONFIG area claimed by the chipset.  If we move PCI devices into
>> > that claimed-but-unreported area, they don't work.
>> >
>> > This quirk reads the AMD MMCONFIG MSRs and adds PNP0C01 resources as
>> > needed to cover the entire area.
>>
>> PNP stuff usually goes through Len's ACPI tree, but this is
>> really x86-specific, and these two patches need to go
>> together, so I think it would make sense to put them both in
>> the x86 tree.  Len, do you object?
>
> I'd really suggest the PCI tree for this - mmconfig is really
> PCI related.

OK, Jesse, would you like to pick up these two patches?

Bjorn
