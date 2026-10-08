Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E8248E0DF;
	Thu,  8 Oct 2026 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463288; cv=none; b=q9kawRBR1QH3QxJCdXppX61dyMuGxdqSoiuUNLnx6qf8rlrIXZAPNMF5Ec1W66NeDxK5ufUHIaTUijIIld9VevbErCgAhaYJGCseq603A3lKE8lQZoQgW56pH/obmDn/g51XwBi2K569O98moDSB9E3HIwxnnO3iFr7BatIoFGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463288; c=relaxed/simple;
	bh=pAN1Hu/IgJg9pp21jQlzsrS9fZUvzUEWWSwlguTguFw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AY0aLcdZb/R2+V5qjTSSY5elyW2H19mZeffkOrnTwv54jowxB5Xd8ZbzhaJoCWUzii1zCHi0DtrZyE4dcY7V+ifIEyGjXgBLlab6lz9D57ptB9BLcNVssHY5vjZTmYLnRJl3jTP3p7M+TDUTFJP2dowCZdvA7mfP+lAXU4vAs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=sBg2uco6; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="sBg2uco6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791463281; x=1791722481;
	bh=pAN1Hu/IgJg9pp21jQlzsrS9fZUvzUEWWSwlguTguFw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sBg2uco60tDYkZIT/pbScYHrGUKjN+oDZoGuCo6D+QHPaciBg9dtKUSi/P5zJZyDS
	 2+89OIXi6b+8wSErm1fn+Jx2F2HAI38yDsmgWFTJG36hNzBSJVJeUD7zadpf9Qs2ks
	 F6r96fBNkLgZp2Mcb6JlD5gWkLLbTljRcjuk+AeL/rm7S1DhVN6shuTYVRBJV74aMN
	 4CXElH9VdmOv/LyXzPWV3DWdh5OI+1aML5AUuCYW/9Ti3D7FAaE0oK3tYRKd9oLvPy
	 UpOSFfVuUyWL5sLhuJrQEKd5Ff57HeKhQVnvFuzrV9VeG4j1htaV1b6kUE/fuCcUyr
	 yFGb9KZULcq2Q==
Date: Thu, 08 Oct 2026 12:41:18 +0000
To: Qiang Yu <qiang.yu@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: mani@kernel.org, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: X1E80100 USB4 PCI0 MSI-X routing under EL1/Gunyah
Message-ID: <179146327547.21465.818931382318963045@pm.me>
In-Reply-To: <179145909457.22346.16055361038608923365@pm.me>
References: <g7V4kc2AO9xogkH0h-XHDvPbjDXcnS11cp1q3hv0X96KPW-zed6V79HUJY5BFA4pBWUE-p2MBYCeDcjWwUGBIU2hXjDpodiWaxB38obe8RE=@pm.me> <arEjxhvfIFGGo9O9@hu-qianyu-lv.qualcomm.com> <C8SBDdV0hyOxs4G2FfZBHt4_1PSRVoxaNFSmy_riJk91MhqFMRAt30lpxdyniPMLWnc5Ph93lS0R1nCkVbuV941UrNmWyPNbDER9zIHlrJg=@pm.me> <7PyP8TPDWSo4VXsNVgDQREx6MqiqQWWL_BsssgI4SBuA9jkR707AGw5AVnm6k1OgH6F2n6Y6QAxah6ZRtKpjZfIKOiOngog3eeLFXIXXf44=@pm.me> <179145909457.22346.16055361038608923365@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: da726e5c9b2edd5ffbae10b72cb9fa3e3b020ee4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Qiang, Konrad,

A correction to my mail from earlier today. Releasing the tunnel reset
is only half of it.

gcc_usb4_0_gdsc also sticks at off, with the same GDSCR 0x6822f800, if
it went off with gcc_usb4_0_phy_sys_clk_src (0x9f0e4) on input 2.
clk_regmap_phy_mux_ops leaves it there when gcc_usb4_0_sys_clk is gated,
and gcc-glymur lists input 2 of that selector as the PHY's PCIe pipe
clock.

With the selector moved to 0 before the power-off and the tunnel reset
released, the router restarted three times in one boot, and a drive
connected afterwards.

Konrad, the selector part is mainline code, so your driver may hit it
too.

Thanks,
Birk

