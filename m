Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A133D4FD;
	Thu,  2 Apr 2026 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114627; cv=none; b=gfUJITWidWEJDtjBhjxGcMMsSnDhAEkEIjdclZWEIJUW7ZzQA/IRgrAmsQLRMTWdagbUdGrfHOrcikxh85zoQZh1jrzQyQq93P5GenpZ6eRseM0m0igPT2gXKVeIvF8BJIuC5J0vuO0tZOzRv82Oy6OIkoHNyl4b94+CTF2onic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114627; c=relaxed/simple;
	bh=cgB8H9DlUIZ+uwTVcF6odwPEZPbboVTlUYsZmwBSBH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SCMkq8ysmxWDhwTRaXsojOz/GLXlZWZRaItmqIOrNOSZXxoclhp1ntGrJd/07LH2XhSRtE5xOPBl0uB6ispRYoTbCxsiOCuI5leJIJvQgxF8aHmD+Dbtzjx1mtpF6plBsQsP5+79e0KwSRc6p6V0forc7t0QE/Few/n8+t7XFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=l52Mp77a; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="l52Mp77a"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yp4FpjnLfYl5LRJx0uX5SvO3U1QpXS7va9VO6CIjnSA=;
	b=l52Mp77aSFW6AGyzkcFLE7JzoRCBTt4O50KG/TbASaTLPIx7RN74zpfMG3UzZIMqWj+fIklTW
	hThwh4ynoXj+nRn9uicynKa9B/WSPZilFP2x/a4+LMJnoasa/4GFZZQvytVK7MltJ6DUQ/XbKZ4
	GLOfnEk2BaFWs977lJf1Ehk=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fmY8F4hG7z12LCb;
	Thu,  2 Apr 2026 15:17:17 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 288F040538;
	Thu,  2 Apr 2026 15:23:43 +0800 (CST)
Received: from [100.103.109.121] (100.103.109.121) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Apr 2026 15:23:42 +0800
Message-ID: <502de80c-d062-4253-a2a3-cfb240d7dab2@huawei.com>
Date: Thu, 2 Apr 2026 15:23:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] PCI/sysfs: Fix null pointer dereference during
 hotplug
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <alex@shazbot.org>, <chrisw@redhat.com>,
	<jbarnes@virtuousgeek.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuyongqiang13@huawei.com>
References: <20260226171403.GA3813150@bhelgaas>
From: duziming <duziming2@huawei.com>
In-Reply-To: <20260226171403.GA3813150@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr500012.china.huawei.com (7.202.195.23)


在 2026/2/27 1:14, Bjorn Helgaas 写道:
> On Fri, Jan 16, 2026 at 04:17:19PM +0800, Ziming Du wrote:
>> During the concurrent process of creating and rescanning in VF, the
>> resource files for the same pci_dev may be created twice.
> Where are the two resource file creations?  This will help review the
> patch.
>
>> The second
>> creation attempt fails, resulting the res_attr in pci_dev to kfree(),
>> but the pointer is not set to NULL. This will subsequently lead to
>> dereferencing a null pointer when removing the device.
>>
>> When we perform the following operation:
>>    echo $sriov_totalvfs > /sys/class/net/"$pfname"/device/sriov_numvfs &
> I think it would be more informative to include an actual sample here.
> We can easily substitute the device names and numbers, given a
> concrete example.  It's a little bit harder to intuit what $pfname and
> $sriov_totalvfs should be.  E.g.,
>
>    $ cat /sys/bus/pci/devices/0000:02:00.0/sriov_totalvfs
>    128
>    $ echo 128 > /sys/bus/pci/devices/0000:02:00.0/sriov_numvfs &
>
> Unless it's important to use /sys/class/net/..., use
> /sys/bus/pci/devices/... both places to make it simpler.
>
>>    sleep 0.5
>>    echo 1 > /sys/bus/pci/rescan
> These look like shell commands ...
>
>>    pci_remove "$pfname"
> but what is "pci_remove"?  I guess it must be an echo into
> /sys/bus/pci/devices/.../remove; expanding it here would be better.
>
>> system will crash as follows:
>>
>>    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
>>    Call trace:
>>     __pi_strlen+0x14/0x150
>>     kernfs_find_ns+0x54/0x120
>>     kernfs_remove_by_name_ns+0x58/0xf0
>>     sysfs_remove_bin_file+0x24/0x38
>>     pci_remove_resource_files+0x44/0x90
>>     pci_remove_sysfs_dev_files+0x28/0x40
>>     pci_stop_bus_device+0xb8/0x118
>>     pci_stop_and_remove_bus_device+0x20/0x40
>>     pci_iov_remove_virtfn+0xb8/0x138
>>     sriov_disable+0xbc/0x190
>>     pci_disable_sriov+0x30/0x48
>>     hinic_pci_sriov_disable+0x54/0x138 [hinic]
>>     hinic_remove+0x140/0x290 [hinic]
>>     pci_device_remove+0x4c/0xf8
>>     device_remove+0x54/0x90
>>     device_release_driver_internal+0x1d4/0x238
>>     device_release_driver+0x20/0x38
>>     pci_stop_bus_device+0xa8/0x118
>>     pci_stop_and_remove_bus_device_locked+0x28/0x50
>>     remove_store+0x128/0x208
>>
>> Fix this by set the pointer to NULL after releasing 'res_attr' immediately.
> This *sounds* like it would still be racy unless there's a lock around
> this.  If there is a lock, please mention what it is and where it's
> held.

I found that the primary race condition between VF creation and PCI 
rescan has been

addressed by the pci_lock_rescan_remove() lock added in commit 
a5338e365c45.

Given this, would setting the pointer to NULL after kfree still be 
considered a worthwhile defensive measure?

>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Ziming Du <duziming2@huawei.com>
>> ---
>>   drivers/pci/pci-sysfs.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 18e5d4603b472..fbcbf39232732 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -1227,12 +1227,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
>>   		if (res_attr) {
>>   			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>>   			kfree(res_attr);
>> +			pdev->res_attr[i] = NULL;
>>   		}
>>   
>>   		res_attr = pdev->res_attr_wc[i];
>>   		if (res_attr) {
>>   			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>>   			kfree(res_attr);
>> +			pdev->res_attr_wc[i] = NULL;
>>   		}
>>   	}
>>   }
>> -- 
>> 2.43.0
>>
