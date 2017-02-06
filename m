Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:48074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbdBFRak (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2017 12:30:40 -0500
Date: Mon, 6 Feb 2017 09:30:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>,
        Austin Bolen <Austin.Bolen@dell.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCHv5 1/5] pci: Export pci device config accessors
Message-ID: <20170206173033.GA25762@infradead.org>
References: <1486144555-5526-1-git-send-email-keith.busch@intel.com>
 <1486144555-5526-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486144555-5526-2-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 03, 2017 at 12:55:51PM -0500, Keith Busch wrote:
> This patch removes the inline pci device config read and write accessors
> with exported functions. This is preparing for these functions to make
> use of private data.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
