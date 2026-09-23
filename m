Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C5B2C21DF
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167812; cv=none; b=BVBaQwcpXwO58HJd9InIHX8da7F05T76fX3CZRLqFgM2NwhJ8DzgnNSrIzj1Mejcx0SVPlItFnVnbNroraMcaeKotfO+0a9Ms3DFgYbihJb2PyW20h0Y+92v0tDTABuXg46SlPjvJTSdtmCrSGfzxvDoR1pidzpPDeC+wE/KzMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167812; c=relaxed/simple;
	bh=7JEYAayWA829bJ03hnHy5+AKULTJK87X0OtRaqshSTE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjH3sCf22HkZaBmr5XrkJ1Tr9yvosb2eR5ZZAiTIywSHWQubSrvF++FVgiTw0PpG7aAk5jjJcRVJwaVulI5X7EG9ObEds9GPvAcok7owvAMYwP7Aavi7iAuvGjIT8GBvoQ+SlZ/piB2+wAbZcUkPin5/rMAjAFMGqxhuP5v5xls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=WM2KnTSn; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="WM2KnTSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790167808; x=1790427008;
	bh=frqa0bOqSCZYcD48+Q0Xau74ISQMvbK9fD24LX5mRZ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WM2KnTSntvoI8dvvA2RfZQU0GbGY4ICq/O64jl4Yu+0ZDJ4vd7l4/6iZGhwW23usJ
	 R4xys/WxU9yk27JzjiU9tnT6j/puxd/9UxkCw4MBLy0fXBcNbMHwD4RAc8pVfShMy9
	 s7C+/IlPw/IXYQRPx1YTbhtKSGml68uLWRD4kH4zzhirMh4n0cG6XuzzTidmaRK7Qf
	 4eBRtfP6YW7vUPH/P/hXuVYbBJQHmJjxOj8NvMszgvt+qHFlkVVYPv2OTeHnaiA6gc
	 aWK+r9DmlFjWimnRTEuFIGRS25AfzTfRg9/iY3DhImhGNlC0JNqsmGQskwn6SKPA9X
	 BuWZ6f4q/LMKw==
Date: Wed, 23 Sep 2026 12:50:04 +0000
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, "mani@kernel.org" <mani@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: X1E80100 USB4 PCI0 MSI-X routing under EL1/Gunyah
Message-ID: <yAHdWansNq46a13rbKUlBxeOcDCBlcJBssFpDYHVBWs24XcjMolLGRNCUe03iTcu1oKbDIcJWcVU5urfj61noQHGRgMpOnqXIMEwR4K2_vY=@pm.me>
In-Reply-To: <cdfcb65e-9a17-4f93-a1f6-d739727ac709@oss.qualcomm.com>
References: <g7V4kc2AO9xogkH0h-XHDvPbjDXcnS11cp1q3hv0X96KPW-zed6V79HUJY5BFA4pBWUE-p2MBYCeDcjWwUGBIU2hXjDpodiWaxB38obe8RE=@pm.me> <arEjxhvfIFGGo9O9@hu-qianyu-lv.qualcomm.com> <C8SBDdV0hyOxs4G2FfZBHt4_1PSRVoxaNFSmy_riJk91MhqFMRAt30lpxdyniPMLWnc5Ph93lS0R1nCkVbuV941UrNmWyPNbDER9zIHlrJg=@pm.me> <cdfcb65e-9a17-4f93-a1f6-d739727ac709@oss.qualcomm.com>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: c3c9d6a4af8be5994e4e537dc20ee20436f2262a
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

Thanks, that makes sense. Our test setup brings up the tunnel's PCIe contro=
ller from the router driver rather than through pcie-qcom, which is why we =
had to do it by hand. With pcie-qcom in charge it should just work, as long=
 as it runs after the router's resets.

Konrad, while writing the Yoga Slim 7x device tree against your RFC binding=
 I ran into a few things you might want before posting.

The binding no longer passes dt-validate on current trees. usb-switch.yaml =
has since been split and port now lives in usb-switch-ports.yaml, so the bi=
nding needs a reference to that file as well, the way parade,ps8830.yaml do=
es it.

The Yoga's DSDT has the interrupts for all three routers. Router 0 matches =
your example (472 and 579), router 1 is 605 and 607, and router 2 is 429 an=
d 438. Each port also lists a third interrupt (255, 523 and 534) that isn't=
 in the binding. Any idea what it's for?

The DSDT also carries a per-port RX equalization byte, 0x6f for ports 0 and=
 1 and 0x6c for port 2, which the Windows driver writes to RX_MODE_RATE3_B4=
 on both lanes. Your patch 4/5 hardcodes 0x6a. Port 0 runs at 2.6 to 2.8 GB=
/s here with 0x6f, so boards like this one will likely need a way to overri=
de it.

And something from suspend testing. With gcc_usb4_0_gdsc kept always on (ou=
r workaround for the power-up issue I asked about), powering the router dow=
n before a deep suspend and back up after resume works fine the first time.=
 But once the router has been restarted in the same boot, the next deep sus=
pend never comes back. The log stops at "PM: suspend entry (deep)" and psto=
re is empty, even though clocks, power domains and interconnect votes look =
the same as after the first power-down. Have you run into anything like tha=
t?

The device tree covers all three ports, so I can test your driver on every =
port as soon as there's a branch to try.

Thanks,
Birk



On Wednesday, September 23rd, 2026 at 06:51, Krishna Chaitanya Chundru <kri=
shna.chundru@oss.qualcomm.com> wrote:

>=20
>=20
> On 9/23/2026 5:40 AM, Birk Skyum wrote:
> > Two details were needed on top of the DT. The DBI MSI registers (0x820 =
to 0x830) had to be programmed after the tunnel BCR reset and the router re=
set requests, and MSI on the root port itself had to be opted out.
> These two should be taken care already in the latest kernel 7.3 [1] & [2]
>=20
> - Krishna Chaitanya.
> [1] pcie-qcom.c - drivers/pci/controller/dwc/pcie-qcom.c - Linux source c=
ode
> v7.3-rc3 - Bootlin Elixir Cross Referencer
> <https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/pci/controller/=
dwc/pcie-qcom.c#L1809>
> [2] pcie-designware-host.c - drivers/pci/controller/dwc/pcie-designware-h=
ost.c
> - Linux source code v7.3-rc3 - Bootlin Elixir Cross Referencer
> <https://elixir.bootlin.com/linux/v7.3-rc3/source/drivers/pci/controller/=
dwc/pcie-designware-host.c#L1181>
>=20
> 
