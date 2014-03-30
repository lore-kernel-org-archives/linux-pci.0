Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:62342 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbaC3UKl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 30 Mar 2014 16:10:41 -0400
Received: by mail-la0-f49.google.com with SMTP id mc6so5039560lab.8
        for <linux-pci@vger.kernel.org>; Sun, 30 Mar 2014 13:10:39 -0700 (PDT)
Message-ID: <53387A41.70507@cogentembedded.com>
Date: Mon, 31 Mar 2014 00:10:41 +0400
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

    And neither do I see it in other lists.

>>> I can have a look a reposting it.

>>     It doesn't apply to the current renesas.git devel branch. What tree
>> it was against?

    Looks like you had some patches to the PCI driver before this one. I've 
just found something in Bjorn's pci.git repo's next branch...

>  From my records it was against the -rc3 release of Horms' development
> tree. I know Simon's tree has been closed for the board bits, but I
> could re-send the rcar-pci code.

    The patch does applies cleanly to pci.git's next branch (it has a trailing 
whitespace though), so no dire need to re-post. I'm not sure if the new 
version of the patch could still be merged there, as Linus was going to 
release 3.14 and so open the merge window this weekend.

WBR, Sergei

