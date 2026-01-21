Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [144.76.133.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE031A7E1;
	Wed, 21 Jan 2026 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017825; cv=none; b=RlzVXxSw8cnlKTGLpY2zauc7m7hH3MtNGh0xwXRIV/zcHlZOUJC0G631GimEGAfSzriqRUz0AsjKrzU5sz2svLh7Hm8h5uKmdaCPObI8cBrs+Wf4rnTPe7vXwcS7RMn1x8XOBiw9WuOOinzKtNmUz22uqyOn9U0WuBYGuB9BUXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017825; c=relaxed/simple;
	bh=wXhkrXas7afKk2bXMs2SmgD8smLMiLuYZL4Dcq7EA0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m70t6uaxJk9MxruFuN+pi99cuaq4/Iz4G0/SiJiHjsXDAoPVAlG39MA7vxADhmkxEFjIcTYPUgvczeTCmgFmsBc1YaIeNdaL6Z50ytIgR3UKZWcpz90uHgxjUIjeTwAR7aCQdJvmNO9EH67WILNKZ/WEur9xMmT+dQtBMjWvSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=144.76.133.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 933B02C000A9;
	Wed, 21 Jan 2026 18:41:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7784330ED2; Wed, 21 Jan 2026 18:41:19 +0100 (CET)
Date: Wed, 21 Jan 2026 18:41:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Initialize RCB from pci_configure_device
Message-ID: <aXEPv8BChwIhlZPa@wunner.de>
References: <20260121113544.4163457-1-haakon.bugge@oracle.com>
 <20260121113544.4163457-2-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260121113544.4163457-2-haakon.bugge@oracle.com>

On Wed, Jan 21, 2026 at 12:35:40PM +0100, Håkon Bugge wrote:
> +	if (pcie_cap_has_lnkctl(dev) &&
> +	    (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    !dev->is_virtfn && pcie_root_rcb_set(dev)) {
> +		u16 lnkctl;
> +
> +		pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> +		if (lnkctl & PCI_EXP_LNKCTL_RCB)
> +			return;
> +
> +		pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnkctl | PCI_EXP_LNKCTL_RCB);

You may want to use pcie_capability_set_word() for brevity.

Thanks,

Lukas
