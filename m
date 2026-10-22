Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657618;
	b=iL/xsEo97ug1R5VWK5qGVwtvhxx8C+2Guqt2i7YHh2LX0iAPIgruA3QFGXoCQ/RaCmBu
	 RdqGtCJMWk7jkjCDaEe1dmaSscXsgvJGdI4O4mxAFQpvOFMchIUG+QoATwREg3Q+bLrpl
	 gyB3zRR+cSvAIRwIF34vEQQcTVBJYbB8PFve+4r1fHltIv8hddOrMOTxxfBTVBtuO78Hc
	 ah5qc//SCiWPt9958wlzqQFWbgKSlh4ujmdFEibBxMSgSYJjPEmul6mH/cD4kavq7l227
	 ayV+Qg09NIUQxjWZGr1spdZqrNK0EV1YvR8t8B4EqXSIZmiuthlJ0Iz2UJfiyAYmu8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657618;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8n4VkmuSYYlcKcyX585ItP+ihAkgOaiUHn0+jv7e+AU=;
	b=XKAdspT3foeH3VD/9U1qRlTtHprQ/txDsNo2+PZz/9FwaIUNUXTzF6K9b2+cFLrIKKTX
	 hNq+gbmt/0E3XH8yayoYPFwm9HGBIZ0ng3pI8FtAkj+Cv2ZNwXkmDCq2goaUlxHBmeS+I
	 EktF+eImthVHMU8qjHrCMn6P/DGRngLsSv/i58AL2bBhNH10Q5VuIe8HcjwTG47OozpbB
	 ssWdfbE536Bex8o0CrT3GW55UumIrwI2z10Vo6t2sW6fXaTVg1nKWMGP2DF6pwsX1fz4o
	 3La0aWAPNKo2WEbWV0RvaWXBL6ax5dn2zPQqXwFLJHdDArOyA0AJxnAwoRIc4y5+pOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6DFvtCn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2880A606A319
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6DFvtCn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865AD1F000C1;
	Thu, 22 Oct 2026 08:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792657617;
	bh=8n4VkmuSYYlcKcyX585ItP+ihAkgOaiUHn0+jv7e+AU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A6DFvtCn9dQ0KtS64WMdQVCvRJCFIBKGsn5a61WbB4/32JWL6Z2jt3QfPVcfSLncY
	 iVbwVnWXotXcADuVXbKDIFawTrrIhDIDAqcWH5ez80rNEzNBO4CIlrfmlaFo9X9jYT
	 7kI3OuLkBPA8g+c3zYrn4rBnwkHLVGkxA8JU6KwVbdT3NW9SflDaXyQz3NwcQVKG0+
	 AUz5tf+2Pb0QNDJNfOAwhOe0hf7NsBXhblBddUSLh+TcQq86V/wDj6cOa/BZjwtzT9
	 sMfeNx5nm+Lq++kyoq5oaDUm77qtmZzpuLLFhbMVCuIGV22BOsIxJqRz3tOFr2fdDI
	 w8pbS4xz+Mbrw==
Message-ID: <sashiko-outbox-181165@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/10] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261022082230.3164834-2-den@valinux.co.jp>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:26:57 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Endpoint functions that export controller-local DMA channels need the
> controller register and descriptor-memory layout.
>=20
> Add DMA control and descriptor-memory resource types. The control
> resource carries the register layout and channel counts. Each descriptor
> region is associated with the static channel ID assigned by the local
> DMA driver.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022082230.3164=
834-1-den@valinux.co.jp?part=3D1

