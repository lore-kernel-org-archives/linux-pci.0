Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:5926 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317Ab3JIA3m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Oct 2013 20:29:42 -0400
Message-ID: <5254A372.3090302@imgtec.com>
Date: Tue, 8 Oct 2013 17:29:38 -0700
From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	James Hogan <James.Hogan@imgtec.com>,
	Qais Yousef <Qais.Yousef@imgtec.com>
Subject: Re: [PATCH v2 1/4] PCI/quirks: Fix PIIX4 memory base and size mask
References: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com> <1380929453-15428-2-git-send-email-dengcheng.zhu@imgtec.com> <CAErSpo47zCU_sR46s1osmZ00AtkX-z++eezzbxee4yr3yDhQgw@mail.gmail.com> <1F7D814BDD93B94493CEE724A97FB4DC01C80AAE@BADAG02.ba.imgtec.org> <CAErSpo7z4c+DUKH4AWMyMZKTxTz_oi1iGtiUuHqQjhFG0gMu0g@mail.gmail.com> <5253243E.3040709@imgtec.com> <CAErSpo4pbyth6FU5XUNpRpah94BAuH3fyrGG20VGROyqTfZUtA@mail.gmail.com>
In-Reply-To: <CAErSpo4pbyth6FU5XUNpRpah94BAuH3fyrGG20VGROyqTfZUtA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/08/2013 04:13 PM, Bjorn Helgaas wrote:
> On Mon, Oct 7, 2013 at 3:14 PM, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com> wrote:
>> [Resend to the mailing list due to the bounceback caused by html format]
>>
>>
>> On 10/04/2013 09:37 PM, Bjorn Helgaas wrote:
>>> On Fri, Oct 4, 2013 at 9:42 PM, DengCheng Zhu <DengCheng.Zhu@imgtec.com>
>>> wrote:
>>>>> Does this fix a user-visible problem?  If so, what does it look like
>>>>> when the problem occurs?
>>>> No, I found the problem while debugging another issue and trying to
>>>> understand this piece of code and after looking into different versions
>>>> of
>>>> PIIX4 datasheets. But I don't think it should prevent such a fix because
>>>> the code is straightforward and the spec is clear enough. If the existing
>>>> encoding was intentionally made like this by the code author due to the
>>>> inaccuracy of the spec, then it's very likely some code comments were
>>>> placed here. There are 2 possibilities:
>>>>
>>>> - This fix breaks something. People should have to bisect the problem.
>>>> - This fix is valid. Some day people need PIIX4 mem quirks and they don't
>>>>     have to run into a possibly well-hidden issue.
>>>>
>>>> What do you think?
>>> Don't worry, I'm willing to fix it even if nobody has actually
>>> reported a problem.  It's just nice to include the symptoms if
>>> somebody *has* reported it, so when other people see the same symptom,
>>> they can more easily find the fix.
>>
>> Ah, I see. Thanks.
>>
>> So far I didn't see them on any branch in kernel/git/helgaas/pci.git
>> <https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/>
> This change definitely makes the code match the specs you mentioned.
> But we don't have any problem reports,
It's very likely that nobody really used PIIX4 ACPI devices 12 and 13. 
Maybe some day they'll be used, or maybe they can be deleted from the code. 
But if they'll be kept in the code, had better fix it IMO.

> and when Linus added this code
> (6693e74a "PCI: be more verbose about resource quirks), he presumably
> was looking at a spec, too.  It's possible he transcribed the masks
> incorrectly, but twice in one patch?
>
> The PIIX4 is an old part, and for something like that I would
> generally say "don't touch it" because the risk of breakage outweighs
> a possible fix for machines nobody uses anymore.
>
> However, I see that the PIIX4 is emulated in, e.g., qemu, so it's
> still relevant.  But before I apply this, can you please research qemu
> and how it uses these registers?  For example, if you can show that
> qemu emulates the registers with the additional bits you add to the
> masks here, then we should be able to make linux act incorrectly by
> setting those bits in a qemu BIOS.

QEMU doesn't emulate PIIX4 ACPI devices 12 & 13, so these registers are not 
used in it.


Deng-Cheng


