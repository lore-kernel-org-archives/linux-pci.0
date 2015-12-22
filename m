Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35731 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbbLVIa0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Dec 2015 03:30:26 -0500
MIME-Version: 1.0
In-Reply-To: <1450745949-23882-2-git-send-email-paul.gortmaker@windriver.com>
References: <1450745949-23882-1-git-send-email-paul.gortmaker@windriver.com>
	<1450745949-23882-2-git-send-email-paul.gortmaker@windriver.com>
Date: Tue, 22 Dec 2015 09:30:25 +0100
Message-ID: <CAMuHMdX-ek6eG9kXt1R4vVHUqe2ggpMCxQ33H512VQ66hRKrAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers/pci: make host/pcie-rcar.c explicitly non-modular
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Paul,

On Tue, Dec 22, 2015 at 1:59 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.

The MODULE_* tags are easier to parse by automated tools.
Do we want to make the work of e.g. the SPDX people harder?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
