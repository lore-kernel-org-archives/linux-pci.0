Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22A340A6F
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590753; cv=none; b=r/ebGLZCeyDE/PJn3l1KPlhyA9vEjuFjPBR6fj9g6QIwGmhkImaPvIlClp+9fVU7KBD/gWb9PJZz3+FDzbWdQgpDMf89neJ1aJqR/p+3NUIp8m0p2g0GYG9hQ3JSgG5rMAyZk2iKwifP0+Y3vOO5KV1myhi3f1zlJYtLMI1XE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590753; c=relaxed/simple;
	bh=y3LLcW00m+gezmPDmCOu0pruiBOkv12IH1Av14wW1X0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fz0Qke+5ZPUf+v8aoTz/BPTzUoYDYButDJsmNnDbdB0UHRz/uA80QD8b8TGRZQhMq6mwyU6bn+JRoWhjIlyFGuQjUBfgXvbEnaGhEvFNC7qSlxiSBytuHK8IOneu3UH0A2spF4YEyRClSt8F+05qm/OLHxWsgInCTYab/05pjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cENugqyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cENugqyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418C41F000E9;
	Mon, 24 Aug 2026 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590751;
	bh=y3LLcW00m+gezmPDmCOu0pruiBOkv12IH1Av14wW1X0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cENugqybJVzZRNZus6uBnmfr54ekGCz1KWeA+pkO11BfgVRQwz7F9jYYQl1Ihj/OS
	 avFqexDCc61y37DMEJhVL8ohXKUwtnXXfA/hZfAZ9DHqKLU1gkTZrSvDxSMWeHEHy+
	 3WQX2cso9b0lx/1oK2OGBSx+Lt2cV/7vih2Yf2jzXYU7eaSuraaBtK+kVl9SjY8oJQ
	 QCOLdbEsuI5omwQgI2w2V2NWVdt9tT0LRjx81e1X6hhMnGTins9yY4mPGefWDJxmC+
	 Mbm2hw1L2aiYnmf2quuS52j/pgZHCVnlPYtS6agTx/wrUqRYTJbd4eFWvOtdp+mNgd
	 LRNgwSK+9BQjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: Add Tenstorrent vendor ID to linux/pci_ids.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anirudh Srinivasan" <asrinivasan@oss.tenstorrent.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260824-blackhole_quirk-v1-1-fc004672cdbd@oss.tenstorrent.com>
References: <20260824-blackhole_quirk-v1-0-fc004672cdbd@oss.tenstorrent.com>
 <20260824-blackhole_quirk-v1-1-fc004672cdbd@oss.tenstorrent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 16:59:10 +0000
Message-Id: <20260824165911.418C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add Tenstorrent vendor ID to pci_ids.h. This will be used to apply a
> pci quirk for the Tenstorrent Blackhole card.
>=20
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-blackhole_=
quirk-v1-0-fc004672cdbd@oss.tenstorrent.com?part=3D1

