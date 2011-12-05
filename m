Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from oproxy3-pub.bluehost.com ([69.89.21.8]:45424 "HELO
	oproxy3-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751455Ab1LEVe7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2011 16:34:59 -0500
Date: Mon, 5 Dec 2011 13:37:26 -0800
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-pci@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, prarit@redhat.com,
	brking@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 1/1] PCI:delay configuration of SRIOV capability
Message-ID: <20111205133726.0bea7383@jbarnes-desktop>
In-Reply-To: <20111106023357.GB2383@ram-ThinkPad-T61>
References: <20111006210320.GA14959@us.ibm.com>
	<CAErSpo7b_6_AaZXW9XBx5p3-0PZJk-1jeCork__KePdzCS89OA@mail.gmail.com>
	<1317970100.29415.305.camel@pasglop>
	<CAErSpo58okGsDW4dOK4i0g_RUejkuQa=iw2uQ5HAJJZCwFtsbw@mail.gmail.com>
	<20111007232516.GF2980@ram-ThinkPad-T61>
	<1318057168.29415.333.camel@pasglop>
	<20111008075353.GK2980@ram-ThinkPad-T61>
	<1318060793.29415.347.camel@pasglop>
	<20111102140325.004b9dad@jbarnes-desktop>
	<20111103013014.GB393@ram-ThinkPad-T61>
	<20111106023357.GB2383@ram-ThinkPad-T61>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/3zEsOp4Mb1fuJ=x7JDh=HoP"; protocol="application/pgp-signature"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--Sig_/3zEsOp4Mb1fuJ=x7JDh=HoP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Nov 2011 10:33:57 +0800
Ram Pai <linuxram@us.ibm.com> wrote:

>       The SRIOV capability, namely page size and total_vfs of a device are
>       configured during enumeration phase of the device.
>       This can potentially interfere with the PCI operations of the platf=
orm,
>       if the IOV capability of the device is not enabled.
>=20
>       The following patch postpones the configuration of the IOV capabili=
ty of the
>       device to a later point, when the IOV capability is explicitly enab=
led
>       by the device driver.
>=20
>       The patch is tested on x86 and power platform.
>=20
>       Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  drivers/pci/iov.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index b0446dd..c1a6f5c 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -346,6 +346,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_v=
irtfn)
>  			return rc;
>  	}
> =20
> +	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
> +
>  	iov->ctrl |=3D PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
>  	pci_block_user_cfg_access(dev);
>  	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
> @@ -451,7 +453,6 @@ static int sriov_init(struct pci_dev *dev, int pos)
> =20
>  found:
>  	pci_write_config_word(dev, pos + PCI_SRIOV_CTRL, ctrl);
> -	pci_write_config_word(dev, pos + PCI_SRIOV_NUM_VF, total);
>  	pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset);
>  	pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride);
>  	if (!offset || (total > 1 && !stride))
> @@ -464,7 +465,6 @@ found:
>  		return -EIO;
> =20
>  	pgsz &=3D ~(pgsz - 1);
> -	pci_write_config_dword(dev, pos + PCI_SRIOV_SYS_PGSIZE, pgsz);
> =20
>  	nres =3D 0;
>  	for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {

Ok applied to linux-next with Don's tested by.  Thanks guys.

--=20
Jesse Barnes, Intel Open Source Technology Center

--Sig_/3zEsOp4Mb1fuJ=x7JDh=HoP
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJO3TmWAAoJEIEoDkX4Qk9hMkcQAJLeLotihZ+HzWdkvx0l8dfW
VpYGQWaTnqnz20/VYUhi60WyeGyb3GZhM1d+oO3VRD4H7z/Uhl/aAwyv2SI/NvhN
T+tzT6wj/ImYpRXuJ7XFCnfDE0KlNCQfhvnpkT+u7ib9eFVE88b852GdtEYEblCP
CxnszP71Ks2K+U0LA4QWrI4IP1XpYj9bLQvzBRNhfVFS48HpzbCMp6kKSIsP4xld
8d0upT1f9zv/TMxf3BhpZJIwxyDR5rSeare8mVSANJ22NsbZQ5vQX6ySHL2VsTlk
ZOxZiFIeipAmMor+4IMM/pL7oIZrUQG8GTC4wey1llRsoSXcZQTepEpDRcrawEZQ
zgDkMHBNkGFSAfFkx52tHVcHQQs4hTn4PFgbA9tuUi7JTRFvzYzmMAExPh6+UKmO
++Uz1iN+VJDikPE8sNvQjh63TUV7PPr9oM/dqW7uq/fwncaQL2/tgNU8OfLrAFtI
jGJiwOlUVLmv015XYIOjKhiMSXvko44vXoJOJiX/5OeC0r97FKMy/7eBiCiFbtUa
2uS0U0MFOfImuVXvOuNYRWlATRVlxjqoi8+fD5VR2HDYj//wI7eLvJk2Y1XMv/7S
gKyIKf1ba+5awadrzxYU744NbzsKuCnVi41e7Lk1kGzQgY8x7dPKhp/7stco5o7q
qOKBdqebab1FpYHx53f1
=4JXK
-----END PGP SIGNATURE-----

--Sig_/3zEsOp4Mb1fuJ=x7JDh=HoP--
