Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208755;
	b=RLAFKBPTnn6rQ9+hDA4NjdFEPT2DiMDYbLgoLMx8+LDfbBOyM5Hm+2cxhTlb0KA4jegi
	 5iHTnQ1kPkRdy8I2vofgWu0/DTgtNxvvs/W8RUU18GRGJxHSk69vAYng9wMJtsmPYUtH7
	 rmXNDxZ9L4LheLuXgbwIku2ZpftTz7H/JTk+g1cA67ErVDIrlGPCqWHgn08GQ5tnv5nOV
	 Poq4eLQ5fSXA2lhRYwpO6ATp9zIETgSwbcPQ+ebv2o/jMe+b7I/p04D95ZVAUda2oDdMG
	 AIR3xTSTs2Yrnfzj5TZWn1nandYVb9pCi3PtnlI3T/v8Ei/nUgo6AVOyIoj6oI76m6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208755;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FW9M1RckeRREuYWW9Mhe6NTjvgkHN7zriWcSofbLRBk=;
	b=bGXkRKXl28GeOcIGkxSyhTUvvEAMUaNtVv2+Zkk4Btbn+vs3EP+dRGa5ou2eHJMVXsaO
	 VkFzlbE3VOe/wY1gXds9lgbmCLIlKpBPA9h3w/LQd/4hm3QZGv7Kk7ZZe6QqKIycl8IPJ
	 51hna8IeRPmDthfP29u+sAGPIrgzCLxfyLbrs9/Fz6Yl3D8fXT074KVtGltLHVR7iPPgl
	 wOjbnurRmcY8tPKsXF5FbXjs4+oCNfXrW72s0obN4WqX//dKy3mQNRDP/W/bTGNmA39iR
	 kYJRuPvpK/Z5tROmOtz1RZdEJyzhsc/ED98rBWtXVav4uN25tzyotxJevyx5ijT7VwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDQuB4O2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8D606A31C
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDQuB4O2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518A91F01825;
	Wed, 28 Oct 2026 17:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793208754;
	bh=FW9M1RckeRREuYWW9Mhe6NTjvgkHN7zriWcSofbLRBk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DDQuB4O26KMRsPbtUbMd297DXGQAsFsLWz2dfTuYInD00Y4u8e/sgEZ/XDjM2FYUV
	 uTV5nhNITvnCX2siqpB5/RXk+ek2aAlFLVeIk6C8yr6KJsJirY8Ib1a7aoS0a7Pb8j
	 Cnsh8isTLHXN9NGnWwB+dnpCRPWIbcpC9YpVee5BL17AxJB4Y4MCme5Xo8ZUq7t4Rm
	 kjJbhJMSKJxsdAKZjk+xfcMK+KYP+9Jufc/DJq2ZwjizeHtKzhvSBlU2xNj5g3Gb28
	 we6RWcUvaRtD29tbXfqN8ACNrQVm9u6ucHC9EQn0oBkJm/GhAkePNQR8DzUu3VODx4
	 untELu7B96Vyg==
Message-ID: <sashiko-outbox-188238@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: rcar-gen4: Inline
 rcar_gen4_pcie_host_perst_assert() again
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
In-Reply-To: <20261028172133.20903-2-marek.vasut+renesas@mailbox.org>
References: <20261028172133.20903-1-marek.vasut+renesas@mailbox.org>
 <20261028172133.20903-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 17:32:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The rcar_gen4_pcie_host_perst_assert() no longer has any purpose,
> inline reset_control_assert()/reset_control_deassert() back into
> the rest of the code and drop rcar_gen4_pcie_host_perst_assert().
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028172133.2090=
3-1-marek.vasut+renesas@mailbox.org?part=3D2

