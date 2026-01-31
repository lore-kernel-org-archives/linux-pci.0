Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E552D2491;
	Sat, 31 Jan 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769878245; cv=none; b=KFpELc1LTdZ0hSDQrjtrmFGLS9la6uKBz/ksyeyP8FSClLjf3va/eYqgRMj03reBJoZlH8EJ569gMqtoMKi1SBWi2Bl2JgzFu6+2VH/UCUzU45MGpCQrrMjpFZdF1ZBjLAQTUvPCx6HOsU7kMEukW3PCm1m5a0dNSwOYSzV6V7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769878245; c=relaxed/simple;
	bh=Pq75lfbTLCURF9snDbnVcSpQd+vL1pkGds2uMZrgcgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEZ6GDfq0Mb4dmcLFSsIXbYtyqIa4IaIh1NaOXBO5pZVS4GjXN8lT1EV9YTjRu+s+Vkyg7D3tXUbibEtL6esr+vSo0eXRPqpthZCc04Pe32e8BoPPwRWeLhiTZBvS83MBzlh0kH/m2QiVTKb5pVHosqJ5sIkmVw/OBVFS0c5i1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXYW1ZHo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXYW1ZHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A989C4CEF1;
	Sat, 31 Jan 2026 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769878244;
	bh=Pq75lfbTLCURF9snDbnVcSpQd+vL1pkGds2uMZrgcgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXYW1ZHoRNDwxLNTidSM6lrXJP5MyWY/UQj1kc6p8EG/2CsO2zfdDUVGcCCGlVgBq
	 0k3MIPRAvf/eC3ygexyfuec7n1SccatsV/58U4sijLFtLkS/qosZN0Xmwaxv6o9n4N
	 4/uUIvygCOUA1YSMsxLany79uk0Uy/GDaucqMbfIbP8nnauS1Y14ILYY6BGArirwHA
	 OcB6cI2vZUsQZOKEkoTi9tF2+R65+ycbtmoRnvNQH4hK5GZhWAXZihMFImbf3XbO9K
	 CW9lMtamW73BKN8WkQZ6vjFsccpgriWsbxzeIf7UOfERHMV2WiCm3lqg07wQZTbM1h
	 /eNrtUvCaqG2A==
Date: Sat, 31 Jan 2026 17:50:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com,
	lpieralisi@kernel.org, robh@kernel.org, Frank.Li@nxp.com,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: endpoint: Document pci_epc_set_bar() caller
 ownership and lifetime rules
Message-ID: <aX4y3txKcYmb-kE3@fedora>
References: <20260131133655.218018-1-den@valinux.co.jp>
 <20260131133655.218018-4-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131133655.218018-4-den@valinux.co.jp>

On Sat, Jan 31, 2026 at 10:36:55PM +0900, Koichiro Den wrote:
> pci_epc_set_bar() may be called multiple times for a BAR when an
> endpoint controller supports dynamic_inbound_mapping and/or
> subrange_mapping.
> 
> Some EPC drivers keep a reference to the struct pci_epf_bar passed to
> pci_epc_set_bar(), but the documentation does not describe the ownership
> and lifetime rules for that object (and its submap array).
> 
> Document that the EPF driver retains ownership of these objects, must
> keep them valid, and must not modify them after a successful
> pci_epc_set_bar(). When updating an active mapping, the EPF driver must
> pass a new pci_epf_bar instance and only free the old one after the
> update succeeds.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst | 22 +++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 4697377adeae..b2f5ad147ed8 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -119,6 +119,28 @@ by the PCI endpoint function driver.
>     BAR register or BAR decode on the endpoint while the host still expects
>     the assigned BAR address to remain valid.
>  
> +   The struct pci_epf_bar passed to pci_epc_set_bar() (and the optional
> +   pci_epf_bar.submap array) is owned by the PCI endpoint function driver.
> +   An EPC driver may keep a reference to these objects after
> +   pci_epc_set_bar() returns. Therefore the EPF driver must ensure that:
> +
> +     * Ownership of the pci_epf_bar object passed to pci_epc_set_bar()
> +       remains with the caller (the EPF driver). The caller is responsible
> +       for ensuring it remains valid (and freeing it when dynamically
> +       allocated).
> +
> +     * After pci_epc_set_bar() succeeds, the caller must not modify the
> +       contents of the pci_epf_bar object (or its submap array) until a
> +       later successful pci_epc_set_bar() for the same BAR replaces it, or
> +       until pci_epc_clear_bar() succeeds. Otherwise, it could potentially
> +       lead to use-after-free or undefined behavior.
> +
> +     * If the caller needs to update the mapping for a BAR and calls
> +       pci_epc_set_bar() again, it should use a new pci_epf_bar instance
> +       (and a new submap array, if used). If the call succeeds, the old

Why does it need a new submap array?

Since an EPC driver never frees the pci_epf_bar instance, nor never frees
the submap array, an EPF driver could reuse the submap in two consecutive
set_bar() if it so wanted, even though it would be a bit silly.

I guess my point is that the important thing is that the pci_epf_bar and
the submap is immutable / pointer to const from EPC's point of view.

Since the EPC will not change the pci_epf_bar, EPF driver could also
theoretically call set_bar() twice with the exact same pci_epf_bar,
even though that would be a bit silly.


IMO, we could totally avoid all this text if we just changed;
int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
                    struct pci_epf_bar *epf_bar);

to:
int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
                    const struct pci_epf_bar * const epf_bar);


i.e.  const pointer to something const, because set_bar() will not change
the pointer, and what is being passed should not change.


Note that I'm not asking you to do this change in all the drivers,
I'm just saying that if the API was actually defined like this,
we would not need to add any Documentation, because the code would
speak for itself.


I think this patch is good, if we just rephrase it slightly.
(An EPF driver can send in the same struct bar twice, it just can't
modify the current struct bar while it is "in use".)
We can probably write this in two paragraphs instead of three.


Kind regards,
Niklas
