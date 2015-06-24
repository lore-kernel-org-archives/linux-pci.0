Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:62616 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933761AbbFXBrh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2015 21:47:37 -0400
Message-ID: <558A0C35.5000708@huawei.com>
Date: Wed, 24 Jun 2015 09:47:33 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/3] Trivial pci hotplug changes
References: <1434700666-6346-1-git-send-email-wangyijing@huawei.com> <20150619171417.GL7710@google.com>
In-Reply-To: <20150619171417.GL7710@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/20 1:14, Bjorn Helgaas wrote:
> On Fri, Jun 19, 2015 at 03:57:43PM +0800, Yijing Wang wrote:
>>
>> Yijing Wang (3):
>>   PCI: Use "slot" and "pci_slot" for struct hotplug_slot and struct
>>     pci_slot
>>   PCI: Simplify pcie_poll_cmd()
>>   PCI: Use usleep_range() instead of msleep() for better accuracy
> 
> I applied the first two to pci/hotplug for v4.2, thanks!
> 
> I dropped the third, as explained in my response to it.

Thanks!

> 
> Bjorn
> 
> 


-- 
Thanks!
Yijing

