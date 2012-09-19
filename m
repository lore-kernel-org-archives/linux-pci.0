Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30950 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab2ISH1v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 19 Sep 2012 03:27:51 -0400
Date: Wed, 19 Sep 2012 03:24:35 -0400
From: Chen Gong <gong.chen@linux.intel.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Huang Ying <ying.huang@intel.com>, jiang.liu@huawei.com,
	Hanjun Guo <guohanjun@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] fix aer_inject bug while doing pci hot-plug
Message-ID: <20120919072435.GB15513@gchen.bj.intel.com>
References: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
In-Reply-To: <1348022442-7816-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2012 at 10:40:36AM +0800, Yijing Wang wrote:
> Date: Wed, 19 Sep 2012 10:40:36 +0800
> From: Yijing Wang <wangyijing@huawei.com>
> To: Bjorn Helgaas <bhelgaas@google.com>, Huang Ying <ying.huang@intel.com=
>,
>  Chen Gong <gong.chen@linux.intel.com>
> CC: jiang.liu@huawei.com, Hanjun Guo <guohanjun@huawei.com>,
>  linux-pci@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>
> Subject: [PATCH 0/6] fix aer_inject bug while doing pci hot-plug
> X-Mailer: git-send-email 1.7.11.msysgit.1
>=20
> v2--->v3
> 1??find the pci_ops of nearest parent bus in patch 1;
> 2??introduce pci_bus_ops_get to avoid race condition window in aer_inject=
_exit;
> 3??scan the root bus for cleaning untracked pci_ops_aer instead of scan a=
ll pci bus as Huang Ying suggestion;
> 4??remove unused code pci_bus_ops_pop;
>=20
> Yijing Wang (6):
>   PCI/AER: fix pci_ops return NULL when hotplug a pci bus doing aer
>     error inject
>   PCI/AER: introduce pci_bus_ops_get() function to avoid a small race
>     condition window
>   PCI/AER: clean all untracked pci_ops_aer when rmmod aer_inject
>   PCI/AER: clean pci_bus_ops when related pci bus was removed
>   PCI/AER: introduce pci_bus_ops_free to free pci_bus_ops
>   PCI/AER: clean unused code pci_bus_ops_pop
>=20
>  drivers/pci/pcie/aer/aer_inject.c |  149 +++++++++++++++++++++++++++++++=
+-----
>  1 files changed, 131 insertions(+), 18 deletions(-)
>=20
After reviewing the whole patch series, I hava a feeling that you don't
desrcibe the whole usage model very clearly. I suggest you update the
description and express it more clearly and in detail, so other guys never =
touch
aer-inject can understand it well. You patch is good but it doesn't mean
others will like it because it is obscure to others never touching these co=
des.

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQWXMzAAoJEI01n1+kOSLH5l8P/2eJ9gZylWJ4yeJh36cJmtVC
DCnyLsEh2QAQIEVX0HfuKkvYosxNDKMjuRdckURtpEB1fdfua8teZFAZxte1XBZF
ou+BgQvo5jmeog6pKfDPShwq+AlsWi/9c+mgSg+hqbO+gnp+RuHPk63GwvZBzMFi
79w5gW8ZHlIrDC+cZB/4K0M0QD5psG0d0MXpNyAy+kLOoaElyWgPUowAUZSfFwWu
PmBESQNwIPmd00j5aFxmEEI6sOallkITiLahNUk8m9FE4N5Sm9C8xPNGmHpqKGV+
LtFjd9Ra/izbB0GcvQc7+fQYUjUDFNWrHx1VIjxAFKBxS1Sme3kdOjP9yvMLDSy5
pugzKbi7N61j0NVLmhTzDvPpHtWQriLL4NdbogfMNXf1QaNLnxciDst0fKPysqvX
b1tnQ4z0Yu0aqULpy/hVLwFQ4726q7xTv8IYmFqNbm53oaHlhbmk429ANy0wEYrE
PvOFwkZheNo488kv0gwy8ERj/GYkJd4BdoZx4OQRmpx682oQl558CzwoQLea1aXD
brjoa8jjvabWTqLBtxyNV+ZvwwcXyBVsnJXtK8gGPGsqiEuhQmA+xNvUWxvcFarV
6uqytUcy9xX/sp7qrfG7ctEUnry5yHmLnjTCfcwqsuLd4/E/E9Dbzpf8kTJDy6R6
cb7AUEvvDxWIOPgovj7/
=r9aF
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
