Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:46750 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755158AbcLOJji (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2016 04:39:38 -0500
Date: Thu, 15 Dec 2016 10:36:52 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
cc: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linuxppc-dev@lists.ozlabs.org,
        gabriel@krisman.be
Subject: Re: [PATCH] genirq/affinity: fix node generation from cpumask
In-Reply-To: <20161214232425.GA13182@gwshan>
Message-ID: <alpine.DEB.2.20.1612151036340.3470@nanos>
References: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com> <20161214232425.GA13182@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 15 Dec 2016, Gavin Shan wrote:
> > static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
> > {
> >-	int n, nodes;
> >+	int n, nodes = 0;
> >
> > 	/* Calculate the number of nodes in the supplied affinity mask */
> >-	for (n = 0, nodes = 0; n < num_online_nodes(); n++) {
> >+	for_each_online_node(n)
> > 		if (cpumask_intersects(mask, cpumask_of_node(n))) {
> > 			node_set(n, *nodemsk);
> > 			nodes++;
> > 		}
> >-	}
> >+
> 
> It'd better to keep the brackets so that we needn't add them when adding
> more code into the block next time.

Removing the brackets is outright wrong. See:
  https://marc.info/?l=linux-kernel&m=147351236615103

I'll fix that up when applying the patch.

Thanks,

	tglx

