Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688B46AA8F
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791459112; cv=none; b=uk19Mm29obW8pZnDTAZ8f/eqALwdaaryWRM8NMnXZToNB0jkFZ8frgcrFSR7Sq0th1Jj68XttOIz0yhuWM34LFgVC2RJlzv1+bYcIHnyIysP7+DnLPVRzX6VYrO7kfW9V3/dRc9UNb6g/sutvEFzskYGFmRY6pVaD7X2i+m4/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791459112; c=relaxed/simple;
	bh=ZPob/8urWcAS4DZwufW6N99yingRZNKmpXDfGBrAdh8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jyKxvThYF8Ou9Oo/ZmH1QqZ7ZUbkwkU6v86MSCy6fleXR+8YC9klCOFo2mLJmmTXoTbal/NfFOr0IhabLzj0d8gfjb/xGCmti8tE1v/KdzURoKmsKDM4V5dp+7n96iDUl76tW/wU9EYRR04yezFI1oi4XNXmEflXstMwclWJi0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=UgcQZ0MH; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="UgcQZ0MH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791459102; x=1791718302;
	bh=ZPob/8urWcAS4DZwufW6N99yingRZNKmpXDfGBrAdh8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UgcQZ0MHIXsuwjLDaTD0s7mXVt7iemSfmovCzGq5Cfofc1p+bnIO67JAiHjPz5IkN
	 FIVQSszwLnnM/JrCRFnPSPc6TY64Inapd4DyTC0z+jhFlMmCpFHWFqNMVlL1wtS18b
	 sWlmdDryUF3t9ngRZghi4IBHi5Su+gZYGmWTcPISe73eOKM8h+hALsGJsuo9f4wMri
	 sxB3t8+ZucJr2AoA1lB41qXZ/Mft0bqIk+d4XYZ0BLyt9I2Sq06F7siuqjeQsvFA9b
	 qT4gL8Vn3flxr9b+I0HxnN5UUerA/N5UBaQO2TrGTHSVOUwfK+80Zi7n5wmPCdQfzL
	 XzTnSQh3S/vYA==
Date: Thu, 08 Oct 2026 11:31:37 +0000
To: Qiang Yu <qiang.yu@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: mani@kernel.org, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: X1E80100 USB4 PCI0 MSI-X routing under EL1/Gunyah
Message-ID: <179145909457.22346.16055361038608923365@pm.me>
In-Reply-To: <7PyP8TPDWSo4VXsNVgDQREx6MqiqQWWL_BsssgI4SBuA9jkR707AGw5AVnm6k1OgH6F2n6Y6QAxah6ZRtKpjZfIKOiOngog3eeLFXIXXf44=@pm.me>
References: <g7V4kc2AO9xogkH0h-XHDvPbjDXcnS11cp1q3hv0X96KPW-zed6V79HUJY5BFA4pBWUE-p2MBYCeDcjWwUGBIU2hXjDpodiWaxB38obe8RE=@pm.me> <arEjxhvfIFGGo9O9@hu-qianyu-lv.qualcomm.com> <C8SBDdV0hyOxs4G2FfZBHt4_1PSRVoxaNFSmy_riJk91MhqFMRAt30lpxdyniPMLWnc5Ph93lS0R1nCkVbuV941UrNmWyPNbDER9zIHlrJg=@pm.me> <7PyP8TPDWSo4VXsNVgDQREx6MqiqQWWL_BsssgI4SBuA9jkR707AGw5AVnm6k1OgH6F2n6Y6QAxah6ZRtKpjZfIKOiOngog3eeLFXIXXf44=@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 2adc6f2c4fa8288e3ae1880a86ce779b9ee18472
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Qiang, Konrad,

I can answer my own question about gcc_usb4_0_gdsc from 23 September.

The domain does not power up while GCC_PCIE_0_TUNNEL_BCR (GCC offset
0xa0000) is asserted. With that reset held, GDSCR stops at 0x6822f800
and CFG_GDSCR at 0x050e0000, and the GDSC driver reports "status stuck
at 'off'". With it released before the power-on, the same power-on
completes (0xf822f800 and 0x04070000). I ran both on the same kernel on
the Yoga Slim 7x, after the same router stop and ten seconds with the
domain off.

Our stop asserted the tunnel reset when it released the tunnel's PCIe
controller and left it asserted, and the next start asked for the
router's domain before releasing it. The router's own resets were not
involved: GCC_USB4_0_BCR and the eleven USB4_0 MISC resets were all
released in the failing case.

Konrad, this may matter for the ordering in your driver. If the tunnel
RC's reset is held across a router power-down, for example over suspend,
the router's GDSC will not come back until it is released.

With the order fixed, the router powers down and restarts repeatedly in
one boot, and a drive connects afterwards. The deep suspend hang after a
router restart that I mentioned is still there.

Thanks,
Birk

