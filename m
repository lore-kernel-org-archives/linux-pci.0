Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F711DDC07
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096435; cv=none; b=L0p9NfRWXAnI+FfCOXmdb2wvSgLU6HbE/+LUkLLV6QZvMonYKr9S/lpnAt4zfMVeNwBqzoLx9MXLMzd8RxXHrS3VdccFTgYzv537CDANMWCIZgBZBthw2nMoLUFz7+bvO7CiaiZLXeaLUkYAn6Tvuai9LpHQgK/FK3QxxUaTqm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096435; c=relaxed/simple;
	bh=Bn1hy0V7iZkfe8UGnFavti5WEyc8wIv3bsAD1B5rAoo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S3miuhIXVwjFPC0GHlfOWDeZuPXOY1aX9HQk9dYEqemmMrnJ+0w+MRoQNdNfem0g3YIFbn5n5RZGmCqe2Boc2GnsNjqwE8rH5EQmuLa2Qvr5kOLeNW3T32RZaMfE0DiXxsvAiyVwbrQdgjAMvDyCsjah2TUM71EiVurMEMrAWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOdZd8fV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOdZd8fV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA9A1F000E9;
	Mon, 22 Jun 2026 02:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782096433;
	bh=n22VE5G8EoOAfpYQaPiDEyJPeIVJamLN0nRpx1WVoLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KOdZd8fVYIJcZMcbp2qbkSTAQou0fvfyb2yuwPKem3QvIU+R+p78xDyiafGZAhN3Q
	 ch1y1ETFY8q0mTd9uUIE0EMat60a68m6viMljpmIkuV9L5nP2KYoIL0HHwlzhxNrU+
	 gLlNBeMGv2rPyhfYsWt/Lgs/mskWJaGbue7EugBWu6ITUf5XK0RXhJwzV9eAlcmZJ4
	 oMBxIBhpIyjWVIau2xx2AZLQvBnPXX1zWBmBHy30XXuWpgIrKtwFMJ8aKkF5kprC2H
	 rtkFgz/EDFCU/3NSzZ95oD0d43cm4OLQmDNcFXfCdvHIoamJmKqUhuIomO0iGgydZt
	 AY6K2TOwlpxcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] nvme-pci: fix CMB mapping when CMBSZ Size field is
 zero
Reply-To: sashiko-reviews@lists.linux.dev
To: kangfenglong <kangfenglong@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260622024129.40800-1-kangfenglong@huawei.com>
References: <20260622024129.40800-1-kangfenglong@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 02:47:13 +0000
Message-Id: <20260622024713.CBA9A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The controller memory buffer size is defined by the SZ field in the
> CMBSZ register (bits 31:12). According to the NVMe specification, a
> value of zero in the SZ field indicates that no CMB is present.
>=20
> Commit f65efd6dfe4e ("nvme-pci: clean up CMB initialization") replaced
> the check for a zero SZ field with a check for a zero CMBSZ register
> value, under the assumption that a zero register implies no CMB.
> However, a CMBSZ register can be non-zero while the SZ field is zero,
> for example when Size Units (SZU) is set to a non-zero value but the
> actual size is zero (e.g. CMBSZ =3D 0x100: SZU =3D 1, SZ =3D 0).
>=20
> When this happens, nvme_map_cmb() proceeds to compute a size of zero,
> passes the alignment checks (zero is always aligned), and calls
> pci_p2pdma_add_resource() with size=3D0. The P2PDMA subsystem then
> defaults size to the entire remaining BAR, which may not be properly
> [ ... ]
>    to detect integer overflow that could wrap to a non-zero value and
>    bypass the SZ check.
>=20
> Fixes: f65efd6dfe4e ("nvme-pci: clean up CMB initialization")
> Signed-off-by: kangfenglong <kangfenglong@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622024129.4080=
0-1-kangfenglong@huawei.com?part=3D1

