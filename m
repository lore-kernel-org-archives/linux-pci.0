Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BAE332EC1;
	Thu, 25 Jun 2026 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420766; cv=none; b=MM8+59Z8ezY1HnLPcSZtfvktm7rbjTT483UWQRd38wzeUzbOuL51NqX2Lro0vNDwV/Ks00ixm+8y3d/tRCNoa349E6u/FTqphpf6DUCnuvVV4ovdcTTM82XBuRX82hszDoNIFTLhOjHCRxc8H5JztpCuh/kujKnO1mWn3Iu4B/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420766; c=relaxed/simple;
	bh=9vCvP5QksXzxjUqw9yT6Q5MeWh41rGCTXNo+FjuiRg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQGLHR5S8t2Kwf8/GXKvFBoVQRrxnAJHPSn+caApMZu5OiaUTsnJD01Wu4YJn0wcO/mzyDJdTn38o8E6oPUl4hgoyi491HkyUH0hsgowBJwHoWtI5HWPejHxoLmZgLy/OKz4kjqG7J5/EO55VQNrFQ3Tk3VFZACUAnZ1a4UUaxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KM4HLMOv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KM4HLMOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4201A1F000E9;
	Thu, 25 Jun 2026 20:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782420765;
	bh=9vCvP5QksXzxjUqw9yT6Q5MeWh41rGCTXNo+FjuiRg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KM4HLMOvtmdYLDatUU0/2XumcNAaCTVP8OQINQFQxbVYqsegoq+cwnRJ7t74TYShi
	 8tlP2d1vx791GqJoTCaHhZ9qIHa8bCqbK1Sez+wp9nbG0n/uii5M9cgXNU/40t2Wmy
	 Eag/sTzATEptO6QugTweMfWtQlf71VVyFhqFACbv2GEiIX/DWlhE4M0u6YI/Qi0ZKu
	 22Q1a/CGWo8fBBebsyAF+Im4TRdriELhBceNjRS+ssxFu3yHwAUpdLrbiZhnmbmXBQ
	 JGVnKvlxUjEDjn7o34iUTMJfBBJd1qrwDzGN2PqAl6fUsXl6uATvN7QSmQNFQRAPTe
	 9WEFGiu1nEtjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] PCI: qcom: Add support for Hawi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Leung" <matthew.leung@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260625-hawi-pcie-v4-2-1a578603cd86@oss.qualcomm.com>
References: <20260625-hawi-pcie-v4-0-1a578603cd86@oss.qualcomm.com>
 <20260625-hawi-pcie-v4-2-1a578603cd86@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 20:52:44 +0000
Message-Id: <20260625205245.4201A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add support for the Hawi platform which has two PCIe controllers: one
> capable of Gen3 x2 operation and one capable of Gen4 x1 operation.
>=20
> Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-hawi-pcie-=
v4-0-1a578603cd86@oss.qualcomm.com?part=3D2

