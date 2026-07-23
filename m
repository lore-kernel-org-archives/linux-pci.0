Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7049242D7B
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787693; cv=none; b=Y5zjnxqlHQm160RX3DTJ95xs0TB8MjVynBRmeNVhPtwmtE81ihGc/Ngmrqn/+xqmwCRSDZI2fA3oDyybw1luGWukCGeEqYlgXqFA8OlGARhmgBMSm9BiS5B6fpQ1mLYg918+bhDKhUcwgXFpwg+vYRE0TIqXxhipApDpVsbB2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787693; c=relaxed/simple;
	bh=+aiTL/jGpKcUb0oL2cTdy9yMAL6s51N721KCQ9gWwkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZNdjY0JKiyO0ubyJON+h06nYW9nePSE8gp9gowWPsi4A73HYLuO4tIT/VL7ILtzT+vzXVvqkFVwoY2Mi+omT7MlVPz7Wrx5sFUKPNkwprP3LnzXqCSSVyNNNSoWI+YtBhDearXUTyUbyYnWQBmsGHgIIVs3D8uD63s7IbdTJxnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9fMJ8uO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9fMJ8uO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E014A1F000E9;
	Thu, 23 Jul 2026 06:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784787692;
	bh=/LZOK3Ztt5svI/hCd1o7VO2xuzcX6cTR6vTnGVLuCVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T9fMJ8uO07wn/q3O375YGWzmhhHqYZf8niIvH6kwcSVH8XvVFCuFWrtRCUyUFqjnS
	 MEh4bWU15QELAREWYOXfz2T7X47xC74Yk7HMyxjNUqIqBPYhtb8o+vFTOi9nzda8aN
	 21hhYCe4ds+E7dVj47KY2X/urFnW9SWv5R+sUxUfCXiBt3ibCI4OBbqCtWFYGuF9n/
	 m0YpbOSCABboMmV9OVn/UNbl0nVZ0+n4bMAbTZ6vPeC1dkz3pdcgZDYtlZLaNWhBJ6
	 gxNbulk4yqTDimk9JS/Q6t+CJeMpJWrbMx3WiAgSUqaEAavObY+pSvF8fIBXCf+9MT
	 RqQak6+KxFSjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: Mark Radeon Pro WX 4100 ATS as broken
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vasant Hegde" <vasant.hegde@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260723061548.10187-2-vasant.hegde@amd.com>
References: <20260723061548.10187-1-vasant.hegde@amd.com>
 <20260723061548.10187-2-vasant.hegde@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 06:21:31 +0000
Message-Id: <20260723062131.E014A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> If ATS is enabled then IOMMU logs below error and GPU fails to
> initialize.
>=20
> [  103.687137] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT devic=
e=3D0000:c4:00.0 address=3D0x1080006060]
>=20
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723061548.1018=
7-1-vasant.hegde@amd.com?part=3D1

