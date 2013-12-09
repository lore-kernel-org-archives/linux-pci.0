Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:62853 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021Ab3LIVV2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Dec 2013 16:21:28 -0500
Received: by mail-ie0-f173.google.com with SMTP id to1so7151059ieb.18
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2013 13:21:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52a632f0.e42c980a.3d86.ffff8faeSMTPIN_ADDED_MISSING@mx.google.com>
References: <003101ceecd5$dd4e79e0$97eb6da0$%han@samsung.com>
 <1385732125-28630-1-git-send-email-ben@datarespons.no> <20131209204349.GA2135@google.com>
 <52a632f0.e42c980a.3d86.ffff8faeSMTPIN_ADDED_MISSING@mx.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 9 Dec 2013 14:21:07 -0700
Message-ID: <CAErSpo7KrWaP5e0TU+J4M+3mU0hUFr9fbt9GFyx8ghBrEJpugQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Kernel oops from pci_disable_msi
To: =?ISO-8859-1?Q?Bj=F8rn_Erik_Nilsen?= <ben@datarespons.no>
Cc: "jg1.han@samsung.com" <jg1.han@samsung.com>,
	"marex@denx.de" <marex@denx.de>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kishon@ti.com" <kishon@ti.com>,
	"Mohit.KUMAR@st.com" <Mohit.KUMAR@st.com>,
	"ajay.khandelwal@st.com" <ajay.khandelwal@st.com>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	"Eric.Nelson@boundarydevices.com" <Eric.Nelson@boundarydevices.com>,
	"troy.kisky@boundarydevices.com" <troy.kisky@boundarydevices.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 9, 2013 at 2:15 PM, Bjørn Erik Nilsen <ben@datarespons.no> wrote:
> Hi Bjorn,
>
> 9. des. 2013 kl. 21:43 skrev Bjorn Helgaas <bhelgaas@google.com>:
>
>> On Fri, Nov 29, 2013 at 02:35:23PM +0100, Bjørn Erik Nilsen wrote:
>>> This patchset address Marek Vasut's comments on the previous
>>> patches. I decided to split into two separate commits as they are
>>> unrelated.
>>>
>>> Bjørn Erik Nilsen (2):
>>>  PCI: designware: Fix crash in dw_msi_teardown_irq
>>>  PCI: designware: Remove redundant call to pci_write_config
>>
>> Hi Bjørn,
>>
>> There's been a fair amount of discussion about the first patch, so I'm
>> ignoring these for now.  Please repost these (again) when that all settles
>> down.
>
> I'm under the impression that all concerns have been addressed and that the discussion has settled down.
>
> What are the outstanding issues to be solved regarding these patches?
>
> I'm asking because these patches are acked-by Marek Vasut and Jingoo Han as well as tested-by Mohit Kumar (and obviously myself).
>
> Jingoo Han confirms he can reproduce the crash on Exynos and that the first patch fixes the problem.

I didn't trace through the discussion closely enough to follow
complaints and their resolution or retraction.  Can you post the
current version including the acks, just so I make sure I get the
latest stuff?

Thanks,
  Bjorn
