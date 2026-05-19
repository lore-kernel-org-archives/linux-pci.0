Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA623F58DE
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182645; cv=none; b=T6DUbOikyDlqYVc7KKCFGugth9GlZXCV/onuPAFScxoB/XS3QDZQu8gio4bC3YuukMUcS84aZePT9RPhcwd93y4fjvK9HFPP4JCNjwRBd/185o4BEjOoYZ77xYSi7AYBtELeS1uVi8OisA6gnVi78EdINsPFiffVI2M1n3rprjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182645; c=relaxed/simple;
	bh=44NaHB+K2HEqAZN/Ba6vSteuP0y9JK+Gd24LxbU6E74=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CIMRSLkpBYBXM1xJ2cg/WeCevytaSpUv+3EMjtBjl0qki+etsofO46jsuu0TaHafSClXRZImzVwXgLN3VaSXwCAKE9r3Kct6I89OeylEMCW3Tlmd9CXipAhmENoG7BPnlgrH/ajNAEnaQOOy0qXhWcAoPcDpDd8rVOI/edkukR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovn0Nmlz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovn0Nmlz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194B7C2BCC6;
	Tue, 19 May 2026 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779182645;
	bh=44NaHB+K2HEqAZN/Ba6vSteuP0y9JK+Gd24LxbU6E74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ovn0NmlzqQP+Ij1/iDlul4IFwHL+DLixT+oVw6LmevKS3Ix6SQTrJMLNFlv8225dg
	 h9fh2DmSIawPM4lAonTV8ZiYTcvwH5WFLVPsltgAPlRew65rCCM+SIhlfm9OJBN+Tt
	 fUxgsQNym3faYYeqd2zNftDsQwATDOIi17CwF8ltoemRtWH58Oy///pQkHwXvUmrcn
	 +IXkcaIKAWQEAEmBpviF1t9n/4Y8vYZqasyoxx5d72AQuruf1MqoTZQlPWCV7K4kJy
	 gdUcg+edygtXoWX1OJVo1oap5LvshR8zSUB5qRb2BXH1rP/es3L4WcRHtL9bdI67Gb
	 +Th+gg+iDlRfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] nvme-pci: Use pci_suspend_retains_context() API
 during suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260519-l1ss-fix-v2-4-b2c3a4bdeb15@oss.qualcomm.com>
References: <20260519-l1ss-fix-v2-4-b2c3a4bdeb15@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 09:24:04 +0000
Message-Id: <20260519092405.194B7C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused header `<linux/suspend.h>` is left in `drivers/nvme/host/pci=
.c`.
--

commit 626756383798c29170f6f0069d54faf950cd1526
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

    nvme-pci: Use pci_suspend_retains_context() API during suspend

The patch replaces pm_suspend_via_firmware() with the newly introduced
pci_suspend_retains_context() API to check if the platform can retain
device context during suspend. This dictates whether the NVMe controller
should be fully shut down or kept in a low power mode.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index db5fc9bf66272..a6664983ce5da 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3915,6 +3915,7 @@ static int nvme_suspend(struct device *dev)
>  	 * use host managed nvme power settings for lowest idle power if
>  	 * possible. This should have quicker resume latency than a full device
>  	 * shutdown.  But if the firmware is involved after the suspend or the
> +	 * platform has any limitation in waking from low power states or the
>  	 * device does not support any non-default power states, shut down the
>  	 * device fully.
>  	 *
> @@ -3923,7 +3924,7 @@ static int nvme_suspend(struct device *dev)
>  	 * down, so as to allow the platform to achieve its minimum low-power
>  	 * state (which may not be possible if the link is up).
>  	 */
> -	if (pm_suspend_via_firmware() || !ctrl->npss ||
> +	if (!pci_suspend_retains_context(pdev) || !ctrl->npss ||

This isn't a bug, but since the final usage of pm_suspend_via_firmware()
was replaced here, should the linux/suspend.h include also be removed?

drivers/nvme/host/pci.c:
    ...
    #include <linux/pci.h>
    #include <linux/suspend.h>
    #include <linux/t10-pi.h>
    ...

Removing it might maintain clean dependencies and avoid unnecessary
compilation overhead.

>  	    !pcie_aspm_enabled(pdev) ||
>  	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
>  		return nvme_disable_prepare_reset(ndev, true);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-l1ss-fix-v=
2-0-b2c3a4bdeb15@oss.qualcomm.com?part=3D4
