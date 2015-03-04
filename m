Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36857 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757870AbbCDTlj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2015 14:41:39 -0500
Date: Wed, 4 Mar 2015 20:41:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>, Borislav Petkov <bp@alien8.de>,
	Matt Fleming <matt.fleming@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 04/15] x86, kaslr: get kaslr_enabled back correctly
Message-ID: <20150304194133.GA6276@gmail.com>
References: <1425456048-16236-1-git-send-email-yinghai@kernel.org>
 <1425456048-16236-5-git-send-email-yinghai@kernel.org>
 <20150304101649.GA3663@pd.tnic>
 <alpine.LNX.2.00.1503041652550.26925@pobox.suse.cz>
 <CAE9FiQU=wCmGEKoq06EV=oi=xxYwh7FGMEt7XiiPwrOLVo1OrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQU=wCmGEKoq06EV=oi=xxYwh7FGMEt7XiiPwrOLVo1OrA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Yinghai Lu <yinghai@kernel.org> wrote:

> On Wed, Mar 4, 2015 at 7:54 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> 
> >
> > Also this 15-patch series needs to be separated into two patchsets. The
> > whole series is not appropriate for -rc3, but this particular one at least
> > is a regression fix that has to go in.
> 
> The first 4 should go v4.0.
> 
> could leave others to v4.1

Then please submit the first 4 only for the time being, and submit the 
rest once Boris has accepted and applied the fixes.

Thanks,

	Ingo
