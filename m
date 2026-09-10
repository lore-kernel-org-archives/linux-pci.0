Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F149BD94
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050961; cv=none; b=iaOXN0a7hKodCvXyL1Gh6QTb1rTOS79r9kiyiw7RtCj7Y4TwuYCjPVlP4LbDcZ0OuU5LtP7wmX6CTcAZZoVhVukGw7RO5n27xTMOeex1eij1nFDTo80zWlkrn9+WAR1WrH1t57/4ATsY4FXFfNTpWCoHmN8v0KG1DhAl+xAZcII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050961; c=relaxed/simple;
	bh=2kwqeXmoLuZAGDpgsgPXJkXri+kZKViN2U5vWZUVSWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mn/jhhXzE/lDLAf2WnFvqOOuzNVB5cYePcku02PI4G+xoVMce/EGYVIa/IMuWGVvB2Q2c7r4jahT4ILqfvr4KUa1JD+mcyZpHq2UYJGCMyQnqGvGOz1hKfY89toi2mc3E27JXwyoDx1QelnEnqAQPwewbYQDJZID9yRu7eL0IoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBP32pJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBP32pJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1131B1F000FF;
	Thu, 10 Sep 2026 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050959;
	bh=2kwqeXmoLuZAGDpgsgPXJkXri+kZKViN2U5vWZUVSWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hBP32pJx6fCTDRt7WQegk3z1UxGK16SvnCdPqsM99PwWBHGb5p79KeitgFfEhziJ1
	 Lnz7Hx/ELURboMO73kNNdKP9vB3rEwJ7QlxNLRfu+LjfV012QEGBPaqxgTiH3Yo9Ug
	 ReFLsv/M9IeIlFTwdMb3gqnssDO7SI4mU2hKZww/VMz8irp5+9xpC7Hp8LmzeJThY7
	 MiKowwOM/NPNNRu91EHRrax5b0D7R2VihslxAkCSFrCZZ/ehttdiAwMgDL46SrnMuS
	 e1YVOVIO2FvqFwx0pzTBKE6/j0oYy6cm25StDOXR/WClxn5/xqdRlnRW8p89VzOf2n
	 GW5Q5ZSYdYKyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] PCI/ATS: Mandate checking pci_ats_supported()
 before pci_prepare_ats()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260910142655.3281464-5-praan@google.com>
References: <20260910142655.3281464-1-praan@google.com>
 <20260910142655.3281464-5-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:35:58 +0000
Message-Id: <20260910143559.1131B1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910142655.3281=
464-1-praan@google.com?part=3D4

