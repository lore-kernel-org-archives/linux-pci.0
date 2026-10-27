Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136907;
	b=SiMY/1edsLCjoRtdgcjumH8WvJKEOwCEPzPaN+d5F4a7i0vyNVu3qlBw/foZ+E+hc44m
	 DQsQlo4k3GhtCuxl6SqVRdrsMxSGmPNlXcxxRDuM2OOjwjCYcT4vt4HUtIV2DRzarssXm
	 Fa1d242US1j+L8g/W/RQ/sdTOOA6vdUmlo+zt+5FTQffZ7C7+UfmhSgR9NEkLElksaDVE
	 NnZq1hWlFjULxH9lrBzQInnSQbaZSAH8xx+rsNf1O9tKECfDjBXkSZPJbJyq68HRo5vGt
	 bH+FvM/UrY0azOHoi7gOGGfvB3oy1FeepxTW2ubu2CfeadXdZvvKkiTO3pPqZQkUj/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136907;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/8w/iCK1HPZD38BEPPuHo99rAtBuTlOymGNTilYwAK4=;
	b=BmRBT/9IKlEQArN9JVJVRyXGnPxirHyda45ZdKsCnC63c+5LbYdoUNY2Ys3sNGmQ28MY
	 vSPQtlw2X+hbrBYED/kBkiKNV/WNrcTwxCMETdl9wcl5iU+fW1xdpL/6hebmxB3UjZ6Zx
	 2exf0WgzMiAA0kqqc7X+oGxsu5sCuK6c0oPV7SIz7J+eNlczwLzyTWMLLP8Gx5QzuYqow
	 wHiAwV5VlEiRtSElUpb1k4WyXG30fJNs0YJDrKBS5woCAGi6ULCiX2gQTKzWZrG9H7gj2
	 dX3YQ+P/ykIR2xBdLJfr6k0Ws6c45IgCHgw/lIgx2AZy3n+XaIrY9K1gH9918G/1uQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtzTk72w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4799606A31E
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mtzTk72w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A1F1F01825;
	Tue, 27 Oct 2026 21:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793136906;
	bh=/8w/iCK1HPZD38BEPPuHo99rAtBuTlOymGNTilYwAK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=mtzTk72w48RuPtLPUksTWomRRFeVGxlQ4eUe4f6Ix1SyYFgF0DU8Ij8e+ZNtamIYa
	 gt9Q213s2tvqlQxdSFvz7mqLtpsNVr2Uj55mezKWmJsZzkyLmZyEf4/aYQXEQ7x4+i
	 w8AsniS14IEPOss6xrrcZl33kJKRp9FbEjbAbLGawDwarmNM+L6Pf17cqBn7PJTCOO
	 /vNduuJ29BnC2Z19TtEy4qGVt5DkoPyGHOEW8eOGQoeANVFMUdr5eGngNz748hjlkl
	 cDq+g67DeKLBUcNjHjIoXRoqkeaYl/WMezeYch+O0SYRDuhLJt45YZUMflM0DwoHHQ
	 rT6IdopeS1SSw==
Date: Tue, 27 Oct 2026 16:35:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukasz Laguna <lukasz.laguna@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	michal.winiarski@intel.com, djbw@kernel.org, brett.creeley@amd.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH v2 02/13] PCI/IOV: Introduce VF iterators
Message-ID: <20261027213504.GA456799@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027160446.858300-3-lukasz.laguna@intel.com>

On Tue, Oct 27, 2026 at 05:04:35PM +0100, Lukasz Laguna wrote:
> Introduce helpers to iterate over the enabled VFs of a PF. Add
> pci_get_vf() and pci_get_vf_reverse() to retrieve the next enabled VF
> of a PF in ascending or descending VF ID order, along with
> for_each_pci_vf(), for_each_pci_vf_reverse(), and
> for_each_pci_vf_continue_reverse() built on top of them. The helpers
> return each VF with a reference held, matching existing PCI device
> lookup APIs.
> 
> This provides a common and convenient way to iterate over a PF's enabled
> VFs and avoids duplicating the iteration logic in drivers.
> 
> Assisted-by: LLM
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
> ---
>  drivers/pci/iov.c   | 63 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h | 57 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index eb019201faed..a437370c4e36 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -70,6 +70,69 @@ struct pci_dev *pci_iov_get_virtfn(struct pci_dev *dev, int id)
>  }
>  EXPORT_SYMBOL_GPL(pci_iov_get_virtfn);
>  
> +/**
> + * pci_get_vf() - Return the first or next existing VF of a PF
> + * @dev: PCI PF whose VFs are being iterated
> + * @from: Previous VF returned by this function, or %NULL to return the first VF
> + *
> + * Iterate over existing VFs of @dev in ascending VF ID order, skipping VF IDs
> + * with no device present. If a VF is found, its reference count is incremented.
> + * A new iteration is started by passing %NULL as the @from argument. Otherwise,
> + * iteration continues after @from, and the reference count on @from is
> + * decremented.
> + *
> + * Return: a pointer to the first or next VF, or %NULL if no further VF is found.
> + */
> +struct pci_dev *pci_get_vf(struct pci_dev *dev, struct pci_dev *from)
> +{
> +	int id = 0;
> +
> +	if (from) {
> +		id = pci_iov_vf_id(from) + 1;
> +		pci_dev_put(from);
> +	}
> +
> +	for (; id < pci_num_vf(dev); id++) {
> +		from = pci_iov_get_virtfn(dev, id);
> +		if (from)
> +			return from;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_get_vf);
> +
> +/**
> + * pci_get_vf_reverse() - Return the last or previous existing VF of a PF
> + * @dev: PCI PF whose VFs are being iterated
> + * @from: Previous VF returned by this function, or %NULL to return the last VF
> + *
> + * Same semantics as pci_get_vf(), except iteration proceeds in descending VF
> + * ID order.
> + *
> + * Return: a pointer to the last or previous VF, or %NULL if no further VF is
> + * found.
> + */
> +struct pci_dev *pci_get_vf_reverse(struct pci_dev *dev, struct pci_dev *from)
> +{
> +	int id = pci_num_vf(dev);
> +
> +	if (from) {
> +		id = pci_iov_vf_id(from);
> +		pci_dev_put(from);
> +	}
> +
> +	while (id > 0) {
> +		id--;
> +		from = pci_iov_get_virtfn(dev, id);
> +		if (from)
> +			return from;
> +	}

Seems slightly odd to use different loop control in pci_get_vf() and
pci_get_vf_reverse().  I think I would use "while" in pci_get_vf() to
match, obviously with id++ at the tail.

> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_get_vf_reverse);
