Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760987;
	b=AIcGBeeqkbnGjcyGtsurA1UXwxq/4s397y7FuaIwbS8XmDAJb4/tvPwzkLtwfoN1DtWD
	 M49RNalnWrwbfKtz68Fp6c1pLwXRFk+T+PkelOLHv0dXhUuJuTV3VKxqEWhE/7T1d01o3
	 csVxf7suSiJYVymGRlyVzuvaUx9WQaLgWj4VLYJugwaCM1v9a58RWzfsOfTORgzGdquvo
	 CX4WuzABld94aKZzRuTEyYUkHe8MDXvgH0Qd+x5iht0Y74U7WfbFsYiyGZ4H7wtPmBmQE
	 P1sKLMucofbdzGXoa1FRJQ6uAu+KsZ2svbuqNg/DvBRGFyItXr1LESBeaQLAa1+TOmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qcQwK8cZ9lWxsH1DQaLYIJ9uFi9nPIv9Go4ez8lWkPI=;
	b=j3osCucLRzuQzceFBZ0cwLRWL/LSLPlHMVEt+mdUsPhisfJ0ymeJlZXIQe/URZun4gwk
	 WO8w5e0Xpa9ApfIbbVZo7BU7cVjJFT+555ROSrBef10Dz1t7/oAkudulW6aNxymS4LxkJ
	 XGP5aVW4VWtHMGsVaKflKzaiA7MASFYumP0FfV8/XRPDbID7dPBNb/WM9is1s2cjnBr2G
	 8caEoePyfd7xB1di++5gYEnz7Jm95KpUJL6za8Ey/ZxmF+7DWYudaVh89bmi7uNhM9T4H
	 zWfKJsTVUyjHQ9hCImGCE49J6tzmOHjgrTUA2ztEuAB0+gmRN3LAA+3ZExJMdrqGxLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L2l/TdWA";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1F606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2l/TdWA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B696D1F000C1;
	Wed,  4 Nov 2026 02:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760986;
	bh=qcQwK8cZ9lWxsH1DQaLYIJ9uFi9nPIv9Go4ez8lWkPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2l/TdWAFvWgrrkQ7yQOgjMjHWmyywKKkj4rrWyLLgM5P/Z1zPQc6YLCgtwQKmhyY
	 VC7NIkuBMa1CRbiCk23SFi5hWl8B9AT2qc1fiqxGdtqqOXN9wLWRpA5yjUtO0+EYTg
	 uazkJM91R7FDOqPTdUrwqLvbRmprwZKYoTl91qeq/zuQRNFeA6eH6CpkCK1xBscxPk
	 FU6Vx4EqEkIh48NudyDTIJN07cFGN+txl4Q93Ncz1Akr9RjSU/lZQoBluZgN0RVLV0
	 kqF+Q7a8UTk/PfW6bwCV6MepqhylGq8Y1pTNSOEupWRqft5ldc1Si6sTIsVTYKc+Jl
	 rgfjP5sU9LfVA==
Message-ID: <sashiko-outbox-196549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/25] dmaengine: sdxi: Allocate administrative
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-9-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-9-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:56:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nathan Lynch <nathan.lynch@amd.com>
>=20
> Allocate the administrative context=E2=80=99s control structures and regi=
ster
> device-managed cleanup.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D9

