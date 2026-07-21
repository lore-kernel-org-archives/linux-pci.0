Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241B3BB699
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623156; cv=none; b=kkx/CDx6RK56zhKD7gAOraicxytoc2ORVk/U6uCRMGXM6UlO/sEJ1JtRjOtlV0OnKbwRs3ES7inrlOObWUg9wU9VWCzN4stL7DAdwhWtmE8s2utICZZb6W+cgdnWlQPHha6HCiCR9pr+LFXcQ2fJg0aCcFnNCHDb7EEcSgby33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623156; c=relaxed/simple;
	bh=pk4aUNllEF4DhMnu7SCxpgkCAOfX2ztBl/r7nATDAlM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kxJ47orkCyU83kl0flyOG8VtQrQQvKc8jL5d0EgdZzHxac8ghejZibGlDDAJc3yY2pniI4CYYl+c8lV35TodbrHenVAr9hsd4sSL4OqBaPCKTcQ+7UHWmFwrjd3a+dgzX52pbPzjBwwP4vuKARVAyoGPG5ebhVJBJC8ePyLzbZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efzB+tgY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efzB+tgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDF41F000E9;
	Tue, 21 Jul 2026 08:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784623155;
	bh=pk4aUNllEF4DhMnu7SCxpgkCAOfX2ztBl/r7nATDAlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=efzB+tgYTKFEemlWG5Uvun6WwlfNX49G8swa+Okn/OrJiznrb88wU5jcLRnGpzHSv
	 3VRPvcKzMgY5+Ifqmf1aYBtx8/n71rgmWzEJcpeZEjJrYDgJSDLisxNdrTQ6Boynml
	 0sfKix6vbZBa/HFr7j2wEninjuQFfpFM4mBr99HObcr3MLDHjkHO8XyoiLMAB+ek50
	 jgXvwGuauT3f/7Af/ks3f8aL5P5WZchzF8CK6ORFmcrO/v/GD4fUwfbjnqOFsokamF
	 7iI9caWaoqFWSToCbP+wJF4bBOSc4wQRms7qh3QXdI7wP3DDKS/R0w7Y0B9zk16DlU
	 vmncnd0OF2MUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 v5] PCI: dwc: Add PCI ID for LECARC PCIe pmu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Braden Zhang" <braden_zhang@lecomputing.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721-pcie-pmu-v5-1-570e44af7cde@lecomputing.com>
References: <20260721-pcie-pmu-v5-1-570e44af7cde@lecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:39:14 +0000
Message-Id: <20260721083915.0EDF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Brett Zhou <brett_zhou@lecomputing.com>
>=20
> This patch adds support for the PCIe PMU found
> on LECARC SoCs.
>=20
> LECARC platforms use the standard DesignWare PCIe Controller,
> and the existing DWC driver already handles the enumeration
> and basic functionality through the generic PCIe core.
> This patch only adds the PCI vendor ID to the vendor-specific
> capability (VSEC) list, which enables the standard DWC
> RAS/DES feature detection.
>=20
> Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>
> Signed-off-by: Braden Zhang <braden_zhang@lecomputing.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-pcie-pmu-v=
5-1-570e44af7cde@lecomputing.com?part=3D1

