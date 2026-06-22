Received: from mail-m10313119121.xmail.ntesmail.com (mail-m10313119121.xmail.ntesmail.com [103.131.191.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779E399372;
	Mon, 22 Jun 2026 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.131.191.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132861; cv=none; b=CXGdtzVEjIz37oJN9e6dAzadPKsNZvohIRzdZHkxhIyCcMhdPKfU4AlkZ92sPX0od7BB5L5dulGJdJUZKdRKuFUY+/JSCm/kYjpqLl8obFZYvD48NlfwPCAn814FUHxSIne38v/GGaQBzath65cznwIbxBturuV/Z2vLR/FL0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132861; c=relaxed/simple;
	bh=oNTlTbn2zq4jvTmESlZCW9gU0sDuA3pbDdndjFZVUHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/Yky7L1q58VGHbnbnEmsH9vCzm3y3VAX4/+VJFe6e8cuU4ncZVtPgAxaTi+gC4agADqE+Mv8XaucLN+JzbgSozV7wq0S2wlrHWp28Hx4ntptC7DbWk4It9j3x3ahECgBLFDayu12/5Afh21hNF4B1aZ3URAttE/j9+joj08CDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn; spf=pass smtp.mailfrom=sangfor.com.cn; arc=none smtp.client-ip=103.131.191.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sangfor.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sangfor.com.cn
Received: from [172.23.68.66] (unknown [43.247.70.80])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43493410b;
	Mon, 22 Jun 2026 20:54:06 +0800 (GMT+08:00)
Message-ID: <d966ac57-52cc-415b-bb0d-1f175a4ebb0c@sangfor.com.cn>
Date: Mon, 22 Jun 2026 20:54:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PCI: Sort resources by size as secondary key
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20260618072536.28199-1-dinghui@sangfor.com.cn>
 <8958b0af-7475-26b1-6eef-8e3ddf056196@linux.intel.com>
Content-Language: en-US
From: Ding Hui <dinghui@sangfor.com.cn>
In-Reply-To: <8958b0af-7475-26b1-6eef-8e3ddf056196@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eef65311003a8kunme9fa735337f216
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQxlJVktJS0sYHR9MGBlKH1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlPSFVJT0xVTEtVQ0tZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++

On 2026/6/22 17:24, Ilpo Järvinen wrote:
> On Thu, 18 Jun 2026, Ding Hui wrote:
> 
>> We encountered an issue on BCM57414 NIC where function 1 failed to
> 
> Don't or "We" (or "I") in changelog sentences. Use imperative tone. Here
> you can start just with:
> 
> BCM57414 NIC function 1 fails to ...
> 
>> enable SR-IOV after remove & rescan. Investigation revealed this is
>> caused by BAR allocation failure during rescan.
>>
>> Simplified topology:
>>
>>   +-[0000:30]-+- ...
>>   |           +-02.0-[31]--+-00.0  Broadcom Inc. and subsidiaries BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller [14e4:16d7]
>>   |           |            \-00.1  Broadcom Inc. and subsidiaries BCM57414 NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller [14e4:16d7]
>>
>> iomem layout after init bootup:
>>
>>    22fffec00000-22ffffefffff : PCI Bus 0000:31 [Window size=19M]
>>      22fffec00000-22ffff3fffff : 0000:31:00.1  [align=1M  size=8M   BAR 9 (VF BAR 2)]
>>      22ffff400000-22ffffbfffff : 0000:31:00.0  [align=1M  size=8M   BAR 9 (VF BAR 2)]
>>      22ffffc00000-22ffffcfffff : 0000:31:00.1  [align=1M  size=1M   BAR 2]
>>      22ffffd00000-22ffffdfffff : 0000:31:00.0  [align=1M  size=1M   BAR 2]
>>      22ffffe00000-22ffffe0ffff : 0000:31:00.1  [align=64K size=64K  BAR 0]
>>      22ffffe10000-22ffffe1ffff : 0000:31:00.0  [align=64K size=64K  BAR 0]
>>      22ffffe20000-22ffffe3ffff : 0000:31:00.1  [align=16K size=128K BAR 11(VF BAR 4)]
>>      22ffffe40000-22ffffe5ffff : 0000:31:00.1  [align=16K size=128K BAR 7 (VF BAR 0)]
>>      22ffffe60000-22ffffe7ffff : 0000:31:00.0  [align=16K size=128K BAR 11(VF BAR 4)]
>>      22ffffe80000-22ffffe9ffff : 0000:31:00.0  [align=16K size=128K BAR 7 (VF BAR 0)]
>>      22ffffea0000-22ffffea1fff : 0000:31:00.1  [align=8K  size=8K   BAR 4]
>>      22ffffea2000-22ffffea3fff : 0000:31:00.0  [align=8K  size=8K   BAR 4]
>>
>> iomem layout after remove function 1 by
>>    echo "1" > /sys/bus/pci/devices/0000:31:00.1/remove
>>
>>    22fffec00000-22ffffefffff : PCI Bus 0000:31 [Window size=19M]
>>      22ffff400000-22ffffbfffff : 0000:31:00.0  [align=1M  size=8M   BAR 9 (VF BAR 2)]
>>      22ffffd00000-22ffffdfffff : 0000:31:00.0  [align=1M  size=1M   BAR 2]
>>      22ffffe10000-22ffffe1ffff : 0000:31:00.0  [align=64K size=64K  BAR 0]
>>      22ffffe60000-22ffffe7ffff : 0000:31:00.0  [align=16K size=128K BAR 11(VF BAR 4)]
>>      22ffffe80000-22ffffe9ffff : 0000:31:00.0  [align=16K size=128K BAR 7 (VF BAR 0)]
>>      22ffffea2000-22ffffea3fff : 0000:31:00.0  [align=8K  size=8K   BAR 4]
>>
>> Rescan logs triggered by
>>    echo "1" > /sys/bus/pci/devices/0000:30:02.0/rescan
>>
>> [   90.585067] pci 0000:31:00.1: [14e4:16d7] type 00 class 0x020000 PCIe Endpoint
>> [   90.585107] pci 0000:31:00.1: BAR 0 [mem 0x22ffffe00000-0x22ffffe0ffff 64bit pref]
>> [   90.585113] pci 0000:31:00.1: BAR 2 [mem 0x22ffffc00000-0x22ffffcfffff 64bit pref]
>> [   90.585116] pci 0000:31:00.1: BAR 4 [mem 0x22ffffea0000-0x22ffffea1fff 64bit pref]
>> [   90.585119] pci 0000:31:00.1: ROM [mem 0xb0e00000-0xb0e7ffff pref]
>> [   90.585216] pci 0000:31:00.1: PME# supported from D0 D3hot D3cold
>> [   90.585253] pci 0000:31:00.1: VF BAR 0 [mem 0x22ffffe40000-0x22ffffe43fff 64bit pref]
>> [   90.585255] pci 0000:31:00.1: VF BAR 0 [mem 0x22ffffe40000-0x22ffffe5ffff 64bit pref]: contains BAR 0 for 8 VFs
>> [   90.585258] pci 0000:31:00.1: VF BAR 2 [mem 0x22fffec00000-0x22fffecfffff 64bit pref]
>> [   90.585260] pci 0000:31:00.1: VF BAR 2 [mem 0x22fffec00000-0x22ffff3fffff 64bit pref]: contains BAR 2 for 8 VFs
>> [   90.585263] pci 0000:31:00.1: VF BAR 4 [mem 0x22ffffe20000-0x22ffffe23fff 64bit pref]
>> [   90.585265] pci 0000:31:00.1: VF BAR 4 [mem 0x22ffffe20000-0x22ffffe3ffff 64bit pref]: contains BAR 4 for 8 VFs
>> [   90.585534] pci 0000:31:00.1: Adding to iommu group 11
>> [   90.585575] pci 0000:31:00.1: BAR 2 [mem 0x22fffec00000-0x22fffecfffff 64bit pref]: assigned
>> [   90.585585] pci 0000:31:00.1: VF BAR 2 [mem size 0x00800000 64bit pref]: can't assign; no space
>> [   90.585587] pci 0000:31:00.1: VF BAR 2 [mem size 0x00800000 64bit pref]: failed to assign
>> [   90.585589] pci 0000:31:00.1: ROM [mem 0xb0e00000-0xb0e7ffff pref]: assigned
>> [   90.585591] pci 0000:31:00.1: BAR 0 [mem 0x22fffed00000-0x22fffed0ffff 64bit pref]: assigned
>> [   90.585599] pci 0000:31:00.1: VF BAR 0 [mem 0x22fffed10000-0x22fffed2ffff 64bit pref]: assigned
>> [   90.585603] pci 0000:31:00.1: VF BAR 4 [mem 0x22fffed30000-0x22fffed4ffff 64bit pref]: assigned
>> [   90.585606] pci 0000:31:00.1: BAR 4 [mem 0x22fffed50000-0x22fffed51fff 64bit pref]: assigned
> 
> Timestamps are irrelevant noise to the problem and should be removed.
> 
>>
>> Enable sriov failed logs triggered by
>>    echo 2 > /sys/bus/pci/devices/0000:31:00.1/sriov_numvfs
>>
>> [ 1666.918432] bnxt_en 0000:31:00.1: not enough MMIO resources for SR-IOV
>> [ 1666.918442] bnxt_en 0000:31:00.1 eth5: pci_enable_sriov failed : -12
>>
>> The resource allocation process during rescan is as follows:
>>
>>    dev_rescan_store
>>      pci_rescan_bus
>>        pci_assign_unassigned_bus_resources
>>          __pci_bus_assign_resources
>>            pbus_assign_resources_sorted
>>              pdev_sort_resources
>>              __assign_resources_sorted
>>                assign_requested_resources_sorted
>>                  pci_assign_resource
>>
>> We noticed that current sort algorithm is only by alignment.
>> The BAR 2 (align=1M size=1M) is located before BAR 9 (VF BAR 2
>> align=1M size=8M), so the 8M cannot be satisfied.
> 
> I think you have a typo (located vs allocated)? The difference changes
> meaning significantly. (located implies before in address, allocated
> implies before in the order of made allocations).
> 

My description could indeed be misleading. My intention was that BAR 2 is
before BAR 9 in the sorted list, and therefore it is allocated before BAR 9.

>> If we keep alignment as primary sorting key, but use size as secondary
>> key, all resource can be satisfied when remove & rescan.
>>
>> Does this approach only solve current specific case as a workaround,
>> or does it also benefit general PCI resource allocation?
>>
>> I think it may help reduce allocation failures due to fragmentation
>> theoretically, but I'm not sure.
> 
> I suppose trying the largest first does generally increase the chances of
> success in cases where the resource sizes are very heterogeneous like in your
> case, not just in this case.
> 

Thanks for agreeing with this point.

> You should really rewrite the changelog text though. Try more to focus on
> how the other allocations from the sibling make it possible to fit some of
> the resource(s) only into a single place within the window. And therefore
> largest one should be requested first. I had to figure that bit myself as
> you didn't clearly state why it fails but only talked vaguely about the
> order of (al)location(s).
> 

After .1 BAR 2 assigned, the iomem layout (deduce should be):

   22fffec00000-22ffffefffff : PCI Bus 0000:31 [Window size=19M]
     22fffec00000-22fffecfffff : 0000:31:00.1  [align=1M  size=1M   BAR 2]
                                               [gap=7M]
     22ffff400000-22ffffbfffff : 0000:31:00.0  [align=1M  size=8M   BAR 9 (VF BAR 2)]
                                               [gap=1M]
     22ffffd00000-22ffffdfffff : 0000:31:00.0  [align=1M  size=1M   BAR 2]
                                               [gap=64K]
     22ffffe10000-22ffffe1ffff : 0000:31:00.0  [align=64K size=64K  BAR 0]
                                               [gap=256K]
     22ffffe60000-22ffffe7ffff : 0000:31:00.0  [align=16K size=128K BAR 11(VF BAR 4)]
     22ffffe80000-22ffffe9ffff : 0000:31:00.0  [align=16K size=128K BAR 7 (VF BAR 0)]
                                               [gap=8K]
     22ffffea2000-22ffffea3fff : 0000:31:00.0  [align=8K  size=8K   BAR 4]
                                               [gap=368K]

And then there is no suitable space available to satisfy both align=1M and size=8M (BAR 9),
that lead to "0000:31:00.1: VF BAR 2 [mem size 0x00800000 64bit pref]: can't assign; no space".

> There will still be some cases this greedy approach will not get right,
> such as align=2M,size=2M & align=1M,size=8M. This algorithm is not really
> designed for filling gaps in a window but the entire window from scratch,
> which is why it cannot handle all cases.
> 

Does the "remove & rescan" is still a corner case for kernel, especially that
only removing a single function rather than the entire device for a multi-function
device, even after you've fixed multiple issues in this scenario?

Does the community resent the issues caused by this scenario?

>> Appreciate any comment and suggestion, thanks.
>>
>> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
>> ---
>>   drivers/pci/setup-bus.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>> index 4cf120ebe5ad..63f224f0c6be 100644
>> --- a/drivers/pci/setup-bus.c
>> +++ b/drivers/pci/setup-bus.c
>> @@ -367,7 +367,8 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
>>   			align = pci_resource_alignment(dev_res->dev,
>>   							 dev_res->res);
>>   
>> -			if (r_align > align) {
>> +			if (r_align > align ||
>> +			    (r_align == align && resource_size(r) > resource_size(dev_res->res))) {
> 
> This is not the only place where the algorithm does sorting.
> 
> (And I also know one restore place is lacking restoring ordering.)
> 

Do you mean in __assign_resources_sorted(), retry normal assign after add_size
assign failed?

I noticed this function after being replied by Sashiko AI review.

> I was planning to move to rbtree for storing the resources that need to be
> in a certain order as doing it everywhere results in small variations
> which is error prone.
> 
> So maybe it would be time to consider moving to that so we could do the
> sort order in one place.
> 

Thank you for your guidance.

-- 
Thanks,
- Ding Hui

