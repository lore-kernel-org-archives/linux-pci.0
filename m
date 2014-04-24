Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20140424072021.GA3396@gmail.com>
References: <20140421221721.26308.1891.stgit@bhelgaas-glaptop.roam.corp.google.com>
	<CABPqkBRVfajbeWeaZRmv6SSWcX7DAuGCxfmrHGiUTPkbfxVMWg@mail.gmail.com>
	<20140424072021.GA3396@gmail.com>
Date: Thu, 24 Apr 2014 11:41:17 +0200
Message-ID: <CABPqkBSpgYO9nxL67mmEOSg7tgssey4_ikdF_8-Vxn7u92suGg@mail.gmail.com>
Subject: Re: [PATCH 2] PNP: Work around BIOS defects in Intel MCH area reporting
From: Stephane Eranian <eranian@google.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Aaron Lu <aaron.lu@intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>, x86 <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Zheng Z Yan <zheng.z.yan@intel.com>,
	Dave Jones <davej@redhat.com>, Rui Zhang <rui.zhang@intel.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 24, 2014 at 9:20 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Stephane Eranian <eranian@google.com> wrote:
>
>> On Tue, Apr 22, 2014 at 12:17 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> > Work around BIOSes that don't report the entire Intel MCH area.
>> >
>> > MCHBAR is not an architected PCI BAR, so MCH space is usually reported as a
>> > PNP0C02 resource.  The MCH space was once 16KB, but is 32KB in newer parts.
>> > Some BIOSes still report a PNP0C02 resource that is only 16KB, which means
>> > the rest of the MCH space is consumed but unreported.
>> >
>> > This can cause resource map sanity check warnings or (theoretically) a
>> > device conflict if we assigned the unreported space to another device.
>> >
>> > The Intel perf event uncore driver tripped over this when it claimed the
>> > MCH region:
>> >
>> >   resource map sanity check conflict: 0xfed10000 0xfed15fff 0xfed10000 0xfed13fff pnp 00:01
>> >   Info: mapping multiple BARs. Your kernel is fine.
>> >
>> > To prevent this, if we find a PNP0C02 resource that covers part of the MCH
>> > space, extend it to cover the entire space.
>> >
>> Works for me on my Levono IvyBridge laptop.
>> Thanks for fixing this, Bjorn.
>> Acked-by: Stephane Eranian <eranian@google.com>
>
> Just curious, what problems triggered on your laptop: only the
> warnings, or did something get mapped to the undeclared area,
> causing other misbehavor?
>
In my case, it was just the warning. Everything appeared to worked correctly.
