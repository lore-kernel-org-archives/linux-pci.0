Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE33644A5;
	Thu, 22 Jan 2026 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076571; cv=none; b=EjCosRkKtsRYuaCshmaarXfwbTDO+SNd56CY7pD2rnARviMvsmRuxZcprWQF2P+ful0Bg3gKJyglPTpUYPaxm4CtkHmr8KC05ahkBRvOiNYpWAEFacMGRF+6OWBsnM4Zt7CEVUHYmHiaKuaQw1s5Bph8HgO492qLxRymY/6Jfn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076571; c=relaxed/simple;
	bh=OE5G/iNMCoqwXls/6lkvnsoui1mMms/Cv7bI2ZgQDDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGeooBzSouFzJeMXrYK3efo+D1Xh4ec6rUMQQit1/hQP86BAD7Sp9EVeZa+YylUhCmr87F1kgVsHelK7/cY2kSfMk0v2haiANAwHi4RE4JWQX8c7o/539/eOvhlYYUHelyh7jF03ttqaZbNm4xrtxZbxEWeyiipglJTzx5Kv+1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5B2872C06AA1;
	Thu, 22 Jan 2026 11:01:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 464F02D331; Thu, 22 Jan 2026 11:01:57 +0100 (CET)
Date: Thu, 22 Jan 2026 11:01:57 +0100
From: Lukas Wunner <lukas@wunner.de>
To: smadhavan@nvidia.com
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
	ming.li@zohomail.com, rrichter@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, huaisheng.ye@intel.com,
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	vaslot@nvidia.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
	vidyas@nvidia.com, mochs@nvidia.com, jsequeira@nvidia.com,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v4 09/10] PCI: save/restore CXL config around reset
Message-ID: <aXH1lfR8g1q--oJc@wunner.de>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260120222610.2227109-10-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120222610.2227109-10-smadhavan@nvidia.com>

On Tue, Jan 20, 2026 at 10:26:09PM +0000, smadhavan@nvidia.com wrote:
> +++ b/drivers/pci/pci.c
> @@ -4989,6 +4990,11 @@ static int cxl_reset(struct pci_dev *dev, bool probe)
>  	if (probe)
>  		return 0;
> 
> +	pci_save_state(dev);
> +	rc = cxl_config_save_state(dev, &cxl_state);
> +	if (rc)
> +		pci_warn(dev, "Failed to save CXL config state: %d\n", rc);
> +

Hm, shouldn't the call to cxl_config_save_state() be moved to
pci_save_state() (and likewise, cxl_config_restore_state() moved to
pci_restore_state())?

E.g. when a DPC event occurs, I assume CXL registers need to
be restored as well on recovery, right?

Note that since v6.19-rc1, state is saved on enumeration and
thus always available for recovery, see a2f1e22390ac.

As a general remark on this series, it seems to have considerable
overlap with Terry's work on AER support for CXL, particularly in
patch [01/10], as Jonathan has remarked.  Please cc Terry on future
submissions and coordinate with him on conflicting parts of your
patches:

https://lore.kernel.org/all/20260114182055.46029-1-terry.bowman@amd.com/

Thanks,

Lukas
