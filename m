Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:64528 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519Ab2KHTMZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2012 14:12:25 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so1308324dak.19
        for <linux-pci@vger.kernel.org>; Thu, 08 Nov 2012 11:12:25 -0800 (PST)
MIME-Version: 1.0
Reply-To: linasvepstas@gmail.com
In-Reply-To: <CAHrUA35gL7=PjjqsgH3T=MRnM7LuzKAT1g8+DkZLMfGvJOy3KQ@mail.gmail.com>
References: <CAHrUA35gL7=PjjqsgH3T=MRnM7LuzKAT1g8+DkZLMfGvJOy3KQ@mail.gmail.com>
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Thu, 8 Nov 2012 13:12:05 -0600
Message-ID: <CAHrUA37v9tCNhOJau=t42EmJ1ha7WY5j2-QqsNixdOEroeotCg@mail.gmail.com>
Subject: PCI error recovery patch [was: Request for feedback]
To: linux-pci@vger.kernel.org
Cc: "Pandarathil, Vijaymohan R" <vijaymohan.pandarathil@hp.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Vijay,

I no longer actively maintain the error recovery stack.  However, your patch
and explanation for it looks reasonable to me --- it was certainly never the
intent that a non-capable driver report a successful recovery.

I'm guessing that the bug that you are fixing was introduced when the
original pci error recovery code was integrated with AER (PCI-AER was
standardized after the original error recovery system was created, and I did
not really pay very much attention to AER at the time).

FWIW, I guess I could add a

Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>

but I'm not sure that really means much any more :-)

-- Linas



On 7 November 2012 21:50, Pandarathil, Vijaymohan R
<vijaymohan.pandarathil@hp.com> wrote:
> Hi Bjorn/Linas,
>
> I got your names from the PCI/PCI-error-recovery maintainers list. I had
> posted the following request last week.
> http://article.gmane.org/gmane.linux.kernel.pci/18465
>
> Being a newbie, it would be extremely helpful to get your guidance on
> these changes, specifically on any side effects it has. I am also working
> on another set of patches to improve the PCI error recovery/containment
> capabilities of KVM. But if the above change cannot be made first, I may
> have to figure out alternate approach for the second set of patches.
>
> Thanks
>
> Vijay
