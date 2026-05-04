Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F9328F5;
	Mon,  4 May 2026 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777872706; cv=none; b=SXWRSexhXnqb2gC/wL7zJAxfam0yGSkvvOz8MEH8EzD6QuSjIaUczpoOPBEoi5g6cyWgrE07KJ80iZsr3g7PRwLVvX9xcaCfXnWaPSAVauPRJeLbBYUzuj5IP0o579uCyWnjVEhF2O5CTkZmFKOhbPtosb53DJO31hJZ/99FHA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777872706; c=relaxed/simple;
	bh=i5wNmWpGGjhz7E8ewAF2JFePCxMEzCQlbM0d5kk3dB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlzZ026b1oyQ/yT5b79r9ay+xTkWZSYN7cJRQYoAAjyni07BSM+SwreIpXs6e3fEd8DBmNCgdAC3iKo5PV9Yzrahv34HT4btiwcyKza8u2VJZ7yuPrYFDrmlbetKw/W/G/UDqm5Z6wqI8JAQIqQH4a0ZKNsNUodaztVRXXwEchE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vwr09kS1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vwr09kS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1EDC2BCB8;
	Mon,  4 May 2026 05:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777872705;
	bh=i5wNmWpGGjhz7E8ewAF2JFePCxMEzCQlbM0d5kk3dB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vwr09kS1jMso+YL5qW0HNl6Rgrswzt24pAcw11cMi2OFfYhxOnyLt9YhbJkTyhj1e
	 vBt1tMXCNFta62r5g9s+gDnVeGFp+xqscvxbK0Qoaq++HoHJUnYlWr4UzWqQpp8n7I
	 hOt8iQwTzMwNl/MlmVNdEsFMY3k55845ZfsDCO78HxZNCGTsHEoYmSf0VxPtZpi+gW
	 BHNwAUTsQ3phh+afd8Ie344+4MUNGoTn0RsNqGWK+siEHH7z3GP977qaemzTksamqE
	 Uz2uMVS+PJsEn8r4a6THtfRcNEVyw9x+vqKuAPtLCcE7elhfSvajUaUh+3JDLEebf3
	 /ZpQ0i2h2uf4g==
Date: Mon, 4 May 2026 14:31:43 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: bhelgaas@google.com, jgg@nvidia.com, jonathan.cameron@huawei.com, 
	dan.carpenter@linaro.org, akpm@linux-foundation.org, bp@alien8.de, rdunlap@infradead.org, 
	alex@shazbot.org, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 3/6] PCI: Consolidate delimiter handling into
 pci_dev_str_match()
Message-ID: <20260504052005.GA2312220@rocinante>
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
 <SEZPR01MB4399FA7D597B0A619C6F9A7EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR01MB4399FA7D597B0A619C6F9A7EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>

Hello,

> +not_found:
> +	if (ret < 0)
> +		pr_err("PCI: Can't parse parameter: %s\n", p);

Two issues here:

  - At this time, when this messages is to be shown, the p can be already
    at the NULL-terminator, as a result of parsing, so if the entire
    parameter is some garbage value, then it will show nothing in dmesg.

  - This new per_err() is not rate-limited, like the old messages were,
    so if the parameter is invalid or malformed, and you have... 30, or
    more on servers and serious hardware, devices in the system, then
    it will print for every single one of them.

Albeit, the second issue might not be an issue, and it might have been on
purpose.  However, I am not convinced it was.

> +	if (*p != ';' && *p != ',') {
> +		/*
> +		 * End of param or invalid format. Return -ENODEV so the caller
> +		 * stops parsing.
> +		 */
> +		return -ENODEV;
> +	}

[...]
> @@ -943,18 +960,11 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>  
>  		ret = pci_dev_str_match(dev, p, &p);
>  		if (ret < 0) {
> -			pr_info_once("PCI: Can't parse ACS command line parameter\n");


[...]
> @@ -6392,16 +6402,8 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
>  			align = 1ULL << align_order;
>  			break;
>  		} else if (ret < 0) {
> -			pr_err("PCI: Can't parse resource_alignment parameter: %s\n",
> -			       p);

For the two above - it was nice to have the information about which
parameter to what kernel boot option was actually causing issues.  The
new code will only print a generic message.

Thank you!

	Krzysztof
