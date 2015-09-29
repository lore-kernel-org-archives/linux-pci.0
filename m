Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36238 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516AbbI2OEJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 10:04:09 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWxBWaJh0CbbEfeBUJK+54NDrTW6r0v-6itXEyTkmzkhQ@mail.gmail.com>
References: <CAKsTQnn-+13Q=+hM581p=dvWnZXtnG6W-t5K4-ioNUTkEmyLMg@mail.gmail.com>
	<CAE9FiQXaOkMKk2PddYOXApK9tKLkgusH18sYgvLHA04BRdXR-g@mail.gmail.com>
	<CAKsTQn=u5HuMCz5_L1jbx6Fvz5Rf_e14tNeEPwxy1o8dxk4J8g@mail.gmail.com>
	<CAE9FiQWxiLV0YeWfUAd=vJaxtV-0PrqBqm1ptKnFoEM0jQDaiQ@mail.gmail.com>
	<CAKsTQn=skDo7mbTrvFfQHW+nD1Ggy-g+qT922WOrjiwqyK5BwQ@mail.gmail.com>
	<CAKsTQn=aigrfTz5hYmzvERK3w6Ax1yxEyZfzWt_NaT6d+-DYuA@mail.gmail.com>
	<CAE9FiQWxBWaJh0CbbEfeBUJK+54NDrTW6r0v-6itXEyTkmzkhQ@mail.gmail.com>
Date: Tue, 29 Sep 2015 16:04:07 +0200
Message-ID: <CAKsTQnkBPEiUtpaVxyDm--BLnHvUCtVMhEUQ5-FQryp-X9HBUg@mail.gmail.com>
Subject: Re: PCIe bus (re-)numbering
From: Ruud <netwerkforens@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>
>> Thus the procedure that works is:
>> 1) Chassis off
>> 2) Boot linux
>> 3) Chassis on
>> 4) setpci busnrs to 0
>> 5) remove switch
>> 6) rescan
>
> 4, 5 is reversed?

I can not setpci on a removed device, afaik.... for that reason I
reset the busses before removing the switch (not physically remove but
echo 1 >../remove).

For the kernel crash issue I will try to explain better, and try to
get a kernel crash dump to post some logging. It seems that the switch
will still fire hotplug events even after being removed (see lspci -tv
below). I zero-ed the busnumber for bus 04 (02.0-[04-17])  without
removing the underlying bus 05 device 00.0 and switches below.

(for illustration, lspci -tv from a 3.2 kernel, hand edited as the
original picture has already discovered the subordinate busses)
            +-02.0-[04-17]----00.0-[05-17]--+-04.0-[06-16]----00.0-[07-16]---
             |                               |
      \-08.0-[11-16]----

Sorry for the delay, but I didn't manage to create a crashdump yet :(
and the BMC is not cooperative in getting the serial console kernel
working either.
Will not go into details on my attempts for the kernel crash logging
to work as it is out of scope for the discussion..

Bet regards, Ruud
