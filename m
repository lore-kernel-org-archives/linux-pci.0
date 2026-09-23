Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DE579815;
	Wed, 23 Sep 2026 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195142; cv=none; b=j+touqO7n6sV0zJfmqiPGcwC4nq53GMcgvRBHmzih7HHTc7K6kqfAyU1y3V7nOo7vPehHZKnKZEWCtTJWtwtIyt6Gy9Uo+UWJsVkdS0EkwcVdXo5JklPIZt9rG0reQREkOkhkpNWqAQEubU1R5J3xWWc0vy7J8+0sOxgXuaRE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195142; c=relaxed/simple;
	bh=VRt387gCs1fHLlLHylNE7ljGVhh9CImHiHnEz4C3hrM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m9ak1m0IHdbWMnUz4D8JefWSTJuGaSz5EUnvL+Ky2mRyxRrc0WBG3ZZO4a8A3If5q1isSb3WHtQNOI2aiwj0+aU5uN26CB40Uoqv3YWuGn6TgMODwP2I9swQrOJyd/U8QaIRziIIvq00zVAVzVGQvngrsPKS+GVO5uH8XSPm1wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxKdLQOj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxKdLQOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A9B1F000FF;
	Wed, 23 Sep 2026 20:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790195134;
	bh=VRt387gCs1fHLlLHylNE7ljGVhh9CImHiHnEz4C3hrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KxKdLQOj7m72V4HRBZHnQbq4HLVrSkjhEJSI4HaoISkf4N5uJKUKIZgXIcaom31H4
	 45Xsn5nV074V7Zp433RaCxwRBveCGuaCYAZaKv4SQoZQYVaW/c1urfaP7+1X3GLV3p
	 mwpUkgajO93wro/bD0L8Enf/dsgGV+8x9rYz+7UhJJWoRu9xC5UNhG+b0Q8W8eOgRC
	 DoGIE878LmMRQpHr/ClIHk0N4XJBSglojV3iDqnI3wlLqtaHOdesOS9YYxluEJkwVy
	 bPdD2SvBqiTbhPMoIN7hNcXLUh7zGQnRTolnb+lTqDWzL6b6tqLAAM2disL+POGydV
	 l2yl7/Zndg9Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/17] iommu/arm-smmu-v3: Add has_ats to struct
 arm_smmu_cmdq_batch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <5560b3d2aff6f2cb3839f6cb854a1ed27b2dfb69.1790188511.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <5560b3d2aff6f2cb3839f6cb854a1ed27b2dfb69.1790188511.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:25:33 +0000
Message-Id: <20260923202534.29A9B1F000FF@smtp.kernel.org>
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
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D14

