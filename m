Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484C383C66
	for <linux-pci@vger.kernel.org>; Sat,  3 Oct 2026 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991239; cv=none; b=IEhHvnevZOFuCWSt3oJSzARwVCJp9LtUSzS4Xlh2EQm8Tc+U0WVfGlNY6DIO095rQSy/+bPs2CA469LD9u6b7zs9j++xf21/A2eFeJj8oq8ant1b3K+6CA8K/dvvvHlfh6OmafdMXmnhrqtWUQaRk4FescLGOV3jMsqvDDCoyMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991239; c=relaxed/simple;
	bh=3Ohzu36U/Kn0Fg1GX9Nb6S8vz9llUvVpWSf1FDoUJDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=swUcuozVeqW/oYl6ARDc0YDwQViM089PXXo7iGW1/2JK0mTSF1Z52Qy7Ft4c75VVXP/89ccutaYDwwh9tplODdlG+63H5dul1dcVxtr1v7zGf8mR9e4JEVoKaq+gMgVIX4SnqY12M3eSldYbQZ2nTxrTVL4FoKufZxnHi88WjLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSdoERJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSdoERJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9E71F000FF;
	Sat,  3 Oct 2026 01:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991238;
	bh=3Ohzu36U/Kn0Fg1GX9Nb6S8vz9llUvVpWSf1FDoUJDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HSdoERJefvV77g1//eiWwDHLo/z1zfGExYOktNcv7k1BsaWyRTu9Kg2SLnHOv71B/
	 H4AlYNSM2MRL97khON/iR1gcWJVRhP7BkrffT34eiQCnvH4+yb19gUQBD9k6iqT+Q+
	 MHBluA3sdGN8IrPZOwZauzd8VYvGqfwfjilAJhIgFMIJS6n4DcpMCjF7a45TBkC5Jl
	 ssa+LNNdy6OD+If04/k1qYiYyuZKLpksmAgNnIlzpGAy9Iy8MnKEHUC0b/DK574emP
	 vcNNKcDmq0MUJ7BbH70yd7amaMl7wFULpgepSsrISVe7ptkjG/FAHuKWqs7uQqVPPR
	 BXl/rPRcO54zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 1/4] PCI: Assume control of portdrv-related features
 only when portdrv enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002211828.1293177-2-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261002211828.1293177-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:57 +0000
Message-Id: <20261003013358.5C9E71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Native control of PME, AER, DPC, and PCIe hotplug depends on the portdrv,
> so default to native handling of them only when CONFIG_PCIEPORTBUS is
> enabled.
>=20
> Native control of LTR and SHPC hotplug does not depend on portdrv, so keep
> defaulting those to native regardless.
>=20
> [bhelgaas: commit log]
> Link: https://lore.kernel.org/r/fcbe8a624166a1101a755edfef44a185d32ff493.=
1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002211828.1293=
177-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D1

