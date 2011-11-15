Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40690 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab1KOSPL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2011 13:15:11 -0500
Received: by yenq3 with SMTP id q3so923841yen.19
        for <linux-pci@vger.kernel.org>; Tue, 15 Nov 2011 10:15:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <af06626e34e32043e3c4974290270ec1.squirrel@webmail.sf-mail.de>
References: <bd3514f0-1a80-45ac-a08e-b327a367b276@zmail15.collab.prod.int.phx2.redhat.com>
 <4EBD73C8.8070407@redhat.com> <CAErSpo5eZ=4yqnMFpFjTOqGvK6p4mOmsppJbodeGe+vkjfKdbw@mail.gmail.com>
 <4EBD8714.30401@redhat.com> <4EC12962.2040105@redhat.com> <20111114181418.GE4387@parisc-linux.org>
 <4EC28B93.1060101@redhat.com> <af06626e34e32043e3c4974290270ec1.squirrel@webmail.sf-mail.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 15 Nov 2011 11:14:50 -0700
Message-ID: <CAErSpo5=YFNMcDt59JU2HQJV2EZpy1khLLCxyPAf49w8m4=kOA@mail.gmail.com>
Subject: Re: [PATCH] pci: Workaround Stratus broken PCIE hierarchy
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Prarit Bhargava <prarit@redhat.com>,
	Matthew Wilcox <matthew@wil.cx>,
	Don Dutile <ddutile@redhat.com>,
	James Paradis <jparadis@redhat.com>, linux-pci@vger.kernel.org,
	mstowe@redhat.com, jbarnes@virtuousgeek.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 15, 2011 at 9:08 AM, Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
>> Trying [v2]....
>>
>>
>> pci: Workaround Stratus broken PCIE hierarchy
>>
>> Stratus systems have a hierarchy that includes a PCIE Downstream bridge
>> connected to a PCIE Upstream bridge and a PCI Downstream bridge.  The
>> system
>> boots with this wrong hierarchy into a crippled mode (USB doesn't work,
>> network doesn't work ...).  Avoiding the Downstream bridge check in
>> only_one_child() causes all the bridges to be enumerated and the system
>> to function properly.
>>
>> Unfortunately this hardware is currently available so we should at least
>> keep it functional.
>>
>> [v2]
>> - ddutile@redhat.com requested drivers/pci/quirks.c code
>> - matthew@will.cx requested that dmi_name_in_vendors() be called only once
>> with a static var check
>> - added a kernel parameter to enable scanning of all PCIE devices.
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 6f45a73..f478bd5 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3589,6 +3589,9 @@ static int __init pci_setup(char *str)
>>                               pcie_bus_config = PCIE_BUS_PERFORMANCE;
>>                       } else if (!strncmp(str, "pcie_bus_peer2peer", 18)) {
>>                               pcie_bus_config = PCIE_BUS_PEER2PEER;
>> +                     } else if (!strncmp(str, "pcie_scan_all", 13)) {
>> +                             printk(KERN_ERR HW_ERR "PCIE: Scanning all devices.\n");
>> +                             pcie_scan_all = 1;
>>                       } else {
>>                               printk(KERN_ERR "PCI: Unknown option `%s'\n",
>>                                               str);
>
> To scan all devices isn't an error, is it? The user has requested this, so
> KERN_INFO should be enough.
>
> Eike

Is this problem a regression?  If so, what commit caused it?
f07852d6442, which introduced only_one_child()?

Does Windows work on this system?

Is this something that could be fixed by a firmware upgrade?  If so,
is there a Stratus/NEC bug report?

Is there a Red Hat bugzilla URL you could include?

What bad things would happen if we just turned on this
Stratus-specific behavior all the time on all systems?  It looks like
f07852d6442 is basically an optimization that makes pci_scan_slot()
faster, so I assume one effect would be to slow down PCI enumeration
for everybody.  By how much?

Bjorn
