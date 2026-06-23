Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE2A27B340;
	Tue, 23 Jun 2026 03:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185623; cv=none; b=guppSp38/fq496ZM5h3pHq5ji9tx6xL81TvEoL5lJ9IXwe1YQNn6OfydWBaGInoasdLCcJxO1hyf6YC//6qYZlTNjwduqZvAXZrquRLTrwA2owfelnXw3uz1uPSwgxG3RBg6pSRwZiAPDCvq3DNDw8VKgtTV0l2alWcKUDpnPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185623; c=relaxed/simple;
	bh=E56ASrF+niAWi4uJTDv33yV/39dZ38yi0rqELcH1yU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jDvKn9sKIAHwewBvjoCybK44Le9QR34dS/FBj6MjNZmkq3UF5hXCGJTcP/Kcl/8plS/mJcVe2c9KuY4R0dxJGOH6Ee/T7A8vum+gejcQIqiPMafNIElCzGyCmLJyEp42yDSoOhW5zExUxk/oejqnjZZfldOJcMLHcFgeRq7AFmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eD5D/ZDC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eD5D/ZDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701E11F000E9;
	Tue, 23 Jun 2026 03:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782185621;
	bh=E56ASrF+niAWi4uJTDv33yV/39dZ38yi0rqELcH1yU4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eD5D/ZDCGoDJVpA1GjiW/sioMYP1sSQyDyFjgSyr/369AAuncmCHQGqhuNGvi0tGz
	 e7MuRhjwrZEeH4Q2WBR3AxioIwKLuRdIIQzByoQkz9N9ViXuIXbil2vs1i6AxZv5K0
	 I64/Zg7HJtDXNEF1tV01JJp3n3tkPJAj6JVT0+UK2WJ1Loe7zZQHOeeoVyS7qZn+g9
	 8ZWhopE4eqXOPxslHbhku+hK3jlxPMDQ4jhlZrePDC3hJARvITyjcwxG3K3Ef+0JG2
	 I8BAYALobfo7nW6Z+wZ8NyuFx3Pz1gjBYAndyALC7kyiT4P7imGaxnwuD073xYjR0Q
	 yaYYmZx1vEvGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/11] cxl: Validate HDM ranges before CXL reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260623032453.3404772-7-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:33:40 +0000
Message-Id: <20260623033341.701E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Before reset, collect enabled cached HDM decoder ranges, reserve them with
> request_mem_region(), and invalidate CPU caches. This rejects reset while
> affected CXL memory is busy and keeps the validation stable through reset.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623032453.3404=
772-1-smadhavan@nvidia.com?part=3D6

