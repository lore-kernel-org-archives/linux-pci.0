Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7047411A0B;
	Tue,  4 Aug 2026 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872542; cv=none; b=qrinNvfIIwSvvNnZKCIpRFRgji97x0ujO2rAVksGsh4FXYsuNr6kslKMRehrbT1+NBmn7sipC5ESSlP6H52m87A8v83Zkc3Bit9iIW5AmhzdXomk+uT42SC5U50dRoL0XFd8LDmc2AH9RR9RDbKezXNCVj7WPV4EsX0uaxKLO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872542; c=relaxed/simple;
	bh=Oatn5+P+6uk3ncnK+EtrH5TNHHqkMawnjzUiB6bGZI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B0vn/XgWWkW0zXz4fwtnB1ZuHGd4Z9JMgkqPeoxs4AyjqzYB25LdBf/jHyQxbdAnSo/zk3Jc11rVaBfUzY6vxa4sb133VxXzhLjKVGOIRwYJSwU0slNTJe6OiUKhxZLItyKiuuCfHLtOPcsgl8FMCX6IsmM8xjkNh4VJHUUcVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofIPhsSU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofIPhsSU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C42B1F000E9;
	Tue,  4 Aug 2026 19:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785872541;
	bh=NIKpwsW46AF/1G7ugX/0nb6pt4l2cnkV7zR82BT0D6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ofIPhsSUYul4W1lXK4HFNzWctwYBFmgOVvnWZeVcdHLV3mfkc/U1Owqe4TEgSEEEE
	 XSlPH1zA12RiJzRsPPe8T4/ZPVhkJvbFUTSEAUc45kYvlZ1b/DzDxUXAG/Fua9fTCf
	 Yq3H1s1PWM58s4vqlGdjtfCqlrE3w8WT1mpXMfyCOOqoaaupV6fmfKuTGfTL2nNR0r
	 FYdSVt20OU+S6EidN/flT+c0hP0Bk5F+UT+VDC3QCfoYG4hSORlsF4kOeUvra1WBEj
	 INyHP9WMm1mQpSYtHFBMsinlGNkgXBkXYacF+8HRDyh6SmazOcMCJIsImxveLZqDqu
	 RvQplSRivPYnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/12] cxl: Add CXL Device Reset helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260804192958.1823952-7-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:42:20 +0000
Message-Id: <20260804194221.4C42B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The polling loop in cxl_reset_wait_cache_wbi() misses a final st=
ate check upon timeout and is vulnerable to returning a false timeout (-ETI=
MEDOUT) if the thread is preempted.
- [Low] usleep_range() is called with an overly tight 1-microsecond delta, =
preventing timer slack batching.
--

--- Patch [6]: [PATCH v10 06/12] cxl: Add CXL Device Reset helper ---
commit 7129cc4ec4e3e4cb936b9c61b556eecc1cfb46fa
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Add CXL Device Reset helper

Add an internal CXL Device Reset helper for Type 2 functions that advertise
CXL Reset in the CXL Device DVSEC. The helper disables CXL.cache, performs
cache writeback, initiates reset, waits for completion, and re-enables
CXL.cache.

> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c

[ ... ]

> +static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
> +{
> +	unsigned long deadline;
> +	u16 status2;
> +	int rc;
> +
> +	rc =3D cxl_reset_set_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CACHE_WBI);
> +	if (rc)
> +		return rc;
> +
> +	deadline =3D jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
> +	do {
> +		usleep_range(CXL_CACHE_WBI_POLL_US, CXL_CACHE_WBI_POLL_US + 1);

[Severity: Low]
This isn't a bug, but does this 1-microsecond delta defeat the high-resolut=
ion
timer subsystem's ability to coalesce timer wakeups?

Could we use a wider range here to allow timer slack batching and reduce CPU
overhead?

> +
> +		rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		if (status2 !=3D U16_MAX && (status2 & PCI_DVSEC_CXL_CACHE_INV))
> +			return 0;
> +	} while (time_before(jiffies, deadline));
> +
> +	return -ETIMEDOUT;
> +}

[Severity: Medium]
Is this loop missing a final state check upon timeout?

If the thread is preempted or experiences a scheduling delay immediately
after reading the hardware status but before evaluating time_before(), and =
the
delay pushes jiffies past the deadline, the loop will exit and return
-ETIMEDOUT.

Could this return a false timeout if the hardware actually completed the
operation during that scheduling delay? Unlike cxl_reset_wait_done(), which
correctly handles this with a final check, this loop appears vulnerable.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804192958.1823=
952-1-smadhavan@nvidia.com?part=3D6
