Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753220AbeFGNa1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jun 2018 09:30:27 -0400
From: Andreas Schwab <schwab@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: PCI: Move OF-related PCI functions into PCI core
References: <20180206193546.52AFA21D4F@pdx-korg-gitolite-1.ci.codeaurora.org>
        <mvmlgbrj7tz.fsf@suse.de>
        <CAErSpo6_BTHJgAhFJxQiVFenqns5rP98TRtSguL21h9HdZAxpA@mail.gmail.com>
Date: Thu, 07 Jun 2018 15:30:26 +0200
In-Reply-To: <CAErSpo6_BTHJgAhFJxQiVFenqns5rP98TRtSguL21h9HdZAxpA@mail.gmail.com>
        (Bjorn Helgaas's message of "Thu, 7 Jun 2018 08:25:57 -0500")
Message-ID: <mvm36xyk9l9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Jun 07 2018, Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Thu, Jun 7, 2018 at 3:53 AM Andreas Schwab <schwab@suse.de> wrote:
>>
>> OF_PCI is still referenced by drivers/pci/host/Kconfig.
>
> Do you have a SHA1 for the file you're looking at?

I'm lookig at 4.17.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
