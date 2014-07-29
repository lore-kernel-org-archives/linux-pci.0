Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55608 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbaG2TEV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jul 2014 15:04:21 -0400
Date: Tue, 29 Jul 2014 13:04:19 -0600 (MDT)
From: Keith Busch <keith.busch@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
cc: Keith Busch <keith.busch@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jordan_Hargrave@Dell.com, Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] PCI: update device mps when doing pci hotplug
In-Reply-To: <1406652178.1011.191.camel@ul30vt.home>
Message-ID: <alpine.LRH.2.03.1407291151210.5109@AMR>
References: <1406621877-12022-1-git-send-email-wangyijing@huawei.com>  <1406650687.1011.180.camel@ul30vt.home>  <alpine.LRH.2.03.1407291022380.5109@AMR> <1406652178.1011.191.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 29 Jul 2014, Alex Williamson wrote:
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

I'm not even sure it is a platform bug, but that was just a guess. The
way the devices are configured, it appears they behave inline with the
spec (from table 7-13):

   "
   Max_Payload_size -- This field sets maximum TLP payload size for the
   Function. As a Receiver, the Function must handle TLPs as large as the set
   value. As a Transmitter, the Function must not generate TLPs exceeding the
   set value.
   "

It sounds like it allows a transmitter to generate a TLP that the receiver
can't handle, but I don't know if that was the intent. :)
