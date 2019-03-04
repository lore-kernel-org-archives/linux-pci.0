Return-Path: <SRS0=xyCL=RH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91516C43381
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 08:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E302208E4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 08:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kikSKC54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfCDIhI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:37:08 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10330 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfCDIhG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Mar 2019 03:37:06 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7ce3b10002>; Mon, 04 Mar 2019 00:37:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 04 Mar 2019 00:37:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 04 Mar 2019 00:37:04 -0800
Received: from localhost (10.124.1.5) by HQMAIL101.nvidia.com (172.20.187.10)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 Mar 2019 08:37:04
 +0000
Date:   Mon, 4 Mar 2019 09:37:00 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Vidya Sagar <vidyas@nvidia.com>
CC:     Lucas Stach <dev@lynxeye.de>, <bhelgaas@google.com>,
        <lorenzo.pieralisi@arm.com>, <swarren@nvidia.com>,
        <mperttunen@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>
Subject: Re: [PATCH] PCI: tegra: Do not allocate MSI target memory
Message-ID: <20190304083700.GA31309@ulmo>
References: <1551366004-32547-1-git-send-email-vidyas@nvidia.com>
 <247102e57e067d1477f3260bdeaa3ea011d0f3ed.camel@lynxeye.de>
 <8b6f53c4-ac39-40d6-0979-86137236f890@nvidia.com>
 <d0e83ca1648a3ec80c01bc5e6708286f9d891580.camel@lynxeye.de>
 <6ee0919a-504f-ae76-5995-a9eae505ef90@nvidia.com>
 <91fbda5d299b29d8516cfdd7c1f72a4b34797e82.camel@lynxeye.de>
 <6ae28571-0110-5122-ed2a-392bbb3edfda@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <6ae28571-0110-5122-ed2a-392bbb3edfda@nvidia.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551688625; bh=8qbfOdtGP8jdj+iSc+gvYOOrkS2mXw7/gWtSzjqOjrY=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:In-Reply-To:X-NVConfidentiality:User-Agent:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Disposition;
        b=kikSKC54Z9247x7tuxYTWYd6SdZDIv1cTIwvEwlkeqHV9yG8Uewvov/GBxvGrPXhK
         jE/OFXSxDAawmvOlj6ZTwwFUHpFuLdDRdcVDimts86LqDw+d96m8dyeGfrIDEUeixU
         d5m0FTnqjzhe981sVKZYvUYSkhuzAb74y+gko1FiCfwCTlajRZweiK2CcUp0vgXjvN
         bWwdbmg+O4wzjwhSQQnudIT4dqMzys+hQEhDDyRicbkxjceTHjylXGsTFNEElQNU1f
         mKZ2lSuftAbpX08MJEwW2HrqBrmeQCZEnI/JS4zSncDreqRl6yPEiWiX2AsS2o/ZwK
         diRM1aaYp4Tug==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2019 at 11:08:54AM +0530, Vidya Sagar wrote:
>=20
>=20
> On 3/2/2019 7:52 PM, Lucas Stach wrote:
> > Am Samstag, den 02.03.2019, 08:20 +0530 schrieb Vidya Sagar:
> > > On 3/1/2019 8:26 PM, Lucas Stach wrote:
> > > > Am Freitag, den 01.03.2019, 08:45 +0530 schrieb Vidya Sagar:
> > > > > On 3/1/2019 12:32 AM, Lucas Stach wrote:
> > > > > > Am Donnerstag, den 28.02.2019, 20:30 +0530 schrieb Vidya Sagar:
> > > > > > > The PCI host bridge found on Tegra SoCs doesn't require the M=
SI target
> > > > > > > address to be backed by physical system memory. Writes are in=
tercepted
> > > > > > > within the controller and never make it to the memory pointed=
 to.
