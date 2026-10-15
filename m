Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AB54705B
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035458; cv=none; b=NmQBmmhjYL8o6MIgcwXnSpY0Vi3zmnljL3Zjpu8zwx8reNxSY36u6kb9v8JKXx5Je8EwahvHHLmFMjPFnCP0H3AIHhFV67awb7e6UhGc8DiDS7h+OiYUpHmPkRtVWwxmeLURSSK5vVwB5af1nDdiHa/pxrckv54LL4oFpqpfqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035458; c=relaxed/simple;
	bh=NCloyeUmhkv/Qhl4m3k2xCEOIaKM5dTsKJvZgpMNQlo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HdRdtzB7hrJ2ja1G7DLFL4IbXPhvi/T9GPL0aQ/PaiR/+cOT3fO7qpQsXHrxuvFHU2K3qioyMtvQhokXqGv8u4px2cnqrQmr/40QfSeJMJ8JERNfBBxSSc+j4QPSgr/f8oHkLQTgp4GRKFDbsMkDwyqMDiRlM90vTK88OzwEsds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBS7Oeq+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBS7Oeq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0671F000C4;
	Thu, 15 Oct 2026 03:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035457;
	bh=NCloyeUmhkv/Qhl4m3k2xCEOIaKM5dTsKJvZgpMNQlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iBS7Oeq+nQ9yxM0WW3gWsCZ51R8kln3nevSweYHiedh+LddNuMmpWjKypGkqHIL4a
	 84v7/ksyo/7B13mQf9p34VTd4Kb+PimjAMkCE5eukB4hsl21Pt2kJ0tZX4oM4MNdBk
	 lFR+9QCD+l4Okz0D06rgR/D3EokBMxDVHahR2g5MQF7MgtifboYcoq/BxVoHTOMZOD
	 CkMM7IVXO6Tavv2M59XBHQaZP9nQ4pU/XentKWibMr1jfuJ4+hXQeAlg7Vk3R7Vj9S
	 MhLvDcSY6B9xWaJglsk+Xkbu+VOLGgJD6xLdUkSDgdmM+kMZAYqAWyeNDLea/AQICz
	 BcdHiu7SDHvRw==
Message-ID: <sashiko-outbox-172206@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/18] PCI: dwc: Export dw_handle_msi_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-6-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:37:36 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Not every platform brings the iMSI-RX interrupt out as a dedicated
> line. On spear13xx and keembay it is a status bit in the SoC wrapper's
> interrupt register that the glue driver has to check and clear, and on
> dra7xx it shares the line with other sources the glue driver has to
> demultiplex. These drivers set msi_irq[0] to -ENODEV so the core does
> not install its chained handler, and service the MSIs from a handler of
> their own. spear13xx and keembay call dw_handle_msi_irq() for that.
> Both are built-in, so the function was never exported. dra7xx can be a
> module and has an MSI loop of its own.
>=20
> Export the function so that modular glue drivers can use it as well.
> The pcie-rcar-gen4 driver, where both situations apply, is the first user.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D5

