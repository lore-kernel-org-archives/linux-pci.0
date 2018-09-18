Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46845 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbeISC6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 22:58:03 -0400
Received: by mail-yb1-f195.google.com with SMTP id y20-v6so1475401ybi.13
        for <linux-pci@vger.kernel.org>; Tue, 18 Sep 2018 14:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
 <20180914161404.4685-2-s.miroshnichenko@yadro.com> <CACK8Z6F1-P+SDYHx6x3zitSFh2iEPhQtY-Vdhz6Qwkt9=0XTjA@mail.gmail.com>
 <d4dd901b-0602-d764-1d79-6dec4ef8cdb4@yadro.com>
In-Reply-To: <d4dd901b-0602-d764-1d79-6dec4ef8cdb4@yadro.com>
From: Rajat Jain <rajatja@google.com>
Date: Tue, 18 Sep 2018 14:22:58 -0700
Message-ID: <CACK8Z6H9PqRLtg+15X4VfcT7hwZL7GrqQyAaCJbd5biom_X6+A@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] PCI: hotplug: Add parameter to put devices to
 reset during rescan
To: s.miroshnichenko@yadro.com
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sergey,

Sorry, I have one more basic question: The PCI express hierarchy is
made up from PCI express switches and end points, so essentially there
are only point to point links (except the switch internal logicl bus
on which you cannot hotplug anything). The device being hotplugged
shall be plugged onto a downstream port of a switch (or root port), so
there shall be no other device on that bus (since each downstream port
gets its own secondary bus number, and its own share of resources). So
it seems to me, that in this case, IF the resources at the downstream
port are not big enough, you will need to re-program the switch to get
resources to this downstream port, by stealing from *another*
downstream port. Is this correct understanding of the problem that you
are trying to solve?

Thanks,

Rajat



