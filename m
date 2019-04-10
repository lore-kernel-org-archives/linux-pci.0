Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC74C10F14
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 22:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9223720645
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 22:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfDJWED (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:04:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:11254 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDJWED (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 18:04:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 15:04:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,334,1549958400"; 
   d="p7s'?scan'208";a="163200774"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2019 15:04:01 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.167]) with mapi id 14.03.0415.000;
 Wed, 10 Apr 2019 15:04:01 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "mingo@kernel.org" <mingo@kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 2/2] x86/pci: Clean up usage of X86_DEV_DMA_OPS
Thread-Topic: [PATCH 2/2] x86/pci: Clean up usage of X86_DEV_DMA_OPS
Thread-Index: AQHU73PVlfD6CeGreEGOC3obJdahu6Y1gciAgADh9YCAAAU5gA==
Date:   Wed, 10 Apr 2019 22:03:59 +0000
Message-ID: <af8787f3bdd8f48e568ce421030b2b4415d79678.camel@intel.com>
References: <20190410080220.21705-1-hch@lst.de>
         <20190410080220.21705-3-hch@lst.de> <20190410081617.GA54229@gmail.com>
         <20190410214500.GK256045@google.com>
In-Reply-To: <20190410214500.GK256045@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.7.162]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-/z1VEyz5xNWnpBvJvX2X"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--=-/z1VEyz5xNWnpBvJvX2X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-04-10 at 16:45 -0500, Bjorn Helgaas wrote:
> [+cc Keith, Jonathan (VMD guys)]
>=20
> I'm OK with this from a PCI perspective.  It would be nice if
>=20
>   dma_domain_list
>   dma_domain_list_lock
>   add_dma_domain()
>   del_dma_domain()
>   set_dma_domain_ops()
>=20
> could all be moved to vmd.c, since they're really only used there.
>=20
> But we don't really have a good way to call host bridge-specific code
> like set_dma_domain_ops() except via pcibios_add_device().  Someday
> maybe pcibios_add_device() will become a host bridge method.
I think these could have been contained to vmd.c with the host bridge
add_device callback [1] but I can't seem to find whatever came about
that discussion

[1] https://marc.info/?l=3Dlinux-pci&m=3D153337765811720&w=3D2



Either way, this looks fine
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>


