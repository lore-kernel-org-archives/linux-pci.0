Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898174AD4BF
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155928; cv=none; b=YdqKl2l4NMPOb5eXsWLArY3aFVGSbklIuS4FKBRXW25hV2tv6E082z60DtxghISOTeaSWtejw1Qc6g/6edu516Xzk+e+uCFaKsifdRwWh3mDSu4Fl2KexURVmDPG7UE74tQe48aJjyCDEIuXD9OQVMkSXtpo9diHz/eXl3yRQwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155928; c=relaxed/simple;
	bh=kPXF8vb1qR8CpvSPMBQpZDFJy6j0/uxte8hB+VWsWD8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eUGNQHrjhyLXOMJf4MnqgyYmhAewvii6P0uEQ3NMDKpOKY+pRTZ78AdbKuIdvg3mcFux6o7/DqD8XtmdtYs6hQlGieMLRu1ajx92rcCTN3MBD8DOQtrKpzpRpAQPfv+PNJrf4T5YqkRJti9T/fejNmIQn6BnFGKBezSFE9CPmFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCeYJOim; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCeYJOim"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B855F1F000C4;
	Fri, 16 Oct 2026 13:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792155922;
	bh=kPXF8vb1qR8CpvSPMBQpZDFJy6j0/uxte8hB+VWsWD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VCeYJOimA3U+UA90GqqQb3SKWEEG8AkUDpWktsns5YiUTI+53l8JcmIPhy/CxphQH
	 s6HzLDkN7FOrqj0Jw591OlwK2pXDqULWnwqiZu/WE8CM6YhJsKop+/toqkU6AuGJqx
	 cvLaU+4hCtX8/MsRXzIf79KIlRrY8q3f+79Srp27VAmr4T6Fo2iNp6BLzGDdQUNYgE
	 RtSAMYl038VUtlUxI4dlCWPMYSmVZB/RRfm9jKFzk9b+QvaTaczozIccGiuHzLPWns
	 19RJ0lk1Ndqa3ks1kcUYkys33+XVxpV71JFU/0KdDhHT0ZQz3J+h9xz4mT3HxsdAsq
	 GaBzhyP+eOOtg==
Message-ID: <sashiko-outbox-174366@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: qcom: Reinitialize MSI on resume for
 firmware-managed controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mrinmay Sarkar" <mrinmay.sarkar@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261016-pcie-controller-reset-v1-2-51779736cf12@oss.qualcomm.com>
References: <20261016-pcie-controller-reset-v1-0-51779736cf12@oss.qualcomm.com>
 <20261016-pcie-controller-reset-v1-2-51779736cf12@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 13:05:22 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On firmware-managed PCIe controllers, hardware context is lost across
> system suspend. While firmware reinitializes the controller through the
> power domain framework during resume, the DesignWare MSI registers are
> not preserved across the power cycle and must be reprogrammed by the
> driver.
>=20
> Retrieve the DesignWare PCIe context and reinitialize MSI state during
> the resume path for firmware-managed controllers to restore MSI
> functionality after resume.
>=20
> Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-pcie-contr=
oller-reset-v1-0-51779736cf12@oss.qualcomm.com?part=3D2

