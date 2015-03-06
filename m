Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:40416 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504AbbCFTuz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2015 14:50:55 -0500
MIME-Version: 1.0
In-Reply-To: <20150306133312.GC4259@pd.tnic>
References: <1425456048-16236-1-git-send-email-yinghai@kernel.org>
	<1425456048-16236-5-git-send-email-yinghai@kernel.org>
	<20150304101649.GA3663@pd.tnic>
	<CAE9FiQWKNDgzJtDVV34e7vWTu7LtqdDKB4KiN1RZwcZrX70zSA@mail.gmail.com>
	<20150304200000.GB6276@gmail.com>
	<CAE9FiQXJ-ujbhpw8phk5iQM8QFw=9QxDrXK6AdyXqDxmch_bbw@mail.gmail.com>
	<20150306133312.GC4259@pd.tnic>
Date: Fri, 6 Mar 2015 11:50:54 -0800
Message-ID: <CAE9FiQVt8Bi==r7pPhSOcSTmmpkjZ4c7O6iphbzFkgbugzKbqw@mail.gmail.com>
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

>
> "However, the setup_data linked list and thus the element which contains
> kaslr_enabled is chained together using physical addresses. At the
> time when we access it in the kernel proper, we're already running
> with paging enabled and therefore must access it through its virtual
> address."
>
> That's it, now how hard was to explain it that way?

No, I don't think your change log is right.

Actually the old code is using address as value.

if the old code would be like:

kaslr_enabled = (bool)(*(unsigned char *)(pa_data + sizeof(struct setup_data)));

then your change log would be good, but the old code is

kaslr_enabled = (bool)(pa_data + sizeof(struct setup_data));
