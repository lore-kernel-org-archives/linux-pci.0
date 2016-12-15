Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758277AbcLOQ5R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Dec 2016 11:57:17 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBFCb9Je113623
        for <linux-pci@vger.kernel.org>; Thu, 15 Dec 2016 07:38:41 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 27bu4d0msn-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Thu, 15 Dec 2016 07:38:41 -0500
Received: from localhost
        by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
        Thu, 15 Dec 2016 10:38:38 -0200
Subject: Re: [PATCH] genirq/affinity: fix node generation from cpumask
To: Thomas Gleixner <tglx@linutronix.de>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20161214232425.GA13182@gwshan> <alpine.DEB.2.20.1612151036340.3470@nanos>
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        gabriel@krisman.be, bsingharora@gmail.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Thu, 15 Dec 2016 10:38:33 -0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1612151036340.3470@nanos>
Content-Type: text/plain; charset=windows-1252
Message-Id: <58528EC9.3060009@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/15/2016 07:36 AM, Thomas Gleixner wrote:
> On Thu, 15 Dec 2016, Gavin Shan wrote:
>>> static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
>>> {
>>> -	int n, nodes;
>>> +	int n, nodes = 0;
>>>
>>> 	/* Calculate the number of nodes in the supplied affinity mask */
>>> -	for (n = 0, nodes = 0; n < num_online_nodes(); n++) {
>>> +	for_each_online_node(n)
>>> 		if (cpumask_intersects(mask, cpumask_of_node(n))) {
>>> 			node_set(n, *nodemsk);
>>> 			nodes++;
>>> 		}
>>> -	}
>>> +
>>
>> It'd better to keep the brackets so that we needn't add them when adding
>> more code into the block next time.
> 
> Removing the brackets is outright wrong. See:
>   https://marc.info/?l=linux-kernel&m=147351236615103
> 
> I'll fix that up when applying the patch.
> 
> Thanks,
> 
> 	tglx
> 

Thanks you all very much for the reviews and comments - lesson learned
about the brackets in multi-line if/for statements!

Thanks for fixing it Thomas.
Cheers,


Guilherme

