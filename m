Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013133CF21A;
	Tue, 23 Jun 2026 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205042; cv=none; b=qdxLyEwJMhwx8RBOTq+77SbXYGtH4BP6YFZQQtPNOP9F2YG5DTF9XDWHW7u69TfHraeOrlpUuKpiccldw2x/2MClY6HHzJxm1QCXFGLtBGvMcsrcAV/K5oHhDiAxBrTXvNJPh3Vy9S1fAeMhVvhk61HoQezO3nLW51xvfE2mJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205042; c=relaxed/simple;
	bh=R272Ao6uWHPd6fy0+xiHN8oXEYJ1iKVvOK3uIl1fT4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JQEN4Rk0Hxj+tUIIpsUakXA4uYG9LMndEHMbXNsIkUaEutzSe2LMFDwl7JVjm0qfb9+rhwWetvFI+ARrWxVbtYD/WitvOR0hDcUTpUZL50f3oIX60hTUeUAA2V+StTufVYuOY0K0/Y0BbIWP3ozq4CDw6kn2u+Ri2p9BbZOaduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY0FtZGl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY0FtZGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692B71F000E9;
	Tue, 23 Jun 2026 08:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205041;
	bh=R272Ao6uWHPd6fy0+xiHN8oXEYJ1iKVvOK3uIl1fT4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kY0FtZGlOhwRP1w7VZO4CJyPB+BXzVikfXUAktnzRSG+3WMF21TZ3YNL2S2xEGdaP
	 rUPp0P9e8ub9lA36J619m12QXqUh2SyGrWgXgo3BSfApStKLvPkwghprzoL9IEjWOB
	 xWFJhvnBDx1Gl1OpEPf+yoePpVzawjNV9nfbzrxENL3BlAA9K1f4DeD2q7zP9tLRkh
	 E6+m2zSdlmqEBXS6q3XqItkwna51rLfgy0MJlfvTYtzUPy/7ej4Z1jmltnwPpZQDD6
	 xGXwpTenGXoC5VNqi3IyJZCv4AJwtQUfH15Usy0AWrva3qJvfZlGcRUggjD3rzp/+1
	 PYaXU3HiUt5UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v18 06/12] PCI/TPH: Expose the enabled TPH
 requester type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260623085048.51139-7-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-7-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 08:57:20 +0000
Message-Id: <20260623085721.692B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Zhiping Zhang <zhipingz@meta.com>
>=20
> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> requester mode without reaching into pci_dev internals.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623085048.5113=
9-1-fengchengwen@huawei.com?part=3D6

