Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:64708 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814AbaKSSwx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Nov 2014 13:52:53 -0500
Received: by mail-qg0-f50.google.com with SMTP id e89so922219qgf.9
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2014 10:52:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CA+r1ZhgMQF4pxwFTRyLQxQJVVzXp17AO0p7FQrfZwoFPWA+FNg@mail.gmail.com>
References: <CA+r1ZhgMQF4pxwFTRyLQxQJVVzXp17AO0p7FQrfZwoFPWA+FNg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 19 Nov 2014 11:52:32 -0700
Message-ID: <CAErSpo79Ob-Jx=5Mmn2oJO5kmVhwGhrrpjuMDz9kxQD09CUFQw@mail.gmail.com>
Subject: Re: randconfig warnings with next-20141119, in drivers/pci/probe.c
To: Jim Davis <jim.epost@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 19, 2014 at 11:32 AM, Jim Davis <jim.epost@gmail.com> wrote:
> Hej! Builds with CONFIG_X86_32=y are getting these warning messages
>
> drivers/pci/probe.c:430:5: warning: left shift count >= width of type
> [enabled by default]
> drivers/pci/probe.c:431:5: warning: left shift count >= width of type
> [enabled by default]
>
> which would seem to refer to
>
>                                base |= ((dma_addr_t) mem_base_hi) << 32;
>                                 limit |= ((dma_addr_t) mem_limit_hi) << 32;

Hi Jim,

Thanks for the note.  This is a known issue and I have a couple
patches for it, so I hope to get it resolved today.

Bjorn
