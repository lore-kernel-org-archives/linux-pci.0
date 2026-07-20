Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566A1A23A4;
	Mon, 20 Jul 2026 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513456; cv=none; b=YiyPAhhf4zDlwu7Cow5vZA+Z1DER4pN8gkzuE9fjekldReRW99UMWIunM4F7rp+7h6VJsh7U3kpjGqHukl1bVTGf7yGT/C7IRnV7puAyCLh2xqS9OOmVnz4Dtmu8ApzgvDIed+eGpTrq8Bxqzyabbsko5PkCQVDa6UOFz2F/uvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513456; c=relaxed/simple;
	bh=Pv/4VudUR98aCE/FepFKN5IGZjQTs1Nydp4XGL2WtYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PKwcxKjupWFmv/Dc5faITbMCANi7iNImJPsMJf7lVTr4jwzw0iwka3JH0+RsjWdl2ajddg6mEOgpLIBjk6Kg+LYq2FQQNKUBC7h/bC+3DcSxXZ+Xd33xNJkSvQuez2KsSVcn9PmiQLJ6K11dtZXgaNLe2AdyxvYoiIsaKBsYjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/6Xk527; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/6Xk527"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C991F000E9;
	Mon, 20 Jul 2026 02:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784513455;
	bh=Pv/4VudUR98aCE/FepFKN5IGZjQTs1Nydp4XGL2WtYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T/6Xk527i7X5Jh5EK90YwuxsJFec8lL2ivYFsuZvrV5pjYSvrI0drAOdgQ/DjBm0F
	 PDTVILkuazZH4fg5FD11c4wXLoDwx3PFSQ/2K7OWWqgmpQa67nW+Za0WckLW3EQVCq
	 Obd9yFQmTQVRchhyd3P8LQh/afA1YqhQL2omKZLbxvLpuH4xR35Le7g3eYzy1gH6jc
	 NlAcgTtEQHaZQ8Q0yKuQejd32TDgYXZPKUW8pTRC4bI9RvseO+ZJW1ah7rJgFtVKed
	 TMuo4MWOa8g2Gf+j/Kh0QBUJYCOxZJcPOBamx1k0twy5ogyftvFv0SmcpTviyhKmIs
	 Y5J0VuiGza/Cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] PCI: dwc: rcar-gen4: Split .start_link into
 ltssm_control and speed_control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260720020505.315335-4-marek.vasut+renesas@mailbox.org>
References: <20260720020505.315335-1-marek.vasut+renesas@mailbox.org>
 <20260720020505.315335-4-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 02:10:54 +0000
Message-Id: <20260720021054.A7C991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce new .speed_control callback and implement it on R-Car Gen4.
> The callback implements the second half of what is currently present
> in rcar_gen4_pcie_start_link(), and rcar_gen4_pcie_start_link() does
> call the .speed_control callback. This is a preparatory patch for
> R-Car Gen5 support, where the .speed_control implementation is
> different.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720020505.3153=
35-1-marek.vasut+renesas@mailbox.org?part=3D3

