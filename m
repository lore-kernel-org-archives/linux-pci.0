Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905679;
	b=XogTsqeGNEis0ldSMJokj31KG/E4pFaK3agTk+HUOPwakKvxZmhCt3Y1yxuR2ixJnib9
	 YySI43HHCo3636EOUttbXtBLNEFok4L5fOk6JewOwKlddcfp/VZG6UahMa0BCTlKWeteq
	 qBDtLNj4bl6+UZKEf34oMrghNOwKcLlR8nVfvKkVFNeLoVGRGX0gibV6QSomqbpe/kqST
	 mGe1JFS+w3gTSDRCeWJHJ4zyiLlC0yorb/ydfhNfX4p+90oosCydZWITUE9rqX4Xxlq6e
	 y1r0lnmAsRNLJpaAGR3VsiDNGGvRTxTm0nIVeO/PVN/EngbcnZLI/eCrlNQoXPDAIRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905679;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/UsFuyEdDPfwtBO/4cSPYK8tfis6XQpeM5tWMpsytrA=;
	b=tzE0GjTh8kBFHau9FXz5lDJoYXFAVZE/7uWV+1FN87LKSlbLXAnzN9BqTKwYTXvGQhq1
	 1T7nDfAK9aGKSQaOE8JEIbl5L3ZVfeSbEtyWyuotCyxkcGpIhbRMgXtqcxQ6ox6AaJ0Df
	 psiVCsPcbTVerXCq5UD2t+pPyS1qmujSgPbXF1V+gq+euEjrQwmZDIaA6XigIwT0XKBol
	 cSrZdwHolCiNcrA6Fo/oIEnOtK2/IXu3VBn5NnPr/EY5//M1HOa3cdFef8XJ8tKjU+4qK
	 pC0aEybl6GSzFNvb08xkcMfqFkUzbEEL0oW7A/HVmwfZasydvHqB/UOzQX10Y9OweoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+Ifg3jQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D98606A32E
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c+Ifg3jQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD40F1F000C1;
	Thu,  5 Nov 2026 19:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905678;
	bh=/UsFuyEdDPfwtBO/4cSPYK8tfis6XQpeM5tWMpsytrA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=c+Ifg3jQ+P992o+Cm09Yorr3NXe9J8RM8ATzjQbXREYnM3opIOf5GOLbOXCMgpSKQ
	 iQF0I8WPn7svvB7GzD8SSuHXTm737Qj+oYxW0GtrzCinK4DDNnAnG3A02imlFkn08T
	 chRkP9bxyOC3zoGlyzNjQxAipEGNO7fVQyv5hfRHEyviLzkLuqAuZ8x9NssXR2TpZN
	 F+xG/GG8trSTAho/p/nXPO/ekiMRKaQ0l/+6I1X7Knv4A/Oq17EFY+8nX4eZeaUIRp
	 hQ7NXH/jSCIVcTHYJmLNtkzTlOmg275tJh4q4+zUO/759w/FTRiA/4iI73x/gUYv+i
	 XMh/TROIWJQBA==
Message-ID: <sashiko-outbox-199812@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 06/19] cxl: Move HDM decoder helpers to built-in
 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-7-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:07:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The PCI core will restore HDM decoders after a reset, possibly while no
> CXL driver is loaded, so it cannot call into cxl_core.
>=20
> Move the HDM register programming helpers from hdm.c to hdm_regs.c and
> build that file into the kernel whenever CXL_BUS is enabled, including
> when CXL_BUS is modular. Export only the symbols that cxl_core uses.
>=20
> Keep the DPA lock assertion in the normal decoder programming caller so
> the register helpers do not depend on cxl_rwsem. Leave cxl_rwsem in
> cxl_core until built-in cache management needs it.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D6

