Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 13 Apr 2017 10:42:58 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 1/2] drivers: pci: do not disregard parent resources
 starting at 0x0
Message-ID: <20170413094258.GA12432@red-moon>
References: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
 <20170411163313.18577-2-ard.biesheuvel@linaro.org>
 <20170412132423.GA6584@red-moon>
 <CAKv+Gu9JrU=-SZQcTtFfOP423gVTyM1w9yF=_J1uGd74ntpwLw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9JrU=-SZQcTtFfOP423gVTyM1w9yF=_J1uGd74ntpwLw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Graeme Gregory <graeme.gregory@linaro.org>,
 linux-pci <linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Sinan Kaya <okaya@codeaurora.org>,
 Tomasz Nowicki <tn@semihalf.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Yinghai Lu <yinghai@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 13, 2017 at 08:39:12AM +0100, Ard Biesheuvel wrote:
> On 12 April 2017 at 14:24, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > [+Yinghai, Bjorn]
> >
> > On Tue, Apr 11, 2017 at 05:33:12PM +0100, Ard Biesheuvel wrote:
> >> Commit f44116ae8818 ("PCI: Remove pci_find_parent_resource() use for
> >> allocation") updated the logic that iterates over all bus resources
> >> and compares them to a given resource, in order to decide whether one
> >> is the parent of the latter.
> >>
> >> This change inadvertently causes pci_find_parent_resource() to disregard
> >> resources starting at address 0x0, resulting in an error such as the one
> >> below on ARM systems whose I/O window starts at 0x0.
> >>
> >> pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff window]
> >> pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
> >> pci_bus 0000:00: root bus resource [mem 0x8000000000-0xffffffffff window]
> >> pci_bus 0000:00: root bus resource [bus 00-0f]
> >> pci 0000:00:01.0: PCI bridge to [bus 01]
> >> pci 0000:00:02.0: PCI bridge to [bus 02]
> >> pci 0000:00:03.0: PCI bridge to [bus 03]
> >> pci 0000:00:03.0: can't claim BAR 13 [io  0x0000-0x0fff]: no compatible bridge window
> >> pci 0000:03:01.0: can't claim BAR 0 [io  0x0000-0x001f]: no compatible bridge window
> >>
> >> While this never happens on x86, it is perfectly legal in general for a
> >> PCI MMIO or IO window to start at address 0x0, and it was supported in
> >> the code before commit f44116ae8818.
> >>
> >> So let's drop the test for res->start != 0; resource_contains() already
> >> checks whether [start, end) completely covers the resource, and so it
> >> should be redundant.
> >>
> >> Fixes: f44116ae8818 ("PCI: Remove pci_find_parent_resource() use for allocation")
> >
> > I know this code fixes IO claiming on ARM/ARM64 (well, it fixes nothing
> > because we never claim resources on ARM/ARM64 apart from kvmtool and
> > generic host bridge), my _big_ worry is that it can cause endless
> > regressions on other arches, in any case I would be really really
> > careful about adding a Fixes: tag to it.
> >
> 
> The patch is only 3 years old, and is obviously a regression given
> that the change in behavior described here occurs as a side effect.

I agree with you that res->start usage changed with f44116ae8818 but
I am not sure you can call that a regression unless we prove there
was some code relying on the previous behaviour (and it is not just
x86).

Anyway, I am happy to put these two patches (with some tweaks on patch
2) on a branch for testing on ARM64 ACPI platforms to see the best
way forward.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
