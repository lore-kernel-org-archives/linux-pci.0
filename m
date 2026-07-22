Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5801344AB91
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706577; cv=none; b=ox3k0WpxQvikN4aCoX1kI+1zDpgbkOUkiF9g+a+s1CNm3/lr2uvWBT5C3mewy1o0h+IaNXkLwZnOXMrfJNp6geJaxpP0WrgYlEj+bWgf6WEvnvax/HlFTMaOE/XzHqrDHVdeexrpcw41kILtiQBNjzB5qjXAMt0kHaGxe+2YSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706577; c=relaxed/simple;
	bh=ybOfrsXO6DDNQ96wRVqqJwY2XiFb/sCuqtxT9W6NLpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aZ0vuYm9r/yLah3dgipx9pw/NJxpniFYV6/vsOnDhAOYZ6S9/OE0jKBKmd9Mye02Jmu6zwGlJ+UZj5/X/29h45S+AxlTwF6G8a1iwg9VyCdK9jG5NBBch7Y+7GHC2XfhhADUWN4D8gP27ABbiBusbKHWLe/ilP5YJ/xx4n25JGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1Ke+E1/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1Ke+E1/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C8E1F000E9;
	Wed, 22 Jul 2026 07:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784706576;
	bh=ybOfrsXO6DDNQ96wRVqqJwY2XiFb/sCuqtxT9W6NLpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I1Ke+E1/gasbWRwmYvqER2ZH+RCS+gp6zxgWlUmupH0dDduVwBvc0gigEcbS2tmKN
	 GhFKAbZccbETf/tS6G6C4rgvDhFidvfIBgkcrBPGUlMsMtkeTsbNwRFL0dj8acUhUT
	 X5j5lVRSvGP/lme3GFeE/T4L9bS1AYOPbGj3ZNdLU12hODnMj8D4BTi8XFfuT/kUWo
	 4NEmCZxLI4jA6kCNVBhmUy4zJJ34ost6pi6k5hxFI1G17v3bNys4oAsDjqz85k7Dh7
	 TFIJ44eRwlPBsr27CIWTPJWI10HuVcwRK+xcqzZNelJsg4m9/D7SPy0A/Gj8kiqh/D
	 uTz9p0ICjCuMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] PCI/IOV: Return unsigned int from
 pci_sriov_get_totalvfs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhi Wang" <zhiw@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260722073913.1807677-2-zhiw@nvidia.com>
References: <20260722073913.1807677-1-zhiw@nvidia.com>
 <20260722073913.1807677-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:49:35 +0000
Message-Id: <20260722074935.C9C8E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_sriov_get_totalvfs() reports a VF count, not an errno-style
> status. It returns 0 when SR-IOV is unavailable or the device is not a
> PF, and otherwise returns the PF's driver_max_VFs value.
>=20
> driver_max_VFs is stored as a u16 in struct pci_sriov. It is derived
> from the SR-IOV TotalVFs field or from a driver-provided limit, so the
> implementation cannot return a negative value.
>=20
> Change the declaration, CONFIG_PCI_IOV stub, and implementation to
> return unsigned int.
>=20
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: David Laight <david.laight.linux@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: linux-pci@vger.kernel.org
> Link: https://lore.kernel.org/all/DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com/
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722073913.1807=
677-1-zhiw@nvidia.com?part=3D1

