Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A84A498F;
	Thu, 24 Sep 2026 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264187; cv=none; b=qFO4ivAizdF4iN1y09DtDZwqTFHXdbK57ZjkWoKMpPteyogz0jlc/atYV8qJAjglbyLUz3yuTcRgevp/zj4b3q5BupmVsuS9Vc4+U/tO4JseSmidseftn8znp0RpCiGNznuCJkiib4yY89xheAUUXI4blbQW3EVjtEfdlcERmgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264187; c=relaxed/simple;
	bh=c6nM/heFv7zvvZWo92XqXZtGbNhiiyFJL+UmPMi8zq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kg+M61jYV5dAJRJ571RZXVMwnDi/dwmGyN9gWq1suZ6uoo89MxsjCE/mXYvRxwfdHZ2gMaPT8UtBaU3XCiloD3FilB5hdLuugn+5KJS1xYdlezgjF3M6H/qpDAgF6mX6GzIM8RiUKLj4uGkj3o3HYKcfbcfwXe2sp9eT75H68kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ame1mdR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ame1mdR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873F51F000FF;
	Thu, 24 Sep 2026 15:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264185;
	bh=b4NwMMgsnsnmscbFkzQifG2tl4vFRUBJnT/cp6joCs8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ame1mdR64Eoe3pCMx7I1yMPGh7hQmQGtnwhWFImGyTFmSoKP7/pGs3VZO4885C4PS
	 CyT8aIx3kADQqWHeB+hX0wWVHhPiXBCu1mmMYcpuSYYfRZ+DQzVsWdWU+gPUUZEQOy
	 TMOGQiaoFQOG7TpDkxVIM01ADqNyVsFUZjYfaqPTGEa7cWqpl5UPD3bA1b+28zJo7r
	 6/OVA8QBsvNnMtsHKEDOtnrViaOzJfNjJA+z/O9shgTZjLK2QTxlQRUTH2szgZY4rK
	 JF0n2hzCCNIaf272WhnJr5Qv+lhhwB0/NnuWLf8KbsnrZdfIT1ujjZajuManogswSK
	 qT1+WwMBQ2x4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260924152159.49702-9-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-9-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:36:25 +0000
Message-Id: <20260924153625.873F51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A VFIO DMABUF can export a subset of a BAR to userspace by fd; add
> support for mmap() of this fd.  This provides another route for a
> process to map BARs, in which the process can only map a specific
> subset of a BAR represented by the exported DMABUF.
>=20
> mmap() support enables userspace drivers to safely delegate BAR
> sub-ranges to other processes by sharing a DMABUF fd, without having
> to share the (omnipotent) VFIO device fd with them.
>=20
> Since the main VFIO BAR mmap() is now DMABUF-aware, the new mmap() reuses
> the existing vm_ops.
>=20
> The lifecycle of an exported DMABUF remains decoupled from that of the
> device fd it came from, i.e. the device fd could be closed with DMABUF
> VMAs present, meaning a fault on a VMA could happen concurrently with
> vfio_pci_dma_buf_cleanup().
>=20
> To deal with this scenario, the fault handler now temporarily takes a
> VFIO device registration to ensure the vdev remains valid, and then
> vdev locks can be taken.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D8

