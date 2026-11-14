Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794694990;
	b=09n4PcwKJucykVgD5WpAnQ4bImQYEsMkhsmU4qjiVyROwVIRjiKQweOzXwdqKl6YWViL
	 bZRDvxS0yrcLBNBATubFxNBGYngTjjBfFubnr7JAeoVMWoTDbhkVi3isZxVo8x9nHtGBk
	 jKysW5tOIB4sSaG866Cmo7QZtISt9DXAZZfRBRG67Gve4uv1SnZq4g8lNaQWraIm9MK3b
	 uUfqQ+zCHqte4trI/+Qo05T7NViyMSTRNp3kdUYe9XRIgRQOPCPDaTXAsLhjHdOeqJibj
	 tYC2FUusnCRDxm57aRRD6QsamOhJ/uJe2bbt5Uya1mgu0uhwPoDzo2HfWDLWLDLhCFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794694990;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OOMqF+bIjYYT53a4I95XY21XVX0ROGXgzQ01iG3yAW4=;
	b=2hHrbkPl3XebR5tEte0vcT49TVFFNAIkVkxxh06oLao7zl8Q5Aneq0PRMFcKBQITUSQu
	 ZgrJUF+xORIOOvJ5JyKeXoe/06fSSkpMcSwev+kJXEcgJnSe94pV3eHSr6WyNkBvnJJ53
	 3iwbaQsvh1GV9PWgyjy0OenSujuF2qvLHV2Xg0e/SE83cQuv7lBN+3IHPwGzRaeRMb2cF
	 rSqw3+ktlNyeGeZjI6HFwbIIsTTfiXMXyUHrmbG4Eau0iHm33hsMW+6NJVvdXymK3oSwo
	 VOKXKtqiX993MFnkxyNOnTjI34+C+F9faS9/oHtc+WP6mBj1vx21aTcyvrzpvPA5viA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d/9zXdkK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B409A606A323
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/9zXdkK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5A01F000C4;
	Sat, 14 Nov 2026 22:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794694990;
	bh=OOMqF+bIjYYT53a4I95XY21XVX0ROGXgzQ01iG3yAW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d/9zXdkK18hD7/Bnsq++pc3iz17cjNCQuFMqpMPv+9yXwO2mKFu9IJ3/lya8vRl1w
	 xF7vcQznZozjrVCY9PIo7HBvuYNosymr1TxJzgmBhTR4MUfm1JEBROqq+bSPutPqhY
	 RaU+9jS7Qb0XcDbpmJQtCrSpcLzYzS/Wva2Pj9Gti0lQt4VtjnjaDfaqpCg5cEf5ai
	 FTqt6YodoUtEFqtNZKRS79J7ER43+YsprnnMWLcTvtPrzWkiUERqQpFJ8dTUntLej3
	 kTFAB4o4hagwYeuuAAfSisg8Rs0VfgyR1vkn1ZFpNnMgC7rFD7tXziUvRmvPWbaIqg
	 p1yt93qmFyE0A==
Message-ID: <sashiko-outbox-215062@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: meson: Power the PHY on and reset the
 controller in host .init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261114-b4-pci-meson-suspend-v1-1-be3d04a13304@iav.lv>
References: <20261114-b4-pci-meson-suspend-v1-0-be3d04a13304@iav.lv>
 <20261114-b4-pci-meson-suspend-v1-1-be3d04a13304@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 22:23:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Igor Velkov <iav@iav.lv>
>=20
> Move the PHY power on and the PHY and controller reset from probe into
> the host .init callback, and add a .deinit that asserts PERST# and
> powers the PHY off, and a .stop_link that disables the LTSSM.
> dw_pcie_host_init() calls .deinit on a later probe error and
> dw_pcie_host_deinit() calls it at remove, so probe and remove do not
> power the PHY off themselves.
>=20
> This prepares for system suspend, where dw_pcie_suspend_noirq() and
> dw_pcie_resume_noirq() run the same callbacks.
>=20
> It also changes the order in probe: the clocks are enabled before the
> PHY is powered on and the controller is reset.  Resume runs .init with
> the clocks still on, so both take the same order.
>=20
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-pci-mes=
on-suspend-v1-0-be3d04a13304@iav.lv?part=3D1