>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
>=20
> On Wed, Apr 10, 2019 at 10:16:17AM +0200, Ingo Molnar wrote:
> > (+Cc. Patch quoted below. Acked-by from an x86 perspective.)
> >=20
> > * Christoph Hellwig <hch@lst.de> wrote:
> >=20
> > > We have supported per-device dma_map_ops in generic code for a
> > > long
> > > time, and this symbol just guards the inclusion of the
> > > dma_map_ops
> > > registry used for vmd.  Stop enabling it for anything but vmd.
> > >=20
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/x86/Kconfig               | 3 ---
> > >  drivers/misc/mic/Kconfig       | 4 ++--
> > >  drivers/pci/controller/Kconfig | 1 +
> > >  drivers/pci/controller/vmd.c   | 7 -------
> > >  4 files changed, 3 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 38c62ff8a3f0..d8e2e6519a61 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -28,7 +28,6 @@ config X86_64
> > >  	select MODULES_USE_ELF_RELA
> > >  	select NEED_DMA_MAP_STATE
> > >  	select SWIOTLB
> > > -	select X86_DEV_DMA_OPS
> > >  	select ARCH_HAS_SYSCALL_WRAPPER
> > > =20
> > >  #
> > > @@ -703,7 +702,6 @@ config STA2X11
> > >  	bool "STA2X11 Companion Chip Support"
> > >  	depends on X86_32_NON_STANDARD && PCI
> > >  	select ARCH_HAS_PHYS_TO_DMA
> > > -	select X86_DEV_DMA_OPS
> > >  	select SWIOTLB
> > >  	select MFD_STA2X11
> > >  	select GPIOLIB
> > > @@ -2877,7 +2875,6 @@ config HAVE_ATOMIC_IOMAP
> > > =20
> > >  config X86_DEV_DMA_OPS
> > >  	bool
> > > -	depends on X86_64 || STA2X11
> > > =20
> > >  config HAVE_GENERIC_GUP
> > >  	def_bool y
> > > diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
> > > index 242dcee14689..6736f72cc14a 100644
> > > --- a/drivers/misc/mic/Kconfig
> > > +++ b/drivers/misc/mic/Kconfig
> > > @@ -4,7 +4,7 @@ comment "Intel MIC Bus Driver"
> > > =20
> > >  config INTEL_MIC_BUS
> > >  	tristate "Intel MIC Bus Driver"
> > > -	depends on 64BIT && PCI && X86 && X86_DEV_DMA_OPS
> > > +	depends on 64BIT && PCI && X86
> > >  	help
> > >  	  This option is selected by any driver which registers a
> > >  	  device or driver on the MIC Bus, such as
> > > CONFIG_INTEL_MIC_HOST,
> > > @@ -21,7 +21,7 @@ comment "SCIF Bus Driver"
> > > =20
> > >  config SCIF_BUS
> > >  	tristate "SCIF Bus Driver"
> > > -	depends on 64BIT && PCI && X86 && X86_DEV_DMA_OPS
> > > +	depends on 64BIT && PCI && X86
> > >  	help
> > >  	  This option is selected by any driver which registers a
> > >  	  device or driver on the SCIF Bus, such as
> > > CONFIG_INTEL_MIC_HOST
> > > diff --git a/drivers/pci/controller/Kconfig
> > > b/drivers/pci/controller/Kconfig
> > > index 6012f3059acd..011c57cae4b0 100644
> > > --- a/drivers/pci/controller/Kconfig
> > > +++ b/drivers/pci/controller/Kconfig
> > > @@ -267,6 +267,7 @@ config PCIE_TANGO_SMP8759
> > > =20
> > >  config VMD
> > >  	depends on PCI_MSI && X86_64 && SRCU
> > > +	select X86_DEV_DMA_OPS
> > >  	tristate "Intel Volume Management Device Driver"
> > >  	---help---
> > >  	  Adds support for the Intel Volume Management Device (VMD).
> > > VMD is a
> > > diff --git a/drivers/pci/controller/vmd.c
> > > b/drivers/pci/controller/vmd.c
> > > index cf6816b55b5e..999a5509e57e 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -95,10 +95,8 @@ struct vmd_dev {
> > >  	struct irq_domain	*irq_domain;
> > >  	struct pci_bus		*bus;
> > > =20
> > > -#ifdef CONFIG_X86_DEV_DMA_OPS
> > >  	struct dma_map_ops	dma_ops;
> > >  	struct dma_domain	dma_domain;
> > > -#endif
> > >  };
> > > =20
> > >  static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> > > @@ -293,7 +291,6 @@ static struct msi_domain_info
> > > vmd_msi_domain_info =3D {
> > >  	.chip		=3D &vmd_msi_controller,
> > >  };
> > > =20
> > > -#ifdef CONFIG_X86_DEV_DMA_OPS
> > >  /*
> > >   * VMD replaces the requester ID with its own.  DMA mappings for
> > > devices in a
> > >   * VMD domain need to be mapped for the VMD, not the device
> > > requiring
> > > @@ -438,10 +435,6 @@ static void vmd_setup_dma_ops(struct vmd_dev
> > > *vmd)
> > >  	add_dma_domain(domain);
> > >  }
> > >  #undef ASSIGN_VMD_DMA_OPS
> > > -#else
> > > -static void vmd_teardown_dma_ops(struct vmd_dev *vmd) {}
> > > -static void vmd_setup_dma_ops(struct vmd_dev *vmd) {}
> > > -#endif
> > > =20
> > >  static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct
> > > pci_bus *bus,
> > >  				  unsigned int devfn, int reg, int len)
> > > --=20
> > > 2.20.1
> > >=20

--=-/z1VEyz5xNWnpBvJvX2X
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
PNauajAtxgRKfqfSMb+IcL/VXiPtVZOxVq+CTZeDJkaEmn/79vg8OYxpR+YhFF+tGlKf/Zc4id1P
AgMBAAGjggI3MIICMzAdBgNVHQ4EFgQU4oawcWXM1cPGdwGcIszDfjORVZAwHwYDVR0jBBgwFoAU
HmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5j
b20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENB
JTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRl
bC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIw
SXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20v
MAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9T
gpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsG
AQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBRBgNVHREESjBIoCoGCisGAQQB
gjcUAgOgHAwaam9uYXRoYW4uZGVycmlja0BpbnRlbC5jb22BGmpvbmF0aGFuLmRlcnJpY2tAaW50
ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQBxGkHe05DNpYel4b9WbbyQqD1G6y6YA6C93TjKULZi
p8+gO1LL096ixD44+frVm3jtXMikoadRHQJmBJdzsCywNE1KgtrYF0k4zRWr7a28nyfGgQe4UHHD
7ARyZFeGd7AKSQ1y4/LU57I2Aw2HKx9/PXavv1JXjjO2/bqTfnZDJTQmOQ0nvlO3/gvbbABxZHqz
NtfHZsQWS7s+Elk2xGUQ0Po2pMCQoaPo9R96mm+84UP9q3OvSqMoaZwfzoUeAx2wGJYl0h3S+ABr
CPVfCgq9qnmVCn5DyHWE3V/BRjJCoILLBLxAxnmSdH4pF6wJ6pYRLEw9qoyNhpzGUIJU/Lk1MYIC
FzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBD
bGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFs
IEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAMamAkocC+WQNPgAAAAAxqYwCQYFKw4DAhoFAKBdMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE5MDQxMDIyMDM0M1owIwYJ
KoZIhvcNAQkEMRYEFIpZydeQcMbgUhkmqpebqv6NakseMA0GCSqGSIb3DQEBAQUABIIBAI6dVy5+
9w/aI1dKBPEj/yuolDP1eBJjWb9daH3hFCyLS2BbRaBdLY1XWfbLYbEZOgz6LNkfsI4v25r/UxFU
UD6q3MY8lLeiQWdcqIYcSm/mDfnSBBFoDSm5DpXsPAchtlYgf0t/FBbJeXB/sDYot57berzYLueP
CB03Cd/PGQC22lRuD62Bp7KxWUHBJz4NKgEkUKgOHo8Hi5Sk5irQWTf/7esCOWXWVLWhndkaFZkr
E6mow/2kw+gL3dq7e//wdVjPItT5XHzCn2npCTgSKHTBlRb4qnaPOADKbLXIaEfRyFZWtlpnvrIU
ltkpCnvaw8ERcxUt1KqMghFXuuGJEhQAAAAAAAA=


--=-/z1VEyz5xNWnpBvJvX2X--
