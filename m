Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C23DCDB5
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655855; cv=none; b=TnWpLbYJ4DSwPetZEWiqYIDy/Fjx6aT1VGm9JYSLinwPJMDvHS11ktgc6ZHK/239Btft6vB9qWYIyod/JpS40AqJ3dFXsLgNOT7+5Hm/QrtOzGzD30JHFuxwGq16jk7BMJ2hHDgZQxmFBRnAZyUHLOxzfdcYfMztUxLthj9Vv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655855; c=relaxed/simple;
	bh=vIHkZOuB5XsdyOnevl7JAyJbBxkcmulbD8WgfiPkX04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jjdt/PSCKDCXkX9QazMfmu7KO1Fl2okazV/lI2iVOIeTtVVW6sSSnNEQSsMs/YwiaF1+RGb5Zd+j3qBo+/WNfz+p+ev60YkoUb40E4o+hON/pszsne+G/Src2JZntFoiAvTW1Y8HfJqz7X1h1IwsqN1WMYd0mgjXPjz63xPxEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U34SO14q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U34SO14q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2901F000FF;
	Tue, 29 Sep 2026 04:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790655853;
	bh=vIHkZOuB5XsdyOnevl7JAyJbBxkcmulbD8WgfiPkX04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U34SO14qFRMA2Gxo1Yb3sa+EbQwOTNbFKk2dF9fC6kToX5epdHiliCobIexvU9T4H
	 gHMrcNXvhmfop/GfAdiqcgov0r+xhTVCr9zekVGk14J+hmxXcJFy3OG0Swo5o159+E
	 AodDsecDD9ZU85oiIF4IfM8KBbD75fV5S/YukSuTkG3BMfRNgAFCAir6EcYwMrBpVD
	 LKMQvJaQCtiDl4xAA8jFb/srlTiTKdcCHP4p9r6K4cV7aElRXnye53xYSdBy34gg6M
	 XbsH1MMcCkIx7G35RsUTwtFx16RKcl14mNae3vx4vl/zydxy2YO9CAxW4Y3RbzYaJq
	 pkptZND/l1QHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/16] iommu/tegra241-cmdqv: Add a helper to drain
 VCMDQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-5-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-5-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:24:13 +0000
Message-Id: <20260929042413.BB2901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The tegra241-cmdqv driver supports vCMDQs which need to be drained
> before suspending the SMMU. The current driver implementation only uses
> VINTF0 for vCMDQs owned by the kernel which need to be drained. Add a
> helper that drains all the enabled vCMDQs under VINTF0.
>=20
> Add a drain_queues function ptr to arm_smmu_impl_ops to drain
> implementation specified queues, and export arm_smmu_drain_queue().
>=20
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D4

