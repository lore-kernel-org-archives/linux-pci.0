Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B56326939;
	Wed, 23 Sep 2026 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790128519; cv=none; b=c1dnjp4WwPYgvFJl5D2d0PNRmumPUuKcr9xGrjjLeMBi+GbSy2gv/W1+DOYEwuwEeM7Na5/itDAgVDUkBn3s9sWXScYvecyjwbCdHKctU7wJo223rfw1Q77QcgQFKZ3wPa6CjPoi0ZbHP5BXpzwSzzj/n3XDMFS49sIW/QhJ5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790128519; c=relaxed/simple;
	bh=gpyLiHf8oXlV80Dy3+nEXIz0bqKWkg5wHg2fBY5hd44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O81TxDKtuwGuRLt1BPmWB8a+emzhyh27bn6lQ9ePf9IL8URmrrR8/HUlK/s5J+iFKK6xTQ/FneHJ1A+NMuDdtEfddoPAz3bknChMlCpzIGsrUHPuq/BjjPjo6jadDg69PnCgC1asgoxG/TfqIoAuITeZpTa7+c2DUc8c+PSi5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdCqqNVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdCqqNVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F9B1F000FF;
	Wed, 23 Sep 2026 01:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790128517;
	bh=gpyLiHf8oXlV80Dy3+nEXIz0bqKWkg5wHg2fBY5hd44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CdCqqNVe6zsAudIbDg8IpRqeiwAkpxHDhetCbbo4H4yNBuPYncfTyKPpN1AuoTZ6+
	 T/F1zcA+pT3qiUmCPEnep+yPRb7fK4t8zrT2WRl9eFU9cLJ1Z3C4EcgnBlT8YAeehX
	 7buG9m5DLKZ93hDYCvC7thHIftR8T8RccPPkSri2TBP2R3H1LkQ2ue6gxDtwDfggNJ
	 e5ymoTe0EXRAgwOIiOdpVpps3GBzyAXrnaN9aysXI8Ly964ISm8hy7lvpNgKXaGC47
	 rxkcsecDqHygX8FGYqDewOy08Cxb6HLL5djuLVvSI14HbRi8umxmvALwbpyMFvq5Br
	 1gYVrP52Ij6Dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/6] dt-bindings: PCI: snps,dw-pcie: Add msi-parent
 for MSI handle check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260923015016.64069-5-inochiama@gmail.com>
References: <20260923015016.64069-1-inochiama@gmail.com>
 <20260923015016.64069-5-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 01:55:17 +0000
Message-Id: <20260923015517.A1F9B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The IMSIC device on RISC-V based system does not require ID
> remapping for MSI. So this device only needs "msi-parent"
> property for IMSIC-based SoC, and the "msi-map" is not a
> necessary property.
>=20
> Add new condition for MSI handling on IMSIC based SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923015016.6406=
9-1-inochiama@gmail.com?part=3D4

