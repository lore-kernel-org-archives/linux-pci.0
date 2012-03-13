Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([119.145.14.67]:44102 "EHLO
	szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759355Ab2CMHYy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Mar 2012 03:24:54 -0400
Date: Tue, 13 Mar 2012 15:23:30 +0800
From: Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH 2/5] Correctly clean up pci root buses in function
 pci_remove_bus()
In-reply-to: <CAE9FiQVRMBHN+QbFpVv4j2xPfco2X0bt9OzzcSE-BrrDY4Oqgg@mail.gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Youquan Song <youquan.song@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenkeping@huawei.com
Message-id: <4F5EF5F2.2000507@huawei.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <1331488109-13466-1-git-send-email-jiang.liu@huawei.com>
 <1331488109-13466-3-git-send-email-jiang.liu@huawei.com>
 <CAE9FiQVRMBHN+QbFpVv4j2xPfco2X0bt9OzzcSE-BrrDY4Oqgg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,
	Good points! It's safe with current implementation because
all root bus hotplug operations are under protection of 
pci_remove_rescan_mutex.

On 2012-3-13 14:24, Yinghai Lu wrote:
> On Sun, Mar 11, 2012 at 10:48 AM, Jiang Liu<liuj97@gmail.com>  wrote:
>> The function pci_create_root_bus() allocates the pci bus structure,
>> registers the bus device and creates the legacy files for a pci root
>> bus, but returns without setting the is_added flag. The is_added flag
>> for a pci root bus will be set by function pci_scan_child_bus().
>
>> If a pci root bus is destroyed before calling pci_scan_child_bus(),
>> the is_added flag will not be set.
>
> how that can be met?
>
> Do we have pci_remove_rescan_mutex around them?
>
> Yinghai
>
>


