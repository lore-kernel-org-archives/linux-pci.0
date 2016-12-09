Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34007 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbcLIGoq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2016 01:44:46 -0500
MIME-Version: 1.0
Reply-To: linasvepstas@gmail.com
In-Reply-To: <584A513B.9080409@cn.fujitsu.com>
References: <1481184974-12505-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <20161208070539.0f00ce71@lwn.net> <58496AA4.5030602@cn.fujitsu.com>
 <CAHrUA35PMscQrohN_wPgip2tM-+OiHmQT1_uhPc75=GeHvkpaw@mail.gmail.com> <584A513B.9080409@cn.fujitsu.com>
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Fri, 9 Dec 2016 14:44:25 +0800
Message-ID: <CAHrUA36r3o3ziEdMz-8=w5XTymsMQZYRXXrCt=H+1F3M4+6RnQ@mail.gmail.com>
Subject: Re: [PATCH] pci-error-recover: doc cleanup
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 9, 2016 at 2:37 PM, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>
>
> On 12/09/2016 02:24 PM, Linas Vepstas wrote:
>> I suppose I'm confused, but I recall that link resets are non-fatal.
>> Fatal errors typically require that the the pci adapter be completely
>> reset, any adapter firmware to be reloaded from scratch, the device
>> driver has to kill all device state and start from scratch. Its huge.
>> If the fatal error is on pci device that is under a block device
>> holding a file system, then (usually) there is no way to recover,
>> because the block layer (and file system) cannot deal with a block
>> device that disappeared and then reappeared some few seconds later.
>> (maybe some future zfs or lvm or btrfs might be able to deal with
>> this, but not today)
>>
>> By contrast, link resets are far more gentle: the device driver might
>> have to discard some half-full FIFO's, or cancel some in-flight
>> commands, but can otherwise gracefully recover without telling the
>> higher layers that there were any problems.
>>
>> --linas
>>
>
> I am little confused too, even not sure if we are talking the same
> *fatal error*, I am talking the fatal error defined in PCI Express spec,
> chapter 6.2.2.2.1:
>
> Fatal errors are uncorrectable error conditions which render the
> particular Link and related hardware unreliable. For Fatal errors, a
> reset of the components on the Link may be required to return to
> reliable operation. Platform handling of Fatal errors, and any efforts
> to limit the effects of these errors, is platform implementation specific.
>
> Link reset means set *secondary bus reset* bit in pci bridge config
> space, can reset the link and device simultaneously, is the strongest
> kind of reset as I know.

OK, well, its been far too many years, and I don't have the PCI spec
at my fingertips.
Isn't there a link reset that can be performed, without forcing a device reset?

The intent was that some PCI link errors are due to vibration,
ground-bounce, humidity, etc. and that these errors can be detected
and do not corrupt the device state or the device driver state.  Since
they are not associated with data corruption (or rather, the
corruption is local to the link), these can be recovered by reseting
just the link, without resetting the whole adapter. They may require
reseting some device-driver state, but not all of it.

However, this was all decided before the PCI-E spec was written, so
maybe the newer PCI-E specs now say something different.

--linas

>
>> On Thu, Dec 8, 2016 at 10:13 PM, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>>>
>>>
>>> On 12/08/2016 10:05 PM, Jonathan Corbet wrote:
>>>> On Thu, 8 Dec 2016 16:16:14 +0800
>>>> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>>>>
>>>>>  The platform resets the link, and then calls the link_reset() callback
>>>>>  on all affected device drivers.  This is a PCI-Express specific state
>>>>> -and is done whenever a non-fatal error has been detected that can be
>>>>> +and is done whenever a fatal error has been detected that can be
>>>>>  "solved" by resetting the link. This call informs the driver of the
>>>>
>>>> As far as I can tell, the original text was correct here; why do you
>>>> think this change needs to be made?
>>>>
>>>
>>> See do_recovery() in aer core, reset_link() is called only seeing fatal
>>> error.
>>>
>>> --
>>> Sincerely,
>>> Cao jin
>>>
>>>
>>
>>
>>
>
> --
> Sincerely,
> Cao jin
>
>
