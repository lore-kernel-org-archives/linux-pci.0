Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:49386 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752687Ab3JGVPM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Oct 2013 17:15:12 -0400
Message-ID: <5253243E.3040709@imgtec.com>
Date: Mon, 7 Oct 2013 14:14:38 -0700
From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	James Hogan <James.Hogan@imgtec.com>,
	Qais Yousef <Qais.Yousef@imgtec.com>
Subject: Re: [PATCH v2 1/4] PCI/quirks: Fix PIIX4 memory base and size mask
References: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com> <1380929453-15428-2-git-send-email-dengcheng.zhu@imgtec.com> <CAErSpo47zCU_sR46s1osmZ00AtkX-z++eezzbxee4yr3yDhQgw@mail.gmail.com> <1F7D814BDD93B94493CEE724A97FB4DC01C80AAE@BADAG02.ba.imgtec.org> <CAErSpo7z4c+DUKH4AWMyMZKTxTz_oi1iGtiUuHqQjhFG0gMu0g@mail.gmail.com>
In-Reply-To: <CAErSpo7z4c+DUKH4AWMyMZKTxTz_oi1iGtiUuHqQjhFG0gMu0g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Resend to the mailing list due to the bounceback caused by html format]

On 10/04/2013 09:37 PM, Bjorn Helgaas wrote:
> On Fri, Oct 4, 2013 at 9:42 PM, DengCheng Zhu <DengCheng.Zhu@imgtec.com> wrote:
>>> Does this fix a user-visible problem?  If so, what does it look like
>>> when the problem occurs?
>> No, I found the problem while debugging another issue and trying to
>> understand this piece of code and after looking into different versions of
>> PIIX4 datasheets. But I don't think it should prevent such a fix because
>> the code is straightforward and the spec is clear enough. If the existing
>> encoding was intentionally made like this by the code author due to the
>> inaccuracy of the spec, then it's very likely some code comments were
>> placed here. There are 2 possibilities:
>>
>> - This fix breaks something. People should have to bisect the problem.
>> - This fix is valid. Some day people need PIIX4 mem quirks and they don't
>>    have to run into a possibly well-hidden issue.
>>
>> What do you think?
> Don't worry, I'm willing to fix it even if nobody has actually
> reported a problem.  It's just nice to include the symptoms if
> somebody *has* reported it, so when other people see the same symptom,
> they can more easily find the fix.

Ah, I see. Thanks.

So far I didn't see them on any branch in kernel/git/helgaas/pci.git 
<https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/>
Is this the right place to look at? Thanks.


Deng-Cheng


