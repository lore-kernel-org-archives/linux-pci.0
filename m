Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9F286A4
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783909901; cv=none; b=lCW+F7jenT7l/NULQOYA5nU38uvcUPvdfYZeeVlhSJHa+1Qn0Vp86iYua3NwaTPMVFILz+7nd7LmqchLsLmERt32QTYd40uRw/J357aqW8kzywZebHaSZ5f3T80YSQi8uW3F09Gj/C8fvaKnFCLr6elfA1GzrhvktGRY2bu1QNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783909901; c=relaxed/simple;
	bh=iNyFzFSuKMYq7W7LwtnC1sSRSPlFIVNGB7cg5tbVpUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jSPGihA/MAJwWgBneBBPTNS6VHBFhH4K4bAVKflMRsD+93+dkZhoM6LobW06s4KSejDXbPX1T+d+BGtTnwpwOQrdjoAvBfPty77MeaaML3+WBq2/42iNjBszKhfQ8mg5L0kB1wxutSSzHVRhey3eg72TJ4OviyN795qtNpyBxAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBe71jeN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBe71jeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333531F000E9;
	Mon, 13 Jul 2026 02:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783909900;
	bh=iNyFzFSuKMYq7W7LwtnC1sSRSPlFIVNGB7cg5tbVpUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IBe71jeN9dBSMVDIwMVVQAwRH5tT0AaiKlY3DyEaK4LnyATh32CRVgpj/ScvIgj0n
	 PEUpb1spv7qKpYxIhBTsmjx6V8KuKKRXmTBG+U3BG5p17as51BWkAFPNfYk+HL9gJa
	 jjQ0URllvf2+t1r9lr+o6mz7slVUnwx/g2N7GJ6lwXvF0USL3MjlhGIW70qCkvgg/1
	 Ob0QPj+V7QbeN4PA4vdL5ke0sw+0DoB2+8vys9BAHxBycmlGXVMOqZ7kqcSAu0IhR+
	 r0dNm7ISezofPCT2i+1DtibtHU4IaHjADR58Zk0TkamBoahe0Al/qlA037kOmFF+77
	 khGEnih/KKyJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 v3] PCI: dwc: Add pci id for LECARC pcie pmu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Braden Zhang" <braden_zhang@lecomputing.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260713-pcie-pmu-v3-1-5e4a8d82248d@lecomputing.com>
References: <20260713-pcie-pmu-v3-1-5e4a8d82248d@lecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 02:31:39 +0000
Message-Id: <20260713023140.333531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Brett Zhou <brett_zhou@lecomputing.com>
>=20
> This patch adds support for the PCIe PMU found
> on LECARC SoCs, which utilize the DesignWare PCIe Controller IP
>=20
> Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>
> Reviewed-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Braden Zhang <braden_zhang@lecomputing.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-pcie-pmu-v=
3-1-5e4a8d82248d@lecomputing.com?part=3D1

