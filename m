Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE335E944;
	Fri, 14 Aug 2026 03:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786679509; cv=none; b=YMbMKPPc8yzSZSkYc9k4roIrW6dZuqJZhhMas1fn596sh039lVIrYfEhgiCbMOzsKkuni51/y+2JuHx4IY49Vsl81GGadHX5K+w9L4UAEfdxCVuI/vDHPmMn/1pMUdwfBnxpkGGM7wvGwl/h3g2rqkloel9t3VD5jT+cttxmYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786679509; c=relaxed/simple;
	bh=Qg+Ecx7NVsm+ljabb4vLMxPnowmdo0/TRRssY72JkJs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=amCvNO2+y1HC9aZsLl0HNkSgb2JWVcGVRKHrPADE4WR4QZPNDRtvc5Sl48BxMx8IQLzu54JNiBNS+pEtgGuzYamz20kJVr80M+6G4sAOlOsvCueHsY2Ens9FjsAZHsmNYaiDf4V11toX3Xs+4lFmPgh2C8cuL0BUTLd4MID5WLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=dQ8rNrOs; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="dQ8rNrOs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=6GFa1C7gAI7sWCaZh4nkyxfa5WX3juo6z7eBpomHhtU=; b=dQ8rNrOsie+NPGcrV3FgZdgmVC
	fnM148n+gAddDgoHD3FCFI33I5aSDzxPGmnsPXicEv0+tpo9yTBVzfdhdfGb0/u4G9EM7kTNFA5Ww
	xvgaspsNf29bwXUQZ2Kp8T1QLSJLeMKE4lBEV7w97MLqWrjbxhZOiqLMt19srgSgNLbbq0lU5v09s
	YGw4cSqHBIGZ06+hM7SToV38scDnp/XQyZHOf1md/OAZQuUO7XTYB2qt/icKcQ9Nnc8OT5sz2MDu2
	fs4WQOsn52eT8DVnooTggdl1+7Fl6yhZh+Hw+qPTaea+NDS7s4JdRGQEO42fT73Km04l1B9bNiVpm
	c06YU8mw==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wuixO-00000002Yve-0ibj;
	Thu, 13 Aug 2026 21:51:47 -0600
Message-ID: <5e7eb09b-a47b-4cb5-8629-0ca5fa39f1f9@deltatee.com>
Date: Thu, 13 Aug 2026 21:50:07 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, "Natu, Mahesh" <mahesh.natu@intel.com>
References: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
 <20260812-hmat-p2p-v1-4-75ac41380585@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260812-hmat-p2p-v1-4-75ac41380585@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: leon@kernel.org, rafael@kernel.org, lenb@kernel.org, saket.dumbre@intel.com, bhelgaas@google.com, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de, mahesh.natu@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH RFC 4/7] PCI/P2PDMA: Prefer providers with better HMAT
 performance
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-12 1:47 p.m., Leon Romanovsky wrote:
> @@ -820,21 +844,29 @@ static unsigned long map_types_idx(struct pci_dev *client)
>   * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE. Otherwise, return
>   * PCI_P2PDMA_MAP_BUS_ADDR.
>   *
> - * Any two devices that have a data path that goes through the host bridge
> - * will consult a whitelist. If the host bridge is in the whitelist, return
> - * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE with the distance set to the number of
> - * ports per above. If the device is not in the whitelist, return
> - * PCI_P2PDMA_MAP_NOT_SUPPORTED.
> + * Any two devices that have a data path through a host bridge require
> + * platform support from the CPU, the host bridge whitelist, or a reachable
> + * ordered HMAT path. Return PCI_P2PDMA_MAP_NOT_SUPPORTED when none of those
> + * sources permits the path.
>   */
>  VISIBLE_IF_KUNIT enum pci_p2pdma_map_type
>  calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  		int *dist, bool verbose)
> +{
> +	return __calc_map_type_and_dist(provider, client, dist, verbose, NULL);
> +}

This patch is a bit hard to follow compared to the earlier ones in this
series.

Why do we need to have a different variant of the function that excludes
coord and is exported only for KUNIT? Why can't we just export the
original function as is instead of creating the double underscore
variant? Personally, I've been trying to avoid creating double
underscore functions and naming functions more appropriately. But this
one seems weird to me.

Seems like some of these details would be better split into another
patch justifying them as this change seems more like prep changes for
the KUNIT work that follows instead of what the patch is meant to do:
enabling the HMAT stuff.


> @@ -941,12 +976,22 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  	}
>  
>  map_through_host_bridge:
> -	if (!cpu_supports_p2pdma() &&
> -	    !host_bridge_hmat_p2p(provider, client) &&
> -	    !host_bridge_whitelist(provider, client, verbose)) {
> -		if (verbose)
> +	host_bridge_allowed = cpu_supports_p2pdma() ||
> +			      host_bridge_whitelist(provider, client,
> +						    false);
> +	/*
> +	 * The coordinates are only used to rank providers, which happens in
> +	 * process context. Skip the firmware lookup on the mapping path once
> +	 * the CPU or the whitelist has already permitted the path.
> +	 */

This feels backwards to me. If ACPI is kind enough to include
information on P2PDMA support then I feel like we should use it
exclusively. Not prioritize the old janky whitelists.

--

In general this series looks really nice. And I'm so glad someone is
finally adding this stuff to ACPI so that we can move away from the
annoying white list.

Thanks,

Logan
