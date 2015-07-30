Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36303 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbbG3QTC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2015 12:19:02 -0400
Received: by wicgb10 with SMTP id gb10so250958246wic.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2015 09:19:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55B9A554.9020901@roeck-us.net>
References: <1436292680-25111-1-git-send-email-linux@roeck-us.net>
 <20150729160903.GD31170@google.com> <CAE9FiQWr3-dw0FhgZjSq=pT-Cn3DaDV3E4QFjURJbQo_igQGNw@mail.gmail.com>
 <55B92DA5.4030409@roeck-us.net> <CAE9FiQXC5P3qZC7CS0UBq4=Uz9mcvgguP0EgV7G0x-PnRZn9-w@mail.gmail.com>
 <55B93151.8040608@roeck-us.net> <20150729202639.GA13239@google.com>
 <CAE9FiQVmek758ZG2MfPCK5RsgUAfuD6zW5zHWQkid1POALnZSQ@mail.gmail.com> <55B9A554.9020901@roeck-us.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 30 Jul 2015 11:18:40 -0500
Message-ID: <CAErSpo6SGXp7zNYENmaUPPNcQjHcPEJwc5Ezbs6W29Y2_9z6_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] PCI: Only enable IO window if supported
To: Guenter Roeck <linux@roeck-us.net>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 29, 2015 at 11:17 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 07/29/2015 08:59 PM, Yinghai Lu wrote:
>>
>> On Wed, Jul 29, 2015 at 1:26 PM, Bjorn Helgaas <bhelgaas@google.com>
>> wrote:
>>>
>>> On Wed, Jul 29, 2015 at 01:02:25PM -0700, Guenter Roeck wrote:
>>>>
>>>> Bjorn, how do you want to handle the flag problem ?
>>>> Do you have an idea on how to make it work with
>>>> the reversed definition ?
>>>
>>>
>>> I'll wait for the revised patch.  Sorry for screwing this up.
>>
>>
>> Please check attached updated version.
>>
>> Yinghai
>>
>
> My version is slightly different, but this one should work as well.
>
> The subject line got lost somehow.

Guenter, would you mind just sending me a fresh version of your patch
with whatever Yinghai tweaks you want to keep?

It's a PITA for me to deal with attachments.

Bjorn
