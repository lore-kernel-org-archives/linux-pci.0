Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C552D2A2
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651885; cv=none; b=i1mP582f9zJUdk6oEJOVMYbzQuOj4lTSkWxBpHIc714jCzGcfjQePVvBVwaEeWcwgSlA1A80jGLW0thNhJM9rpMmJN/prHrwbGPq6Rk7cj1+0ph6QLGvEoiNPYMgJLrs1BN5iR46W39IKnIqnc07exdDYO4C6l9A3D5PC0qQM/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651885; c=relaxed/simple;
	bh=Fe8ZtOX9VLUAm/R0peOa42hOBiiwB4EY10IzAyx2Dig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nIoAomPYjfzMW20AcaWKWATE7sFgljbM1ew72PXNHilIFCEkzHwGBtSluZ3eFG4QWL6Un2sGDPBOjAdTdndMfT1TEgsXx36Z2492Wnmqrr2BTNmGQfx0R8/7kokzcS8h2ienTIriPrllOgmLNOVvoKZgFisenoTFQ8mUknsEy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIsAf2GN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIsAf2GN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECB41F000FF;
	Thu, 17 Sep 2026 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651879;
	bh=Ajt9JsOZChtZPf2ZE3rIXeLfvFVV0KhtOLGV/mnp4T4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIsAf2GNDOC/EN2YOa/Ev3T/ZxThPGrFd+7nDUjQC8d3ip3ZMudTRIRhA2/uLzzgu
	 p1GT8m9CvtbWQECQicfI2bND0W+J/3qn6/jB/loraJQCtcEg5P1gZp50a1CUD0DPS+
	 xXxE6DB0HuNbzpi6IPXLjZ90RzCkkUleKFG9rVy6XAw84p5QXazHG+jNkHuKI8P2a9
	 feP4M9Xhjdx94PvRXYj1PwCugBIxhZnvgmdNSIylKAR8sfXR73ukrErJ47ejegIK0m
	 EaqdEUDmHEjvT9U/BRZUKMYp/MkC4cRHFcCzq36C4q1ggBVs+OpEo/b1uWw/MTRWJ9
	 6f3TfTW3K68uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: xilinx-xdma: Fix device node reference leak in
 xilinx_pl_dma_pcie_init_irq_domain()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260917132459.2153240-1-vulab@iscas.ac.cn>
References: <20260917132459.2153240-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 13:31:19 +0000
Message-Id: <20260917133119.8ECB41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> xilinx_pl_dma_pcie_init_irq_domain() takes a reference to the PCIe
> interrupt-controller child node with of_get_child_by_name(), but the
> error paths after the two irq_domain_create_linear() calls and after
> xilinx_pl_dma_pcie_init_msi_irq_domain() returns directly without
> dropping it.  irq_domain_create_linear() gets its own reference on the
> fwnode, so the domains do not consume the caller's one.
>=20
> Add an err_put_node label that drops the reference before returning.
>=20
> Fixes: 8d786149d78c ("PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917132459.2153=
240-1-vulab@iscas.ac.cn?part=3D1

