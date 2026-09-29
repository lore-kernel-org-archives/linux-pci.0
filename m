Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818630F92E
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 04:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790656941; cv=none; b=c4tMRCvONtW9jy5Uu+fZmy8f77DkqToyvRdGKopnIuFiSZtS54AG5eKlel83wxC1lMZiPrGVJnII4s0Grm7/mKTiME2kXL6OAungJvDlxrQIjfNT4uwP8WCQsVWnkQ2OIvJ9cdbmtCCyxjidedZIFXR6K17zEYLYqAHJXq43KBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790656941; c=relaxed/simple;
	bh=K713UB/p8cSGbaHAkph+dnuYxA/ZFNmGAmLX5pPyJUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pn6/ShSs9DAhuJ9XG+2zxpPyNiU+985Y2npMbl6yMdiP1EBi3U1VrSfk409ytYbK34FPH8nAqRYC94lzJauuyFl0is6MtSgfmE963jgJ7ZILc5X8MQFapBiuLV9yH17qlH4h1Fayq4DE2LxArduHE/OASVS8xxq+37sPu4DMH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+swixT0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+swixT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5D01F000FF;
	Tue, 29 Sep 2026 04:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790656939;
	bh=K713UB/p8cSGbaHAkph+dnuYxA/ZFNmGAmLX5pPyJUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h+swixT0YzCz4DX3He+Kzm0GO4+k6d8N6bQdeOGi9KA6RLU+Oe80lP7fkBbb7lFzD
	 WLIAFesBGTQelo/wvjbO6tSi6Vjn5K5cRLf82dSsPrg/j6v+rpHNB+DGk4t4W4Rb/D
	 vI+WNmPQ6BvOWQncc5qMk3iDBMeEL/AT1aZGK1XQDolWdyqeXHGFNy3sBuiT+KT5z9
	 63M0PGcOanSBWJyyXqfcdLv0JqKHrfQmLcNp1G3A12ZiqDRNXjMK/S8mE6WWxlSp5e
	 bn/2zOy021XeMC7DG3VIdSlTYQ3qoyW7Wl2p2iMlUX+HL4/UhraHijZxj5KyezR97P
	 SLmQy6Gt9NdsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 06/16] iommu/tegra241-cmdqv: Restore PROD and CONS
 after resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-7-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-7-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:42:19 +0000
Message-Id: <20260929044219.AE5D01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Ashish Mhetre <amhetre@nvidia.com>
>=20
> PROD and CONS indices for vcmdqs are getting set to 0 after resume.
> Because of this the vcmdq is not consuming commands after resume.
> Fix this by restoring PROD and CONS indices after resume from
> saved pointers.
>=20
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D6

