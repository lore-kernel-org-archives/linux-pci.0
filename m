Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:51452 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756517Ab3GYQsS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2013 12:48:18 -0400
Received: by mail-ob0-f172.google.com with SMTP id f8so2079950obp.3
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2013 09:48:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVXY4-J6u5HTLA3q5VY+D74W91hzpnLZTYBMgb1Jad7oA@mail.gmail.com>
References: <20130723180001.19616.72450.stgit@bhelgaas-glaptop>
 <20130723180821.19616.52936.stgit@bhelgaas-glaptop> <CAE9FiQU5-rjWir=NvwEs0vEMmSL9qps6NAa2QFO7yNrLzrx26A@mail.gmail.com>
 <CAErSpo4J+69VeSiLceeV8U322ZgtWw099wRBUyjzF_eSE7+8Hg@mail.gmail.com> <CAE9FiQVXY4-J6u5HTLA3q5VY+D74W91hzpnLZTYBMgb1Jad7oA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 25 Jul 2013 10:47:57 -0600
Message-ID: <CAErSpo67PyXCnU=7hv6kbq17nXqX8oryyy-azRJs=QV=5195kQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Convert pciehp to be builtin only, not modular
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 25, 2013 at 7:14 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Jul 24, 2013 at 10:59 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, Jul 23, 2013 at 5:10 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On Tue, Jul 23, 2013 at 11:08 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>> Convert pciehp to be builtin only, with no module option.
>>>>
>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> ---
>>>>  drivers/pci/pcie/Kconfig |    5 +----
>>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
>>>> index 569f82f..3b94cfc 100644
>>>> --- a/drivers/pci/pcie/Kconfig
>>>> +++ b/drivers/pci/pcie/Kconfig
>>>> @@ -14,15 +14,12 @@ config PCIEPORTBUS
>>>>  # Include service Kconfig here
>>>>  #
>>>>  config HOTPLUG_PCI_PCIE
>>>> -       tristate "PCI Express Hotplug driver"
>>>> +       bool "PCI Express Hotplug driver"
>>>>         depends on HOTPLUG_PCI && PCIEPORTBUS
>>>
>>> HOTPLUG_PCI is still tristate,
>>>
>>>  menuconfig HOTPLUG_PCI
>>>         tristate "Support for PCI Hotplug"
>>>
>>>
>>> Can you make HOTPLUG_PCI to be built-in ?
>>
>> Is that necessary for this CONFIG_HOTPLUG_PCI_PCIE change?  The config
>> tools are smart enough to only offer CONFIG_HOTPLUG_PCI_PCIE as an
>> option when CONFIG_HOTPLUG_PCI=y, so I'm not sure it's actually a
>> problem yet.
>
> a little weird.
> before this change normally
> CONFIG_HOTPLUG_PCI=m, and CONFIG_HOTPLUG_PCI_PCIE=m.
>
> now if user may select
> CONFIG_HOTPLUG_PCI=m, and CONFIG_HOTPLUG_PCI_PCIE=y
> never test that if it is really work.

Ooh, you're right!  I tried CONFIG_HOTPLUG_PCI=m and
CONFIG_HOTPLUG_PCI_PCIE=y, and config *allows* that and builds a
working kernel (though pciehp doesn't actually work), even though I
don't think menuconfig will actually generate that combination.  I'll
convert CONFIG_HOTPLUG_PCI to a bool as well.

Bjorn
