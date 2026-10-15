Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC44391822
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035548; cv=none; b=mb8kK4bDR3PIf0rz30oABypQQpNDmLxl0r02xWgrvjAt1xofMecbNFqB69Qv5VKiZ+7rLd5C2hU5jnzZp7+yOqRTLxpN19PmiZoKy+qZwn/5tCdGSC7wa66jfwH911VtCGaoNHFvIM+X617jHyKEWh9Jt8nqFymiwHAeXlNf76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035548; c=relaxed/simple;
	bh=KEtIm9EKZbngrkl36DfIdNdcO/eC4XLOtE2fPh5K8xs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cgG5Z6cuMAtpq3rL7GFtHHDfknjfgh/4RAd4pDuJNJ1D8jAhCf6aPiVTyMUVMdUeUC3XOB2nG2z2FOfzL8GbLJScZBIHnV1mDpd/+ITKSNZZvFnawwL9hViQukBlrKZfh26zswmm2VjV8Z2uQqLVJiYCVoEkRk86D+p6dVfYt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZRD1vWX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZRD1vWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD5C1F000C4;
	Thu, 15 Oct 2026 03:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035545;
	bh=KEtIm9EKZbngrkl36DfIdNdcO/eC4XLOtE2fPh5K8xs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZRD1vWXlRI2VJ323DrBc1SYokOeG1Wezdctyg2VUuilv25OG5e/aDifJkeYncqKK
	 YfPtzsrnul2IBCMzLd0P6axya9ozsEmGLHS/dykTVWhX0vTZwaLrrInnHY6Yb8eHVe
	 mBf62EyCXsa4+msb3dwWOTBygv9mS3Aqk1N8opBTEbA1nLN7R6iADYVsBQ6Sd1XrKx
	 Db2/09XcByHQVxlHQrrqNJLnNQtNt4nIekCNTNaGAtA+U6EF6IC72l8fcwH6n5Tm4b
	 IBgyOtMbD5Lls+dnTRLm6pB35WODOJWiCB7EtoFLUThb3F+8nb/WXvx2hHPN3gYt32
	 d/TuSods0vFPA==
Message-ID: <sashiko-outbox-172209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/18] PCI: rcar-gen4: Check live link status in
 link_up()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-4-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:39:04 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> rcar_gen4_pcie_link_up() checks link state using SMLH_LINK_UP and
> RDLH_LINK_UP in PCIEINTSTS0. However, these bits do not reflect the live
> link state. On an R-Car S4, after taking down the endpoint, a link-down
> interrupt saw PCIEINTSTS0 =3D 0x20a000c5 with both bits still set. Even
> after resetting the controller with the LTSSM back in Polling, they read
> 0xa000c5, still set.
>=20
> As a result, dw_pcie_link_up() keeps reporting the link as up after it
> has gone down. That defeats the check in dw_pcie_other_conf_map_bus(),
> which is supposed to stop config accesses to downstream devices while
> the link is down, so such accesses go out on the dead link and stall the
> host. It also makes the callback useless for the link-down recovery
> added later, which has to wait for the link to actually come back after
> resetting the controller.
>=20
> Keep the APP link-up event check from Figure 104.5 of the R-Car S4
> reference manual, but also require PORT_LINK_DEBUG1 to report the link
> up and not in training, through dw_pcie_link_up_debug_check(). The
> callback then rejects a downed link even if the APP link-up events
> remain latched.
>=20
> Clear the APP latches before enabling LTSSM to discard events from a
> previous start, and only read them in .link_up(). RC startup uses
> dw_pcie_wait_for_link() to poll the combined condition.
>=20
> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller supp=
ort for host mode")
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car V4H
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D3

