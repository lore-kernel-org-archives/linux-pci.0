Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE91FA859;
	Mon, 22 Jun 2026 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155081; cv=none; b=tV4w+ow4Y2/QDwaVWNxSwvMwfypo+lc/bIu7QC7ZvGEIGn00xSfEnUUjxn14pfu6kQjiuVUvjhoo4kmVdpiati6w6VZIMRwKaKIhc9AM0C69IUonYanYq1qoxd5bEM343OlM09luZrXMFw1gpnOd5qtqtbRg5KCQ2d1cndKHlP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155081; c=relaxed/simple;
	bh=MCVRE+IzQGOTnEZjmB7HPn4wPdgc38o8Yj1eyttEgIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bx/CLgrJk9srRNyWj2mHjPiZhDGUUuFfPCyDv//5Tz+xkRxXEUZZ2Fnttgd1nFd8nK6I9i/SRX3JgV173RNY2eEz4Bco6omanpRkTvsTNvGRoKFoKZfsniMavZ7FacSkVs6RZQENGv3aUerBq7YoI0+4mdmwAU9xQn/U5/sPA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1R4YL5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1R4YL5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4331F000E9;
	Mon, 22 Jun 2026 19:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782155080;
	bh=MCVRE+IzQGOTnEZjmB7HPn4wPdgc38o8Yj1eyttEgIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A1R4YL5lX7V+clgjEUMNh/X5iWREGFsIEyi4Kidz+7UpysgLdcRGaPSy/9YlXu9nI
	 408TxOe1kx0fhl+Ht0PBQ70AWdtlcBDfgmKznk/1F1dUbHw39fvkHAXkBjL/J0fdwu
	 CjrmM0PHJ4dQtG2S3KzunsDZcEoGx4anIZtTfbLzaitHCNL1HtGPlnz5rTEuhKnKwh
	 0edE3tb3GihP78esnt+uLrV/UpYnIDnnc7oQH2iyzQk25R8oq/8Gilc+56noCh9bH6
	 i4hY7COqFbMygiwT4AWpGHllWtFBP8mAmPBPfa4TNZ3TDmRgpJlRmlwDwdAIaUTyOJ
	 TT1C/FHvX7w3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/4] PCI/TPH: Add requester/completer type helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20260622184211.2229399-2-zhipingz@meta.com>
References: <20260622184211.2229399-1-zhipingz@meta.com>
 <20260622184211.2229399-2-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 19:04:39 +0000
Message-Id: <20260622190440.2D4331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> requester mode without reaching into pci_dev internals.
>=20
> Add pcie_tph_completer_type() so drivers that publish TPH metadata for
> a device acting as a completer can gate on the "TPH Completer
> Supported" field of Device Capabilities 2 (bits 13:12,
> PCI_EXP_DEVCAP2_TPH_COMP_MASK) rather than reusing requester-side
> state. Fold the reserved 0b10 encoding into NONE so callers only see
> the defined values.
>=20
> This keeps pci_dev::tph_req_type and the completer-capability decode
> inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for
> callers.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184211.2229=
399-1-zhipingz@meta.com?part=3D1

