Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36042 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756566AbcB0SWF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 27 Feb 2016 13:22:05 -0500
MIME-Version: 1.0
In-Reply-To: <20160227151457.GA30280@localhost>
References: <20160227151457.GA30280@localhost>
Date: Sat, 27 Feb 2016 10:22:04 -0800
Message-ID: <CA+55aFwd3zJNyy=7n945GfKYv0RhMuX6HUfDAqvZWrQyL=4GUA@mail.gmail.com>
Subject: Re: [GIT PULL] PCI fixes for v4.5
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Jake Oshins <jakeo@microsoft.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	=?UTF-8?B?0J7Qu9C10LMg0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>,
	Sunjin Yang <fan4326@gmail.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 27, 2016 at 7:14 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> The big chunk here is the paravirtual front-end for Linux guests of a
> Microsoft Hyper-V VM.  It's new, so no risk of regressions to pci-hyperv
> itself.  It does include minor changes to common code, but they are
> low-risk.

I really don't want to take new features like this that change
existing code when I'm about to do a rc6.

I've done late hardware-enabling pulls before with new drivers etc,
but then they are meant to enable consumer hardware that people would
have trouble getting Linux installed on etc. A paravirt Hyper-V VM
install doesn't really count as that kind of "we need to get this in
quickly out of the normal development model".

I didn't check, but can you peel off that part if it's at the top and
just send me the actual bugfixes?

                 Linus
