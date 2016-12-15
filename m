Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46815 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757508AbcLOIy6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Dec 2016 03:54:58 -0500
Date: Thu, 15 Dec 2016 09:54:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        gabriel@krisman.be, hch@lst.de, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, stable@vger.kernel.org.#.v4.9+
Subject: Re: [PATCH] genirq/affinity: fix node generation from cpumask
Message-ID: <20161215085456.GA2864@lst.de>
References: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(but I agree with the bracing nitpick from Gavin)
