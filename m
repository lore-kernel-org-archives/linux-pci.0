Return-Path: <SRS0=bmG0=A5=linaro.org=ard.biesheuvel@kernel.org>
Return-Path: <SRS0=bmG0=A5=linaro.org=ard.biesheuvel@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170928174847.GW15970@bhelgaas-glaptop.roam.corp.google.com>
References: <20170828180437.2646-1-ard.biesheuvel@linaro.org>
 <20170828180437.2646-2-ard.biesheuvel@linaro.org> <20170926173200.GL15970@bhelgaas-glaptop.roam.corp.google.com>
 <CAKv+Gu8CCcm_R3S1PbXZFqzvjAJVfU_bKpimVxbeQ78ciAgJyA@mail.gmail.com> <20170928174847.GW15970@bhelgaas-glaptop.roam.corp.google.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 28 Sep 2017 11:33:17 -0700
Message-ID: <CAKv+Gu8Z-pJ2bcWvwLU28dQP6_KbgEoMktqXN3B+Zb=cDM-0tw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pci: designware: add driver for DWC controller in
 ECAM shift mode
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>,
	Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>, Rob Herring <robh@kernel.org>,
	Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 28 September 2017 at 10:48, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Sep 28, 2017 at 08:51:43AM -0700, Ard Biesheuvel wrote:
>> On 26 September 2017 at 10:32, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Mon, Aug 28, 2017 at 07:04:36PM +0100, Ard Biesheuvel wrote:
>> >> Some implementations of the Synopsys Designware PCIe controller implement
>> >> a so-called ECAM shift mode, which allows a static memory window to be
>> >> configured that covers the configuration space of the entire bus range.
>
>> >> Note that, unlike most drivers for this IP, this driver does not expose
>> >> a fake bridge device at B/D/F 00:00.0. There is no point in doing so,
>> >> given that this is not a true bridge, and does not require any windows
>> >> to be configured in order for the downstream device to operate correctly.
>> >> Omitting it also prevents the PCI resource allocation routines from
>> >> handing out BAR space to it unnecessarily.
>> >
>> > This is a tangent, but does this mean the other drivers do not need to
>> > expose a fake 00:00.0 device either?
>>
>> To be honest, I am not so sure anymore. I am seeing some issues in
>> ASPM code making the assumption that any device which is not a root
>> port has a parent. If this is mandated by the spec, I guess there
>> isn't a whole lot we can do except expose a fake root port on b/d/f
>> 0/0/0. This used to work fine, though, and I have to confirm whether
>> the issues I am seeing currently are due to different hardware or
>> changes in the software.
>
> I agree that our ASPM code had some assumptions that any non-root port
> device should have a parent.  I think the spec also makes that
> assumption, but I haven't found an explicit mandate.  And there *are*
> systems lacking root ports:
>
> http://lkml.kernel.org/r/1439808478-23253-1-git-send-email-wangyijing@huawei.com
>
> We fixed one such assumption in that thread, but I wouldn't be
> surprised if more remain.  If there are, I think we should fix the
> code to remove the assumption.
>

OK, that is good to know. What I am seeing on my board is the following crash

