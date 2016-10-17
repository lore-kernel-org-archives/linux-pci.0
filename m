Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:60998 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934415AbcJQUzT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Oct 2016 16:55:19 -0400
Date: Mon, 17 Oct 2016 22:55:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Emmanuel Benisty <benisty.e@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, tj@kernel.org,
        linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: use pci_alloc_irq_vectors issues
Message-ID: <20161017205517.GA27244@lst.de>
References: <20161017080103.GA8732@lst.de> <CA+i8gK+dxqJgAcANzsHecE4dD4tGARuaNka-29nZWdrRUL=+Hw@mail.gmail.com> <20161017092621.GA11124@lst.de> <CA+i8gKK55YWL0SsB0UL89TL1XAgySvFwhmU=c+fTpkGo_s4XTA@mail.gmail.com> <20161017103442.GA12240@lst.de> <CA+i8gKJkhTjBAPbuceToHD3YJuPHkLhs-joso-vuJzuHRF5OLg@mail.gmail.com> <20161017120234.GA14105@lst.de> <CA+i8gK+UfUmKtYpXH1cObd3_5WWje397pgQqW5SmwFg8ms+aLw@mail.gmail.com> <20161017192858.GA25429@lst.de> <CA+i8gKJ6dyxHm-5_=Xdm=HusyxsHVbqTphGzMp1zBTMut=yygQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+i8gKJ6dyxHm-5_=Xdm=HusyxsHVbqTphGzMp1zBTMut=yygQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 17, 2016 at 10:51:44PM +0200, Emmanuel Benisty wrote:
> This patch solved the issue, thanks a lot.

Thanks for testing!

I'll resend it to Tejun with proper indentation and a changelog
tomorrow.
