Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:37124 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab2JIIRv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Oct 2012 04:17:51 -0400
Message-ID: <5073DD4A.1070908@huawei.com>
Date: Tue, 9 Oct 2012 16:16:10 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Hanjun Guo <guohanjun@huawei.com>, <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 0/7] disable bridge ari forwarding after connected ari
 device hot removed
References: <1349751804-7476-1-git-send-email-wangyijing@huawei.com> <50739D40.8040005@huawei.com> <5073D56C.40705@huawei.com> <5073D76C.9090304@huawei.com> <5073DCCB.2050503@huawei.com>
In-Reply-To: <5073DCCB.2050503@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012-10-9 16:14, Yijing Wang wrote:
> On 2012/10/9 15:51, Jiang Liu wrote:
>> When scanning PCI devices for hot-add, it guarantee function 0 is scanned
>> at first. And when destroying PCI devices for hot-removal, we also need to
>> destroy function 0 at last, but currently there's no such guarantees. 
>>
> 
> This is an issue, btw in pciehp now only try to hot remove fun from 0 --> 8,
> ARI device supports up to 256 function device.
> for (j = 0; j < 8; j++) {
> 	struct pci_dev *temp = pci_get_slot(parent, PCI_DEVFN(0, j));
> 	if (!temp)
> 		continue;
Another patch to fix.

