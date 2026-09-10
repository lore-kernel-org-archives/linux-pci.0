Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF93C3F7C;
	Thu, 10 Sep 2026 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024848; cv=none; b=hYTk7G9s9di7dvaboq57vnLZfRX4pjSpIxeTFVaDNLeesRI2QAyRg7UeJM80joYmwQjyiCm8ViC3eYbAzH8B9g5knPGSs8IAQ14/F1KQ1BTRGWVuitSGvc1f2DeZxUL29I+zP824lI4We8JU5SxoVe7Xd1epnrnqWY9O+Id7sIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024848; c=relaxed/simple;
	bh=9pb6lvxSE4716Mh3bYWSNhob+reX+AQ4b92rjVDH1xA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LdxMrPZxN2zLivnop4AxofXZNmKbn9dd+Nn8UL2tTnixGcSKO0EOmP9tKIdhY3jQ7agJt+O/tFuIc8ln5ShwwQnSm/w8h8W99j/S2dLgUJISVXeArLBRczrjahArwMReFIuW4M152SG4OTujmCS95AH00471nC3id0+EHj5lgdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtkB/uCb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtkB/uCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C621F00893;
	Thu, 10 Sep 2026 07:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024847;
	bh=AYaoo468GvdHguY+ngEYS5l2A5zCVheJqeq3Zj7vZtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AtkB/uCbyRilSYg/HZKtacnbJUoB8cA0CIgUTg5ZUnRk/PbSUgpatPK9AzjdUW7W2
	 aYlGkYkAAggOIoEf/1KkjORfYkfjMCpewdz/wq1+V+yopnHEF3BITWQ6OsqyxEbbRY
	 dS4VlXOqBVwd92nX4RbyIAdXyZVy2GOy22YriUXT2Fn/ZENF1ALF6ssibMfVUu7rNB
	 G/7ra/l1QWLnyD+WD+18Uu+2KAG7ry6/pDSSoN+XDCiwfPEz1tkcpV4MgYtTpgaQFj
	 PGIxmKT+IAxUgglommO4tvj7NqobHEQ9CQQIgaDIslQ+KMtjxqE3RkbWBotz9VnCxV
	 S/vtoN4IEhWFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 06/12] cxl: Add CXL Device Reset helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260910070808.1444264-7-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:20:46 +0000
Message-Id: <20260910072046.85C621F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The PCI_DVSEC_CXL_RST_MEM_CLR_EN bit is not cleared on error paths=
, causing subsequent resets to inadvertently perform a full Memory Clear.
- [Medium] Missing final status check after timeout in cache WBI polling ca=
n cause a false timeout.
--

commit e65504bb1432889a2f2835801327341b00b21dfc
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Add CXL Device Reset helper

Add an internal CXL Device Reset helper for Type 2 functions that
advertise CXL Reset and CXL Reset Memory Clear in the CXL Device DVSEC.
The helper disables CXL.cache, performs cache writeback when supported,
initiates reset with Memory Clear enabled, waits for completion, and
re-enables CXL.cache on exit.

> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 6d9f8fe14b16e..9c1aa0800521b 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c

[ ... ]

> +#define CXL_RESET_CTRL2_CMD_MASK \
> +	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
> +
> +static int cxl_reset_read_ctrl2(struct pci_dev *pdev, int dvsec, u16 *ct=
rl2)
> +{
> +	int rc;
> +
> +	rc =3D pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	*ctrl2 &=3D ~CXL_RESET_CTRL2_CMD_MASK;

[Severity: High]
Does this mask inadvertently exclude the memory clear enable bit, preservin=
g it
on error paths?

If cxl_reset_initiate() sets PCI_DVSEC_CXL_RST_MEM_CLR_EN and the reset
subsequently fails, the error path calls cxl_reset_enable_cache(). That cal=
ls
cxl_reset_modify_ctrl2(), which relies on cxl_reset_read_ctrl2() to fetch t=
he
current register state.

Because CXL_RESET_CTRL2_CMD_MASK does not include PCI_DVSEC_CXL_RST_MEM_CLR=
_EN,
the stale bit is read, preserved, and written back. Could this cause subseq=
uent
resets to inadvertently perform a full Memory Clear?

[ ... ]

> +static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
> +{
> +	unsigned long deadline;
> +	u16 status2;
> +	int rc;
> +
> +	rc =3D cxl_reset_modify_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
> +	if (rc)
> +		return rc;
> +
> +	deadline =3D jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
> +	do {
> +		usleep_range(CXL_CACHE_WBI_POLL_US, CXL_CACHE_WBI_POLL_US + 1);
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

[Severity: Medium]
Does this loop miss a final status check after the timeout expires?

If the thread is preempted or delayed between the register read and the time
check, time_before(jiffies, deadline) can fail even if the cache invalidati=
on
succeeded just as the timeout expired.

Standard kernel polling macros (like readx_poll_timeout) avoid false timeou=
ts
by evaluating the status one final time after the timeout expires.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070808.1444=
264-1-smadhavan@nvidia.com?part=3D6
