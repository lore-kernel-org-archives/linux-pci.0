Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F939B96A
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742052; cv=none; b=RVB5rkSvwN75rA3GvZvAqM9wXFJDoYEl7PFXAPFU8G+yn4NfBey20SqKSYNncg2Ga4PInZ68z21JyvFU8pZhe8z0ZARXfFov7zqU/QwnQslGNlxA6Etj3avPsFNJkHi3zse3PecGK3O5oDu94Z30nLiRiX4qLC/Myknmeeo3lLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742052; c=relaxed/simple;
	bh=8vCytBaHTaVBEwH4XcUcflKmYxER1fOu/J2H+OGIGkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cKGMOb/KwT+JEETESgTL+LrGk9BiI9zngfw95cgw4sD1wWhRtjPjEqV/TRVY9Mq1i7hs1V1QeRZjJFs9/eA1VK0EgeBHcIlLUubIpl5HwF0czAxZ72LW5D/1VDBKAvWiwyh04+iOfoFy7uYfFLD3qzmxf7eFYDM1hSg/LfdRGh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JV7fFf0h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JV7fFf0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC871F000E9;
	Mon,  3 Aug 2026 07:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785742051;
	bh=8vCytBaHTaVBEwH4XcUcflKmYxER1fOu/J2H+OGIGkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JV7fFf0hqZY4OtHm4UBR8xt3CStSXC3yDGyjb/N+C8Rn78TSM+4CqV66iM5JyWV1M
	 3Ssz+vauCd8XsaG9BJqsRY15KFKmtnTSuaZz1wtRjwIzdti7D/Z60BuQdvKsu/9IH/
	 Tk/+8Yf7juT7OEsFxUgv5G1fH+ttCe6CbiC2pKa41IN6Z/qTqmaH3yISbH6uL5aoYf
	 SmI6G7FpbcR1li6TDm97KjbZDjAiR31WM+UIp+0SBofa3uDGaJmVqmzffcYqa6Eqog
	 FBYyHRmfqZ0gmFxYXVIwq6d08DnKq83rypbjUtmP/CZaJZIYc340pvaelf5TiCtzkB
	 NDft1o8aNFWpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Documentation: PCI: Document how to write PCI Host
 Controller drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260803-pci-doc-v1-1-2814f8672cad@oss.qualcomm.com>
References: <20260803-pci-doc-v1-1-2814f8672cad@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 07:27:30 +0000
Message-Id: <20260803072730.ECC871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>=20
> Writing a PCI Host Controller driver requires bringing up the Root Complex
> hardware and registering it with the PCI core in a specific sequence.
> Add a guide describing these steps to help developers write new drivers.
>=20
> It covers the Root Complex topology and enumeration, and walks through the
> driver flow, including resource setup, Configuration Space accessors,
> address translation, interrupt handling, Link training, power management,
> shutdown and removal, using standard guidelines/best practices.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-pci-doc-v1=
-1-2814f8672cad@oss.qualcomm.com?part=3D1

