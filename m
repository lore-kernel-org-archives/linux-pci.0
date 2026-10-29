Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292314;
	b=k9PN6jlSv2eyiHDIx5jcSeT61Dv0TIRPXD9JrceJLIMF8Q0TmOKov5cQvdN507T6mb8t
	 L+iDXjN3BZYKfW1E+iPX+JQn65Xddmmfw7MlQh7Q8jYwt12NqRDo53c13VzBVf0G7GSXm
	 s3dR2in3glVWNYMXIdKQVm4erp+JVyCmDwPMmG+3wteoJ0WELLDvpPudBf4Zq6Ukrka+P
	 lNyFXCZpnZduJNIoa7YAcabItDCYKHGmdtpCq2XPms7UbTFtvxplTHfSshy0he4nsj0uA
	 adgqarL+nYtWik725eNo9SoCjeIeXmwrg8/PcBb+AdpXnsVvLX/lURq39sg1KXH0uiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292314;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8FjjOsXf5z9Tt1Kqhs0sKNFOSjmAhcAFmnSn8YWvTIY=;
	b=mXFOIoDCgiusEISEIMQOMq6SbsGXiXbC1qKVjCvgtJ03/ntG73yqV9oSuOAN4xZ6jjqI
	 joNrXjSA+Oa1+ImmVvzvDj6wTQacJH5QvmDiah2sXHQqe7NudRtVrDLVAY7aBDHYuXP/x
	 5kMKcbZi5gpscFiduUhLDoZylP+gUH8+RfbjGk+agPbPx987fKD4T4Jna9vZSNDw5YlnN
	 SpK3AMtgPs+nstQrlmd6rySIFjoFMlQJbg4NPE2QvvNODMcKvstYmaHAoGE1WYRj3vmBH
	 6sA9KnGM2eg2JEo/edoeHJYma486EmpAmNONM0klkRmyUf0rto/DNxWNkdtKgQJRVGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpHLH41i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA383606A324
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpHLH41i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272D91F01816;
	Thu, 29 Oct 2026 16:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292313;
	bh=8FjjOsXf5z9Tt1Kqhs0sKNFOSjmAhcAFmnSn8YWvTIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PpHLH41ina4lNLrm4ETuYucC0WXkVH4uC9nuQS04476jBt7Mj4dhgDtRtgf9e0XE0
	 63Dqj37GDuZ6lDM+xxTQbxSSk/iqaFko+IJVnrldstyMcsq16BrJVSiBs8hobUJ26A
	 sZAh4CO9vCPQov38McNDe8L+SYSgvw5yXoxGd/ZAWA552KlPFxWgNjW3J/Fbc6ycrC
	 Vm8ZeAO+3ZueeLJBsZ0kKqUwmI7tf9MQ/o12elwvwObBzvmw0eE6QtGk+fMtpOg1PK
	 dUMwGPd4KbEa0GWYIZm6PI4neYHPv77cDfWGJmAna5Rx4GB1qpxjaNbPjZ/jx7PIdd
	 iXUTZeNteVvEg==
Message-ID: <sashiko-outbox-189672@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/8] ath11k: add PCIe link recovery retry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029163713.1366077-5-jtornosm@redhat.com>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
 <20261029163713.1366077-5-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:45:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> When ath11k devices are passed through to VMs via PCIe passthrough,
> the PCIe link may not stabilize immediately after global reset due to
> virtualization layer timing variations. This causes MHI initialization
> to fail with "BHI offset: 0xffffffff is out of range" errors because
> the device is read before it's ready.
>=20
> Currently, ath11k_pci_soc_global_reset() just warns if the link is
> down but continues anyway, leading to inevitable MHI failures.
>=20
> This patch adds:
> 1. A retry loop (up to 5000ms) to wait for the PCIe link to recover
>    after global reset (similar to the existing ath12k LTSSM retry logic)
> 2. Proper error propagation to prevent continuing with a dead link
>=20
> This is especially important for VM environments where timing can vary
> significantly from bare metal.
>=20
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029163713.1366=
077-1-jtornosm@redhat.com?part=3D4

