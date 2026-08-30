Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A323504B;
	Sun, 30 Aug 2026 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788103966; cv=none; b=TlnPIHf3Z9YzbQaPvwhAPXQSaqmzAUiAIXoMCtIeHQfFkQfFwF4kjcTHmioyimzYDEXjO0oszodmViTD4mYjf53lx4ODucJUPTvXf162YjPWG7cT/oGpFjSK95TNAR7bEfSBrFvOZx7uZXcbY/mVqiuRqhhL7TuySxvW9Zrd/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788103966; c=relaxed/simple;
	bh=KdGEzG45K6trpFsuKE7q/q/rEHNVUpGjlrPvyWyd5LQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gdh5f78KlmvyLMzpzv8TKzsnxmm/YWYk8YLRuUWOWBJsX8vcbgoaTIE74/5CQ8FafgPlWVV+6/9SVzO8HF0Le8YnDoykZQSI78a2SmzqdaFTOUtBBC1tgH1rYM4XYBSlvzlA/ZFa2LkpzWJV1IVPUBL+AC+8TCTjaoNS9sfq5Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoUWbBDW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoUWbBDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6431F000E9;
	Sun, 30 Aug 2026 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788103965;
	bh=aivJ0zOgOMAo/ilxfyE6mFc3gzaEpteEvl9RE+0E6iU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YoUWbBDWtlZETh7aA+cggycI2/D0C4SWDqKKGs+oX8kM0tbb78RpIWuT+9YRWhZdd
	 d0zePZMkGsnfHdtH6oVU2tmMFZlT/FFaHWGd83ChVwbh2rElCdrVxwAZRSNRytCns7
	 rRewd93qML7T0MzNRFa1KgOKwXi8gEByVWKPkX+pNDue8zcimviWq9oHYhReVubEv7
	 UIVvOER0XcSFeJyT6v9a1fGHfqBZVMfA+sH3KcYV7AleVdVlfIodgyGCee7F24zi2Q
	 nBgWC8ATET5oo+uwNl2RdX1AOfaUf4Q78JiLPI0sKJF8HfRVfu1oZzT2i7TYFahBXj
	 izeiokzUg0jJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] PCI: endpoint: Support hardware-owned MSI-X
 table and PBA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260830151948.3547577-2-den@valinux.co.jp>
References: <20260830151948.3547577-1-den@valinux.co.jp>
 <20260830151948.3547577-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 15:32:44 +0000
Message-Id: <20260830153245.3C6431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Peer host can trigger an out-of-bounds read of the MSI-X table=
 by sending a `db_count` larger than the locally configured `ntb->db_count`.
--

commit 295a1c24101afaf6161eaaa30348ba3941a52791
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: Support hardware-owned MSI-X table and PBA

Some endpoint controllers expose the MSI-X table and Pending Bit Array in
fixed, hardware-owned BAR regions. This patch introduces a new
struct pci_epc_msix_layout to describe a fixed layout where the table and
PBA have independent locations. It also updates existing EPF implementations
and callers to validate and use this new layout format.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/e=
ndpoint/functions/pci-epf-ntb.c
> index 5314aca2188a0..f3e0e1b3ffb99 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
[ ... ]
> @@ -505,8 +504,8 @@ static int epf_ntb_configure_msix(struct epf_ntb *ntb,
>  	ntb_epc =3D ntb->epc[type];
>  	epc =3D ntb_epc->epc;
> =20
> -	epf_bar =3D &ntb_epc->epf_bar[ntb_epc->msix_bar];
> -	msix_tbl =3D epf_bar->addr + ntb_epc->msix_table_offset;
> +	epf_bar =3D &ntb_epc->epf_bar[ntb_epc->msix_layout.table_bar];
> +	msix_tbl =3D epf_bar->addr + ntb_epc->msix_layout.table_offset;
> =20
>  	peer_ntb_epc =3D ntb->epc[!type];
>  	peer_barno =3D peer_ntb_epc->epf_ntb_bar[BAR_DB_MW1];

[Severity: Critical]
This isn't a bug introduced by this patch, but can a remote peer host
trigger an out-of-bounds read that leads to arbitrary memory access?

When the remote peer host writes to its control region and provides a
db_count, it appears epf_ntb_configure_db() validates this count against
the global MAX_DB_COUNT (32) instead of the local ntb->db_count.

If the peer host sends a db_count larger than the local ntb->db_count,
could the loop in epf_ntb_configure_msix() read past the end of the
allocated msix_tbl?

for (i =3D 0; i < db_count; i++) {
	msg_addr =3D ALIGN_DOWN(msix_tbl[i].msg_addr, align);
	msg_data =3D msix_tbl[i].msg_data;
	...
}

If msix_tbl is overrun, the code might read untrusted data from adjacent
memory regions (such as the peer-writable SPAD region). Since msg_addr is
then passed to pci_epc_map_addr(), could this allow the remote host to map
outbound PCIe windows to arbitrary physical memory addresses on the local
host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830151948.3547=
577-1-den@valinux.co.jp?part=3D1
