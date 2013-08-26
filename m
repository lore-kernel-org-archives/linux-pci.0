Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:23109 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710Ab3HZDne (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 25 Aug 2013 23:43:34 -0400
Message-ID: <521ACE99.9000505@huawei.com>
Date: Mon, 26 Aug 2013 11:42:17 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Jon Mason <jdmason@kudzu.us>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	<joe.jin@oracle.com>
Subject: Re: [PATCH v8 6/6] PCI: update device mps when doing pci hotplug
References: <1377141888-7000-1-git-send-email-wangyijing@huawei.com> <1377141888-7000-7-git-send-email-wangyijing@huawei.com> <20130822181823.GA25721@google.com>
In-Reply-To: <20130822181823.GA25721@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> I think the strategy of updating the device MPS when possible makes
> sense, but I don't think we should do it in PCIE_BUS_TUNE_OFF mode.
> That mode is documented as "Disable PCIe MPS tuning and use the
> BIOS-configured MPS defaults."  This patch changes that to something
> like "Disable PCIe MPS tuning, except for hot-added devices" and there
> is no longer a way to tell Linux to never touch MPS.

Hi Bjorn,
   Thanks for your review and comments!

As you mentioned, PCIE_BUS_TUNE_OFF means "Disable PCIe MPS tuning and use the
BIOS-configured MPS defaults.", But hotplug action make the BIOS default mps setting
changed(power off, all registers reset). So If we only touch the newly inserted device mps,
I think maybe it's reasonable.

> 
> Eventually, I think the default mode should change to PCIE_BUS_SAFE,
> where Linux changes MPS settings at boot-time and at hotplug-time to
> make sure every device works.  (This mode assumes no peer-to-peer
> DMA.)  I know this was tried in the past, and we tripped over all
> sorts of issues, but it's not clear how many were problems with the
> Linux code and how many were unsolvable BIOS or platform issues.

Agree.

> 
> Then we'd have these choices:
> 
>   PCIE_BUS_TUNE_OFF	Never touch MPS
>   PCIE_BUS_PEER2PEER	Set all MPS to 128, so peer-to-peer DMA works
>   PCIE_BUS_SAFE		Configure each device with largest safe MPS
> 			(assumes no peer-to-peer DMA)
>   PCIE_BUS_PERFORMANCE	Use MRRS in addition to MPS
> 			(assumes no peer-to-peer DMA)
> 
> The hot-add issue [1] could be regarded as a BIOS bug -- the BIOS
> programmed a hotplug bridge with MPS=256.  A hot-added device powers
> up with MPS=128, so it's only safe for BIOS to set MPS=256 if the OS
> is smart enough to change the bridge MPS, the device MPS, or both, at
> hot-add time.  That doesn't seem like a good assumption for a BIOS to
> make.
> 
> I think we should always *warn* about potential MPS issues, even in
> PCIE_BUS_TUNE_OFF mode.  That would help diagnose the hot-add issue as
> well as issues like the ones Joe Jin reported [2] and [3].

OK, I will add a new patch to provide "warn" info if necessary like Joe Jin reported.
But because hotplug issue [1] and Joe reported [2] and [3] only encountered in
PCIE_BUS_TUNE_OFF mode.

> 
> I think what we should do is *always* call pcie_bus_configure_set(),
> no matter what mode we're in, but make pcie_bus_configure_set() smart
> enough to do different things (print warnings, adjust settings, do the
> stuff you added in pcie_bus_update_set(), etc.) depending on what mode
> we're in.


OK, I will try to rework this patch.


Thanks!
Yijing.


>> +	}
>>  
>>  	/* FIXME - Peer to peer DMA is possible, though the endpoint would need
>>  	 * to be aware to the MPS of the destination.  To work around this,
>> -- 
>> 1.7.1
>>
>>
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=60671
> [2] http://lkml.kernel.org/r/4FFA9B96.6040901@oracle.com
> [3] http://lkml.kernel.org/r/509B5038.8090304@oracle.com
> 
> .
> 


-- 
Thanks!
Yijing

