Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F4136351;
	Sun, 11 Oct 2026 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791684998; cv=none; b=YifILBPVlIotrZfv/IZA3PzhPRn7XiulZPjmwaMNyuaTJgP7PjCgpxoHifT1wLryVXC0I46F3R1oyOMlFxTa4pIvpQliRM5vaHprf8s7Y8F8ad30dT3GlsdA6UADvILTLTJGxM2kTRiG0YywjtauXEcMx70DlWCL9uSDIVeLTAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791684998; c=relaxed/simple;
	bh=dWVS6cQLWflm9qxI5Z+E5/PmnUmeDQHPXoZM1o4gfzE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LC2zs5+QyayNCFbunVmZLCGVIn+vj9aiyxUTYIfqGE/tfoHtfbEz9d3SFxi2bjgY5HlMhND+UiyGVJ5Ja7J62a6KakzyC5AitlpbwGdCJtlvON3ZooxEczq2IcAMtX7Qa+f76I1vRItEYke3lQ/+PlHtA1cVBmFvLEbt7PtH/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBnJA54S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBnJA54S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C731F000FF;
	Sun, 11 Oct 2026 02:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791684996;
	bh=dWVS6cQLWflm9qxI5Z+E5/PmnUmeDQHPXoZM1o4gfzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VBnJA54SQ3BB4rxZJAsYJJF8YsOHtFAIB68RSGjPNndpraoSvurJ0MEzHclAQTLbv
	 n2A13h/8UbSZ9E/l1D1hOlNEJXkYwJvWCejg73HuxdEvhpQgdkC7XO4tAUkIYF4eNC
	 vZsj+HqUJsqZ9R9DITyMsTu9H72u42FS7fw0i35CEXgKU6xe9+ZhgQzhxa94+MZXQw
	 trkVLpt7qeV4S5qwVKxbSAxc1wdh2IFtUzFlvcJ7RFVaB2hFzYHOEBfHqK7u6Lnx4P
	 teZlv0KpQ1C3xTQYgjwNrPUfkaBU7pf8UFl5ws8NnTqiBrTgqQ16+b/aeIyLv2je4Q
	 u2atrXDx8LLVw==
Message-ID: <sashiko-outbox-166967@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 01/16] cxl: Drop stale decoder interleave limit
 comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261011021422.3428136-2-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:16:36 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> CXL 2.0 added 16-way memory interleaving, making the comment that the
> specification supports only 8-way interleaving stale. Remove the comment
> without changing CXL_DECODER_MAX_INTERLEAVE.
>=20
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hla=
ptop/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D1

