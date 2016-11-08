Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41869 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbcKHO4y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Nov 2016 09:56:54 -0500
Date: Tue, 8 Nov 2016 15:56:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [RFC PATCH] pci: add pci_irq_get_affinity_vector()
Message-ID: <20161108145652.GA12817@lst.de>
References: <1478591241-123356-1-git-send-email-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478591241-123356-1-git-send-email-hare@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 08, 2016 at 08:47:21AM +0100, Hannes Reinecke wrote:
> Add a reverse-mapping function to return the interrupt vector for
> any CPU if interrupt affinity is enabled.

What's the use case of it?

Also as-is this won't work due to the non-affinity vectors that
have the affinity set to all cpus.  It will get even worse if we have
to support things like virtio_net that have multiple interrupts per
CPU due to the send and receive virtqueues.
