Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B948C349CFF
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 04:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788410665; cv=none; b=VzuUSG2IfaftMViYP7GmmRLyf8hjJWtulctineEp1aKu+bAl+7g1xH4krBndU0W01HyQf2YIZ11U/zwP7RBCoM/GfReQq23JfHVezZ+4zP1yUPHzWjbrU1JZwF1vKGsXPA7s3pnE6f+omt9QFYV4xm0V6MYeHzkqKJrQlOKSqz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788410665; c=relaxed/simple;
	bh=ENZMBFErcRmm3mzVGZcsN/vrZ/ZGtGrGi6nV+LFVz1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l6Mp2vNH7ui71CZQZIrELr/TFVOSJW8uI7LWdt44PbFrVOgb7mx405AMWXC7Fu87ZbdmkOF12OjXCHYpP262XgY2ut2cgGGKIRslPAA26q7+sPo31ZW0AqEaiyKxgY9ktrZ9kQ0hmYeqt5wDYwMZqhohqwmxdx+IW1Rl6ybdeRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZTG+Zio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZTG+Zio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E091F000E9;
	Thu,  3 Sep 2026 04:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788410664;
	bh=jo+Fb1FnGAHsx8BtMelxARlxq3C3016vFb0JPcnvFrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UZTG+ZiocjgoKKzgiE0+lgtgxmNWkgdZeEc/F0ugXl24v9BSd/Zye26SN9uOQ3DAn
	 JAqXf2Ey9OztJRRflJXmOwk80lpzypEcmImiTyYTkYIL36h9MeW6xXTDKC0fujxdYi
	 znnDoYXuH1lnpwbSbqCXuqVHbYgGVM2Wv+nu98sQxTbMfJr20M8tm1ghcdDsIjnRUN
	 7jnbq/pttinfl69j3o9NJOjNj8enMQ0UeM1Yl+2C59MzAf6mG751FsI4EZy1MsOaMy
	 nzUQKiB8XvAFmAsJP7llmvXE6SqTcd+WZMQs1uqMTbEtcn8CdtojvH0woiT1Owm/zE
	 I5nURQzHOUbtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/6] PCI: Add the enhanced ACS controls check to
 pci_acs_flags_enabled()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB439314CABFD64FC0586F2FF8DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439314CABFD64FC0586F2FF8DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 04:44:23 +0000
Message-Id: <20260903044424.57E091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The enhanced ACS controls introduced by PCIe Gen 5 ensures better device
> isolation. On devices that support the PCI_ACS_ECAP capability, the
> controls are required to be enabled properly:
> - ACS I/O Request Blocking needs to be enabled to avoid unintended
>   upstream I/O requests.
> - ACS DSP and USP Memory Target Access Control needs to be set with
>   Request Redirect or Request Blocking to ensure the Downstream and
>   Upstream Port memory resource ranges are not accessed by upstream
>   memory requests.
> - ACS Unclaimed Request Redirect needs to be enabled to ensure accesses to
>   areas that lies within a Switch's Upstream Port memory apertures but not
>   within any Downstream Port memory apertures get redirected.
>=20
> To maintain compatibility with legacy devices that lack PCI_ACS_ECAP
> support, pci_acs_enabled() skips checking for the capability.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB4393F337A7=
92CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D6

