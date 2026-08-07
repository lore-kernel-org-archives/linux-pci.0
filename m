Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF8138E121;
	Fri,  7 Aug 2026 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113052; cv=none; b=Fd0RB5T2LH4+Rc+8gH4yi06c1QcgOhMI/uWlirPSxRoDCMe/ArLgQGuWe4x6vX86alElkAReHDVF0wntEHQjWAReSc7rGxYRjkF7qvf6P/MSNqqZ6sU+M4na8DIeIE29pbt+mkj0XlnYGpcxLDebMyeuT8aizLS1MMyeGb/Ub6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113052; c=relaxed/simple;
	bh=+voaySB3X/1QJ8wZeLq0MoEviZoo6PJYEUCBzs7kSdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JMC4gvRDjWN3uQUXF6gHDwfkQmF4YY8bFMxhd5zgj0edkA4Ug1ri1xf1vpkQ+gaJGdxkRiUob/G+j5a1IserNSKs7Sja0Rq8gADYvnwXYac7gZ68J1Esyyvx2lFrnh7lrjv0BCQgPC08/AG2UgYESRHVEMyGsWZv+PdXZ8gb/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSxgVcAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSxgVcAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5A91F00A3E;
	Fri,  7 Aug 2026 14:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786113051;
	bh=+voaySB3X/1QJ8wZeLq0MoEviZoo6PJYEUCBzs7kSdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CSxgVcAQajTwjxqPVOdyipUQoiZG6cBESLTe+t+Y/J0jtHrY5GeH70aoM5fxBfViY
	 mlsqpj1S2+H/c7nAHA9wALLwXSXRPugirvByUnD4LKjfj1JXr4TD9F7VArkYPCtnhn
	 PvxpQm8pOYFgIxi8uoXcQNVzrrNaQebCsVExpI/r21mGJuuuaj9IFOn8S+yV9DEPg6
	 Nj2vtyQrit9n/qsqwUz21QjDK9v11IlI++5qqmOWjyBfeU2Xi+oaLz2lcINyxSMMPp
	 XuaZTSbAH0p1o5RERL9Z9M7z2cpFOTKKP8GgMIbsU5G2jTjAPOfry/9PfWobxJP2b1
	 GNTbAxQNqnlww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/2] PCI: xilinx-cpm: Add support for PCIe RP PERST#
 signal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sai Krishna Musham" <sai.krishna.musham@amd.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260807140205.1070367-3-sai.krishna.musham@amd.com>
References: <20260807140205.1070367-1-sai.krishna.musham@amd.com>
 <20260807140205.1070367-3-sai.krishna.musham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:30:49 +0000
Message-Id: <20260807143050.BF5A91F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add support for the PCIe Root Port PERST# signal using the GPIO
> framework, along with the PCIe IP reset. This reset is managed
> by the driver and occurs after the Initial Power Up sequence
> (PCIe CEM r6.0, 2.2.1) is handled in hardware before the driver's
> probe function is called.
>=20
> This is useful in warm reset scenarios where the power rails stay stable
> and only PERST# is toggled. Applying both the IP reset and PERST# resets
> the Root Port controller and Endpoint synchronously, improving
> reliability and avoiding lane errors.
>=20
> Both the reset GPIO and the reset controller are optional to keep
> backward compatibility with existing DTBs. Also add a PCIE_T_PERST_US
> (100 us) macro in pci.h for the PERST# active time (PCIe CEM r6.0,
> sec 2.11.2, "T_PERST").
>=20
> As part of this, update the interrupt controller node parsing to use
> of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> host bridge node now has multiple children. This ensures the correct
> node is selected during initialization.
>=20
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807140205.1070=
367-1-sai.krishna.musham@amd.com?part=3D2

