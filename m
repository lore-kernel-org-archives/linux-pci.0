Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34358 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbbHYVP0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2015 17:15:26 -0400
Received: by widdq5 with SMTP id dq5so27936031wid.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2015 14:15:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAC1AzdcoZHpRJ3NpW2UQnp9frEYn6pAf5cPyDx4zPXT3TUiULA@mail.gmail.com>
References: <CAC1AzdcoZHpRJ3NpW2UQnp9frEYn6pAf5cPyDx4zPXT3TUiULA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Aug 2015 16:15:05 -0500
Message-ID: <CAErSpo6AkSjccgepdEQvaAFKQoiQHCuM8V178ZsKMzammUziQA@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Move MPS configuration check to pci_configure_device()
To: Jordan Hargrave <jharg93@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 25, 2015 at 9:44 AM, Jordan Hargrave <jharg93@gmail.com> wrote:
>>Previously we checked for invalid MPS settings, i.e., a device with MPS
>>different than its upstream bridge, in pcie_bus_detect_mps().  We only did
>>this if the arch or hotplug driver called pcie_bus_configure_settings(),
>>and then only if PCIe bus tuning was disabled (PCIE_BUS_TUNE_OFF).
>>
>>Move the MPS checking code to pci_configure_device(), so we do it in the
>>pci_device_add() path for every device.
>> ...

> I have tested the patch and it is working on our PCIE SSD devices.

Thanks, I added your Tested-by.

> This is basically reimplementing a patch I introduced several years
> ago that was reverted.
> http://marc.info/?l=linux-pci&m=130100586722666&w=2

As far as I can tell, that was reverted by b03e7495a862 ("PCI: Set
PCI-E Max Payload Size on fabric"), not because of a problem with your
patch, but because b03e7495a862 implemented more extensive MPS support
with "safe" and "perf" options.

I didn't try to verify that b03e7495a862 actually preserved the
behavior of your patch for hot-added devices.

But after b03e7495a862, 5f39e6705faa ("PCI: Disable MPS configuration
by default") turned off MPS tuning anyway.

> One thing is you are not checking if the max possible payload of the
> inserted device is less than the payload setting of the parent.  If
> the bridge is set at 512 MPS for example, and the inserted device only
> supports a MPS of 256, it should error out and disable the PCI device.

I used pcie_set_mps(), and I think it does check for errors like that,
doesn't it?  It's certainly my intent to catch the problem you
mention, so if it's wrong I want to fix it.

Thanks a lot for testing and reviewing this!

Bjorn
