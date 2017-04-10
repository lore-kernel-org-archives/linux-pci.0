Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8x0rQUnTUorknW-mW9LFgrxFYsXyy4LU_w9JbA-m_sjA@mail.gmail.com>
References: <1490196629-28088-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170322193111.GA8190@wunner.de>
 <CAKv+Gu_X-SEnz7h9J8boqqjOQGHQawwdSAq4haH-OGu8zdfNfA@mail.gmail.com>
 <20170323084819.GA23281@h08.hostsharing.net>
 <CAKv+Gu93eJ-js3g7M6Jdm6XGMaWMswFmzBG2qNT4rn+3=1+EyA@mail.gmail.com>
 <20170323105727.GA2441@red-moon>
 <466dcd2b-a781-2fe7-6ef0-5a3767c793e0@codeaurora.org>
 <CAKv+Gu9LbwpnJNi1OL25MWvYPxEOfKRHcs2jA2121BPaQWPzow@mail.gmail.com>
 <27f50de3-721e-e8ec-00c8-b7a9d3cff0d6@codeaurora.org>
 <CAKv+Gu-qRg8-YRCairppKrEfeLcW+OwVF8qZHp7vxXJA_AwPOw@mail.gmail.com>
 <20170330100524.GA22801@red-moon>
 <CAKv+Gu-ff98HrPK3f+E8soGJUXaaMxPLs2AuJ+rvXd0HWX-jXw@mail.gmail.com>
 <CAKv+Gu8YjySTDMgsrtGqEPMOtVhHc8gvTHZ4C5Ga8OTYdC9R3A@mail.gmail.com>
 <ae87ae28-f50d-095f-576e-f3fd7f96dea2@codeaurora.org>
 <CAKv+Gu8x0rQUnTUorknW-mW9LFgrxFYsXyy4LU_w9JbA-m_sjA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 10 Apr 2017 16:28:11 +0100
Message-ID: <CAKv+Gu9Su0F9CSRe=sxomuDDH7c2szO6Z8dpqOQ=t_1Vn3JD3g@mail.gmail.com>
Subject: Re: [PATCH v3] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
To: Sinan Kaya <okaya@codeaurora.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 Matt Fleming <matt@codeblueprint.co.uk>, linux-pci <linux-pci@vger.kernel.org>,
 Peter Jones <pjones@redhat.com>, Heyi Guo <heyi.guo@linaro.org>,
 Lukas Wunner <lukas@wunner.de>, Hanjun Guo <hanjun.guo@linaro.org>,
 Yinghai Lu <yinghai@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2 April 2017 at 16:16, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 30 March 2017 at 14:50, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 3/30/2017 9:38 AM, Ard Biesheuvel wrote:
>>> On 30 March 2017 at 11:09, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>>> On 30 March 2017 at 11:05, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>>>>> On Thu, Mar 30, 2017 at 09:46:39AM +0100, Ard Biesheuvel wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>>> I'm asking why we don't fix the actual problem in PCIe ARM64 adaptation instead
>>>>>>> of working around it by quirks.
>>>>>>>
>>>>>>> I don't see any reason why ACPI ARM64 should carry the burden of legacy systems.
>>>>>>>
>>>>>>> Legacy only applies to DT based systems.
>>>>>>>
>>>>>>
>>>>>> I fully agree with this point: ACPI implies firmware, and so we should
>>>>>> be able to rely on firmware to have initialized the PCIe subsystem by
>>>>>> the time the kernel gets to access it.
>>>>>
>>>>> https://lkml.org/lkml/2016/3/3/458
>>>>>
>>>>
>>>> I don't think the fact that at least one system existed over a year
>>>> ago whose UEFI assigned resources incorrectly should prevent us from
>>>> being normative in this case.
>>>
>>> In any case, given that EFIFB is enabled by default on some distros,
>>> and the fact that DT boot is affected as well, I should get this patch
>>> in to prevent serious potential issues that could arise when someone
>>> with a graphical UEFI stack updates to such a new kernel.
>>>
>>> So I think we are in agreement that this is needed on both ARM and
>>> arm64, since their PCI configuration is usually not preserved. The
>>> open question is whether there is any harm in enabling it for x86 as
>>> well.
>>>
>>
>> Agreed, the other issue is about compatibility with UEFI and future
>> proofing Linux for other potential issues like hotplug reservation.
>>
>
> OK, given the lack of feedback regarding the suitability of this patch
> for x86, I am going to rework it as a ARM/arm64 only patch, and queue
> it as a fix for v4.11. This way, we can backport it to stable (which
> is arguably appropriate, given that upgrading to a EFIFB enabled
> kernel may cause severe breakage for existing systems that implement
> the GOP protocol), and easily change the patch to apply to x86 going
> forwards, by removing the #ifdefs
>

As it turns out, this patch does not solve the problem completely.

For EFI framebuffers that are backed by a PCI bar of a device residing
on bus 0, things work happily. However, claiming resources for devices
behind bridges doesn't work.

Given that we have not made the situation worse, fixing it is less
urgent than it was before. I.e., there is no longer a risk of
inadvertently poking the wrong BAR when writing to the framebuffer.
There is a regression in functionality, though, since EFI fb devices
that happened to work (because the firmware BAR == the kernel BAR)
have stopped working if they are behind a bridge, which is of course
always the case for PCIe.

So before starting the next round of hacking to work around this, I
would like rekindle the discussion regarding the way we blindly
reassign all resources on ACPI/arm64 systems, and whether there is a
way imaginable to avoid doing that.

I suppose the state of the BARs as we inherit it from the firmware
cannot be blindly trusted (and IIUC, this is Lorenzo's primary issue
with it). So should there be some side channel (UEFI config table
perhaps?) to describe this? How do other architectures deal with this?
Is this what the PCI bios accesses are for?

In any case, I have updated the UEFI firmware we have for ARM Juno to
use EDK2's generic PCI host bridge driver instead of one that was
specially written for ARM Juno, and may deviate in the way it
allocates PCI resources.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
