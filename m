Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55752 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbbGaBhV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2015 21:37:21 -0400
Message-ID: <55BAD14E.9020300@roeck-us.net>
Date: Thu, 30 Jul 2015 18:37:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>
CC: linux-pci@vger.kernel.org, rajatja@google.com, rjw@rjwysocki.net
Subject: Re: [PATCH v2 0/2] Fix a deadlock for aer and pciehp driver
References: <1437124592-2070-1-git-send-email-wangyijing@huawei.com> <20150730212026.GK9640@google.com>
In-Reply-To: <20150730212026.GK9640@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/30/2015 02:20 PM, Bjorn Helgaas wrote:
> On Fri, Jul 17, 2015 at 05:16:30PM +0800, Yijing Wang wrote:
>> Yijing Wang (2):
>>    PCI: Use a local mutex instead of pci_bus_sem to avoid deadlock
>>    PCI: Lock pci_slot_mutex when traverse bus->slots
>
> Applied to pci/hotplug for v4.3 with changelogs as follows, thanks!
>

Hi Bjorn,

I don't see pci/hotplug in
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/.

Is that a different repository ?

Thanks,
Guenter

