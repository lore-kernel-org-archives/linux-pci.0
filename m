Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B137F755;
	Thu,  9 Jul 2026 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559138; cv=none; b=biXEqmaODlYVuYHd+rPUFBAZpbWeQ37zWmjZD9ftaR7+E++pnTweWCUEovcjSXG53MMgxbH16mT7yM7tktQ4eeYCmQyEG2CmrcI2BWeYwt1wcul1RCSqpR339Fxz6w1U/sSu0ElrzDK5FWFUvL4GTw1mvAY6AwGjdQRtT6JI/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559138; c=relaxed/simple;
	bh=71JOUwkS0/R1OQmZhNUpFN69JGiKedW7DmEbcuWkeB8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nflzA4uCU3sxu5g7ncBSZwXH7HP0qRC9cvhAi11KWcqZWLqSO1xFRmIHkEJ8TsoFB876M5hkB79ysexhTvGUvxnwv0Fw9gk++VezGYfXP4CjCXA27dMRVdhC5Ud44zC61tI1F6VuPSVJRtfGf3P3k2BTRP3c+HqoXRGMpx6O108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkSOqrtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkSOqrtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AAA1F000E9;
	Thu,  9 Jul 2026 01:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559137;
	bh=71JOUwkS0/R1OQmZhNUpFN69JGiKedW7DmEbcuWkeB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BkSOqrtkPx5sy/WZhrbKlpFsnHrJIYWZ1CYY9/swFlA3HCGVUGt938+Bj/3Karig7
	 8Ya2p1p4hHPrz9stCI3ooP5JeAod6QeUaShN5F8Y5FuASBjRpT3kKlL9AH2/Yn7Jtl
	 lHIadB2se0ZJkZ7FqLO9UEBw73/ydHDHQlRjx2uqe8Z+W9PmMk2KIUWfkSUjxQdvve
	 CLDcjhaPRZLmV3DqzBEqxayFhmyAOQZ0GovKqT4gC7j3sndhWsa3jnw8f4/8erHbM9
	 PmOy8NtlpgKt1Wt39MxizLLj9I1T/tgwBlu5wyvDwBXyt0yJS8IwBZfFpTCe5rOUAt
	 16l19qoGZESag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/11] Documentation/ABI: Document CXL Reset PCI
 reset method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260709010304.680422-11-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 01:05:36 +0000
Message-Id: <20260709010537.39AAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document the "cxl_reset" PCI reset_method value for Type 2 CXL devices.
> CXL Reset is device scoped, requires affected memory to be idle,
> invalidates CPU caches, restores cached HDM decoder state, and does not
> request Memory Clear.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709010304.6804=
22-1-smadhavan@nvidia.com?part=3D10

