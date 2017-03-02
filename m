Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 2 Mar 2017 21:08:00 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 07/20] PCI: implement Devres interface to map PCI config
 space
Message-ID: <20170302200800.GA21303@ulmo.ba.sec>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-8-lorenzo.pieralisi@arm.com>
 <CAHp75VfdE6_W+DxhejorLxra2JQDGF3cG0uBedyOohhmcLiKLg@mail.gmail.com>
 <20170302120546.GB17277@red-moon>
 <CAHp75VfoZTr5L3z5_SXW58W2Ate5nCWSzP8hAA051fVwizSjag@mail.gmail.com>
 <20170302192406.GA8519@wtj.duckdns.org>
MIME-Version: 1.0
In-Reply-To: <20170302192406.GA8519@wtj.duckdns.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jon Mason <jonmason@broadcom.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Ray Jui <rjui@broadcom.com>, John Garry <john.garry@huawei.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: multipart/mixed; boundary="===============6627134699467838173=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


--===============6627134699467838173==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 02:24:06PM -0500, Tejun Heo wrote:
> Hello,
>=20
> On Thu, Mar 02, 2017 at 02:50:00PM +0200, Andy Shevchenko wrote:
> > > I thought about that and did not do it because here we are remapping
> > > resources that are _not_ PCI bus resources (ie it is not PCI BARs we
> > > are remapping), keeping the devm_* prefix would be more consistent
> > > to the typical device drivers remapping functions pattern (ie a
> > > typical PCI host controller driver would mix devm_ and pcim_ calls
> > > which is a bit hard to parse), that was my rationale.
> > >
> > > I am not too fussed about that either way, I am happy to update it to
> > > pcim_* though, it is Bjorn/Arnd's decision.
> >=20
> > I would vote for pcim_*() variant.
>=20
> Me too, for brevity.

devm_* is equally brief. Also, all existing pcim_*() functions take a
struct pci_dev * as their first argument, because they operate on the
PCI devices. However in this case the devm_pci_remap_*() functions do
not operate on PCI devices. Rather they operate on the struct device
that represents the PCI host bridge. Therefore I think devm_ is more
appropriate here.

Thierry

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAli4e50ACgkQ3SOs138+
s6GNuA//fAb3QI6abNRkCmASOctClqDiO1meyvngmoqLymMYTyIhT4iuVWlXmUHu
QESNy10gY57D8xhjFKNemzp18/GuY0BTZClWBzJHjSits4rH2qGD/x4LOpfxrHbm
NRf+Yh/C4NLeGYFl04ds3MtbSh5MPuf3XmbR7IzMSKxvBSO90SBw9q3GjKb2Eokr
7LV0I5qFEiwiRvgBYFj6vjU5DA9Fg5Is5msK7psHMLh5t6Dy9skHWgB2wRnzsuOc
91uplo72htr9puZ4EBNirOOb5dYEILAoPkSPJiFut/09GYV+Ywxp7rmgfvp+N/M+
7YQcRvcGQFP4KhMz5EmCcZH7BFRtZ3sbHVqFf5F0nFkfPhQG+zJgWEjP8v8r5EYE
2iNp3Cq0Sa+AkIsyHKmBqwcqLmFkjZesgyvvtoSa/ByvQpGLY5hpTGlKvUjLozyB
aJ1EG/g3QaHPOd1hYPj08cbl48t+g+m+Pcq1CfORvTQhXnOB6z+PzEqUnnfBcvrj
yybtp7EGx6+7SpOFcomi4Fl337XQOJF4fH/KipX+sYHib+fP65WLBTQXajf8pgQ8
J0KYqrL164+geCiaZSazoSTMSoGS2KGvU75xjTxTyQ0kuthtrTAZEFDxgfwiRmpK
wHrxAnQvr9v68FZXihw//W+uMzSmgY8w0jK6L7ptGJUt4fGkByI=
=3s6b
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--


--===============6627134699467838173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6627134699467838173==--
