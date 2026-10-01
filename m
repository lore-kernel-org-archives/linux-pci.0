Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39479475339;
	Thu,  1 Oct 2026 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847083; cv=none; b=dsg0lT5NZ9euswUUbkC2vOV4AmBWS0CQa6oIQaalBmr4nGKmbuymNN7eihG7mTkvs7kf7YLZtED7oG/xV56LJjrmsDlKpz14KMhw4cld3P2hY8CFM6XM2KJEt1G6rbnTkBKjkE+cmm8VlqN0/Jh5ZyJS6AxMa4XpuAVVLNFTGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847083; c=relaxed/simple;
	bh=2h/rzh7WXgXD9KO8IotyEtZi8B2lHOoo9cvbiR5R5LQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SLccpQkeCe+XySHu/dUQoKLKqo077mJ2gWjfG/cnX+9FxdiTCQp+ggCMwrCmQK0E1r0yh2+kNY+MYY4OBM9aIE4v3k3E3NfuzzD0yHCXgTJmMuXc4zoC5v5pVaeqXIUyGvHqdZ6WKeOCMTVCrd3Y34aoad2xbEV5ENhHx3guiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfmCWaBv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfmCWaBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59BC1F000FF;
	Thu,  1 Oct 2026 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790847081;
	bh=2h/rzh7WXgXD9KO8IotyEtZi8B2lHOoo9cvbiR5R5LQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nfmCWaBvg0VWGAFBs5e4UL0jY92/aqpBL79H7ICSSMXemJZEP0J5Zv0tVyV19ctx6
	 VmUbnjnlpiuJUVMU/z7p1ca9jckTUgkwL4gF2ppDtvhBJ8DNeK9pOpqJaTqFI0Vm96
	 s9xoN6xpyStB2D7MIvma2GHAr51gfuqDZ75xMO93JUmmnQhksGvnqmTDllXeywrp8d
	 cjrqgo1WWXkJO9ftKWQuHFhQAYxdt5f4UVxfnM20lROu3GbkLsldekGZIfEHvFVO5f
	 xvFa7UbwQeDNN1hs9om41KTDlgpD4RcmBfepmfqCQ4A3erWcZFV/CTkNArek6JEhxY
	 Vv3JVyE/KNXtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 05/16] cxl: Introduce reusable HDM decoder settings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-6-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:31:21 +0000
Message-Id: <20261001093121.A59BC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Represent HDM programming state with struct cxl_decoder_settings and pass
> it to the commit helpers. Keep endpoint skip and switch targets with their
> owning types and flatten them only into transient programming settings.
> Place flags with the programming state and leave runtime region ownership
> outside the snapshot.
>=20
> Separate commit initiation from completion waiting so reset restoration
> can reuse register programming without changing normal DPA-lock policy.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D5

