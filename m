Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33038 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbbCGAwa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 19:52:30 -0500
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLk-qeHLqejR47TmT8wzrkjF9eQhfGPJYDoejD+AdkmOQ@mail.gmail.com>
References: <1425456048-16236-1-git-send-email-yinghai@kernel.org>
	<1425456048-16236-2-git-send-email-yinghai@kernel.org>
	<20150306135534.GD4259@pd.tnic>
	<CAE9FiQXzv7TPMRA+RqSdV0ERiW3KYA-2KOyDKBrZDn3Zd5RcrQ@mail.gmail.com>
	<CAGXu5jLf+=CMs0qj4nRG-kw1YiQ-eMFHFpAE8uVUitqmGOG7gA@mail.gmail.com>
	<CAE9FiQU3jKn260cce7Zvo0Qy0ksDKB=-o2m_drBmO4fpBv8Wow@mail.gmail.com>
	<CAGXu5jLk-qeHLqejR47TmT8wzrkjF9eQhfGPJYDoejD+AdkmOQ@mail.gmail.com>
Date: Fri, 6 Mar 2015 16:52:29 -0800
Message-ID: <CAE9FiQXRyO1aej7_JOfUfG7h-qrFHfukEP+9JxYm5+e9s4-Zpg@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] x86, kaslr: Use init_size instead of run_size
From: Yinghai Lu <yinghai@kernel.org>
To: Kees Cook <keescook@chromium.org>
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
	Josh Triplett <josh@joshtriplett.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Junjie Mao <eternal.n08@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 6, 2015 at 11:56 AM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Mar 6, 2015 at 11:28 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> Okay, I've proven this to myself now. :) I think it would be valuable
> to call out that brk and bss are included in the _end calculation. For
> others:
...
> So, _end - _text does equal _text + bss offset + bss size + brk size
>
> Thanks! It'll be nice to lose the run_size hack. Adding some
> documentation to the code here would help others in the future trying
> to find this value, I think. :)

in arch/x86/kernel/vmlinux.lds.S, we have

        /* BSS */
        . = ALIGN(PAGE_SIZE);
        .bss : AT(ADDR(.bss) - LOAD_OFFSET) {
                __bss_start = .;
                *(.bss..page_aligned)
                *(.bss)
                . = ALIGN(PAGE_SIZE);
                __bss_stop = .;
        }

        . = ALIGN(PAGE_SIZE);
        .brk : AT(ADDR(.brk) - LOAD_OFFSET) {
                __brk_base = .;
                . += 64 * 1024;         /* 64k alignment slop space */
                *(.brk_reservation)     /* areas brk users have reserved */
                __brk_limit = .;
        }

        _end = .;

so _end already cover bss and brk.
