Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469FE3D5C0B;
	Mon, 31 Aug 2026 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788218011; cv=none; b=F5LNNQ7j45ZKFw8NMR787CCrk1tfXx1OOsSVRhaV/k9kub1XBOm6QjzJgnOkiyqAlZI6PzImR/2GB/4usKKn8v2ji6epVmPP7FnExqsvdW3M2KTIzsAcyd07vaIC47p7v1w1mJ/PiqbeJ3DueAttwLjOeezp6ARypExSHdz1Du8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788218011; c=relaxed/simple;
	bh=sdkvuIaq58I+rGlPMbSNYm5rO/V9BvcLjaGRKPWFExc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vgu5Depq2qeqMMjFCdlquAKmSMblDc3fag6JTLzV+kcnuaGlvGzsdojUGMpkbcSPjfqCuxnfF8r0V/w7hizz/PdS0aVQ/AjT3+fi3r2QiJ5XAsEMXGK0Ebpk0rp9lYqILqtp3AhutpU4K2v2buWs7i6SRUHerrabkpXi9LXo0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOR92qqu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOR92qqu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D59C1F000E9;
	Mon, 31 Aug 2026 23:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788218009;
	bh=sdkvuIaq58I+rGlPMbSNYm5rO/V9BvcLjaGRKPWFExc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GOR92qquT8uXbIiPfnhQpiWvGzkXf+QPtJRFtI+IwjNPpLZBgDt74gmHNC11dMPz4
	 Gi88tmao8jEREhCWbwa3fKtOlo+ChxfxuRek+No2VzXwdvHmlfjcVrMQpoH0Q5ZFMz
	 2HvWVNe+Nnc1NnGHGtBPTnpXuvyuhVYVBkmFiCLxNkY2w8q2JWwoJHRjKs6+ku+n7y
	 eAMvda19A6qJZ710MSMYiUrZxV5p+VXjKVCL7M+s4nyzHHaLBb6AamrFjp8N3i7ip1
	 DG2ljp125KTg0jkWFJYqSWKgumDJ2elIr+PItIG1r+NXLC/r98LoSp/JQWY3VHdNed
	 C9UYYO9g//+7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/12] dmaengine: ioat: disable relaxed ordering
 before registering the device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260831191403.207631-11-logang@deltatee.com>
References: <20260831191403.207631-1-logang@deltatee.com>
 <20260831191403.207631-11-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 23:13:29 +0000
Message-Id: <20260831231329.8D59C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> ioat3_dma_probe() disabled PCIe relaxed ordering after calling
> dma_async_device_register(), so if an error occurs and the code jumps
> to err_disable_interrupts, the function returns with the device still
> registered in the core's dma_device_list while the caller frees the
> ioatdma_device struct, leaving a dangling registration that anything
> walking the device list can dereference after it's been freed.
>=20
> Move the capability read/write ahead of dma_async_device_register()
> instead. Nothing after registration depends on relaxed ordering
> already being disabled, and nothing before it depends on the device
> being registered, so this is a plain reordering. It also means every
> remaining step after registration can't fail, so there's no need to
> ever have to unregister the device once registered.
>=20
> Fixes: 511deae0261c ("dmaengine: ioatdma: disable relaxed ordering for io=
atdma")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/dmaengine/20260707165906.249F41F000E9@smtp.=
kernel.org
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831191403.2076=
31-1-logang@deltatee.com?part=3D10

