Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:5007 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab3HTCzU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2013 22:55:20 -0400
Message-ID: <5212DA84.6070409@huawei.com>
Date: Tue, 20 Aug 2013 10:55:00 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH v5 1/2] PCI: fix the only slot identification in pcie_find_smpss()
References: <1376533135-36708-1-git-send-email-wangyijing@huawei.com> <1376533135-36708-2-git-send-email-wangyijing@huawei.com> <20130816221716.GA25780@google.com> <521187A5.6030002@huawei.com> <CAPoiz9zpovgcnx=DG-g4v7VpA17H5P2EYv1spm7TGLOwO6zYCQ@mail.gmail.com> <CAErSpo7kxfJDrm1QwNrGd4onfKBzUW+jVV-8p14i1yJqkMFobg@mail.gmail.com> <CAErSpo7tf+9NUGT2U5WBcQUtZb9=ZT_4wAjxzhiiWh9n_KEbAA@mail.gmail.com> <CAPoiz9wMo+sr1EWp+fPdwKTBoJpQGjZg-dASRMHAtvPBE+G4Eg@mail.gmail.com>
In-Reply-To: <CAPoiz9wMo+sr1EWp+fPdwKTBoJpQGjZg-dASRMHAtvPBE+G4Eg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> Actually, I don't think it matters whether the slot is currently
>> occupied or not.  If the bridge supports hot-plug, we have to handle
>> the current device (if any) as well as any other device that might be
>> added after removing the current device.
> 
> Yes, this is true.  So, we want to see if there is the ability to:
> 1. have a device hotplugged
> and
> 2a. there are other devices under the same root port
> or
> 2b. there are multiple hotplug slots under the same root port
> 
> The patch covers part 2b (unless I missunderstand and it only covers
> the devices present and not the slots available), but we need part 2a
> to be covered.  I believe your suggested code above covers 2a.  Am I
> off my rocker?

I'm a little confused, let us list the possible pcie topo here:

1.
root port -------------->[slot]-(function device a)
			       -(function device b)

Here there is only one slot directly connected to root port,
this slot is inserted a physical device which contain function device a and b.
After we insert physical device into this slot, hotplug driver will call
pci_configure_slot()---->pcie_bus_configure_settings() to set device mps.

As Jon's original patch, in this case we should update root port and slot device
mps to the minmum mpss of root port and slot device. But in pcie_find_smpss()
list_is_singular() is used to check whether there are other devices on the fabric.
list_is_singular() in this case return false. because more than one devices found in devices list.
But we expect the result is true.

And Bjorn think root port always connected to only one hot-plug slot, so use list_is_singular() or pci_only_one_slot()
to check other devices on the fabric make no sense. I agree with him if there is no broken hardware platform that
a root port connected to more than one slot.

2.		(is_hotplug_bridge)
root port --------------->Port A--------->[slot]
		bus a	 |
			 |Port or devices ?

If Jon's original patch is correct, I guess the topo is like above.
In this case, Port A is hotplug bridge and connected directly to root port.
So if there is no other port or devices in bus a, we can configure mps to the minmum
mpss of root port and Port A and slot device.

But does this topo exist? root port has only one link, the pcie link is point to point.

3.                                                (hotplug bridge)
root port ---------------Up steam port----------->Downsteam port A -------->[slot]
						 |
						 |Downsteam port B -------->[slot]  ?

This topo is common, but DP A is not directly connected to root port, so the original patch
can not cover this case. If DP B is not exist. there is only one Downstream port A, like:

                                                (hotplug bridge)
root port ---------------Up steam port----------->Downsteam port A -------->[slot]

In this case, we can also configure mps after a pcie card inserted into slot, because
although the system is running, because root port UP port DP port A and slot are not running.
But this case is rare.

So, Jon, does your original patch want to cover the case 1 or case 2 ?
For case 1, we can remove the list_is_singular() check.
For case 2, do you have some example hardware platform ?
Or there are other pcie topos not exist here?

Thanks!
Yijing.


