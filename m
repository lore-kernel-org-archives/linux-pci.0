Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F90357739
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849638; cv=none; b=XM3WdIBC7zZitWDZQK8UxPEPJ2ORSBFL7jNs2rBrTKH6HCB1EBh8oDnwFW3dfmM24cUwaadiQKD9SjVW9NhCTWZeypMroVZvAd0Az9uduR+wsDG4B9u0dRonGZZ9xYsZnRSs+qCU17IQR3ifk2Dt0RTDnvQIx2o/aimPOpX2eMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849638; c=relaxed/simple;
	bh=/E6YRESAgH4yOvn0r01iY0K5HwYa7Vjusw0EjZcReH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yr40xca0PeMDMHcY4mw4iZdThA8JRQxzzx/li6YlBof0mvDLmxtke2v0AqlZh4a+IWPwGkbVfg8QAJJl/m+QG4rHwuRZ2NioJFDvjy20LbztzYH6HZqChIFyKO6v0hlh+LulCqjubH50TZDhoftERBRGTuNShgguS/sqrgsJ150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCkOVZ0A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCkOVZ0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20A91F000E9;
	Tue, 30 Jun 2026 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782849637;
	bh=/E6YRESAgH4yOvn0r01iY0K5HwYa7Vjusw0EjZcReH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DCkOVZ0A5waX74hhdu0l/yMh8jCc8SLjnexgcM1qWA/rW3jQer1D9Rkp7D7LMY8jU
	 1CQDgz2JK2UKdz1sdL8tv3lSDNBAOMwptdZzvZhApSMnB9uHL35CV7ZFD//bPc6Hg3
	 oECknffxBhcwDP/ByS/7z2HFKtMXQmyKioezBTbGz7Mss4W0L7NtuqJEPjrwyyOUWk
	 NL1OUO4m3aOVvopTe3n2C01TZVExHFF5wuO3LfIGf+tBc52iQTG4M6RkH7+RahdIki
	 Sb8pkDbONogBzvVU/mTd71mqIzpGcFFEc2rUnqm1mz5a2Z5KHzpDN3warkBNUGSK0A
	 RFGAHzdK91mHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: xgene: Drop unnecessary OF node reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260630195234.1871951-1-dbgh9129@gmail.com>
References: <20260630195234.1871951-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 20:00:36 +0000
Message-Id: <20260630200036.E20A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> xgene_pcie_probe() stores dev->of_node in port->node with
> of_node_get(), but the cached node is only used during probe by
> xgene_pcie_parse_map_dma_ranges(). The driver never releases the extra
> reference, so the node reference is leaked.
>=20
> There is no need for private OF node ownership here. Use the device's
> existing of_node directly in xgene_pcie_parse_map_dma_ranges() and remove
> the cached port->node pointer.
>=20
> Fixes: 5f6b6ccdbe1c ("PCI: xgene: Add APM X-Gene PCIe driver")
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630195234.1871=
951-1-dbgh9129@gmail.com?part=3D1

