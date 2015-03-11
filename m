Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:44271 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbCKA6b (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2015 20:58:31 -0400
Received: by igdh15 with SMTP id h15so8633516igd.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2015 17:58:30 -0700 (PDT)
Date: Tue, 10 Mar 2015 17:58:27 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
cc: bhelgaas@google.com, mingo@redhat.com, tglx@linutronix.de,
	hpa@zytor.com, pure.logic@nexus-software.ie, jgross@suse.com,
	luto@amacapital.net, andy.shevchenko@gmail.com,
	thomas.petazzoni@free-electrons.com, JBeulich@suse.com, bp@suse.de,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC v1 2/2] x86: kconfig: remove UP [IO]APIC options
In-Reply-To: <1426029275-9594-3-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <alpine.DEB.2.10.1503101756460.26407@chino.kir.corp.google.com>
References: <1426029275-9594-1-git-send-email-mcgrof@do-not-panic.com> <1426029275-9594-3-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 10 Mar 2015, Luis R. Rodriguez wrote:

> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> These were here mostly to help as wrappers for PCI_MSI
> under certain UP 32-bit build scenarios, now that PCI_MSI
> properly selects what it needs and when it needs it these
> Kconfig options are now only enabling users reduce the size
> of 32-bit kernels optionally. Since 32-bit kernels are not
> in a huge state of flux and since there is no penalty for
> adding APIC support other than a bit of size moving forward
> we simply expect folks to enable APIC options on 32-bit systems
> when a system needs it, as with PCI_MSI. This lets us remove
> clutter from the x86 Kconfig file.
> 

Check out Linus's latest tree at 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git and see 
how it looks after commit 50849eefea3b ("x86/Kconfig: Simplify X86_UP_APIC 
handling") and commit b1da1e715d4f ("x86/Kconfig: Simplify X86_IO_APIC 
dependencies").
