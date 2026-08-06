Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D63C8C60
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046628; cv=none; b=CrUY2Go3jhAk24J2UsPc1Vg/LsxkP8YLqhMpgsohxFaV+fyoe+LvW3Wkgsp5w6rhleT5kcjO6R1XEyAREJzjBDxYCIatJM0SzMtR80Y4lmSj1I+8KPfO7QWt9BFSOSdH7zvNcD3RgQigqtGCYGrYTOHSvnm+MEGpiEoHF7hJNH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046628; c=relaxed/simple;
	bh=Hksxy7ImMa4EYJbywBK2RKUTqmiOSCTMQ3gYSlL4gjo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rLqIBLSzdY1PKr2ZWK1CfMgzmRaDOUDCLFEIuGAiOcUvMyB/O2RROcSp5/+XN4C2pKT2CyvS3drBbgF7y4W2+2kaxhR/CR91d616U4g9SqQfy8c0/f+xVnznZipMiaddhy5UZyv+d7NU2wA0lglv5n02uE01NLGzpg+7opm8tUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rg8rERip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rg8rERip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831391F000E9;
	Thu,  6 Aug 2026 20:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786046621;
	bh=Hksxy7ImMa4EYJbywBK2RKUTqmiOSCTMQ3gYSlL4gjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rg8rERipax4RGktUmDsp5krNOfhq7BcRE1xyDzmBaBOrGHigvMaDjMFkZfMJ4nJ22
	 v8aFGyYLLzF+L9yyyneLaLlOsXQI9am5R+fQOh8sOdGE7NI8v5tP7O6VI7JrfxBLvg
	 maZO4PcZjRhUT916wcto2PAh88TVSjjCr+BY0O2BwuegVdi+dq8c0PNKJu9au/QM1Z
	 /GLgOKAvySB7K+v0hHJkqMcXFrHSA/KcE1uHzzWA0lzOrAFZ8K5wkpwl7VBljAjMcS
	 bYyeFwkVCwYSJP+IVZs4F6s+ZRV9kyjWkkb+Jb6gBK4pgA4FuLSeuYL6mjmJf6pIz+
	 imPvfaI0WBnFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/8] PCI: vmd: Convert bus and busn_start to an array
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806221351.38592-7-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
 <20260806221351.38592-7-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 20:03:40 +0000
Message-Id: <20260806200341.831391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Convert bus and busn_start from scalar to an array to support
> multiple VMD buses in the future. No functional changes.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806221351.3859=
2-1-szymon.durawa@linux.intel.com?part=3D6

