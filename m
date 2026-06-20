Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF5233932
	for <linux-pci@vger.kernel.org>; Sat, 20 Jun 2026 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781975660; cv=none; b=sLbxounZtjkOPo3CMw6zs7oLWwyNwdWVdu+glkxIU+Ac8KI9EHvdB52zH+PQpJ5ibnnq3d8s2sz50CdoEi4Vz1ymwlDr7Hk+YxRAJ1vHoa5F7nyh19oF1DqBuP4kMIZT44FFLqkAx0NPZfGTC1brpC3jVMGug1oY629mTXExEiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781975660; c=relaxed/simple;
	bh=zz4rnXS0wi/0kIeKRWntBitj3rIhOspFTK13URcVsWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DV88WeOPJ7troxqpLB2KsT8nLmfT4PqnzylFkxpWlshLtCUVSaDfrO2DfmHDyGD0vFb1nZQeYBUMrkXIfAKJBIay4hbkTw7EN3UfDMPdU3xnCMXKxZEW4wuvDpjd4lE+zCMuT2gGLDVgsHeQjTuo1YDzUgIKZPlNPwaYDCNvef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHYppI31; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHYppI31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFD41F000E9;
	Sat, 20 Jun 2026 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781975659;
	bh=zz4rnXS0wi/0kIeKRWntBitj3rIhOspFTK13URcVsWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jHYppI31I3fAmJpwFVT9jCgG8QS2QyQ/cSFIydvMUJTUYDM14SfE/qkUgOqX5kobM
	 7dEaospp5eHEUo6tocmvPA3v0w20YDFYcWHD/d6DgiYnojvr8blYINRWkNB440H03e
	 vKzmd62ij5gdDmCweKU2sKMJs+C6Hq30xgQwAFGVaHntJICLQv1r3vFWeZChrzT3o4
	 3wbx8Yq4Zpfl+GNl2p5wWTI3cEKIR7hRTl6joqt6rOhXHtDt63IVMTA4+EudgIzC6l
	 tSUsSC/aTApRCBbbvzeCEoDmBRp7v5b+wbjrQGeYLYwlUUNpbLXac1pU3WZyjBRcVp
	 qAQZ/XX5isNGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260620170438.3756593-5-den@valinux.co.jp>
References: <20260620170438.3756593-1-den@valinux.co.jp>
 <20260620170438.3756593-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:14:18 +0000
Message-Id: <20260620171418.EAFD41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Expose the DesignWare endpoint-integrated eDMA register window, logical
> DMA channels, and linked-list descriptor memories through the EPC
> auxiliary resource API. This lets endpoint functions decide which
> channels to publish to the host.
>=20
> When the DMA register window is already visible through a reserved BAR
> region, report its BAR and offset. Otherwise report it as a normal
> physical resource so an endpoint function can map it. DMA channel
> resources carry hardware channel selectors and refer to linked-list
> descriptor memory by ID.
>=20
> Expose DMA resources only after the local DW eDMA provider has been
> registered, and only expose channels whose linked-list descriptor memory
> is available. DWC non-LL exposure needs a metadata ABI and host parser
> extension, so leave it unsupported for now. Reject VF auxiliary resource
> queries because the RC-programmable DWC eDMA/HDMA register window is
> assigned to a PF BAR only.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620170438.3756=
593-1-den@valinux.co.jp?part=3D4

