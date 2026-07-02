Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6F30EF86;
	Thu,  2 Jul 2026 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007743; cv=none; b=KMn+EOKv7GTRQZKyr6WW3KObyW50H8ELlMUzUmd10HLYCnD2ebz+ZqOnHSEbo40gOCO/Hreh+SlSVAP7Y+pjzrFjWgUwZ/E0bQt3mE8M9/b+jmkAlXHWsktU4t2tzM/Iwh9UIVgjzMyrGGs9/m+Z29yJsrQ/ZM+PxiIg/PikIHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007743; c=relaxed/simple;
	bh=DWoKT7O7ljVzZo/n+aaxT2AQQ6rco2vqA4cQgNNvj8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N/ci7/n/TK0PzHlL77ijZRrTuZGkSj3BmBGMJ3sC8AKDwip0jgbxlld0/RwwsoogvGBXMRxQBR9/lpXxwDCBv3aY6Ob9Pv7qVf1xcSiu+92xzRbvN6TFZH2QStJtgm5WyHKL7tFnuKteM1hyjZl5LuFKNRI15QSWvbrPnbycLBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+SvHaSV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+SvHaSV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E2D1F000E9;
	Thu,  2 Jul 2026 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007742;
	bh=DWoKT7O7ljVzZo/n+aaxT2AQQ6rco2vqA4cQgNNvj8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b+SvHaSVpcaunmxU0pCjo1bEoyOWaxHGtqjSTtUupBDjLquzOJk9w/MTzXjswO3Tk
	 dK6d58ZMsNKcNTvSFgLoU4ktepH/JSuYZD6mVGMAz4H3N3Hjta8h93tZScDXfxtzYd
	 F2NCuRLHMc6J6ioiM3vdJIzqQnApstUQlnQQxDDfz+RfLApvYn9Ou1t6ri57anRX5Q
	 CMeTFUye05bFlXihAgpYrKqI+f9L7WiqOwofvCsIqT10O+rhLCPOv4iAVDzTZtqVYe
	 b32vUHGr9SjNqzJyM/5w92t1D9YWNXm/drDbcNEz5ECuDELiUfXLtBkPWnzHG57Tb4
	 HOz758E4dndoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/11] RDMA/hfi1: Use sysfs_emit() for cpumask show
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: Frank.Li@kernel.org, linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20260702154725.185376-9-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-9-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:55:41 +0000
Message-Id: <20260702155541.E1E2D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> sdma_get_cpu_to_sde_map() is used by a sysfs show callback.
>=20
> Use sysfs_emit() and cpumask_pr_args() to emit the mask.
>=20
> This prepares for removing cpumap_print_to_pagebuf().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702154725.1853=
76-1-ynorov@nvidia.com?part=3D8

