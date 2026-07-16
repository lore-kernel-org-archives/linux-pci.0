Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59070423EA0
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211160; cv=none; b=g8yUAxGhWsoDjAmAnG/HBCoweGHBYWHsoHdM+c6NVw515OCT5IV9Krv2tUOtge3ZOj6kadWHam7hXfGyhKkQeXpQwE+5BIE8ErJ/o835UcVKwlbk5EDW7AP/zkM8qcBncF3cejOcArmNhr4WiOmZHLcmW4E37FPapywJhdcssJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211160; c=relaxed/simple;
	bh=WTI/5aaVjPWTy0ul12nSrSsVxykZvAZAhkoX6wGd3mU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ouwYJogYlYRdtOScQOnK09ant00nbzo1LjtIt0NmaGSDkxcA5oD2EI/NkKF+mYNoAoYLSwr4NkSNmxR5rgyqC7BD4XhIZI2EA5RRzeVBfvx/81hDlWLKXoZZVXA4T34hUAh8xOF5oe1Y4hPdwdhxi23OduIbiKDMSRS3ATBvUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzISd9se; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzISd9se"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7351F00A3A;
	Thu, 16 Jul 2026 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784211159;
	bh=WTI/5aaVjPWTy0ul12nSrSsVxykZvAZAhkoX6wGd3mU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bzISd9seufbQ63WGUaB8ICARq7lNEAN2DT14ajNrIwJdnlPzZPgEy7Yf537fSx3i8
	 CpaknHe0lMCgTiPYiD7gWYdt7pqc7NyX1IFLLsDO+GXwaPejlwVmBWMJDvWAOZx9WL
	 OT6IKbuqxrBrVqD7zXedzE3DkMa23EojknHQY0rG1Wbzy5R2GhuPyWRrFj0kQ2QnDe
	 Izwo72/jGp3M+29hhPmGnfo/OpZIs6iU4xN6az5MFJIRXwNEdp2UKumXke2qjWgw5y
	 1hAfL6echxEDIW8oxPRVsWesHntWjVTj6eAnb//RoruiK+L8Gdx4J1eMenWZX3FDoj
	 UIGVP4J/O4QuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] ACPI: video: Drop backlight parent device
 reference later
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <10885673.nUPlyArG6x@rafael.j.wysocki>
References: <12935400.O9o76ZdvQC@rafael.j.wysocki>
 <10885673.nUPlyArG6x@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 14:12:38 +0000
Message-Id: <20260716141238.EF7351F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Update acpi_video_dev_register_backlight() to put the parent device after
> registering the backlight class device under it instead of attempting to
> register the backlight class device under a parent that (theoretically)
> may be gone at that point.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/12935400.O9o76ZdvQC=
@rafael.j.wysocki?part=3D3

