Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A82FF672
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016865; cv=none; b=MzJcGuAk5/UwZZM/v6dsyRnT4gdNXbuyPnL01OY1zOZwHJriFgqPiEBsYyfMx56ljfR/wXfOJgmAUihkSKYahadffFagiGpjh+HAdLBgICqVF9jERLrXCN4lEd2Vpb7xmQiju38BX2Jo43YoZqfCugI34w6c9k0u+CkGT6hlwKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016865; c=relaxed/simple;
	bh=4tCCNdmA7rRVdqPHDk7gxdr4Z/iM+ZqcjdioQ7H/LgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FcyaTjoM7zBqILgxRRcAJjCKUQPGnFw4YztU9NGKtd5Knd0baoNuK6j5KjAhvTF8eEgpYj26WLoxA2OQISZaX59Zsg+rTChVTbs0UHVHG0VJsTV6kZD0gtqzUnrnTiBEW6zRg9FymLMN9Z3afc7VEZ5fcuE4V6FGHumTJWfVncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFqXE8UT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFqXE8UT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8FB1F000E9;
	Thu,  6 Aug 2026 11:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016863;
	bh=o9jYnPnVGWSLOUxdmSbRSNOz4HXC5bMzFImtpSvJwVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nFqXE8UTjPMyDvefnbPzEqlRL2GNgyT/hUhXXhOaIkVKSdi8XmMs+tT8ZBxXYoiJ5
	 pcjmTPVqepDf+9AgvQ3GBi9c9tEhn8J/TRs95HXtmqQM+gip1bLFWyu70eHyjXh9M/
	 pcS6BrNlYrauX/R2f4gIZi+hGnf4NstPBQ5CsPhSXFxJBaXBBey14CKGdFEmolfAJO
	 ydxOR4XHPWZobliIoCV2Hq97mMEsl5LTagEW7NcxgFQeK72exJtesiJOg1e5vzaiKf
	 7B/7NrLnwfJQe5hGQ9mVJt2H9yYTE+IwdfPvNeyXX7YNjPZjN4/+EUhOKNYdk9Lx+L
	 Lf0116Rs0ce3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/13] PCI/P2PDMA: Honor ACS egress control vectors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-8-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-8-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:47:42 +0000
Message-Id: <20260806114743.8B8FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Cross-domain PCIe ACS Egress Control Vector evaluation uses meanin=
gless port numbers when devices reside on different host bridges.
--

--- Patch [8]: [PATCH v2 08/13] PCI/P2PDMA: Honor ACS egress control vector=
s ---
commit 96de4ef43ce98491771577d7338b7224cb26b816
Author: Leon Romanovsky <leon@kernel.org>

PCI/P2PDMA: Honor ACS egress control vectors

This commit updates P2PDMA to properly evaluate the ACS Egress Control Vect=
or
when determining routing between peers. It reads the vector where the paths
diverge below their common upstream port, treating a clear vector bit as a
direct path and a set bit (without Request Redirect) as an ACS Violation.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c

[ ... ]

> @@ -770,25 +770,44 @@ calc_map_type_and_dist(struct pci_dev *provider, st=
ruct pci_dev *client,
>  	 */
>  	no_common_upstream =3D true;
> =20
> -check_b_path_acs:
> -	bb =3D b;
> +check_paths_acs:
> +	*dist =3D dist_a + dist_b;
> +	bb =3D provider;
> =20
>  	while (bb) {
> +		target =3D bb =3D=3D a_child ? b_child : NULL;
> +		state =3D pci_acs_p2pdma_state(bb, target);

[Severity: High]
When no_common_upstream is true, the provider and client reside on different
host bridges. Does this cause pci_acs_p2pdma_state() to evaluate the ACS
Egress Control Vector using a target from a completely different PCIe domai=
n?

If bb =3D=3D a_child, b_child is passed as the target. Down in
pci_acs_egress_ctrl_set(), the link capabilities of the foreign port are us=
ed
to extract a target port number:

drivers/pci/pci.c:pci_acs_egress_ctrl_set() {
    ...
    target_port =3D FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
    ...
    ret =3D pci_read_config_dword(pdev,
                                pdev->acs_cap + PCI_ACS_EGRESS_CTL_V +
                                (target_port / 32) * sizeof(vector),
                                &vector);
    ...
}

Since pdev and target are on different host bridges, does this use a
meaningless port number as an index? If so, this could read arbitrary bits
from the hardware configuration space and potentially result in incorrect A=
CS
routing decisions or spurious violation warnings.

> +		if (state !=3D PCI_ACS_P2PDMA_DIRECT) {
> +			seq_buf_print_bus_devfn(&acs_list, bb);
> +			if (state =3D=3D PCI_ACS_P2PDMA_REDIRECT)
> +				acs_redirect_cnt++;
> +			else if (!acs_unsupported)
> +				acs_unsupported =3D bb;
> +		}
> +
>  		if (a =3D=3D bb)
>  			break;
> =20
> -		if (pci_acs_p2pdma_state(bb, NULL) =3D=3D
> -		    PCI_ACS_P2PDMA_REDIRECT) {
> -			seq_buf_print_bus_devfn(&acs_list, bb);
> -			acs_cnt++;
> -		}
> -
>  		bb =3D pci_upstream_bridge(bb);
>  	}
> =20
> -	*dist =3D dist_a + dist_b;
> -
> -	if (!acs_cnt) {
> +	bb =3D client;
> +
> +	while (bb && a !=3D bb) {
> +		target =3D bb =3D=3D b_child ? a_child : NULL;
> +		state =3D pci_acs_p2pdma_state(bb, target);

[Severity: High]
Similarly here, if the devices are on different host bridges, a_child and
b_child are on different domains. Does passing a_child as the target to
b_child's ACS evaluation create the same cross-domain hardware configuration
read issue?

> +		if (state !=3D PCI_ACS_P2PDMA_DIRECT) {
>  			seq_buf_print_bus_devfn(&acs_list, bb);
> -			acs_cnt++;
> +			if (state =3D=3D PCI_ACS_P2PDMA_REDIRECT)
> +				acs_redirect_cnt++;
> +			else if (!acs_unsupported)
> +				acs_unsupported =3D bb;
>  		}
> =20
>  		bb =3D pci_upstream_bridge(bb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D8
