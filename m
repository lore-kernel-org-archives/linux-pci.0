Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:45699 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755872Ab2EGPLa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 May 2012 11:11:30 -0400
Received: by lahd3 with SMTP id d3so358782lah.19
        for <linux-pci@vger.kernel.org>; Mon, 07 May 2012 08:11:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FA3B596.3050106@openwrt.org>
References: <1335808019-24502-1-git-send-email-blogic@openwrt.org>
 <4F9ED1DC.3050007@gmail.com> <4F9FE4F6.5070909@openwrt.org>
 <CAErSpo4bZ=0=DtbDots_GOGeLNhX6Q4eJrdetaFQMv4iiv5+XA@mail.gmail.com>
 <4FA32E47.7020406@gmail.com> <4FA3B596.3050106@openwrt.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 7 May 2012 08:11:08 -0700
Message-ID: <CAErSpo4AQh3cJzULkmP_Dqsf0cSPRP1WqvhuQR3gePXw2rN7rQ@mail.gmail.com>
Subject: Re: [PATCH] OF: PCI: const usage needed by MIPS
To: John Crispin <blogic@openwrt.org>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 4, 2012 at 3:55 AM, John Crispin <blogic@openwrt.org> wrote:
> Hi David,
>
>> The problem is when you start declaring function pointers in various
>> ops vectors.
>>
>> Consider:
>>
>> void (*foo)(const struct pci_dev *)
>> void (*bar)(struct pci_dev *)
>>
>> foo and bar are not type compatible, and you will get compiler
>> warnings if you use one where the other is expected.

Oh, right.  I vaguely remember tripping over this a few years ago when
I refactored pci_swizzle_interrupt_pin().  Thanks for enhancing my
simple understanding.

>> So the question is:  Are we ever going to the address of any of the
>> functions that are being modified?  If so, we have created a problem.
>
> i could not find any place in the code where this happens, which does
> not mean that there are none.

I compiled alpha, ia64, mips, parisc, powerpc, sh, sparc, and x86 and
didn't see any issues related to this patch.  There might still be
something,  but I'm willing to help work through them or revert this
if it turns out to be a problem.  I'm still assuming that Grant will
handle this.

Bjorn
