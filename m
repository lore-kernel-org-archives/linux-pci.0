Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07442360EE8;
	Fri, 17 Jul 2026 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327910; cv=none; b=ZiSCMaDsAM9Npcifuv1/A89oA+xplQMjpF5mREBNKGsN2VHKJvxwjLS+pq2n3DMN84Xk9Y4GODUcW43GSfBchQ+u30DYWB1IwrfTPO0bHqyShDv6J0DOA8tXsT6FqoIE+gaB/IGBZfUUhHluUe1nsp4Ywy8BvEt5pKJ8ULUoVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327910; c=relaxed/simple;
	bh=yq1Czgb6ofwfFEnr0tYwQy/7RJDtT0SVTab5/wZxJKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTRYBsbKCBSyWmLWloLWTOeyscbSx5HCd6eMyrDkbqufcr/zHQtimRuX9oYt6Yvfi81fRxKOuBQml0gBTXoOZkkeHMAzmmfE3PohjeDmkbU4ctxWO9XfbdnshMnzi/eLjs3Ng1uDXRCW6St4+QYgORGS+5+CBIU9eGkyoUuTqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Q6ij4R8I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3p91ygZ; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Q6ij4R8I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3p91ygZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 49F5F1D000D3;
	Fri, 17 Jul 2026 18:38:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 18:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784327905;
	 x=1784414305; bh=lzde1ha+q0b3f53Hnca6aQ3EBESk3P8v7XvgdM60Feg=; b=
	Q6ij4R8I96GjEjcUD1qZKp+MktX/se/U67ruWFXVdRaCcuep0Hzsq0TptKEBdQ1k
	BbaUQZRd3kGFDFShK3JAyN3CAJUZp05WQeRgrsX+oXSmhODXf+gmzFO4k73+T8IT
	tvb++PH3ocHu7i8+drrSM9PqIL3/VN1hpPpn2GK6PX0YZMvjW2PleKtFfCpa9JZe
	ZpNKYcI/9DNAFjMaGR5zfayIPxn4VeEap2uoS7UqtigbgKNKLQEevJ6oDpBn4H7d
	W+91wm1iw1CnWBmsL3K03cMVPEtuErgCy6wNJ3yuTKZqeyBM8v5DZFRajTzN/Rr8
	SVl/ZSWu4nmtD96mnaTE9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784327905; x=
	1784414305; bh=lzde1ha+q0b3f53Hnca6aQ3EBESk3P8v7XvgdM60Feg=; b=k
	3p91ygZHntREhMvwRvvg1Nd6p8Yy82IesJEqGKKmouz8AY0GCqunTdJNaAoK2Izd
	gX27XhdWtrEcbyyF0b5ULRVNOb7NpiEF+HkGuCPh9a+vNP/Sml4kXsVaN6eGL/DZ
	mDYTKzZvsESQnYGnpAkYDcJrenv4en0xKRqT1fLLK9Kq0zSyXztvFMzjviSKEnKn
	f2v+DgameSBhsyR9gRn7L0cDQ4jt4kBnavidzvmYjwPmmXT4kOcEAQ1jLYEQyFkC
	Ps5fKiVy7O4euSm2Cp3A0jsFzlbRLwx2NrHGGRxz3pX5knstd90i/L30mwsPfmrU
	x0f/mfqvnulJfzMswgjzQ==
X-ME-Sender: <xms:4K5aasDFJxf8OJ9HwrQvkbL3nz_k-D9y0ERPa60Chq_o1nrerKIHOw>
    <xme:4K5aauqSodIH1QgfhPde-nISWSQrkHiq0g5aTcSniaa3Loa2yP-GiSAHAkVxM4OmS
    QETNl2eUvDe8v5EXh_tXC3K4bgcN0IkAVlz2poE_In7Ox0V_S7rxf8>
