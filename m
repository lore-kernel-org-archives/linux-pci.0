Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1640D596;
	Tue, 23 Jun 2026 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205887; cv=none; b=HP1/gN7X17cfG6nRfCcu3iP3SRTr/T/lyAwkAlgO1Ziz1In59t1YtXFbqXRBmgKwjH4e5OzAnOYj7R7EisKZshW8XKEDjc6rbTDv9pKul3ZpMIZ6AUgzrAb/xUrhMiWYl9ui57nlVNcF14s8lFeq7FF1ESf1qnyKEpjqKKmi1rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205887; c=relaxed/simple;
	bh=W+MON6YeCxE59gmuI/vhtVLkTvJKWSUMSRdfz1rwWPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aRUJhh/2/xTPlnCXcMRHOfvckNCePFkNoqueVMdpXKPZ5DLosHrYzkwTcP4q7wqZPHPEOMx7ap/XQycNPrhgKYRdnJ2ChDyPRI6JzIF4tK/7G2rgBSVXtXj+jhL2pBQt1FR3wW/xW8M323TrAYDz06Pk7T5sMjEJ7ZdVqeg6YVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GACpoxOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GACpoxOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94FA1F000E9;
	Tue, 23 Jun 2026 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205886;
	bh=vdginLlN5muauoMgHnq1kFfYJR4KMY7Uls47NZpI/DA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GACpoxOt4t+7NJeMB5AEm6HCNExikhvIpu2+jOrbDI3RjrFEH9iZ9aZx9QjoANErB
	 w9ct3XHh4Dt4lYak7j1IZzGtWcnCitiMu/ycm1+Rmy42RR2/cJiNGQxATXwp6QLGNY
	 9EIpM3izY/g5FlhZwEYUzKGj+lQT3Dbc1M0S9QS9WCQW1pz50n7zL3NJbAfJ5cQnK9
	 bv9buGxSavNbpckpWcf/Co0/x/TbdHZqZjsYPHYcert58ZlhGEqbHxHdfq5ATlmGTm
	 ujYHtO9zwZTmkSAr7GAUOnDXWrucXAtsIT9Mr60gqoHCMJLgqEI5qIm/cLTuNcfhAh
	 JMDCcOQ0Ru45A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v18 11/12] vfio/pci: Add TPH_ST_CONFIG for PCIe
 TPH ST configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623085048.51139-12-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-12-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:11:25 +0000
Message-Id: <20260623091125.E94FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add a new VFIO device feature VFIO_DEVICE_FEATURE_TPH_ST_CONFIG to allow
> userspace to configure PCIe TPH Steering Tag table entries. This interface
> supports only configuration writes, read operations are not permitted.
>=20
> Implement shadow ST table to cache entries, paired with per-device mutex
> for concurrent access protection. Batch write failure triggers entry
> rollback to guarantee hardware and shadow table consistency.
>=20
> The feature is double gated:
> 1. Global enable_unsafe_tph module parameter must be enabled;
> 2. Userspace needs to firstly SET VFIO_DEVICE_FEATURE_TPH_ENABLE
>    to set per-device tph_permit flag before using TPH_CPU_CONFIG.
>=20
> Design note for Sashiko reset shadow table warning:
> Do not clear tph_st_shadow on FLR/device reset. Userspace VFIO application
> can detect hardware reset events and re-initialize full ST table
> configuration to sync shadow cache with hardware state afterward. Retain
> cached ST entries to support offline error diagnosis and post-reset
> recovery.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623085048.5113=
9-1-fengchengwen@huawei.com?part=3D11

