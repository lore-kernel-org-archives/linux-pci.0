Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:47103 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbCJFc0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 01:32:26 -0400
Date: Tue, 10 Mar 2015 06:32:19 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86:pci: Change  sta2x11_dma_ops stucture to use
 switolb_dma_supported as it's dma_supported function in sta2x11-fixup.c
Message-ID: <20150310053219.GA11197@gmail.com>
References: <1425959625-14551-1-git-send-email-xerofoify@gmail.com>
 <20150310044500.GA9015@gmail.com>
 <0393A100-7C14-4185-AD1A-5C2364B8CEE3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0393A100-7C14-4185-AD1A-5C2364B8CEE3@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Nicholas Krause <xerofoify@gmail.com> wrote:

> 
> 
> On March 10, 2015 12:45:01 AM EDT, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >* Nicholas Krause <xerofoify@gmail.com> wrote:
> >
> >> This changes the structure sta2x11_dma_ops stucture to use
> >switolb_dma_supported as it's 
> >> function for dma_supported hardware verus setting this value to NULL
> >as this should be set 
> >> correctly for when dma_supported function needs to be called for
> >hardware needing this 
> >> function to be supported. Otherwise hardware needing this function to
> >be supported will 
> >> either cause a kernel panic or oops due to a NULL pointer being
> >dereferenced in the 
> >> structure, sta1x11_dma_ops for the dma_supported function. Further
> >more in  order to 
> >> prevent a kernel panic or oops here due to a NULL pointer being
> >deferred here we add the 
> >> function, swiotlb_dma_supported as the dma_supported function for the
> >structure,
> >> sta2x11_dma_ops.
> >
> >Pleasedontresendtotallyunstructuredandunreadablechangelogs.
> >
> >You also (still) don't explain where and how this supposed crash might 
> >happen in practice. Please don't resend unless you've addressed those 
> >deficiencies.
> >
> >I.e. I'm not convinced you know what you are modifying there and what 
> >effects your modifications will have.
> >
> >Thanks,
> >
> >	Ingo
> Ingo, 
> I was just wondering why my patch wasn't merged yet.  In addition this patch is more of a preventive measure as if there is no function pointer here either we kernel panic or oops at best if hardware needs to access a dma function for this structure .  At the moment I am unaware of any actual hardware that causes this issues, however this doesn't mean it won't happen at some point. I can rewrite my change log to this reasoning if required.
> Nick

1)

So as a reply to my feedback complaining about the quality of your 
submissions, you write an unstructured mail put into a single line 
with no newline at all? *whoosh*

2)

So I restructured your reply, added newlines at logical boundaries of 
thought, added proper punctuation and capitalization, fixed typos, 
removed phantom spaces - to make it minimally readable:

> I was just wondering why my patch wasn't merged yet.
>
> In addition, this patch is more of a preventive measure, as if there 
> is no function pointer here either we kernel panic or oops at best 
> if hardware needs to access a DMA function for this structure.
>
> At the moment I am unaware of any actual hardware that causes these 
> issues, however this doesn't mean it won't happen at some point.
>
> I can rewrite my change log to this reasoning if required.

You should have done this before expecting others to spend time on 
your mails.

3)

As to the technical substance of your patch: where exactly would the 
kernel panic or oops? Your changelog is missing actual analysis.

4)

And if you are wondering why maintainers have learned to start 
ignoring your trivial patches:

 - Unstructured changelogs, typos, missing punctuation, missing
   newlines, missing capitalization, phantom spaces cause submissions 
   to be ignored as trivially deficient.

 - No real analysis is found in your patch, beyond the line that was
   spewed out by 'git grep -i fixme'.

 - Mass mailing of borderline useless patches is a waste of time for
   everyone. There are thousands of trivial FIXME's in the kernel and
   you want to generate a commit for every single one?

The thing is, you now know how to write patches and how to upstream 
them. So it's time to rise beyond trivial patches: how about reading 
and understanding kernel code and fixing some real bugs?

5)

All in one, I'm not convinced you went beyond the 'git grep -i fixme' 
line in reading kernel code...

But it's up to Bjorn whether to merge your patch.

Thanks,

	Ingo
