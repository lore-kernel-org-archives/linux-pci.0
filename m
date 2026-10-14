Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD841DDF2;
	Wed, 14 Oct 2026 21:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014766; cv=none; b=RFrSznH69aa3kAc9jGuK8zaCrb6p2vckkkSIbh1Hxbir9EjHHO5G1cLIcPq3HaOYVgmZRU8yh+ghDFsVi516XGk+eOKbVd7cWSV5lbqE6ufFjGVCenVdqn8tHavezN1CSDz+kI+pvLlfQWz1j0cv4tx7+SUed4IA5vSZp2eM5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014766; c=relaxed/simple;
	bh=pcGZG/1An6tLaK/s5q0+DEOIAUX3Avip0BY70/K6EkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hnu/Odv/2wbA1pqM8T6bkal5wGrgIIpFZUyrCokrMueNUERhuY50GxqZlWBc8VV+y3746K5lUI2Ljpa7bFDHky9zHOJH3cFmS8Id/QlCdi46TVjosrYUiKGuK9BJ7yrLZoNnDwnjC0LdvU0VdX31K+50pOd0HbChC/HCYnMhPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luFKnl6n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luFKnl6n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888AC1F000C4;
	Wed, 14 Oct 2026 21:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792014765;
	bh=D+IaSM9kT05pfBEWp0Id2Mry8ziv93Bwpy/RvFGwxDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=luFKnl6nDaTRwLuUvwfPn1yXToQ2S1HPsjTzNUym0qJ8e7SyIg0KvlS7arhuRzpcy
	 4PkPpRlwf7D6QFnrWtwK5EzrYITdsqCmxWlo9Q+ebxhM8EnqkgnHWQw4ScGKloCiu7
	 Fgc4P0Hv9gWPN348FWMNlfdx0gXntEZPzXl3HL0DBLf8pZeLN5avrDd2gJawMMgvRR
	 gYTbwxoOiYBLLhDsEgnfcoerq+xFhZ3jE8lrgn956m+2dhQA/ghNl6VNgj/xMR43Sw
	 gyXbFe1TLs3xdr+rRcVimZDKubhrru8kRO9aXspUB+z7OGi8O/RCE+opLw9XqyhE8O
	 BxLIt38LXIC+A==
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
Subject: Re: [PATCH v11 07/16] genirq/msi: Cache MSI message in
 irq_chip_write_msi_msg()
In-Reply-To: <20260929034510.2023173-8-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-8-praan@google.com>
Date: Wed, 14 Oct 2026 23:52:41 +0200
Message-ID: <875wz4eyqe.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 29 2026 at 03:45, Pranjal Shrivastava wrote:
> Currently, PCI MSI caches the composed MSI message into the MSI
> descriptor inside __pci_write_msi_msg(), whereas platform MSI and other
> device MSI domains do not cache the message in the core, forcing
> individual drivers to manually copy the message into desc->msg if they
> need to restore it across power transitions.
>
> Cache desc->msg in irq_chip_write_msi_msg() before invoking the chip
> callback so all hierarchical MSI domains automatically record the
> latest message. Document why the redundant assignment in
> __pci_write_msi_msg() must remain for direct callers outside the
> irq_chip hierarchy.
>
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/pci/msi/msi.c | 6 ++++++
>  kernel/irq/msi.c      | 9 +++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 80a9db417dc8..f7bedc31d486 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -257,6 +257,12 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  		pci_write_msg_msi(dev, entry, msg);
>  	}
>  
> +	/*
> +	 * Although irq_chip_write_msi_msg() already caches the message,
> +	 * keep the assignment here for callers that invoke
> +	 * __pci_write_msi_msg() or pci_write_msi_msg() directly outside
> +	 * the irq_chip hierarchy.
> +	 */
>  	entry->msg = *msg;
>  
>  	if (entry->write_msi_msg)
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index fb5f372215bf..df460a574d80 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -634,6 +634,15 @@ static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid
>  static inline void irq_chip_write_msi_msg(struct irq_data *data,
>  					  struct msi_msg *msg)
>  {
> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> +
> +	/*
> +	 * PCI Multi-MSI shares a single descriptor across all vectors and
> +	 * the device stores only the base message. Cache the message of the
> +	 * first interrupt only, so that sub-vectors cannot overwrite it.
> +	 */
> +	if (desc->irq == data->irq)
> +		desc->msg = *msg;
>  	data->chip->irq_write_msi_msg(data, msg);
>  }

Sashiko reported correctly:

> [Severity: Critical]
> Does this code cause a NULL pointer dereference for domains without an
> msi_desc object?

So this needs to be:

	if (desc && desc->irq == data->irq)
		desc->msg = *msg;

Did not think about that, but that also means that this patch was not
tested on any recent (less than 10 years old) Intel x86 platform or a
x86 VM exposing HPET...

Thanks,

        tglx

