Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:59051 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709Ab3JHXNb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 19:13:31 -0400
Received: by mail-ie0-f180.google.com with SMTP id u16so15073iet.39
        for <linux-pci@vger.kernel.org>; Tue, 08 Oct 2013 16:13:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5253243E.3040709@imgtec.com>
References: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com>
 <1380929453-15428-2-git-send-email-dengcheng.zhu@imgtec.com>
 <CAErSpo47zCU_sR46s1osmZ00AtkX-z++eezzbxee4yr3yDhQgw@mail.gmail.com>
 <1F7D814BDD93B94493CEE724A97FB4DC01C80AAE@BADAG02.ba.imgtec.org>
 <CAErSpo7z4c+DUKH4AWMyMZKTxTz_oi1iGtiUuHqQjhFG0gMu0g@mail.gmail.com> <5253243E.3040709@imgtec.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Oct 2013 17:13:10 -0600
Message-ID: <CAErSpo4pbyth6FU5XUNpRpah94BAuH3fyrGG20VGROyqTfZUtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI/quirks: Fix PIIX4 memory base and size mask
To: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	James Hogan <James.Hogan@imgtec.com>,
	Qais Yousef <Qais.Yousef@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 7, 2013 at 3:14 PM, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com> wrote:
> [Resend to the mailing list due to the bounceback caused by html format]
>
>
> On 10/04/2013 09:37 PM, Bjorn Helgaas wrote:
>>
>> On Fri, Oct 4, 2013 at 9:42 PM, DengCheng Zhu <DengCheng.Zhu@imgtec.com>
>> wrote:
>>>>
>>>> Does this fix a user-visible problem?  If so, what does it look like
>>>> when the problem occurs?
>>>
>>> No, I found the problem while debugging another issue and trying to
>>> understand this piece of code and after looking into different versions
>>> of
>>> PIIX4 datasheets. But I don't think it should prevent such a fix because
>>> the code is straightforward and the spec is clear enough. If the existing
>>> encoding was intentionally made like this by the code author due to the
>>> inaccuracy of the spec, then it's very likely some code comments were
>>> placed here. There are 2 possibilities:
>>>
>>> - This fix breaks something. People should have to bisect the problem.
>>> - This fix is valid. Some day people need PIIX4 mem quirks and they don't
>>>    have to run into a possibly well-hidden issue.
>>>
>>> What do you think?
>>
>> Don't worry, I'm willing to fix it even if nobody has actually
>> reported a problem.  It's just nice to include the symptoms if
>> somebody *has* reported it, so when other people see the same symptom,
>> they can more easily find the fix.
>
>
> Ah, I see. Thanks.
>
> So far I didn't see them on any branch in kernel/git/helgaas/pci.git
> <https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/>

This change definitely makes the code match the specs you mentioned.
But we don't have any problem reports, and when Linus added this code
(6693e74a "PCI: be more verbose about resource quirks), he presumably
was looking at a spec, too.  It's possible he transcribed the masks
incorrectly, but twice in one patch?

The PIIX4 is an old part, and for something like that I would
generally say "don't touch it" because the risk of breakage outweighs
a possible fix for machines nobody uses anymore.

However, I see that the PIIX4 is emulated in, e.g., qemu, so it's
still relevant.  But before I apply this, can you please research qemu
and how it uses these registers?  For example, if you can show that
qemu emulates the registers with the additional bits you add to the
masks here, then we should be able to make linux act incorrectly by
setting those bits in a qemu BIOS.

Bjorn
