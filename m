Return-Path: <SRS0=ToWj=PL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2E9C43387
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 21:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D062184B
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jan 2019 21:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546551549;
	bh=XB3D7JmmdHHKdNaRkVEDXfxvlbjdnpXfWW3San1bNNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1SV6yVCTF7bNe++O9slN53SIvWFFO3f7DbLz7HFd6IEcXCwTzJ/rellriUD0BDAPA
	 KwSE4F3OOz8pLRobnS4ke7m+HBei2yl0xUO0kc4OCryTi3m3V6/o0u19kSQEnyUha8
	 7Mu+Xw30RCIrJhMh3mHpW9nClK7N1OqV8MuZtTIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfACVjI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jan 2019 16:39:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfACVjI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jan 2019 16:39:08 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24F28217F5;
        Thu,  3 Jan 2019 21:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546551547;
        bh=XB3D7JmmdHHKdNaRkVEDXfxvlbjdnpXfWW3San1bNNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4B2CbgmLNVP62twynZ3DsHk3rfavinIFDFlIO0fpcVQlfJs97FJ4s54yhdYJK3Dz
         AHqQLopGk3VJsDRpqYtqGtTZ0v35bGhFXZqjADPZRP7R0A7oHgSa06XgZvTrlXSb6E
         56qaKLrmKLxP3q2I/AsoJlNWGGcVK32dMQCEYPZw=
Date:   Thu, 3 Jan 2019 15:39:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/4] pci/irq: Handle vector reduce and retry
Message-ID: <20190103213900.GB168876@google.com>
References: <20190103210954.11129-1-keith.busch@intel.com>
 <20190103210954.11129-3-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103210954.11129-3-keith.busch@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Keith,

Thanks a lot for jumping on this.

I know I'm a broken record.  Please run "git log --oneline
drivers/pci/msi.c" and make your subject match.

On Thu, Jan 03, 2019 at 02:09:53PM -0700, Keith Busch wrote:
> Adding the nr_sets forced the driver to handle reducing the vector count
> on allocation failures because the set distributino counts are driver
> specific. The change to this API is very different to use than before,
> and introduced new error corner cases that weren't being handled. It
> is also less efficient since the driver doesn't actually know what a
> proper vector count it should use since it only sees the error code and
> can only reduce by one instead of going straight to a possible vector
> count like PCI is able to do.
> 
> Provide a driver specific callback for managed irq set creation so that
> PCI can take a min and max vectors as before to handle the reduce and
> retry logic.

s/distributino/distribution/
s/irq/IRQ/

Can you also add some explanation to Documentation/PCI/MSI-HOWTO.txt
about the concept of "sets" and how to use
nr_sets/sets/recalc_sets/priv?

> Signed-off-by: Keith Busch <keith.busch@intel.com>
> ---
>  drivers/pci/msi.c         | 20 ++++++--------------
>  include/linux/interrupt.h |  4 ++++
>  2 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 7a1c8a09efa5..b93ac49be18d 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1035,13 +1035,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> -	/*
> -	 * If the caller is passing in sets, we can't support a range of
> -	 * vectors. The caller needs to handle that.
> -	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> -		return -EINVAL;
> -
>  	if (WARN_ON_ONCE(dev->msi_enabled))
>  		return -EINVAL;
>  
> @@ -1061,6 +1054,9 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  				return -ENOSPC;
>  		}
>  
> +		if (nvec != maxvec && affd && affd->recalc_sets)
> +			affd->recalc_sets((struct irq_affinity *)affd, nvec);
> +
>  		rc = msi_capability_init(dev, nvec, affd);
>  		if (rc == 0)
>  			return nvec;
> @@ -1093,13 +1089,6 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> -	/*
> -	 * If the caller is passing in sets, we can't support a range of
> -	 * supported vectors. The caller needs to handle that.
> -	 */
> -	if (affd && affd->nr_sets && minvec != maxvec)
> -		return -EINVAL;
> -
>  	if (WARN_ON_ONCE(dev->msix_enabled))
>  		return -EINVAL;
>  
> @@ -1110,6 +1099,9 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  				return -ENOSPC;
>  		}
>  
> +		if (nvec != maxvec && affd && affd->recalc_sets)
> +			affd->recalc_sets((struct irq_affinity *)affd, nvec);
> +
>  		rc = __pci_enable_msix(dev, entries, nvec, affd);
>  		if (rc == 0)
>  			return nvec;
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index c672f34235e7..326c9bd05f62 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -249,12 +249,16 @@ struct irq_affinity_notify {
>   *			the MSI(-X) vector space
>   * @nr_sets:		Length of passed in *sets array
>   * @sets:		Number of affinitized sets
> + * @recalc_sets:	Recalculate sets original requested allocation failed

This sentence is missing something and doesn't parse quite right.
"if"?  Is "original" superfluous?

> + * @priv:		Driver private data
>   */
>  struct irq_affinity {
>  	int	pre_vectors;
>  	int	post_vectors;
>  	int	nr_sets;
>  	int	*sets;
> +	void	(*recalc_sets)(struct irq_affinity *, unsigned int);
> +	void	*priv;
>  };
>  
>  /**
> -- 
> 2.14.4
> 
