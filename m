Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:60859 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933632AbdGTIHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2017 04:07:44 -0400
Date: Thu, 20 Jul 2017 01:07:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] pci: add missing __iomem cast
Message-ID: <20170720080742.GA22116@infradead.org>
References: <20170719120535.26350-1-palminha@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170719120535.26350-1-palminha@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 19, 2017 at 01:05:35PM +0100, Carlos Palminha wrote:
> Add missing __iomem annotation to fix sparse warning:
> - incorrect type in return expression (different address spaces)

How is this going to shut up sparse without a __force?

And once you add the __force please also add a comment explaining
why it's safe.
