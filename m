Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:9185 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbaG3DiK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jul 2014 23:38:10 -0400
Message-ID: <53D8681F.6060904@huawei.com>
Date: Wed, 30 Jul 2014 11:35:59 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>,
	Keith Busch <keith.busch@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<Jordan_Hargrave@Dell.com>, <jon.mason@intel.com>,
	Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com>	 <1406650687.1011.180.camel@ul30vt.home>	 <alpine.LRH.2.03.1407291022380.5109@AMR> <1406652178.1011.191.camel@ul30vt.home>
In-Reply-To: <1406652178.1011.191.camel@ul30vt.home>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/7/30 0:42, Alex Williamson wrote:
> On Tue, 2014-07-29 at 10:30 -0600, Keith Busch wrote:
>> On Tue, 29 Jul 2014, Alex Williamson wrote:
>>> On Tue, 2014-07-29 at 16:17 +0800, Yijing Wang wrote:
>>>> Currently we don't update device's mps value when doing
>>>> pci device hot-add. The hot-added device's mps will be set
>>>> to default value (128B). But the upstream port device's mps
>>>> may be larger than 128B which was set by firmware during
>>>> system bootup. In this case the new added device may not
>>>> work normally.
>>>
>>> Apologies if we rehash some previously discussed topics while I try to
>>> cover for Bjorn while he's out.  By "normally", do you mean "optimally"?
>>> The device should be functional with a lower mps setting, right?
>>
>> You'd think so, but some platforms don't work. A pci-e trace showed
>> TLPs exceeding MPS when parent device at 256B and the end device left
>> at 128B. Even if that's a platform bug, I think we still want it to work.
> 
> But if it's a platform bug for a non-compliant device, should it be
> handled as a quirk rather than standard configuration?  Thanks,

This is not a platform bug, in PCIe 3.0 spec 7.8.4, page 618, it said
Software can control this to achieve some purposes.


IMPLEMENTATION NOTE
Use of Max_Payload_Size
The Max_Payload_Size mechanism allows software to control the maximum payload in packets sent
by Endpoints to balance latency versus bandwidth trade-offs, particularly for isochronous traffic.
If software chooses to program the Max_Payload_Size of various System Elements to non-default
values, it must take care to ensure that each packet does not exceed the Max_Payload_Size
parameter of any System Element along the packet's path.  Otherwise, the packet will be rejected by  20
the System Element whose Max_Payload_Size parameter is too small.
Discussion of specific algorithms used to configure Max_Payload_Size to meet this requirement is
beyond the scope of this specification, but software should base its algorithm upon factors such as
the following:
  the Max_Payload_Size capability of each System Element within a hierarchy  25
  awareness of when System Elements are added or removed through Hot-Plug operations
  knowing which System Elements send packets to each other, what type of traffic is carried, what
type of transactions are used, or if packet sizes are constrained by other mechanisms

For the case of firmware that configures System Elements in preparation for running legacy
operating system environments, the firmware may need to avoid programming a Max_Payload_Size
above the default of 128 bytes, which is the minimum supported by Endpoints.
For example, if the operating system environment does not comprehend PCI Express, firmware
probably should not program a non-default Max_Payload_Size for a hierarchy that supports Hot- 5
Plug operations.  Otherwise, if no software is present to manage Max_Payload_Size settings when a
new element is added, improper operation may result.  Note that a newly added element may not
even support a Max_Payload_Size setting as large as the rest of the hierarchy, in which case software
may need to deny enabling the new element or reduce the Max_Payload_Size settings of other
elements.

> 
> Alex
> 
> 
> 
> .
> 


-- 
Thanks!
Yijing

