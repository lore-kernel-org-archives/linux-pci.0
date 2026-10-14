Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34FA38B122;
	Wed, 14 Oct 2026 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015105; cv=none; b=tKwDijjyBahCVud0SP2kKNGnXaNG7SL3N5u0Y4JheeW3UpmhDp8FLqeGHBJddQfG36KzDV+AVUgGuZ7C9xSYhqldKC8Lvie1CrQE55WUb6e46QJYZJ0hUoL3PCsZelpYejoCyOdFlWU8cOWYUMA6CuYSB1uXrfMEjXzAFOTc8oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015105; c=relaxed/simple;
	bh=brkQDJQNNlxAy/6blY96IdbiPifLKNqDcW8gnFUQaDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p2SsNcXBqWXjNJhB5vcP0bh1rXODmEAsHBUK6wOOIZlLynxnnjl/elktLxWiOfJSXeMR5trnNU6B7LD++3k4LfnCnvTQetsf+MpI5rHgEiSR/DMh2XUZLLnrZ4AiSIG/w446Y2AJqjfnIivswgn+07ojDmF8l/ksbgS5PVK1Yl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwG6lK1l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwG6lK1l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44DF1F000C4;
	Wed, 14 Oct 2026 21:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792015104;
	bh=JFNoFpngqoFf9NYyppuLv/yxto7jom22R1QvJtAwSYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gwG6lK1l3w4+r6otOEIhBoeVI/BR1VAS43XaS1Y340hNar+VaxyVThvttryMf8o0e
	 OoU3M7ZhcTV5rZsATNpc4PeBPfNIlr7x3TSzYAfvDWtZ71mkvwxuRneMiR55CytZ9+
	 EeV5bV+r9T0QU1Ubvvo5kqoNefTcfF+sJsY1b2hr31YNnQuIsyqDDRcT5M7IdEjN2q
	 URVFhP+zQDlL4ma9zqoJeNFo6j5VQ8FKF9WO011gMBoo4LoMGt7iP0TP96g2H6zp7t
	 K8JTH9El3wYTlNRkd5o81zobuJEYq8bXOWQbQahiMWOaQ1Lq4bwK38+3khnrQadg/P
	 AgTIpjUjBnEIA==
From: Thomas Gleixner <tglx@kernel.org>
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa
 Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, Daniel
 Mentz <danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Radu Rendec <radu@rendec.net>, Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, rafael@kernel.org, Danilo Krummrich
 <dakr@kernel.org>, driver-core@lists.linux.dev, Pranjal Shrivastava
 <praan@google.com>, sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/16] genirq/msi: Provide
 msi_device_domain_restore_msi_msgs()
In-Reply-To: <20260929034510.2023173-9-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-9-praan@google.com>
Date: Wed, 14 Oct 2026 23:58:21 +0200
Message-ID: <8733u8eygy.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 29 2026 at 03:45, Pranjal Shrivastava wrote:
> +void msi_device_domain_restore_msi_msgs(struct device *dev, unsigned int domid)
> +{
> +	if (!dev->msi.data)
> +		return;
> +
> +	guard(msi_descs_lock)(dev);
> +	struct irq_domain *domain = msi_get_device_domain(dev, domid);
> +
> +	if (!domain || !irq_domain_is_msi_device(domain))
> +		return;
> +
> +	struct xarray *xa = &dev->msi.data->__domains[domid].store;
> +	struct msi_domain_info *info = domain->host_data;
> +	struct msi_desc *msi_desc;
> +	unsigned long idx;
> +
> +	xa_for_each_range(xa, idx, msi_desc, 0, info->hwsize - 1) {
> +		/* Only handle MSI entries which have an interrupt associated */
> +		if (!msi_desc_match(msi_desc, MSI_DESC_ASSOCIATED))
> +			continue;
> +
> +		scoped_irqdesc_get_and_buslock(msi_desc->irq, 0) {
> +			struct irq_data *data = irq_desc_get_irq_data(scoped_irqdesc);
> +			struct msi_msg msg = msi_desc->msg;
> +
> +			if (data->chip)
> +				irq_chip_write_msi_msg(data, &msg);
> +		}
> +	}

In this case sashiko is wrong:

> [Severity: Critical]
> Will this result in a NULL pointer dereference in hierarchical IRQ domains?
> 
> Since irq_desc_get_irq_data() retrieves the top-level irq_data, data->chip
> points to the top-level irq_chip. In hierarchical IRQ domains, the top-level
> irq_chip typically does not implement the irq_write_msi_msg callback.
> 
> When this top-level irq_data is passed to irq_chip_write_msi_msg(), it will
> dereference a NULL function pointer:

All MSI top level (device) domains implement the irq_write_msi_msg()
callback. That's the whole point of the top level MSI domain as that's
the one which has access to the device and the associated message store.

Thanks,

        tglx
