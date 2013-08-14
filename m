Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33424 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760409Ab3HNTow (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2013 15:44:52 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so13379608iea.18
        for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2013 12:44:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXuNPfhndRAm7uX4phvVqqVsQuuEzEqEi8at9f2oWPYOg@mail.gmail.com>
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org>
 <20130807040112.GA14662@google.com> <CAE9FiQVXhg299RKsoa8eCqoN7b9c0HaeTGHCnxQY=9vkSYaJJg@mail.gmail.com>
 <CAE9FiQWftukxyNiyM2znVPh7x82de3nhRMQwGHigZtOvU6xQ6g@mail.gmail.com>
 <20130809170404.GA29690@google.com> <CAE9FiQXuNPfhndRAm7uX4phvVqqVsQuuEzEqEi8at9f2oWPYOg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 14 Aug 2013 13:44:31 -0600
Message-ID: <CAErSpo5uYciz4dZtf6utfehXGnooRAT3BcVHyz+EoZ4m7tbitg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: Separate stop and remove devices in pciehp
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Don]

On Fri, Aug 9, 2013 at 5:44 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Aug 9, 2013 at 10:04 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:

>> What would happen if we just reverted dc087f2f6a2 for now?  Jiang?

I tried to reproduce the problem you reported ("Cannot add device at
0000:02:00"), but I haven't been able to.  I have an ixgbe SR-IOV
device in an external hotplug-capable chassis, and I'm using v3.11-rc4
with a patch to add a little instrumentation.  Here's what I see:

    # echo -n 8 > /sys/bus/pci/devices/0000:08:00.0/sriov_numvfs
    ixgbe 0000:08:00.0 eth1: SR-IOV enabled with 8 VFs
    pci 0000:08:10.0: [8086:1515] type 00 class 0x020000        # VF1
    pci 0000:08:10.2: [8086:1515] type 00 class 0x020000        # VF2
    ...
    pci 0000:08:11.6: [8086:1515] type 00 class 0x020000        # VF8

Created 8 VFs; no problem there.

    # echo -n 0 > /sys/bus/pci/slots/4-1/power
    pciehp 0000:04:03.0:pcie24: disable_slot: physical_slot = 4-1
    pciehp 0000:04:03.0:pcie24: pciehp_unconfigure_device:
domain:bus:dev = 0000:08:00
    ixgbevf 0000:08:11.6: pci_stop_and_remove_bus_device
    pci 0000:08:11.6: pci_release_dev                   # release VF8
    ixgbevf 0000:08:11.4: pci_stop_and_remove_bus_device
    pci 0000:08:11.4: pci_release_dev                   # release VF7
    ...
    ixgbevf 0000:08:10.0: pci_stop_and_remove_bus_device
    pci 0000:08:10.0: pci_release_dev                   # release VF1
    ixgbe 0000:08:00.1: pci_stop_and_remove_bus_device
    pci 0000:08:00.1: pci_release_dev                   # release PF1
    ixgbe 0000:08:00.0: pci_stop_and_remove_bus_device  # stop/remove PF0
                                                        # PF0 not released

When I turn off power to the slot, pciehp stops and removes all the
devices, starting with the VFs.  The PF 08:00.0 is stopped but not
released, because we didn't call virtfn_remove(), so the reference
held by the VFs was never released.  This is a problem.

   # echo -n 1 > /sys/bus/pci/slots/4-1/power
    pci 0000:08:00.0: [8086:1528] type 00 class 0x020000
    pci 0000:08:00.1: [8086:1528] type 00 class 0x020000

When I turn the slot back on, we find both PFs; no apparent problem there.

On v3.10 (which does not contain dc087f2f6a), I see essentially the
same thing.  The PFs are stopped before the VFs because v3.10 doesn't
contain 29ed1f29b68, which removes devices in reverse order.  But even
in v3.10, PF0 is stopped but not released because the VFs still hold
references to it.  And there's no complaint when turning the slot back
on.

So we definitely have a problem: when we remove the PF, we don't
release it correctly because we don't release the references held by
VFs.  But this is not a regression, and doesn't seem urgent enough to
rush something for v3.11.

I think we're headed toward tearing down all VFs when removing a PF.
Obviously, we *have* to do that when powering off the device, and I
think we also need to do it when removing the PF driver just to keep
all the bookkeeping sane.  I don't know how much heartburn this will
cause Don.

So tell me if you still think we need to do something for v3.11.

Bjorn
