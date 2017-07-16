Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:42677 "EHLO mout1.freenet.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751158AbdGPQ4M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 Jul 2017 12:56:12 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
Subject: Re: ryzen X370: iommu - unusable huge groups
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <95b7f350-76f7-daff-be4a-f3fc70589ba9@01019freenet.de>
 <20170716085334.7ae210d2@w520.home>
Message-ID: <ecdf6b75-4966-fa3a-00de-99b1c9fe6caa@01019freenet.de>
Date: Sun, 16 Jul 2017 18:53:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170716085334.7ae210d2@w520.home>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Alex!

Nice to hear you again :-)



On 07/16/2017 at 04:53 PM Alex Williamson wrote:
> On Sun, 16 Jul 2017 07:44:01 +0200
> Andreas Hartmann <andihartmann@01019freenet.de> wrote:
> 
>> Hello!
>>
>> I've got a Asus X370-Pro motherboard with enabled iommu. Unfortunately,
>> the group 0 is mostly all of the system :-).
>>
>> [    2.602426] iommu: Adding device 0000:00:01.0 to group 0
>> [    2.602440] iommu: Adding device 0000:00:01.3 to group 0
>> [    2.603368] iommu: Adding device 0000:03:00.0 to group 0
>> [    2.603377] iommu: Adding device 0000:03:00.1 to group 0
>> [    2.603385] iommu: Adding device 0000:03:00.2 to group 0
>> [    2.603396] iommu: Adding device 0000:1d:00.0 to group 0
>> [    2.603406] iommu: Adding device 0000:1d:02.0 to group 0
>> [    2.603417] iommu: Adding device 0000:1d:03.0 to group 0
>> [    2.603428] iommu: Adding device 0000:1d:04.0 to group 0
>> [    2.603439] iommu: Adding device 0000:1d:06.0 to group 0
>> [    2.603450] iommu: Adding device 0000:1d:07.0 to group 0
>> [    2.603466] iommu: Adding device 0000:24:00.0 to group 0
>> [    2.603481] iommu: Adding device 0000:25:00.0 to group 0
>> [    2.603498] iommu: Adding device 0000:26:00.0 to group 0
>> [    2.603513] iommu: Adding device 0000:27:00.0 to group 0
> 
> 
> Update your motherboard BIOS, AMD AGESA 1.0.0.6 is supposed to
> enable ACS in the PCIe root ports.  Thanks,

Group 0 is now group 10 - that's mostly all :-( - no significant change.
(Version 805 which should contain AGESA 1.0.0.6).


[    2.600097] iommu: Adding device 0000:03:00.0 to group 10
[    2.600117] iommu: Adding device 0000:03:00.1 to group 10
[    2.600136] iommu: Adding device 0000:03:00.2 to group 10
[    2.600148] iommu: Adding device 0000:1d:00.0 to group 10
[    2.600158] iommu: Adding device 0000:1d:02.0 to group 10
[    2.600169] iommu: Adding device 0000:1d:03.0 to group 10
[    2.600180] iommu: Adding device 0000:1d:04.0 to group 10
[    2.600190] iommu: Adding device 0000:1d:06.0 to group 10
[    2.600201] iommu: Adding device 0000:1d:07.0 to group 10
[    2.600216] iommu: Adding device 0000:24:00.0 to group 10
[    2.600233] iommu: Adding device 0000:25:00.0 to group 10
[    2.600249] iommu: Adding device 0000:26:00.0 to group 10
[    2.600266] iommu: Adding device 0000:27:00.0 to group 10


All devices that are used are in the same group again.

Isn't it possible to allow them to put to VM anyway if there is no peer
to peer communication - same as it was possible with the previous
chipset (990xa)?




Thanks,
Andreas
