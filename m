Received: from mail.m10.be (mail.m10.be [172.233.33.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29B367F23;
	Wed, 29 Apr 2026 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.233.33.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777461092; cv=none; b=l43+UtBtYu2YCtCqskXag7dD07BsYyJecjXTInq01VBZzyJ9hP3ggZP8JUhO/vZaLbzM1HrMfqzUnMbfU+ksxBoiWZGKVApWA9+Lwy/2q6b0pZ2SsAYFptooo2/bNHwN9bEmentNYk0yaKJncw/012DJVYo6QXvyyJdKqu5GuEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777461092; c=relaxed/simple;
	bh=rB+3ipuW/GxYlulVwETfIxoDZxdGXkdQx31DgVJgCdU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=edFawDbjnw8nxDUc5KQg7L7PDQbU0uBpGXy60u3SUonNvE1zLCTyhKimyGOpKh3xvKLubHMjqLt/n+v5+x1UhDybobFQVUAadZ4RmqFnQwItbrK7Do+WAXtVPSPQ1keV4+WFW6gKpev4KgkVGDMFGOrxUhte5g32LVvfDQRdAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=maxboone.com; spf=fail smtp.mailfrom=maxboone.com; dkim=temperror (0-bit key) header.d=maxboone.com header.i=@maxboone.com header.b=QpvVvG+z; arc=none smtp.client-ip=172.233.33.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=maxboone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=maxboone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=maxboone.com header.i=@maxboone.com header.b="QpvVvG+z"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1E8446877;
	Wed, 29 Apr 2026 13:11:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxboone.com;
	s=dkim; t=1777461087;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rB+3ipuW/GxYlulVwETfIxoDZxdGXkdQx31DgVJgCdU=;
	b=QpvVvG+zhkkUFPqb9kVbErSghCcTgaRBEHZD+kRxNKteK1WHlHktKiVUTv7/wVHOF0KtqB
	ewIrCjli0bK9ogfwNQQ3YFgqLqgoaIslrLYtuoFEp+6RBZ6RutGdZY0jw5N3F4ChJUCfJW
	+sqBYKaI/9Nr/c1k8lGL2c6G+rklq5OTxSlFVsbjFPFGo8wddvi/YKBk795m7L+5k72Bha
	gW2UyVCRSq3SqdL+DbUcNFjDz42w1mg63c7N8FSAJXlQ6juugGhiqJ+zLLpOMj0f6BYRJA
	jKuDNqFJ38TFqPorK2zCur5RTfqFke3F7alK8ElDSPw6t5IZv8FpULSUHYUrmQ==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v14 4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell
 allocation for new backends
From: Max Boone <contact@maxboone.com>
In-Reply-To: <afHQWdn2rmG4mAA4@ryzen>
Date: Wed, 29 Apr 2026 13:11:12 +0200
Cc: den@valinux.co.jp,
 mani@kernel.org,
 frank.li@nxp.com,
 allenbh@gmail.com,
 bhanuseshukumar@gmail.com,
 bhelgaas@google.com,
 dave.jiang@intel.com,
 jdmason@kudzu.us,
 jingoohan1@gmail.com,
 kishon@kernel.org,
 kwilczynski@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 lpieralisi@kernel.org,
 marco.crivellari@suse.com,
 mmaddireddy@nvidia.com,
 ntb@lists.linux.dev,
 robh@kernel.org,
 shinichiro.kawasaki@wdc.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BEB40AEB-7A22-4BED-AC00-E3C0CDE72510@maxboone.com>
References: <2F694A6C-23BA-4025-ACD7-2751595982CB@maxboone.com>
 <afHQWdn2rmG4mAA4@ryzen>
To: Niklas Cassel <cassel@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Last-TLS-Session-Version: TLSv1.2



> On Apr 29, 2026, at 11:33=E2=80=AFAM, Niklas Cassel =
<cassel@kernel.org> wrote:
>=20
> On Tue, Apr 28, 2026 at 10:36:15PM +0200, Max Boone wrote:
>>=20
>> I=E2=80=99m not very fond of keeping this implementation in the =
pci-ep-msi file,
>> as the platform MSI and this implementation are both iiuc specific to
>> the designware ep driver. Even more so because the MSI implementation
>> is enabled by config rather than through device tree.
>=20
> Why do you think that the current code with DOMAIN_BUS_PLATFORM_MSI is
> designware EPC specific?
>=20
> I don't see anything that is designware EPC specific.
>=20
> Sure, it relies on GIC ITS, but I don't see why non-designware EPCs =
can't
> use GIC ITS.

Good point - looking through the device trees I only saw the msi-map / =
platform
msi set for the imx95 and assumed designware was the only EPC supporting
this (also because the code uses that of-node specifically), but I =
indeed don=E2=80=99t see=20
a reason that other chips can=E2=80=99t use this.

I=E2=80=99m a bit confused on the configuration, fwiw it=E2=80=99s =
probably me being unfamiliar
with PCIe, but it doesn=E2=80=99t seem right to configure the MSI and =
eDMA DBs through
a kconfig option rather than inferring it from the device tree and/or =
having the EP
driver enable the capability and expose an operation to realize it.

On the other hand, that way, we would probably end up with identical DB
implementations in mutliple drivers.

>> Wouldn=E2=80=99t we want end-users to specify what kind of doorbell =
they want,
>> as it seems to be that a more specific doorbell BAR layout can be=20
>> programmed with eDMA, allowing native support for nvmet=E2=80=99s =
doorbell
>> BAR for example.
>=20
> I also wanted to use my designware based EPC for doorbells in =
nvmet-pci-epf,
> specifically the support that Koichiro added for inbound subrange =
mapping.
>=20
> However, most designware EPC have a strict alignment requirement
> (CX_ATU_MIN_REGION_SIZE), which is often 4k.
>=20
> This alignment requirement is there both on the PCI address (address =
within
> the BAR, and for the physical memory address (target address)).
>=20
> I thought that we could use the inbound subrange mapping and put the =
doorbells
> in a separate inbound iATU, so we could remove polling in the =
nvmet-pci-epf
> driver, just like they have done in the vNTB driver. However, it works =
in vNTB
> because they have a register telling exactly which BAR and offset in =
that BAR
> where the doorbells are.
> In the NVMe PCIe Transport specification, the offset for the start of =
the
> doorbells is fixed, at offset 0x1000 (4k) and the only thing you can =
change is
> the stride between the doorbells.
>=20
> Currently, a doorbell is a single 32-bit data, sure we could call
> pci_epf_alloc_doorbell() with ("number of I/O queues" + 1 (admin =
queue)) * 2
> (submission queue and completion queue).
>=20
> However, the address which we get from pci_epf_alloc_doorbell() might =
not be
> 4k aligned.
>=20
> We have the function pci_epf_align_inbound_addr() which can split this
> non-aligned address to a 4k aligned base + offset from that base.
>=20
> However, that would also require the host side driver to write to this =
offset
> from the start address. (See e.g. doorbell_offset in pci-epf-test.c).
>=20
> So, basically, with the current limitation that the doorbells must =
start at
> 0x1000, together with the fact that the doorbells returned from
> pci_epf_alloc_doorbell() might have an arbitrary alignment, I don't =
see how
> we could add support for doorbells in nvmet-pci-epf.
>=20
> If we could supply an alignment requirement to =
pci_epf_alloc_doorbell(),
> e.g. 4k, and the API is guaranteed to return an address that satisfies =
this
> alignment requirement, then we would be good.
>=20
> However, right now, we don't have such an API. We simple get an =
address
> somewhere within the GIC ITS MMIO region.

Check, thanks for the write-up, this is also what I=E2=80=99m looking to =
get working,
coindicentally on the RK3588. I had imagined that it would be possible =
to build
a sufficient API by passing in a base offset and stride for the doorbell =
allocation,=20
but an alignment param sounds better. Can we program the resulting =
doorbells
at an arbitrary offset in a BAR, or would we waste the first allocated
doorbell that=E2=80=99s going to be located at 0x0000 - 0x1000?

In any case, I think it would be preferable for users of the =
alloc_doorbell function
to pass in what kind of doorbell they want instead of using a fallback =
mechanism.
It seems to me that the alignment and possibly a larger amount of =
doorbells are
possible with the eDMA doorbell mechanism. Or am I misunderstanding eDMA
here and is that bounded by mapping / size / alignment of the GIC ITS?

>> Originally in a patchset by Frank Li the API that was proposed was =
more
>> generic, and the pci-epc-msi implementation was chosen because there
>> was only one implementation:
>> - https://lore.kernel.org/imx/20231019150441.GA7254@thinkpad/
>> - https://lore.kernel.org/imx/20231019172347.GC7254@thinkpad/
>>=20
>> I=E2=80=99d personally prefer to see an abstraction that is weaved =
into pci-epc-core
>> and pci-epf-core that can be implemented by drivers as they wish. =
While=20
>> still keeping the enum for different types.
>>=20
>> That also gives room to pull a poll-mode doorbell into the =
pci-epc-core,
>> which deduplicates that code from the nvmet and vntb epfs, and allows
>> other functions to use RC->EP doorbells without needing to bother =
with
>> writing the polling mechanism.
>=20
> Sounds like a good idea.

I=E2=80=99ll refactor my local branch and include this patchset and send =
it in with RFC,
will probably not work on this for another couple days though.

>> P.S. I=E2=80=99ve been working on a vfio-user based epc for =
development purposes
>> personally, and the last hurdle before I want to send it in for =
comments is=20
>> support for doorbells, and came across this patchset checking if =
there=E2=80=99s
>> any other activity in the space. Having an implementation-agnostic
>> doorbell API in the EPF/EPC core would be very helpful to me.
>=20
> I have looked at adding doorbell support to nvmet-pci-epf, but got =
stuck on
> pci_epf_alloc_doorbell() returning an address that is not 4k aligned.
>=20
> (Since the NVMe PCIe transport specification has the doorbells at a =
fixed
> location, we can't change that.)
>=20
> But if we could provide an "alignment" parameter to =
pci_epf_alloc_doorbell(),
> then I think it is possible.
>=20
> Sure, the GIC ITS MMIO area might be quite small, so it might not be =
able
> satisfy such a request. E.g. on rk3588, the its1 MMIO region is =
0x20000 (128k):
> =
https://github.com/torvalds/linux/blob/v7.1-rc1/arch/arm64/boot/dts/rockch=
ip/rk3588-base.dtsi#L2414

Hrm, I think I=E2=80=99m misunderstanding the eDMA mechanism that is =
proposed in this
patch. Is the fixed eDMA register block (e.g. BAR4 for the RK3588) =
translated to
a space in the GIC ITS MMIO area - or is restriction specifically on =
adding alignment
to the platform MSI doorbell implementation?

> However, I have not idea of how much of this region the GIC driver =
uses for
> actual registers, and how much of that region it can actually dedicate =
to
> doorbells.
>=20
>=20
> Kind regards,
> Niklas

