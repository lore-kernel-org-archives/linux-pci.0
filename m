Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AA42EBDC0;
	Fri, 27 Feb 2026 02:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159457; cv=none; b=iQQ7obBMz4Y/1st2SQlFR9Ypp1X5kgkvglHZhsZm9thwNnqZG022BBS+LKDp6EsDalUOSrJ6h+Da0oKeYIeszYECYcERsL4QmN48hE7+XjuwIplBtN5yIbhyDn3Yss5HKFjzaDS53Yo+w5J0bCOz1kVzl8EfxArPJGrwB+1rrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159457; c=relaxed/simple;
	bh=Tr1SdXgtxRBGiGdhE93Pm5Gn9MA3VCZp8A9/MTTjaEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dYb/I0LLYPNklWp97ybyr9mOCU9lwkCt29IqW4ZoO7s4nEh3M9SuemS9Pr858yAqpKtwg/EOkvabP3ATcuuv0mSRDHf6HddO+B8qjvuF0HJ2Xo20JcMk43gPVuZUL4c67cc/uBgadP1F3TbhlZXweZflqAwBexSsSQyq8T8etTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CGotrYbY; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CGotrYbY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=g+KnSBSARpE0upmUpjuCGIWvUr9YRXkowCqRjqqEsYM=;
	b=CGotrYbYn94W8U9IndfdE5qrPupeMpgyluRbKsB+LKk1QeOOUAAO4DktjknA3Cr6t7LerG4WZ
	driQLZJ+lORZXNQl6/K4q8YDPA/uDuJ5xEwf85JFz+eX3SJs187bRbTxCJODRtD5O5wSRboLpW8
	85ZHPQkRo8exfun1XMC7jEw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fMXHt6yX8zKmZ2;
	Fri, 27 Feb 2026 10:26:02 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 784E940565;
	Fri, 27 Feb 2026 10:30:51 +0800 (CST)
Received: from [100.103.109.121] (100.103.109.121) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Feb 2026 10:30:50 +0800
Message-ID: <a4b352e3-3517-4f1c-a469-37f7205ddfdd@huawei.com>
Date: Fri, 27 Feb 2026 10:30:50 +0800
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

The process of creating VFs:

sriov_numvfs_store
     hinic_pci_sriov_configure
         hinic_pci_sriov_enable
             pci_enable_sriov
                 sriov_enable
                     sriov_add_vfs
                         pci_iov_add_virtfn
                             pci_bus_add_device
                                 pci_create_sysfs_dev_files
                                     pci_create_resource_files

The process of rescanning VFs:

rescan_store
     pci_rescan_bus
         pci_bus_add_devices
             pci_bus_add_device
                 pci_create_sysfs_dev_files
                     pci_create_resource_files

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

Yes, you are right, based on your comments, I have revised it as follows:

$ cat /sys/bus/pci/devices/0000:02:00.0/sriov_totalvfs
128
$ echo 128 > /sys/bus/pci/devices/0000:02:00.0/sriov_numvfs &
$ sleep 0.5
$ echo 1 > /sys/bus/pci/rescan
$ echo 1 > /sys/bus/pci/devices/0000:02:00.0/remove

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

The rescan process holds pci_lock_rescan_remove(), while the creation 
process

holds "device_lock(&pdev->dev)"

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
