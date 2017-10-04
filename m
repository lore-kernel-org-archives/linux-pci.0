Return-Path: <SRS0=yG7d=BD=broadcom.com=hari.vyas@kernel.org>
Return-Path: <SRS0=yG7d=BD=broadcom.com=hari.vyas@kernel.org>
From: Hari Vyas <hari.vyas@broadcom.com>
References: <a9aba0db-4865-2a6b-b77c-9cb70a4eeab0@broadcom.com>
 <20171002193532.GA5407@bhelgaas-glaptop.roam.corp.google.com>
 <e0a89ffe-a936-9b41-c9c0-3616452376e2@broadcom.com> <20171002200854.GB5407@bhelgaas-glaptop.roam.corp.google.com>
 <f1e6454f-a069-be64-df21-b5dbf76df4f3@broadcom.com>
In-Reply-To: <f1e6454f-a069-be64-df21-b5dbf76df4f3@broadcom.com>
MIME-Version: 1.0
Date: Wed, 4 Oct 2017 11:47:06 +0530
Message-ID: <8e3b39b55776cfb334071dcf0a8ee75f@mail.gmail.com>
Subject: RE: [RFC] PCIe bus address at 0x00000000
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Abhishek Shah <abhishek.shah@broadcom.com>, Srinath Mannam <srinath.mannam@broadcom.com>,
	Vikram Prakash <vikram.prakash@broadcom.com>, Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

-----Original Message-----
From: Ray Jui [mailto:ray.jui@broadcom.com]
Sent: 04 October 2017 04:21
To: Bjorn Helgaas
Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; Hari Vyas; Abhishek Shah;
Srinath Mannam; Vikram Prakash
Subject: Re: [RFC] PCIe bus address at 0x00000000

Hi Bjorn,

On 10/2/2017 1:08 PM, Bjorn Helgaas wrote:
> On Mon, Oct 02, 2017 at 12:47:16PM -0700, Ray Jui wrote:
>> Hi Bjorn,
>>
>> On 10/2/2017 12:35 PM, Bjorn Helgaas wrote:
>>> On Fri, Sep 29, 2017 at 05:47:23PM -0700, Ray Jui wrote:
>>>> Hi Bjorn and all,
>>>>
>>>> One of our ARM64 based processor (NS2) has our system address
>>>> reversed for PCIe outbound transaction in the range of 0x0000_0000
>>>> and 0x1fff_ffff. If we use 1:1 mapping between the system address
>>>> and PCIe address, we end up having the PCIe address in the same
>>>> range.
>>>>
>>>> In this case, we noticed that certain USB-PCI adapters will decline
>>>> access to BARs mapped in this address range with "Unsupported
>>>> Request". In this case, if we change the PCIe address range to
>>>> something else like 0x8000_0000, it would work without an issue.
>>>>
>>>> This sounds like an issue with the USB PCI adapter that cannot
>>>> allow BARs to be used with specific PCIe address range. Is my
>>>> understanding correct?
>>>
>>> I assume you're seeing "Unsupported Request" completions on the PCIe
>>> link?  Can you tell with an analyzer that the TLP actually appears
>>> on the link and it's the device that is responding with UR?  I'm
>>> just wondering if there's something in the RC that could be
>>> short-circuiting this.  But I guess you mention "certain USB-PCI
>>> adapters", which implies that these BAR addresses work for *some*
>>> devices, just not these particular USB-PCI ones.
>>
>> Yes, UR is observed with a PCIe analyzer. See attached two JPGs for
>> captures from PCIe analyzer (one uses PCIe address of 0x0000_0000 and
>> the other uses 0x8000_0000).
>>
>> And yes, this behavior is only seen with certain PCIe-USB adapters.
>> Most other PCIe endpoint devices (NVMe SSDs, Ethernet dongle, PCIe
>> switches, and etc) work fine with PICe address of 0x0000_0000.
>>
>>>
>>> AFAIK, there's no PCIe reason why the 0x0000_0000 - 0x1fff_ffff
>>> region shouldn't be used for BARs.
>>>
>>
>> Okay, thanks for helping to confirm that.
>>
>>> It's surprising to me that a device would special-case addresses
>>> like that, but maybe it does.
>>
>> If this is proven to be a shortcoming of some specific PCIe-USB
>> adapters (and in fact it seems to be the case so far based on all of
>> the data points). Does it make any sense to you to have a workaround
>> done by the root complex, i.e., to avoid using 0x0000_0000 outbound
>> region; instead, use something else, .e.g, 0x1000_0000
>
> We could have a workaround, as long as it's done in a way that doesn't
> penalize all the correctly-working hardware.  I don't want to give up
> 1/16 of the 32-bit address space for everybody just to accomodate some
> broken hardware.
>
> I'm not sure what form such a workaround would take.  A quirk could
> mark a zero-valued BAR as invalid and force reallocation, but I'm not
> sure how we'd force the allocator to avoid this region.  There might
> be some development required there.

Giving that this is obviously a shortcoming from some specific endpoint
devices, I would image enforcing certain region of PCIe address space from
the root complex side would not make sense, right?

I'd assume this needs to be done through some API that an endpoint device
can call and mark specific PCIe address invalid?

-----------------------------------------------------------------
I guess, we may think about adding some special quirk to handle this.
Anyway, just to be more clear, I am mentioning that specific PCIE-USB
adapter for which we are facing issues.

0000:01:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
Controller (rev 04)
00: 33 10 94 01 06 04 10 00 04 30 03 0c 20 00 00 00
10: 04 00 00 10 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 14 a5 c0
30: 00 00 00 00 50 00 00 00 00 00 00 00 82 01 00 00
>
> Bjorn
>
