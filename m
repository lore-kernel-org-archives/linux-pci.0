Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33661 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755427Ab2FDBNL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 3 Jun 2012 21:13:11 -0400
Received: by lahd3 with SMTP id d3so2628905lah.19
        for <linux-pci@vger.kernel.org>; Sun, 03 Jun 2012 18:13:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
References: <1338749305-22558-1-git-send-email-sebastian@breakpoint.cc>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 3 Jun 2012 18:12:50 -0700
Message-ID: <CAErSpo6ybFiBDx6M69HqyPDkU6VQGRe=1yOhH4He5XRje5GBnw@mail.gmail.com>
Subject: Re: Annotate PCI fixups with __devinit instead of __init
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linux-pci@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Michal Marek <mmarek@suse.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jun 3, 2012 at 11:48 AM, Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:
> This patch series adds a section missmatch check to modpost which will
> splat a warning if a PCI fixup routine (declared via
> DECLARE_PCI_FIXUP_HEADER for instance) is defined in __init. Even if the
> platform does not support hot-plug, one could remove the PCI bus during
> run time (soft remove, now HW touching involved) and rediscover it again.
> The rediscover process will call the PCI-fixups again.
> This is patch #1. After posting it Bjorn ask for fixing the noisy warnings
> and this is done by patch #2 to #9.

These all look good to me.

There's not a real dependency between #1 and the rest of them, so I
propose that I feed #2-9 through the PCI tree and whoever normally
handles modpost can take #1.

Bjorn
