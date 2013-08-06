Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:64902 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab3HFIEa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 04:04:30 -0400
Message-ID: <5200ADF7.80006@huawei.com>
Date: Tue, 6 Aug 2013 16:04:07 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Li Zefan <lizefan@huawei.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Jon Mason <jdmason@kudzu.us>, <stable@vger.kernel.org>
Subject: Re: [PATCH -v2] PCI: update device mps when doing pci hotplug
References: <1375773838-33572-1-git-send-email-wangyijing@huawei.com> <5200A7D2.3080001@huawei.com>
In-Reply-To: <5200A7D2.3080001@huawei.com>
Content-Type: text/plain; charset="GB2312"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/8/6 15:37, Li Zefan wrote:
> On 2013/8/6 15:23, Yijing Wang wrote:
>> v1->v2: Update patch log, remove Joe's reported-by, because his problem
>>         was mainly caused by BIOS incorrect setting. But this patch mainly
>> 		to fix the bug caused by device hot add. Conservatively, this 
>> 		version only update the mps problem when hot add. When the device
>> 		mps < parent mps found, this patch try to update device mps.
>> 		It seems unlikely device mps > parent mps after hot add device.
>> 		So we don't care that situation.
>>
>> This patch need to be applied to stable 3.4+
> 
> In this case...
> 
>>
>> Currently we don't update device's mps vaule when doing
>> pci device hot-add. The hot-added device's mps will be set
>> to default value (128B). But the upstream port device's mps
>> may be larger than 128B which was set by firmware during
>> system bootup. In this case the new added device may not
>> work normally. This patch try to update the hot added device
>> mps euqal to its parent mps, if device mpss < parent mps,
>> print warning.
>>
>> References: https://bugzilla.kernel.org/show_bug.cgi?id=60671
>> Reported-by: Yijing Wang <wangyijing@huawei.com>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> Cc: Jon Mason <jdmason@kudzu.us>
>> Cc: stable@vger.kernel.org
> 
> The better tag is:
> 
> Cc: <stable@vger.kernel.org> # 3.4+
> 
> Otherwise you won't be notified if it can be applied to the most recent
> stable version but failed in older versions.

Will update, thanks!

> 
> 
> .
> 


-- 
Thanks!
Yijing

