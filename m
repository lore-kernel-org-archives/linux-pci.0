Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104426;
	b=VqOzAdV0nu3Y8fNbNbxG+tc6cm1A2RNcOV7ZF3X1Qlgp4EwjdHAm/RX90YokQKlSb1AP
	 dOilbPu048zKbjDnr6noDwPOYYE+hPK4d9KLJ60J8zmehGWVojkoeMWzXtujleVVOUk2/
	 SYPL376mOI/aR5fZyEyQTIWQGNgT8Zy4aP/hQDgsdjuLyXyil0U4J0h7LT9YEh12DTn6p
	 E8CpivQSscq8IEpqceXaskKW84M7b1LzrCDpxTVgKJOD6aLcpVXUrnHqmL/KI0i7UtIIR
	 j40rLHsc7FGA055EouyP7AqY9tyJgW+5DDxPlZAXSTrI4wjgBW+vtRAUheXCEHl2IWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8xols5ldNZ5hdFs1otm4QbAJy7PRErh+eMpVAb3o0YU=;
	b=q64nfbALBXlp7EXxz03dJgjsPKBXCcI1YSbyYCJzw8rnZwsicH7nv+B09nJZZaDXnG9E
	 BYFmbqefdKdnYPkL/CKWW1uCaCXfpw1aeAHHWK/j8mdyp4VLL4M16QuRjFWKo4bKhOEOE
	 9P9v/uG4w/E13YNPUFsHaot8a67s76ojG6vsCc+bpOswPqE/hTj82fUwnHZc0/2FrEkgh
	 B4sSnqDBt9jBRj0PTjNU01tkxNbf0dj8W/IfiXm4+rEYTnyXgxfUoA85k/L2WaLiwdMEh
	 DBbGGn0mrc+RXDPq/Rde8rplKQof2NFXMHNCAFesP+LDdP1pYIDnI2UpX+OQ+dTq+Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WSIE8cUA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DDB606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WSIE8cUA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F641F01825;
	Tue, 27 Oct 2026 12:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104426;
	bh=8xols5ldNZ5hdFs1otm4QbAJy7PRErh+eMpVAb3o0YU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WSIE8cUA6V/nMKtjhU6L62a9Wv9uMD4OAbOEmNkhiEMdcKWKEdgqBtkYmmYBkEqt8
	 81EFj6FUlkLhkRAo8qwczlODPb7NC+5wfqVseHlJR9SW7+iAnlImg4jrfaVhzcPDNz
	 mFxQOtCbiWTRXTsQ+hLxF2vX6epn1KAqmADR2VsxeorvwFSmZ3Knm7NC4QoyUUekMz
	 PueMnjQFimTf8E/PO5k4PgaCSgj/6mDFqKSQEnuJTgcJDaKXgqaIpCZMna+wR+rsVd
	 kkKUJC5BHi2UBeyCj06fsYkWQ5BpL76xrzwMuKxHC74R+LFJOQd0plvAxIgzJzxJCP
	 Yyv7k6xqttB+w==
Message-ID: <sashiko-outbox-186562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/16] PCI: dwc: Use cached PCIe capability offset in
 core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-3-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:33:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Convert the DWC core users of
> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to dw_pcie_get_pcie_cap():
>=20
>   dw_pcie_wait_for_link()
>   dw_pcie_link_set_max_speed()
>   dw_pcie_link_get_max_link_width()
>   dw_pcie_link_set_max_link_width()
>   dw_pcie_ep_init_non_sticky_registers()
>=20
> These functions are reached in exactly the same situations in which the
> replaced dw_pcie_find_capability() call used to be executed, so DBI is
> accessible whenever the helper performs its first lookup. Because the
> lookup happens at the point of use, there is no window in which
> pci->pcie_cap could be used uninitialized, neither in Root Complex nor
> in Endpoint mode.
>=20
> While at it, remove the now redundant capability lookup in
> dw_pcie_link_get_max_link_width(): the offset variable it filled is the
> one used for the register access.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D2

