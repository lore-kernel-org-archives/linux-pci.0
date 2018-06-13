Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:53331 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933912AbeFMH2r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2018 03:28:47 -0400
Received: by mail-it0-f49.google.com with SMTP id a195-v6so2503128itd.3
        for <linux-pci@vger.kernel.org>; Wed, 13 Jun 2018 00:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <1528871397-17917-1-git-send-email-kernelfans@gmail.com>
 <1528871397-17917-2-git-send-email-kernelfans@gmail.com> <20180613063710.GA30350@infradead.org>
In-Reply-To: <20180613063710.GA30350@infradead.org>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 13 Jun 2018 15:28:35 +0800
Message-ID: <CAFgQCTt+iWc2qoGyRxEq=f2x0tZQbbweMz_oq3qhuBG5e_GDUA@mail.gmail.com>
Subject: Re: [patchV2 1/2] pci: introduce an extra method for matching in pci_driver
To: hch@infradead.org
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 13, 2018 at 2:37 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> If we successfull call ->probe twice on a device we have a much
> deeper problem than we can fix in the PCI layer or shpchp.
>
OK, see your point.

> Please explain the actual race or other condition that can lead to
> this and report it to the driver core maintainer.
Oh, then it should be. I will add more debug info to narrow down the
problem, and report it to driver core maintainer.

Thanks for your kindly review.

Regards,
Pingfan
