Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34670 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbcLOMef (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2016 07:34:35 -0500
Subject: Re: [PATCH] genirq/affinity: fix node generation from cpumask
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, hch@lst.de,
        linuxppc-dev@lists.ozlabs.org, gabriel@krisman.be
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <d637847f-52c8-1b55-80e2-1b4d4523fa8a@gmail.com>
Date: Thu, 15 Dec 2016 23:34:21 +1100
MIME-Version: 1.0
In-Reply-To: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 15/12/16 05:01, Guilherme G. Piccoli wrote:
> Commit 34c3d9819fda ("genirq/affinity: Provide smarter irq spreading
> infrastructure") introduced a better IRQ spreading mechanism, taking
> account of the available NUMA nodes in the machine.
> 
> Problem is that the algorithm of retrieving the nodemask iterates
> "linearly" based on the number of online nodes - some architectures
> present non-linear node distribution among the nodemask, like PowerPC.
> If this is the case, the algorithm lead to a wrong node count number
> and therefore to a bad/incomplete IRQ affinity distribution.
> 
> For example, this problem were found in a machine with 128 CPUs and two
> nodes, namely nodes 0 and 8 (instead of 0 and 1, if it was linearly
> distributed). This led to a wrong affinity distribution which then led to
> a bad mq allocation for nvme driver.
> 
> Finally, we take the opportunity to fix a comment regarding the affinity
> distribution when we have _more_ nodes than vectors.

Very good catch! 

Acked-by: Balbir Singh <bsingharora@gmail.com>
