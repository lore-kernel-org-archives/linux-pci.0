Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D8582BB7;
	Wed, 23 Sep 2026 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194845; cv=none; b=SO54K0h5oKMcJCZovJfAlJx+3daT+jPnFpfhd1kXD4zpJanheuuiJuva76LIU+LZwFB6tLeOHbqMtHQEZGGmAO6aR2QVqOirEKqoEADlRXAJp08SHbxhBswl9cd8H5Un2hinioB/b/CNhGBRaD1ee+R+ZGFBJPt1EtCK41VgGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194845; c=relaxed/simple;
	bh=DwAXhax6KoAQhTnH7wCrX+oy4tzHZW6GUxXF0QpYPtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RfzNlwoQbvsmiBQBBqtaVBNxWmHrxqsVvtDlH+v/4a05VKBrgxYMPoBMgHspsT/aOMENJrj1nlaikQ7CU/zz22MfK/lpJen7gl9IFV/VN5zqPlMfT3siAtsinwocxqEXxrdZzSijER/aYpF6DajDdqRNBkEfYr+gizP3sRWZ51A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wtf3QU4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wtf3QU4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117A11F000FF;
	Wed, 23 Sep 2026 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194839;
	bh=DwAXhax6KoAQhTnH7wCrX+oy4tzHZW6GUxXF0QpYPtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wtf3QU4EgWVqE1pujjyg4c+/UqbecD0NjYSinY+d8yc5w5y7vufD4fQiDuoLCwz0B
	 HOeozSU7NcRKXgSP/gXaNP/7zUgS2ymf2gVD9A8X5eDDS4x4DT19rdTXdNkRwg5kAu
	 7rPsQkIW1dsuxTnu3zo/Z+ubTseGnr3pgahaPyoOzJHLn+YXqckPFu75onDEjyY5B3
	 GQAUUIE875ff+335l8RWkRtqshXcXJFaDIxtwhcNY1gLGJoNGe2R38o0/6IodUf82O
	 LsrotPC+gFYh+wLGBxOYtJ2ZFFHDjtb1rZryV9BzEI4j8akAB2biyLOaTGR8QOfR0Z
	 SZnpEXeKL26fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/17] iommu/arm-smmu-v3: Introduce
 arm_smmu_cmdq_batch_issue() wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <234616c89cd2703e1d4682a22da46eff410f2607.1790188511.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <234616c89cd2703e1d4682a22da46eff410f2607.1790188511.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:20:38 +0000
Message-Id: <20260923202039.117A11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Both arm_smmu_cmdq_batch_submit() and arm_smmu_cmdq_batch_add_cmd_p() call
> arm_smmu_cmdq_issue_cmdlist() to flush batches. A future change will retry
> the issued commands on -EIO, using the arm_smmu_invs carried in the batch.
> So, a single hook point is preferred.
>=20
> Introduce an arm_smmu_cmdq_batch_issue() wrapper, so a retry logic will be
> simply filled into the wrapper.
>=20
> No functional changes.
>=20
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D12

