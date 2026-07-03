Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE430567B
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052971; cv=none; b=coPnTXe+K6OcYpm0zvVzIStfY5cF6+LPIVBSc8I5LiU30OBrl0PNT65qXybFGj7CMG8b7Cc+d3AjsJqKlzwnkhJWPT1O7rG3+1lNBtdolGCXbABLc8jZK9D9ktnKS8p7ut8u+xbRU1uTK8GsAvJwcug/oHQ95PvJ1ZbC4VM1hxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052971; c=relaxed/simple;
	bh=GhbQCVBi8kBPObhlLdlIescfjz9SxRN4VRAMhQx51y4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lXt5XoxxFBls1mrT2jQwQqP9RjQj06u7Z5IzFQY3soow1TLlOdo87qbU9IPoziTmLrAp1P6WFwS0E/YlPMaIe/NPPxR8Mn8Fd/R4I2n+34Q90GX2j9N1mrtFxtq/CY4YjTnhoV6ifYzn8lGWd3mhiSl+xKb3WZaQXoSot2kWnkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZSyJtDq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZSyJtDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6873C1F000E9;
	Fri,  3 Jul 2026 04:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052963;
	bh=GhbQCVBi8kBPObhlLdlIescfjz9SxRN4VRAMhQx51y4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LZSyJtDqjU+vS/6ZEZ443n1QuxlOLj6VMjekJhyg7ET+/pFtOfDRvp8hAlM1nczKJ
	 j4CSfFxARzMcDfZgeXIAebU1jWGMz6vUSwyL6+jyknaLYuEJgqgFQPmlmz/o8XB1fG
	 ztC74K33n+fpN/0sT8dqt8YdLR5mrB/bsd3Fb3VTQ5vEh6fEXMODEYiVWfH6Aayvw5
	 qi6JROREg7udjLImA5xIjI+qLxQ3aWckzgzidP5n/Tbs8a9YmfUllqatEOsPH3UkLc
	 zHhmduDTy4HfLGmwK+NaXYifEY66c3Mw4QBEEpk/TnG6AzO7A0cNTWrii7s3CqGWyS
	 PKo95OQAYiIJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/18] iommu/arm-smmu-v3: Add has_ats to struct
 arm_smmu_cmdq_batch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <b947f52231c35c89d5ad427070918a6ee5c0fb27.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <b947f52231c35c89d5ad427070918a6ee5c0fb27.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:29:22 +0000
Message-Id: <20260703042923.6873C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The arm_smmu_cmdq_batch_add_cmd_p() might flush a sub-batch mid-way, when
> the ARM_SMMU_OPT_CMDQ_FORCE_SYNC is set or when a batch is full. To allow
> a future change to retry these sub-batch flushes on a timeout and identify
> the broken master, the batch needs to know whether it holds an ATC_INV.
>=20
> Add a "has_ats" flag, set by arm_smmu_cmdq_batch_add_cmd_p() when it queu=
es
> an ATC_INV command.
>=20
> No functional changes.
>=20
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D14

