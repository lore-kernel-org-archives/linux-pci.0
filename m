Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3E35E1BC
	for <linux-pci@vger.kernel.org>; Sat, 19 Sep 2026 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835772; cv=none; b=dPk0ltUfwTMwIeCZ+DyUh4KZErjWl45Un6x0nWxEqWnD2fh/TTlZ0RGd3DqSdLfj8QS6FN0jubbHyI1u/vHRdgVDMpctSEPNo3MdTEnG23eo6uDhmGlKQ9w/jlEAa1VjIOIr+QRbM/WaFMZzc5bp7NxBLMdO6F4rBDPWNnVzHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835772; c=relaxed/simple;
	bh=I3yllBGjbM52nHcUy+7z/j7YTFhU3hUJhkMz3L76W+o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FpqNFqokQzByBCQQKdNWvzcG3QpLabxD2awAIngXARrHD/VWd14aCcaOl5iaCOdZ9w3pRkf5+CqL2uuzrU+dwbv0p/dIKktDNnXmImjeWtNDkKfgtTOSq9y3IMmjRr1II5XoMr7BxjqUw3kdMMFAQ9tdaWrtnpgrQ5CADX1vlhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRugC/W2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRugC/W2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606991F000FF;
	Sat, 19 Sep 2026 16:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789835770;
	bh=BvrswbfgZvofEL2QY17ZROeI+vebGAz4UzWz/6/y5ic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nRugC/W2u+9HP7Ei+zWsw7Bu4GTzU31Zl/USNu7zFSzBLj09V+1TGzKRYBqAU3AZV
	 WdZMyPFcgpOWQKb6rOj/sn1xJrKF4QV4CEVmtxMgT52VUjPYlVTIQXCRGZMZPE5Swk
	 LcdWJtrMPpI3KFcJZbgJ9jxSFWkhDFdgEqH+Utu7ddAJGyMl/VQ8UNaXnhaW2crwjj
	 V5a+lxbCKjqKFBSbPeA9w2tniqg81eDq53QyFeT+WZEMVgIsURPmIf3mz8+a+Ne9zN
	 NvgEgfnsGKIdocq98XuKPEg8UDEP/KNltNtqQEn+C7iCf57wr9fC8q1j5t72Lqir0c
	 qNaPYn3nH3MuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 5/5] PCI: Centralize pci_aer_available() checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260919162655.3499010-6-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 16:36:09 +0000
Message-Id: <20260919163610.606991F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> "pci=3Dnoaer" tells us not to use AER.  pci_aer_available() reports that,
> and it also reports the other cases where the OS cannot use AER at all,
> namely CONFIG_PCIEAER=3Dn and MSI being unavailable.
>=20
> Set host_bridge->native_aer from pci_aer_available() when we initialize
> the host bridge, so callers only have to look at native_aer and we do not
> have to test pci_aer_available() separately in each of them.
>=20
> Do this in pci_init_host_bridge() rather than in acpi_pci_root_create()
> so it also covers host bridges that are not described by ACPI and never
> reach acpi_pci_root_create().
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@l=
inux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919162655.3499=
010-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D5

