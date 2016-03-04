Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 4 Mar 2016 10:55:17 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com,
	rafael@kernel.org, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, yinghai@kernel.org
Subject: Re: [PATCH V5 00/15] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Message-ID: <20160304105517.GA30693@red-moon>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <56D49611.2050202@codeaurora.org>
 <20160303112332.GC28359@red-moon>
 <56D84938.6020102@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56D84938.6020102@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 03, 2016 at 09:24:56AM -0500, Sinan Kaya wrote:
> On 3/3/2016 6:23 AM, Lorenzo Pieralisi wrote:
> > x86 and IA64 claim PCI resources on boot and live with that (well, minus
> > the gazillions x86 pci= parameters that change the PCI resources assignment
> > one way or another), comments very welcome in particular on the pci=realloc
> > option and its usage.
> 
> I have been working with Linux PCIe over 3 years. I never used
> pci=realloc argument.
> 
> The v5 series minus [PATCH V5 11/15] drivers: pci: add generic code to
> claim bus resources is working just fine and is ready to go upstream
> in my opinion. It passed my internal testing with different types of
> endpoints.
> 
> The inclusion of this patch is now requiring everybody to add
> pci=realloc argument otherwise the resources assigned by the UEFI BIOS
> are not working.
> 
> I think there is still some work to be done in this patch and is too
> early to be included into the series. It is blocking progress of the
> series which is sitting on review over 1 year already.

First off, I think that's specious, patch 11 is not blocking anything,
if you and Tomasz want to drop it go ahead and take responsibility
of the consequences.

I am not saying patch 11 is perfect, it is there to review, if you
spot bugs point them out.

If you are interested and willing to make an effort to understand why I
asked Tomasz to integrate it, a bit of background here:

http://permalink.gmane.org/gmane.linux.kernel.pci/44830

If we want to drop patch 11, we are going to discard whatever FW
set-up at FW/OS hand-off and reassign everything. Want to do it ?
Go ahead.

I wrote it in my previous email, probably it was not clear, so, here we
go again.

If we want to at least consider the FW PCI configuration at FW/OS
handoff, we should read the PCI bridge apertures and claim them, when
that fails reassign the corresponding PCI bus hierarchy (which means
releasing the bridge resources and downstream devices and reassign
them), that's what pci=realloc does.

I think that it is a command line option since it has to be a choice,
ie overriding FW set-up should be an option, not a default.

Patch 11 does what x86 does in arch code arch/x86/pci/i386.c,

pcibios_resource_survey()

and that works for them (of course, minus quirks that do exist).

I could integrate the code implementing pci=realloc in patch 11 so
that we realloc by default all resources claimed that failed (which
means that bridges are resized accordingly and you won't be forced
to use pci=realloc on command line).

> [    0.752916] pci 0000:01:00.0: VF(n) BAR2 space: [mem 0x80360800000-0x8037fffffff 64bit pref] (contains BAR2 for 63 VFs)
> [    0.771799] pci 0000:00:00.0: PCI bridge to [bus 01-06]
> [    0.777054] pci 0000:00:00.0: root [mem 0x80100100000-0x8013fffffff window] res [mem 0x8013ff00000-0x8013fffffff] nr 14
> [    0.787846] pci 0000:00:00.0: pci_claim_bridge_resource:714 1: i:14
> [    0.794135] pci 0000:00:00.0: root [mem 0x80300000000-0x8037fffffff window] res [mem 0x80360000000-0x8037fffffff 64bit pref] nr 15
> [    0.805881] pci 0000:00:00.0: pci_claim_bridge_resource:714 1: i:15
> [    0.812155] pci 0000:01:00.0: root [mem 0x8013ff00000-0x8013fffffff] res [mem 0x8013ff00000-0x8013fffffff 64bit] nr 0
> [    0.822773] pci 0000:01:00.0: root [mem 0x80360000000-0x8037fffffff 64bit pref] res [mem 0x80360000000-0x803607fffff 64bit pref] nr 2
> [    0.834778] pci 0000:01:00.0: root [mem 0x80360000000-0x8037fffffff 64bit pref] res [mem 0x8037ff00000-0x8037fffffff pref] nr 6
> [    0.846265] pci 0000:01:00.0: can't claim BAR 9 [mem 0x80360800000-0x8037fffffff 64bit pref]: address conflict with 0000:01:00.0 [mem 0x8037ff00000-0x8037fffffff pref]
> [    0.861237] pci 0000:01:00.0: BAR 9: no space for [mem size 0x1f800000 64bit pref]
> [    0.868811] pci 0000:01:00.0: BAR 9: failed to assign [mem size 0x1f800000 64bit pref]
> 
> 
> I keep saying this but the type of CPU is not important when it comes
> to PCIe. Both PCIe and ACPI are governed by specs. If it is working
> for x86 and i64; it needs to work for ARM64 as well.

That's theory. In practice there is massive legacy there and PCI resource
assignment is carried out in an arch specific way (otherwise there would
be no pci claiming/assignment code in arch/* right ?) and the resource
claiming/assignment strictly depends on FW set-up, like it or lump it,
that's the way it *currently* is.

I wrote in my previous email, the status of PCI resources at OS/FW
handoff is not strictly mandated by the PCI standard AFAIK (it is
covered by 3.5 "Device state at Firmware/Operating System Handoff" in
the PCI FW spec revision 3.1), so what I suggest above is the only option
we have (or you just discard FW configuration altogether, that's what
happens if all PCI resources are reassigned, it is a choice to be made
and it is neither correct nor wrong, I wish it would).

> Even ARM64 has the luxury to omit the old BIOS behaviors. Most ARM64
> systems use tianocore based UEFI BIOS.
> 
> This is pointing to an implementation problem in arm64 adaptation.
> Need to figure out what is different.

Look no further, firmware is different. How do we want to proceed ?

Lorenzo
