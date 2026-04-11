Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3DB2E093A;
	Sat, 11 Apr 2026 05:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775886214; cv=none; b=ipcxmxI2flJjzYxIJMIcOrx+RNWjeesSW3PWkhYwCszaU8pmyiaLhho2W15FB+X+2C7UtdmTbkgLphVPTr/bVl6zOXvf1iTL1A+UjB5f30FMN8XJT00sjSidyRIdpWpJEPHe8NXxhJmIY3VJdxfqJo+Gol770A94Zy8e4SBC164=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775886214; c=relaxed/simple;
	bh=vfyyOEwLWpusGfVpYmg9rUitdLQgind3LbsBdfcpNVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aB50NPWrVlX6RsEBGnNqyQpm3mY0ktoAqejWuIoRpvbNd7wZTJSgokse4azjXmOjGpu5MuOi9pe4W//RmqWQGLJJxXM7DglEjMeNLqIMw7rSSSVOxZ8+Ai5Lpi+xF9tbCSA30oN69R4j4ZsyDRvM7DdCs4+gRUGw+fwfYF2bhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id F40371686;
	Sat, 11 Apr 2026 07:43:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D84EF6010601; Sat, 11 Apr 2026 07:43:20 +0200 (CEST)
Date: Sat, 11 Apr 2026 07:43:20 +0200
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
Subject: Re: [PATCH iwl-next 2/2] idpf: implement pci error handlers
Message-ID: <adnfeAJHoFoaGYH7@wunner.de>
References: <20260411003959.30959-1-emil.s.tantilov@intel.com>
 <20260411003959.30959-3-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411003959.30959-3-emil.s.tantilov@intel.com>

On Fri, Apr 10, 2026 at 05:39:59PM -0700, Emil Tantilov wrote:
> +static pci_ers_result_t
> +idpf_pci_err_slot_reset(struct pci_dev *pdev)
> +{
> +	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
> +
> +	pci_restore_state(pdev);
> +	pci_set_master(pdev);
> +	pci_wake_from_d3(pdev, false);
> +	if (readl(adapter->reset_reg.rstat) != 0xFFFFFFFF) {
> +		pci_save_state(pdev);
> +		return PCI_ERS_RESULT_RECOVERED;
> +	}

The pci_save_state() is no longer necessary here, please drop it.
See commits a2f1e22390ac and 383d89699c50 for details.

Thanks,

Lukas
