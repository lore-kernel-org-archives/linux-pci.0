Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA626D4E5
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779744920; cv=none; b=IybwEAz7GKispdh9qD2zbiuebVLzwy+fcTi8mhi4YSMiumk5MJgegGXSFC7ZmrgnQgYQMkmXjFwNzdGgvhLtDzc/dOJ99HnhCCMdvStrq4llZvDP/0yj+PLfF+HwtVon4sXuMvQvYWTUkXaAW8ztiUKbl0uw6XP4go5cY4QnrUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779744920; c=relaxed/simple;
	bh=A+V2NgnVGCQ8wAJQOUQ1U4hdhg7gAcyXwW+m6Q9bghg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h0RwrSX+yxzffWcOh81oqtD/3v+njHg0xl0gHssJF/gFaFtBnJNtcYDk4XboweRHMZ9qIR9kpJ4qx7oxrvo0jEUyghJJ6ojpjsCTDoSkhrH4AQG1jSmlSIuMx3r/UEIuX4zgLMWWq80vSZbtrH2mTFprR1mAJUFkmox9g2Owh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OX6Ae/Xk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OX6Ae/Xk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7777D1F000E9;
	Mon, 25 May 2026 21:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779744918;
	bh=gmJl0LDf2SOG0wYNo1sKZnhstzKfPahZOJVLkEF8IrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OX6Ae/Xkh5cX+u5deCPH86h7JfvKV/ps04Lo2mvHgrx4SS7u7qWYTKKqJlfmsteM4
	 PPNlxDbRe2NkhyH+/OHC2k2Q0ZBC3zuEuK4Zb9V9R00P9QAUyfzVwFq/clojcc0PNb
	 Qqzrhw3ajPL+/IQZXMvXt2VQB7jrxNKihpiCC7eE2JjZ8U3FjsNp8Y4aJebnnaYsDR
	 tKl2Ml6065Y5donX7quQ/hLk83LBPfNMW7YfObMPKNSR+Q3D3TyQ+R9nG3Cj0xlU08
	 uarkufh+jJ6BYckZJeUTNHc5vohMsyhH/avIEcZdc+b1Y+o0DbZFCVW6OPHCFCJpJa
	 bbrOfWALqsfVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] iommu/amd: Fail probe on ATS configuration
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260525184347.4059549-6-praan@google.com>
References: <20260525184347.4059549-6-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 21:35:18 +0000
Message-Id: <20260525213518.7777D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The error path for pci_prepare_ats() in amd_iommu_probe_device=
() fails to revert previously initialized IOMMU state, leading to a potenti=
al Use-After-Free.
- [High] Failing the IOMMU device probe when pci_prepare_ats() fails breaks=
 backward compatibility for devices that could function perfectly without A=
TS.

Pre-existing issues:
- [Critical] Pre-existing missing cleanup on error path when IOMMU page tab=
les are disabled causes a Use-After-Free.
--

commit c40e9d6d303549c37f626ed11947fa01974222f8
Author: Pranjal Shrivastava <praan@google.com>

iommu/amd: Fail probe on ATS configuration failure

Update the AMD IOMMU driver to handle ATS configuration and enablement
more strictly. Specifically, update the device probe to fail if
pci_prepare_ats() returns an error. This ensures that any ATS-capable
master reaching the attach phase is guaranteed to have a valid config.

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 84cad43dc188c..1dddb08e7b224 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
[ ... ]
> @@ -2502,8 +2508,17 @@ static struct iommu_device *amd_iommu_probe_device=
(struct device *dev)
>  	else
>  		dev_data->max_irqs =3D MAX_IRQS_PER_TABLE_512;
> =20
> -	if (dev_is_pci(dev))
> -		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
> +	if (dev_is_pci(dev)) {
> +		struct pci_dev *pdev =3D to_pci_dev(dev);
> +
> +		if (pci_ats_supported(pdev)) {
> +			ret =3D pci_prepare_ats(pdev, PAGE_SHIFT);
> +			if (ret) {
> +				iommu_dev =3D ERR_PTR(ret);
> +				goto out_err;

[Severity: High]
Since ATS is an optional performance optimization, does failing the IOMMU
probe when pci_prepare_ats() fails break backward compatibility?

This completely prevents devices with buggy ATS capabilities (or VF/PF STU
mismatches) from attaching to the IOMMU.

Could this disable DMA translation entirely for hardware that would otherwi=
se
work correctly without ATS?

[Severity: Critical]
If pci_prepare_ats() fails, we return ERR_PTR(ret) without calling
iommu_ignore_device(). Could this lead to a Use-After-Free regression?

Since iommu_init_device() has already globally linked dev_data and populated
the hardware dev_table and rlookup_table with dev_data->dev pointing to the
PCI device struct, the IOMMU core receives an error and considers the device
unbound. It will not invoke release_device() upon removal.

When the physical device is later removed and freed by the PCI subsystem,
dev_data->dev becomes a dangling pointer.

If a spurious IOMMU fault or event occurs for that device ID, the interrupt
handler (e.g., amd_iommu_int_thread) will retrieve dev_data and dereference
the freed pointer (e.g., via dev_name(dev_data->dev) in dump_dte_entry()),
causing a Use-After-Free regression and system crash.

> +			}
> +		}
> +	}
> =20
>  out_err:

[Severity: Critical]
This is a pre-existing issue, but does the same Use-After-Free regression
occur when amd_iommu_pgtable =3D=3D PD_MODE_NONE evaluates to true?

Similar to the newly introduced ATS error path, it jumps to out_err and
returns ERR_PTR(-ENODEV) without calling iommu_ignore_device().

This leaves dev_data globally linked with a populated hardware dev_table and
rlookup_table containing a dangling dev_data->dev pointer. Upon device
removal and a subsequent spurious IOMMU event, could this cause a
Use-After-Free regression for the exact same reasons?

>  	return iommu_dev;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525184347.4059=
549-1-praan@google.com?part=3D5
