Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572C7489FA4
	for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2026 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332376; cv=none; b=NkI3NLRBYPF9IpQDMcyGKVKgIc5fYUsh5+Rl4omF8+0c4cmJSSntTfOYAqtbbFBs5lI9nNRA1VHJ5SZU4+2EGk6NLttmCIXw1kXYrlXAhXX7wStmN/7CcNMGE5VfgqC6uqPHz9exVvCQIBQwPVrL/rdNQOXOG55fayYV8vZV8fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332376; c=relaxed/simple;
	bh=pi01WMeKj5TR8aMT9RIjzOD3Js1Q+GZIKFc5Se/5SQM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bZrSU5M6Cg9cvNV8RPFgA58CUztfNkefrNiS7zZ8PjeIA1zu727wXlBCBL9vtRWcSN/QifP2Rst4hQgyt5G1kQIy77ZBi6OBkUK1UC3Aw+EVhOBtiryQ8tPVXFFLZVIfPsoJ+kk4Homdbv0W3E5jSPVykix0NXhcTD8psRVrx4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsIbE/8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsIbE/8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC98B1F000FF;
	Fri, 25 Sep 2026 10:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790332375;
	bh=x5hfSYHTOPrPqB8SLSy8l4jGXiik8Jq23dU/L6k2TwE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lsIbE/8lcAeS5Eulk7c0rhU1d4rbTbFVHS+SpEXAOgBT3xv7AuO/q8kr/Rgj5mAsb
	 /TUQIEmv7YV+adXVMZDLBMcZH/AxgweMVvghfDdN96WPN3BvYegwlAB/iM3dVjwFII
	 XGfk4BuWpckBwFt6CwoHSOJya/p10CFKApyMAOgJ0KFJcFXPPneLPwzQc0VwDiQ4wk
	 J19gIqQY97tHFlcOyO01GVF9eKTXgLEseEqziKhwfdMlssZWlGrUTvQ2k5nSky1jTh
	 T64krbXZPhEWLJqKAiwJJazKXpfAAP/Za274sK2foIFG+OsUaTPQl8ts86aEm8KqM5
	 Yyb81Fln4Jn/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Clear runtime PM error after
 pm_runtime_resume_and_get() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mrinmay Sarkar" <mrinmay.sarkar@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260925-pcie-ep-rpm-fix-v1-1-855d56cce43b@oss.qualcomm.com>
References: <20260925-pcie-ep-rpm-fix-v1-1-855d56cce43b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 10:32:54 +0000
Message-Id: <20260925103254.EC98B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pm: ineffective pm_runtime_set_suspended() due to false runtime_=
error assumption
--

commit 3d108ba33ceb10b064e31ea4a0bb76a46a7b974e
Author: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>

PCI: qcom-ep: Clear runtime PM error after pm_runtime_resume_and_get() fails

This patch attempts to fix a runtime PM recovery issue in the Qualcomm PCIe
endpoint driver. It adds a call to pm_runtime_set_suspended() on the error
path of pm_runtime_resume_and_get() in qcom_pcie_perst_deassert() to reset
the runtime PM state and allow future resume attempts.

> pm_runtime_resume_and_get() sets dev->power.runtime_error when a runtime
> resume fails. As a result, subsequent runtime PM resume requests fail
> immediately until the error state is cleared.

Is this description accurate?

Looking at the PM core in drivers/base/power/runtime.c, rpm_resume() does n=
ot
set dev->power.runtime_error upon failure. Instead, it merely updates
runtime_status to RPM_SUSPENDED. It appears only rpm_suspend() sets
runtime_error when a suspend operation fails.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/cont=
roller/dwc/pcie-qcom-ep.c
> index 8364696a1b980..5a3dfea702cee 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -404,6 +404,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *p=
ci)
>  	ret =3D pm_runtime_resume_and_get(dev);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to enable device: %d\n", ret);
> +		pm_runtime_set_suspended(dev);

[Severity: Medium]
Will this call to pm_runtime_set_suspended() actually be a silent no-op?

pm_runtime_set_suspended() routes to __pm_runtime_set_status(), which
contains an early check:

    if (dev->power.runtime_error || dev->power.disable_depth)
        dev->power.disable_depth++;
    else
        error =3D -EAGAIN;
    ...
    if (error)
        return error;

Because runtime_error remains 0 (as the resume failure didn't set it) and
disable_depth is 0 (because runtime PM is enabled), the function returns
-EAGAIN and aborts immediately without clearing any state. Does this leave =
the
underlying reason for repeated resume failures unfixed?

>  		return ret;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-pcie-ep-rp=
m-fix-v1-1-855d56cce43b@oss.qualcomm.com?part=3D1
