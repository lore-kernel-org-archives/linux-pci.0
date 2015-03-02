Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40808 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbbCBI6J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 Mar 2015 03:58:09 -0500
Date: Mon, 2 Mar 2015 09:56:54 +0100
From: Borislav Petkov <bp@suse.de>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Matt Fleming <matt.fleming@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/8] x86, kaslr: get kaslr_enabled back correctly
Message-ID: <20150302085654.GA17532@pd.tnic>
References: <1425176259-30087-1-git-send-email-yinghai@kernel.org>
 <1425176259-30087-2-git-send-email-yinghai@kernel.org>
 <CAE9FiQXE5YnSQAkkAxob38Qe+aHZ=niAXL6uLF5650KQPfjPPw@mail.gmail.com>
 <20150301094557.GA7748@pd.tnic>
 <20150301152351.GA17391@gmail.com>
 <CAE9FiQV7DouV+76mzH0jFjFJOFBm-ZmgKpYVjTGAmKao0y3HbA@mail.gmail.com>
 <20150301194904.GC7748@pd.tnic>
 <CAE9FiQVpWQ1NU5Euy2G4btS=94qKCZZ7T0YFsCR1x6iv4C1hjA@mail.gmail.com>
 <20150301202938.GD7748@pd.tnic>
 <CAE9FiQWqfpCg5reKP5TOv=8qJCLxqBDHCKAexH94avZ4b3=irQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAE9FiQWqfpCg5reKP5TOv=8qJCLxqBDHCKAexH94avZ4b3=irQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 01, 2015 at 12:41:10PM -0800, Yinghai Lu wrote:
> Does not look safe yet...

Why?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
