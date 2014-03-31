Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:49537 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbaCaVXx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 31 Mar 2014 17:23:53 -0400
Received: by mail-la0-f50.google.com with SMTP id pv20so1991441lab.23
        for <linux-pci@vger.kernel.org>; Mon, 31 Mar 2014 14:23:52 -0700 (PDT)
Message-ID: <5339DCE6.70505@cogentembedded.com>
Date: Tue, 01 Apr 2014 01:23:50 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Ben Dooks <ben.dooks@codethink.co.uk>
CC: linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@lists.codethink.co.uk, magnus.damn@opensource.se,
	horms@verge.net.au, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/9] pci-rcar-gen2: add devicetree support
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk> <1394128887-4197-2-git-send-email-ben.dooks@codethink.co.uk> <5318BCAE.7000108@codethink.co.uk> <53386C2F.1090508@cogentembedded.com> <53386E9D.70803@codethink.co.uk> <53386FE1.5000002@cogentembedded.com> <53387336.2000306@codethink.co.uk>
In-Reply-To: <53387336.2000306@codethink.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 03/30/2014 11:40 PM, Ben Dooks wrote:

>>>>>> Add OF match table for pci-rcar-gen2 driver for device tree support.
>>>> [...]

>>>>>> diff --git a/drivers/pci/host/pci-rcar-gen2.c
>>>>>> b/drivers/pci/host/pci-rcar-gen2.c
>>>>>> index fd3e3ab..1216784 100644
>>>>>> --- a/drivers/pci/host/pci-rcar-gen2.c
>>>>>> +++ b/drivers/pci/host/pci-rcar-gen2.c
>>>>>> @@ -16,6 +16,7 @@
>>>>>>   #include <linux/kernel.h>
>>>>>>   #include <linux/module.h>
>>>>>>   #include <linux/pci.h>
>>>>>> +#include <linux/of_pci.h>
>>>>>>   #include <linux/platform_device.h>
>>>>>>   #include <linux/pm_runtime.h>
>>>>>>   #include <linux/sizes.h>

>>>>> Apologies all, there's a missing include of <linux/of.h> which should
>>>>> have been added here

>>>>     Have you ever re-posted this patch fixed? If not, it's not going to
>>>> be merged for 3.15 I guess...

>>> I thought I did.

>>     I don't see such repost in 'linux-sh'.

>>> I can have a look a reposting it.

>>     It doesn't apply to the current renesas.git devel branch. What tree
>> it was against?

>  From my records it was against the -rc3 release of Horms' development
> tree. I know Simon's tree has been closed for the board bits, but I
> could re-send the rcar-pci code.

    Could you address my comments and re-send? Or if you don't have time, 
would you mind that I take this patch into my hands?

WBR, Sergei

