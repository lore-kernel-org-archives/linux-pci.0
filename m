Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36269 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288AbbCFTxX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 14:53:23 -0500
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVt8Bi==r7pPhSOcSTmmpkjZ4c7O6iphbzFkgbugzKbqw@mail.gmail.com>
References: <1425456048-16236-1-git-send-email-yinghai@kernel.org>
	<1425456048-16236-5-git-send-email-yinghai@kernel.org>
	<20150304101649.GA3663@pd.tnic>
	<CAE9FiQWKNDgzJtDVV34e7vWTu7LtqdDKB4KiN1RZwcZrX70zSA@mail.gmail.com>
	<20150304200000.GB6276@gmail.com>
	<CAE9FiQXJ-ujbhpw8phk5iQM8QFw=9QxDrXK6AdyXqDxmch_bbw@mail.gmail.com>
	<20150306133312.GC4259@pd.tnic>
	<CAE9FiQVt8Bi==r7pPhSOcSTmmpkjZ4c7O6iphbzFkgbugzKbqw@mail.gmail.com>
Date: Fri, 6 Mar 2015 11:53:22 -0800
Message-ID: <CAE9FiQXbQ37A7+a+dk4LdPs7DCr68EfWwypR9X4dyPfixH8PZA@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] x86, kaslr: get kaslr_enabled back correctly
From: Yinghai Lu <yinghai@kernel.org>
To: Borislav Petkov <bp@suse.de>
Cc: Ingo Molnar <mingo@kernel.org>,
	Matt Fleming <matt.fleming@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
	Baoquan He <bhe@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 6, 2015 at 11:50 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Mar 6, 2015 at 5:33 AM, Borislav Petkov <bp@suse.de> wrote:
>
>>
>> "However, the setup_data linked list and thus the element which contains
>> kaslr_enabled is chained together using physical addresses. At the
>> time when we access it in the kernel proper, we're already running
>> with paging enabled and therefore must access it through its virtual
>> address."
>>
>> That's it, now how hard was to explain it that way?
>
> No, I don't think your change log is right.
>
> Actually the old code is using address as value.
>
> if the old code would be like:
>
> kaslr_enabled = (bool)(*(unsigned char *)(pa_data + sizeof(struct setup_data)));
>
> then your change log would be good, but the old code is
>
> kaslr_enabled = (bool)(pa_data + sizeof(struct setup_data));

Please check if you are ok with this:

Subject: [PATCH v4] x86, kaslr: Access the correct kaslr_enabled variable

commit f47233c2d34f ("x86/mm/ASLR: Propagate base load address calculation")
started passing KASLR status to kernel proper, but it uses address as
the vaule.

That will get wrong value back for kaslr_enabled in kernel stage.
1. When kaslr is not enabled at boot/choose_kernel_location, if kaslr_enabled
get set wrongly in setup.c, late in module.c::get_module_load_offset
will return not wanted random module load offset.
That change behavior when HIBERNATION is defined or nokaslr is passed.

2. When kaslr is enabled at boot/choose_kernel_location, if kaslr_enabled
get cleared wrongly in setup.c, late in module.c::get_module_load_offset
will not return wanted random module load offset.

The setup_data linked list and thus the element which contains
kaslr_enabled is chained together using physical addresses. At the
time when we access it in the kernel proper, we're already running
with paging enabled and therefore must access it through its virtual
address.

This patch changes the code to use early_memmap and access the value,
and will keep boot and kernel consistent with kaslr.

-v3: add checking return from early_memmap according to Boris.
