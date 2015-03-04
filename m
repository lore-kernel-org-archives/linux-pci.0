Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37796 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757280AbbCDUAG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2015 15:00:06 -0500
Date: Wed, 4 Mar 2015 21:00:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Matt Fleming <matt.fleming@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
	Borislav Petkov <bp@suse.de>, Baoquan He <bhe@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 04/15] x86, kaslr: get kaslr_enabled back correctly
Message-ID: <20150304200000.GB6276@gmail.com>
References: <1425456048-16236-1-git-send-email-yinghai@kernel.org>
 <1425456048-16236-5-git-send-email-yinghai@kernel.org>
 <20150304101649.GA3663@pd.tnic>
 <CAE9FiQWKNDgzJtDVV34e7vWTu7LtqdDKB4KiN1RZwcZrX70zSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWKNDgzJtDVV34e7vWTu7LtqdDKB4KiN1RZwcZrX70zSA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Yinghai Lu <yinghai@kernel.org> wrote:

> On Wed, Mar 4, 2015 at 2:16 AM, Borislav Petkov <bp@alien8.de> wrote:
> > On Wed, Mar 04, 2015 at 12:00:37AM -0800, Yinghai Lu wrote:
> >> commit f47233c2d34f ("x86/mm/ASLR: Propagate base load address calculation")
> >> is using address as value for kaslr_enabled.
> >>
> >> That will random kaslr_enabled get that set or cleared.
> >> Will have problem for system really have kaslr enabled.
> >>
> >> -v2: update changelog.
> >
> > This is still not good enough. Please do this:
> >
> > In commit f47233c2d34f we did A. The problem with that is B. Change the
> > code to do C.
> >
> > Now you only have to fill out the A,B and C variables with the
> > respective text which is understandable even for people who don't know
> > this code.
> >
> 
> I don't know, that is trivial and obvious.

The fix might be obvious, the effects of the bug are not obvious at 
all, as you yourself show that you don't understand your own change, 
which is evident from the changelog you've written:

> Please check if it is ok:
> 
> Subject: [PATCH v3] x86, kaslr: get kaslr_enabled back correctly

Missing capitalization.

> 
> commit f47233c2d34f ("x86/mm/ASLR: Propagate base load address calculation")
> is using address as value for kaslr_enabled.

Missing capitalization. Do you really expect maintainers to fix up 
every single sentence of yours??

> That will get wrong value for kaslr_enabled, so have problem for 
> system really have kaslr enabled.

This sentence does not parse, nor is it correct: the bug isn't just 
triggering on systems that want to have kaslr enabled - but also on 
bootloaders that happen to pass in a kaslr boot parameter but have the 
switch value disabled...

You also need to point out the important fact that bootloaders that 
don't try to use the kaslr extension (i.e. that don't use SETUP_KASLR) 
work just fine - this is why the bug was not noticed to begin with, 
i.e. the overwhelming majority of systems out there.

> This patch change to using early map and accessing the value.

s/change to using/changes the code to use/

It is totally unacceptable that you don't do proper analysis of the 
patches you submit, and that you don't bother writing proper, readable 
changelogs.

Your flippant "that is trivial and obvious" attitude towards 
changelogs is unacceptable as well. And this is not about English 
knowledge: missing capitalization is a very simple concept any 
beginning coder should be able to graps the first time it's pointed 
out... yet for the past 3 years half of your patches had totally 
careless, often unreadable changelogs.

These subpar changelogs and patches show plain laziness, sloppiness 
and lack of care to write clean changelogs - and that sloppiness not 
only makes it much harder for maintainers to process your patches, but 
also tends to creep over into your patches as well, causing repeat 
problems again and again...

Thanks,

	Ingo
