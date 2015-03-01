Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53474 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbbCAJrI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 1 Mar 2015 04:47:08 -0500
Date: Sun, 1 Mar 2015 10:45:57 +0100
From: Borislav Petkov <bp@suse.de>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Matt Fleming <matt.fleming@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/8] x86, kaslr: get kaslr_enabled back correctly
Message-ID: <20150301094557.GA7748@pd.tnic>
References: <1425176259-30087-1-git-send-email-yinghai@kernel.org>
 <1425176259-30087-2-git-send-email-yinghai@kernel.org>
 <CAE9FiQXE5YnSQAkkAxob38Qe+aHZ=niAXL6uLF5650KQPfjPPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAE9FiQXE5YnSQAkkAxob38Qe+aHZ=niAXL6uLF5650KQPfjPPw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 28, 2015 at 06:40:39PM -0800, Yinghai Lu wrote:
> oh, no. the offending commit already got into linus tree.

We're working on it, follow this thread:

http://lkml.kernel.org/r/1424929021.10337.24.camel@intel.com

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
