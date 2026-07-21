Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E83793D2
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649949; cv=none; b=TAZt0hChyLlIP6T8PRPmkSr8Yv5iGuaM0CKAZyK1ScxvUN6+GSzXqiC3NoqTP2ahS+U+31xPnv0ivBN+v/BSh0LMwHEo/PDb5JC3aXkj9HPhuQcCrtNNEMjRTcvXIMRjU7Hd+eWt1VHOfkTNR+4YlESp+k6jCjNTHuP1n9R7yfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649949; c=relaxed/simple;
	bh=hLFVHa8izh3gSNNNHBzIYfap8mfSK+MVWoM5kJtYtuM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oWBz7u6tyytwHCTkvYA1mBeV1uoSgi30+5fm2gvzakz+tNra+RIzgnG7k2BnYdlOBcE2XbUrn+kjqehxZc5LdNmKYFfM2eEv2L4r4iGZcKecbjDcWn8aXM+8Thnj01n6MPsUXXDp5W6GhXglhLvTTJ0agAvRW/WRMC7jU/PBGtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCRfuru/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCRfuru/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4C51F00A3F;
	Tue, 21 Jul 2026 16:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784649947;
	bh=hLFVHa8izh3gSNNNHBzIYfap8mfSK+MVWoM5kJtYtuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cCRfuru/Hb2mwU4vrRpEd6fOe1Bw6Nlr9qDuBUDI5tYSPOOhyRm3DhJhCVLyP4oNZ
	 WHVa26lER0IJZHNph4LFvra34/sHjbyTqMBGK9/9L7rrqxOtwJIm69szcHYckiTKJW
	 9M+0vC2NITttFRVhSTqVDWMmFZd+hnpxKB1FWLSTile4O8AkXlyax40Y6vXu4h+gHQ
	 gLe6QzxkeJJ7H4Fz6N37rTQnnjxLMY4zTNzQ/L0IcFCdQhJrVYmU3a9d8SyeYwWD2l
	 x1kGdoZ9vTOPge167sQ7ZlRL5F4eG8yiCEwIMYo0tupSo7xonbXoKB/6hLbq4LgNyd
	 uPEqszsUfOdmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: j721e: Fix incorrect max_lanes for J7200
Reply-To: sashiko-reviews@lists.linux.dev
To: "Takuma Fujiwara" <t-fujiwara1@ti.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721155743.3347659-1-t-fujiwara1@ti.com>
References: <20260721155743.3347659-1-t-fujiwara1@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:05:47 +0000
Message-Id: <20260721160547.7F4C51F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe Controller in the J7200 SoC supports a 4-lane configuration.
> However, j7200_pcie_rc_data and j7200_pcie_ep_data incorrectly set
> .max_lanes =3D 2, limiting operation to fewer lanes than the hardware
> supports.
>=20
> Set .max_lanes =3D 4 for both j7200_pcie_rc_data and j7200_pcie_ep_data to
> match the hardware capability.
>=20
> See J7200 Technical Reference Manual (SPRUIU1D), section 12.2.3.1.1
> for further details: https://www.ti.com/lit/pdf/spruiu1d
>=20
> Fixes: 3ac7f14084f5 ("PCI: j721e: Add per platform maximum lane settings")
> Signed-off-by: Takuma Fujiwara <t-fujiwara1@ti.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721155743.3347=
659-1-t-fujiwara1@ti.com?part=3D1

