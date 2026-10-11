Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821612EEE84;
	Sun, 11 Oct 2026 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685296; cv=none; b=t8YizwIjpdAyk6XYWbp03qLXc5DwT9jN4oL+br2rfudD1MzrzbS8+VkuAEOG5/WDIc/iidYD8IxyCBO5l+rN+6V0te+yk0pTHDK9l8cxGug3cPIBDz29JSARbT9lE9U3vegky9sSmCTeiRh2jq0dHOCPrwkO2UzpDDZP20ufX/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685296; c=relaxed/simple;
	bh=yfl2vGU4iUWfqv6jHQjJqOysw9fmgxrCpP2K1pAlNnc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JVTzwDxaY0nLnLl7o97Z0wCSvvQc2jfsI4eD4kXXmh/emu+vXImjhGxhL97OCP1ZI+twfaShWz+sXaWO8YFpeGgaog1pNIYdt3NDdCMQs8xl5/WE6NkXZi79H1hWF/q9A2jJOoIuOTT+LucKz6VX7Xyf/M/qqHixR6oTluw9kpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8Lr3Y3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8Lr3Y3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AF21F000FF;
	Sun, 11 Oct 2026 02:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685293;
	bh=yfl2vGU4iUWfqv6jHQjJqOysw9fmgxrCpP2K1pAlNnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e8Lr3Y3FI1FweS1nLKeCBbGNbiBLgEc6W4OdSYiDLi6P930guBVYjvxRmZBkNDTIm
	 stZXNSWlOmCwCPQtRyIFK/PHJJ8aX7KBGtV8fosLl/5R6rA2rl7wiX72xKJvdUL1sL
	 t7MA+rXqzcl17Dspmc29O4wfW46B2+J3VWh4LbiCe8wF91Rr/brW0Wdej+8m/xVgbB
	 As2HvhuuKiP3BVhUrfPUQjd9NdBj5SRTp1ZMWaDNrmqIZsB4T47rPNoseXueF48Emu
	 lyPavAcwVMBq7emMB6OevtZoNQwBEoAY8coQiDnutXL1fig0l4aWEggqc3UQQ+eD29
	 8Lt3sL2N3I5PQ==
Message-ID: <sashiko-outbox-166969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 11/16] cxl: Validate and synchronize HDM ranges
 around reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261011021422.3428136-12-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:21:33 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refuse reset unless enabled system-physical HDM ranges can be reserved
> exclusively and CPU-cache invalidation is available. Invalidate before
> reset and again before ending IOMMU exclusion, holding range reservations
> until the second invalidation completes. A later patch places state
> restoration before the second invalidation.
>=20
> Reject normalized-addressing decoders because their cached ranges are not
> system physical addresses. Ignore zero-size decoders because they map no
> address range. Refuse reset when the device decodes memory through its
> DVSEC ranges instead of HDM decoders, since the cache holds no range to
> reserve for that memory.
>=20
> Provide the range handling as a region quiesce in built-in CXL code. The
> quiesce lock blocks region commit and teardown for the whole reset, and
> the HDM state copy taken under it supplies both the reserved ranges and,
> later, the state to restore.
>=20
> The range handling and region-quiesce structure follow Dave Jiang's
> reference implementation on his cxl-type2-reset branch.
>=20
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/co=
mmit/?id=3D5944c6e61f14c0dd28d54537be15edb2cadb0e8b
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D11

