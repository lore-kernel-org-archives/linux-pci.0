Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4652F6931
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789082929; cv=none; b=ZbsDHoboke24rn+Sm8ohiuGUvRxl/nkgkXYvJCogfLSr90cvmyw+5b1RUjP44ltpWFe84aBG65+K9vw0nD3xG3mlvcLSxC8Ww9R29Pt6FDyGFtzHVvN78MwTkWFyFVrvTihlLHu0X1myDGuSzQGB98v2Yi8yCqqKc03V+a7o+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789082929; c=relaxed/simple;
	bh=+vTR1pLIr+s8Q4WIBZg4ayhJrVdC2sNqpCkfBqlGpUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fbx0KPk26f6wGBxepPKppDNDFxitTXEe4XTtd8ritHiOsSgc2Bp9RG9XIVXlkEw7ZyjumXA117bHamnrzMpETiLQt2IjxFKYj3jD029gF59YIPil25vOqc1dlFD8CxsGYekMIrR6z9xKVZTJONRmLlMb02+qLSMoPs4H1JvcZ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTj3qDFv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTj3qDFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135D91F000FF;
	Thu, 10 Sep 2026 23:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789082928;
	bh=+vTR1pLIr+s8Q4WIBZg4ayhJrVdC2sNqpCkfBqlGpUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BTj3qDFvyd8CZl2AnVrnBgMQwJCY52tZJ0wf8ST9KThx8TghqQ6eEQ3bKuxLPHGSP
	 I0ymhwOSxtHwbV/DBbzd5aIILkeX0F5+dz8PA/Y8JVF7olDJV4ytsy4IEKeHmZrxxA
	 S7FIhM06WDaOToG5Nfpbq8wvO8mj4LzR2bRhN1zmxk7AWaVGasqjFS6+LTiJwI/Bmu
	 F/5mIinxmV+sI5wEpTDpDnHtLVB7hKrVKXiQ22jSvlVe19YXgMCHXjz+8yXXCVM1W2
	 FabESuyaxr3CxUZz2R4EQPiJrBV8Ms9Z0U57LrwPT6/QWllhc0yVzgll6NnOtkFqkC
	 8gWSRKt7uEOLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/15] PCI/ATS: Export pci_enable_pri() and
 pci_reset_pri()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <49ce62ed61bd2c0626bde44aca33c515bc8acaeb.1789081084.git.nicolinc@nvidia.com>
References: <cover.1789081084.git.nicolinc@nvidia.com>
 <49ce62ed61bd2c0626bde44aca33c515bc8acaeb.1789081084.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 23:28:47 +0000
Message-Id: <20260910232848.135D91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>=20
> Export pci_enable_pri() and pci_reset_pri() so the SMMUv3 driver, which is
> tristate, can use them from its probe path when built as a module.
>=20
> Link: https://lore.kernel.org/iommu/20201112125519.3987595-9-jean-philipp=
e@linaro.org/
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [nicolinc: drop stale or already-exported APIs]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789081084.gi=
t.nicolinc@nvidia.com?part=3D14

