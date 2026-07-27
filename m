Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE38C3D903E
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187577; cv=none; b=rFUgll30T1b1OfPjsrLgwB+Uff9RngKzyy08xz2uisSXsF7jAznzBC2DN482PUUQ9MNkcZXjunbFftDtg68sGck1LL9CkdPfylpQcl0dL2KJOHnxUL4vzKFu3B4yE9Fp/589/+dIZPhmBBRGlcjRBEHo+6r6OlgrLKtVs75pN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187577; c=relaxed/simple;
	bh=b0MKzIFWufysWFqxEwY3kg4Sk7n6iC6f6K8mPeOXuoA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kdhXsT/MV7uLVcdHPrIPIyGd1I6DUe0S0HMfE6XNa9/iRAu87qTIxJiWrziZG/pL62uSOGyEwsDur8S6d13brdlAkPNVvFDInpMobLwoWBcNyIR3BYJ45QigbMnbIbhLqnMfoE3BXmAWtm1ENXdvnT5C6GUIrVl6whQ69XWdHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSbHw8Zi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSbHw8Zi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3B01F000E9;
	Mon, 27 Jul 2026 21:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785187576;
	bh=b0MKzIFWufysWFqxEwY3kg4Sk7n6iC6f6K8mPeOXuoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MSbHw8ZiYBMZyI1ysKt4UyUAppBWtrn23s9mvmcnWRx2YsiJM7XJEIxLg1IGZy6KC
	 4hMYmeIoZBBZVetofPhL00uRO+EUTAivAIv9KhCGzOl+at57i1udegEb1VfqKjXwJb
	 oADT8QLYgT7MVUPM2r+fusqJFLLBfFzjSinfSIKJBRScK3U2TgUztyEZ4Sr7HtW9RH
	 DUZPT3/WgPK/UIQPsbt055afNwlDFC0beDnD8rwZGFcjpnpKe8nsRUuRUe+bq94+Ue
	 lUKU0NQAenPNSY2x69bZpLBIRC+9FwOmhO0tG3Web37dg1Jw93y2bzKcU04MDaHHeJ
	 C43GYFJSZLIXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] thunderbolt: Add device links for Apple T2 NHI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727211807.1223-3-atharvatiwarilinuxdev@gmail.com>
References: <20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com>
 <20260727211807.1223-3-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 21:26:16 +0000
Message-Id: <20260727212616.9F3B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Ice Lake Thunderbolt NHI on T2 Macs (2018=E2=80=932020). The NHI and its
> associated PCIe Root Ports all sit directly on the Root Complex
> with no upstream port. Identify the tunneled PCIe Root Ports by
> their PCI IDs and create device links back to the NHI so that
> PCIe tunnels can be re-established after sleep.
>=20
> And on other T2 Thunderbolt NHI's, like Titan Ridge, the default method
> is used to add device links.
>=20
> Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
> Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
>=20
> Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727211807.1223=
-1-atharvatiwarilinuxdev@gmail.com?part=3D2

