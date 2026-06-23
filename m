Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907130CD89
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206001; cv=none; b=Sc2cHdTcCepI2sRbkyeN+Au0jXV4k8La9FIDcgmz70VTPBNqdhIdPeV/3CPIW7iQITDloNFkkVnyO13VZSEhYJNjIy85dvjLblqDpwkBKsRMMZDf8xFGeHPCCyBSiMYlTkuF+kLUPatgA0swvBRVkSqs2+08xWGo8dra6A3lN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206001; c=relaxed/simple;
	bh=Q2VbUM95a0Nl/tcQuRqF0IdQ6roBqNwz6JdXVmCFtYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TvHKJgJ3NuScFAchfBkoiiFkQQe12lENPTn6Pk+L2vguR3pzH9BINIUMvlZstPpHG2433LjLdZE25OolWlM/wyF4Bs5ZS6akfZeHL1G5NEnfNkvPsNyj1Dt3Bj/nAC1AfNZUdYyLH2iQ/2cIN2HLXgFSgvKM4AUYO3zMD96XvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbNTTyk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbNTTyk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF2E1F000E9;
	Tue, 23 Jun 2026 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206000;
	bh=Q2VbUM95a0Nl/tcQuRqF0IdQ6roBqNwz6JdXVmCFtYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MbNTTyk6wtqK+/XfRfkohdFjufO9L/vadWCxRJ2HvZASzPbwxc4LcwYAKzfPdyfLZ
	 zY5uGHY1p7u+5DdCy9AWVrvbby7UyAwo6HdCSMcB+IQghEouQbsW1iwzQYEIbnpArZ
	 +ZlcTFhEEsGCqruokdEmCtbXEWQ4ZzSBhDDKA0s/Hoj4McU/7fbQFSwnwv5Y77nr+m
	 3x14ePISjeftzrEZrT+OYwatzk8wnLt+miXy+oL4mLWuRe25oPDsWsDCxlw7Ldtqh3
	 tKC3+iH+jGe5S7OGWvhhwMnWN/tajA6rZg+TW6zmVouXDXgSmXX4Mr67wq/42cJ6b8
	 KDwicUnzONaTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] PCI/DOE: Move common definitions to the header
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aksh Garg" <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260623090737.711656-2-a-garg7@ti.com>
References: <20260623090737.711656-1-a-garg7@ti.com>
 <20260623090737.711656-2-a-garg7@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:13:19 +0000
Message-Id: <20260623091320.1BF2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move common macros and structures from drivers/pci/doe.c to
> drivers/pci/pci.h to allow reuse across root complex and
> endpoint DOE implementations.
>=20
> PCI_DOE_MAX_LENGTH macro can be used outside the PCI core as well,
> hence move the macro to include/linux/pci-doe.h.
>=20
> These changes prepare the groundwork for the DOE endpoint implementation
> that will reuse these common definitions.
>=20
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623090737.7116=
56-1-a-garg7@ti.com?part=3D1