X-ME-Received: <xmr:4K5aatYnWC8LdcmOZrSzhCBQ4J7_G7UsMC1yNED7CRfNG5NR66QFF_xVA3s>
X-ME-Proxy-Cause: dmFkZTGm3qs5+aEcYkfakpq+2uLa99h4ajh2qJDjfxZgK/kLOg+NCtE9Xvz+Bhj3dMCVeG
    Iw9OAvLLQOBef102C9CcWY9KFqr31YULKXWz7tTVH/9L0r3O8EFnXB6mx22NULLeTdT4jR
    7YyhGf/7/zlHCdn9qcNeEbW1dGitA6XPDqWKaKaSLfsRIHa47ZmRAwCu/HK0tLf9EzcH6J
    mrXjVXzFge3aTWOYrJ8BV1WW+FlEXo356jBxCU/ddBc45zydnrQ/OFaKikfgE5MXr2hUSm
    qivErpgstzhVNhWpsbEp/HjC3trwdQqnxIg3F3fBPXme/bWnJbnRbmJ1IoE7xjyGX8ciMn
    NLkqwZEJY9vN1jLTYco6vz9m/oKknXVpe4cimgXmyi71Tz3zw90wQLPatMv0uythQlAFHI
    siDsOq04rZ8KC7P/N5IKixERGDlXwr2nDee2QXJL16P5A97LDoe8ij/WvPHOdgqQErQBp7
    2qh1L4FEcxl0oRjEIbc1cA5156yEJIg6jz/FUFOOeYSqKIqgBCiY/BjgF6d6eJhywXH2Wb
    di7DE9KTauaQKU2jiAMqCMesbMe93WPD0RH+Ko6ZJH9eORiCm5lho/LYAMlGyQv8Vd8D7s
    Dm3+bOx2kd0cxpUZNVlu21VpRgek0q9oT6X6hbADH6goWPsiBbg3eWlEy3qQ
X-ME-Proxy: <xmx:4K5aanB5kD0EYGoIaM4DDZ0vTQFilDsP--MwNer7HMw1YyoSd9BfsQ>
    <xmx:4K5aavcC-HAX6KVYAQS0nIgyIJxU4jrz27bJGCe6jG_NyrEAL-QqFQ>
    <xmx:4K5aas8gfYkzLwYExzLPNBb72kPXQsB3BzGO0uaNxonp5Bj0P9CzEw>
    <xmx:4K5aanEYB5o6L-2-emvdTEbuBXbU4hevweZU1IYJCUEHLrpOQro-0w>
    <xmx:4a5aakPRm9ooV6NOF6i9FVYfpIf8SW4TZedXWnnZEgXY4Zo8wPg2K4hV>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 18:38:22 -0400 (EDT)
Date: Fri, 17 Jul 2026 16:38:20 -0600
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>,
 Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, Jacob
 Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon
 Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike
 Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>,
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Samiullah Khawaja <skhawaja@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, William Tu
 <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, alex@shazbot.org
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <20260717163820.6bc8c13b@shazbot.org>
In-Reply-To: <20260710212616.1351130-4-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
	<20260710212616.1351130-4-dmatlack@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jul 2026 21:26:06 +0000
David Matlack <dmatlack@google.com> wrote:

> @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
>  
> +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
> +{
> +	struct pci_flb_incoming *incoming = NULL;
> +	int ret;
> +
> +	ret = liveupdate_flb_get_incoming(&pci_liveupdate_flb, (void **)&incoming);
> +
> +	/* Live Update is not enabled. */
> +	if (ret == -EOPNOTSUPP)
> +		return NULL;
> +
> +	/* Live Update is enabled, but there is no incoming FLB data. */
> +	if (ret == -ENODATA)
> +		return NULL;
> +
> +	/*
> +	 * Live Update is enabled and there is incoming FLB data, but none of it
> +	 * matches pci_liveupdate_flb.compatible.
> +	 *
> +	 * This could mean that no PCI FLB data was passed by the previous
> +	 * kernel, but it could also mean the previous kernel used a different
> +	 * compatibility string (i.e. a different ABI).
> +	 */
> +	if (ret == -ENOENT) {
> +		pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
> +	 * but it cannot be retrieved.
> +	 */
> +	if (ret)
> +		panic("Failed to retrieve incoming FLB data (%d)\n", ret);
> +
> +	return incoming;
> +}

I'm having trouble following the error escalation here.  What's
fundamentally the difference between FLB data being provided and not
compatible (subtle log message) versus FLB data being provided and
compatible but we cannot access it (panic!)?

Don't both suggest devices are running but we can't get their FLB data
to continue letting them run?

The errno interpretation is also slightly different than the comment
above liveupdate_flb_get_incoming():

 * Return: 0 on success, or a negative errno on failure. -ENODATA means no
 * incoming FLB data, -ENOENT means specific flb not found in the incoming
 * data, -ENODEV if the FLB's module is unloading, and -EOPNOTSUPP when
 * live update is disabled or not configured.

Thanks,
Alex
