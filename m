Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:33100 "EHLO
	mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933059AbcFMB2u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 12 Jun 2016 21:28:50 -0400
MIME-Version: 1.0
In-Reply-To: <d6b476e6-de3c-8190-dbb4-c34837fad4a2@cn.fujitsu.com>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
 <20160104204104.GB17427@char.us.oracle.com> <CAKgT0UenF-Cj2fvFPEmY0g7FOf=85HbFJ9iFUjs4KgsaXrckqA@mail.gmail.com>
 <20160105113317-mutt-send-email-mst@redhat.com> <CAKgT0UeY9+BJoGtM+Fqa4Zve36GBJQpYVyoo2CPJZdELH6cEbg@mail.gmail.com>
 <df81dd53-dc03-667e-4d53-3c67f90aab8f@cn.fujitsu.com> <CAMt9YRpzAKt1KQW17VBzx0PT5BxiL_1+U1-AEK2A_Ao9KQjmGg@mail.gmail.com>
 <6a7bef5b-3f96-f582-d3cf-cb59f5308e28@cn.fujitsu.com> <CAKgT0UeXeq+GQo1ak9wUEQqzLvE+LN=5tAvZoTtSua1=X3R55A@mail.gmail.com>
 <d6b476e6-de3c-8190-dbb4-c34837fad4a2@cn.fujitsu.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 12 Jun 2016 18:28:48 -0700
Message-ID: <CAKgT0UeOPVLHtkBwCkz_aeXy01rn6A30vnqscs5SttHfQY8fVg@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] x86: Add support for guest DMA dirty
 page tracking
To: Zhou Jie <zhoujie2011@cn.fujitsu.com>
Cc: Alex Duyck <aduyck@mirantis.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Lan Tianyu <tianyu.lan@intel.com>,
	Yang Zhang <yang.zhang.wz@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	kvm@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"the arch/x86 maintainers" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	=?UTF-8?B?SXp1bWksIFRha3Uv5rOJIOaLkw==?=
	<izumi.taku@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 11, 2016 at 8:03 PM, Zhou Jie <zhoujie2011@cn.fujitsu.com> wrote:
> Hi, Alex
>
>
> On 2016/6/9 23:39, Alexander Duyck wrote:
>>
>> On Thu, Jun 9, 2016 at 3:14 AM, Zhou Jie <zhoujie2011@cn.fujitsu.com>
>> wrote:
>>>
>>> TO Alex
>>> TO Michael
>>>
>>>    In your solution you add a emulate PCI bridge to act as
>>>    a bridge between direct assigned devices and the host bridge.
>>>    Do you mean put all direct assigned devices to
>>>    one emulate PCI bridge?
>>>    If yes, this maybe bring some problems.
>>>
>>>    We are writing a patchset to support aer feature in qemu.
>>>    When assigning a vfio device with AER enabled, we must check whether
>>>    the device supports a host bus reset (ie. hot reset) as this may be
>>>    used by the guest OS in order to recover the device from an AER
>>>    error.
>>>    QEMU must therefore have the ability to perform a physical
>>>    host bus reset using the existing vfio APIs in response to a virtual
>>>    bus reset in the VM.
>>>    A physical bus reset affects all of the devices on the host bus.
>>>    Therefore all physical devices affected by a bus reset must be
>>>    configured on the same virtual bus in the VM.
>>>    And no devices unaffected by the bus reset,
>>>    be configured on the same virtual bus.
>>>
>>>    http://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg02989.html
>>>
>>> Sincerely,
>>> Zhou Jie
>>
>>
>> That makes sense, but I don't think you have to worry much about this
>> at this point at least on my side as this was mostly just theory and I
>> haven't had a chance to put any of it into practice as of yet.
>>
>> My idea has been evolving on this for a while.  One thought I had is
>> that we may want to have something like an emulated IOMMU and if
>> possible we would want to split it up over multiple domains just so we
>> can be certain that the virtual interfaces and the physical ones
>> existed in separate domains.  In regards to your concerns perhaps what
>> we could do is put each assigned device into its own domain to prevent
>> them from affecting each other.  To that end we could probably break
>> things up so that each device effectively lives in its own PCIe slot
>> in the emulated system.  Then when we start a migration of the guest
>> the assigned device domains would then have to be tracked for unmap
>> and sync calls when the direction is from the device.
>>
>> I will keep your concerns in mind in the future when I get some time
>> to look at exploring this solution further.
>>
>> - Alex
>
>
> I am thinking about the practice of migration of passthrough device.
>
> In your solution, you use a vendor specific configuration space to
> negotiate with guest.
> If you put each assigned device into its own domain,
> how can qemu negotiate with guest?
> Add the vendor specific configuration space to every pci bus which
> is assigned a passthrough device?

This is kind of the direction I was thinking of heading in, so yes.
Basically in my mind we should be emulating a PCIe hierarchy if we
want so support device assignment.  That way we can already make use
of things like hot-plug and AER natively.  So if we have a root port
assigned to each assigned device we should be able to place some extra
logic there to handle things like this.

- Alex
