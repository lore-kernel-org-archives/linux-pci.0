Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48556 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbbCKSfQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 11 Mar 2015 14:35:16 -0400
Date: Wed, 11 Mar 2015 19:35:12 +0100
From: "Luis R. Rodriguez" <mcgrof@suse.com>
To: David Rientjes <rientjes@google.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, bhelgaas@google.com,
	mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
	pure.logic@nexus-software.ie, jgross@suse.com, luto@amacapital.net,
	andy.shevchenko@gmail.com, thomas.petazzoni@free-electrons.com,
	JBeulich@suse.com, bp@suse.de, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC v1 2/2] x86: kconfig: remove UP [IO]APIC options
Message-ID: <20150311183512.GI25035@wotan.suse.de>
References: <1426029275-9594-1-git-send-email-mcgrof@do-not-panic.com>
 <1426029275-9594-3-git-send-email-mcgrof@do-not-panic.com>
 <alpine.DEB.2.10.1503101756460.26407@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1503101756460.26407@chino.kir.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 10, 2015 at 05:58:27PM -0700, David Rientjes wrote:
> On Tue, 10 Mar 2015, Luis R. Rodriguez wrote:
> 
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> > 
> > These were here mostly to help as wrappers for PCI_MSI
> > under certain UP 32-bit build scenarios, now that PCI_MSI
> > properly selects what it needs and when it needs it these
> > Kconfig options are now only enabling users reduce the size
> > of 32-bit kernels optionally. Since 32-bit kernels are not
> > in a huge state of flux and since there is no penalty for
> > adding APIC support other than a bit of size moving forward
> > we simply expect folks to enable APIC options on 32-bit systems
> > when a system needs it, as with PCI_MSI. This lets us remove
> > clutter from the x86 Kconfig file.
> > 
> 
> Check out Linus's latest tree at 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git and see 
> how it looks after commit 50849eefea3b ("x86/Kconfig: Simplify X86_UP_APIC 
> handling") and commit b1da1e715d4f ("x86/Kconfig: Simplify X86_IO_APIC 
> dependencies").

OK thanks yeah I see that now, yeah this can be simplified further, will
send a follow up based on top of these two.

 Luis
