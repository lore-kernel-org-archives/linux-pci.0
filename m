Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150909151126.GA1366@ulmo.nvidia.com>
References: <20150909151126.GA1366@ulmo.nvidia.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 9 Sep 2015 12:27:38 -0500
Message-ID: <CAErSpo5bAHywkbeBBOsGs3e5ih5rFpPuWBE-sA1pSuAxtNf_MQ@mail.gmail.com>
Subject: Re: Global lock for PCI configuration accesses
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thierry,

On Wed, Sep 9, 2015 at 10:11 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> Hi,
>
> There's currently an issue with PCI configuration space accesses on
> Tegra. The PCI host controller driver's ->map_bus() implementation
> remaps I/O memory on-demand to avoid potentially wasting 256 MiB of
> virtual address space. The reason why this is done is because the
> mapping isn't compatible with ECAM and the extended register number
> is encoded in the uppermost 4 bits. This means that if we want to
> address the configuration space for a single bus we already need to
> map 256 MiB of memory, even if only 1 MiB is really used.
>
> tegra_pcie_bus_alloc() is therefore used to stitch together a 1 MiB
> block of virtual addresses per bus made up of 16 64 KiB chunks each
> so that only what's really needed is mapped.
>
> That function gets called the first time a PCI configuration access
> is performed on a bus. The code calls functions that may sleep, and
> that causes problems because the PCI configuration space accessors
> are called with the global pci_lock held. This works in practice
> but it blows up when lockdep is enabled.
>
> I remember coding up a fix for this using the ARM/PCI ->add_bus()
> callbacks at one point and then forgetting about it. When I wanted
> to revive that patch a little while ago I noticed that ->add_bus()
> is now gone.

Removed by 6cf00af0ae15 ("ARM/PCI: Remove unused pcibios_add_bus() and
pcibios_remove_bus()"), I think.  That only removed the ARM
implementation; the hook itself is still called, but on every arch
except x86 and ia64, we use the default no-op implementation.  You
could add it back, I guess.  It was removed because the MSI-related
stuff that used to be in the ARM version is now done in a more generic
way (see 49dcc01a9ff2 ("ARM/PCI: Save MSI controller in
pci_sys_data")).

> What I'm asking myself now is how to fix this. I suppose it'd be
> possible to bring back ->add_bus(), though I suspect there were good
> reasons to remove it (portability?).

> Another possible fix would be
> to get rid of the spinlock protecting these accesses. It seems to me
> like it's not really necessary in the majority of cases. For drivers
> that do a simple readl() or writel() on some memory-mapped I/O the
> lock doesn't protect anything.

I've wondered about removing pci_lock, too.  It seems like it could be
removed in principle, but it would be a lot of work to audit
everything.  Probably more work than you want to do just to fix Tegra
:)

> Then again, there are a lot of pci_ops implementations in the tree,
> and simply removing the global lock seems like it'd have a good chance
> of breaking things for somebody.
>
> So short of auditing all pci_ops implementations and pushing the lock
> down into drivers, does anyone have any good ideas on how to fix this?

The 32-bit version of pci_mmcfg_read() uses fixmap to map the page it
needs on-demand.  Could you do something similar, i.e., allocate the
virtual space (which I assume is the part that might sleep), then
redirect the virt-to-phys mapping while holding the lock?

Bjorn
