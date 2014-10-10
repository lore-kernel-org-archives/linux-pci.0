Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout3.freenet.de ([195.4.92.93]:49318 "EHLO mout3.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755268AbaJJWie (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Oct 2014 18:38:34 -0400
Date: Sat, 11 Oct 2014 00:32:19 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through
 (vfio)
Message-ID: <20141011003219.560cca97@dualc.maya.org>
In-Reply-To: <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>
References: <20140923210318.498dacbd@dualc.maya.org> <1411502866.24563.8.camel@ul30vt.home> <5437A958.3000201@maya.org> <CAErSpo5kkk4itqqmCMU=08-XMcDknur8VY++F3A2LajdvTptOA@mail.gmail.com> <5437F1F5.3010706@maya.org> <CAErSpo6DuWEcJb_gfS=5JnKN8b4DXXV9+u-CRa8m3db0dbzpsQ@mail.gmail.com> <543804BC.3080307@maya.org> <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas wrote:
> On Fri, Oct 10, 2014 at 10:09 AM, Andreas Hartmann
> <andihartmann@freenet.de> wrote:
>> Bjorn Helgaas wrote:
>>> On Fri, Oct 10, 2014 at 8:49 AM, Andreas Hartmann
>>> <andihartmann@freenet.de> wrote:
>>>> Bjorn Helgaas wrote:
>>>>> On Fri, Oct 10, 2014 at 3:39 AM, Andreas Hartmann
>>>>> <andihartmann@freenet.de> wrote:
>>>>>> shortly: I retested w/ qemu 2.1.0 and Linux 3.17.0 - no change in behaviour.
>>>>>>
>>>>>> Alex Williamson wrote:
>>>>>>> On Tue, 2014-09-23 at 21:03 +0200, Andreas Hartmann wrote:
>>>>>>>> Hello!
>>>>>>>>
>>>>>>>> Since long time now, I'm using w/o any problem PCIe pass through with a
>>>>>>>> Gigabyte GA-990XA-UD3/GA-990XA-UD3 mainboard (AMD 990X chipset) and
>>>>>>>> enabled IOMMU with vfio-pci.
>>>>>>>>
>>>>>>>> The last kernel working w/o any problem is kernel 3.13.7 (I didn't use
>>>>>>>> .8 and .9, but I do not think they would have been problematic).
>>>>>>>>
>>>>>>>> Since 3.14.19 (I didn't test any 3.14 kernel before) I'm encountering a
>>>>>>>> hard and silent lock up of the complete machine when starting the VM
>>>>>>>> with the PCIe card passed through.
>>>>>
>>>>> Since we're not really making any progress on this yet, would it be
>>>>> possible to bisect it?  We already know that 3.13.7 works and 3.14.19
>>>>> fails, and "git bisect start v3.14 v3.13" says it's about 13 steps.  I
>>>>> know that's still quite a bit of work, but at least it sounds like the
>>>>> problem is easy to reproduce.
>>>>
>>>> Which git repository should I use best?
>>>
>>> The linux-stable repository [1] contains both the v3.13.x and the
>>> v3.14.x branches, but apparently you can't bisect directly between
>>> v3.13.7 and v3.14.19:
>>
>> I know that the first version after 3.13.0 (patch-v3.13-next-20140121)
>> is already broken. Therefore, it must be between 3.13.7 and
>> patch-v3.13-next-20140121.


Ok, this is the result of git bisect:

425c1b223dac456d00a61fd6b451b6d1cf00d065 is the first bad commit
commit 425c1b223dac456d00a61fd6b451b6d1cf00d065
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Tue Dec 17 16:43:51 2013 -0700

    PCI: Add Virtual Channel to save/restore support
    
    While we don't really have any infrastructure for making use of VC
    support, the system BIOS can configure the topology to non-default
    VC values prior to boot.  This may be due to silicon bugs, desire to
    reserve traffic classes, or perhaps just BIOS bugs.  When we reset
    devices, the VC configuration may return to default values, which can
    be incompatible with devices upstream.  For instance, Nvidia GRID 
    cards provide a PCIe switch and some number of GPUs, all supporting 
    VC.  The power-on default for VC is to support TC0-7 across VC0,
    however some platforms will only enable TC0/VC0 mapping across the 
    topology.  When we do a secondary bus reset on the downstream switch 
    port, the GPU is reset to a TC0-7/VC0 mapping while the opposite end 
    of the link only enables TC0/VC0.  If the GPU attempts to use TC1-7, 
    it fails. 

    This patch attempts to provide complete support for VC save/restore, 
    even beyond the minimally required use case above.  This includes 
    save/restore and reload of the arbitration table, save/restore and 
    reload of the port arbitration tables, and re-enabling of the 
    channels for VC, VC9, and MFVC capabilities. 

    Signed-off-by: Alex Williamson <alex.williamson@redhat.com> 
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>


Kind regards,
Andreas
