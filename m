Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:61980 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755208Ab2KABln (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 31 Oct 2012 21:41:43 -0400
Message-ID: <5091D30B.7040600@cn.fujitsu.com>
Date: Thu, 01 Nov 2012 09:40:27 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	yinghai@kernel.org
CC: bhelgaas@google.com, lenb@kernel.org, jiang.liu@huawei.com,
	izumi.taku@jp.fujitsu.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] ACPI: container hot remove support.
References: <1351668471-31436-1-git-send-email-tangchen@cn.fujitsu.com> <509106E2.70008@jp.fujitsu.com>
In-Reply-To: <509106E2.70008@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/31/2012 07:09 PM, Yasuaki Ishimatsu wrote:
> Hi Tang,
> 
> If container device contains memory device, the function is
> very danger. As you know, we are developing a memory hotplug.
> If memory has kernel memory, memory hot remove operations fails.
> But container_device_remove() cannot realize it. So even if
> the memory hot remove operation fails, container_device_remove()
> keeps hot remove operation. Finally, the function sends _EJ0
> to firmware. In this case, if the memory is accessed, kernel
> panic occurs.
> The example is as follows:
> 
>   https://lkml.org/lkml/2012/9/26/318
> 
Hi Ishimatsu,

I see, thanks for the info. So we need to do some roll back thing.

Is anyone doing this now ?
If yes, would you please give me some links to refer to ? And I think I
should push these patches later.
If not, I think I can try to do it.

Thanks. :)
