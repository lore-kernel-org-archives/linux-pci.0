Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C41A6806;
	Sun, 20 Sep 2026 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885053; cv=none; b=BFen8gbBA40UBH80VLKZJaCBhWa6bJUgaK1QuMiOFasdmbqyR21p5TpKMMhGrv70keWeQ1YaglhaYACLJVDhVctqbvnoUO8TSMc2D19n/78ggxSVwM0b+VYQ06db6S/2Uoq/9i1Wczj8AULi33b/Wqh6lVB6w0ZES+R04KFDCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885053; c=relaxed/simple;
	bh=wsDZb9FaCBL6EPTf17FjcijI1ZHiidhK1dy76kOY0WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOdn5el7UiNDUZWEGw707TH0XeuIkcd9otJ6kRrdPSDj3/oAb01Y/O87EPkbq0gGEjHNcOpDXsAmPRD2tdsyvitS4RdfAvzV3uAIuRcg1Asq1/Etypm3lGDf/4wu+8eh61sU8V94B5OF65bRZTpEwg76VKMjkVeZHk0Y8OgeS/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id A80E34938;
	Sun, 20 Sep 2026 08:17:21 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7697E61ACEA6; Sun, 20 Sep 2026 08:17:21 +0200 (CEST)
Date: Sun, 20 Sep 2026 08:17:21 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rafael J Wysocki <rafael@kernel.org>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v13 2/5] PCI: Assume control of portdrv-related features
 only when portdrv enabled
Message-ID: <aq96cULSmdeBzd3D@wunner.de>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919162655.3499010-3-sathyanarayanan.kuppuswamy@linux.intel.com>

On Sat, Sep 19, 2026 at 09:26:52AM -0700, Kuppuswamy Sathyanarayanan wrote:
> +++ b/drivers/pci/probe.c
> @@ -668,12 +668,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	 * may implement its own AER handling and use _OSC to prevent the
>  	 * OS from interfering.
>  	 */
> +#ifdef CONFIG_PCIEPORTBUS
>  	bridge->native_aer = 1;
>  	bridge->native_pcie_hotplug = 1;
> -	bridge->native_shpc_hotplug = 1;
>  	bridge->native_pme = 1;
> -	bridge->native_ltr = 1;
>  	bridge->native_dpc = 1;
> +#endif
> +	bridge->native_ltr = 1;
> +	bridge->native_shpc_hotplug = 1;
>  	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;

How about (e.g.)

 	bridge->native_pcie_hotplug = IS_ENABLED(CONFIG_PCIEPORTBUS);

instead of using #ifdef?  That's the preferred style according to
section 21 of Documentation/process/coding-style.rst

>  	bridge->native_cxl_error = 1;

Hm, this one depends on CONFIG_PCIEAER I believe.
(But Terry Bowman is the expert.)

Thanks,

Lukas
