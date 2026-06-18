Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C10140D59E;
	Thu, 18 Jun 2026 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820372; cv=none; b=FmB+P/PePd7en4mNNL1YcEKgwEzzV7kHgn8p24EiGCBhMTUO9dD1qAo//0ps6p1ZNIWydTLG0Nxvjuk/wMm+wX+veG6fNfF6gBMfwfqVwwfCgZQ26WhonH/Y6iqSIiLEX0dhsDQbCvJ6nmSro8qr+0PcZYGVgHb3+WSP4+Xv/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820372; c=relaxed/simple;
	bh=S+unlq7k3YvuMOhvSJrd4abYTtkkonRGAbMOXY6lyeo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l/LMB9W6SuqdX7Igyy2XK8Fs6YpHlPVM2twk5yv88EEJvN2mMsxFvEDFzKKUDcha/zVHzyMHCRMzjctC8KR/XSIp94cTwdXb1tbpgwIRvHDufBwFO3Gg09PPQNhVru/19aEUFsEWQyRkUcRM78eoymIO0Te4rKux0E2KBWMvDb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg484fft; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg484fft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE45F1F00A3D;
	Thu, 18 Jun 2026 22:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781820371;
	bh=S+unlq7k3YvuMOhvSJrd4abYTtkkonRGAbMOXY6lyeo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lg484fftJJLHCWviMlsl0+Kuwk4Ezu4LMiGItCwFD0AOQ60MauNzsYEZB01S3canH
	 KlOfPhrGV787MqylgpaOw67noiOMnNFBcZeUgxUlTSWrCi4/TpTOAJujq+3sX+hahq
	 U6/Qb8V6TrkcsX+PCIuPNDDT5aNsH5AhOG7B26owSgagJNYDTG+iSnXhgdZslIvhnX
	 anVCxWapBLaTGHWTnZsOTQQPk3ZHdwAFHE3jZhrX3hoHeB8ulx4Wl7pAppgVvZ/Hq+
	 Nv9o8JgzK4gau1bWkYZmPr7rzz+Cl6i3FC0P2G5wHM/2oRjimrlebQUIl5lgVycdKd
	 BsadtGj2Pq0nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: qcom: Document the Hawi PCIe
 Controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Leung" <matthew.leung@oss.qualcomm.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260618-hawi-pcie-v3-1-f31880bfb3ec@oss.qualcomm.com>
References: <20260618-hawi-pcie-v3-0-f31880bfb3ec@oss.qualcomm.com>
 <20260618-hawi-pcie-v3-1-f31880bfb3ec@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 22:06:10 +0000
Message-Id: <20260618220610.BE45F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a dedicated schema for the PCIe controllers found on the Hawi
> platform.
>=20
> Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-hawi-pcie-=
v3-0-f31880bfb3ec@oss.qualcomm.com?part=3D1

