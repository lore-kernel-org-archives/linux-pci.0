Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818953;
	b=laD/5eMk9syCRy47PwctNVDwuWXUerCh/qTN5A6ZxAwZI252DoEf5jmu+Ie/SPgpIa4A
	 UIDnaPTE9wr/H063RoNspl9Fzijvb0bZjkP88TLb8aoBvff3e4UwH25ztxlQTMdbHv2q5
	 J5kRVKt80FbiDZyt1Nd21hLiGy++DkvCidMuWTtTSOXPZcfjZX8pXOXc4PUQAFRMk+oWC
	 bxLUhyg3mamxtOruuWu/GJFMel92rgLNEtYy9DO6c4Bq/WPaEPwJ75hf35DY65Jpr2axn
	 SJBoh1lUQt2oLRaTIMYQki45GGrf05QIOD2cesWXGPfiYnq4FFqQCLzgUMv6fdJ02Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818953;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p++IXYZkvrNfXKDkqaJO4LvxaUP7pYCBY/oyLuBvDJw=;
	b=i20C75dNfoynx+QgQVNl+EsbmQjeW518O5hQbfbKCzzSXZHn9bZLk6goZXb26d7DWLqh
	 OMNoE33YLPBC59bV2PKYqL8KbVFczuEvukLsY0PG7ml4ekh0GDomHJ3rY8j7doDw5piLl
	 82j7DcguMuoyPOP3zc8pYHYF15iKWoh1LwAOwMTmt+2xDUOiq3ek8e0Oftsoq5zcDu2dE
	 bMcspWI53wlF4I//SZWNWwIH53FwWoIFuL30g6CbQoRfAS5z2WlKlt8DJfucihWVLbegN
	 zlNT641ySQwaets9KXeO4Hn/sLi6vzZPhg7s3sFK+JYryxKz1E1h9GnoaI0PdQFt6ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geceIYyP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF4A606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 19:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geceIYyP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BE01F000C1;
	Wed,  4 Nov 2026 19:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818952;
	bh=p++IXYZkvrNfXKDkqaJO4LvxaUP7pYCBY/oyLuBvDJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=geceIYyPqG6ECGvT/5lA58vG1tJal5O8Y1u6uZUZzxzYl83Xh66omXgwxH5Q1Sd/L
	 76NEVR00cE9O4I0J3N7Z8djQCHhLLHWtLcBR9SScJE1tGchTV5Zs5vva6+U0c9/0Tg
	 9k/3wbHS0CH6F/ALqiswAaTd3vaQ56EJ2jU4IkfliwEAGrmeLJxUYaHc4Pa/ji1hXV
	 40yKfAT8iO8ioq2NEbfpLqPkHglSpifZQEPzedjYCK4ZWgZMqi/z23oyv5X7+WD1sd
	 X7pQVP335G5k2rS0AO7Tq2YA92WjVHImTV/XRTt0v/Zs/0RQEO5c1JGyWNbnijWxSb
	 pQGG/VoEV+8jg==
Message-ID: <sashiko-outbox-197906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/10] PCI: dw-rockchip: Fix LTSSM set functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-1-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
 <20261104-rockchip-pcie-system-suspend-v7-1-6ae6875939a2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 19:02:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Before the Rockchip PCIe driver has been switched over to the
> FIELD_PREP_WM16 macro, PCIE_CLIENT_ENABLE_LTSSM and
> PCIE_CLIENT_DISABLE_LTSSM were setting bits with a mask of 0xc =3D 0b1100,
> which means BIT 2 and BIT 3. After the conversion it only sets bit 2,
> with bit 3 being handled by a separate define named
> PCIE_CLIENT_LD_RQ_RST_GRT. Apparently the conversion missed to make use
> of this new macros resulting in the third bit not being set.
>=20
> Fixes: 30e919570581 ("PCI: dw-rockchip: Switch to FIELD_PREP_WM16 macro")
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-rockchip-p=
cie-system-suspend-v7-0-6ae6875939a2@collabora.com?part=3D1

