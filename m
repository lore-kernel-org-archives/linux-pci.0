Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8EB443C12;
	Tue, 22 Sep 2026 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067283; cv=none; b=vEoA3jUWlohFqq5vvmzG4AXjRxe8GJg+yze7nnH1lTVSjK8WYdaN59KsEMQes6MWXW1d+hOtLT6H4aVcG1zFZEhZD/DrKLr2EWGQ6rCJuJSy4euAKGk64Nn2cjdpn7rWFOtFMFTEJcvIgxIzP/+dOlbVGUc/5CxnvZ5GxTKWBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067283; c=relaxed/simple;
	bh=F46UIH6zoRyesbgyW42PCk44xHy05h6KSvAS2zgTaqc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TKvrqKOSlD0OZTS0uh76sNvcyz7eypgz8fgvboLgsGGU52yGDSCglHBt2Z1jvKW/i0lAFFUkRVeAmO4Ca39QyAVbQgCDSwKDxH6DX29zSlEIxP5RnwDHYHT2OBYeEoMijYpytiEqCfuTdsnHlgxNvf9B6ikjJ8/rwPkRQkZHSys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7ov7ICn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7ov7ICn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F125A1F000FF;
	Tue, 22 Sep 2026 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067282;
	bh=F46UIH6zoRyesbgyW42PCk44xHy05h6KSvAS2zgTaqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E7ov7ICnm6+M1xVbkhhAukHwdGZYoVebrg3nU/Y78VPC7ibdKnCoauMSQS4dxqit9
	 XJK++zA0ayGt2E8d8XqHaG/o/F1PCpnCXljoOYnzyhdkFYO+WrjIZHJu+L49rEKLZ/
	 7j3tWQth+z2p9pY82V87tgHZhZy0H2gtxZkB8eVDnFLFKn3UZ12Oy83k++r7seQlv+
	 +YG/PEY5tYBBQPI6vnB3Rl2/HjpuJOYrrSFCbgZNBjcC9DJST+gt56C3M1PDIypSg3
	 UN+GCtZPgjAk9UAAeDhqB1CtXE6nlW7TLsKHtkDz54mkeHySEgl+xbS4fwsUHRgkBI
	 l2UEiAJDbOS/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 09/15] cxl: Cache endpoint HDM state during PCI
 enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260922083924.2451158-10-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:54:41 +0000
Message-Id: <20260922085441.F125A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> PCI capability initialization runs before BAR resources are finalized,
> while driver binding is too late for driver-independent reset support.
> Create pci_dev->hdm during pci_bus_add_device(), after PCI resource setup
> and before driver binding.
>=20
> Cache BAR-relative HDM location, global control, decoder settings, and CXL
> Device DVSEC Control, then publish the completed cache under cxl_rwsem.dp=
a.
> Restore PCI_COMMAND after temporary MMIO access and reject decoder-count
> changes.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D9

