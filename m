Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B444F54C;
	Mon, 21 Sep 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022809; cv=none; b=CYwHag0cv/OlcLAlcOoPuFFZGTbmDoQ262JZHhM1F4cJ3aU3KNVUl8WsuIaA4BDfdGtyXSGNeX3tm+/dWMPjeNqu6efB6Qd9oC3Ez0qN22PJgW6fVAnYZooKnjn77acadY8qSlbGMcj+7ySFBS/9kmTIAhtnmrGMzPxgsVxbDTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022809; c=relaxed/simple;
	bh=xjvBKhdQudBR/bG1tr+3gu6nSMldGcCmdOT7jBXT+AI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rm8NE2j/HPV+GoXfDa8K5eZOtXOpv03Vi8EAoAogsGvo7G2Pe/JrFH5bYVnLbTVMdB3d3S0NIHFXZuuQOfqBKlDsBF4RxmX8CLREfNJ3DVFVE5STl4R6L71ReCBvC0gZ6p14M6UG3AQ020lsQrxKfn7l8lNcz3dLx+gZlKddY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8IIB6eH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8IIB6eH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ADD1F0089B;
	Mon, 21 Sep 2026 20:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790022808;
	bh=xjvBKhdQudBR/bG1tr+3gu6nSMldGcCmdOT7jBXT+AI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R8IIB6eHZM+4WSAp7d9X+1/ZL9SdknyAwIaezcfX1pO4yub2hfZPYxBiyeqpklGdu
	 ZCpG3k9f7U46Z+w9GCEeF6mWavOAQIR6BERN4kmK5V1oNWa7xfesZqGx8rte1RF2lf
	 qkB3ipK9zZDlgNfD9OHziiBxmSsds3/dZ1RgMGNn2d2ptt/SAUBkSigY8cpQs3x4er
	 f9AG+67L6vC4ZtABfF1L6Xjlzq5upPxxb+JUbQSqLNeBSNsZgXpNgNnJ4O6V8GjLyw
	 7ull2xgnCyDufo0IBXiKtFZeDsGR+X234rmLQnJTbeeu6wGpHjXicwUVU3lvFPaQ2E
	 7AIfzpec+8hfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] PCI: dwc: rcar-gen4: Rework
 rcar_gen4_pcie_drvdata .additional_common_init into .init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: wsa+renesas@sang-engineering.com, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260921202823.72620-3-marek.vasut+renesas@mailbox.org>
References: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
 <20260921202823.72620-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 20:33:27 +0000
Message-Id: <20260921203327.C0ADD1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Rework the current complicated initialization callchain that invokes
> host_init->common_init->additional_common_init() for host and
> ep_init->common_init->additional_common_init() for endpoint into
> simpler host_init->init() and ep_init->init() .
>=20
> The init callback is now always implmented for all R-Car Gen4 SoCs,
> therefore there is no need to check whether the callback is not NULL.
> For R-Car S4 the .init callback is rcar_gen4_pcie_common_init(),
> for R-Car V4H and V4M the .init callback is implemented using a
> new function rcar_gen4_v4h_v4m_pcie_init() which calls the common
> rcar_gen4_pcie_common_init() followed by R-Car V4H and V4M specific
> hardware initialization. The hardware initialization sequence remains
> unchanged.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921202823.7262=
0-1-marek.vasut+renesas@mailbox.org?part=3D2

