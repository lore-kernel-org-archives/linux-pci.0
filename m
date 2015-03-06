Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56537 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678AbbCFN7m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 Mar 2015 08:59:42 -0500
Date: Fri, 6 Mar 2015 14:58:25 +0100
From: Borislav Petkov <bp@suse.de>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Matt Fleming <matt.fleming@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
	Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-pci@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 02/15] x86, boot: move ZO to end of buffer
Message-ID: <20150306135825.GE4259@pd.tnic>
References: <1425456048-16236-1-git-send-email-yinghai@kernel.org>
 <1425456048-16236-3-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1425456048-16236-3-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 04, 2015 at 12:00:35AM -0800, Yinghai Lu wrote:
> bp found data from boot stage can not be used kernel stage.
> 
> Actually those data area is overlapped with VO kernel bss stage, and clear_bss()

"VO kernel bss stage"?

I'm sure you can think of a better explanation. Right now I'm thinking
of "Video Only" or "Virtually Omnipresent" or ... I can go all day.
Let's be more precise here please.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
