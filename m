Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:61300 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755552Ab3GYNOK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2013 09:14:10 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so1465629obb.0
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2013 06:14:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4J+69VeSiLceeV8U322ZgtWw099wRBUyjzF_eSE7+8Hg@mail.gmail.com>
References: <20130723180001.19616.72450.stgit@bhelgaas-glaptop>
	<20130723180821.19616.52936.stgit@bhelgaas-glaptop>
	<CAE9FiQU5-rjWir=NvwEs0vEMmSL9qps6NAa2QFO7yNrLzrx26A@mail.gmail.com>
	<CAErSpo4J+69VeSiLceeV8U322ZgtWw099wRBUyjzF_eSE7+8Hg@mail.gmail.com>
Date: Thu, 25 Jul 2013 06:14:09 -0700
Message-ID: <CAE9FiQVXY4-J6u5HTLA3q5VY+D74W91hzpnLZTYBMgb1Jad7oA@mail.gmail.com>
Subject: Re: [PATCH] PCI: pciehp: Convert pciehp to be builtin only, not modular
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 24, 2013 at 10:59 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Jul 23, 2013 at 5:10 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Tue, Jul 23, 2013 at 11:08 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> Convert pciehp to be builtin only, with no module option.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> ---
>>>  drivers/pci/pcie/Kconfig |    5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
>>> index 569f82f..3b94cfc 100644
>>> --- a/drivers/pci/pcie/Kconfig
>>> +++ b/drivers/pci/pcie/Kconfig
>>> @@ -14,15 +14,12 @@ config PCIEPORTBUS
>>>  # Include service Kconfig here
>>>  #
>>>  config HOTPLUG_PCI_PCIE
>>> -       tristate "PCI Express Hotplug driver"
>>> +       bool "PCI Express Hotplug driver"
>>>         depends on HOTPLUG_PCI && PCIEPORTBUS
>>
>> HOTPLUG_PCI is still tristate,
>>
>>  menuconfig HOTPLUG_PCI
>>         tristate "Support for PCI Hotplug"
>>
>>
>> Can you make HOTPLUG_PCI to be built-in ?
>
> Is that necessary for this CONFIG_HOTPLUG_PCI_PCIE change?  The config
> tools are smart enough to only offer CONFIG_HOTPLUG_PCI_PCIE as an
> option when CONFIG_HOTPLUG_PCI=y, so I'm not sure it's actually a
> problem yet.

a little weird.
before this change normally
CONFIG_HOTPLUG_PCI=m, and CONFIG_HOTPLUG_PCI_PCIE=m.

now if user may select
CONFIG_HOTPLUG_PCI=m, and CONFIG_HOTPLUG_PCI_PCIE=y
never test that if it is really work.

>
>> or to be more aggressive, just kill HOTPLUG_PCI as with HOTPLUG.
>
> Getting rid of CONFIG_HOTPLUG let us get rid of all the __devinit*
> markings, which helps avoid a whole class of bugs.  That doesn't apply
> to CONFIG_HOTPLUG_PCI, of course.
>
> But if somebody wants to do the work and see if it's useful to remove
> CONFIG_HOTPLUG_PCI, I'm certainly willing to consider it.  I'm sure
> most general-purpose distros will set CONFIG_HOTPLUG_PCI=y and
> CONFIG_HOTPLUG_PCI_PCIE=y, but I wouldn't be surprised if embedded
> folks still leave them both disabled.

ok, let's leave HOTPLUG_PCI alone.

Yinghai
