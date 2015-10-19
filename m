Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35076 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbbJSRAW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2015 13:00:22 -0400
MIME-Version: 1.0
In-Reply-To: <1445270436-3797-1-git-send-email-roland@kernel.org>
References: <1445270436-3797-1-git-send-email-roland@kernel.org>
Date: Mon, 19 Oct 2015 10:00:21 -0700
Message-ID: <CAE9FiQWaRAv_UvvEzhg6XFK11Gvq6Gkq_APLpbX8NDWhbi-c2w@mail.gmail.com>
Subject: Re: Running out of IO space because of innocuous-looking DSDT change
From: Yinghai Lu <yinghai@kernel.org>
To: Roland Dreier <roland@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 19, 2015 at 9:00 AM, Roland Dreier <roland@kernel.org> wrote:
> Would it make sense to change the kernel to reduce PCIBIOS_MIN_IO in
> my case?  I could make it generic and send it upstream, or just hack
> it locally.  Or (given my ignorance of ACPI in the real world) is this
> a broken BIOS change that I should ask my BIOS vendor to revert?
> Or... ?

I would suggest to expand standard_io_resources[] to include all
possible conflict that we should avoid, like the io port for serial and cf8/cf9.

Then we could just set PCIBIOS_MIN_IO to 0 for x86.

Thanks

Yinghai
