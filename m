Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:59350 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab3KUVml (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2013 16:42:41 -0500
Received: by mail-ve0-f179.google.com with SMTP id jw12so293478veb.10
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2013 13:42:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQVY6si_3uG6ndbZVOWCY5o8RuXpSLimEo96FVtNC38Dgw@mail.gmail.com>
References: <1384912317-3721-1-git-send-email-yinghai@kernel.org>
	<1384912317-3721-7-git-send-email-yinghai@kernel.org>
	<20131121103021.GA29873@yanx>
	<CAE9FiQXgvaqErd1oiHmt6G8GwbW92C490+0sYyLUMcMFMMNRAg@mail.gmail.com>
	<CA+55aFyM5o39pmFtPOc1VVE5y_SYp1WXtz773cBp3fHrvnzOLQ@mail.gmail.com>
	<CAE9FiQVY6si_3uG6ndbZVOWCY5o8RuXpSLimEo96FVtNC38Dgw@mail.gmail.com>
Date: Thu, 21 Nov 2013 13:42:40 -0800
Message-ID: <CA+55aFyDSK9fOwicxP3=44-R_tDLgBtm93wVFPrquizO3WJuSQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] PCI: Try to allocate mem64 above 4G at first
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 21, 2013 at 1:34 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> Here are suggestion is:
> assume mmio pref: will be use for 64bit pref only, and if the mmio pref
> does not support 64bit, we just ignore it.
> If devices under that bridge need pref, we will just use range from bridge's
> nonpref mmio.

Since we always scan devices behind the bus, why don't we take that
into account? If we find devices with 32-bit mmio, we try to make the
prefetchable one be in the 32-bit range.

> In my test setups, it is always working.
> --- only with Intel network devices and Mellanox Infiniband cards and storage
> cards from Qlogic and Emulex.

Right. And remember how many times your testing did *not* show
problems that others saw?

"Works for me" doesn't work for PCI resource management.

              Linus
