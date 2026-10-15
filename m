Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D3357CF7
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035442; cv=none; b=S5Cfrr+X8WoixsadO9MiAEqSbKWgWKSzvzYBjpx56Rxal9Q8pEeof9ZoMt/w6YJAmWzBX0sDqV3loL0xCKsOl2sxYSmba/UZkp38Ah0iFN/nBx10Fm7nAdITvmKJWSiGWxUN8hW5Sn5ETwnI0x5Sn8EBF6YQuIBjrVCqa3q86K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035442; c=relaxed/simple;
	bh=V2oUOP0NskXnRGcn5nxyMrKqEdIMrXsXDCLlOmMHYUQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=q3CFCklHgjgTX97bHNh8sqFeRVXSWSZJsY9pHQDfKzV4VJ9h4RpMINFW9cgOamG/riyvZMgPhefuZy4KExFPU3q2BWHlFnIZcx7EiPPReCc6j2yn4qhJzB8vVIlDhjeZgbFEAcXy5RA+1Ia4Om6ynYBsI9JCMvuLCmYGfurBiDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csalmXqB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csalmXqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F391F000C5;
	Thu, 15 Oct 2026 03:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035440;
	bh=WGz+AzQRd6P14dm+fKzbwFiwQrrkdmCSvEtVtVJ1IFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=csalmXqBlYoD/JYuMo0OPAff39znWaRwAX33iy2zxKaWq8lOwlAMXt2ajOayTxsFs
	 f3tC0y6qKkXP19O1bMbkjLP4Arx/Cs4M26WpqfZPDNsGKPUAayOldGX312Pk0QEfSA
	 6MWf8Oo46PY1sey5cGsLk84e1+vjvCMZ2J8xDiTLgKZWMf3e7rh/jizTqDQg4s2oUh
	 aiUm4FixoYIgaVudaZ+JyrQRzBaPuG8DvBFXXZ8AQn2zersnt+CyIn3VkxHFO80E2F
	 pZ+0rdVgXIeNOUnLQUX5hrzX625b6pXWkbDKnAAbUWzGSWtFjh+7DdXaORh9/Sfzk0
	 A9dod4yXN2aHg==
Message-ID: <sashiko-outbox-172204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/18] PCI: rcar-gen4: Separate hardware setup from
 resource acquisition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-9-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-9-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:37:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Factor out the hardware setup needed by Root Port recovery into helpers.
> Recovery needs to reset and restore the controller while keeping its
> clocks enabled and the R-Car Gen5 SoC PHY initialized.
>=20
> - From rcar_gen4_pcie_common_init(), extract the power reset and mode
>   setup. Leave clock enabling and Application/Local reset control in
>   common_init(), so recovery can keep the APP registers accessible.
>=20
> - From rcar_gen4_v4h_v4m_pcie_init() and rcar_gen5_pcie_init(), extract
>   the SoC-specific register setup. This allows recovery to restore those
>   settings without taking another clock or PHY initialization reference.
>=20
> - From rcar_gen4_pcie_host_init(), extract the Root Port register setup
>   and PERST# release. Both paths need this host-specific sequence after
>   the per-SoC initialization or reset.
>=20
> No functional changes.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D8

