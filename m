Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25C47D441;
	Mon,  7 Sep 2026 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780664; cv=none; b=OuVk4BRtH0ihsEwzXiQCoM3m+8eOty5Z4WSHQkj2ntxp91rtb+JV/76Z9xhAmkeLpVE8a6ah7gkTDJ+zSz+QfYaNSoOP78MV1QWADOhMNkxw/BbLWxT8lYMTyVNFr7yrkceiMvxs6pazbPyN53De/t/79COcw70lEzMvruoozMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780664; c=relaxed/simple;
	bh=/BYKYcikgor5SSTHOWrqFHRAYUpGOcDhnBnyacCSMlM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LLUYvxUp+eEPDz8MI6rp+9/dmRcfxVkBxXVufNtz6Ivb7RimICM02pAoPbDqncUpzvadeIuC52v2QzdLzQoHNb7HYBO/q0HreFBCIVMd0jqM902mgEs/Jyb/bcVC7G53g9p1CAAmRoLhYaqWU6p9wsoroinpr72YhQpJs1R18bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSkGQ2fE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSkGQ2fE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A751F00A3A;
	Mon,  7 Sep 2026 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788780662;
	bh=/BYKYcikgor5SSTHOWrqFHRAYUpGOcDhnBnyacCSMlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eSkGQ2fE2HvKcrO48C/RgtmhAvdHfZ6qWxRh8dFcMpkOFaFrB0HKDJ5Eho/EVwyA1
	 nLhbQ6TiLN/WhkSrEE82V5lFfLBXU58bmYj+NyrAlNhJR3yrkHbHMacUHsQb6K+d4N
	 ScmhioKW6agPH7Y6u93hVpfQpHwXvzohuDSkPHjZhUp4q6gz83/9VX+LV84NqdQC3m
	 rlhHXF3mz8TNqMwQhoAvGEngffoaBeH/VQXU43fulV+yi9r+I3d+ElGqd/xrPjg2Cz
	 dxkqptkw26VAaVNl+E9uCC/kbPWYHqLFKn/pTbdbY9Jp2NgTskyHo8rYFntkoa8etZ
	 MFpWnVB3Y+OHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] PCI: spacemit-k1: Add device data support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260907112606.465778-2-inochiama@gmail.com>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-2-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:31:01 +0000
Message-Id: <20260907113102.75A751F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
> data to handle the K1 specific logic and make room for the incoming
> logic for K3.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907112606.4657=
78-1-inochiama@gmail.com?part=3D1

