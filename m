Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F13515FA;
	Tue,  6 Oct 2026 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791316445; cv=none; b=KnOTclDWM8Y7sSgfqjDZplWSxtusAf7ZFr4t/96KRu3bhoMliVwbsuPd1IrN1pkHuguzr7pPjTXOwy8Y8wZA4lLmB4cQals9LeIl7WLapmT9T4K4qVilgCFzIK9tumUv+fV250wEaqqqtJQq3bJH7b0HrQchgy+IP3i4/Az4h0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791316445; c=relaxed/simple;
	bh=2s9hqierUNaB7f/7blIVWVONTb4UUroPbJN+gSoeC2s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gZ4abD+kOcI4ddVhraaEw2GjcilIdpZttHWNM8mD44KIDy6DP0BAFIqDWm0SQMMfiph+KzfWCynAmUSOtFqvSgrbQSrkA3Pir109Cgi8Z9KfEXau0JBKKfXZGkEB+UrtbkktNMrFpcGVEx2TBN/krtp3DjS6LxkwSKh+bx2Lal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMe8LXiP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMe8LXiP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B401F0089B;
	Tue,  6 Oct 2026 19:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791316444;
	bh=Vv6Qv2Zd14cuUvTpGz9PFT061NDmDnhaheMn60GzFgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RMe8LXiPL7BK60CHY4YFlIyFMVe41xs9+21zwReairAasrz5KS62xLI+DJNRaBJ0l
	 BTA9svO2vBur5rSP8I5i+Xui8cyigMCOkPen8ZVDRy7zSOJpIQPHMfO8OA0MMBZlKv
	 odokdYQ1b8vc6pOY3lQZi+W+enItkGrDIHq+7EXqfbBt+ZBcGw0LCrwrffiUw4PB90
	 hIa9o8lE62zZ+RUMFoe0AX8Sf2Gl8Jhph3aUQHkTeNHKnGbVVCaSjK9Ot5OEoTL+We
	 ukMPbGAb028zmBvMigEMdBhjRbYl5xQ4W0toR8rRwLt7p/WZ2vqbzD8yGUzj5wQzE9
	 JWWBCp5Z/6hjw==
Message-ID: <sashiko-outbox-162414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261006193643.76330-9-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-9-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:54:03 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D8

