Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36162 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470AbbGaPbu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2015 11:31:50 -0400
Received: by wicgj17 with SMTP id gj17so22860477wic.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2015 08:31:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55BAD14E.9020300@roeck-us.net>
References: <1437124592-2070-1-git-send-email-wangyijing@huawei.com>
 <20150730212026.GK9640@google.com> <55BAD14E.9020300@roeck-us.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 31 Jul 2015 10:31:29 -0500
Message-ID: <CAErSpo4o_U1CO2AwbtrMttvfS0Gk7i_tBSCpH-2r-YbGwxeu+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Fix a deadlock for aer and pciehp driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatja@google.com>,
	Rafael Wysocki <rjw@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 30, 2015 at 8:37 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/30/2015 02:20 PM, Bjorn Helgaas wrote:
>>
>> On Fri, Jul 17, 2015 at 05:16:30PM +0800, Yijing Wang wrote:
>>>
>>> Yijing Wang (2):
>>>    PCI: Use a local mutex instead of pci_bus_sem to avoid deadlock
>>>    PCI: Lock pci_slot_mutex when traverse bus->slots
>>
>>
>> Applied to pci/hotplug for v4.3 with changelogs as follows, thanks!
>>
>
> Hi Bjorn,
>
> I don't see pci/hotplug in
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/.
>
> Is that a different repository ?

Sorry, I just hadn't pushed it because I have some more hotplug
patches and thought I'd push them all at once.  I pushed it now (and
will probably push some more updates soon).

Bjorn
