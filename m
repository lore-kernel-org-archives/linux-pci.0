Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34974 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932760AbbLNWfx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2015 17:35:53 -0500
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <CAA93t1roq4xmeqHjTSKsrO-8VKiRN0aK4_LU1p3pQLGicWy7fw@mail.gmail.com>
References: <1450119766-28102-1-git-send-email-rajatja@google.com>
	<20151214214022.GA24226@kroah.com>
	<CAA93t1roq4xmeqHjTSKsrO-8VKiRN0aK4_LU1p3pQLGicWy7fw@mail.gmail.com>
Date: Mon, 14 Dec 2015 14:35:52 -0800
Message-ID: <CAA93t1o2dvcngg2qftKeY9XeZUK_0kNZOmb4_JKC+Yb=+K5HNQ@mail.gmail.com>
Subject: Re: [PATCH] kobject: Ensure child's resources get released before
 parent's resources
From: Rajat Jain <rajatxjain@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rajat Jain <rajatja@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Fixed the linux-pci mailing list address]

On Mon, Dec 14, 2015 at 2:33 PM, Rajat Jain <rajatxjain@gmail.com> wrote:
> On Mon, Dec 14, 2015 at 1:40 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Mon, Dec 14, 2015 at 11:02:46AM -0800, Rajat Jain wrote:
>>> If the only remaining reference to a parent, is the one taken by
>>> the child (in kobject_add_internal()), then when the last
>>> reference to the child goes away, both child and its parents
>>> shall be released. However, currently the resources of parent
>>> get released first, followed by the child's resources:
>>>
>>> kobject_cleanup(child)
>>>     ....
>>>     kobject_del(child)
>>>         ....
>>>         kobject_put(child->parent) -> results in parent's release()
>>>         ...
>>>     child->kobj_type->release() -> Child's release()
>>>
>>> This is a problem because the child's release() method may still
>>> need to use parent resources or memory for its own cleanup. E.g.
>>> child may need parent pointer for dma_free_coherent() etc.
>>>
>>> Signed-off-by: Rajat Jain <rajatja@google.com>
>>> Signed-off-by: Rajat Jain <rajatxjain@gmail.com>
>>
>> Why are you listed twice here?
>
> Ah, sorry, I'll remove that.
>
>>
>> Where in the kernel is the parent being freed before the child that is
>> causing this issue to happen?  We should fix that root cause first...
>
> Umm, are you saying that it is a bug to reach a scenario where all
> references to a parent, except the ones made by the child, are gone?
>
> Sorry, I should have given more context here. Here is the scenario
> where I came across this situation, and I'd appreciate any suggestions
> on how to better deal with this situation:
>
> I have 2 modules (random names here):
>
> user_interface.ko <--- pci_driver.ko
>
> 1) user_interface.ko
>      - exports some interfaces (char driver etc) to the userspace,
>      - allows low-level device drivers to register devices via some
> API (user_interface_add() / user_interface_del())
>      - Userspace can issue some transactions. Each transaction results
> in a child kobject being attached to the device's kobject.
>      - Low level drivers also provide a release() function that can
> get called AFTER user_interface_del() if there are transactions
> in-flight.
>      - Low level drivers should allow operation of the device until
> release() gets called.
>
> 2) Low level drivers such as pci_driver.ko:
>     - attach to the actual physical devices (PCI device in this case)
>     - create a custom device (that has an embedded "struct device")
> and register this new custom device with the user_interface.ko.
>     - also attaches a release() function to the device. This release()
> would get called when all references to the device are dropped.
>     - The entities holding the reference to the device are:
>           * 1 reference by the pci_driver.ko itself (when it did
> device_initialize())
>           * 1 reference by the user_interface.ko (During user_interface_add())
>           * 1 reference for each transaction in-flight (a child
> kobject under the device)
>
> 3) Now, we want to allow removing (rmmod) the low level driver pci_driver.ko.
>     - Before returning from PCI remove method, need to ensure that
> release() has been called.
>     - So we do call user_interface_del(dev) - drops the reference that
> user_interface.ko was holding.
>     - pci_driver.ko gives up its own reference so that release()
> method can get called.
>     - At this time, the device is just waiting for transactions
> in-flight to get completed i.e only the child kobjects hold the
> references.
>
> When the last transaction gets completed, I end up in the situation
> described in the patch commit log. I'd be very glad if you can provide
> suggestions on how to achieve this or if there is anything I am
> missing?
>
> On a side note, my poor understanding of the device model came out to
> that it does (or may be should) guarantee that all children are freed
> before the parent is freed. Is that not the case?
>
> Thanks,
>
> Rajat
>
>>
>> thanks,
>>
>> greg k-h
