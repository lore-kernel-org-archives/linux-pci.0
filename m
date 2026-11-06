Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987302;
	b=NPXO22cdwZruMWvw0HY01/lOtGre+NBXgCsf9/4onENgWPQl5iIALsWQzubCf/gL3E/j
	 Wmdv5FUplxCoGvzY8PFrYKcWha6JKzlPPH7pYOt32/Q42S1QX41/cd87POXqdmqh63Aj1
	 RBpAXBBD2Fw5g+5B4qVkJW2XWSyupw7VHByeHLl8AbRy8v3Rts4v1afnMoeNJG4UwvCYe
	 eMVQSDByWGzCirxWKiBOCHD0PaNjyQuBHRbhADBT7Kg6dnJBrqwfk6gmNn12CDPN0qJtv
	 ZiqJrAsyDH9v4g4hKW0xMaKR0MnnAQyvJ0bqGtyHab+8Y15dhKHsfbF74H263wPe6Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987302;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qRbRyftsDjUhs2khKYmmhqWHuuupZGj0YAAao8jpBXA=;
	b=glOnt+bA+dMfVnkDzrj5Clrpu1axeJ+SxB9WEzdlGgv4m+IQY8RU/WrmPhLIUyqcXVDN
	 P8hExHxFP9H/iNkhVEEhhxkLaM2vmXlJJyOIOqSzc5jgRicdHvYLt/ONbI8HotIIYTDF/
	 myh5OoO2QmoGUrXHbTA+1YgLdTKGuyl2zMb8YsAf3w28FUL01yy4dm9rRB9k3qOHpJNN6
	 5Szweak4l97i40XYL2v8zrBytdaO7oUMq0IWmcpFy7+b2vt0f7KFJjpLHbZDlgIJHcnFB
	 +rc6TOvX2yd28VHmi5nYFcBKABmj9PLd2bUbKWfWLVlMdj5DKOH8Btaf6Axv3jT5c7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kp1SmWLK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE5606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kp1SmWLK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E761A1F0089F;
	Fri,  6 Nov 2026 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987302;
	bh=qRbRyftsDjUhs2khKYmmhqWHuuupZGj0YAAao8jpBXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kp1SmWLKSyY7ur4NvjwGxK/VCZyCGpD8EnSrF8tvR8PtfoBgXMnVb2CpdaREIrjk+
	 czfocvGDX4PILGNwccjMWjSByAfMBK8tMVXJTMLrW23WqsJlwZHis3a72L/8au1op3
	 cMljg3gQ/Xjg3ysmjR1zu4kjwxj8ZXStWLZrud3OhItpManlLUqLat0r/xeeK2wp2Z
	 umbMdniyGzaKHqZsDyWQulOtfb7Q3Qy0K3AOdH69TOPxde16ktfhD+4iGlu45oXd1X
	 uIg1gwmrOw90e3d8HOl9ojb8FnhlyOwmY9vUOFfNuncjMqZ8s12oqm+5Et1Q3PM/Xn
	 Q1EKGnDRJ1HzQ==
Message-ID: <sashiko-outbox-201968@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] genirq: Add disable_irq_noflush()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Keith Busch" <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106173448.34794-2-kbusch@meta.com>
References: <20261106173448.34794-1-kbusch@meta.com>
 <20261106173448.34794-2-kbusch@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:48:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Keith Busch <kbusch@kernel.org>
>=20
> Drivers that switch between interrupt and polled completions don't need
> the mask write flushed to the device; the disabled state already
> keeps their handler from running and a late interrupt is replayed on
> enable. Add an optional irq_chip::irq_mask_noflush() callback, falling
> back to irq_mask(), and disable_irq_noflush() to mask through it right
> away rather than lazily.
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106173448.3479=
4-1-kbusch@meta.com?part=3D1

