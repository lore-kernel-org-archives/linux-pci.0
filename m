Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B70CC43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06933218A3
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 17:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfC2Ru0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:50:26 -0400
Received: from ale.deltatee.com ([207.54.116.67]:49678 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbfC2Ru0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 13:50:26 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1h9ve4-0000x0-Cd; Fri, 29 Mar 2019 11:50:25 -0600
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
References: <155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155387327020.2443841.6446837127378298192.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cfda881b-d99c-7c53-64cb-745ff4b257b0@deltatee.com>
Date:   Fri, 29 Mar 2019 11:50:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <155387327020.2443841.6446837127378298192.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, bhelgaas@google.com, akpm@linux-foundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 5/6] pci/p2pdma: Track pgmap references per resource, not
 globally
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Dan, this is great. I think the changes in this series are
cleaner and more understandable than the patch set I had sent earlier.

However, I found a couple minor issues with this patch:

On 2019-03-29 9:27 a.m., Dan Williams wrote:
>  static void pci_p2pdma_release(void *data)
>  {
>  	struct pci_dev *pdev = data;
> @@ -103,12 +110,12 @@ static void pci_p2pdma_release(void *data)
>  	if (!pdev->p2pdma)
>  		return;
>  
> -	wait_for_completion(&pdev->p2pdma->devmap_ref_done);
> -	percpu_ref_exit(&pdev->p2pdma->devmap_ref);
> +	/* Flush and disable pci_alloc_p2p_mem() */
> +	pdev->p2pdma = NULL;
> +	synchronize_rcu();
>  
>  	gen_pool_destroy(pdev->p2pdma->pool);

I missed this on my initial review, but it became obvious when I tried
to test the series: this is a NULL dereference seeing pdev->p2pdma was
set to NULL a few lines up.

When I fix this by storing p2pdma in a local variable, the patch set
works and never seems to crash when I hot remove p2pdma memory.

>  void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
>  {
> -	void *ret;
> +	void *ret = NULL;
> +	struct percpu_ref *ref;
>  
> +	rcu_read_lock();
>  	if (unlikely(!pdev->p2pdma))
> -		return NULL;

Using RCU here makes sense to me, however I expect we should be using
the proper rcu_assign_pointer(), rcu_dereference() and __rcu tag with
pdev->p2pdma. If only to better document what's being protected with the
new RCU calls.

Logan
