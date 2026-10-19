Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55A65458BA
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418799; cv=none; b=u6Hc4nVnEAbAftPZ2fhc/Vgo1HGJpSXnXol+oCoTmZZvIHcmso5jtalLYrpN/yTfcmUz8+Dj/UkXrHvcYZJZkrV9morTG8nEZ8BIWA15rN7TevHQaD16nrRh61pHwyWS/td8gT2DtzVr0uIqjMxPm/nWDMC5+IKYOYkS9XYRh9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418799; c=relaxed/simple;
	bh=p+J+JDHiWIjo9Ft+8dljD473DurjetYAYbk8pfXkie8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nBCKY0leR6MepR1OIHyu1iZ5p50vYkaXcGLKvfbTl53SQ7zxKYd/AOeITwFYbFCN1d7reuaB9Sc05VcSGtKPd1d/CZ+Zd8mUMTmFPt4TzoKR407YtZLYOn464jG8hgkpmHqt5/UoJxmNstWXNZHKi4X8Y9/DDK0qmt18XRTZCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jj/Mr6Ud; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jj/Mr6Ud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC3D1F000C6;
	Mon, 19 Oct 2026 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792418797;
	bh=p+J+JDHiWIjo9Ft+8dljD473DurjetYAYbk8pfXkie8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jj/Mr6Ud+rMYZUJlTScFLRQV5UmgdhhJTXUjf8A6mD3lqb9hYhjx62ok8CXtXraUf
	 hNcr8d1relBPD3srnJzq6NwOQvrWs3Nw04+/uBMi1CTTB0rE5CjvsFAIkiLqY8eu+n
	 FBcA07q0t4GJy6ih0NoC03HHiqz4e9gC/jSsTYaTib46yj2wmGyo05ZufdqhO4ODMr
	 xjKTU97OzbmAYrpLd8UHc94YXbkrHbiMd50tIkRoQTz0+3V+Q8kPw/9N7yedM4PUe5
	 xLlqZb1WhR6G3WyEBpEhoH1NDV1Gvol6/hp0z6vUEcb3SIMcm4Ka5sB7KS/8yyPr40
	 shbYhlmeEgrUA==
Message-ID: <sashiko-outbox-177288@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] PCI: switchtec: Add Microchip PCI1008
 to NTB DMA alias quirk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019135441.1420968-46-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-46-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:06:36 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Logan Gunthorpe <logang@deltatee.com>
>=20
> [ Upstream commit 00a479ba1d01249d43ca5e453380d1ed60946f8a ]
>=20
> Add the PCI1008 device ID to the quirk_switchtec_ntb_dma_alias PCI fixup
> table. Without it, DMA transactions from a PCI1008 switch's NTB function
> are not given the correct requester ID alias, which can misdirect them
> under an IOMMU.
>=20
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/20260714212010.230606-4-logang@deltatee.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-46-sashal@kernel.org?part=3D1

