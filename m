Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24428 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbaEAUUH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 1 May 2014 16:20:07 -0400
Date: Thu, 1 May 2014 14:20:05 -0600 (MDT)
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Keith Busch <keith.busch@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/2] PCI: Device driver function reset notification
In-Reply-To: <CAErSpo7R9BZtJpb3ekR=8D+tkWR9tPzsT0YLY5YS-hOGQJuxQA@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1405011412500.5666@AMR>
References: <1397000541-1085-1-git-send-email-keith.busch@intel.com> <20140430224637.GA31315@google.com> <alpine.LRH.2.03.1405011344330.5666@AMR> <CAErSpo7R9BZtJpb3ekR=8D+tkWR9tPzsT0YLY5YS-hOGQJuxQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 1 May 2014, Bjorn Helgaas wrote:
> On Thu, May 1, 2014 at 1:57 PM, Keith Busch <keith.busch@intel.com> wrote:
>> On Wed, 30 Apr 2014, Bjorn Helgaas wrote:
>>>
>>> On Tue, Apr 08, 2014 at 05:42:20PM -0600, Keith Busch wrote:
>>> You put the notify in these functions:
>>>
>>>  pci_reset_function()
>>>  pci_try_reset_function()
>>>
>>> but what about these:
>>>
>>>  pci_reset_slot()
>>>  pci_try_reset_slot()
>>>  pci_reset_bus()
>>>  pci_try_reset_bus()
>>
>>
>> Good point. These all call pci_dev_save_and_disable at the start and
>> pci_dev_restore after, so I think just adding the reset prepare/complete
>> to those functions should cover all scenarios. Does this sound ok?
>
> Sound OK to me, as long as the save/restore functions aren't used elsewhere.

Yep, there is currently 1:1 symmetry for these in all cases. I'll make
a note for any future use that the calling disabling/restore should
maintain this property.
