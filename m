Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f179.google.com ([209.85.213.179]:34105 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753493AbeFGN0K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jun 2018 09:26:10 -0400
Received: by mail-yb0-f179.google.com with SMTP id n23-v6so1942846ybg.1
        for <linux-pci@vger.kernel.org>; Thu, 07 Jun 2018 06:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180206193546.52AFA21D4F@pdx-korg-gitolite-1.ci.codeaurora.org> <mvmlgbrj7tz.fsf@suse.de>
In-Reply-To: <mvmlgbrj7tz.fsf@suse.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 7 Jun 2018 08:25:57 -0500
Message-ID: <CAErSpo6_BTHJgAhFJxQiVFenqns5rP98TRtSguL21h9HdZAxpA@mail.gmail.com>
Subject: Re: PCI: Move OF-related PCI functions into PCI core
To: schwab@suse.de
Cc: Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 7, 2018 at 3:53 AM Andreas Schwab <schwab@suse.de> wrote:
>
> OF_PCI is still referenced by drivers/pci/host/Kconfig.

Do you have a SHA1 for the file you're looking at?  In my current
"next" branch (488ad6d3678b), "OF_PCI" is not referenced anywhere in
drivers/pci/:

08:25:21 ~/linux (next)$ git show |cat
commit 488ad6d3678beee65bcd74e6a9764bd7cee9d3d3
Merge: 0ecda3a08746 82e1719c4cd6
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Jun 6 16:10:51 2018 -0500

    Merge branch 'pci/trivial'

      - clean up quirks.c organization and whitespace (Bjorn Helgaas)

    * pci/trivial:
      PCI: Clean up whitespace in quirks.c
      PCI: Reorder quirks infrastructure code

08:25:27 ~/linux (next)$ git grep OF_PCI drivers/pci |cat
08:25:30 ~/linux (next)$
