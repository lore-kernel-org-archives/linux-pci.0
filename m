Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63108 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3JKWCI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2013 18:02:08 -0400
Received: by mail-ie0-f179.google.com with SMTP id aq17so7384009iec.38
        for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2013 15:02:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6zGZkL7hWmBOVzd2=MWvY18v5xLO1qg7jVfSgqa8wHzw@mail.gmail.com>
References: <CAPWoNkJ3NKM-_g93LdRpjvdNFtLt-Pjpg4d4oEKC9CvkpzZ-Wg@mail.gmail.com>
 <CAPWoNkLQUbFG2vZ7wqoqqVNj4uxKz3Fa_vsSH=1_TDD=XC1f2A@mail.gmail.com>
 <CAErSpo5ZZgdpkK+QdQUEnNCEXcG_T+QBWTVoQnMTghxkX7n2HA@mail.gmail.com>
 <CAPWoNkJtnE3ASH0AdgfAD-3soa13DyH-zZAyzWMg9K2=nCX87Q@mail.gmail.com>
 <CAPWoNkLTC+1ba3vwY0xiJVmmebvuXZBTwiyH5HAFfE8mRReaRQ@mail.gmail.com> <CAErSpo6zGZkL7hWmBOVzd2=MWvY18v5xLO1qg7jVfSgqa8wHzw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 11 Oct 2013 16:01:47 -0600
Message-ID: <CAErSpo49ZLfxkEanmrrwwiqHR8koiCakqe9h8My2Mu1yA4R1Ww@mail.gmail.com>
Subject: Re: PCIE device errors after linux kernel upgrade
To: Leon Ravich <lravich@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 16, 2013 at 4:05 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Aug 6, 2013 at 11:41 PM, Leon Ravich <lravich@gmail.com> wrote:
>> From comparison of pci printout from the two kernel ,
>> beside the EDAC errors I noticed other strange differences:
>>
>> In 3.8.13 I got BAR 7 and BAR 8:
>> [   39.017749] pci 0000:00:00.0: BAR 8: assigned [mem 0xc0000000-0xdfffffff]
>> [   39.024530] pci 0000:00:00.0: BAR 7: can't assign io (size 0x10000)
>>
>> In 3.8.13 I am getting:
>> [   38.931873] pci_bus 0000:01: busn_res: can not insert [bus 01-ff]
>> under [bus 00-01] (conflicts with (null) [bus 00-01])
>>
>>
>> On 6 August 2013 09:32, Leon Ravich <lravich@gmail.com> wrote:
>>> Thanks Bjorn.
>
> Is this still a problem, or have you found a solution in the meantime?
>
>>> 1) If I understand it right this patch only removes the "pci
>>> 0000:00:00.0: ignoring class 0x0b2000 (doesn't
>>> match header type 01)" message , don't  care about it , had it before .
>
> It also affects how the PCI core handles the device.  But as you said,
> if you had the message before, it's probably not the cause of the
> current problem.
>
>>> 2) regarding the comparing of printouts:
>
> Can you post the complete logs somewhere, maybe in a bugzilla or similar?
>
> Where are the "PCIE ERR_CAP_STAT" and similar messages from?  My quick
> grep didn't find them.

Did this problem ever get resolved?  Is there anything we need to look at?

Bjorn
