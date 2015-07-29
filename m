Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:33673 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbG2UV7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 16:21:59 -0400
Received: by ioii16 with SMTP id i16so33412581ioi.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2015 13:21:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55B93507.6070101@roeck-us.net>
References: <1436292680-25111-1-git-send-email-linux@roeck-us.net>
	<20150729160903.GD31170@google.com>
	<CAE9FiQWr3-dw0FhgZjSq=pT-Cn3DaDV3E4QFjURJbQo_igQGNw@mail.gmail.com>
	<55B92DA5.4030409@roeck-us.net>
	<CAE9FiQXC5P3qZC7CS0UBq4=Uz9mcvgguP0EgV7G0x-PnRZn9-w@mail.gmail.com>
	<55B93507.6070101@roeck-us.net>
Date: Wed, 29 Jul 2015 13:21:58 -0700
Message-ID: <CAE9FiQWxMjJQBw6iQqtQxsBYG8-jxneia_8hrEm-JQH=6rCCTA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] PCI: Only enable IO window if supported
From: Yinghai Lu <yinghai@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 1:18 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/29/2015 12:53 PM, Yinghai Lu wrote:
>>
>> On Wed, Jul 29, 2015 at 12:46 PM, Guenter Roeck <linux@roeck-us.net>
>> wrote:
>>>
>>> On 07/29/2015 12:30 PM, Yinghai Lu wrote:
>>>
>>>>
>>>> so PCI_BUS_FLAGS_SUPPORTS_IO will never get set.
>>>>
>>>
>>> excellent catch. Unfortunately, I don't know how to make it
>>> work with the reversed flag. The idea here was that the flag
>>> propagates from parent to child. This makes sense for an
>>> "it doesn't work" flag to be inherited from the child,
>>> but not for an "it works" flag.
>>>
>>
>> also would be better if we can add has_ioport in hostbridge instead.
>> like has_mem64 in https://patchwork.ozlabs.org/patch/500926/
>> and use
>>
>> to_pci_host_bridge(bus->bridge)->has_ioport
>>
>> to replace pci_root_has_io_resource()
>>
>
> Is there a function to get the root bus ? Otherwise I still need to
> find the root bus first.
host-bridge and rootbus is one to one mapping.

drivers/pci/host-bridge.c has related function.


Yinghai
