Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8F51C327
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908921; cv=none; b=AaTkVh8fY5oPpCx16wC5OKjc0SjB3joI4fML1pLIz5jAXCJUFlTdOXrNTkkxj+V8BkhjG9nerR45AZ+UjjTtyJL5wYD7htlDdZG5CMyNNbjz5r5ft/yIjHn2L5Zu/sMWEME2r1RAI0/XwAE/TYpICRfoh6Tw3AZuoeWe0NOeujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908921; c=relaxed/simple;
	bh=odVEBCmsRbJOJ1+9+4qgE6bBwt1qmTgdLvR2oIvMX4Q=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WA8rMx3FR4ptC+2x8mHhGS5yirj/Tfqmbfp4vA1LUMVhA65mejkNTAgKDcFo/Pe42dwRO3YbQQM3GE324CapgxCUYKGExvXWvmHGr8+qFPqiJtbFfb46a3cI2KfmmTty+gUeHLbfscrY3QStqfe8jrUBFQYfLz/djop8Qpsx8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCwm4mJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCwm4mJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA00A1F00893;
	Tue, 13 Oct 2026 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908920;
	bh=odVEBCmsRbJOJ1+9+4qgE6bBwt1qmTgdLvR2oIvMX4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nCwm4mJEHorrQsUlrCM50K/8k5X4D7ZKAk9onNNpKdoZk/h29ZePz4wAfwQwb0ieM
	 JkCR9tdXoCW9olbYraKuyXCPLu8fe4lmRRvoQ+Cbj+gpBtc9Dxq2q3+FYFzjvkJ+kF
	 wjy+pxHuZuNLIzD1D3XSMqGb0oo2EvE67x+D7c6c7cJzcBzBskVq3Qk60MKTXnW1k1
	 jOVdr2MI+GtVFp8R5NrkPe+IaUkgH/WciC1cwY53aXSvQdQi7Erc7PAIqwdItFSCXE
	 e3aqGvILN7RTMmb/z7V0FFXzUs7dbf6yzjRWRkJB9gCbgdVeGYrDi7ZO0sCQPzRyUC
	 SbwlG1hi7aMPA==
Message-ID: <sashiko-outbox-170112@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 13/13] Documentation: PCI: Add documentation for
 Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261013162529.1928093-14-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-14-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:28:38 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add documentation files for the PCI subsystem's participation in Live
> Update.
>=20
> These documentation files are generated from the kernel-doc comments in
> the PCI Live Update source code. They describe the File-Lifecycle-Bound
> (FLB) API, the device tracking API, and the specific policies applied to
> preserved devices (such as bus number inheritance and bus mastering
> preservation).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D13

