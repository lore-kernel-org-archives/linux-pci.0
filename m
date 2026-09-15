Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98F442B324
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491097; cv=none; b=CRdTG7oLm/EDKsggiri0gQtkPiXJk33EemRJWg13ZnnmdviSKoT3kzhThw1B45YyPO+o8JIvsgw5RxUo7fAyhDqn/v23oYuydKNfyE0LV6hrnBi3mmFk1xGedHj6Oi14S6HgfDd+J53aURXWiM0hTEimQ4/OW1ASXsiDkMre5VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491097; c=relaxed/simple;
	bh=tRQtvTbzF44/+wKEpUEelqAMURCktApH0o2FOg1GrDI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FWyq8fCqD2g+WrZLNl+ex2x2vYGkAKlU1j7e+43/lXcdEkA19q+JS5xRnbDI7fZZ4nE5kp4caNtZTz7etRQMITdRDGFx4Cve0DhhhcHxr63Po3Qb1Ov2ZPezjfPYu8924cJQgOEvcLz/TcTt+pnUHFMe0aF6Dkjg7YbbrRTrtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrchGFNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrchGFNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB8F1F000FF;
	Tue, 15 Sep 2026 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491094;
	bh=tRQtvTbzF44/+wKEpUEelqAMURCktApH0o2FOg1GrDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KrchGFNQBXa49mXtMbBDrRpIX45MTmAX3GJtfjeM8wfZIYB48Osdt+KBzWbore85n
	 1ahY3FJ1hHg3gNn0PGYBk6od3dtUOoDYnjpUAFhZw/1Ps/2rRgW5J6adu5svD2Kecj
	 ZRbiAWUee7MFg6/xcn+3O/DaTbpoV2C0n7mQKcGg3A3SydfpF10M4H54jBL/A8bFx8
	 zVH4exxyEDBYQS2Chtl0hY7TplKbREyCTdGnpkMYLyRSxm0UJpigIMPOblQpSf7xDW
	 iq6JrZHkwpHrEuXhMnc7/1EofOrKEco9xBq3d+EP2Q8ewlbK9jMrCK4fAdr+5wPpm4
	 y5IprRoB+im8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/15] PCI/ATS: Add PRI stubs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <17b39a2056c9128f195a5fd0764df0b6c5f7e980.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <17b39a2056c9128f195a5fd0764df0b6c5f7e980.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:51:34 +0000
Message-Id: <20260915165134.9BB8F1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D13

