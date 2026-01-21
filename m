Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAA1428468;
	Wed, 21 Jan 2026 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983855; cv=none; b=BWLi4sonYyO58bI6j3aJdiy2xAm7ExQ75F7K4FxgeEkQk+zdZYdaQSjtT5XXKdeoVbkTD3mylGkEgMmESKSwydxDqkNUQCOTrD7V5PXKyF/T+Im9RJ4Uukadi/Zd58nRjxa85Q0fjc13YypOZU+HEAthtX/lenizYY4cyi1Pyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983855; c=relaxed/simple;
	bh=312ckB6v77HdihpJv55jyXboZbnIRTMv2iAxblU3CPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpGpj7drbrZTPoyiodVB+xrnI5MgnukoGoJMzIdMXOSpX809ZAwrxSETsW7GnjSQmuG00ovciWMh0uYkssMQ48OE/CBWFAN2lBV1NSft+w408/JU/vSRiRgWSXVtM5hUm6J1kRZUi3EYImvlA6dcC6yCZzAzfqulqxVG49TVYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK5Wkl7F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK5Wkl7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF59C19422;
	Wed, 21 Jan 2026 08:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768983854;
	bh=312ckB6v77HdihpJv55jyXboZbnIRTMv2iAxblU3CPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XK5Wkl7FFD2uI/e7bAd7HEOtnpU8AQBVXAbjRBiUlwzaUSuLHZW57U38M82cetEv+
	 8xnGnBNl1Fr3QyhrQWi+FuXXpFqKiurA6RSmxJSqz8fIwHbr0Y5X7F1mMonDDEPg52
	 A+MIkSH2j09ppgk2yx+oVrLyfkauMfe4qXfLG4viXaw1KmSPzVWO3D+UBwqgReVTZB
	 K+OQfjb/EZ6q8cHmqdG/HxSfmRbCLeUN3rTv37HM0OIGmlpNLGWulRFq5w9GKniRFk
	 Uyd9I2/oiTd6+ETO5iG3m8i0UOOcEC2IgpEbB970t/zC/OpOUqbMsIvvIOnzkD/MlH
	 EzaVbY7RQ0Q0Q==
Date: Wed, 21 Jan 2026 09:24:09 +0100
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 5/5] PCI: dwc: Fail dw_pcie_host_init() if
 dw_pcie_wait_for_link() returns -ETIMEDOUT
Message-ID: <aXCNKeebHq-YUUXR@ryzen>
References: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
 <20260120-pci-dwc-suspend-rework-v4-5-2f32d5082549@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-pci-dwc-suspend-rework-v4-5-2f32d5082549@oss.qualcomm.com>

On Tue, Jan 20, 2026 at 11:17:44PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> The dw_pcie_wait_for_link() API now distinguishes link failures more
> precisely:
> 
> -ENODEV: Device not found on the bus.
> -EIO: Device found but inactive.
> -ETIMEDOUT: Link failed to come up.
> 
> Out of these three errors, only -ETIMEDOUT represents a definitive link
> failure since it signals that something is wrong with the link. For the
> other two errors, there is a possibility that the link might come up later.
> So fail dw_pcie_host_init() if -ETIMEDOUT is returned and skip the failure
> otherwise.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
