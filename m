Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F63B4E9A;
	Fri, 19 Jun 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888703; cv=none; b=T4M2hhndXM0nh6mjFaBo7CeWrCXgSpXFcvP64rLTIlVtV/s7wOwmScC1jCTeWdtRzsLKrtiUk0AbCAxiKAx68BfHP/yyTkUJM5zm/Em0Ai9EQlqCi2/4KIBndIiia9LqN6vhDS2Q7JAevCBvQhcNBiN/cY2BM3EyeVxseGv+RFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888703; c=relaxed/simple;
	bh=HkeFeRTWOk4VOrJCSpjbq1rbFgylJxEdA96UbntTN2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YL+zuehhSpsfG+a2EI7ZBz2CYpq2z8wtQ2GCdiRjBJIQq4el8fbHpSIhGuD2KRDEFqxoUgSy7snTc0ynjiVC5/Fm8tG05RAnvkrdshJXhkupda84S0n3jBhFYpSs1klLOIIZw5/6rK1LroSIFDRY9tTL9vo01bQj2c4dyxG93HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv6xr8WK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv6xr8WK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575281F00A3D;
	Fri, 19 Jun 2026 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888702;
	bh=HkeFeRTWOk4VOrJCSpjbq1rbFgylJxEdA96UbntTN2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gv6xr8WKeGiiMk41Fk3VCaPN3dOrA7zLo3G/xXjk68pQutAxbFmAWLnxgH5BAamU2
	 W/BDK1ktqicPTxt5NCQuGnMq8ynderdyKlNnDoNCGnhFctTVOpQKcNE0A7fNkYikFK
	 5ZVGuP1kmZP/eLCcQWe7maSnWxQWr3Ze70GizY3JU5iWChGZr9UP2oirBjRbrCu5Ud
	 uxxDMLD0x06op4Ot8OcUek4x4PRLUdASbbqdSCTRnsrw2AsvBrfCeHjzoACa2Tjzd0
	 1R+t+2UKf4hqL66vbnBVCg93aMG5SmXZ8k6MC+rQWNcIncgVBRUGCfB9i5IaYvYZ1R
	 RpMghq5UDrXeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] RFC: rust: driver: support map-like syntax for ID
 table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, devicetree@vger.kernel.org
In-Reply-To: <20260618-id_info-v1-10-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-10-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:01 +0000
Message-Id: <20260619170502.575281F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The device ID table and its associated info is really just a map. Add a
> syntax to `module_device_table` macro that reflects that.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D10

