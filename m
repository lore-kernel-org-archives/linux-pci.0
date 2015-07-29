Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60078 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbG2USS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2015 16:18:18 -0400
Message-ID: <55B93507.6070101@roeck-us.net>
Date: Wed, 29 Jul 2015 13:18:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v2] PCI: Only enable IO window if supported
References: <1436292680-25111-1-git-send-email-linux@roeck-us.net>	<20150729160903.GD31170@google.com>	<CAE9FiQWr3-dw0FhgZjSq=pT-Cn3DaDV3E4QFjURJbQo_igQGNw@mail.gmail.com>	<55B92DA5.4030409@roeck-us.net> <CAE9FiQXC5P3qZC7CS0UBq4=Uz9mcvgguP0EgV7G0x-PnRZn9-w@mail.gmail.com>
In-Reply-To: <CAE9FiQXC5P3qZC7CS0UBq4=Uz9mcvgguP0EgV7G0x-PnRZn9-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/29/2015 12:53 PM, Yinghai Lu wrote:
> On Wed, Jul 29, 2015 at 12:46 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 07/29/2015 12:30 PM, Yinghai Lu wrote:
>>
>>>
>>> so PCI_BUS_FLAGS_SUPPORTS_IO will never get set.
>>>
>>
>> excellent catch. Unfortunately, I don't know how to make it
>> work with the reversed flag. The idea here was that the flag
>> propagates from parent to child. This makes sense for an
>> "it doesn't work" flag to be inherited from the child,
>> but not for an "it works" flag.
>>
>
> also would be better if we can add has_ioport in hostbridge instead.
> like has_mem64 in https://patchwork.ozlabs.org/patch/500926/
> and use
>
> to_pci_host_bridge(bus->bridge)->has_ioport
>
> to replace pci_root_has_io_resource()
>

Is there a function to get the root bus ? Otherwise I still need to
find the root bus first.

Guenter

