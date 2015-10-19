Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36828 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbbJSRV5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2015 13:21:57 -0400
MIME-Version: 1.0
In-Reply-To: <CAE9FiQWaRAv_UvvEzhg6XFK11Gvq6Gkq_APLpbX8NDWhbi-c2w@mail.gmail.com>
References: <1445270436-3797-1-git-send-email-roland@kernel.org> <CAE9FiQWaRAv_UvvEzhg6XFK11Gvq6Gkq_APLpbX8NDWhbi-c2w@mail.gmail.com>
From: Roland Dreier <roland@kernel.org>
Date: Mon, 19 Oct 2015 10:21:37 -0700
Message-ID: <CAG4TOxOSnP6OBw-=Rnj6=ihBu2Ndue1u_Ww3nM+deRKZpo_p1A@mail.gmail.com>
Subject: Re: Running out of IO space because of innocuous-looking DSDT change
To: Yinghai Lu <yinghai@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 19, 2015 at 10:00 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> I would suggest to expand standard_io_resources[] to include all
> possible conflict that we should avoid, like the io port for serial and cf8/cf9.
>
> Then we could just set PCIBIOS_MIN_IO to 0 for x86.

That would work on my system, which is a well-behaved standard server.
But I thought the issue was weird vendor-specific stuff (Sony
laptops?) where there are undocumented nonstandard IO resources that
also aren't reserved in ACPI?

 - R.
