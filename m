Received: from mx-relay28-hz2.antispameurope.com (mx-relay28-hz2.antispameurope.com [94.100.136.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C9375F6B
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614087; cv=pass; b=rLUZ91J/Z6ufS60we0t9Wi3qK1dbMzgT+aU26jwy0ZU8SFNnyrB5Z8m5+rIJcevaGMCKI8FCV09OOsHuW4zSwvafq+t8XSGxKbGvEq0QUkxXr7yfZIdhjonlnmzNrE/Emgf9RnTMA9CkFbQezQ/UZEiwayOR0nli3wmBPv293P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614087; c=relaxed/simple;
	bh=RXSffSzEJPRbTJBVRVQaYy+1Rbgr2pp8gsOU8CPq9xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fK4nLBrDEpSApMVX6yQhycTSu/tOmQJlHy/zCQiL08z58sI1vS/IYnDkpOog7uiZm0SiqBEN8lbfp8vP8CGEyg3CZ503Qpxam0sE9DI8hmwRCCYFImYGILL/iQcIyyzzl3hJPaMKMui3EJIBPUakb0Vxtt4UPb2jcM+bsQ2tV3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GeU9+r4Q; arc=pass smtp.client-ip=94.100.136.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GeU9+r4Q"
ARC-Authentication-Results: i=1; mx-gate28-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=Tc5060lOULfVsdNRxfTIuSjgRGoa5zkf8LbdJsu7Flc=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1772614050;
 b=ryEaI4woBBI7+/mRGOgTbzBfeczaikUxcM5Lq8H14XPiDrK+Jsgh/wOjtNRDBLXYdEce4rPh
 KenHYBa9JchzBGFwebKhJn5I1Ba/0naH01ghrDXtJvZ2wCPqbCL6BAebY19Vli25OhaUz4LgkEz
 bsvP3ACIfL12O3UMQYE5L1e4DNRw5Wk2BoC6BeLXsaDv8L7DcYIxvJ2/s02wWUg7BWulq2vcfR2
 8g/ArRcXDq1SRpFyPK8XvgXxLRR0MsUpN9q9NPuUHLj0rN+ul7zgKZckP/hTJks2/HVeXdyImww
 s5RDx3Ai3zb1aLBI4QwvlsBU9/aoHF7mBHrLY2FuBmtug==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1772614050;
 b=UPoQo8ixpPA5uWEpcAu8AX7gFTtVJFNXUf20HLOqtg/No5DgV1uz82kD8AHZhAl9xzLpMcok
 MWglXCRB2gwBsPLD8bsk9N1R9frBfjS3g3WkgJUAnEKNR6jbmLqO4xiBRL7PgkQiMmptvo0dyIC
 eWgsgA0MR6qerB47NB56M/tmL0nmh0xOGarpeQ8yRRenKnj3RkiaZnydapj+g5OQTWd7NkyfZD8
 gOQJyG6DDxQ50MWwrbzDwACgMGyfISxRyb++XMsvlgABerKH68yS5jLwjj0S+YRo8qdQ38dj79x
 QHuRQHVzFtBUJBUS2+GOTj2a4ncvebDeahK/RJhhqDgvA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay28-hz2.antispameurope.com;
 Wed, 04 Mar 2026 09:47:30 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 5ED3ACC0D36;
	Wed,  4 Mar 2026 09:47:23 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: i.MX8M Plus PCIe link regression
Date: Wed, 04 Mar 2026 09:47:23 +0100
Message-ID: <6102060.LvFx2qVVIh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <2qto2ddqmtks37wxtklxo4ctvxyezmgtjcuprnk6crant5fvsu@vdbmqomrcqt3>
References:
 <23024521.EfDdHjke4D@steina-w>
 <AS8PR04MB88332979F06EDE29E751BCE18C7CA@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <2qto2ddqmtks37wxtklxo4ctvxyezmgtjcuprnk6crant5fvsu@vdbmqomrcqt3>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-pci@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay28-hz2.antispameurope.com with 4fQmWb5Jc5z1QKgG
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:327ce3c9e8c61b36ad9fc7d5cc2ee034
X-cloud-security:scantime:1.715
DKIM-Signature: a=rsa-sha256;
 bh=Tc5060lOULfVsdNRxfTIuSjgRGoa5zkf8LbdJsu7Flc=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1772614050; v=1;
 b=GeU9+r4Q1FXW+hX+RWqlojwsE3FV4hFpgzq5LrD2vEJsUYm5MIJvp05UYbq31N74CrAcznCW
 F0kSiC0hMT6oamwJzAVXbP8CKYbbWiCClvz7Ydq054A2W7TY/5th58qep7KV11bLzxq0jKPZamJ
 yMBQY4D5I5+LwCwDcFZWpLb2NtpSS1MGa9tkSAccLxsUD0Pd6TwnzkARWUh4LE3CzMvus0Wt3Hg
 Lyt/k/sFhXtSHG00OhoEmKVtE2X8rkOIjru96qSb8ARKWr8EQTyluyKAf/DwgjTXxihJblFWdJY
 rZhPIZSv6xrytregMF0OUJnQ1+DMPMvde3tgISrgF9KnA==

Hi,

Am Mittwoch, 4. M=C3=A4rz 2026, 07:32:48 CET schrieb Manivannan Sadhasivam:
> On Wed, Mar 04, 2026 at 02:55:51AM +0000, Hongxing Zhu wrote:
> > > -----Original Message-----
> > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > Sent: 2026=E5=B9=B43=E6=9C=884=E6=97=A5 0:42
> > > To: Hongxing Zhu <hongxing.zhu@nxp.com>; Alexander Stein
> > > <alexander.stein@ew.tq-group.com>
> > > Cc: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > imx@lists.linux.dev
> > > Subject: Re: i.MX8M Plus PCIe link regression
> > >=20
> > > On Tue, Mar 03, 2026 at 01:38:13PM +0100, Alexander Stein wrote:
> > > > Hi,
> > > >
> > > > these days I noticed that there is a PCIe link regression on my
> > > > i.MX8MP platform (TQMa8MPxL) running next-20260227.
> > > > I could bisect it back to commit 9c03e30e3ade3 ("PCI: imx6: Skip li=
nk
> > > > up workaround for newer platforms"). I always get the following err=
ors:
> > > >
> > > > imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM:
> > > > CFG_LINKWD_START imx6q-pcie 33800000.pcie: probe with driver
> > > > imx6q-pcie failed with error -110
> > > >
> > > > Connected is a Gen1 PCIe -> Ethernet adapter. Interestingly a Gen2
> > > > device is detected without issues.
> > > >
> > > > Reverting 3c96a61dd2e098dda8dcac3dce3d38a3c87afbfc and
> > > > b9a8d28ebbf118bb3eac953f4a37abbd341257ab "fixes" my platform, both
> > > Gen
> > > > 1 and Gen 2 devices are detect. Commit
> > > > 3c96a61dd2e098dda8dcac3dce3d38a3c87afbfc is only required for confl=
ict
> > > free revert.
> > > >
> > > > Here is a summary with outputs:
> > > > Gen 1 device
> > > > > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > > > > 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> > > > > RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (r=
ev
> > > > > 01)
> > > >
> > > > Gen 2 device
> > > > > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > > > > 01:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9128 P=
CIe
> > > > > SATA 6 Gb/s RAID controller (rev 20)
> > > >
> > > > output of "dmesg | grep imx6q-pcie". Common part for all tests:
> > > > > imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
> > > > > imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff ->
> > > > > 0x0000000000
> > > > > imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff ->
> > > > > 0x0018000000
> > > > > imx6q-pcie 33800000.pcie: config reg[1] 0x1ff00000 =3D=3D cpu 0x1=
ff00000
> > > > > imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K,
> > > > > limit 16G
> > > >
> > > > next-20260227
> > > > Gen 1
> > > > > imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM:
> > > > > CFG_LINKWD_START imx6q-pcie 33800000.pcie: probe with driver
> > > > > imx6q-pcie failed with error -110
> > > >
> > > > Gen 2
> > > > > imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up imx6q-pcie
> > > > > 33800000.pcie: PCI host bridge to bus 0000:00
> > > >
> > > > next-20260227 + reverts
> > > > Gen 1
> > > > > imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up imx6q-pcie
> > > > > 33800000.pcie: PCIe Gen.1 x1 link up imx6q-pcie 33800000.pcie: PCI
> > > > > host bridge to bus 0000:00
> > > >
> > > > Gen 2
> > > > > imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up imx6q-pcie
> > > > > 33800000.pcie: PCIe Gen.2 x1 link up imx6q-pcie 33800000.pcie: PCI
> > > > > host bridge to bus 0000:00
> > > >
> > > > What can we do here? I'm wondering why Gen 2 trains correctly, while
> > > > Gen 1 doesn't.
> > > >
> > >=20
> > > Thanks for the report and sorry for the breakage. Commit 9c03e30e3ade=
3,
> > > mentions that the workaround is only needed for the i.MX6 platforms. =
So
> > > I'm not sure why the patch breaks i.MX8M and that too only for Gen 1
> > > speed.
> > >=20
> > > Also, before 9c03e30e3ade3, LTSSM was always started in Gen 1, but as=
 per
> > > your finding, only Gen 1 devices fail to work. So the code till
> > > imx_pcie_wait_for_speed_change() shouldn't have an impact. Maybe the
> > > issue is due to skipping imx_pcie_wait_for_speed_change()?
> > >=20
> > > Richard, thoughts?
> > Hi Maini:
> > Prior to calling imx_pcie_wait_for_speed_change(), the PCIe link must
> >  already be established. Before commit 9c03e30e3ade3, the speed change
> >  procedure was only initiated after the initial Gen1 link was successfu=
lly
> >  brought up.
> >=20
> > Hi Alexander:
> > Sorry for the breakage.
> > Before commit 9c03e30e3ade3, i.MX8MP PCIe forced Gen1 link training
> >  initially, then switched to Gen3 after link-up by triggering a speed
> >  change. After commit 9c03e30e3ade3, link training starts directly at
> >  the Gen3 capability level.
> >=20
> > The two link training methods differ only in the i.MX8MP Root Complex (=
RC)
> >  link capability configuration prior to link training: one method forces
> >  Gen1 speed, while the other retains the default Gen3 setting in your t=
ests.
> >=20
>=20
> I still don't understand why the link fails to train at Gen 1.

Independently from the configured maximum link speed, shouldn't the initial
link be Gen1 anyway and upgraded to Gen 2 later on?

I added some debug output to dw_pcie_link_up()

imx6q-pcie 33800000.pcie: dw_pcie_link_set_max_speed: current pci->max_link=
_speed: 3
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f704
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x28000000
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f722
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM: CFG_LINKWD_START
imx6q-pcie 33800000.pcie: probe with driver imx6q-pcie failed with error -1=
10


imx6q-pcie 33800000.pcie: dw_pcie_link_set_max_speed: current pci->max_link=
_speed: 2
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x28000000
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x28000000
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x2800f702
imx6q-pcie 33800000.pcie: Link failed to come up. LTSSM: CFG_LINKWD_START
imx6q-pcie 33800000.pcie: probe with driver imx6q-pcie failed with error -1=
10


imx6q-pcie 33800000.pcie: dw_pcie_link_set_max_speed: current pci->max_link=
_speed: 1
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08000010
imx6q-pcie 33800000.pcie: PCIe Gen.1 x1 link up
imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00

So for any maximum speed above Gen1 it seems that LTSSM is stuck at link
training.
Unfortunately only link training and link up bits are defined and RM doesn't
show anything, so I don't know what the other bits are indicating.

=46or a Gen2 device the link training succeeds right away.

imx6q-pcie 33800000.pcie: dw_pcie_link_set_max_speed: current pci->max_link=
_speed: 2
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08200000
imx6q-pcie 33800000.pcie: dw_pcie_link_up: PCIE_PORT_DEBUG1: 0x08000010
imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up
imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


