Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:52672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeC3JFM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Mar 2018 05:05:12 -0400
Date: Fri, 30 Mar 2018 11:05:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nipun Gupta <nipun.gupta@nxp.com>, robin.murphy@arm.com,
        linux@armlinux.org.uk, m.szyprowski@samsung.com,
        bhelgaas@google.com, dmitry.torokhov@gmail.com,
        rafael.j.wysocki@intel.com, jarkko.sakkinen@linux.intel.com,
        linus.walleij@linaro.org, johan@kernel.org, msuchanek@suse.de,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: move dma configuration to bus infrastructure
Message-ID: <20180330090504.GA13125@kroah.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
 <20180330071530.GA17557@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180330071530.GA17557@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 30, 2018 at 09:15:30AM +0200, Christoph Hellwig wrote:
> Can you resend the current state of affairs so we can get it in for
> 4.17?

Changes to the driver core and 3 different busses 2 days before 4.16 is
out, preventing any testing at all in linux-next?  This needs to wait
for the next merge window, sorry.  I'm away all this weekend, and can't
test on my end, sorry.

greg k-h