> > > > > > >=20
> > > > > > > Since no actual system memory is required, remove the allocat=
ion of a
> > > > > > > single page and hardcode the MSI target address with a specia=
l address
> > > > > > > on a per-SoC basis. Ideally this would be an address to an MM=
IO memory
> > > > > > > region (such as where the controller's register are located).=
 However,
> > > > > > > those addresses don't work reliably across all Tegra generati=
ons. The
> > > > > > > only set of addresses that work consistently are those that p=
oint to
> > > > > > > external memory.
> > > > > > >=20
> > > > > > > This is not ideal, since those addresses could technically be=
 used for
> > > > > > > DMA and hence be confusing. However, the first page of extern=
al memory
> > > > > > > is unlikely to be used and special enough to avoid confusion.
> > > > > > So you are trading a slight memory waste of a single page again=
st a
> > > > > > sporadic (and probably hard to debug) DMA failure if any device=
 happens
> > > > > > to initiate DMA to the first page of physical memory? That does=
 not
> > > > > > sound like a good deal...
> > > > > >=20
> > > > > > Also why would the first page of external memory be unlikely to=
 be
> > > > > > used?
> > > > > >=20
> > > > > > Regards,
> > > > > > Lucas
> > > > > We are not wasting single page of memory here and if any device's=
 DMA is
> > > > > trying to access it, it will still go through. Its just that we a=
re using that
> > > > > same address for MSI (note that MSI writes don't go beyond PCIe I=
P as they get
> > > > > decoded at PCIe IP level itself and only an interrupt
> > > > > goes to CPU) and that might be a bit confusing as same address is=
 used
> > > > > as normal memory as well as MSI target address. Since there can n=
ever be any
> > > > > issue with this would you suggest to remove the last paragraph fr=
om commit
> > > > > description?
> > > > How does the core distinguish between a normal DMA memory write and=
 a
> > > > MSI? If I remember the PCIe spec correctly, there aren't any
> > > > differences between the two besides the target address.
> > > >=20
> > > > So if you now set a non-reserved region of memory to decode as a MS=
I at
> > > > the PCIe host controller level, wouldn't this lead to normal DMA
> > > > transactions to this address being wrongfully turned into an MSI and
> > > > the write not reaching the targeted location?
> > > >=20
> > > > Regards,
> > > > Lucas
> > > You are correct that core cannot distinguish between a normal DMA mem=
ory and
> > > MSI. In that case, the only way I see is to alloc memory using
> > > dma_alloc_coherent()
> > > and use the IOVA as the MSI target address. That way, a page gets
> > > reserved (in a way wasted
> > > also as the MSI writes don't really make it to RAM) and there won't be
> > > any address
> > > overlaps with normal DMA writes. I'll push a patch for it.
> > At that point it's no longer different from the current code, which
> > simply reserves a single page of memory and uses its address as the MSI
> > target address.
> But, I think there is still one issue with the current code base. Since w=
hat
> is used as
> MSI target address is the physical address equivalent of the memory page
> being reserved,
> there is a chance that some IOVA might become equal to this physical addr=
ess
> there by
> making PCIe IP to raise an MSI interrupt instead of forwarding the write =
to
> memory.
> Do you agree with this?

Yeah, I think we need to make sure that the MSI target address is in the
same address space as other memory allocated for PCI devices. If we
continue to use __get_free_pages() that means we'd have to manually set
up an IOMMU domain for the IOVA mapping of the MSI target address. That
is pretty tedious and would probably also conflict with code in PCI
device drivers that are presumably going to allocate memory using the
DMA API and hence could get a different domain or IOVA space than the
PCI controller itself.

There's also still an issue with 32-bit vs. 64-bit addressing, if I'm
not mistaken. I think we had meant to address that separately, but it
looks like we never did. Or perhaps I'm forgetting what conclusion we
had come to regarding that?

The original proposal to use a fixed address outside of system memory
could've fixed the conflicting address issue and the 32-bit vs. 64-bit
addressing problem, but it also wouldn't have worked for IOVA addresses
because the MSI target address could easily clash with an address from
the PCI IOVA space.

> > So in conclusion this change should just be dropped.

I think we need to do something, even if this change is perhaps not the
best approach in retrospect.

Perhaps as a first step we could try to solve the 32-bit vs. 64-bit
addressing issue in a separate patch and then think about the SMMU case
some more and then resolve that separately.

I'm not exactly sure how SMMU works for PCI on Tegra, but I thought it
was using a single IOVA space (or ASID in Tegra-speak) for anything PCI.
What I don't understand is how that works in conjunction with the memory
resource assignment code. If we enable SMMU for PCI, don't all of the
BARs become invalid? I suppose if only memory accesses upwards of the
PCI controller get translated through the SMMU, then the memory resource
assignments might stay valid. But we would also have to ensure that IOVA
allocations for PCI don't intersect with the PCI address ranges from
which BARs are allocated.

I've been working on a set of patches that address a similar problem for
display. The problem that I'm seeing is that if we enable IOMMU-backed
DMA API for display, then the IOMMU translation for display controllers
gets enabled very early on, a long time before the driver gets a chance
to program the hardware. The result is that if the bootloader has left
the display controller enabled, it will now read from memory that has no
IOVA mapping (the bootloader usually doesn't set up the SMMU). This is a
bit of a bug without DMA/IOMMU as well because the display controller is
reading memory that the kernel will at some point claim and write to.

There are two things we need to fix that: one is to make sure that the
kernel doesn't write to the memory currently being scanned out and the
other is to properly set up the SMMU before it is enabled, but without
requiring the kernel driver to be loaded.

The first I solved using reserved-memory regions. See the documentation
in Documentation/devicetree/bindings/reserved-memory/ for background on
what these are. The idea is to use a reserved memory region to prevent
the kernel from handing the framebuffer memory to the buddy allocator.
The second problem can be fixed by implementing "reserved regions"
support in the SMMU driver. I have an implementation for that ready and
it works fine in conjunction with some bootloader patches that make sure
the correct reserved memory regions are set up when the kernel boots.

While not exactly the same, I think the issue for PCI is conceptually
similar. It doesn't make much sense to add a reserved region for the PCI
apertures because they aren't part of system memory in the first place.
I'm not sure it would hurt, but it's possible that the reserved memory
code is not prepared to deal with memory regions outside of system
memory. However, I think what we want to do is establish reserved
regions in the PCI ASID that represents the PCI apertures. That way we
avoid ever programming PCI devices with DMA addresses that would point
back into PCI memory.

Thierry

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx846kACgkQ3SOs138+
s6G98g/9EdQNGBHVvgss9nNuYlUGuN9AKHarDHjwZ2wzHIOA/smRop7jOK71NCV8
+2Dl7Tx0pszplJrty90yMyJPvocgnxXOhc6SwVbsUsVlqh4db0g1mlAnhABqtMWE
yJnvbwuRDfZ/ie6CSi5cmySpCxNvT+azlSxYiGTaDbrAMQs7ijfrZEvnb3EQwHEr
AJWzAx8dIJc234NDopBnCzX+8aP0RIyJJyZBCyA2nnU9Ln1OBjoZZqbJeftABfDs
+zDjjOYjdzA6jnXUKrCmfkn1/LYn4iuUkijD1YS82Mo7FC2A/rC77412933p+CWS
499y5mQ5KifUJYaak6a0VpiqBwGnOvqwJW2Mwl1tOKepr0fQt3ETdGfSckYO9XU2
cE6Ae+r7MT7J5lPgxmW6qMAKX+iKyIE8FQemYqjxNPUzs/VhW8ljyX1+yhUiXylJ
ZqqFhM/WVQTcy1yygUM78UJJx+IiTmZsD03iJ4gnuKOmHQPiki5yvg+C9NDI3IRA
efW6NdKqRdSdZRGRgezTorAIZ9YrnvXCUgXeCBe/xBsnkmagL7zDzRyshBYZ5mOd
XGGuCxMfx1q4CmIAg33K9Eu/snB4VGzJGpdwB66myUHNJqd3QqpZ+hg+mgTCSxKd
4YrmDQh5TqzTA2e9o8UbwrxAQ7/TUALPb8uz299N4IVIA2Q/21U=
=5mGU
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
