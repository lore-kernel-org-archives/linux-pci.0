Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C675472543
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932464; cv=none; b=F0vLAFqiqmNe3I5xdjUwrUQBw6G1II/Wx3otles7s0FpO0GBr0+3lcxA+NzBDEVHT5cYbTRAkZAfoaQ2Kbu8hJ/JzapKJUo7x5ZIDTw0fPlUHSQQwLJiQjXPkRqrWEP7e+qUjjdQj7If8ZqhTNS7EM5RGB7NjCp2U/BfqjXk6o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932464; c=relaxed/simple;
	bh=zpVuVCW99IVYwpNBM1aTnWlTDSqlt4Yv/XD5/0xjUtk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pknjf5L3bGKmHAJDuEhUZDpMzrXZMNFXTKSQKWyaxZl1k9vhpJlCwsMGX4vvhz2sGYu2/exUllM3HKiuzsOiVnH+1C3Ur5ivZpscqH7KP25dr+j7JsxpySMjpOAbcrHigSvKeexVZCGioxQyCa+CJZBOg8/UdnRtsb38qR+LpGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgVIoxQ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgVIoxQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65F41F00893;
	Fri,  2 Oct 2026 09:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932462;
	bh=zpVuVCW99IVYwpNBM1aTnWlTDSqlt4Yv/XD5/0xjUtk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CgVIoxQ7pDOwj1sjnhJJ7CFPMa6/8L/mitz7lIC5yLvxbH30Gcz/mAg1DaWelX1eo
	 UV3603Nww7ICEHB0kEoCOKhnFBemQeQSKHk4UntwwymEUY1tfFDX833lhzOoPVm1/g
	 CW+QH4H4G6LI89eOsSVoqTepp4qv8bnMyZbnhBEKVyeRdo/iXEz9awsP0igXrV6wpc
	 eU1yg1eFb9cI9Xg4rY5xd4yd9fS1C3sV1/ehIUiEAQz/w/fiHpfI+3Qj6REVjbdc3T
	 NJkTsbTKriIJxD5DofnhELWbzfI8ynTvY2UlPXlbFxmNtZCAvsewefknGdbqUSQbXv
	 KlpQUzbSdGyRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/1] PCI/ATS: Mandate checking pci_ats_supported()
 before pci_prepare_ats()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261001233338.918408-2-praan@google.com>
References: <20261001233338.918408-1-praan@google.com>
 <20261001233338.918408-2-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:22 +0000
Message-Id: <20261002091422.C65F41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, pci_prepare_ats() internally calls pci_ats_supported() and
> returns -EINVAL if the device does not support ATS. While this provides
> a silent safety check, it conflates support detection with configuration.
>=20
> Update pci_prepare_ats() to wrap the internal pci_ats_supported check in
> a WARN_ON(). This mandates all callers to call pci_prepare_ats() only if
> the function supports ATS.
>=20
> Update the function documentation to mention that callers must verify
> ATS support (via pci_ats_supported()) before calling pci_prepare_ats().
>=20
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001233338.9184=
08-1-praan@google.com?part=3D1

