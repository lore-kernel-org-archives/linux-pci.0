Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.154.119.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794951735;
	b=IDBwixCVhV1HU+rYSQyc75vi3dOz22unD/yPiA6jikhthlD3Ehp1lqWF4qJ04wgfAtFX
	 5I0UIyr9mCQrtsH+7D3cP5NIjVLMm4BQG0XCRZwgI6Hisa3F+UY9D5nqCn+e6hvJO3r/D
	 049wGJ3/iGhgzSWsOttkN7ciih966y2fXCz853uJQ59Xlz5xYydopBiNAF8nKRpEecEYj
	 3yovf3Y0Z93VcQJ+Z+pQQH001vtnE32jDDkaT/XQmqp4h0DmALsO1cIrBYzrHEA6ireG7
	 /sMD5XfpAjIQxqWEp+kHINaW25ewflDz+r2aW2WGKe6ibgZ2fhoH/ccND9QYLcvTl0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951735;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:User-Agent;
	bh=PrHvuwIuDErJm7EM/POsxG5qv1/2voyuislLca5+9uA=;
	b=SK1n4tAee7fiqQi5qV4aS2+XWUKfvvy2wnZOywSGj2+xx0AJ9D4MHHdrapDuolDySRow
	 xq6Y18kPClxWeojQ9kHPiu4vSwBN4gF2IYBS13Q9Lm4P32+Xyg120o4Q6w5sI2OpxeDhW
	 6mIzCnuKADodDfLElg7GUFCmqcuhgpuYkRZiri0WgLwDlW21O4y2wbyLdSsIR8go8vK8D
	 /sYbRd4pAmVOrgbsQ9ZiBcHIa+xt0j59b9QUEOPle++LSLQKqWCIO4ja1CVyBZo+jjR9l
	 BeHkX/dIMjByMVsTaCNp71R21vACszjmS+awiQUCLeqdT3Gd3MnmL3dh7d85rRp793A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aurel32.net;
	spf=pass smtp.mailfrom=aurel32.net;
	dkim=pass header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b="idd9LGL/";
	arc=none smtp.remote-ip=195.154.119.183
Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB68606A31C;
	Tue, 17 Nov 2026 21:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADB68606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.a=rsa-sha256 header.s=202004.hall header.b=idd9LGL/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=PrHvuwIuDErJm7EM/POsxG5qv1/2voyuislLca5+9uA=; b=idd9LGL/Vro7c0VHbgDwR/u6Iv
	E7k9Y/K/GK26hxy30CBDTzvylJ/VfXJ/vH8j3FJdIXNmiTa+MqwNYYCqVi6gnmhyGAQf9/pj4DFpB
	sgacsAUHnnGo3SsF15tqr2RXuhtyaRJAKtTJQlNB2v0cNZNFshDIo4pyqrjazGs3ltNON3VFgRCIz
	P0ZN6YdewWKbahdbNOTwZDl4PZK1StyHPpL/zf6qanH61ZhmxLPs+gKZw6FqJlklV0xuy/3LFjMPs
	ZvBdbbAQwTFg1JKQ/MhB3+ikHjl5ks21pP5zzypPqCHSgQX4AsTYDSrJBRtEoG6qV1siOgOl8SL1x
	qwebwdCQ==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1xTQwM-0000000GaSU-2Nd8;
	Tue, 17 Nov 2026 22:42:10 +0100
Date: Tue, 17 Nov 2026 22:42:08 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: =?utf-8?B?RnLDqWTDqXJpYyBNYWjDqQ==?= <frederic.mahe@cirad.fr>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Alex Elder <elder@riscstar.com>,
	Encrow Thorne <encrow.thorne@linux.spacemit.com>,
	linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: spacemit-k1: Request the Gen2 speed change once the
 link is up
Message-ID: <avzKMAtDqeqHIivr@aurel32.net>
Mail-Followup-To: =?utf-8?B?RnLDqWTDqXJpYyBNYWjDqQ==?= <frederic.mahe@cirad.fr>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Alex Elder <elder@riscstar.com>,
	Encrow Thorne <encrow.thorne@linux.spacemit.com>,
	linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261117085508.83388-1-frederic.mahe@cirad.fr>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261117085508.83388-1-frederic.mahe@cirad.fr>
User-Agent: Mutt/2.4.1 (2026-07-04)

Hi Fr=C3=A9d=C3=A9ric,

On 2026-11-17 09:55, Fr=C3=A9d=C3=A9ric Mah=C3=A9 wrote:
> On a Banana Pi BPI-F3, an NVMe SSD in the M.2 slot (pcie1) always comes
> up at 2.5 GT/s, although the root port and the drive both support
> 5 GT/s. The Directed Speed Change that dw_pcie_setup_rc() requests
> before the LTSSM is enabled has no effect on K1. Setting Retrain Link
> in the root port's Link Control from userspace brings the link to
> 5 GT/s, so the link itself is fine.
>=20
> Once the link is up, request the speed change again, wait for the
> controller to clear SPEED_CHANGE (as pci-imx6 does), then briefly for
> Link Status to report the new speed. A port with nothing behind it is
> skipped after 100 ms.
>=20
> With an SK hynix BC511, the link now trains at 5 GT/s x2 and fio
> sequential read goes from 397 to 575-640 MB/s. Data verified with fio
> crc32c. The empty pcie2 port behaves as before.
>=20
> This change was developed with the help of Claude (Anthropic); I
> reviewed and tested it on hardware.
>=20
> Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>
> ---
> The K1 PCIe cover letter says all ports run at 5 GT/s, so maybe this
> depends on the drive or the firmware; on this board the link always came
> up at 2.5 GT/s before this patch. Tested on top of v7.4-rc1 with "PCI:
> spacemit: Ignore PERST# input in RC mode on K1" (applies cleanly without
> it too).
>=20
>  drivers/pci/controller/dwc/pcie-spacemit-k1.c | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)

Thanks, I confirming this works well and greatly improves the NVMe=20
performance. I have just tested it for a few hours, and I'll mail back=20
if I encountered any stability issue on the long term. In the meantime:

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
