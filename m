Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3B35DA56;
	Thu,  2 Jul 2026 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997234; cv=none; b=lQugfTMNSt8simJHTM0yIRa6Fd6RKHRZouD3San0pzxsyze1yKSvtRsHGU6skunavHgmTGbpQiACmLnWUxt2kexkZ+ipfozKOqPgI4XCdWsE+7Av3/OKkCj1U9LnejP8xzqEbAcDLXxpgrOy9+EAA4hRquN0gTxmzKBxTImq/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997234; c=relaxed/simple;
	bh=xcxf4inGlKGyx8fukxoRWW0aE+camaZGlRFJOG/n6RA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fv1kC8tiEb+EMYCQFyrOgsUbLiCXEShx6AVYcSWkgezBQfzOJV7VLEmsA2fxyR+2VPvBzg6DNKN1qAU3w8zdqNxK7dZ14+7wwBNB5zte+hfjCMPqnVj1o+fGIFppziOKnEv1VUDD+0iQhqCDkBg1xyIxscaGPW4vR1VsORg3x1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfsFAi9b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfsFAi9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E471F000E9;
	Thu,  2 Jul 2026 13:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782997233;
	bh=luDUAdAuAB8hEwbA6NL27y7M5E4GwQ//ABobu35DC5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HfsFAi9bcUUj5p+QhVoI2Q7ptlKxlvxVbVlfhbKQ3pIgHDY8sBMMX8B8v0n6l69iS
	 dQXfLhisILuBd38/VFJGSKahmA6Ksjof+R5S1tkvTZQnJXxA6kVZcHHig7qdzdzEV9
	 t4hccI5qZW1CDkYcJY9ydkrxoCiIgNlb/mPiuY9s+lph/wshhYP9gnUPCH3rFAmFnr
	 rvILJ3SOg9Yv++iTjvpLoVNFIq3n7j0Vi+RWw0KZB0jah+xXpYpoO6QR58y8YsUFYP
	 qYU0VJMKdFfkacHem09CMpIJsK8icwwLI7+3Ip0LDJcnbkbM/ki8K0ahj8exYTvqMe
	 l5Bqhk6/htpmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 17/18] vfio/pci: Reset hardware TPH state on device
 enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260702124224.57168-18-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-18-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 13:00:33 +0000
Message-Id: <20260702130033.86E471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> VFIO allows user space to enable and modify PCI TPH state, but device
> reset only clears hardware TPH registers, while the software TPH state
> maintained in pci/tph.c remains stale.
>=20
> Fix the stale state leakage by explicitly disabling TPH in core enable
> and disable paths:
> - In vfio_pci_core_enable(), clear leftover TPH state from previous
>   user sessions before device initialization.
> - In vfio_pci_core_disable(), revert any user-modified TPH state
>   when releasing the device.
>=20
> This ensures consistent TPH hardware and software state for each
> user session and avoids residual state contamination.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D17

