Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA05242AF82;
	Mon,  3 Aug 2026 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781405; cv=none; b=DQ6ilpxVhwdk0Xm5nI63Ce8n3Foely089WkqLVhacDyAo5uKrkfOXIDXMD97kU/tTmBzz0mMVNyzwGPOPpc4U6ih+surqOieLGnTiskwpun3pwV2ogGWfU4n6Ov/f0WB5tkovcmn4ztjwUmk90R19Lf9leOgHV1w97axy2q/5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781405; c=relaxed/simple;
	bh=RJc2SOkOJGnRhosFcNNnexw85RpkJP5N++AJsl4mFq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H8sqK/oVgtZ+xets5Rvj1I1RmovuT7iHVoZzNhkl9S3bHs8A1z3KWRhaHT0eu6rop7ilce+5CPE85b5Vc8buleIlowgY9eAW1+XORN9jBwCn0Lv1F1alezNOPzJajuFWxY90GWHiCCT+ihTGpon0RIw4ZcUL0SDXASwUdtPEFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKHwkypR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKHwkypR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5901F000E9;
	Mon,  3 Aug 2026 18:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781403;
	bh=pCHGjCtpJX5juM+8xMz0E0ffjjocJUg4ZNdPxBTrPHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hKHwkypRR4AKtrgESjYyVDH8g42kKo7y0S0fAsa2c8OBCB0O0MavkUYd4fHTJvujX
	 L2U49tMrLOCvKDnuCwdEN03/DMisnT2WIig2bB/Eb1i5ASUOeJkptdcP8VLXA2xuYh
	 zme0nVx1biy44g0Gv7VpTDgimxu0qvR3F+BwwPFn571IXW2KbEIbMNgyu8G+Ur4gtt
	 UZfVNhtBLjvhHI8d3gOiF4mPEGjeZfRNxlUm7EXEs7nGVBMiT6xUl9IDvn5gQg/wKU
	 NxVDUTVWYajift1KYQv0hIIQisOlT2YfKXvfbkUTqS0I4Hw75DtTFJHLK02LU08H3K
	 PcNLfa7L+YzAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] NTB/msi: Require a singleton memory window
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260803180439.1963864-10-den@valinux.co.jp>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <20260803180439.1963864-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 18:23:22 +0000
Message-Id: <20260803182323.4E5901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Error Handling Bug: incorrect memory window index cleared on rollb=
ack
- [High] Integer Underflow / Out-of-Bounds Read: Negative index passed to h=
ardware driver
--

--- Patch [9]: [PATCH 09/11] NTB/msi: Require a singleton memory window ---
commit ed42871f4aa60b4cc0fd8192c14055c9e382384b
Author: Koichiro Den <den@valinux.co.jp>

    NTB/msi: Require a singleton memory window
   =20
    This commit adds a check in ntb_msi_init() to reject NTB MSI layouts
    where the outbound memory window does not form a singleton translation
    group. This ensures the transport driver can retain non-singleton groups
    for data use.

> diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
> index 6817d504c12ac..029edcf400784 100644
> --- a/drivers/ntb/msi.c
> +++ b/drivers/ntb/msi.c
[ ... ]
> @@ -42,6 +44,21 @@ int ntb_msi_init(struct ntb_dev *ntb,
>  	if (peers <=3D 0)
>  		return -EINVAL;
> =20
> +	if (ntb->ops->mw_get_trans_group) {
> +		for (i =3D 0; i < peers; i++) {
> +			peer_widx =3D ntb_peer_highest_mw_idx(ntb, i);
> +			if (peer_widx < 0)
> +				return peer_widx;
> +
> +			ret =3D ntb_mw_get_trans_group(ntb, i, peer_widx, &first,
> +						     &count);
> +			if (ret)
> +				return ret;
> +			if (first !=3D peer_widx || count !=3D 1)
> +				return -EOPNOTSUPP;
> +		}
> +	}
> +
>  	ntb->msi =3D devm_kzalloc(&ntb->dev, struct_size(ntb->msi, peer_mws, pe=
ers),
>  				GFP_KERNEL);
>  	if (!ntb->msi)

[Severity: High]
This is a pre-existing issue, but does this code properly prevent a negative
index from being passed to the hardware driver?

Further down in drivers/ntb/msi.c:ntb_msi_init():

	for (i =3D 0; i < peers; i++) {
		peer_widx =3D ntb_peer_mw_count(ntb) - 1 - i;

		ret =3D ntb_peer_mw_get_addr(ntb, peer_widx, &mw_phys_addr,
					   &mw_size);

If the hardware exposes fewer outbound memory windows (ntb_peer_mw_count(nt=
b))
than there are peers (ntb_peer_port_count(ntb)), won't the subtraction
underflow and make peer_widx negative?

Hardware drivers might fail to validate this negative index, resulting in
out-of-bounds array accesses and likely causing a kernel panic during device
probe.

[Severity: High]
This is also a pre-existing issue, but does the error handling in
ntb_msi_setup_mws() clear the correct memory window index on rollback?

In drivers/ntb/msi.c:ntb_msi_setup_mws():

error_out:
	for (i =3D 0; i < peer; i++) {
		peer_widx =3D ntb_peer_highest_mw_idx(ntb, peer);
		if (peer_widx < 0)
			continue;

		ntb_mw_clear_trans(ntb, i, peer_widx);
	}

The unroll loop queries ntb_peer_highest_mw_idx(ntb, peer) using the failing
peer index instead of the loop iterator i.

If peers have different memory window counts or indices, won't this leave an
active memory window mapping on the NTB hardware for previously configured
peers, or potentially clear the wrong window?

If the driver later reuses the uncleared memory window for regular data
transfers, remote memory writes could be interpreted as MSIs, leading to
hardware state corruption and spurious interrupts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803180439.1963=
864-1-den@valinux.co.jp?part=3D9
