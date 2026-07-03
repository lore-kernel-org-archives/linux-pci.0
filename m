Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB2C2E8B6B
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783053403; cv=none; b=Nn2QhO02KsqAH0SpGaIMeqBlDVHdF67uxU+GPTYe9rbCJH1dYLvRMilV2T10baXcsO6D8BRK7sIAY6RGVIp5Ad1eXEKZfBuLkbK1W1l6Wx6TJqb8quaIxw4W7JSkLLXYt/oAVjNeg/6fJs/hK0F7O+VOems4+98vdg2jnSR4NoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783053403; c=relaxed/simple;
	bh=HzADCcYr2DxVZtAJeydN2AU0vxyhDH5AhfwtnHnshYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KqbpblUgxY8yGTbssa23sPwkr60q8Dg+NMJnY+iT2mziI49gz7imc9dM/T6FFWhEkJmuPVe2GCVuyPHlffh3DFG1d6UXnx/fCjDQQ6rtrYOO5ktw3r7kiW2rW0RFUzuyS6rQRqCcb5ddv4OXfESGC4UFf4mZfaZ+E6xXA3soPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCt3ZDQF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCt3ZDQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979A51F00A3A;
	Fri,  3 Jul 2026 04:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783053393;
	bh=q6aNipZQJlKBZC7t/nLg/fhS+osViXodT8rJMwUMKew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SCt3ZDQFeSooirg26l1q6rpDUCZnfO7E5xadrC4zcCf8rTx6Q8XRWYlSfF9TFByGB
	 Z1zjbFt8HsIHA/4xlHStyUxoZWP4cAQxkEbMQc6LT19VrF7taS0jgU1ICJgEhLkBaU
	 9ShqcrQ1Hgmn3VNxJQhpt4YOfoEqmvj5HsZv8+4TQfQ7XvhYn6YlYXpnxg2EbAua6W
	 Y8aU1SE8h+ZyCeYel03s/WTq8J0/PWALhbZCLOO1HXDpLUV7BWbX61iqEM/sYGT2fW
	 OcFJnlc98S8D6t/PvkbroFVtIJJWBhoI4V4UVjG5/ImZTPKM+PNTyq27ksWlQMZeIC
	 T96eiv0S2Tl/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/18] iommu/arm-smmu-v3: Block ATS for a master upon
 an ATC invalidation timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <939885143f3064811685b3f31f6f30f8a713c89e.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <939885143f3064811685b3f31f6f30f8a713c89e.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:36:33 +0000
Message-Id: <20260703043633.979A51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When a CMD_ATC_INV times out, the SMMU stalls at the trailing CMD_SYNC and
> arm_smmu_cmdq_issue_cmdlist() returns -EIO. The CMDQ HW reports the timeo=
ut
> on the CMD_SYNC, not the failing CMD_ATC_INV, so the master that caused it
> cannot be identified from the error alone.
>=20
> cmds->cmds is sorted by SID, so arm_smmu_cmdq_batch_retry() walks the bat=
ch
> and re-issues one CMD_ATC_INV per unique ATS SID; a second -EIO can confi=
rm
> which master is broken. arm_smmu_quarantine_ats() then quarantines it:
>  - clear STE.EATS on every SID it owns
>  - walk master->master_domains marking its INV_TYPE_ATS/_ATS_FULL entries
>    in every domain's invs as INV_TYPE_ATS_BROKEN so later walks skip them
>=20
> When a batch carries only one unique Stream ID, the timed-out CMD_SYNC by
> itself identifies the target, in which case quarantine it directly and sk=
ip
> the re-issue probes. This is the common case, since it is uncommon for an
> [ ... ]
> when the device's PCIe Completion Timeout expires, which defaults to a
> short interval.
>=20
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D18

