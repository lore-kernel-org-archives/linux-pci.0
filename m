Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235874;
	b=Xeo2FTGVg02lzcT0SQaL4baCaFN1bmrYfdikP73x6q2XH93KHLYgzXxVS2xuoh0DGpro
	 EVcIdkLZA3LsVT6YZu9C0VsVCyL+U//GWKgrTHFcvL7y6K+R7sTPzy0sAJRNpuGzPxdL0
	 sGFSWaz/VBPk+woVJ9WGznpI2WS6QaCRwyds8byCTc8EGPiR9YUN4zb7kl+62hGaXVefX
	 C7JKRjTz8K8SARzwqgDO3G292JfcAziYU4L70Ya+aD0QKDdAXtO7A9SStXrkMh6e+6ZnD
	 VDCMwTg2YByl+KWSuKWIeNJEVou2AQzsHzfVtFbTEekxGRenV3NUWPDe0cI04KFQZcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235874;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CF6hz4+p3vM6yDu43p4mjQXxPZ7OW2EHOTV7Ni92pXQ=;
	b=sBf6hLD2K2/+X0wZ+/FBmFLptmgAon+lZzZvmGnr6s75QYUDgM53/KaPPXJYv8cTTV6u
	 gU45aQuSUKeReHM1gU5vWJPN7fzssE9qbn0MDP+k/OBs+bYlQz0FaGq68DeYRVz+zKF3b
	 5sHkqVVaVoioHo6IJvAb2fcMArZ9EqthasKWYMcFm0zwB2EcCflY0eyxIlLrzCg8klq1v
	 79MA6YGFpCvzDJTNAKuVxCtmjHkSKh7BO+ax1BwMWF2zD80VkCzk96P83jSkQsB0AAibf
	 6Zg9lSP5pR3zjZfL6yIpkBdS6sSalNPrPQmrT6vuQqitL8i+2cOt0V/eYXgTfGU1JAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TEVw9H/Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE3606A323
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEVw9H/Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F651F008A3;
	Mon,  9 Nov 2026 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235874;
	bh=CF6hz4+p3vM6yDu43p4mjQXxPZ7OW2EHOTV7Ni92pXQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TEVw9H/YOQ6Ax0s7vTZRjH4xSmkmcP8dMd2IH1IvJJycj3lkflI0Z9CWD13VPKvKT
	 Jo0VLLLrhfyZOP3IGa4nxCXiVJZi3lD5mvSqr8cRKn7IFFslZYgkT2o1Dz30fXl2Eu
	 8CO0cXVio5qu1Ve9Ycq8x0V8Pto14Qh2wKhDcfsUa45RAd5Yuz9xtqi1ianJCiaN4a
	 qeXpIfAn8jjw5rdDTmm8teyI7YjhDGqyrxeMPXyeLaQXN4AC8wvg3L8PeqsdUdenyQ
	 n7+GL0f/tupLUt+A/PFVU4al0qvKxr37qqiXF/Cfz14W4GcTq5vRAYsqqtQA8OBIvq
	 6+qL+l0hmHLPQ==
Message-ID: <sashiko-outbox-205132@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: Fix start of available space for the next
 bridge during distribution
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109144553.2516-3-ilpo.jarvinen@linux.intel.com>
References: <20261109144553.2516-1-ilpo.jarvinen@linux.intel.com>
 <20261109144553.2516-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:51:13 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> After distributing space to a bridge,
> pci_bus_distribute_available_resources() advances available[i].start with
> "+=3D end + 1". As .start and .end are addresses, not a base and a size,
> this adds start a second time. The space left for the following bridges
> then starts at a bogus address, which skews their alignment calculations.
>=20
> Set start to just past the space given to the previous bridge.
>=20
> Fixes: 08f0a15ee8ad ("PCI: Align extra resources for hotplug bridges prop=
erly")
> Reported-by: Claude:claude-opus-5-5 <noreply@anthropic.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109144553.2516=
-1-ilpo.jarvinen@linux.intel.com?part=3D2

