Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE75048989F
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491149; cv=none; b=N62lURvylOqehuTwMzARwa7hv5E6txE3hecVbSxedIXeXYNWi5NG/VVWX9vldipY1VoytJSl+HwJ4cKKlxVyWZsokHsOlXVTsONYbmbWdjwPBAtzG5WzLuivt4+KnzyyK0tLDQln/Gw8jtgS1uFVjOGLpzP4mNAwkE8axip0jQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491149; c=relaxed/simple;
	bh=94lwy/J9J+684FiFCC/FsbMtgrLqhkvQTps7WdLHTQM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T7VbmzUFoLJlvqjR1LWR1Zozo5r/k8oSTTWMZxaCA+uHMdznzavMwAckSgN5ELk32q3BnYbFP/6NstlDJmwAfM2MpM52QRPTg0DZILZnJ30nq9/kmHVW2cPGDgispfzh97a0DP3lRodC4Vu73Qxz+8mas+WxMdZLNLfX/7Dx0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K05Cnxe0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K05Cnxe0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4BB1F00893;
	Tue, 15 Sep 2026 16:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491147;
	bh=94lwy/J9J+684FiFCC/FsbMtgrLqhkvQTps7WdLHTQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K05Cnxe00/Qqc/CKktk30s3ShJjA7wJN7ta6Xmuu1Oy2kPHZ4LrXrAKibKZ03xrwk
	 cv9C/SacTnpEqnECu/5B5N49uYNnsC02X0+CyXgjllUfN7vz1yr6AgaJWPi6F2mG8Y
	 4DbwVSJiJHG8X0YfayoMvl5UA8ylMwAhcYqkBIJdLz1q1Dq2o44VGgLYZHpJ2Hv2gP
	 lcSPCg4bjdoMPCiZzSsfqu9UEATwE5rlp0aMsYWue1Zc+Kie3a5jRumcbKOF6s5Xga
	 XUCUka6DCfVz0nrXbLHIFnfL6TPQAvavOsr5ZzVU5cE9IoCWpaGRKPb3RzHXz8eUtV
	 zi7SoryJVg+8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/15] iommu/arm-smmu-v3: Support PRI Page Request in
 arm_smmu_handle_ppr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <dd1ee0afb947b5f7c229c21b7fcff5d18f9bc326.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <dd1ee0afb947b5f7c229c21b7fcff5d18f9bc326.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:52:27 +0000
Message-Id: <20260915165227.7C4BB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> For a PRI-enabled master, convert every PRIQ entry into an iopf_fault and
> report it through iommu_report_device_fault().
>=20
> For an unknown StreamID or a master without PRI enabled, keep the existing
> LAST-page DENY path. Merge its two messages into one ratelimited line so a
> faulty device cannot flood the kernel log.
>=20
> Discard any PASID Stop Marker (LRW =3D 0b100) prior to the fault report a=
nd
> the DENY fallback both, because a Stop Marker does not expect a response.
> The IOPF infrastructure requires the driver to discard it, as per the doc
> at iommu_report_device_fault(). This also matches the intel-iommu code.
>=20
> When SSV is clear, the same LRW encoding is a PRI Page Request that expec=
ts
> a response, so let it fall through.
>=20
> Note that master->pri_enabled will only be set by a later change, once all
> the PRI paths are ready.
>=20
> Co-developed-by: Barak Biber <bbiber@nvidia.com>
> Signed-off-by: Barak Biber <bbiber@nvidia.com>
> Co-developed-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Stefan Kaestle <skaestle@nvidia.com>
> Signed-off-by: Malak Marrid <mmarrid@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D10

