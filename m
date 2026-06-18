Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740B73DB319;
	Thu, 18 Jun 2026 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775031; cv=none; b=lrINnpAB9B7Dx/fXbq0F4Dfm5YmZ8y7VVxefdt9GVCPWrev4mHQU2pN3kKSbvnlTNRcJA+/y+pOU5xX9UsikPA0/jQGGIfVQZzaA3sUJFJ2tt+CjNg265JjTzMQXfRX8mr5a7z8FRzqd0MxHQCZ3O+G+TTC9hPWkPuvDS8toFME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775031; c=relaxed/simple;
	bh=aG4sDJKcE+ObS50FC/wjH6iMdD/grleJ60Z5wp+fN1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b5rE3QAMQVzJmFsq3EvL4vOspOzUp53rRf8cXzhx9+qRLsTu/63Tg12n04fzwlW4h9zWm3IAp324eTe3uNXmGtgP5Ct5clOh85i1s44aPx+4NNV63qc2JoqBWydY+nMSOK5RDFOAHtHL9o1xWt3HAXk9ObBMfChVT77IuTs42WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4DI6W9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4DI6W9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92751F000E9;
	Thu, 18 Jun 2026 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781775030;
	bh=aG4sDJKcE+ObS50FC/wjH6iMdD/grleJ60Z5wp+fN1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c4DI6W9xrcnDKjheC6mqIbG4/GJpMoRA/czTju18zeufJsw3UJr3eDJKP8UdG6Bqm
	 pt2ZoInHLSGVK8sCM8QZhk4lGfjMzn2tVvP5/c2s4j/k9yuvzWAWDUFm0uQH0NpwhS
	 mbVrUqfgc/7Wymzqf2m2FpoWStayToDUJdjB3FmsXLDuEhmJd/UjnOZ7NTu3f6JmH6
	 kOx+/sq03YIOAwJJr97uB3GDVDLxXeIadMChoKqnuBrpgrHlJ/ihaxMaMwWVZ5Xiu1
	 22B9samu6uwD93sIuZ1m8McTJmit79C+qwNud5tQ2F4/2t68+JpNfoFK1G00Uz7kFW
	 XrTNATPHT87jw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] arm64: dts: imx95: Add dma, intr, aer and pme
 interrupts for PCIe
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, robh@kernel.org, conor+dt@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260618092100.3669556-3-hongxing.zhu@oss.nxp.com>
References: <20260618092100.3669556-1-hongxing.zhu@oss.nxp.com>
 <20260618092100.3669556-3-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 09:30:29 +0000
Message-Id: <20260618093029.D92751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> The current PCIe device tree configuration only defines the MSI
> interrupt, which is sufficient for basic PCIe operation but limits
> advanced functionality.
>=20
> Add the following interrupt lines to pcie0 and pcie1 nodes:
> - dma: DMA interrupt for PCIe DMA operations
> - intr: General controller events and link state changes
> - aer: Advanced Error Reporting interrupt
> - pme: Power Management Event interrupt
>=20
> This enables enhanced PCIe features and capabilities that were
> previously unavailable due to missing interrupt definitions.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618092100.3669=
556-1-hongxing.zhu@oss.nxp.com?part=3D2

