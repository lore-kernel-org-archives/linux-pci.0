Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC843D6CC1
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 02:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792030573; cv=none; b=lZVGljLtkZfzYi8UszpJUkezmcjNoehsRy4E9N7lsKt1F474+TbktLqsDI3HaTRP8TI/ydhdh982YBsAo40m5AgKiQoYTwfJbuV3/niN0/RWbvYhRWy0eVpPUTsniObu+9eUo6zzEJ414hsS9YkrtdgioHiXNhoE0/ScQGSh8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792030573; c=relaxed/simple;
	bh=aJExio4p6DDqxVXPaE9BjS1fC8NXqMQkn8KrMhq3ZH4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DZdKATaRGX5VvtfSpG5PBZJak9trzdQW4+qB3RWwuCtZmdBaCOU8sIRuXAjYWc6Ndg+TYGxTWhGz0FtNQwyqVxuT1MzhersaX/NQ90ga+ItqBaFkvvPo5wl3xFlboQ91gcYUeVBVLLpUwMFL1/yP+1NI4bF79CFuLD8e/S2SJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAZ6oTHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAZ6oTHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1C11F000C4;
	Thu, 15 Oct 2026 02:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792030571;
	bh=aJExio4p6DDqxVXPaE9BjS1fC8NXqMQkn8KrMhq3ZH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mAZ6oTHtaRBeTCV1zWKK8tSWqDGBS+O4D46mxj10qhiNQTFc5Q/MxbXeN2fslbkQJ
	 BjssEhMmPWeh7QS6OBM7DnUsUYPDe7kYpw8Vaf2YPRJi4EBQPY2qfXbNoTdSW077Rg
	 pU/86uRY1/+VnMwFleQmpZZAR/DldYgSPLpeThZBjs6B5aVYh1v7r+rwCvykoXyCMu
	 AB4twyxDmBEs1DqFcuYCx/LF2JBFvCtBKLsSuJwDgaf0W0Q2t+fhZH4O7KdmNj+D7W
	 YFag1IGYjuBllfjtT08hlctqzIU2zNWiq4yWRJS/Ba5hVF83utD0qkIV4pWLHzrx8C
	 Z6Wf1Zu7wbpPg==
Message-ID: <sashiko-outbox-172136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI/PM: Restore BARs after powering up during
 enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keng-Yu Lin" <keng-yu.lin@hpe.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015020811.1132314-1-keng-yu.lin@hpe.com>
References: <20261015020811.1132314-1-keng-yu.lin@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 02:16:10 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
> initializing") added pci_pm_power_up_and_verify_state() to pci_pm_init().
> The helper ignores pci_power_up()'s return value indicating that BARs
> need restoring. Its resume callers restore saved configuration
> afterwards; pci_pm_init() does not.
>=20
> D3hot-to-D0 may reset a device and lose its BARs (PCI PM 1.2, sec 5.4.1).
> After enumeration powers it up, pci_enable_device() reads D0 and skips
> the full power-up path. Previously, a device still in D3hot at enable
> time took that path, including BAR restoration.
>=20
> On AMD Venice SP7, two AMD xHCI controllers [1022:17d2] are in runtime
> D3hot with No_Soft_Reset clear before kdump. Diagnostic reads on
> v7.3-rc6-37 show the following for 0000:01:00.4 in the crash kernel:
>=20
> [ ... ]
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializi=
ng")
> Link: https://lore.kernel.org/r/CAJZ5v0ie2AvCbdv8-zkpYzHLcTwUPUj+=3DWWOQj=
DAPmSepSAQPg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Keng-Yu Lin <keng-yu.lin@hpe.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015020811.1132=
314-1-keng-yu.lin@hpe.com?part=3D1

