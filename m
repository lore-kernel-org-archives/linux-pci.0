Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:38936 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbCFRt0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 12:49:26 -0500
MIME-Version: 1.0
In-Reply-To: <20150306133312.GC4259@pd.tnic>
References: <1425456048-16236-1-git-send-email-yinghai@kernel.org>
	<1425456048-16236-5-git-send-email-yinghai@kernel.org>
	<20150304101649.GA3663@pd.tnic>
	<CAE9FiQWKNDgzJtDVV34e7vWTu7LtqdDKB4KiN1RZwcZrX70zSA@mail.gmail.com>
	<20150304200000.GB6276@gmail.com>
	<CAE9FiQXJ-ujbhpw8phk5iQM8QFw=9QxDrXK6AdyXqDxmch_bbw@mail.gmail.com>
	<20150306133312.GC4259@pd.tnic>
Date: Fri, 6 Mar 2015 09:49:25 -0800
Message-ID: <CAE9FiQVux0j=3MOj1V-hAfVtbPGUCtAyzBpkQyjr8iUchFBmOg@mail.gmail.com>
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

On Fri, Mar 6, 2015 at 5:33 AM, Borislav Petkov <bp@suse.de> wrote:
> Please use checkpatch before submitting patches:
>
> WARNING: please, no spaces at the start of a line
> #71: FILE: arch/x86/kernel/setup.c:433:
> +    unsigned char *data;$
>
> WARNING: please, no spaces at the start of a line
> #72: FILE: arch/x86/kernel/setup.c:434:
> +    unsigned long offset = sizeof(struct setup_data);$
>
> WARNING: please, no spaces at the start of a line
> #74: FILE: arch/x86/kernel/setup.c:436:
> +    data = early_memremap(pa_data, offset + 1);$
>
> WARNING: please, no spaces at the start of a line
> #75: FILE: arch/x86/kernel/setup.c:437:
> +    if (!data) {$
>
> ERROR: code indent should use tabs where possible
> #76: FILE: arch/x86/kernel/setup.c:438:
> +        kaslr_enabled = true;$
>
> WARNING: please, no spaces at the start of a line
> #76: FILE: arch/x86/kernel/setup.c:438:
> +        kaslr_enabled = true;$
>
> ERROR: code indent should use tabs where possible
> #77: FILE: arch/x86/kernel/setup.c:439:
> +        return;$
>
> WARNING: please, no spaces at the start of a line
> #77: FILE: arch/x86/kernel/setup.c:439:
> +        return;$
>
> WARNING: please, no spaces at the start of a line
> #78: FILE: arch/x86/kernel/setup.c:440:
> +    }$
>
> WARNING: please, no spaces at the start of a line
> #80: FILE: arch/x86/kernel/setup.c:442:
> +    kaslr_enabled = *(data + offset);$
>
> WARNING: please, no spaces at the start of a line
> #81: FILE: arch/x86/kernel/setup.c:443:
> +    early_memunmap(data, offset + 1);$
>
> total: 2 errors, 9 warnings, 19 lines checked
>
> NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
>       scripts/cleanfile
>
> Your patch has style problems, please review.
>
> If any of these errors are false positives, please report
> them to the maintainer, see CHECKPATCH in MAINTAINERS.
>

That is "copy and paste" instead of attachment for easy review.
but gmail web client convert tab to spaces.
