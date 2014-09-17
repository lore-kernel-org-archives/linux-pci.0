Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:48965 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbaIQQgV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 17 Sep 2014 12:36:21 -0400
Received: by mail-la0-f54.google.com with SMTP id ge10so2156578lab.41
        for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2014 09:36:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5419AE7E.4030203@redhat.com>
References: <bug-84761-41252@https.bugzilla.kernel.org/> <CAErSpo5yPJxReveBN5ofcr==2fUkfv8D9uO7rqHj_uFK54se1w@mail.gmail.com>
 <5419AE7E.4030203@redhat.com>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Wed, 17 Sep 2014 18:35:59 +0200
Message-ID: <CAMxnaaX9AcPQhpMaQn+Hn4JmcSLJxgHj+waCiJxF1uZDF5tGxw@mail.gmail.com>
Subject: Re: [Bug 84761] New: LSI controller not found when specifying pci=assign-busses
To: David Milburn <dmilburn@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 17, 2014 at 5:53 PM, David Milburn <dmilburn@redhat.com> wrote:
> Hi,
>
>
> On 09/17/2014 10:38 AM, Bjorn Helgaas wrote:
>>
>> [+cc Andreas, linux-pci, thanks for the bugzilla; please continue
>> discussion in email]
>>
>> On Wed, Sep 17, 2014 at 7:48 AM,  <bugzilla-daemon@bugzilla.kernel.org>
>> wrote:
>>>
>>> https://bugzilla.kernel.org/show_bug.cgi?id=84761
>>>
>>>              Bug ID: 84761
>>>             Summary: LSI controller not found when specifying
>>>                      pci=assign-busses
>>>             Product: Drivers
>>>             Version: 2.5
>>>      Kernel Version: linux-3.17.0-rc2
>>>            Hardware: All
>>>                  OS: Linux
>>>                Tree: Mainline
>>>              Status: NEW
>>>            Severity: normal
>>>            Priority: P1
>>>           Component: PCI
>>>            Assignee: drivers_pci@kernel-bugs.osdl.org
>>>            Reporter: dmilburn@redhat.com
>>>          Regression: No
>>>
>>> Created attachment 150651
>>>    --> https://bugzilla.kernel.org/attachment.cgi?id=150651&action=edit
>>> Patch to change pcibios_assign_all_busses check in pci_scan_bridge()
>>>
>>> When booting with kernel command line option "pci=assign-busses", LSI
>>> controller
>>> is no longer found.
>>>
>>> 05:00.0 SCSI storage controller: LSI Logic / Symbios Logic SAS1068E
>>> PCI-Express
>>> Fusion-MPT SAS (rev 08)
>>>
>>> It seems the problem is in pci_scan_bridge (drivers/pci/probe.c):
>>>
>>> [    2.542563] PCI_READ_BRIDGE_BASES:
>>> [    2.545953] PCI_SCAN_BRIDGE:
>>> [    2.548823] scanning [bus 01-01] behind bridge, pass 0
>>> [    2.553947] PCI_SCAN_BRIDGE:
>>> [    2.556818] scanning [bus 05-05] behind bridge, pass 0
>>> <=========PROBLEM
>>> [    2.561942] PCI_SCAN_BRIDGE:
>>> [    2.564812] scanning [bus 06-06] behind bridge, pass 0
>>> [    2.569936] PCI_SCAN_BRIDGE:
>>> [    2.572806] scanning [bus 03-03] behind bridge, pass 0
>>> [    2.577930] PCI_SCAN_BRIDGE:
>>> [    2.580800] scanning [bus 02-02] behind bridge, pass 0
>>> [    2.585923] PCI_SCAN_BRIDGE:
>>> [    2.588793] scanning [bus 04-04] behind bridge, pass 0
>>>
>>> If I change the pass 0 check from !pcibios_assign_all_busses() to
>>> pcibios_assign_all_busses() it finds the LSI controller; however, it
>>> looks
>>> like pci_scan_bridge has checked !pcibios_assisng_all_bussses() for a
>>> very long time.
>>> (changed code in pci_scan_bridge, causes driver to head down that first
>>> path)
>>>    if ((secondary || subordinate) && pcibios_assign_all_busses() &&
>>>        !is_cardbus && !broken) {
>>>
Well, not taking that branch is the main effect of pci=assign-busses.
Negating the check should be equivalent to not specifying
pci=assign-busses. Does this actually fix the problem (the SR-IOV
message)?

Can you attach the full dmesg of the failed boot to the bugzilla
report. If pci=assign-busses is specified then we only scan during the
second pass.

This is again an LSI card. Looks like they don't take bus changes very well.
>>> [    2.560225] PCI_SCAN_BRIDGE: secondary 1 subordinate 1 is_cardbus 0
>>> broken 0
>>> [    2.567252] PCI_SCAN_BRIDGE: !pcibios_assign_all_busses() 0
>>>   .
>>>   .
>>> [    2.849864] scanning [bus 05-05] behind bridge, pass 0
>>> <=====SCANNING
>>> [    2.854988] PCI_SCAN_BRIDGE: CHECKING FOR ASSIGN_ALL_BUSSES
>>> [    2.860544] PCI_SCAN_BRIDGE: secondary 5 subordinate 5 is_cardbus 0
>>> broken 0
>>> [    2.867572] PCI_SCAN_BRIDGE: !pcibios_assign_all_busses() 0
>>> [    2.873126] PCI_SCAN_BRIDGE: ASSIGN_ALL_BUSSES child           (null)
>>> [    2.879546] PCI_ADD_NEW_BUS busnr 5:
>>> [    2.883109] PCI_ALLOC_CHILD_BUS:
>>> [    2.886327] PCI_SET_BUS_SPEED:
>>> [    2.889407] PCI_BUS_INSERT_BUSN_RES:
>>> [    2.892971] PCI_SCAN_CHILD_BUS:
>>> [    2.896100] PCI_SCAN_CHILD_BUS: scanning bus
>>> [    2.900357] PCI_SCAN_SLOT:
>>> [    2.903053] PCI_SCAN_SINGLE_DEVICE:
>>> [    2.906529] PCI_SCAN_DEVICE: devfn 0
>>> [    2.910093] PCI_BUS_READ_DEV_VENDOR_ID: devfn 0
>>> [    2.914608] PCI_ALLOC_DEV:
>>> [    2.917305] PCI_SETUP_DEVICE:
>>> [    2.920262] SET_PCIE_PORT_TYPE:       =====DEVICE FOUND BELOW=====
>>> [    2.923399] pci 0000:05:00.0: [1000:0058] type 00 class 0x010000
>>> [    2.923401] [1000:0058] type 00 class 0x010000
>>> [    2.927841] pci 0000:05:00.0: reg 0x10: [io  0xec00-0xecff]
>>> [    2.927852] pci 0000:05:00.0: reg 0x14: [mem 0xde2ec000-0xde2effff
>>> 64bit]
>>> [    2.927863] pci 0000:05:00.0: reg 0x1c: [mem 0xde2f0000-0xde2fffff
>>> 64bit]
>>> [    2.927877] pci 0000:05:00.0: reg 0x30: [mem 0xde100000-0xde1fffff
>>> pref]
>>> [    2.927879] PCI_DEVICE_ADD:
>>
>>
>> Tangent: why do you need "pci=assign-busses"?  If that's necessary to
>> make some device work, I think that's a different bug in itself.
>
>
> User reported trying this as
>
> As a workaround for
> igb 0000:06:00.1: SR-IOV: bus number out of range
>>
>> Is this a regression?
>
>
> It was reproduced on RHEL6.1, so I don't think so. So far I have
> reproduced on upstream linux-3.17.0-rc2 and -rc5.
>
>>
>> Can you attach complete dmesg logs with and without "pci=assign-busses"?
>
>
> Ok, I will attach the logs to the BZ.
>
>>
>> We have a couple patches that are candidates for reversion before
>> v3.17 because of similar issues (I think they're good patches, but we
>> may need some additional work to fix some other problems they
>> exposed).  If you want to try them, they're here:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/reverts
>
>
> Ok, I will give them a try.
>
> Thanks,
> David
>
>>
>> Bjorn
>>
>
