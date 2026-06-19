Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462435C1B1
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860191; cv=none; b=RiqEcmS88M+N471WzDTaarKyRvrEVSO1M44wINff3v52hfdWIwj0U4HJ5oN3Q8JvXax7VvqpQ7YPwd61EhYZQvbFzTnxradZ+PTkarCphvNp1fbj6YReMkhKxhUW7IwpzfVAOM4wH/UuSPbvvaqvxTQFzCbk2bdLIsJZUbZDUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860191; c=relaxed/simple;
	bh=HJU3XqFydNAPFSXOmtALlTZHcCiP/ySrub0im3ay+iw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dxq9mvYXMeV2lD6cgfScd1hk5/aSjxGrlCURCURYNMj/eOZ50G/sTB07p6GsN3gKRbkwst99p+cuf6+GgKKfq3CL99gW5L8ICczOCAE4Vi63mGLmRT2SOinaC/5qD5N4yi8sp4+/TT443P2EO66NzpsRb7gGPeTNObRvqwMRj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odBc/S1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odBc/S1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6F31F000E9;
	Fri, 19 Jun 2026 09:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860190;
	bh=r+kX3VpdygjfomScP5AVEp6YnWVaafLuXvAW7qbLfGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=odBc/S1P0UCpKipsPw1ybpkWGwSAj1LlS3Wvm+E8qZlh+fiLs2YAFAxlmruyL6scE
	 UcFrD94qBb1lFrBzXd2JdKhBT4tnjIaZuGJTqM4/ENRFe2Yl863iqEAxq5iuxFyD5D
	 ooEr39BLWqNIUUQn+HKF1tNUvADojE1V2T8vimthu5z867+MQzFrwUGMI35cN9620X
	 Y6TTOnLHPv683CuOQWeSuQEMsbM9s9drPiW5Ngdc54YOLlQGA5+e8Y4P9sGV6CKmAi
	 fH7zGMtpPHITno+EmP2GEzCMMtsPzk2A5hf0BgBGD6Sx9InbmXoE34AuH3Zy7vBLEW
	 wMEvX43sIilGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 17/25] alpha/PCI: Convert resource files to static
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-18-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-18-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:09:49 +0000
Message-Id: <20260619090949.EF6F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, Alpha's PCI resource files (resourceN, resourceN_sparse,
> resourceN_dense) are dynamically created by pci_create_resource_files(),
> which overrides the generic __weak implementation.  The current code
> allocates bin_attributes at runtime and manages them via the res_attr[]
> and res_attr_wc[] fields in struct pci_dev.
>=20
> Thus, convert to static const attributes with three attribute groups
> (plain, sparse, dense), each with an .is_bin_visible callback that
> checks resource length, has_sparse(), and sparse_mem_mmap_fits().  A
> .bin_size callback provides the resource size to the kernfs node, with
> the sparse variant shifting by 5 bits for byte-level addressing.
>=20
> Register the groups via ARCH_PCI_DEV_GROUPS so the driver model handles
> creation and removal automatically.
>=20
> Use the new pci_resource_is_mem() helper for the type check, replacing
> the open-coded bitwise flag test.
>=20
> Finally, remove pci_create_resource_files(), pci_remove_resource_files(),
> pci_create_attr(), and pci_create_one_attr() which are no longer needed.
>=20
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Acked-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D17

