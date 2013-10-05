Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39980 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3JEEh4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 5 Oct 2013 00:37:56 -0400
Received: by mail-ie0-f175.google.com with SMTP id e14so10993302iej.20
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2013 21:37:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1F7D814BDD93B94493CEE724A97FB4DC01C80AAE@BADAG02.ba.imgtec.org>
References: <1380929453-15428-1-git-send-email-dengcheng.zhu@imgtec.com>
 <1380929453-15428-2-git-send-email-dengcheng.zhu@imgtec.com>
 <CAErSpo47zCU_sR46s1osmZ00AtkX-z++eezzbxee4yr3yDhQgw@mail.gmail.com> <1F7D814BDD93B94493CEE724A97FB4DC01C80AAE@BADAG02.ba.imgtec.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 4 Oct 2013 22:37:35 -0600
Message-ID: <CAErSpo7z4c+DUKH4AWMyMZKTxTz_oi1iGtiUuHqQjhFG0gMu0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI/quirks: Fix PIIX4 memory base and size mask
To: DengCheng Zhu <DengCheng.Zhu@imgtec.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	James Hogan <James.Hogan@imgtec.com>,
	Qais Yousef <Qais.Yousef@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 4, 2013 at 9:42 PM, DengCheng Zhu <DengCheng.Zhu@imgtec.com> wrote:
>> Does this fix a user-visible problem?  If so, what does it look like
>> when the problem occurs?
>
> No, I found the problem while debugging another issue and trying to
> understand this piece of code and after looking into different versions of
> PIIX4 datasheets. But I don't think it should prevent such a fix because
> the code is straightforward and the spec is clear enough. If the existing
> encoding was intentionally made like this by the code author due to the
> inaccuracy of the spec, then it's very likely some code comments were
> placed here. There are 2 possibilities:
>
> - This fix breaks something. People should have to bisect the problem.
> - This fix is valid. Some day people need PIIX4 mem quirks and they don't
>   have to run into a possibly well-hidden issue.
>
> What do you think?

Don't worry, I'm willing to fix it even if nobody has actually
reported a problem.  It's just nice to include the symptoms if
somebody *has* reported it, so when other people see the same symptom,
they can more easily find the fix.

Bjorn

>> I assume the other patches (2-4) are cleanups that don't fix any
>> problems.
>
> Definitely, as indicated by patch titles and commit messages.
>
>
> Deng-Cheng
>
> ________________________________________
> From: Bjorn Helgaas [bhelgaas@google.com]
> Sent: Friday, October 04, 2013 7:13 PM
> To: DengCheng Zhu
> Cc: linux-pci@vger.kernel.org; James Hogan; Qais Yousef
> Subject: Re: [PATCH v2 1/4] PCI/quirks: Fix PIIX4 memory base and size mask
>
> On Fri, Oct 4, 2013 at 5:30 PM, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com> wrote:
>> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>>
>> According to Intel PIIX4 datasheet: The memory address consists of a 17-bit
>> base address (AD[31:15]) and a 7-bit mask (AD[21:15]). This provides memory
>> ranges from 32 Kbytes to 4 Mbytes in size.
>>
>> This is true for both devices 12 and 13. This patch fixes it.
>
> Does this fix a user-visible problem?  If so, what does it look like
> when the problem occurs?
>
> I assume the other patches (2-4) are cleanups that don't fix any problems.
>
>> Ref 1: www.intel.com/assets/pdf/datasheet/290562.pdf
>>        April 1997 version 001 (p131 bottom, p226 top)
>> Ref 2: www.intel.com/assets/pdf/specupdate/297738.pdf
>>        January 2002 version 017 (Nothing against the fix in the
>>        specification update was found.)
>>
>> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>> Reviewed-by: James Hogan <james.hogan@imgtec.com>
>> ---
>>  drivers/pci/quirks.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index f6c31fa..3e7e489 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -414,9 +414,9 @@ static void piix4_mem_quirk(struct pci_dev *dev, const char *name, unsigned int
>>         pci_read_config_dword(dev, port, &devres);
>>         if ((devres & enable) != enable)
>>                 return;
>> -       base = devres & 0xffff0000;
>> -       mask = (devres & 0x3f) << 16;
>> -       size = 128 << 16;
>> +       base = devres & 0xffff8000;
>> +       mask = (devres & 0x7f) << 15;
>> +       size = 128 << 15;
>>         for (;;) {
>>                 unsigned bit = size >> 1;
>>                 if ((bit & mask) == bit)
>> --
>> 1.7.1
>>
>>
>
