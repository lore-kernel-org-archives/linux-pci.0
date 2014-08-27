Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20140827210405.GA26372@kroah.com>
References: <1409144277-23379-1-git-send-email-ricardo.ribalda@gmail.com>
 <20140827202301.GA13800@kroah.com> <20140827205129.GA25227@kroah.com>
 <CAPybu_2p0UroO=WwUOC3LybPq0HQymoD50v6-6gA+aVweveOHw@mail.gmail.com> <20140827210405.GA26372@kroah.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Wed, 27 Aug 2014 23:10:42 +0200
Message-ID: <CAPybu_2p6+VXj0s+yWGRvTO-1W-=rkhCBVKFHqa25joEO+Q3zA@mail.gmail.com>
Subject: Re: [PATCH] pci/pci-sysfs: Set pci interface in uppercase
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Greg

On Wed, Aug 27, 2014 at 11:04 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Aug 27, 2014 at 10:56:57PM +0200, Ricardo Ribalda Delgado wrote:
>> No worries,
>>
>> I have to mark for stable it or Bjorn? It it is me, how :) ?
>
> Bjorn can when he applies it, for details on the process, see the kernel
> file Documentation/stable_kernel_rules.txt
>
>> ps: For other people reading this thread, the kmod/modprobe is in
>> http://anonscm.debian.org/cgit/users/md/kmod.git/tree/libkmod/libkmod-index.c
>> and handles all the modalias as strings without differing the type.
>
> That sounds wrong, and odds are, will cause more problems over time.
> These are hex values, not strings :(

I totally see your point, but I disagree on the method.

I think is our resposibility (modalias/file2alias) to provide a
matcheable string, otherwise modprobe should be aware of all the types
(pci, usb, spi, vmbus.....)

As we keep adding types, and they don't follow any standard, we would
be adding a dependecy between kmod and the kernel, and duplicating
code.  That is bad systemwise

Maybe the code on kmod should not be case sensitive, that is all :)

>
> thanks,
>
> greg k-h

Thanks



-- 
Ricardo Ribalda
