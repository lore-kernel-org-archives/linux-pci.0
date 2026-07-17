Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2D390C81;
	Fri, 17 Jul 2026 22:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328219; cv=none; b=Mu50zyrkqfGsgtSIA+BnNCdXwe8d7XB9KiVYq/oJGLHZ7v6DfOymd1jK7u0srn2Gx2X37Pg1iTXr0fcWtXS8E1/1l5uODmFf0rY/Ulj598/aBgmplyYkwAZzinrUA56cfoCBIVYStX9PjiTAdy3CktZ+3xLfIzeohiF9fPbtJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328219; c=relaxed/simple;
	bh=clO930PDCF6jeTNyimlNKfuuebQj86lNfOL61WaitFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T6hAQ1jI63O83Yzz4ABNtDqnxfLw3MsTKo4OthumJ8Vau/hrxoqau3rmqNb4YQzarLQXFd5ZJdtcsUQSKexMt5DxmZwWmuHusVcuN/r/UaKHyOW93L6vihKpDXuvem9tFOsU/Xp6k0SIIbp321OweGyojCL8UCoJLGL/hqPwp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrpdYKvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrpdYKvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954701F000E9;
	Fri, 17 Jul 2026 22:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784328217;
	bh=clO930PDCF6jeTNyimlNKfuuebQj86lNfOL61WaitFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GrpdYKvfILMOrRPRYp64hkWvtdrHYoqPM7Av25a1Y92I8RmpEKbdr+F3vsAcGn50Z
	 Y2CDH66ETxbhsOngxNFWE7NijYe6Q5+dWFbBU/Inj7+S2WKcvlkCMVWJVrlOSbmcPr
	 Z/FxdpePMdABgyd/28eFxqoyoToW/jVTqpjoZmMtBvooLJuKAfexQcA9KfTc0sKA84
	 dogBafL9qk/AKdQALe/c521LMoaAPDB7PZOLpm82ByeV8ZsD+o01m/9KZR/vL+Aq0r
	 gGfWB7zb9EcM63c6bN5kx5iOd4ETbHZMvYmtawDy/3AK8WlTIJl72+kDr/kigNMdPO
	 tQV5NyTDcrsZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 13/13] Documentation: cxl: Document CXL protocol
 error handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717222706.3540281-14-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-14-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:43:37 +0000
Message-Id: <20260717224337.954701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add Documentation/driver-api/cxl/linux/protocol-error-handling.rst
> describing the end-to-end CXL protocol error path: AER ingress, the
> AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
> cases, severity policy, trace events, and a source code map.
>=20
> This documents the architecture introduced by the preceding patches in
> this series.
>=20
> Assisted-by: Claude:claude-opus-4.7
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D13

