Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116562;
	b=Tt6QpBn4X4rPJovsmHHF2qa76L1tCrwC5Guj0/Q7WJFM2qPF8rCmKssdizsOZzAzGwer
	 1d2/uNNkd1ViqKBF4E0GW7WSzywnH4otOrWIA9eVEEayLb6ss2C7xmyXkq4tjRZ1HTcTN
	 wkWttKduLB41b7HwqZ5Q9sdZCUYmlz+aO/sgu4VnmxmVDpgPmEBamwcWfxSPiLDa+uixj
	 XUJlslZQu43ZyVuRDFow8/7cSWCXHnMW3TW6q14uPVCRdV8h76rPuV46ZvT3CdFW72Odo
	 HlxCjCJa6lLquFujHWZCvC2wmLAfZ3pf3T8t8Jyxg1gkMGoVPvbOHzljIXE5ZlaME3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116562;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IhPMPS5EqGdBYMj40lLBBZlVlewyKsbsf65fOKnnTIA=;
	b=u+nTkkmHqPoja1HxI3IdST68Jyd6XoeIHWNlOnWxQfQeuHM3gmm3l6ap59fmJ+xmG6Au
	 5B7U3Thc6+zxXPSTA2XLqXQBgstP2Cf8Q92gwJxoJlzZmypLpHSjDsnJv2DRkGnzb7i5q
	 cpBQSS8o+cgd64RI/waPfuPWShGrSOUYBRpWdUD/1mB1SYKfBm2FtvY3DyyPVXu2dwdtC
	 yipT7Vnr93j/XI4Okk/53QKSP1wBb7E9EbYUaQprEE7+zc3oO56SoooZ1PFlHBNP1cd97
	 TAA6ROrWl02YhnL00JzCtmpKqudqKWsoDEpNl6UURkqW/GPW3t0iSjhXZkpHe9VYNvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgdUTizg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8F606A324;
	Thu, 19 Nov 2026 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NgdUTizg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB181F000C7;
	Thu, 19 Nov 2026 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116562;
	bh=IhPMPS5EqGdBYMj40lLBBZlVlewyKsbsf65fOKnnTIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NgdUTizgOUgfLbpb/TQAZvyPpBo/kZ2M212PrtBBlNqTiIpYN1MnvEWouvOZOm8sw
	 oeLxGWnxHCPNVt3xvOd1GMC1mTkjmk8sQef6QhdTrbHcTqeRBaA+a8UrefwtWNuoSD
	 IU9ymHRQVnVXVW7YgJ4NKyyxnY0m7ILAQmSvCQ9EvjJp5u+bzcqGWHiBYO7N24vIwn
	 R7Z9mP1Wi1ZzgxeV7AlCo6dotFae8aeqz3P2f2T+0tMrEbyFMyRn/3RFWtlxogDqX+
	 kdQxxA2/maNYjP7EL9RrExbJXpSb0r+rDZxfHFXV1z0v1VWsX3thXi3d3wyxrUDLmj
	 E+vIL/fJrLPXw==
Message-ID: <sashiko-outbox-223887@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/31] wifi: mac80211_hwsim: lock device for manual
 driver binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-1-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-1-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> The documented API contract for device_bind_driver() requires the device
> lock. mac80211_hwsim uses it for a newly created class device with no bus,
> so no automatic driver-core path can bind the device concurrently and the
> missing lock was safe.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D1

