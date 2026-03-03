Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C443366816;
	Tue,  3 Mar 2026 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772561983; cv=none; b=PhCvZUJZ5eSStL9phaqCIv8INKCSCWbHTa+VkBGutckJMCh5Xsn44mE/0jAjCQS5qhwMPmMHPUC9Kqjlw2YnfTpPXgcoqE92xK5iHI9aL28G1aS9HWr/vE8L2tWloNM9uA05qmVAcTumEy1CC78gYofglGyeciDtX26M1W/rGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772561983; c=relaxed/simple;
	bh=At0ECBzaKDrjxT0JLMDBhr+dwJKmlxb1pFjAEOnOM3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ryqfx0+emuEu5ApAdN4HbSmmWn/w6vRdho0eFiMEqorRRPXLN3Zjcoe0Fq3Ydrd6b4b2hJG4ax8Or9SljJorbyq+t7/OQcCZ2sR2anKLp1/B9jbYhd1G05ewvU3b8KL4YZKO4fyC8DJKJa6WkKv6yYXOqhUPPhMR7AcIo7sFh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id D0D89202011D;
	Tue, 03 Mar 2026 19:19:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BB4683F48F; Tue,  3 Mar 2026 19:19:31 +0100 (CET)
Date: Tue, 3 Mar 2026 19:19:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: linux-pci@vger.kernel.org, helgaas@kernel.org, sebott@linux.ibm.com,
	schnelle@linux.ibm.com, bblock@linux.ibm.com, alifm@linux.ibm.com,
	julianr@linux.ibm.com, dtatulea@nvidia.com, mani@kernel.org,
	ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] PCI/IOV: Add reentrant locking in
 sriov_add_vfs/sriov_del_vfs for complete serialization
Message-ID: <aacmM9bAPstfDpgY@wunner.de>
References: <20260303080903.28693-1-ionut.nechita@windriver.com>
 <20260303080903.28693-2-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303080903.28693-2-ionut.nechita@windriver.com>

On Tue, Mar 03, 2026 at 10:09:02AM +0200, Ionut Nechita (Wind River) wrote:
> +++ b/drivers/pci/iov.c
> @@ -629,19 +629,23 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
>  {
>  	unsigned int i;
>  	int rc;
> +	bool locked;
>  
>  	if (dev->no_vf_scan)
>  		return 0;
>  
> +	locked = pci_lock_rescan_remove_reentrant();
>  	for (i = 0; i < num_vfs; i++) {
>  		rc = pci_iov_add_virtfn(dev, i);
>  		if (rc)
>  			goto failed;
>  	}
> +	pci_unlock_rescan_remove_reentrant(locked);

I think a nicer API would be to have a counter which
is incremented by pci_lock_rescan_remove_reentrant() if owner is current,
is decremented by pci_unlock_rescan_remove_reentrant() if owner is current
and pci_unlock_rescan_remove_reentrant() unlocks only if it hits 0.

No need for an atomic counter as this happens under the lock.

Then you don't need this bool which leaks out of the API into the callers.

Also, I would put this in the existing pci_lock_rescan_remove(),
i.e. without introducing a new _reentrant variant, because these
deadlocks exist elsewhere.  They're known to happen on unplug in
pciehp as well.

Thanks,

Lukas
