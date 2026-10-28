Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157385;
	b=uwJ5hgY/gjRgv/REuQBUhCANyoto26pv+U3XeBxIwJihCGF0j2ozbWi/j8Bg6P4DuTak
	 KcsL5jAdH9CIiaYJfonySVN1lTLaABB2cuvFnco0m8eTZkh/sEJF9NHZcwooDxeasD0e3
	 szNcUH2BAoFJPbB0+tLT3kj/BHBfbpVNCZdOi7UbHIx7GyM8S6i4CBvp13z1rtf5oNb3G
	 91XEDbsDvJQ5R9YQqL5hKgwsBUTa19X+9a9FtdPmKG7oeO3qSsrr096khec08O0x4bCWU
	 fI+V0R/5f26vJexvNQuW9Rm2A9+6uElbXANc1MLaEzEhsbFSQFK+y0P4HFb+r/sNVkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ygXTgk5xD3JFLYW1Z40kjbYGFjl5GKNoQ+QBPbOVGWE=;
	b=mLM0uGCwT417pn25sz3q5OZi9gt9+QFOhuITNcaqyYnLf3pdzOnIgib+WL/Y8pMtpFd/
	 7Mmx+uYlW8eRCNTcfflMmSN8gITBKQEhIciFcpNVtaJhTPFQAXTwk7m+bCgzLORTlB+C7
	 ihDY3VhQtjQ03hM+5MOV8XGjjWR0F710smVMlkGE/SvEcHCIF804EE0JGXN9ibYiYIoBl
	 iQsk6UIkN0uAfYLfQg4A2DOkE9HgXvl4fyVhHOLf5ZHqmbQDm1Aibpzr8fquF1I339hNz
	 WNcEViyUN0Mckp6Ci66cb9feqso5/+KZZjp0GWDWjpVqWMRqBxmd/nozQmFaWEeFgqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grtY2zP5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972D606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grtY2zP5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89CD1F01828;
	Wed, 28 Oct 2026 03:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157384;
	bh=ygXTgk5xD3JFLYW1Z40kjbYGFjl5GKNoQ+QBPbOVGWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=grtY2zP5psniBGpyvg2xibjA7xVNBaLzCHYotw3lo1w0vyjqQ+l2a1OhxNxh6TJUM
	 x5BVt+qGhfxgdAh/dD/bGBAx0Fd1jEnRAipR45v4sPtsccFwRtiytcY8a5QwZj3JzK
	 EntLFjATONIohF1mJNiCxbw8BwGYkTE2DysubwQuJkXUotoU6OkoMS6Vj/E1rS0rzv
	 RfVZ5I/sVTkMAKE6AQsedWlZbldCJveo9Jo2mNwAg/juz65Yjsd5Fx9bzhSRh1Wnwe
	 fqfSFKsLdznbXv66yp8SmgtsJvUdvnvnhsmCSQcLcbNQLS6jP8rHC9nTkINxzsF1LE
	 dcUa/ctev2P+w==
Message-ID: <sashiko-outbox-187406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/16] PCI: dwc: qcom-ep: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-11-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-11-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:16:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace the three dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
> the qcom-ep driver with dw_pcie_get_pcie_cap().
>=20
> qcom_pcie_perst_deassert() is the point where the controller resources
> have just been enabled and DBI becomes accessible, so the offset is
> looked up and cached there. Both the L0s and the L1 exit latency are
> then programmed using that same cached offset instead of walking the
> capability list again.
>=20
> qcom_pcie_ep_icc_update() may run from the global IRQ handler, which is
> requested before the PERST# IRQ. The helper performs its lookup at that
> point of use, i.e. exactly where the open coded search happened before,
> so this change neither adds nor moves a DBI access and does not
> introduce a new race with the PERST# handler.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D10

