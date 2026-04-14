Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E23E9580;
	Tue, 14 Apr 2026 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179621; cv=none; b=ar+6RoMMfne6Jq/mxP249oPH75HXWWviHHLviQPf3cWUgSWxIS72zxIISmibtfq4Qxl56J2llwTaF3ZKt11FbMqUPh9CxYF97Dpbw2zmJpylT8ezyMuV3ubugCnOba6RF/zYvgxLVdirr5TXf1EzgYps/TZT99inyCQmXydQlJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179621; c=relaxed/simple;
	bh=SxMcvDSO1WH57hVUH3MEAHeEedBtt6pHuvvrisfSZ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVl1nUIsMwQZQwh6uTv/jc2CRR44kHVLHPW91wA/10v/3yszCztDznJhHcbarYLrar+WxQalo1c0hwC/EaOIpk5wEiU5kvxUbrybsF/JHz/7D2GRP2qWOoGbh/4+IeK19pxhNkjp0SmFKImD6p3twF2XS34VRRwZNBCN+NmaJe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 8EB0410586;
	Tue, 14 Apr 2026 17:13:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6E6506034192; Tue, 14 Apr 2026 17:13:36 +0200 (CEST)
Date: Tue, 14 Apr 2026 17:13:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com, jay.bhat@intel.com,
	ivan.d.barrera@intel.com, aleksandr.loktionov@intel.com,
	larysa.zaremba@intel.com, anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
	linux-pci@vger.kernel.org, madhu.chittim@intel.com,
	decot@google.com, willemb@google.com, sheenamo@google.com
Subject: Re: [PATCH iwl-next v2 2/2] idpf: implement pci error handlers
Message-ID: <ad5ZoDCuSsPW0lKo@wunner.de>
References: <20260414031631.2107-1-emil.s.tantilov@intel.com>
 <20260414031631.2107-3-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414031631.2107-3-emil.s.tantilov@intel.com>

On Mon, Apr 13, 2026 at 08:16:31PM -0700, Emil Tantilov wrote:
> +static pci_ers_result_t
> +idpf_pci_err_slot_reset(struct pci_dev *pdev)
> +{
> +	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
> +
> +	pci_restore_state(pdev);
> +	pci_set_master(pdev);
> +	pci_wake_from_d3(pdev, false);
> +	if (readl(adapter->reset_reg.rstat) != 0xFFFFFFFF)
> +		return PCI_ERS_RESULT_RECOVERED;

FWIW, there's a PCI_POSSIBLE_ERROR() helper that you may find useful
to check for an "all ones" MMIO read.

Thanks,

Lukas
