Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E683168EB
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223371; cv=none; b=O2mPNsN41nKq5rhtXpPgyJnWaJx8Ma78ZTsKHUVnJBfjLQJEmvcSzcUVyOH6pjrhsxesl3/1RG9Y6n4p8cBH5z7p2R9zPKoaMQs/xJTkoJs3a2DTsix5ip/0hjU0zxYPrZgGFlFGSZ8+UGmyaFTKnuduupCgh9nHpSyTQTfV9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223371; c=relaxed/simple;
	bh=UtrUgIa64qugj1VxTvENudUu8Llyqw/MPMtv5Hk4jm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qPUUy1p84In0/J2MGvIQ9gwKtzPxKFVxKXfUBjzCZw9CmKeZUND36tkGX0VFQuraZu5LDbE0dPDHtqimKsSNE2Kpp30XdKVvZvWKd//jZdJIsDOWs7LXBxBEzDUZ467C5ako75ADOYD0K/5ml5EkGgNVmzS7Ezh6SaFh7o9VXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDdFh1d8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDdFh1d8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078DB1F000E9;
	Tue,  1 Sep 2026 00:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223370;
	bh=UtrUgIa64qugj1VxTvENudUu8Llyqw/MPMtv5Hk4jm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QDdFh1d8wJ9cbWedHAluRy+eJOzUMI+LDoJbB6Y70zm2rEj6PApuyXgXy2ua+Mr7e
	 Pk963fgVBWSlVuFshmujq2jiRlUgQTaMJklQnadEPaI38AZP9h46E08lv+xscVwS/j
	 /fhnGODZ6R/K59j4/U7I5aWoyhh+M8Oqs6C2gy9A9YHhZ5KgsMUEY3z+OnGmn4ZnIt
	 cCScMhaa/EcApOiFqUFq1d5Gq7iew3yaquKFmKmKCutOQsIbOROQ3sDQiUITB7mco2
	 r1jevKG8Y5mkwqa2jx3gGRIsmdyH9efZtkERjiInmVZbjShkfFYTmFQIaexwh7gUgl
	 LGnw8xjDayJpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/13] PCI/ATS: Add PRI stubs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <f7c924266e6f8d74de4508c812d0e49036fda53a.1788222486.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <f7c924266e6f8d74de4508c812d0e49036fda53a.1788222486.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:42:49 +0000
Message-Id: <20260901004250.078DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>=20
> The SMMUv3 driver, which may be built without CONFIG_PCI, will shortly ga=
in
> PRI support. Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove unused
> PRI and PASID stubs") to re-introduce the PRI stubs, avoiding more #ifdefs
> in the SMMU driver.
>=20
> Link: https://lore.kernel.org/iommu/20201112125519.3987595-8-jean-philipp=
e@linaro.org/
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [nicolinc: drop stale APIs]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788222485.gi=
t.nicolinc@nvidia.com?part=3D11

