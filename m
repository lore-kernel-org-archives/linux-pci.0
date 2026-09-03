Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F4233D9E
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408374; cv=none; b=Z6Ax4OFkv1gCgg1x6LIXdbMH24l07ScdE4VJggNVx2FYxBl7VVPEFxaF9qxMe7OmQEBGJo4mdiUD6V7WqDu/sU5Q2Db1utGxBnEOkF9Opj1RHxlx8sn2Wn6uSFl3fjB2DcH/UJ8La6jHunLEFzcxwvcOm0/sQG6RM9ieu0kwAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408374; c=relaxed/simple;
	bh=KovHD+4SNyES+ZK9JgtI2jAzZ/uHqoFmaM36+k3drdM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jxVclB7WFRrPvTdYcDq9Edz8nOTb3EGi1TCT6TlDCHPy6v3ai5/jldCxaRCu6KSYLRnLaT0nmC9VnbaQ/s16uxNsZHwiFQdR420XAJ8Vp7xJYw3J8Nf7Hph+GZFXsKAlY8qnYJvrcw6G86l8QeE14PaszFW7pGT3OaBioFpDflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq2OiMwc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq2OiMwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADD31F000E9;
	Thu,  3 Sep 2026 04:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788408372;
	bh=KovHD+4SNyES+ZK9JgtI2jAzZ/uHqoFmaM36+k3drdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gq2OiMwc4Qzv/zAVfz07/aKblmYAmeHZCnZcXFBV/V2e6PHvdPK9Xt1KqCoUzJ4h+
	 1abHKY3ov8P4UQn8LJr6g0nnlXTWttnAfDIaVRE9Wx9Uh1Sieu15doMbwN6fbLt7G1
	 r9B8W/1MEcwWOdZ51WVQvIq1hvISpD/jazh3jZK+cGeXf6uXMHhEaiwbVMyc64ViLw
	 sZE4II2qvP6H9kKEM/zkWGMfd9qwGTFfvD3Yu3y34rnQAY4X1vxc9mPFk6yIzxpaU2
	 8ynDez6uHEkWIeEvcbKXgmec0fWqvmtLFD8Se5J73H39roFPZIcgBEXxaHmkInR7Jg
	 S9y8W3zpqBW/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/6] Documentation/kernel-parameters: Add
 multi-device config_acs example
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB439342D6BDCFD10A2B6207B9DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439342D6BDCFD10A2B6207B9DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 04:06:11 +0000
Message-Id: <20260903040612.4ADD31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The config_acs parameter allows configuring ACS settings for multiple PCI
> devices by separating entries with semicolons. The current documentation
> only illustrates applying one configuration pattern to all devices, but
> does not show how to specify multiple devices with different ACS settings
> in a single parameter. Add an example demonstrating multi-device usage
> with distinct ACS configurations.
>=20
> Some bootloaders interpret ';' as a command separator, which can cause
> the parameter to be split as multiple commands. Document that the entire
> parameter may need to be quoted to avoid bootloader parsing issues. This
> avoids confusing bootloader errors such as "can't find command <BDF>"
> when passing multiple device entries.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB4393F337A7=
92CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D2

