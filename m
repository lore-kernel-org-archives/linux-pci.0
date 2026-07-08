Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0CE405C38
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500661; cv=none; b=faUROSE/IVoLo56sL7i+D6siAnruOVqlzAd0R8O/fOHuhB8KkGxiv97508O7aMsD3eEer7Up+H/VxbNKuATEwUVClHb5BxwhhTldVxsKZ7osquue4Hq4D9JTlJmhS9w4PgsX0RJSgnv+TLN+9qc58Rc9vnzcDn9maVMMdkzouFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500661; c=relaxed/simple;
	bh=cMZqZ9YO38cE+obv6m9gSzgMmy/UyYfksDCNiVrCmuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=na6BHbCCglK+A61xNVIuRaie8jr+GiRktMIG8qwNUU2FLhMcZyII8Ssz+xVbSxpwhy+REKfBZZIWC+XQReTcB2l/Wjm5541rMgmiw66zsn5H1GRoqkzHq51QH+Hz1cHItpZCWvj5wc7A7xyENrqN9CTSaSAQYiitwk0EqNqEosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUaSA213; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUaSA213"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9455C1F000E9;
	Wed,  8 Jul 2026 08:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783500659;
	bh=cMZqZ9YO38cE+obv6m9gSzgMmy/UyYfksDCNiVrCmuc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CUaSA2136EeyB360wq0F0LbMiih19zO7t5j3NlFBHEPsxTpfa3JsXcveUpcWX2Yti
	 FnhoBCIbMX/E/q0/EpRyGGoUbhJHLjJY4Jue4eAanuisbcQVuWQ+YIeiDb9Drda80i
	 1wLNOYbDLI393J5r4SbP7L1yrGO6CYblE1FE0mcxpFJK8DdCMWoDCVbSaGgydMNxiK
	 oufg8Kb1ynUVIRv8aSR036iOQqqfq3hTWDdwOZu/vqRPHjfb9vpPQGNmyTGjaO5ATd
	 3HOY3RtHidxRSA1jDRvnkgDXKR5MrjDIxuHYLueqDVS4gvWi4xmVGA0BXbDYQNiSaw
	 HnwYvnf2Ds5cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] perf/dwc_pcie: Add support for Picoheart vendor
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yicong Yang" <yang.yicong@picoheart.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708084507.98242-2-yang.yicong@picoheart.com>
References: <20260708084507.98242-1-yang.yicong@picoheart.com>
 <20260708084507.98242-2-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 08:50:59 +0000
Message-Id: <20260708085059.9455C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add PCI_VENDOR_ID_PICOHEART in pci_ids.h. Update the DWC PCIe
> vendor table with Picoheart PCIe Vendor ID to enable the PCIe
> PMU support.
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708084507.9824=
2-1-yang.yicong@picoheart.com?part=3D1

