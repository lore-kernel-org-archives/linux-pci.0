Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794295195;
	b=ee337no8+iYSpZF1yS/FBk7tEPwUHhRtV0LYOL2VaonjHhvOECqlqgNiE93jBUM+ecrP
	 ApUZD6yLoOhP1KcnUqObkMsMYSkZM8jvJq7mWDzUsaHYE9ZW2wZ5cRBc0n8YQwgKBp1rs
	 HHfc9jqhd3X1KDZDdEnBgVaRSVT7z2tdQE/Lc9+mMr3V5jGGXtAx2ETSKZC3COd1RH/Ec
	 4wKMVFKzg0yGjXYkmVBSGDAAFMaKxa5QVFTJZWdxN74bb8xm1eoe7WiWYl3qLhhiblaC8
	 4rjeYvXi++Ht0kG3OgZkscE1IRigbKIHbyVMl2WA1AEJMZAWVZgTdJBGd1Pu0jt/++A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295195;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qm+vMHczT0efzLSYOEOgKcV4bXyd42aNCz99mCJ+Lrc=;
	b=YfPehUmmKEB55Uln8JKcXJoOHTV3OOcbGukICC2vAHOFc+O0jPHxIHx1xWpJCoF71Ti7
	 qPZ1J477nEtkdjIhRGEB+JBWeAlmj+5Ro3nN0YRtUydQcXQgs+gQ73YnEzAV6zVoKIx3L
	 x06upeM7K2juy7YTJx2HM94oI4LhpaNIR9eXwYWvHUpSPJ47tACvCBKchm4GKkMU6q3FX
	 j95kLUNGASbdAR6vGBe/4f2sv8HfZAm+DkGYg6n12HUsHGiy6QLho7bdNhbF4itkKiPGa
	 L+1SSgook+34mzSxfuabsW2ZUJmJsujBEawjySzNvi9ArpStqbLcO6Jcbe7sDp4Doww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pgtn3yMu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252F6606D637
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pgtn3yMu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D141F0089F;
	Tue, 10 Nov 2026 07:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794295195;
	bh=Qm+vMHczT0efzLSYOEOgKcV4bXyd42aNCz99mCJ+Lrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pgtn3yMuQu+m4nXGbe2qB3S2/kZ30DMTNi3bOfVrWzAwoVcB4svK/2dHaVLhRFbO5
	 /nweunnxXYC6jSF+wu44iM6kNnA7MXC5wZn8HFD91f5YXl5ULgGYPZ85yikfs2BGvO
	 aSkdB1VtbvS/YrPa1fdp20Yie0GGA8rJtRsnf9SBZTFJ4Im8c/sQvqRkrQhP57L9qM
	 qB63QjjKbTpuqn5YPBor1mJSBXxySjuf41mfsohd7pSeq8VK6NvivPfDCsrYqXiAB/
	 9bjqmoGhgZv8gP9PrSr5yfEPghsn5KdersiBvn3Ya+QV0GQ62m2p8h33+XALlqb7C9
	 HZX4WhK3wnG8g==
Message-ID: <sashiko-outbox-206477@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: j721e: Fix OF node reference leak in
 j721e_pcie_ctrl_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110070944.996-2-zhaofeng2@cmss.chinamobile.com>
References: <20261110070944.996-1-zhaofeng2@cmss.chinamobile.com>
 <20261110070944.996-2-zhaofeng2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:19:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
>=20
> j721e_pcie_ctrl_init() resolves the "ti,syscon-pcie-ctrl" phandle
> with of_parse_phandle_with_fixed_args(), which takes a reference on
> the resolved device node, but the reference is never dropped.  Since
> j721e_pcie_resume_noirq() re-invokes j721e_pcie_ctrl_init() on every
> resume, the device node is leaked not only at probe but again on
> every suspend/resume cycle.
>=20
> Drop the reference with of_node_put() once the offset argument has
> been consumed.
>=20
> Fixes: 7aa256234c4c ("PCI: j721e: Get offset within "syscon" from "ti,sys=
con-pcie-ctrl" phandle arg")
> Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110070944.996-=
1-zhaofeng2@cmss.chinamobile.com?part=3D1

