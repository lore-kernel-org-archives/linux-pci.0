Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377810;
	b=2t7Gs7/pkyt6bmjJ58W8QNohB80iXkJF4kLptC4w+Y/8OFTqq7Q3rpcACcCVjj6hoiQW
	 UreaISvTFTKsB+Y4Vi3dcd2/R6meHb2IX5PB20NTgt537ib6NgSeEAY9Mi+sTSeSpWTGl
	 +o5/MpgVia8zmuhezrBCUfCLfCQN+GHDKbRAcjKyKbndPeTmhwFvbEjQk9d299GBkiP2X
	 86pZCp7pZjJxJVwb+6ZwuNF3XdyDDT9s4ArELErKf6AmRgBWgY7OP2CeMpv8CgbGr1A+I
	 /dzvrUJGLV0e4tskp+xPa51AOoa9Y1e00dbeAQL1UmY04rdL5U4k+z5o7VZs1RirFFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377810;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d/MMAJz7fPUWKJ+xXRqo30isYkVkO2GdfsJRyXHUMBk=;
	b=y7eL+BegjgDkKS0q/9reF70gNpnHIDEJ+V3Pq54Ny593Xt36wccHeI5uzirfnZM+YscZ
	 wOg9mZh1OY5zCNHZ9Q2oG/jyS4SamaYrleOARN282Ca5dvzGtUvPqfblIFwsO920ARnRV
	 W+fjXM9s1cu8QHSVabBmg6NRpMYcbUa139wHF1wUTfshk0Cm5KfOJPpQFJEdoNQBVYKkZ
	 J92rJoTJ4jmNBS2XXiJL6QC7ohLN1Z7QYWDYjaLaMCfqVfBLxlaWoViGPSoTXjK+OJ1tw
	 N3ip7Z0zeQyaMDi91VANmckMt1LnsneAi6btDoOQO6429zQ61fGtRZ4l9OjqxqlFSjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGLbcZWz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D0606A324
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lGLbcZWz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5960E1F00A11;
	Wed, 11 Nov 2026 06:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377810;
	bh=d/MMAJz7fPUWKJ+xXRqo30isYkVkO2GdfsJRyXHUMBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lGLbcZWzIQLNcILAgK9z4kCUV5DLibJug4MsbVCyGLhKi2DGgLvIn3yRlglWLeoR6
	 qyyr8lWnV6Ajl9JIFL/05z1O5740R4WOvnsM3duuNu5AOJ94RszFBqN0FtD/76C5Sc
	 TkVaViPFMCFvqqum+9sBD/VSQjy4dfqqwDp3eAAeb2AIJY44uLcOvCRNy7DLfVC35p
	 Hm+5CSft28qVyvl0Fn6iLasKGb/dD7pyPkjRQbaUUOjgO/A4LjDgzeWqfZ7HfI7ElP
	 XbLhyZNwBeP630X8MfewxinhrGEal+QcXLeni2GuzmF+XP1g+oYgtqDf8K8B/Zia3y
	 wJjsWdxSg9tMA==
Message-ID: <sashiko-outbox-208416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/19] liveupdate: Add feature header to struct
 luo_flb_header_ser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-14-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-14-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Precede struct luo_flb_header_ser with struct kho_ser_hdr via
> DECLARE_KHO_SER so future File-Lifecycle-Bound (FLB) header features can
> append fields to struct luo_flb_header_ser without breaking compatibility
> between adjacent kernels.
>=20
> Initialize the header in luo_flb_setup_outgoing() and place the outgoing
> entry array immediately after kho_ser_size(luo_flb_header_ser). On the
> incoming path in luo_flb_setup_incoming(), validate the feature header
> with kho_ser_validate() and locate the incoming entry array at
> fhdr->size so entries remain properly aligned even if the source kernel
> serialized a different header layout.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D13

