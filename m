Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2133CE084
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383016; cv=none; b=Lp6w9VdNQUVZ/uLaN38hZDhVI0nAeDRTKr+3+mNorhzFLQc4JRFYb+WOfS8HETz7557lzvyKfiTjJMEXy/yBaT8OSy4waAGsNCukDuKJyLdBGjmqLdcuJs4jP0u/Ictx5WEQmOlPulr52HyIT8CTIoT7+j7hkNKkm03tCe5gWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383016; c=relaxed/simple;
	bh=C9cy5X46mpfJaxjzJE5nnhGS8+xmXzq7l60y8YAKFoY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CjK3Aj5a630YoJGBvCvHSZZdAs4MOTHK4JiCRMRRraLH8yVdFeAS6/rBzM5RC+cKqbxzyR118t557zKWt8vQkit2/VH9DU6F3jkjrxDYqj5lVbevMP7A9LgQtChjaQzuh9eCvJildVZQpyM4WBejITCYdjFyT4OoJJrpzgs4/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHXoZHq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHXoZHq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFBE1F000E9;
	Thu, 25 Jun 2026 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782383015;
	bh=C9cy5X46mpfJaxjzJE5nnhGS8+xmXzq7l60y8YAKFoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dHXoZHq8pweZKMQ2jNnzZ1idxV4sdEy8VPD7Fg5ZvYuL1umtAqS3GIpnwiBq+d6JX
	 OgjKIrydmBV6cxqLGugiXPhdhrDhNRiDq4wfCyWT9OaPXOksThLRDOjegLVZdi/bc2
	 wwCY8srHSv7CRq15F8N887xAf++aNEtPGyUFdtweaT8sVhQjIJJxkSev+a7vY6XAgk
	 vdnHOV61SVo7AJNNELVH1r+D49LAjEeTdt/0c0PC9k+YvVo/GAWrr9EGhL2SzIYMlW
	 Rmqx0X05TnLeJ0q7+QHUie2U/E4p+vEWJGlx8bx/9DeMyunscNX3X/XcYJhP5KDHTL
	 AzzZ0pN7oEdHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 3/8] rust: implement `ForeignOwnable` for `Owned`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-unique-ref-v18-3-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-3-4e06b5896d47@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:23:32 +0000
Message-Id: <20260625102332.AAFBE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>=20
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-unique-ref=
-v18-0-4e06b5896d47@kernel.org?part=3D3

