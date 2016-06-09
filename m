Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] x86: Add support for guest DMA dirty
 page tracking
To: Alex Duyck <aduyck@mirantis.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
References: <20151213212557.5410.48577.stgit@localhost.localdomain>
 <20160104204104.GB17427@char.us.oracle.com>
 <CAKgT0UenF-Cj2fvFPEmY0g7FOf=85HbFJ9iFUjs4KgsaXrckqA@mail.gmail.com>
 <20160105113317-mutt-send-email-mst@redhat.com>
 <CAKgT0UeY9+BJoGtM+Fqa4Zve36GBJQpYVyoo2CPJZdELH6cEbg@mail.gmail.com>
 <df81dd53-dc03-667e-4d53-3c67f90aab8f@cn.fujitsu.com>
 <CAMt9YRpzAKt1KQW17VBzx0PT5BxiL_1+U1-AEK2A_Ao9KQjmGg@mail.gmail.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>,
	Lan Tianyu <tianyu.lan@intel.com>,
	Yang Zhang <yang.zhang.wz@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	<kvm@vger.kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	<x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	<qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	=?UTF-8?B?SXp1bWksIFRha3Uv5rOJIOaLkw==?=
	<izumi.taku@jp.fujitsu.com>
From: Zhou Jie <zhoujie2011@cn.fujitsu.com>
Message-ID: <6a7bef5b-3f96-f582-d3cf-cb59f5308e28@cn.fujitsu.com>
Date: Thu, 9 Jun 2016 18:14:40 +0800
MIME-Version: 1.0
In-Reply-To: <CAMt9YRpzAKt1KQW17VBzx0PT5BxiL_1+U1-AEK2A_Ao9KQjmGg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

TO Alex
TO Michael

    In your solution you add a emulate PCI bridge to act as
    a bridge between direct assigned devices and the host bridge.
    Do you mean put all direct assigned devices to
    one emulate PCI bridge?
    If yes, this maybe bring some problems.

    We are writing a patchset to support aer feature in qemu.
    When assigning a vfio device with AER enabled, we must check whether
    the device supports a host bus reset (ie. hot reset) as this may be
    used by the guest OS in order to recover the device from an AER
    error.
    QEMU must therefore have the ability to perform a physical
    host bus reset using the existing vfio APIs in response to a virtual
    bus reset in the VM.
    A physical bus reset affects all of the devices on the host bus.
    Therefore all physical devices affected by a bus reset must be
    configured on the same virtual bus in the VM.
    And no devices unaffected by the bus reset,
    be configured on the same virtual bus.

    http://lists.nongnu.org/archive/html/qemu-devel/2016-05/msg02989.html

Sincerely,
Zhou Jie

On 2016/6/7 0:04, Alex Duyck wrote:
> On Mon, Jun 6, 2016 at 2:18 AM, Zhou Jie <zhoujie2011@cn.fujitsu.com> wrote:
>> Hi Alex,
>>
>>
>> On 2016/1/6 0:18, Alexander Duyck wrote:
>>>
>>> On Tue, Jan 5, 2016 at 1:40 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Mon, Jan 04, 2016 at 07:11:25PM -0800, Alexander Duyck wrote:
>>>>>>>
>>>>>>> The two mechanisms referenced above would likely require coordination
>>>>>>> with
>>>>>>> QEMU and as such are open to discussion.  I haven't attempted to
>>>>>>> address
>>>>>>> them as I am not sure there is a consensus as of yet.  My personal
>>>>>>> preference would be to add a vendor-specific configuration block to
>>>>>>> the
>>>>>>> emulated pci-bridge interfaces created by QEMU that would allow us to
>>>>>>> essentially extend shpc to support guest live migration with
>>>>>>> pass-through
>>>>>>> devices.
>>>>>>
>>>>>>
>>>>>> shpc?
>>>>>
>>>>>
>>>>> That is kind of what I was thinking.  We basically need some mechanism
>>>>> to allow for the host to ask the device to quiesce.  It has been
>>>>> proposed to possibly even look at something like an ACPI interface
>>>>> since I know ACPI is used by QEMU to manage hot-plug in the standard
>>>>> case.
>>>>>
>>>>> - Alex
>>>>
>>>>
>>>>
>>>> Start by using hot-unplug for this!
>>>>
>>>> Really use your patch guest side, and write host side
>>>> to allow starting migration with the device, but
>>>> defer completing it.
>>>
>>>
>>> Yeah, I'm fully on board with this idea, though I'm not really working
>>> on this right now since last I knew the folks on this thread from
>>> Intel were working on it.  My patches were mostly meant to be a nudge
>>> in this direction so that we could get away from the driver specific
>>> code.
>>
>>
>> I have seen your email about live migration.
>>
>> I conclude the idea you proposed as following.
>> 1. Extend swiotlb to allow for a page dirtying functionality.
>> 2. Use pci express capability to implement of a PCI bridge to act
>>    as a bridge between direct assigned devices and the host bridge.
>> 3. Using APCI event or extend shpc driver to support device pause.
>> Is it right?
>>
>> Will you implement the patchs for live migration?
>
> That is pretty much the heart of the proposal I had.  I submitted an
> RFC as a proof-of-concept for item 1 in the hopes that someone else
> might try tackling items 2 and 3 but I haven't seen any updates since
> then.  The trick is to find a way to make it so that item 1 doesn't
> slow down standard SWIOTLB when you are not migrating a VM. If nothing
> else we would probably just need to add a static key that we could
> default to false unless there is a PCI bridge indicating we are
> starting a migration.
>
> I haven't had time to really work on this though. In addition I am not
> that familiar with QEMU and the internals of live migration so pieces
> 2 and 3 would take me some additional time to work on.
>
> - Alex
>
>
> .
>
