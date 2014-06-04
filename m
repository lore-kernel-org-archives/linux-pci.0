Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:43531 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbaFDCoY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jun 2014 22:44:24 -0400
Message-ID: <538E87E1.8030604@huawei.com>
Date: Wed, 4 Jun 2014 10:43:45 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Keith Busch <keith.busch@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jon Mason <jon.mason@intel.com>
Subject: Re: Debugging incorrect mps settings detected
References: <alpine.LRH.2.03.1406031308200.11244@AMR> <CAErSpo6B76KL=PVGuuLjvC77kvxSjjYNnngXxPEjj_3dMbA0yg@mail.gmail.com>
In-Reply-To: <CAErSpo6B76KL=PVGuuLjvC77kvxSjjYNnngXxPEjj_3dMbA0yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

accurate>> 0xd5200000-0xd52fffff 64bit pref]
>> [ 2107.015060] pci 0000:09:00.0: Max Payload Size 128, but upstream
>> 0000:05:07.0 set to 256; if necessary, use "pci=pcie_bus_safe" and report a
>> bug
>> [ 2107.015079] pci 0000:09:00.0: no hotplug settings from platform
>>
>> The commit message that added the warning indicates it may be a BIOS
>> issue that incorrectly configures this, but BIOS isn't involved with
>> setting the MPS on a device hot add, am I right? Or is that wrong?
> 
> The BIOS is not involved in setting MPS on a device hot-add.
> 
>> This is a Dell R620 server, if that matters, though we see this on other
>> platforms as well.
>>
>> Using pci=pcie_bus_perf works around the issue, but that seems a bit
>> odd to suggest to users. Is setting MPS on hot-add something the PCI
>> driver layer ought to be doing, or should I be looking into the platform
>> BIOS instead?
> 
> The PCI core should be doing something intelligent here.  If we can't
> configure MPS safely, we should prevent the device from being enabled.
>  But this is stuff the PCI core doesn't implement yet.

Hi Bjorn,
   We had a long discussion about fix this issue.
Link: http://marc.info/?l=linux-pci&m=137714192204947&w=2

Now more BIOS configure device mps larger than 128B, So I think
we should consider to fix it before we have a perfect solution about mps setting.

> 
> It's hard to reconfigure MPS after boot because it affects other
> devices in the system, and I don't think we can always change the
> settings of other devices while they're active.

Yes, what we can only change is the device not active after hotplug.


> 
> I'm not sure that warning is correct.  It seems like it should suggest
> pcie_bus_peer2peer, which is documented as guaranteeing that hot-added
> devices will work.  But this is always confusing to me, and I could be
> wrong about this.

I think warning is proper, pcie_bus_safe is designed to fix the hotlplug issue.
pcie_bus_peer2perr guarantee that hotplug device work fine, because all mps setting
128B. Maybe we should change document a little, make it more clear.


> 
> Bjorn
> 
> 


-- 
Thanks!
Yijing

