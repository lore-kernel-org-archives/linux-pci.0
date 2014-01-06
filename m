Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:31552 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbaAFBIr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jan 2014 20:08:47 -0500
Message-ID: <52CA020C.60206@huawei.com>
Date: Mon, 6 Jan 2014 09:08:28 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <guohanjun@huawei.com>
Subject: Re: [PATCH v3] sparc/PCI: Use dev_is_pci() to identify PCI devices
References: <1386741626-35744-1-git-send-email-wangyijing@huawei.com> <20140104.210533.653844636617320862.davem@davemloft.net>
In-Reply-To: <20140104.210533.653844636617320862.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/1/5 10:05, David Miller wrote:
> From: Yijing Wang <wangyijing@huawei.com>
> Date: Wed, 11 Dec 2013 14:00:26 +0800
> 
>> Use dev_is_pci() instead of checking bus type directly.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Applied.
> 
> 
Hi David,
   This patch has been merged in Bjorn's pci tree, so will have some conflict between yours and Bjorn's tree?

-- 
Thanks!
Yijing

