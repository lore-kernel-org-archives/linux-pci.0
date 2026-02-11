Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4621C84BD;
	Wed, 11 Feb 2026 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813280; cv=none; b=X8WLsu0xtWPrOV5ZrHj1YU6UN+PHM3cauoQO3CYylFxnuphijgF5cRmOPLaT74CoeX8ohx+p75flrUQ3tCRWKxwgLk72X6Kpy8x7JBDvRdfhs4A2JyM8QcRHO5UVtPshYkXvxUrgVJkqLLwgTNId4oEZu+DtyY2ZNk4WAEeMOU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813280; c=relaxed/simple;
	bh=e3hklfL8NjYOBfoGGoSdOrS2m8b1kmDquBnKh2W+ehM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unw6Jz/PPMNfE8qLPe0RfqStmI+UA4evNR5EgzAGe4tUW+XUDTLY6mcAAj+60FAPkv7/O1KaeyqVEnLHRavWKEF6ETDYOUK0yAN7vAFyfvs8ihqMfQHSTNZMlqDktorGr63yiNcLbzFGMMRo36hDUhS2OUlXYR4xVXXHbWjmy3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id AA9252C05FEA;
	Wed, 11 Feb 2026 13:34:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 874C732273; Wed, 11 Feb 2026 13:34:27 +0100 (CET)
Date: Wed, 11 Feb 2026 13:34:27 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com,
	zhuo.song@linux.alibaba.com, oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v2] PCI/AER: Only clear error bits in PCIe Device Status
 register
Message-ID: <aYx3Uy7rE6GM9xq-@wunner.de>
References: <20260211054816.22758-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211054816.22758-1-xueshuai@linux.alibaba.com>

On Wed, Feb 11, 2026 at 01:48:16PM +0800, Shuai Xue wrote:
> +++ b/drivers/pci/pci.c
> @@ -2243,10 +2243,11 @@ EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
>  #ifdef CONFIG_PCIEAER
>  void pcie_clear_device_status(struct pci_dev *dev)
>  {
> -	u16 sta;
> -
> -	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
> -	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
> +	pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
> +				    PCI_EXP_DEVSTA_CED |
> +				    PCI_EXP_DEVSTA_NFED |
> +				    PCI_EXP_DEVSTA_FED |
> +				    PCI_EXP_DEVSTA_URD);

Isn't there one too many blanks before each of the PCI_EXP_DEVSTA_* macros?

The available space would be sufficient to accommodate two macros per line,
so just 2 instead of 4 lines for the macros.

Otherwise this is:
Reviewed-by: Lukas Wunner <lukas@wunner.de>
