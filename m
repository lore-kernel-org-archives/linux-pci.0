Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679748EC89
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256892; cv=none; b=hoFT2xCS2WGRAzAfgatgATJZn7qCvWjE8//mRZp5cNjX5TqTkD5LZn/ueUjMldxs7FIXQHQPr0nGxQbWF9Q89/ehMfw3+oIK7DWKDgO30qhW8IoxW1DkesYBsLvpWiY1QaH3uEQNbC5v8g1b0Hat7h1EuEzxm98J8AqBzs99qMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256892; c=relaxed/simple;
	bh=sx84sDuN//OCTbrIddKMRXkV0hpqSz/AOVvMJXBMjUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X27TnjVvUQMYY9TqfakOJAq7jS/Y0UqXn+/BpTr8kwfGeMaCCZJFAbFZHp8f8pvqKitriuKc+g7OhThsL3VuGGc25dp4XL1ollHqB3f29B9iUxQ7YLxFGZJ6CeJtpX5I8SodWlo/8eTrwHPzjOckTNdWKybi1hoRvjmUD664Eho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqKBO/YL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqKBO/YL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FBF1F00893;
	Thu, 24 Sep 2026 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256878;
	bh=vOgicc9vk8ha9Z+q+vh1EEZFmLQv90eVo+YrUgQGfaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XqKBO/YLgfsdo0d+Es09Tp8Rtv+BXBJO12PquT4CLbG1mUbKiuZp4xmT3kTbB/mw0
	 jyHw6BpYWntbnYgPb7UkpOvbvfA2jOZoilQlGFM2KGTSrKy0qD7bfr1H7MylWGoElC
	 u3pCwOxN3NKYXoyy7X91eN0slq8IDfaRf3mZ51wPe+PgNCezNXjnONp2M+4ABAZfsO
	 NqO62I91OfnmrySsxc5zAXAJY3E56jjahwsrrvPf81jgX0x9v9k3cqlUR9xJ02HGNk
	 yc5PvM2zjRKmNO+yUvRNWIoAzCIVaBwwLaP/AqlrQ9zi4E1w/u9JeiK+/jQqYfq5Mt
	 p7z4DvQzkgMwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Extend Apple Thunderbolt power quirk to Alpine
 Ridge
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RnJhbmNpc2NvIEJlbHRyw6FuIE1pbGxhbMOpbg==?= <fbeltranmillalen@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924132815.24430-1-fbeltranmillalen@gmail.com>
References: <20260924132815.24430-1-fbeltranmillalen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 13:34:37 +0000
Message-Id: <20260924133438.44FBF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On Macs with an Alpine Ridge Thunderbolt 3 controller, suspending to RAM
> with anything plugged into a USB-C port leaves the PCIe link between the
> root port and the controller's upstream bridge permanently untrained on
> resume.  The link does not merely fall back to a lower speed: it never
> starts.  On a MacBookPro14,3 the root port reports
>=20
>   LnkSta:  Speed 2.5GT/s, Width x0
>   LnkSta2: EqualizationComplete- EqualizationPhase1- Phase2- Phase3-
>=20
> with no correctable, non-fatal or fatal errors logged, and the link
> training state machine stuck at its first state.  Both Thunderbolt
> controllers, both integrated xHCIs and all four USB-C ports are lost
> until reboot.  Measured 15 failures out of 15 with a device attached,
> against 5 successes out of 5 with the ports empty; it follows the device,
> not the port, and affects either controller.
> [ ... ]
>     and leaving it out is the conservative choice.
>=20
> Tested on 6.18.49 on a MacBookPro14,3.
>=20
> Signed-off-by: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@gma=
il.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924132815.2443=
0-1-fbeltranmillalen@gmail.com?part=3D1

