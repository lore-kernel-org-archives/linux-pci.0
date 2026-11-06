Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954105;
	b=nwzW4g9j9hMvHIa53v+X0ryIfLrNgjqHa54e00LTQRtYN3RL3zDYm6aplY4j4MfwHu6a
	 Btj5G7zVU1pA9U48lc/lvI5Fp14WLHBie3AT4ROuglaYSLvmzT+NL7qhBHi24tQCfmIrH
	 BeeyYDnIGVCHEXJ9ASP7LL3icaVqFxUBH/gWt/LlwYkkF73usf3UyBVq0gHPotgDO6vwd
	 K0h/mK9BXlORiuWrkiiJSAHwQfzIKyKjl43AQVvKhNOznPjVOgUoJmD0NfNsLlOkh2Z85
	 rYC/ZbCoMIQyrPCXW3is3SXznDODG+pNMfVXC/3UbxJ1Kiz9rykB+njqcyz4TwIzAFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954105;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EViaPbfeiFT+cakbLSjG3Gy1kD8eEwriPljcaWhz8WM=;
	b=FxJ48iEdlSAQ0yGx2zAxxK4pSgm8bQ7vQAeAzqUxRFxtwhUWvN8ebNxoENQqM51BYxqw
	 GymzhueFHvPjKtIOmFwp3wO90xwYWvyXMqJ+NdDfiYRKnMpn84pRc13dKbzufov527g0X
	 BbrFNBOD+vQHdTEcXgtkX24o9fsMXeCyVrpK8TOWCP1ItKRoFY+5zuTwXX4W6HKA+QSG/
	 uZh7jQ6ehiwEV6PkPwyFtU1EOyNQxZ9cUII3P0EMvEO5F/rhysGyAdSn/RDOg96kvWzd2
	 UakiQHF1NtdPwJQzeW+tt5t9zCxA2sL6nUYuPMrLW0TErVply5KsWXKYyDHDZ2ZFN4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2Jn4X+U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368E606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2Jn4X+U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991F51F0089F;
	Fri,  6 Nov 2026 08:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793954104;
	bh=EViaPbfeiFT+cakbLSjG3Gy1kD8eEwriPljcaWhz8WM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2Jn4X+UnlFW2vXFTOKkAA7nMlErrk2F18rSxS8EyV4feKPMRhVizOCEsMfuc1SYt
	 XbRvqOJslEuPXxkdl6HJI5kyVWtXQQ/kodSBCm5SJlqg1G7BfEl9ZHwQ5pHpJYl5Ax
	 nF6fQQrHQIOZltbiAQxXsjHN6Xh8LLG2muJ6nYvMz11TJcj3a/Ly0ULPqKMSEZpVZS
	 N2ppTBZMebFYU8ZDHoLbDii/p0jHn5ILMQewA4uBKr+mMQlGWiwOg7PSYwNRPcodgg
	 tDDykEkQ9whj7j72Hivw2UlgEdE8KAgLstEgfXew5VNFym5oUuKa3CxqJm5n+StwWl
	 qt0f5G0WwLrog==
Message-ID: <sashiko-outbox-201069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/DPC: Increase recovery timeout to 60 seconds
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Wml5b3UgV2FuZyAoTGVub3ZvKQ==?= <ziyou.dev@foxmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <tencent_0EA784F33CA15095806009C26E9DD624B809@qq.com>
References: <tencent_0EA784F33CA15095806009C26E9DD624B809@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 08:35:04 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] PCI/DPC: undeclared PCIE_RESET_READY_POLL_MS in
  pci_dpc_recovered()
--

commit 9107bdc3c03dade9f834df49cdbc6c47d0a15a44
Author: Ziyou Wang (Lenovo) <ziyou.dev@foxmail.com>

PCI/DPC: Increase recovery timeout to 60 seconds

This commit increases the DPC recovery wait timeout in pci_dpc_recovered()
from 4 seconds to PCIE_RESET_READY_POLL_MS (60 seconds).

> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b779bd1d861b..df1c469fa24cd 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -116,12 +116,13 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
>  		return false;
> =20
>  	/*
> -	 * Need a timeout in case DPC never completes due to failure of
> -	 * dpc_wait_rp_inactive().  The spec doesn't mandate a time limit,
> -	 * but reports indicate that DPC completes within 4 seconds.
> +	 * Wait for DPC recovery completion.  Use PCIE_RESET_READY_POLL_MS
> +	 * (60s) to match pci_dev_wait() timeout.  Some devices need >5 seconds
> +	 * to recover after DPC containment.  The 4 second timeout is too short.
>  	 */
> -	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
> -			   msecs_to_jiffies(4000));
> +	wait_event_timeout(dpc_completed_waitqueue,
> +			   dpc_completed(pdev),
> +			   msecs_to_jiffies(PCIE_RESET_READY_POLL_MS));

[Severity: High]
Does this fail to build when CONFIG_PCIE_DPC and CONFIG_HOTPLUG_PCI_PCIE
are enabled?  PCIE_RESET_READY_POLL_MS is defined locally in
drivers/pci/pci.c rather than in drivers/pci/pci.h, so it is undeclared in
drivers/pci/pcie/dpc.c.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_0EA784F33CA=
15095806009C26E9DD624B809@qq.com?part=3D1