Unable to handle kernel NULL pointer dereference at virtual address 00000090
[0000000000000090] user address but active_mm is swapper
Internal error: Oops: 96000004 [#1] SMP
Modules linked in:
CPU: 23 PID: 1 Comm: swapper/0 Not tainted 4.13.0+ #1
Hardware name: Synquacer Evaluation Board (DT)
task: ffff800f5c574080 task.stack: ffff800f5c578000
PC is at pcie_aspm_init_link_state+0x204/0xa38
LR is at pcie_aspm_init_link_state+0x184/0xa38
   ...
[<ffff0000084fda0c>] pcie_aspm_init_link_state+0x204/0xa38
[<ffff0000084e2924>] pci_scan_slot+0x10c/0x150
[<ffff0000084e3a9c>] pci_scan_child_bus+0x3c/0x1b0
[<ffff0000084e37b4>] pci_scan_bridge+0x30c/0x5b8
[<ffff0000084e3b1c>] pci_scan_child_bus+0xbc/0x1b0
[<ffff0000084e37b4>] pci_scan_bridge+0x30c/0x5b8
[<ffff0000084e3b1c>] pci_scan_child_bus+0xbc/0x1b0
[<ffff0000084e3e0c>] pci_scan_root_bus_bridge+0xdc/0xf8
[<ffff000008509c28>] pci_host_common_probe+0x148/0x400
[<ffff00000850ee4c>] pci_dw_ecam_probe+0x2c/0x38
[<ffff0000086348c8>] platform_drv_probe+0x60/0xc8
[<ffff000008631b3c>] driver_probe_device+0x2e4/0x460
[<ffff000008631de4>] __driver_attach+0x12c/0x130
[<ffff00000862f1e0>] bus_for_each_dev+0x88/0xe8
[<ffff000008631218>] driver_attach+0x30/0x40
[<ffff000008630b90>] bus_add_driver+0x200/0x2b8
[<ffff000008632fd8>] driver_register+0x68/0x100
[<ffff0000086347ec>] __platform_driver_register+0x54/0x60
[<ffff000008c44520>] pci_dw_ecam_driver_init+0x20/0x28
[<ffff00000808399c>] do_one_initcall+0x5c/0x168
[<ffff000008c10f98>] kernel_init_freeable+0x1e8/0x288
[<ffff0000088ae9b8>] kernel_init+0x18/0x108
[<ffff0000080836d0>] ret_from_fork+0x10/0x40
Code: 54000f20 f9400aa0 f9400800 f9401c00 (f9404816)

which is essentially caused by this code [in alloc_pcie_link_state()]

if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
    pci_pcie_type(pdev) == PCI_EXP_TYPE_PCIE_BRIDGE) {
        link->root = link;
} else {
        struct pcie_link_state *parent;

        parent = pdev->bus->parent->self->link_state;
    ...

so I guess we should fix this instance as well.

>> > This really doesn't have any DesignWare specifics in it, and it seems
>> > more related to drivers/pci/host/pci-host-generic.c than to anything
>> > in drivers/pci/dwc.  Maybe it should be
>> > drivers/pci/host/pci-host-generic-quirks.c or something?  That's
>> > unwieldy, I admit.
>>
>> I don't care where we put it, and I am fine with owning it if you prefer.
>
> I think Will's idea of teaching pci-host-generic to deal with this is
> perfect.
>

I agree. I originally thought people would prefer the DesignWare
quirks to live under dwc/, but it does fit more naturally into the
generic driver.

>> >> +config PCIE_DW_HOST_ECAM
>> >> +     bool "Synopsys DesignWare PCIe controller in ECAM mode"
>> >> +     depends on OF && PCI
>> >> +     select PCI_HOST_COMMON
>> >> +     select IRQ_DOMAIN
>> >> +     help
>> >> +       Add support for Synopsys DesignWare PCIe controllers configured
>> >> +       by the firmware into ECAM shift mode. In some cases, these are
>> >> +       fully ECAM compliant, in which case the pci-host-generic driver
>> >> +       may be used instead.
>> >
>> > This doesn't quite read right.  It sounds like a controller in ECAM
>> > shift mode might be fully ECAM compliant, but I don't think that's
>> > what you intended.
>>
>> Yes, that is what I mean. ECAM shift mode results in a fully compliant
>> ECAM config space iff the IP was synthesized with a 32 KB granularity
>> for the iATU windows. The default is 64 KB, though, in which case you
>> need this driver.
>
> OK.  I'm trying to figure out how I as a user would know whether to
> select this option.  Maybe the config option will go away if you add
> the smarts to pci-host-generic?
>

Yes. The firmware knows, and so the firmware should expose the correct
compatible string in this case, either pci-host-ecam-generic or one of
the quirked ones.
