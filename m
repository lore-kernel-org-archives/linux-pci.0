Return-Path: <SRS0=ztgn=7W=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FFCC433DF
	for <linux-pci@archiver.kernel.org>; Tue,  9 Jun 2020 15:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40E1207C3
	for <linux-pci@archiver.kernel.org>; Tue,  9 Jun 2020 15:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="St82luIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgFIPtQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:49:16 -0400
Received: from ts18-13.vcr.istar.ca ([204.191.154.188]:41222 "EHLO
        ale.deltatee.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbgFIPtM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 11:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gzpWaNjDvCeUY2xxp6peZc5kvZV+ww7/pZ37AoN8uNo=; b=St82luIsjVHMwZfLIUADVV6Uep
        s2wvq8UDXGUWSV1Gr1ZXVoWqz6iAt9n+Jx/c/nJQrJ6znmW253uYMBUhZDG/GBUnrtDD0JJ6q8HKa
        oystQW5RPiTAf7TKgdX3PycWWrZfaaPtGRKyd8jLwUk3ZafOY9TvaiKw6DZfl3ugsO6GVHnfi0HsB
        4LbRE4fQMO3TdoHDmlS0A7IAKQe8tVwdfHAhy2HVdScai3Z1jN1IIf5wrmbok9keGvFOM8i+/sGDj
        Rnsr8Ld5otHcos8//30//fyGc9rJF54cYhpiqqsX0EV4hueT9jzPLtjKuRlxHHye8se9ldfLsNn0e
        vVU2uXbg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1jigUr-0005iA-LG; Tue, 09 Jun 2020 09:49:09 -0600
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
 <20200609091440.497-1-piotr.stankiewicz@intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0e0c77e7-b4fb-67f3-5c31-0de6a1ff39f6@deltatee.com>
Date:   Tue, 9 Jun 2020 09:49:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609091440.497-1-piotr.stankiewicz@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, jian-hong@endlessm.com, rdunlap@infradead.org, rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com, linux-pci@vger.kernel.org, bhelgaas@google.com, piotr.stankiewicz@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 01/15] PCI/MSI: Forward MSI-X vector enable error code
 in pci_alloc_irq_vectors_affinity()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-06-09 3:14 a.m., Piotr Stankiewicz wrote:
> When debugging an issue where I was asking the PCI machinery to enable a
> set of MSI-X vectors, without falling back on MSI, I ran across a
> behaviour which seems odd. The pci_alloc_irq_vectors_affinity() will
> always return -ENOSPC on failure, when allocating MSI-X vectors only,
> whereas with MSI fallback it will forward any error returned by
> __pci_enable_msi_range(). This is a confusing behaviour, so have the
> pci_alloc_irq_vectors_affinity() forward the error code from
> __pci_enable_msix_range() when appropriate.
> 
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>

Looks fine to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

> ---
>  drivers/pci/msi.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 6b43a5455c7a..cade9be68b09 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1191,8 +1191,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  				   struct irq_affinity *affd)
>  {
>  	struct irq_affinity msi_default_affd = {0};
> -	int msix_vecs = -ENOSPC;
> -	int msi_vecs = -ENOSPC;
> +	int nvecs = -ENOSPC;
>  
>  	if (flags & PCI_IRQ_AFFINITY) {
>  		if (!affd)
> @@ -1203,17 +1202,16 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  	}
>  
>  	if (flags & PCI_IRQ_MSIX) {
> -		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
> -						    max_vecs, affd, flags);
> -		if (msix_vecs > 0)
> -			return msix_vecs;
> +		nvecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
> +						affd, flags);
> +		if (nvecs > 0)
> +			return nvecs;
>  	}
>  
>  	if (flags & PCI_IRQ_MSI) {
> -		msi_vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs,
> -						  affd);
> -		if (msi_vecs > 0)
> -			return msi_vecs;
> +		nvecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
> +		if (nvecs > 0)
> +			return nvecs;
>  	}
>  
>  	/* use legacy IRQ if allowed */
> @@ -1231,9 +1229,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  		}
>  	}
>  
> -	if (msix_vecs == -ENOSPC)
> -		return -ENOSPC;
> -	return msi_vecs;
> +	return nvecs;
>  }
>  EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
>  
> 
