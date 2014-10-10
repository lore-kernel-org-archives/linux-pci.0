Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:48906 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbaJJQln (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Oct 2014 12:41:43 -0400
Received: by mail-qa0-f49.google.com with SMTP id f12so1867131qad.36
        for <linux-pci@vger.kernel.org>; Fri, 10 Oct 2014 09:41:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <543804BC.3080307@maya.org>
References: <20140923210318.498dacbd@dualc.maya.org> <1411502866.24563.8.camel@ul30vt.home>
 <5437A958.3000201@maya.org> <CAErSpo5kkk4itqqmCMU=08-XMcDknur8VY++F3A2LajdvTptOA@mail.gmail.com>
 <5437F1F5.3010706@maya.org> <CAErSpo6DuWEcJb_gfS=5JnKN8b4DXXV9+u-CRa8m3db0dbzpsQ@mail.gmail.com>
 <543804BC.3080307@maya.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 10 Oct 2014 10:41:22 -0600
Message-ID: <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through (vfio)
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 10, 2014 at 10:09 AM, Andreas Hartmann
<andihartmann@freenet.de> wrote:
> Bjorn Helgaas wrote:
>> On Fri, Oct 10, 2014 at 8:49 AM, Andreas Hartmann
>> <andihartmann@freenet.de> wrote:
>>> Bjorn Helgaas wrote:
>>>> On Fri, Oct 10, 2014 at 3:39 AM, Andreas Hartmann
>>>> <andihartmann@freenet.de> wrote:
>>>>> shortly: I retested w/ qemu 2.1.0 and Linux 3.17.0 - no change in behaviour.
>>>>>
>>>>> Alex Williamson wrote:
>>>>>> On Tue, 2014-09-23 at 21:03 +0200, Andreas Hartmann wrote:
>>>>>>> Hello!
>>>>>>>
>>>>>>> Since long time now, I'm using w/o any problem PCIe pass through with a
>>>>>>> Gigabyte GA-990XA-UD3/GA-990XA-UD3 mainboard (AMD 990X chipset) and
>>>>>>> enabled IOMMU with vfio-pci.
>>>>>>>
>>>>>>> The last kernel working w/o any problem is kernel 3.13.7 (I didn't use
>>>>>>> .8 and .9, but I do not think they would have been problematic).
>>>>>>>
>>>>>>> Since 3.14.19 (I didn't test any 3.14 kernel before) I'm encountering a
>>>>>>> hard and silent lock up of the complete machine when starting the VM
>>>>>>> with the PCIe card passed through.
>>>>
>>>> Since we're not really making any progress on this yet, would it be
>>>> possible to bisect it?  We already know that 3.13.7 works and 3.14.19
>>>> fails, and "git bisect start v3.14 v3.13" says it's about 13 steps.  I
>>>> know that's still quite a bit of work, but at least it sounds like the
>>>> problem is easy to reproduce.
>>>
>>> Which git repository should I use best?
>>
>> The linux-stable repository [1] contains both the v3.13.x and the
>> v3.14.x branches, but apparently you can't bisect directly between
>> v3.13.7 and v3.14.19:
>
> I know that the first version after 3.13.0 (patch-v3.13-next-20140121)
> is already broken. Therefore, it must be between 3.13.7 and
> patch-v3.13-next-20140121.

I assume patch-v3.13-next-20140121 is the linux-next tree from
20140121.  v3.13 was released on Jan 19, 2014, so 20140121 was during
the merge window, and the linux-next tree from that day would be
Linus' tree (v3.13 plus whatever he had merged during the first day or
two), plus all the remaining stuff in subsystem trees that had not yet
been merged.  The result (patch-v3.13-next-20140121) should be a
fairly good approximation of v3.14.

v3.13.7 is a branch based on v3.13.  patch-v3.13-next-20140121 would
essentially be a branch based on v3.13 also.  So while they share a
common v3.13 ancestor, I don't think you can bisect directly between
them.  And linux-next is rebuilt from scratch every day, so I don't
think there is a git tree with patch-v3.13-next-20140121 in it anyway.

Bjorn
