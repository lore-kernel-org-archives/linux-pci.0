Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E472D1907;
	Mon, 20 Jul 2026 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560524; cv=none; b=mbB/OfkKygL6D7sPVntUv+bjvjUEPjVyV6gDLbHa5HcLDyTx5/QTpyiXh4EUIrmAUu/p8OlyLU12TJIw2lY8cnBp18UXAeM6Tt68ndzdbb1v77XjxrimWX5K65LLKeurbrtsqo3I32gwRDnhTkviSafSs3w8iRdgk8FkCftIhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560524; c=relaxed/simple;
	bh=LmmogiEufKhvOJytSyIQ3GRxByxn/QocdEFTi8HuwOQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KnPBo3HJx6mZ2tq2rLOW9WgXc5HHjzzzei/3Ccu+s/xhjOXupzOhj8QqjHSsihita3rlrQGayNgww29Sgfj43s5lH1sU5oaej+pFVFGXv3UxReLkijgtFfh1dlSGe4/UbGq0gFzWc+ndmm/8LBbST7flWsZhahCHeVhBkTckP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjPjJnv5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjPjJnv5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A771F00A3A;
	Mon, 20 Jul 2026 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784560522;
	bh=LmmogiEufKhvOJytSyIQ3GRxByxn/QocdEFTi8HuwOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KjPjJnv56gh/l1/GiWw/gRoU+WmWj89hGbhKMXL0WS3zzEEkKBAmE/Kzh9Qlzwt6Z
	 DWTyNQyQ5IagNHTZQ7Ebapg/LXrbCMH//x6CMtx2K2zeMAS+vAJK6WeJCDjeWCV1iO
	 u/617YOjQzGixGEfmoHCT9WgtKac7Xu4aqIir3Dtt2pIn816AE0tdX9HnO8UqjvFD3
	 ulKFRhV1WMxU1kWEsz+A9p53XWLZStP4Gfg/yXOiqcM4G7ZxPOUmYX2FL3OBOKTR0d
	 7u3AIKb4on3b9WzGMLB1KDqqva84PCfSBPJcaheC+uCxWWrqxBF84l+GbIUj1MXOtt
	 8i7CJ+BchPhXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/16] PCI: dwc: eswin: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, Frank.Li@kernel.org
In-Reply-To: <20260720150619.24733-8-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-8-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:15:21 +0000
Message-Id: <20260720151522.41A771F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> This function is called after dw_pcie_host_init() has already cached the
> offset (dw_pcie_link_up() is called after .init and after caching).
> Therefore, we can directly use pci->pcie_cap.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D7

