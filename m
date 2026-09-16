Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2994C9561
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553173; cv=none; b=L0ghH75E+IaU6Z5SpWYPgmzAIlFY0joAg9RjOi+2d/V3ezzpi9dboGPY8/1R4SRNzkpvWH7FZDZ2vVWmMGXcB9ik4CCy3NU8Wh7a8VGMatacqyQbpUglpMXYISJSxh1JSwKdY5KNr6vDzuWhJ8l6r0sUGdSoxFy0XmfBVAXI5bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553173; c=relaxed/simple;
	bh=u6KAM6xzN1IAGy26mzc9FR42b249szAjH+M9039CsKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gy5CQjCMLxcgfyOUTwX7Gkv0MhWdZUr/Qe6ddteJSLUxKRGbqglPxUt/EufxxRe7cdb5Rkzjd5oaA7/xiPbZFysXSRoEp+JTkKxrN0eaPbjb2Z0y6LnwX6vvqni53iltu1T9g+ExuN5NQIa10cTeaN+CKETGI/zwn0U1PtSkp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyUYewKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyUYewKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9086A1F000FF;
	Wed, 16 Sep 2026 10:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789553143;
	bh=u6KAM6xzN1IAGy26mzc9FR42b249szAjH+M9039CsKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UyUYewKsHon6fuxP0I4oMf3S4sOi0HHfZID8c2sFsnWp1MvMuOJrpxfwxj8X+pm8y
	 2d/1CIjtpp2HhUXlDZ1h60ksgRCYbD8ijueDeEwma/jbKMnx+CoeunGUTs/4GShCWv
	 hyjEDZQFU0ca8S3tyBoOOLLpx2QlY6SRFoQzpBd3Thk6kQRJKLiOIbhOAsWIawJG7t
	 FAmkv2cyOre2KeiX3TLSgZvMRGmmMbRmTCvEVPkmoATFR99LsdASF0h1WleulWq5du
	 VO2uWUECpOQ2saQj69eVoHgyMUHeme5xdpfjpFV2/iOEhD0+mbv6OVQ/z94+BxH7SU
	 s5Eog1P7ry4EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260916100206.92853-2-blum@kernel.org>
References: <20260916100206.92853-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 10:05:43 +0000
Message-Id: <20260916100543.9086A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> returns nonzero, which avoids probing functions 1-7 on single-function
> devices, but also stops scanning when a function is absent on a
> multifunction device.
>=20
> This can skip early quirks on multifunction devices with holes in their
> function numbering.
>=20
> On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
> 00:1c.3, also documented by the model list in commit abb2bafd295f
> ("x86/quirks: Add early quirk to reset Apple AirPort card").
>=20
> Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
> 00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
> stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
> is silently skipped on these machines.
>=20
> Check function 0 first, and if it indicates a multifunction device, scan
> functions 1-7 independently so that absent functions do not cause later
> ones to be skipped.
>=20
> Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916100206.9285=
3-2-blum@kernel.org?part=3D1

