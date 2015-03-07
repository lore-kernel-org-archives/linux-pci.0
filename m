Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57546 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649AbbCGUwD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 7 Mar 2015 15:52:03 -0500
Date: Sat, 7 Mar 2015 21:50:42 +0100
From: Borislav Petkov <bp@suse.de>
To: Yinghai Lu <yinghai@kernel.org>
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
Subject: Re: [PATCH v2 04/15] x86, kaslr: get kaslr_enabled back correctly
Message-ID: <20150307205042.GA3380@pd.tnic>
References: <1425456048-16236-1-git-send-email-yinghai@kernel.org>
 <1425456048-16236-5-git-send-email-yinghai@kernel.org>
 <20150304101649.GA3663@pd.tnic>
 <CAE9FiQWKNDgzJtDVV34e7vWTu7LtqdDKB4KiN1RZwcZrX70zSA@mail.gmail.com>
 <20150304200000.GB6276@gmail.com>
 <CAE9FiQXJ-ujbhpw8phk5iQM8QFw=9QxDrXK6AdyXqDxmch_bbw@mail.gmail.com>
 <20150306133312.GC4259@pd.tnic>
 <CAE9FiQVux0j=3MOj1V-hAfVtbPGUCtAyzBpkQyjr8iUchFBmOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAE9FiQVux0j=3MOj1V-hAfVtbPGUCtAyzBpkQyjr8iUchFBmOg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 06, 2015 at 09:49:25AM -0800, Yinghai Lu wrote:
> That is "copy and paste" instead of attachment for easy review.
> but gmail web client convert tab to spaces.

Next time you send a patch *only* for review *and* *not* for
application, do state that at the top like everyone else. Better yet,
don't use gmail for sending patches at all.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
