Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778121;
	b=dAEisHA8uIwAx+vjn6GjGoJRy7PXjx5iDpQge6yurxj/O1gjH1iVHLqRtjbcynZGF4dN
	 d6W473Q11yqV8IV/JGkpqmNs54cySNQWcWGSP5fGRYHO/4UU3txkJI+xGPsTnJZkIgpBY
	 YaajdZwmiEMkpzzYrsJJtZ57gxjxv9iHL0wN1M5JMHKGffVvAVlpFZPoSuuxMpyZch4wR
	 KKxyi91FcenyO2G7/+wXZPnEXrIQhLZVfZ3cz862LxVNur6wpsIj8cWskhrF7BtwaM3EW
	 GhOlRj42m44XcvjESKAYnhR3q9bkRoU8MLJPsKylVnSYa92Dp9EQlRTVmx1a3KiLSbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778121;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9lze4BcktKCXoOAxLRSh3evuV1ODEFzBfiqGiqkfoDk=;
	b=hVKuYAoXIe4Ig6EMwazl/SD/+en/W+2pN0UV61F68qYdpceirR7ZcI3T4OirXwSHafCu
	 1bx997COLN4bFT7ITGSLNFZbYHVYMR5Fi9N7LPO7vP9laZZgeo9F3XcDNZ5yf5Qv0jrKM
	 9PpeILTr6uvP6HYP9BZrEp2UupotZaCidfAwA7kb2RXIxm4/phyLUJo9W9N6YkuHe6zG0
	 KVjppuNjQTeCZfF7iSchUM3zwCvMJXnaWnDlwHxj+a6uPeIY8QJhvaSnoHxlMDRKtY3OE
	 9v9DB8Xg/9Bu//3znFbdhzD9OanwZAmHvG6ne7Qwdm5xUYKw6PYyrVENcuFP4H9ucfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNRZfLgz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031B9606A31B
	for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNRZfLgz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A8D1F01829;
	Fri, 23 Oct 2026 17:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778120;
	bh=9lze4BcktKCXoOAxLRSh3evuV1ODEFzBfiqGiqkfoDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HNRZfLgzSfUSwjkArlyGcIhw/u+asMbP628sy39jIFqENk3+6sOZ94Nv6R5/wfqiz
	 CzXy0+QsM4BHiB8qLAn8u/hbkmSQi8XD2WG4hSqvZmMDQpH3uP3Pc7q/+BMiZjdTiT
	 t6tJVJRyGzlocEdACaJAi3mfIx3c9KnTEL7Q1JuIkof+GqmNYPQC7Vs6r010NmTh0K
	 +I4ktH1uZYc2eWnVPdMOGUzNExCUF8mS/J4dWCn26Uo2HtfjD2Ur3f1GlWHIyiwbA/
	 wpGWXJ5950USm9cVn28sBxMkQw350VIEGKQE83ftBQYqwKIOepE9S/a1dmwDB9ZPMO
	 mjX2WAZW5HsPA==
Message-ID: <sashiko-outbox-183023@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Disable LTR on Qualcomm WCN7850 [17cb:1107] to
 allow ASPM L1.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Ruhier" <aruhier@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261023-quick-wcn7850-v1-1-9a139b9b2c8e@mailbox.org>
References: <20261023-quick-wcn7850-v1-1-9a139b9b2c8e@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 17:55:20 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Anthony Ruhier <aruhier@mailbox.org>
>=20
> The WCN7850 Wifi/BT card, found in several Snapdragon X laptops, never
> enters ASPM L1.2 when LTR is enabled. Its firmware reads the
> LTR_L1.2_THRESHOLD set at enumeration and reports an LTR value just
> below it, so the L1.2 entry condition is never met and the link stays in
> L1.1.
>=20
> Windows does not set LTR Mechanism Enable for this device (verified by
> dumping the ACPI tables), and the link idles in L1.2 normally.
>=20
> Replicate the same behavior: clear PCI_EXP_DEVCTL2_LTR_EN for WCN7850 at
> enumeration and again on resume, as the LTR state is restored there.
>=20
> On a Lenovo Yoga Slim 7x (X1E80100) this allows the link to reach L1.2
> and reduces idle power by about 70 mW.
>=20
> Signed-off-by: Anthony Ruhier <aruhier@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-quick-wcn7=
850-v1-1-9a139b9b2c8e@mailbox.org?part=3D1

