Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117635;
	b=XcfXRus4PE8x7hp3Glekdkh8Pe/ewRthtYUdKtCYyAs3sMzBXl/w0QPeTAaDTsYfC92G
	 HawQ0OWBQC4BbDjLFdFn9i2I8jvoRa/YSkZLKLa/UJ+mqomP5DYEG643fLYQjRiYTCNyN
	 Ltk17e4Uvn7hOTfZpGFiVudHOqJO5RC90ybPsWRXBOHjdsWFGex+Yut25WhikDSq1zXwe
	 MSTvGssj1/sQeqNW7E28ZczewZCUv7lnQbjeaknq50hj0+qFFTxuSfHCFYWbsY3xFPvyi
	 CMwap62WUuUX2T3SN8yA3TPUw8fYpqU6tbZDGyV50gjTIQ/ckpfjpiIHwVKc5NT8TBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117635;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R4Teu+dtY5ytDXWLvk9EX3DijLAxS0CHpLR2Yb87IqY=;
	b=DwksWqJzi+7rZNfX9jTsSARGRa7pHBY2H5exZMFFS6V/adY1Gv4hUyDI9W22iDxUgvjM
	 JS/pB2BLMcSIDd6zw0+KihsKZAHslYLikKJBeZrmTU1eCR2aIZy84Bw0+4X035IYOHJ6w
	 aIl92tX+8JZrCKL37c+22bVhGCpuhWxOdBKfqHhJbAsSFufvxTiM/U/AYHapOqlH/+cia
	 C/L3zDl1hymUC5bHmH1U74R+ZuGxUBCPzsBc0tIE+JxaK9Qy/pax/CD6MJ2rJOZaFAprd
	 YLoS8Lo0uZdrcSfUE6Y0dtiHY12kt57/1O3VzfP8DltsSCPq/gyysHth73hfn8ktYKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSxlK23F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3267D606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSxlK23F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBA21F01825;
	Tue, 27 Oct 2026 16:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117635;
	bh=R4Teu+dtY5ytDXWLvk9EX3DijLAxS0CHpLR2Yb87IqY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FSxlK23FcNt8B+9RBAFzl3ypRDU7SJInhQF/wSqSerEqZLnmBtaY24p4scgXkiBzd
	 BN+reRB0cKvz5UV8BlyZlNcYaFL4F9S1ki4G4Ln4I803GigjinxkyzwREaARlAxDi/
	 xZp1rrY7AlM6Xc7XQxW89NmfsooRcLWmYsL/bPh1yGkNNtjYXwGGJILuRcHmK6KUhH
	 9tnB2hloLEdo3ADjZ6OtdVmcdhL20yA4r1Em5htAEfif7NVrsR4k2I3dHSoBG1BEP+
	 oVmVad7jV2MCAABJqgaG2r0nArzdaJqTLSZ2l240SdNeTIpJZBhygK7yFuQUWjy6NC
	 3PQ1nOCFLEG2A==
Message-ID: <sashiko-outbox-186885@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/13] i40e: Drop VF MSI state restore from PF
 reset_done
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-8-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-8-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:13:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The PCI core now saves and restores the config state of all enabled VFs
> around PF reset, including MSI state. Remove the driver-specific
> restore, as it's redundant now.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D7

