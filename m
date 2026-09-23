Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDE58039A;
	Wed, 23 Sep 2026 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194817; cv=none; b=lu0nQwa+6hBSWD4+S6dkLvrp6RPeVjVFqXosV8QkBZzgNZOub2O4ZIz0zaA764PKYreRpTAoS9VRlLlR/oLP5ciqT++adxwinY8O3V2MiNDAaxHedQEbDy37GvhLRvtPC70hqiq9eZFgL4YaB8JdBwK+TkOKYcz71rEwzly0rqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194817; c=relaxed/simple;
	bh=oPLDgtXJLOu8Kf9acheHgxe6Z81oVWWkeD3AWJvYslg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JJu2ishyKc5v4/apQ/15USxnBfJkJdn4PhtbIyat4bTcIeB/lcs+/+iXYRLbOxOI2AKwVR6dtCr0hLq5to/XnobwKEXuKMIlXCVhBLJJO4MOQQQTyXAhJ4ME7kFMzHLdmqsCIRVZfrOnhy0tDjASIgJ1RLo1jsQ8s1toPebaz9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oASc6oFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oASc6oFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9EB1F000FF;
	Wed, 23 Sep 2026 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194813;
	bh=nFfNLRt/uobKlAqq6l3vtsxuVg7Fpddl4PbGzn2V2a4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oASc6oFCvg8rHzfygqIcGoaUXu5GK5pd1vdHmxksXUjT97qhRT3HZPFvEVFk13FqE
	 Bx6vSwQRlreUSsIPg/VJrysflQpDuHqXI/9hdvSS2XPJHe2IwkY10zvV/zFNzP9RbX
	 zP2WPve98eBKzu03mXzZ1GT2GIW6+evmP6id+WjD/iM8wURdDgTy9qkdBTmE3xi2xU
	 DFBFCVrA9l3po0fXb8+6ZmGY0tQq/E/4UtsEIjVQs1zafubfKo6z7UxtG5U1vs9Fwq
	 Z2zCoN09Sr+21mBmPP9XOFSFzcxFQt+b5FuIDDm5rrFu6/yDwHM4tcH+PpLxaaihZh
	 Zswia6T3S3lTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/17] iommu: Pass in reset result to
 pci_dev_reset_iommu_done()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <bf5ccc916593357c640cd7fcdffabfb46fdf4c64.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <bf5ccc916593357c640cd7fcdffabfb46fdf4c64.1790188510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:20:12 +0000
Message-Id: <20260923202013.4A9EB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> IOMMU drivers handle ATC cache maintenance. They may encounter ATC-related
> errors (e.g., ATC invalidation timeout), indicating that the ATC cache may
> have stale entries that can corrupt the memory. In this case, IOMMU driver
> has no choice but to block the device's ATS function and wait for a device
> recovery.
>=20
> The pci_dev_reset_iommu_done() called at the end of a reset function could
> serve as a reliable signal to the IOMMU subsystem that the physical device
> cache is completely clean. However, the function is called unconditionally
> even if the reset operation had actually failed, which would re-attach the
> faulty device back to a normal translation domain. And this will leave the
> system highly exposed, creating vulnerabilities for data corruption:
>     IOMMU blocks RID/ATS
>     pci_reset_function():
>         pci_dev_reset_iommu_prepare(); // Block RID/ATS
> [ ... ]
> the old domain in place of group->domain.
>=20
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D5

