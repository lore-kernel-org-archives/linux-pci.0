Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AECF391E4B
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089802; cv=none; b=XHT5TMfqb8020lPAVCOCUva/6jjfPrd/7IhXyRURxlyCUa6gTD1ZSARhZEW61KWDMh4+tPl60Ee9Ssqx43OUiSnV9jPHaA8VH1eGF6rJpeGmlzlUOF35BN3vbaDDpv4qLopuz3McodxbRpk0M6EhXW3pRNLENq0JfobtwWl4iDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089802; c=relaxed/simple;
	bh=uFrCwH2AH4EjciUtPAmRCwXOzgScY26mqFO9o3GTwaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LH8cwf/+1kCcKgp7OZlw5EDDwtjo54mtsVKxBxij6kdF1i2PX30SWt7TB0147QuU7mwseSVsBRHzhpemx9OFo7wj2WdqPQ2nw8Oe9KR0cDGZ9+4v6U4XcOM9qYyiUfKmzsqNPOLJ+ypX/Co1aTX+Skt4B7Dx/FRp5rZ3bP7SiDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYXdhITm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYXdhITm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5951F000FF;
	Tue, 22 Sep 2026 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089800;
	bh=uFrCwH2AH4EjciUtPAmRCwXOzgScY26mqFO9o3GTwaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WYXdhITmpUUr8Mu+bLJ+jhjo0Z6nvjr37omqRAb7OgyW6l6qHkEmJb73n4ng8MEuU
	 1nyW1GYIhKouBUv9GEHoGGyU/Am0ph65DuhBHk13jUDLdDMpbcfh6kOQRAgBtbTFpI
	 ijHtNLREVQzC9nt4Wgbrm7JyHg9VNh7Rmnt503/E1OONYD/eSpuyyleqW6GF2jvR5s
	 uLpqrRSuE3xswR4PGPqXEMOo1YaFUNCUsYlHY7sRBQCpX7X/RczkLvWoDtQ6A6ensD
	 S3jRrzrQkFLcUwQSuBuc028ruDl5hmWF9iFyyLzd5WhRa32zIOjB8qjRFx9uZ++pVr
	 vTAy4ZNvbJ3PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/6] PCI: Consolidate delimiter handling into
 pci_dev_str_match()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB4393A855D592C1F484DEF778DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393A855D592C1F484DEF778DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:09:59 +0000
Message-Id: <20260922151000.8D5951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Callers of pci_dev_str_match() manually checked for the ';' or ','
> delimiter and advanced the parameter pointer past it. Move this common
> logic into pci_dev_str_match() so callers no longer need to duplicate it.
>=20
> As a side effect, pci_dev_str_match() now checks that a
> pci:<vendor>:<device>[:<subvendor>:<subdevice>] token is immediately
> followed by ';', ',' or the end of the string, and returns -EINVAL
> otherwise. Previously, trailing characters after such a token (e.g.,
> "pci=3Dconfig_acs=3D110x@pci:10de:1234zz") were silently ignored: a
> matching token was accepted as a match, and a non-matching one quietly
> ended parsing of the rest of the parameter. Callers now report a parse
> error in both cases.
>=20
> The [<domain>:]<bus>:<device>.<func> form is unaffected, since
> pci_dev_str_match_path() already rejects trailing characters.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB43935D2C01=
946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D3

