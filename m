Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51065 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab2FKWAo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jun 2012 18:00:44 -0400
Received: by lbbgm6 with SMTP id gm6so3163664lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 11 Jun 2012 15:00:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXPHp0Pubs3eQc_TqKFhBvVTwZNDgSuDSBFa8rj31phGQ@mail.gmail.com>
References: <1338190380-5144-1-git-send-email-jiang.liu@huawei.com>
 <CAE9FiQWTP1PP6hcfJ=ru5J=_dLH+q5oy4-OEg-Ws-2xWkxyGLg@mail.gmail.com>
 <CAErSpo450AHHHm1PgCi+ELrhosuwGSg3BnX_Ff2v4dC1h-v_Pg@mail.gmail.com> <CAE9FiQXPHp0Pubs3eQc_TqKFhBvVTwZNDgSuDSBFa8rj31phGQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 11 Jun 2012 16:00:22 -0600
Message-ID: <CAErSpo6rZ2VNLhAUhy-TNAq9yOuWZPQxsXGc=Pe0E9UnsSqDow@mail.gmail.com>
Subject: Re: [PATCH] PCI: export symbol pci_bus_sem to module
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Wu Fengguang <fengguang.wu@intel.com>,
	Amos Kong <kongjianjun@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 11, 2012 at 2:01 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Mon, Jun 11, 2012 at 10:43 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Fri, Jun 8, 2012 at 12:01 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Mon, May 28, 2012 at 12:33 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
>>>> Changeset "9080648 PCI: acpiphp: remove all functions in slot,
>>>> even without ACPI _EJx" introduces pci_bus_sem into the acpiphp
>>>> driver, but pci_bus_sem hasn't been exported to modules yet.
>>>> So export symbol pci_bus_sem to modules, otherwise the acpiphp
>>>> driver can't be built as module any more.
>>>>
>>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>>> Signed-off-by: Jiang Liu <liuj97@gmail.com>
>>>> ---
>>>>  drivers/pci/search.c |    2 ++
>>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
>>>> index 9d75dc8..e0c7a22 100644
>>>> --- a/drivers/pci/search.c
>>>> +++ b/drivers/pci/search.c
>>>> @@ -15,6 +15,8 @@
>>>>  #include "pci.h"
>>>>
>>>>  DECLARE_RWSEM(pci_bus_sem);
>>>> +EXPORT_SYMBOL(pci_bus_sem);
>>>> +
>>>>  /*
>>>>  * find the upstream PCIe-to-PCI bridge of a PCI device
>>>>  * if the device is PCIE, return NULL
>>>
>>> Bjorn,
>>>
>>> can you please fold this one into
>>>
>>> 9080648:
>>> PCI: acpiphp: remove all functions in slot, even without ACPI _EJx
>>>
>>> that commit now is in pci/for-3.6
>>
>> Yes, I'll fix this.  If you don't object, I'll make it
>> EXPORT_SYMBOL_GPL().  I think we'll have more changes in the bus
>> scan/remove paths, and it's possible we'll be able to un-export this
>> in the future.
>
> yes, it should be EXPORT_SYMBOL_GPL.

I applied this to my "next" branch, with EXPORT_SYMBOL_GPL.  Thanks!
