Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC923191C8
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052843; cv=none; b=AHpsy1gWXEaTyq5yKm/NG9Y4FOiIxJjadEX+nUOXW64qfz0fSCIj4NRIFcdG9tKqlR0hR0z6h0MQOYObBqR22rqpJMMPkLpodfwNE21E+QDKW6MPnUu2No75vTds54Llx4HY2d4VU+1P06ogm3J9Rz0HBPAMAt4jL+/m2cPr2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052843; c=relaxed/simple;
	bh=eR73jyJE7wfXnyX6cwtwaBgyNSwomXQwe4LGBdnOhgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ena7tWy89yUhKHDVnHIERtTLrCV3J05DRHxH1TzHcF1ljX0Z6supqRu2y0ar/6RvboFuHzhgr3KNjrVmd7RTdFr5BBZ68A+TCveJNGO7yjeq5yXzh0/tyO5ycU1RZmyFg5rXVbNHKgsOQQCpPjMw88MjoPgOHZn2MfQuU87Bwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFQDCi+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFQDCi+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53281F00A3A;
	Fri,  3 Jul 2026 04:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052835;
	bh=yzVWtLum+/6kA0xp013KtBkY6/3TUAiwfeNK5fYsj9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oFQDCi+7X0PxNKWmcCIvEZH+BMWRvrCS+8P/RaGjCEzJlbIkk3MfH0fO6/4C1Ey5B
	 f7qeQMQMiiiNSDyuquvSXeD6gBl9+M2DT9/n6rzCjFThLCiIbCCKvztQKq9a1JWvjr
	 dLfzPp5JZk748lxSu3j2XijGICG5LYcNYXhUs5Tz6adzurvUKFvRFGfthq6cG8e+eW
	 vaV3t4mNdygtFQYe7UiGj8JdVsRcYQ9NjRD3O1N6JcHZgZudO9C30PvdOYdpGiX/Cr
	 rJBX4ripk9faqhEJR4hLh+bqrkwzlYK1G2dGocjk/3nfNL0xO+ZxNzeqQgdLKy7ORa
	 UZHK9AvPBCIaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/18] iommu: Pass in reset result to
 pci_dev_reset_iommu_done()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <9306670b5bd647e477e36156b124557917baead3.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <9306670b5bd647e477e36156b124557917baead3.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:27:15 +0000
Message-Id: <20260703042715.A53281F00A3A@smtp.kernel.org>
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
> This introduces a new situation where a blocked device is being unplugged.
> Decrement the group->recovery_cnt accordingly.
>=20
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D5

