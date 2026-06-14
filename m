Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6219D074
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781404301; cv=none; b=EQrdm00OFsAxN55dTlIfxFl6YN57PcHneZFgMGBrnjnM/F7EqdTQ3o5LatAqY7e6jE6hNHgUsN3aHsVk22NBwnQcdgzm2Jtajo9+RAcUrKdxGfYO3wqo3aYdzLXK80Cq/eHPztFAx4DG2gQ2o3W8YJa7zHly6PlQTuaAQ2crZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781404301; c=relaxed/simple;
	bh=yOw20AfG2+pooGtXtuJFspV/3rZPgd5XBJgt1m2qhr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XMPWA9MptjGpXufoDP4/bCr5AKMz2FVD7zwTK6fB+G0arN1kNWiWhQnmeQ8PzQuXid6oAnjTkTCXozd4doH0eRMFB4RJcuxxkxGwLozJJdUjvS9QyylpzKNtf98hfvWyy/YgkLwCBJaq8nuhFcudKuXMAWXlKvbFZTriMHkzMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtHZKELW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtHZKELW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51F41F000E9;
	Sun, 14 Jun 2026 02:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781404299;
	bh=yOw20AfG2+pooGtXtuJFspV/3rZPgd5XBJgt1m2qhr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dtHZKELWGFvnhDX4uxjhuge0h+yEmZEOv9b3qOVGUUqMatY/Omtt5J3tj+EddjS4U
	 I3xlcMjDkzX/li0rRKL5NzL2jqX+IIQ3ydIcnNxcztUXSNQFST/30iI06c36c9HwUk
	 23tWfO+LWwkFepdCv2TEE+IcVWUyoLcXdzgUkJP0Tw+iubB7+Ee0OSpOr8rAa+Ikwe
	 gI3vDzZ8s2qOfdD3JfNLBysavb+bTQCRyngyVoLBKWkWKZcYTvwBYMUEVpsapSUJjh
	 CbnJLfZuWm+ZWvuGU2ApBLxExl11cbUWbXWIk1JB6tweD580nEkFfsJBWWotuaE+BA
	 HkiCRgLchkmug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: meson: Fix PERST# timing by asserting reset before
 LTSSM enable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gowtham Kudupudi" <gowtham@ferryfair.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260614015620.20432-1-gowtham@ferryfair.com>
References: <20260614015620.20432-1-gowtham@ferryfair.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 02:31:39 +0000
Message-Id: <20260614023139.A51F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On warm reboot, the PCIe controller's LTSSM starts link training
> immediately if PERST# is already deasserted from the previous boot.
> The driver then pulses PERST# for only 500us, which is too short to
> properly reset the endpoint device that has already started training.
>=20
> Fix by moving the PERST# assert/deassert pulse BEFORE enabling LTSSM,
> so the endpoint gets a clean reset cycle before link training begins.
>=20
> This was found on Amlogic G12B (A311D) with NVMe on an M.2 slot.
> Cold boot worked because POR held PERST# low; warm reboot did not.
> The fix was confirmed on a Banana Pi CM4 with Waveshare IO base board.
>=20
> Signed-off-by: Gowtham Kudupudi <gowtham@ferryfair.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614015620.2043=
2-1-gowtham@ferryfair.com?part=3D1

