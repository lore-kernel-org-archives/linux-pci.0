Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A236415F0B
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 05:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499901; cv=none; b=HPxsNYPyjda0zGCKqMHZsF28LLgGNdPPbI5ESj96/DCjdQKE0B2CzvivX9edCqo1iRTyhtgQze7MVfGqiJ1j2wqa/Is1yQ+Zf5aSjro7riAQvnt/+1oTmaYVxOaoatFADQkFvy119rLOkMwQOlHMqjsRqG48R3sUK8IAJlXo4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499901; c=relaxed/simple;
	bh=PQ0LSCC8CE7h+rk5S4lsrRjkR+4vvL8vOmkINlKt1j0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LIxt2l+coomKqf/RI/jnHMPGiQyvjV9DTCBq2Nn+wSOyAzVS6oRMDz5erDXwEfrxiY/eG0u6pgRxz2PCSpfpsI5j68fmxKlRa3ntG9ouHu0pHj0EpDDXYvxyeOHPsx7Nx1llk8QHZ2jWzVhtxmbNVg8WnkZNx3GnC8RXkZ8uikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTkBO1xN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTkBO1xN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9D91F00A3E;
	Fri,  4 Sep 2026 05:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788499899;
	bh=8Doe9iwWp0Ky/IVaqjxyyXCP3EZGRKs6wVdlfbkGMv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gTkBO1xNq1md8oRKI68ZUVjlG3MMWjKyXaT0F9B4V9DBVJ1hb3qSukRDR2WXIpYXc
	 FXokRJz1aYgpdpm6QFwPlwn3M+cBWfYmVfCFT1wq8yVH94KM/vP0tjt1Yydil9a5YI
	 2q5Vesdk4cZt3htgqxpkb3+Gv2mkQQ7MFrQfOIEBAcLT3S98si9UW7YFerR2JVJ3xw
	 aQM3GhzAKqcsn3Ygm0Ik3XWZFz8gxyeHrPUFERCge7It2qjfEWtoFmGiyHn+b9RRmA
	 +q8tpv5DM/kcvYkHKW2cdIL34QQp9eFpdVRsAzr/nrrNBDFMJ4QQpW6/ytpMHHTJmR
	 ZG5K4Ob/1eYHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] PCI/ASPM: Add pci_aspm_inhibit() helper for
 temporary link state suppression
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260904-pcie-link-endpoints-v3-2-4b9a91bd4b35@google.com>
References: <20260904-pcie-link-endpoints-v3-0-4b9a91bd4b35@google.com>
 <20260904-pcie-link-endpoints-v3-2-4b9a91bd4b35@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 05:31:39 +0000
Message-Id: <20260904053139.AD9D91F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, pci_disable_link_state() permanently disables ASPM on a PCIe
> link by setting link->aspm_disable. However, several kernel subsystems
> and driver operations require temporary ASPM inhibition without
> permanently disabling power management:
>   - PCIe Lane Margining at Receiver (LMR): receiver testing requires
>     the link to remain continuously in L0 throughout the test duration.
>   - Device firmware updates (e.g. NICs and NVMe controllers): link
>     latency or L1 transitions during firmware flashing can disrupt
>     device communication.
>   - Secondary Bus Reset and link retraining sequences: prevent
>     unexpected L1/L1SS entry during link reset and recovery.
>=20
> Because pci_disable_link_state() cannot be reversed by
> pci_enable_link_state() to clear link->aspm_disable, drivers previously
> attempted manual manipulations of PCI_EXP_LNKCTL (ASPMC). This
> [ ... ]
>   - When all inhibitors have released (aspm_inhibit_cnt =3D=3D 0), restor=
es
>     the configured ASPM policy to hardware (Upstream Component before
>     Downstream Component per sec 7.5.3.7 & Table 7-24).
>=20
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-pcie-link-=
endpoints-v3-0-4b9a91bd4b35@google.com?part=3D2