On Mon, Sep 17, 2018 at 2:25 PM Sergey Miroshnichenko
<s.miroshnichenko@yadro.com> wrote:
>
> Hello Rajat,
>
> On 9/17/18 10:00 PM, Rajat Jain wrote:
> > On Fri, Sep 14, 2018 at 9:21 AM Sergey Miroshnichenko
> > <s.miroshnichenko@yadro.com> wrote:
> >>
> >> Introduce a new command line option "pci=pcie_movable_bars" that indicates
> >> support of PCIe hotplug without prior reservation of memory regions by
> >> BIOS/bootloader.
> >>
> >> If a new PCIe device has been hot-plugged between two active ones, which
> >> have no (or not big enough) gap between their BARs, allocating new BARs
> >> requires to move BARs of the following working devices:
> >
> > I think this is a great problem to solve. I have some questions (not
> > objections, but trying to understand what are the limitations of the
> > solution being proposed):
> >
> > * What about hot-pluggable root ports? Would this help (I'm guessing not)?
> >
>
> We don't have a hardware that is able to handle a hotplug directly into
> a root port (but we'll find) - there are intermediate bridges always, so
> I can't provide proofs right now. But after a thought experiment I can't
> see any obstacles, so just need to verify.
>
> > * What about situations where the root port itself does not have
> > enough resources for the new device being inserted. I'm guessing we
> > are not going to expand root port allocation in those cases. But do we
> > fail gracefully rejecting the hotplug by not assigning it resources,
> > or do we manage to screw up the already working healthy devices (while
> > attempting to move them)?
> >
>
> Thanks for a great point! The code currently is too simplistic to handle
> this case properly, and though it never happened to us yet, but I'm sure
> it can kick off a working device to use its resources for a hotplugged
> one. The struct resource doesn't have a "priority" field, so probably I
> need to check the status of the resource allocation procedure and retry
> it without some of new hotplugged devices in case of fail.
>
> > * What about non-memory resources? E.g. cards may have pci bridges or
> > switches on them, and they may need extra PCI bus numbers. Does this
> > help that use case?
>
> Actually, this patchset is a part of our bigger work on hotplugging
> bridges full of bridges full of NVME and GPU devices. And in case of
> success here I was planning to submit the last part (hotplugging
> bridges), which includes the movement of bus numbers - similar to BARs,
> but more awkward, with PCIe devices renaming and re-building the
> /sys/bus/pci and /proc/pci, otherwise the lspci tool gets mad.
>
> By device renaming I mean the "/dev/nvme0n1p1" and "eth0" will remain
> the same, but underlying "nvme 0022:04:00.0" and "tg3 0001:06:00.1" may
> change. In this regard I don't know which UDEV action is the best here -
> it's neither "add", "remove" nor "change".
>
>
> Also I've just realized that should take a closer look and check if MSIs
> are also needs to be reallocated.
>
> >>
> >> 1)                   dev 4
> >>                        |
> >>                        v
> >> .. |  dev 3  |  dev 3  |  dev 5  |  dev 7  |
> >> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
> >>
> >> 2)                             dev 4
> >>                                  |
> >>                                  v
> >> .. |  dev 3  |  dev 3  | -->           --> |  dev 5  |  dev 7  |
> >> .. |  BAR 0  |  BAR 1  | -->           --> |  BAR 0  |  BAR 0  |
> >>
> >> 3)
> >>
> >> .. |  dev 3  |  dev 3  |  dev 4  |  dev 4  |  dev 5  |  dev 7  |
> >> .. |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 1  |  BAR 0  |  BAR 0  |
> >>
> >> Not only BARs, but also bridge windows can be updated during a PCIe rescan,
> >> threatening all memory transactions during this procedure, so the PCI
> >> subsystem will instruct the drivers to pause by calling the reset_prepare()
> >> and reset_done() callbacks.
> >>
> >> If a device may be affected by BAR movement, the BAR changes tracking must
> >> be implemented in its driver.
> >
> > This is quite a big thing right? I expect that this will break a lot
> > of drivers because
> > (a) they may not have reset_prepare() and reset_done() callbacks (I
> > grepped in the sources and seems only 4 support it?).
> > (b) Now, it is expected that in the reset_done() the drivers should
> > re-read the BAR and remap any memory resources that may have changed.
> > Note this may also include cleaning up any existing resource mappings
> > that they had before they were paused. Not sure if this was the
> > semantics of reset_done() already, or may be it was, I'm just not
> > sure.
> >
>
> Yes, this is the most painful part: all the drivers that may be affected
> with BARs getting moved, must be prepared in this way. Luckily, these
> operations have distinct patterns, just like power management callbacks
> like runtime_suspend()/runtime_resume() and friends.
>
> Just a few minutes earlier in this thread I've wrote to Sam why we think
> this approach still can be used even with a minimal subset of drivers
> being prepared: for now we've limited the configurations of hotplug
> usage to non-root bridges and to domains with similar devices. If this
> concept looks viable to the community, we'll be happy to share the
> patches for the nvme, ixgbe and tg3 drivers (and a bit later - for
> xhci). Right now these are the only drivers _we_ need on our ppc64
> (PowerNV) and x86_64 servers.
>
> > Thanks,
> >
> > Rajat
> >
>
> Thanks for the review!
>
> Best regards,
> Serge
>
> >>
> >> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> >> ---
> >>  .../admin-guide/kernel-parameters.txt         |  6 +++
> >>  drivers/pci/pci.c                             |  2 +
> >>  drivers/pci/probe.c                           | 43 +++++++++++++++++++
> >>  include/linux/pci.h                           |  1 +
> >>  4 files changed, 52 insertions(+)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index 64a3bf54b974..f8132a709061 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -3311,6 +3311,12 @@
> >>                                 bridges without forcing it upstream. Note:
> >>                                 this removes isolation between devices and
> >>                                 may put more devices in an IOMMU group.
> >> +               pcie_movable_bars       Arrange a space at runtime for BARs of
> >> +                               hotplugged PCIe devices - usable if bootloader
> >> +                               doesn't reserve memory regions for them. Freeing
> >> +                               a space may require moving BARs of active devices
> >> +                               to higher addresses, so device drivers will be
> >> +                               paused during rescan.
> >>
> >>         pcie_aspm=      [PCIE] Forcibly enable or disable PCIe Active State Power
> >>                         Management.
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index 1835f3a7aa8d..5f07a59b5924 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -6105,6 +6105,8 @@ static int __init pci_setup(char *str)
> >>                                 pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
> >>                         } else if (!strncmp(str, "disable_acs_redir=", 18)) {
> >>                                 disable_acs_redir_param = str + 18;
> >> +                       } else if (!strncmp(str, "pcie_movable_bars", 17)) {
> >> +                               pci_add_flags(PCI_MOVABLE_BARS);
> >>                         } else {
> >>                                 printk(KERN_ERR "PCI: Unknown option `%s'\n",
> >>                                                 str);
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index 201f9e5ff55c..bdaafc48dc4c 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -3138,6 +3138,45 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
> >>         return max;
> >>  }
> >>
> >> +/*
> >> + * Put all devices of the bus and its children to reset
> >> + */
> >> +static void pci_bus_reset_prepare(struct pci_bus *bus)
> >> +{
> >> +       struct pci_dev *dev;
> >> +
> >> +       list_for_each_entry(dev, &bus->devices, bus_list) {
> >> +               struct pci_bus *child = dev->subordinate;
> >> +
> >> +               if (child) {
> >> +                       pci_bus_reset_prepare(child);
> >> +               } else if (dev->driver &&
> >> +                          dev->driver->err_handler &&
> >> +                          dev->driver->err_handler->reset_prepare) {
> >> +                       dev->driver->err_handler->reset_prepare(dev);
> >> +               }
> >> +       }
> >> +}
> >> +
> >> +/*
> >> + * Complete the reset of all devices for the bus and its children
> >> + */
> >> +static void pci_bus_reset_done(struct pci_bus *bus)
> >> +{
> >> +       struct pci_dev *dev;
> >> +
> >> +       list_for_each_entry(dev, &bus->devices, bus_list) {
> >> +               struct pci_bus *child = dev->subordinate;
> >> +
> >> +               if (child) {
> >> +                       pci_bus_reset_done(child);
> >> +               } else if (dev->driver && dev->driver->err_handler &&
> >> +                          dev->driver->err_handler->reset_done) {
> >> +                       dev->driver->err_handler->reset_done(dev);
> >> +               }
> >> +       }
> >> +}
> >> +
> >>  /**
> >>   * pci_rescan_bus - Scan a PCI bus for devices
> >>   * @bus: PCI bus to scan
> >> @@ -3151,8 +3190,12 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
> >>  {
> >>         unsigned int max;
> >>
> >> +       if (pci_has_flag(PCI_MOVABLE_BARS))
> >> +               pci_bus_reset_prepare(bus);
> >>         max = pci_scan_child_bus(bus);
> >>         pci_assign_unassigned_bus_resources(bus);
> >> +       if (pci_has_flag(PCI_MOVABLE_BARS))
> >> +               pci_bus_reset_done(bus);
> >>         pci_bus_add_devices(bus);
> >>
> >>         return max;
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index 6925828f9f25..a8cb1a367c34 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -847,6 +847,7 @@ enum {
> >>         PCI_ENABLE_PROC_DOMAINS = 0x00000010,   /* Enable domains in /proc */
> >>         PCI_COMPAT_DOMAIN_0     = 0x00000020,   /* ... except domain 0 */
> >>         PCI_SCAN_ALL_PCIE_DEVS  = 0x00000040,   /* Scan all, not just dev 0 */
> >> +       PCI_MOVABLE_BARS        = 0x00000080,   /* Runtime BAR reassign after hotplug */
> >>  };
> >>
> >>  /* These external functions are only available when PCI support is enabled */
> >> --
> >> 2.17.1
> >>
