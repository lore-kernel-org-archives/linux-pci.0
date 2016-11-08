Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46397 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751991AbcKHIQd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Nov 2016 03:16:33 -0500
Subject: Re: [PATCH 4/7] pci/msi: Propagate irq affinity description through
 the MSI code
To: Christoph Hellwig <hch@lst.de>, tglx@linutronix.de
References: <1478544462-9549-1-git-send-email-hch@lst.de>
 <1478544462-9549-5-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1b443c8b-1028-a776-e613-2e51218ff3d4@suse.de>
Date: Tue, 8 Nov 2016 09:16:31 +0100
MIME-Version: 1.0
In-Reply-To: <1478544462-9549-5-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/07/2016 07:47 PM, Christoph Hellwig wrote:
> From: Christogh Hellwig <hch@lst.de>
>
> No API change yet, just pass it down all the way from
> pci_alloc_irq_vectors to the core MSI code.
>
> Signed-off-by: Christogh Hellwig <hch@lst.de>
> ---
>  drivers/pci/msi.c | 62 +++++++++++++++++++++++++++++--------------------------
>  1 file changed, 33 insertions(+), 29 deletions(-)
>
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
