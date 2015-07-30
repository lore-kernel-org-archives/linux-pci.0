Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59842 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbG3ER1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2015 00:17:27 -0400
Message-ID: <55B9A554.9020901@roeck-us.net>
Date: Wed, 29 Jul 2015 21:17:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v2] PCI: Only enable IO window if supported
References: <1436292680-25111-1-git-send-email-linux@roeck-us.net>	<20150729160903.GD31170@google.com>	<CAE9FiQWr3-dw0FhgZjSq=pT-Cn3DaDV3E4QFjURJbQo_igQGNw@mail.gmail.com>	<55B92DA5.4030409@roeck-us.net>	<CAE9FiQXC5P3qZC7CS0UBq4=Uz9mcvgguP0EgV7G0x-PnRZn9-w@mail.gmail.com>	<55B93151.8040608@roeck-us.net>	<20150729202639.GA13239@google.com> <CAE9FiQVmek758ZG2MfPCK5RsgUAfuD6zW5zHWQkid1POALnZSQ@mail.gmail.com>
In-Reply-To: <CAE9FiQVmek758ZG2MfPCK5RsgUAfuD6zW5zHWQkid1POALnZSQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/29/2015 08:59 PM, Yinghai Lu wrote:
> On Wed, Jul 29, 2015 at 1:26 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Wed, Jul 29, 2015 at 01:02:25PM -0700, Guenter Roeck wrote:
>>> Bjorn, how do you want to handle the flag problem ?
>>> Do you have an idea on how to make it work with
>>> the reversed definition ?
>>
>> I'll wait for the revised patch.  Sorry for screwing this up.
>
> Please check attached updated version.
>
> Yinghai
>

My version is slightly different, but this one should work as well.

The subject line got lost somehow.

Guenter

