Received: from mail1.manjaro.org (mail1.manjaro.org [142.132.176.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A7838A298;
	Thu, 26 Feb 2026 04:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.132.176.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772081593; cv=none; b=B/Y+CajImxNXjKiGEb3Zpm51bukQeAjDx0PZxYICb3fyuBVfAgEQB/RZ7pl+hXcIi+K4vGsJ+ngK0Q0hTn/58EV7E72UNS9OndRY3giAykkJi4YkpWtOs+aChi6KcIbvcnxqtq5Kb5VzbG9keGIKqlktqKHIyui7tXfWwlqjk98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772081593; c=relaxed/simple;
	bh=e2x3Ilzd94O5EBiKf2VQVnVjI3fUbVuwUcpAuhch9z0=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=LBc4mWxytXKB9NE7AMblxlz+f2G5bpbJmX2XycKVip3nWtOg2i+wmtnu6FRa9HDfhUanRinFj38UB+GzdO/SNAWR5nrYPDYgzzHOEOHrVqTle+PRtLfErduru3nPGC+jMhOh3Zc50p0t+FlfIM9H+1Hkv0gCzMrjBcAm6xVAdlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=B60mAHbt; arc=none smtp.client-ip=142.132.176.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="B60mAHbt"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPA id 294C442053;
	Thu, 26 Feb 2026 05:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=dkim;
	t=1772081582; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ng3zv82xhOSBFnbYUmWaLkKZuWzEHGZYyz7mquCv+AY=;
	b=B60mAHbtY4h0REVywWQLt6HGshTl3/zo3YgAro3ysEruPLY9H7lIb8U2NVryz2wE2dzR/9
	T1Qu6DTp2lsD6toPJyDidLVlTY5LetXqJYgEhlDFEk/yPhfGmQCoAmf7GiEuJWPYek0ZsG
	6XWvCrcMHg7167k+pqJg5YeqyyqM43uruT4Pyc4WDo9e1lDAfMx5gg+wV7Ef0HBM3b5Ysj
	1Cq//twsLcMFzuRWBToe56EBHOFS1xu32VTDqkTiU8qoLxIaldz3+zJnKhArfzsQlEXC9T
	rr21LusDOw+xLVtUs0LwDW+ZYaZK4VT2Ht/s4kzfqatJsGLSmFasXlOT61AjeA==
From: "Dragan Simic" <dsimic@manjaro.org>
In-Reply-To: <aZ-RaBLVfEZA_FxU@geday>
Content-Type: text/plain; charset="utf-8"
References: <8db835ffe384db63ee598a203751b298ad1cc267.1772057799.git.geraldogabriel@gmail.com>
 <20260226001229.GA3794668@bhelgaas> <aZ-RaBLVfEZA_FxU@geday>
Date: Thu, 26 Feb 2026 05:52:58 +0100
Cc: "Bjorn Helgaas" <helgaas@kernel.org>, "Shawn Lin" <shawn.lin@rock-chips.com>, "Lorenzo Pieralisi" <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: "Geraldo Nascimento" <geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e0aa10e5-ec0a-4d0d-6f71-6797286221cc@manjaro.org>
Subject: =?utf-8?q?Re=3A?= [PATCH v3 2/2] =?utf-8?q?PCI=3A?=
 =?utf-8?q?_rockchip-host=3A?= comment danger of =?utf-8?q?5=2E0?= GT/s 
 speed
User-Agent: SOGoMail 5.12.3
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None

Hello Geraldo and Bjorn,

On Thursday, February 26, 2026 01:18 CET, Geraldo Nascimento <geraldoga=
briel@gmail.com> wrote:
> On Wed, Feb 25, 2026 at 06:12:29PM -0600, Bjorn Helgaas wrote:
> > On Wed, Feb 25, 2026 at 07:27:44PM -0300, Geraldo Nascimento wrote:
> > > According to Rockchip sources, there is grave danger in enabling =
5.0
> > > GT/s speed for this core. Add a comment documenting this risk of
> > > "catastrophic failure" and discouraging end-users from forcing
> > > higher speed.
> >=20
> > A comment in the code might be useful but doesn't discourage end
> > users.
>=20
> Hi Bjorn, thanks for the quick review.
>=20
> > > Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b=
4c21b@rock-chips.com/
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Dragan Simic <dsimic@manjaro.org>
> > > Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> > > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/driver=
s/pci/controller/pcie-rockchip-host.c
> > > index ee1822ca01db..4faf3e29b7d5 100644
> > > --- a/drivers/pci/controller/pcie-rockchip-host.c
> > > +++ b/drivers/pci/controller/pcie-rockchip-host.c
> > > @@ -332,6 +332,10 @@ static int rockchip=5Fpcie=5Fhost=5Finit=5Fp=
ort(struct rockchip=5Fpcie *rockchip)
> > >  		/*
> > >  		 * Enable retrain for gen2. This should be configured only aft=
er
> > >  		 * gen1 finished.
> > > +		 *
> > > +		 * Dangerous and may lead to "catastrophic failure", with data=
 loss
> > > +		 * or worse!
> > > +		 *
> >=20
> > Wrap comment to fit in 80 columns like the rest of the file.
> >=20
> > Remove spurious blank line at end.
> >=20
> > This should probably be squashed with the first patch; I don't see =
the
> > benefit of having them separate.
> >=20
> > Why don't we just remove this whole "link=5Fgen =3D=3D 2" block?  I=
f we
> > don't want to use it, there's no point in keeping the code.
>=20
> Yes, I think I'll go with this second option and remove the code
> block outright.

I agree about removing the effectively unused code block that handles
the "link=5Fgen =3D=3D 2" case from pcie-rockchip-host.c, but then plea=
se
remove the PCIE=5FCLIENT=5FGEN=5FSEL=5F2 define from pcie-rockchip.h an=
d its
single "link=5Fgen =3D=3D 2" use from pcie-rockchip.c as well.

As part of that additional removal, an early check for "link=5Fgen =3D=3D=
 1"
should be added to function rockchip=5Fpcie=5Finit=5Fport() in pcie-roc=
kchip.c,
because that will become the only "link=5Fgen" value it supports.

> >=20
> > >  		 */
> > >  		status =3D rockchip=5Fpcie=5Fread(rockchip, PCIE=5FRC=5FCONFIG=
=5FCR + PCI=5FEXP=5FLNKCTL2);
> > >  		status &=3D ~PCI=5FEXP=5FLNKCTL2=5FTLS;

