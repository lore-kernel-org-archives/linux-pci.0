Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:49294 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbaCMPpO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Mar 2014 11:45:14 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so1169508ier.27
        for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2014 08:45:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5321CE94.5070506@kernel.dk>
References: <cover.1393404496.git.agordeev@redhat.com> <20140313041231.GC26657@google.com>
 <5321CE94.5070506@kernel.dk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 13 Mar 2014 09:44:52 -0600
Message-ID: <CAErSpo74gmXCLCg46Eqmu4r664cRvMFLcBOf9c0UZLf7vFtNsw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] block: Use pci_enable_msix_exact() instead of pci_enable_msix()
To: Jens Axboe <axboe@kernel.dk>
Cc: Alexander Gordeev <agordeev@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mike Miller <mike.miller@hp.com>, iss_storagedev@hp.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Matthew Wilcox <willy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 13, 2014 at 9:28 AM, Jens Axboe <axboe@kernel.dk> wrote:
> On 03/12/2014 10:12 PM, Bjorn Helgaas wrote:
>>
>> On Wed, Feb 26, 2014 at 10:02:40AM +0100, Alexander Gordeev wrote:
>>>
>>> Changes since v1:
>>>    - cciss: patch #1: a weird 'goto' removed;
>>>    - cciss: patch #2: pci_enable_msix_exact() used, not
>>> pci_enable_msix_range();
>>>    - rsxx: patch dropped - no need to change anything;
>>>
>>> As result of deprecation of MSI-X/MSI enablement functions
>>> pci_enable_msix() and pci_enable_msi_block() all drivers
>>> using these two interfaces need to be updated to use the
>>> new pci_enable_msi_range()  or pci_enable_msi_exact()
>>> and pci_enable_msix_range() or pci_enable_msix_exact()
>>> interfaces.
>>>
>>> This change updates 'cciss' only, but there is also 'nvme' update
>>> pending - I am waiting for Intel guys to clarify if they want to
>>> route it thru their tree. If not, I will post the 'nvme' patch as
>>> a follow-up to this series.
>>
>>
>> Hi Jens,
>>
>> I'd like to get these merged during the v3.15 merge window.  I'd be glad
>> to
>> review and apply them through my tree, unless you want to do it.  They do
>> depend on f7fc32c, which went in after the v3.14 merge window, which makes
>> it a bit of a hassle.
>
>
> My 3.15/drivers (and core) branch are based off 3.14-rc3, so it should be
> OK. I've queued them up, as it's mostly a followup to the previous ones from
> Alexander.

Great, thanks!  I'll take them off my to-do list.

Bjorn
