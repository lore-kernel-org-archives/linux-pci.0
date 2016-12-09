Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:65337 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752375AbcLIHrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2016 02:47:47 -0500
Subject: Re: [PATCH] pci-error-recover: doc cleanup
To: <linasvepstas@gmail.com>
References: <1481184974-12505-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <20161208070539.0f00ce71@lwn.net> <58496AA4.5030602@cn.fujitsu.com>
 <CAHrUA35PMscQrohN_wPgip2tM-+OiHmQT1_uhPc75=GeHvkpaw@mail.gmail.com>
CC: Jonathan Corbet <corbet@lwn.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <584A513B.9080409@cn.fujitsu.com>
Date: Fri, 9 Dec 2016 14:37:47 +0800
MIME-Version: 1.0
In-Reply-To: <CAHrUA35PMscQrohN_wPgip2tM-+OiHmQT1_uhPc75=GeHvkpaw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 12/09/2016 02:24 PM, Linas Vepstas wrote:
> I suppose I'm confused, but I recall that link resets are non-fatal.
> Fatal errors typically require that the the pci adapter be completely
> reset, any adapter firmware to be reloaded from scratch, the device
> driver has to kill all device state and start from scratch. Its huge.
> If the fatal error is on pci device that is under a block device
> holding a file system, then (usually) there is no way to recover,
> because the block layer (and file system) cannot deal with a block
> device that disappeared and then reappeared some few seconds later.
> (maybe some future zfs or lvm or btrfs might be able to deal with
> this, but not today)
> 
> By contrast, link resets are far more gentle: the device driver might
> have to discard some half-full FIFO's, or cancel some in-flight
> commands, but can otherwise gracefully recover without telling the
> higher layers that there were any problems.
> 
> --linas
> 

I am little confused too, even not sure if we are talking the same
*fatal error*, I am talking the fatal error defined in PCI Express spec,
chapter 6.2.2.2.1:

Fatal errors are uncorrectable error conditions which render the
particular Link and related hardware unreliable. For Fatal errors, a
reset of the components on the Link may be required to return to
reliable operation. Platform handling of Fatal errors, and any efforts
to limit the effects of these errors, is platform implementation specific.

Link reset means set *secondary bus reset* bit in pci bridge config
space, can reset the link and device simultaneously, is the strongest
kind of reset as I know.

> On Thu, Dec 8, 2016 at 10:13 PM, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>>
>>
>> On 12/08/2016 10:05 PM, Jonathan Corbet wrote:
>>> On Thu, 8 Dec 2016 16:16:14 +0800
>>> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>>>
>>>>  The platform resets the link, and then calls the link_reset() callback
>>>>  on all affected device drivers.  This is a PCI-Express specific state
>>>> -and is done whenever a non-fatal error has been detected that can be
>>>> +and is done whenever a fatal error has been detected that can be
>>>>  "solved" by resetting the link. This call informs the driver of the
>>>
>>> As far as I can tell, the original text was correct here; why do you
>>> think this change needs to be made?
>>>
>>
>> See do_recovery() in aer core, reset_link() is called only seeing fatal
>> error.
>>
>> --
>> Sincerely,
>> Cao jin
>>
>>
> 
> 
> 

-- 
Sincerely,
Cao jin


