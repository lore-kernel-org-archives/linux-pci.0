Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995336;
	b=waTvqCQRPS38f1FWpfHANpxoqqrFvQuac1J0Lk8c3wkXMoF2gy8Uhc7XsDBmCXALuOj2
	 0puctdhRGqkqRfoV6FLIfdWUwvmtNFOKWgTO0DsPao9r9eG9WOmHapZvnMRPFHVOrjVGS
	 YLeJJtJBUgrSgBskkYmtzVuQImfffrTD8lBn3Y4RH7K3GlB6+3Rvt/oRK2Plk9Wq+Ox60
	 L6tElivlJGuoXDOx0mHuC2plD9fYYxHRF3wKwVZY88BkA67dlypABokH7f12Grk67a+aI
	 InLzgf/9LmRbwqK6n3j2rYzcyfVcJ8xyk2shg09QrPyCLkf9yvcu6f9fawIeW1qCj7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995336;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IULhMVDG2hJUiDeMU7QJbzvXSqyYqkRs52ic94b9ivM=;
	b=ZBZhfRgUf6tFhqEqxI0AYezMs6bpz2ztoezn3nF0ctM69Ph+7Fj0fF44LIfxwYKUjzU1
	 wKTTgqABXjpJBpqxbPCFm2i+Qdcp0fOI7/8WqSIjzpZ/B3pr/US/bPumAoxncLveC2fzk
	 2ARbicslUATAmV32ic4iL1bI5cpXXbVfy36QTDmYoRF9P1hra3buRQjpHdKlUGq+iqMv7
	 0RCCp9PEBPSgWFwgeUEsaEATpo8WWxbtM/1tdGWzT1IXd5k1yRlYqdByGpnFByD0WZnx4
	 GliVjHYsOAlWGY6K3bjhw+5jkXVivcIAHEabQgV+FG+LiIUT5QYNmhr38EKgu9n8GSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSG5NVi3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D62606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oSG5NVi3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72281F000CC;
	Wed, 18 Nov 2026 09:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995336;
	bh=IULhMVDG2hJUiDeMU7QJbzvXSqyYqkRs52ic94b9ivM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oSG5NVi3ZKcZ2A8MfWOPKAjYhhmQ8ez43hUUijwEwYXdLWTqXaxLVPwhtYxP+uwYm
	 0ZTJ3oZUkJQV47O9P5tAyRkDnklQL1gz79AxRnCQUNIlXmLLjcyCXseam327+5qHg+
	 s0M6Jqq/8wAvhEFhvvTfhaE78k01XwHJjhl1IMR02bETRiv+vkLWTOftKFBqxE5Xe+
	 65fH8HmrBHEThi5wNsxG6nZrqTTqK7fzBFJAL/y+sw67GqYQYhp3CTJk/ujfyZsdgH
	 mkZygxhs2vXj1AWseVQNdE50OtsVsRp+DC4b+ZJydRxVrHbPTYsaDKZko0HbOR4Sc+
	 G2rZMZkRb2mMg==
Message-ID: <sashiko-outbox-220626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 04/13] PCI/TPH: Refactor pcie_enable_tph and add
 requester variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-5-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-5-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:48:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Refactor the core TPH enable logic by renaming the original function to
> pcie_enable_tph_ext(), which accepts an explicit requester type argument.
>=20
> - Keep the original pcie_enable_tph() as a compatibility wrapper; it uses
>   the pre-cached tph_max_type negotiated capability automatically, so
>   existing drivers calling pcie_enable_tph() require no modification.
> - Export new pcie_enable_tph_ext() to support explicit requester type
>   selection, intended for use by the upcoming VFIO TPH series.
> - Add requester type validation to reject values out of hardware negotiat=
ed
>   range or invalid reserved types.
>=20
> Update pci-tph.h header and CONFIG_PCIE_TPH stub inline definitions
> to match the new function signatures.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D4

