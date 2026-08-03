Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB237BE9E;
	Mon,  3 Aug 2026 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781944; cv=none; b=NSsZsW0924l1zdt1+vGSH/7TeeNE7acjwbhbpgY8i7K5UU1fOG1pU5FtLju4ahFBlHmsEaFGbRo9AUUMAacNPi1TeHYC7K5oRXo+etvdL8Y8W0znFRuB4MMozvbE77ytcAP5xPFqQWIC6wZBAroYIsCaTPG/amvtA5ScVK2x87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781944; c=relaxed/simple;
	bh=dln6sBGoJxFtYsiDomVGo3RWQyPALW7qdVJCvjG1gkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OpsY8vys8L9ydo0tNaUI4ICxwCaigtfbAUxiNZ7o4vsXu+eNlm1dULhdwnah/e6frjVuXssDGhFYQiSgp4SQoaXCaGr4EATe0FlMOGBnBQ7PTSDr3Kmp8TcaanVPUxNrd/jksvPGunP+YucTb9ODfGyaa5FoiNS3wxu24UizCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVDIBbDG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVDIBbDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654851F000E9;
	Mon,  3 Aug 2026 18:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781942;
	bh=vaVql0ah70ZpJa+IBZ7DiV/y9i0oXqb9bvXrPRc0IRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HVDIBbDGKY2jL9ssjeaFcMRZiIzMM+v6ow7rSrQ9z7NIO1EJH2m2/XzICA6NCyPgp
	 VilcwBVHMuTStGhnFzRzpR9XwFdRzn3zGmbM+f+L8VHJCLK/cTlDhqzGKOgcGamrg7
	 0ABBPVE9S/EXVPgMuMiFF0ixRGz2hdGQGbqQqd+qfnOYag4M3F8OKywCEQuMX27+Np
	 qQSmrEKYZuvDR1q6SKKYA/7Pz7r/MdNbEQFzDxxmWKjLXmAw+LQo3TqhUE+HXcBrW1
	 CR6uPNwvC1D1qGtuUiI3TkIHjhW76j8Tns7adVvjfnmTunOEnKzbgzADzCbqmAxiPO
	 aK/UdUTQoX3JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] PCI: endpoint: pci-epf-vntb: Allocate packed
 outbound MW space
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260803180439.1963864-6-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <20260803180439.1963864-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:32:21 +0000
Message-Id: <20260803183222.654851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Packed outbound MW space is allocated but can never be mapped to t=
he host, rendering it unusable.
--

--- Patch [5]: [PATCH 05/11] PCI: endpoint: pci-epf-vntb: Allocate packed o=
utbound MW space ---
commit 1f91a957de194db5f5786ea1932b0222be01c3a2
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Allocate packed outbound MW space

A packed MW group can use one outbound iATU region only when its EPC
address range is contiguous.

Allocate one EPC address range for the group and expose each logical MW
as a subrange. Singleton MWs keep separate allocations.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index 0c72b907c2896..aa8d304fe861f 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
[ ... ]
> @@ -926,6 +936,9 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
> =20
>  alloc_vpci_mw:
>  		/* Allocate EPC outbound memory windows to vpci vntb device */
> +		count =3D ntb->packed_mws ? ntb->packed_mws : 1;
> +		size =3D epf_ntb_mw_group_size(ntb, i, count);
> +		/* Only the group head owns the allocation handle. */
>  		ntb->vpci_mw_addr[i] =3D pci_epc_mem_alloc_addr(ntb->epf->epc,
>  							      &ntb->vpci_mw_phy[i],
>  							      size);

[Severity: High]
Will the newly allocated packed MW space ever be mapped to the host, or does
it remain unusable?

In epf_ntb_configure_mw() (which handles VHOST CMD_CONFIGURE_MW requests fr=
om
the host), the driver explicitly rejects packed groups:

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_configure_mw() {
	...
	ret =3D epf_ntb_get_mw_group(ntb, mw, NULL, &count);
	if (ret)
		return ret;
	if (count > 1)
		return -EOPNOTSUPP;
	...
}

Since mapping of packed groups returns -EOPNOTSUPP without calling
pci_epc_map_addr(), won't the configuration fail when requested by the host?
If so, does the memory allocated here go unused, preventing host memory acc=
ess
for packed MW groups?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180439.1963=
864-1-den@valinux.co.jp?part=3D5
