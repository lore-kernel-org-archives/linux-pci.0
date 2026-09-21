Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7A48423C
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001245; cv=none; b=myPb5gxGJCw9kX2FPkMq5pmo0owmJ5Hcvz95zMogm7mU3AnH+gY7QPz60nBdBOFZu+1CBUT42eygy6v6bnh9nrfDgYM5aJSibhndw31PqNamgp+4OVuEFQD6xxAp0oWrXxnozRBNe740kSeaAQmckHMkh5WAXYk1wEXVOtuE7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001245; c=relaxed/simple;
	bh=XSvAp9i97+tcyCky8Lr8HAkHoTHIWAFYFFsmxRx4zos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p60HQ5xvcjU/xnlSXI8WD2tLsLMpPJpCpHqCSg5gAbgD92E2JBeDIXz49fdaTCL1Vs8Nzq95VG0bIADUtl3FpjDszn892GjKqFPIc/1tbuS0J8ezM0wrPn1FRkwmOo+KYDzD4gIlTQBgibqICA32ZkFXM3dx9yWBsNOHmiz8Q9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdfF//sN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdfF//sN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994C11F00893;
	Mon, 21 Sep 2026 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790001243;
	bh=G2112zKFnfVxpeSFSZtst/2sE8cWdB/7PGYCB6wte/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mdfF//sNADeJabeKiA+1nkkoxix4tBJBQJODAUDBC9IWjeDEmaFiHjGipm3EHATyr
	 BTPFzP1e65B87sdrJdQU47Unmop9FuHBhdfl56WRt8exoTC19L3R6SQ3zz4hHx+TZB
	 OdHgy5rEGMhp5YJWjCoSvAHElNIawJmezcOMhpCZtV3DfLZwzYoaKm1h2rF9E52TG7
	 53awT9cZhCuvEiZZ6Y6uvcNtsVfk8NwIIY0A/h3gHsReEisVb/HulEKwraqHMesGYs
	 4iE1fGzaL1km6QWzZb06r/ev0R1aHUoit5s7MJxd+kXYksc/mJ964PVTsAUwxP5yl7
	 EUNJSL//TwwlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: pciehp: Make poll mode parameter read-only
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921142608.270312-1-runyu.xiao@seu.edu.cn>
References: <20260921142608.270312-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:34:03 +0000
Message-Id: <20260921143403.994C11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pciehp_request_irq() and pciehp_free_irq() select different resources
> based on the global pciehp_poll_mode parameter. The parameter is
> currently writable through sysfs, so changing it while a controller is
> active can make teardown stop a nonexistent polling thread or call
> free_irq() for an IRQ that was not requested.
>=20
> Keep the parameter available for boot and module configuration, but
> prevent runtime changes to the registration mode.
>=20
> Reproducer:
> Boot an x86_64 guest in QEMU with a native PCIe hotplug root port and an
> e1000 device, using these device options:
>=20
>     -device pcie-root-port,id=3Drp1,chassis=3D1,slot=3D1
>     -device e1000,bus=3Drp1
> [ ... ]
>=20
> Fixes: 2aeeef119995 ("pciehp: Clean up pcie_init()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM Codex
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921142608.2703=
12-1-runyu.xiao@seu.edu.cn?part=3D1

