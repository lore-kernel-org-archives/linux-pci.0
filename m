Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22C3054C7;
	Thu, 30 Jul 2026 05:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387994; cv=none; b=fIXroWKfbS9da8hKYmLC7P03wgn79x5yQg9mKCOp0l0VMJVFmXPiX01yU6Z6bgno4OgKrKOZBBvOexiyZKf5s7F0mBF1epa6V7R4xe9IdDFj5/crCJY7+/bIrRODYQkU1LT0wxXKvyIH0kg2oH0wCifdreY2RvlW7KlkxuwEGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387994; c=relaxed/simple;
	bh=bSjt+WHOPIYUXBekr59bHehz4iqfAqWogYbceBdBI34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCWaUPpc/S23HciRQcp4UqYLIO2XtFczmDji6PVG90WN8heTSGbrWsJy4YUqAtgk2n3/Q6AyD4z49jp8u8EhrjPOIZh61iYdn58vTLnV2RLjcq1KRbpBXmRZdFEk+3MD08CdwyUColiAeAi61+EcOaOMzoZ2aHHyoLonkh/k4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITfcGu/x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITfcGu/x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CD51F000E9;
	Thu, 30 Jul 2026 05:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785387993;
	bh=u0/HVpY2ufml7of1EeLDSZn/mFXKxLrn6XGAASTUj5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ITfcGu/x84aLAwRJyuAPFXw94RpiwYGlCwt0B0Y43aZ089kWZfQAqdAdDFQnx0GAi
	 qOogqASzU5fvLq3G6pJtWwZEhrIUuUUneNB54iYHzLLHTVCLPb9R60rRGOtuKnx3zF
	 +7ypBTFlDtK6zo8ufPARTVn0IrUmheIVVt1L/S4WHlv9bn9HFlryyTIt7PO/hmE4rr
	 UQ4iXgTKYbaGHELXqMPVu2s4PRRIb5sq4FWsXAu++VdB9BCGfwv4rq/qtedZfYeDW2
	 mqG/Y6L2abQgECORqFcVFmpAJaNPRHW7X29RdTZEfskh39qkUfVG6OpxgwzSQ5Iq+Y
	 KUqTV/fe3DKyQ==
Date: Thu, 30 Jul 2026 07:06:24 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Message-ID: <6auzmytl2yuea75l2z5zeqlfvtjagvd6cuwwnhkpccpbc63yks@3sp6sav75nq5>
References: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
 <20260727-aspm-v6-3-2ebb3ee7ef71@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-aspm-v6-3-2ebb3ee7ef71@oss.qualcomm.com>

On Mon, Jul 27, 2026 at 07:32:38PM +0530, Krishna Chaitanya Chundru wrote:
> Some platforms require selectively disabling specific ASPM states on a
> given PCIe link to avoid link instability or functional failures caused
> by board-level connectivity constraints such as PCB routing, connectors,
> slots, or external cabling.
> 
> Devicetree supports disabling ASPM L0s, L1, and L1 PM Substates via the
> 'aspm-no-l0s', 'aspm-no-l1' [1], and 'aspm-no-l1ss' [2] properties.
> However, the ASPM driver does not currently honor these properties when
> initializing the default link state.
> 
> When firmware enables L1 PM Substates before the kernel takes over,
> masking aspm_support alone is insufficient to disable them in hardware.
> pcie_config_aspm_link() guards L1SS configuration behind a check on
> aspm_capable, which is derived from aspm_support. Once aspm_support is
> masked, pcie_config_aspm_l1ss() is never called, leaving
> firmware-enabled L1SS substates active in hardware.
> 
> Fix this by introducing pcie_link_has_aspm_override() to check for DT
> override properties on either endpoint of the link. In
> pcie_aspm_override_default_link_state(), use it to:
> 
>  - Mask aspm_support, aspm_default, and aspm_enabled for any disabled
>    state, so software's view of the link stays in sync with what is
>    actually programmed in hardware. Leaving aspm_enabled stale would
>    make pcie_aspm_enabled() and the aspm sysfs attributes report a
>    state as active even after it has been masked, and could cause
>    pcie_config_aspm_link()'s "already in requested state" check to
>    skip reprogramming hardware to match.
>  - Explicitly call pcie_config_aspm_l1ss(link, 0) before masking
>    aspm_support when firmware has L1SS active and DT requests disabling
>    L1 or L1SS, since pcie_config_aspm_link() will no longer do so once
>    aspm_capable is derived from the masked aspm_support.
> 
> Move the aspm_default initialization and
> pcie_aspm_override_default_link_state() call in pcie_aspm_cap_init() to
> before the "Restore L0s/L1" block. pcie_aspm_cap_init() disables L1 in
> hardware prior to aspm_l1ss_init() and re-enables it only in the
> restore block. Calling pcie_config_aspm_l1ss() while L1 is already
> disabled satisfies its precondition ("Caller must disable L1 first"),
> whereas the previous placement after the restore violated it.
> 
> Since the restore block writes back the parent_lnkctl/child_lnkctl
> snapshot taken from hardware before the DT override ran, mask the L0s
> and L1 enable bits out of that snapshot for any state the override has
> just disabled in aspm_support. Otherwise the restore step would
> unconditionally reprogram the link back to firmware's original L0s/L1
> configuration, defeating the Devicetree override it is meant to
> enforce.
> 
> Move pcie_config_aspm_l1ss() earlier in the file so it can be called
> from pcie_aspm_override_default_link_state().
> 
> Link [1]: https://github.com/devicetree-org/dt-schema/pull/188
> Link [2]: https://github.com/devicetree-org/dt-schema/pull/190
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
