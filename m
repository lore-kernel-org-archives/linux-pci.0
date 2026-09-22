Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD882448BAB;
	Tue, 22 Sep 2026 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066979; cv=none; b=EmOJXHSXZYFJyQXgR/cCF2Tt/Lth/3TkCrXQzmJIoEsRLF7MuwhTsvWBRsKKQ8/s1xvmGhC+zxviawZjkti4lwulZnAElvVNBKUimkmfmzYFal05SLyhgHSSr0vODnXJcVf/pt8TuM6JLTP1but9P4w3GQhdCclcSrLqgL30E2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066979; c=relaxed/simple;
	bh=a3kgxat/nPIJ1L9nSb4of3ZDnrVjx2+6ofJbLo3zxSA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RbfdNJUEHYHiX56j1bupjfVWzAtjfKWA+rYEgbXnRoKTJNuXafcuE+6a5shT6pntljk31eWhyeTu5LvluyWgZ9EcZJ4t0xRQ46K0a3rE9Zbyy5hf8wDSJJrpnU0T2zJj0lXCT1Nr/wTFH8Ji+ePnQl7co9+5xlXGbadRFblqBrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oba26QGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oba26QGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6001F000FF;
	Tue, 22 Sep 2026 08:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066977;
	bh=jLll+2Fs5jYW9KhrsgzqJfVjo6gSSLPMs/SVuyZnzFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oba26QGs+6m/VksfqOhvQ6AV+aQVojrS429UYHiteQPYHXvpWV2LOVS2UmviXzehp
	 aegJjRIKiV2u6IILrTcNf9CJZCl2cYQTqvtF51vWzJzGjuoYzu3g7ITZ1x4gk25mOa
	 iJQpo0E9+k6RfTYh/spHGpuVbzhUUZFfoS42rQLawwNTB6CXPi6fPtgyEUOlXsDdMJ
	 78QlOWN3eZUFLopXDQ8zLcHtXxrfX+0FU5U0jWm8rShUmbePePsGBnT6Mu+t9MGlPG
	 LJRh2J4+1huJKkFYZ5KMFoufxWTaNYx1BT20bPkA61Ig/BC6NFEoLa0mRVX5Us9Skf
	 xjhn5qhzJwPPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 10/15] cxl: Add CXL Device Reset sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260922083924.2451158-11-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:49:37 +0000
Message-Id: <20260922084937.8C6001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] cxl: 100s thread stall due to ignoring PCI errors in cxl_reset_w=
ait_done()
- [Medium] cxl: spurious reset timeout for devices with <=3D 100ms budget
--

commit 0940b93cca76ebfd20726ff13344213cdb258009
Author: Srirangan Madhavan <smadhavan@nvidia.com>
cxl: Add CXL Device Reset sequencing

This commit implements CXL Device Reset for eligible Type 2 devices. It
disables caching, prepares the IOMMU, initiates reset with Memory Clear
enabled, and waits for completion.

> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index b5f8c28e613fe..57eec77cbb213 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
[ ... ]
> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	unsigned long deadline;
> +	u32 timeout_ms;
> +	u16 status2;
> +	int idx, rc;
> +
> +	idx =3D FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
> +	if (idx >=3D ARRAY_SIZE(cxl_reset_timeout_ms)) {
> +		int last =3D ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
> +
> +		pci_warn(pdev,
> +			 "unknown CXL reset timeout encoding %d; using %u ms\n",
> +			 idx, cxl_reset_timeout_ms[last]);
> +		idx =3D last;
> +	}
> +
> +	timeout_ms =3D max_t(u32, cxl_reset_timeout_ms[idx],
> +			   CXL_RESET_RRS_WAIT_MS);
> +	msleep(CXL_RESET_RRS_WAIT_MS);
> +	deadline =3D jiffies + msecs_to_jiffies(timeout_ms -
> +					      CXL_RESET_RRS_WAIT_MS);

[Severity: Medium]
Does this logic yield a 0-jiffy budget and immediately timeout if the device
is not ready on the first poll?

Because timeout_ms is clamped to a minimum of 100ms (CXL_RESET_RRS_WAIT_MS),
the calculation of timeout_ms - CXL_RESET_RRS_WAIT_MS results in 0 for
devices advertising 10ms or 100ms timeouts.

After the initial 100ms sleep, any U16_MAX response (which is common while
the PCIe link is recovering) will immediately trigger -ETIMEDOUT without
retrying, providing zero grace period for link recovery.

> +
> +	for (;;) {
> +		rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc || status2 =3D=3D U16_MAX)
> +			goto not_ready;

[Severity: Medium]
Could this cause a kernel thread to stall for up to 100 seconds if the devi=
ce
experiences a permanent error?

By grouping a non-zero rc (which pci_read_config_word can return for
permanent errors like device disconnection, e.g., PCIBIOS_DEVICE_NOT_FOUND)
with the transient U16_MAX state, the code falls through to not_ready.

If a device advertises a 100,000 ms timeout, this causes the kernel thread
to sleep and poll uselessly for up to 100 seconds when the device is entire=
ly
gone, delaying recovery and blocking operations.

> +		if (status2 & PCI_DVSEC_CXL_RST_ERR)
> +			return -EIO;
> +		if (status2 & PCI_DVSEC_CXL_RST_DONE)
> +			return 0;
> +
> +not_ready:
> +		if (time_after_eq(jiffies, deadline))
> +			return -ETIMEDOUT;
> +
> +		msleep(CXL_RESET_STATUS_POLL_MS);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D10
