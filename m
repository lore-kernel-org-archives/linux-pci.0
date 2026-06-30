Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354C8287E;
	Tue, 30 Jun 2026 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782861121; cv=none; b=NbTTHzoVwpsMa67aWZ73FzUTWnjd/vwdWMfhAWeDFPNaMqELtm3RJXPfyoWBUajbbnaW3oI7ptDaQEAB0FU/2fOu9Q32ChCUOtIDmKTCuMnS2Pk2JceOio3Z2Z8/7XUy+bd7Zqoe5FLa6lgnOxvK6KSXSCkprd18B1VMEjZQpyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782861121; c=relaxed/simple;
	bh=YouuZLEIEO5m2YlgfAG02ZFNT62OJ7IdcU08Y0jQvzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KLjZJHuY+JN1QY9EMRgC1A+BCZ9WVmlsx/2IHlEvBLhVFoMCtrlEeL3GTyhZ+4rVJG1ykbd7A9HiXDdTerL06HCipofyP3kGYf2Fyki73XGM4XXJxmXdyt0QYl+p6ptwxp3xHpKtCHS2cpZhnqnn7tKYjHNGMY5DTPjBvUOmUG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzVMxtqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzVMxtqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F8E1F000E9;
	Tue, 30 Jun 2026 23:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782861119;
	bh=YouuZLEIEO5m2YlgfAG02ZFNT62OJ7IdcU08Y0jQvzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SzVMxtqip/rJUliRR038d9RAA0FCcpgF6HkBqJeAZ4y5MtONJKEM8i/YEhtnSHkt7
	 Qd26cnG4AQfv2ITuISIUtpgXv+pWhRuEwCKGs0FXNjTD+JstCIdw0F5hb/6s4Mr3jW
	 raxRnPerBpIN9PhIIOr/kdjrEwrZ/OG2aT89IrbRzvBi6PukFE4ahJQan5giK5o6WK
	 NeR4a7XsaPiCSTRRtw7+FcRVb9cP3n4OdBdpub6AlGUNo7Ci0TFh+106+hZrXDKdjK
	 3frdZqViiyfRepU77kF+aJ0Rr9PQ/a5CNefoRBzTouIGGo61ueEGLjUaz6kfOSuBIc
	 QRoS8eeVIRFgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/4] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20260630224328.3218796-5-zhipingz@meta.com>
References: <20260630224328.3218796-1-zhipingz@meta.com>
 <20260630224328.3218796-5-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 23:11:59 +0000
Message-Id: <20260630231159.A1F8E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of `struct mlx5_st_idx_data` in `mlx5_st_dealloc_index=
()` when its refcount reaches 0.
--

Note: Due to system recitation restrictions, this review report cannot quote
the original patch diff inline. The findings are provided as a free-form
summary below.

commit 9ada3f634918f1f6bc02c86bed9350c775185dbc
Author: Zhiping Zhang <zhipingz@meta.com>
Subject: RDMA/mlx5: get tph for p2p access when registering dma-buf mr

This commit wires up mlx5_ib to query dma-buf TPH metadata at MR registrati=
on
time to program requester-side TPH on the outbound mkey. It translates
exporter-provided steering tags into local ST entries and ties the extra
ST-table reference to the MR lifetime.

[Severity: High]
This is a pre-existing issue, but I noticed something while reviewing the
surrounding code in drivers/net/ethernet/mellanox/mlx5/core/lib/st.c.

In the mlx5_st_dealloc_index() function, when the usecount refcount drops to
zero, the code calls xa_erase() to remove the element from the xarray.
However, it appears the dynamically allocated memory for the idx_data
structure itself is never freed.

Could this lead to an unbounded memory leak when a user-space application
repeatedly registers and deregisters a dma-buf MR with a TPH tag? During
registration, mlx5_st_alloc_index_by_tag() allocates a new struct
mlx5_st_idx_data via kzalloc_obj(). If deregistration drops the reference
count to zero and removes the pointer from the xarray but fails to free the
structure, could this be triggered in a loop by an unprivileged user-space
process to deplete kernel memory?

Would it make sense to add a kfree() for the idx_data structure immediately
after the xa_erase() call in the refcount_dec_and_test() block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630224328.3218=
796-1-zhipingz@meta.com?part=3D4
