Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:36106 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbbIUHtt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2015 03:49:49 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWxiLV0YeWfUAd=vJaxtV-0PrqBqm1ptKnFoEM0jQDaiQ@mail.gmail.com>
References: <CAKsTQnn-+13Q=+hM581p=dvWnZXtnG6W-t5K4-ioNUTkEmyLMg@mail.gmail.com>
	<CAE9FiQXaOkMKk2PddYOXApK9tKLkgusH18sYgvLHA04BRdXR-g@mail.gmail.com>
	<CAKsTQn=u5HuMCz5_L1jbx6Fvz5Rf_e14tNeEPwxy1o8dxk4J8g@mail.gmail.com>
	<CAE9FiQWxiLV0YeWfUAd=vJaxtV-0PrqBqm1ptKnFoEM0jQDaiQ@mail.gmail.com>
Date: Mon, 21 Sep 2015 09:49:49 +0200
Message-ID: <CAKsTQn=skDo7mbTrvFfQHW+nD1Ggy-g+qT922WOrjiwqyK5BwQ@mail.gmail.com>
Subject: Re: PCIe bus (re-)numbering
From: Ruud <netwerkforens@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>       /sbin/setpci -s $NAME 0x1a.b=0
>       N=`find /sys/devices/pci0000:"$BUS"/"$NAME"/remove -name "remove"`
>       echo $N
>       echo -n 1 > "$N"
>       sleep 1s
>     done
> done
>

Thanks for the script!

>
>>
>> I will test next monday.
>
> Good. Please check current upstream and my tree for-pci-v4.3-rc1 branch.


Sorry for the rookie question: which version do you mean by "current
upstream", the current main trunk rc?.
I am currently using for-pci-v4.3-rc1 for testing.

>> Are these settings in the binary driver? I do not see that much need
>> for a driver to use the geographical addressing after the BAR's have
>> been set. I thus wondered if it is feasable to hide the geographical
>> addressing from the driver and offer an API for it from the PCIe layer
>> to the drivers...
>
> Card firmware.  Assume those card firmware would trap pci conf read cycle
> and compare something inside.
> The only workaround that I found is reset the link to make firmware rebooting.
> but that will have problem if you are use the disk as root etc.
>

I do not completely understand the remark you make, are you suggesting
the firmware running on the PCIe card (embedded in a CPU on the card
itself) is acting on the content of the busnumber or do you mean x86
extension rom code acting on the busnumber.

Although it is probably irrelevant for the problem I like to solve, I
still like to understand all details.


> Thanks
>
> Yinghai

BR,

Ruud
