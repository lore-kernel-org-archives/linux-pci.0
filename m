Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793131700;
	b=Ru2fcgQUnOyMgnQBi9bDX6XF9CCaJvUJzWKcYBJvKXneFADFK7+sWSH9Vg3uM9AcNxMR
	 L/T0HK3IpPM/hon/3pDAKDz2nm27NbxsYLADkIBjQjjq5Pc7IF5wpn5klruRRiOR3rMrG
	 R0L5Rctd2azbX5Jh+I2aMCFReaUBVVUDlJ0iJ4ZkiZqoPdxJeyc6J5L5o+Z/Skzl9eQLW
	 DwDLqIE0xIqI6uoakIH3nXi/sny6IbSdiWx5PDCmB4JQAOg+aHQ53UKZ4la3ro1vOUHD2
	 B07GHDRr/CG4FD5VeTtHvxwApNctGCTRq92vuF++PrtwJrQv38xkD2cEjwnPK6u/IRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131700;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LfuuzRta0ecfFktp7KiAJuNjtLbag20YiQ4n2maa6Rk=;
	b=kf9GOLUVaNZybTYsOklm7al0ThYBpy66Kjg3rinXV63BAb54QN9yQqIfNZAScUzNcXGT
	 hdkrdKVY9SSGEKSZUgKZQy0uSm6s8KKvGjQcltgF+mQricq6xOWOB5DTzD9lI1zeRZ9tu
	 dbKyzYhKYPG67d42TH1HEqFtBDeaca73FpN2dg58w67Qq80r5heZMglUPZVD3tMEzeMRo
	 QaveU5+3PG29/Pcn4crs/mlv/JImuW15CiuSKjIa7yUw8FDDJ64763lK16Ach2HW7r5Ln
	 ODIhD6jlrQsq3DRb4C80Xr5xrljmQrJbCoT9WSjs2CjJyc3dT2uqKeob1cQxsOOxPoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eT5NguxM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B183606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eT5NguxM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98481F01825;
	Tue, 27 Oct 2026 20:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793131699;
	bh=LfuuzRta0ecfFktp7KiAJuNjtLbag20YiQ4n2maa6Rk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=eT5NguxMt4xGTBLkyMjmlPqX+aGtE6akYq0rvjFcszXG7ABKcPZ0KdLvPfQuJurBh
	 dgMVTnwi/TRCUaNFZXxuy3y0FvyApz4gYI5/59C0aXaAewhzYW6MI4TnnKjYLR7IT5
	 sVMIXMsgGUwoqdtaqSyYTG80m/Il5+Nh6whfdbMfRPbgdeBLUjJuaIunEp8eFI4R1C
	 ZQy3QeR3a1UECnkJSFFlYW01ouPWf52nKCAOCVa5GQERJYrs6yIZHLe1TO6D5Y5yoP
	 QiqdoUZ6GJQHg0+h5cW0So5oqR/6+F1gpjCSoeOClxIrJoglcIX5ZG/MfHC4HoB4jh
	 h2IJlaVeaPTeQ==
Date: Tue, 27 Oct 2026 15:08:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukasz Laguna <lukasz.laguna@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	michal.winiarski@intel.com, djbw@kernel.org, brett.creeley@amd.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH v2 09/13] PCI/TSM: Use generic VF iterators
Message-ID: <20261027200818.GA482873@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027160446.858300-10-lukasz.laguna@intel.com>

On Tue, Oct 27, 2026 at 05:04:42PM +0100, Lukasz Laguna wrote:
> pci_tsm_walk_fns() and pci_tsm_walk_fns_reverse() implement their own VF
> iteration logic. Replace it with for_each_pci_vf() and
> for_each_pci_vf_reverse().

This and the rest of the series seems like nice, relatively simple
cleanup that could be done earlier, e.g., after [02/13] "PCI/IOV:
Introduce VF iterators".  Those look fairly straightforward and maybe
could be merged earlier to get them out of the way.

> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>
> ---
>  drivers/pci/tsm.c | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 5fdcd7f2e820..01fa6149e481 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -84,6 +84,7 @@ static void pci_tsm_walk_fns(struct pci_dev *pdev,
>  	for (int i = 0; i < 8; i++) {
>  		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
>  			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +		struct pci_dev *vf;
>  
>  		if (!pf)
>  			continue;
> @@ -93,18 +94,8 @@ static void pci_tsm_walk_fns(struct pci_dev *pdev,
>  			cb(pf, data);
>  
>  		/* walk virtual functions of each pf */
> -		for (int j = 0; j < pci_num_vf(pf); j++) {
> -			struct pci_dev *vf __free(pci_dev_put) =
> -				pci_get_domain_bus_and_slot(
> -					pci_domain_nr(pf->bus),
> -					pci_iov_virtfn_bus(pf, j),
> -					pci_iov_virtfn_devfn(pf, j));
> -
> -			if (!vf)
> -				continue;
> -
> +		for_each_pci_vf(pf, vf)
>  			cb(vf, data);
> -		}
>  	}
>  
>  	/*
> @@ -128,22 +119,14 @@ static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
>  	for (int i = 7; i >= 0; i--) {
>  		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
>  			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +		struct pci_dev *vf;
>  
>  		if (!pf)
>  			continue;
>  
>  		/* reverse walk virtual functions */
> -		for (int j = pci_num_vf(pf) - 1; j >= 0; j--) {
> -			struct pci_dev *vf __free(pci_dev_put) =
> -				pci_get_domain_bus_and_slot(
> -					pci_domain_nr(pf->bus),
> -					pci_iov_virtfn_bus(pf, j),
> -					pci_iov_virtfn_devfn(pf, j));
> -
> -			if (!vf)
> -				continue;
> +		for_each_pci_vf_reverse(pf, vf)
>  			cb(vf, data);
> -		}
>  
>  		/* on exit, caller will run @cb on function 0 */
>  		if (i > 0)
> -- 
> 2.43.0
> 
