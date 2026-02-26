Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D1538B7D7;
	Thu, 26 Feb 2026 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088788; cv=none; b=fDlMp0IV9BSRxuoP5kb1yEtB3rh+kFayX5cjypl46kXZ3iI3KXUFTkIsOLxHXZ49f4qxa8mprjUQ/3x1G4/SIaB9Q0z4Jo9kkBuPcVNP2gVc3QOgUFlhYagXdlrKhwRxyMuf6P72YrsFeZ2VQUhp/Doi44KO2UUd5mlOz69FJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088788; c=relaxed/simple;
	bh=mrT3R0FF6W4LVOZAR/U7sHMjtaitqOGuzp1gkc7ZMyw=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=k4YHVt7hSvehGWhF28rgpG568p/z7BgQd2b/izAMEQFeKdMomN4p8z3Pg6F+uH8SDDFr3sX6K3uSQen8nsJna44CI9CPLob4u/HXdDNI0bkDrDlstuvvzdQr02wf0+7YUNl1aDPgkXt2hzCxWGS2NZ68NTyceKpS+tCviDTsmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Zk9OF+IH; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Zk9OF+IH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 5F27740979;
	Thu, 26 Feb 2026 07:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1772088784; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zqkIHaA7pn62FNksNMToTkxsGlzJhhwIoAGGjLcJ8gA=;
	b=Zk9OF+IHov2lNMm1LlJpQ+E421rW6PaBKSB4aAECaZBi1QwJ6T0okGxcKplJeiAP8NGNQJ
	VoXNOevH4PJdmmtR/WYU56W7ZLTMwAWY2KdBuzXiMfZqxU/dMKmW2jQ6hR+ewn/i/djT3z
	rlTHafafFd2oZd9YJ/0HFuO/pPytIkgRqBnSYLV374ekzAEMcsL7fb5TclqA7dVu8eY77N
	ANfrBDofCZ+TKjC8+TuGu5hHEg/ITN0hOfx51y8m82+8tFmSLWsaUGesJIjzV9YeOMD5rh
	wbO4O3WNtTYKMl2KO8DAK+ZDPfo1IV3St04+ykiqCfInjJaWFPuUPPqASeu0Zg==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <aZ_U0ASjuK2fZi5h@geday>
Content-Type: text/plain; charset="utf-8"
References: <8db835ffe384db63ee598a203751b298ad1cc267.1772057799.git.geraldogabriel@gmail.com>
 <20260226001229.GA3794668@bhelgaas>
 <aZ-RaBLVfEZA_FxU@geday>
 <e0aa10e5-ec0a-4d0d-6f71-6797286221cc@manjaro.org> <aZ_U0ASjuK2fZi5h@geday>
Date: Thu, 26 Feb 2026 07:52:59 +0100
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <b760ec8f-b57e-a505-62ef-a8bbc9dd8aac@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v3 2/2] =?utf-8?q?PCI=3A?=
 =?utf-8?q?_rockchip-host=3A?= comment danger of =?utf-8?q?5=2E0?= GT/s 
 speed
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

On Thursday, February 26, 2026 06:06 CET, Geraldo Nascimento <geraldoga=
briel@gmail.com> wrote:
> On Thu, Feb 26, 2026 at 05:52:58AM +0100, Dragan Simic wrote:
> > I agree about removing the effectively unused code block that handl=
es
> > the "link=5Fgen =3D=3D 2" case from pcie-rockchip-host.c, but then =
please
> > remove the PCIE=5FCLIENT=5FGEN=5FSEL=5F2 define from pcie-rockchip.=
h and its
> > single "link=5Fgen =3D=3D 2" use from pcie-rockchip.c as well.
>=20
> Good.
>=20
> There's also some code that needs to be dropped from the endpoint
> driver.

Oh indeed, there's a redundant code block that handles a "link=5Fgen =3D=
=3D 2"
case in function rockchip=5Fpcie=5Fep=5Flink=5Ftraining().  As a note, =
a similar
early check against "link=5Fgen =3D=3D 2" should be added there as well=
.

> > As part of that additional removal, an early check for "link=5Fgen =
=3D=3D 1"
> > should be added to function rockchip=5Fpcie=5Finit=5Fport() in pcie=
-rockchip.c,
> > because that will become the only "link=5Fgen" value it supports.
>=20
> What do you think, should the driver bail out completely if
> link=5Fgen !=3D 1 or just let it force 2.5 GT/s speed with a warning?
>=20
> I tend to go with the latter.

Actually, I'd go with the first option, i.e. bailing out early in funct=
ion
rockchip=5Fpcie=5Fhost=5Finit=5Fport() with an error message emitted, b=
ecause that
function isn't supposed to define the link parameters.  Thus, if it end=
s up
receiving wrong link parameters, the issue lies somewhere else and shou=
ld
be fixed at its origin.

