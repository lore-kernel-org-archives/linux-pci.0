Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0061.outbound.protection.outlook.com ([104.47.41.61]:33472
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755435AbdCWOaK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Mar 2017 10:30:10 -0400
From: "Sagalovitch, Serguei" <Serguei.Sagalovitch@amd.com>
To: "Zhang, Jerry" <Jerry.Zhang@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple@vodafone.de>
CC: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Ayyappa Ch <ayyappa.ch.linux@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: resize VRAM BAR for CPU access
Date: Thu, 23 Mar 2017 14:30:06 +0000
Message-ID: <MWHPR12MB115280D45EBF8E0647805BD7FE3F0@MWHPR12MB1152.namprd12.prod.outlook.com>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-5-git-send-email-deathsimple@vodafone.de>
 <CAPyr0yLWiGzU5ihFcj_NmA2Vk2R7GsKqo2LK8o3Eu+Df9m7vhw@mail.gmail.com>
 <6fac05e4-26ae-e959-9af6-cb68a04a1110@vodafone.de>
 <MWHPR1201MB0206CA2E6DAC3B83ACA52ADBB4270@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <17c470c4-d406-b5ac-73d1-4dd5b83cfca8@vodafone.de>
 <DM5PR12MB18188AF745E7FB6B021E6600FF260@DM5PR12MB1818.namprd12.prod.outlook.com>
 <CADnq5_NzFTWEB8NXT6LM9U=JfexpbZxQCyja1VqZv+NYMCmJwQ@mail.gmail.com>,<DM5PR12MB1818E21F5F5456B2041B3817FF260@DM5PR12MB1818.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1818E21F5F5456B2041B3817FF260@DM5PR12MB1818.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Christian,

- Are we going to support resizing BAR when kernel=20
modesetting  is not enabled and we are running in console=20
under VBIOS control (VESA/VGA)?=20

- Should we restore PCI configuration if amdgpu
will be unloaded?

- In function amdgpu_resize_bar0():
  If resizing for "max" size failed should we try other=20
sizes? What do you think?


Sincerely yours,
Serguei Sagalovitch


From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Zhang, J=
erry <Jerry.Zhang@amd.com>
Sent: March 15, 2017 10:41 PM
To: Alex Deucher
Cc: Zhou, David(ChunMing); Ayyappa Ch; linux-pci@vger.kernel.org; linux-ker=
nel@vger.kernel.org; dri-devel@lists.freedesktop.org; platform-driver-x86@v=
ger.kernel.org; Christian K=F6nig; helgaas@kernel.org; amd-gfx@lists.freede=
sktop.org
Subject: RE: [PATCH 4/4] drm/amdgpu: resize VRAM BAR for CPU access
=A0  =20
Thanks for your info.
I see.

Regards,
Jerry (Junwei Zhang)

Linux Base Graphics
SRDC Software Development
_____________________________________


> -----Original Message-----
> From: Alex Deucher [mailto:alexdeucher@gmail.com]
> Sent: Thursday, March 16, 2017 10:25
> To: Zhang, Jerry
> Cc: Christian K=F6nig; Zhou, David(ChunMing); Ayyappa Ch; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org; dri-
> devel@lists.freedesktop.org; platform-driver-x86@vger.kernel.org;
> helgaas@kernel.org; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 4/4] drm/amdgpu: resize VRAM BAR for CPU access
>=20
> On Wed, Mar 15, 2017 at 10:19 PM, Zhang, Jerry <Jerry.Zhang@amd.com> wrot=
e:
> >> -----Original Message-----
> >> From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On
> >> Behalf Of Christian K?nig
> >> Sent: Wednesday, March 15, 2017 17:29
> >> To: Zhou, David(ChunMing); Ayyappa Ch
> >> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; amd-
> >> gfx@lists.freedesktop.org; platform-driver-x86@vger.kernel.org;
> >> helgaas@kernel.org; dri-devel@lists.freedesktop.org
> >> Subject: Re: [PATCH 4/4] drm/amdgpu: resize VRAM BAR for CPU access
> >>
> >> Yes, exactly that.
> >
> > (I'm not familiar with PCI too much.)
> > Is there any restrict for PCI device?
> > I'm concerning if any PCI couldn't support it on some motherboard.
>=20
> It depends on the PCI root bridge.=A0 This patch set only implements supp=
ort for
> AMD root bridges.=A0 Intel and other vendors would need similar code.
>=20
> Alex
>=20
> >
> >>
> >> Christian.
> >>
> >> Am 15.03.2017 um 09:25 schrieb Zhou, David(ChunMing):
> >> > Does that means we don't need invisible vram later?
> >> >
> >> > David
> >> >
> >> > -----Original Message-----
> >> > From: dri-devel [mailto:dri-devel-bounces@lists.freedesktop.org] On
> >> > Behalf Of Christian K?nig
> >> > Sent: Wednesday, March 15, 2017 3:38 PM
> >> > To: Ayyappa Ch <ayyappa.ch.linux@gmail.com>
> >> > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> > amd-gfx@lists.freedesktop.org; platform-driver-x86@vger.kernel.org;
> >> > helgaas@kernel.org; dri-devel@lists.freedesktop.org
> >> > Subject: Re: [PATCH 4/4] drm/amdgpu: resize VRAM BAR for CPU access
> >> >
> >> > Carizzo is an APU and resizing BARs isn't needed nor supported there=
.
> >> > The CPU can access the full stolen VRAM directly on that hardware.
> >> >
> >> > As far as I know ASICs with support for this are Tonga, Fiji and all=
 Polaris
> variants.
> >> >
> >> > Christian.
> >> >
> >> > Am 15.03.2017 um 08:23 schrieb Ayyappa Ch:
> >> >> Is it possible on Carrizo asics? Or only supports on newer asics?
> >> >>
> >> >> On Mon, Mar 13, 2017 at 6:11 PM, Christian K=F6nig
> >> >> <deathsimple@vodafone.de> wrote:
> >> >>> From: Christian K=F6nig <christian.koenig@amd.com>
> >> >>>
> >> >>> Try to resize BAR0 to let CPU access all of VRAM.
> >> >>>
> >> >>> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> >> >>> ---
> >> >>>=A0=A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu.h=A0=A0=A0=A0=A0=A0=A0 =
|=A0 1 +
> >> >>>=A0=A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 29
> >> +++++++++++++++++++++++++++++
> >> >>>=A0=A0=A0 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c=A0=A0=A0=A0=A0 |=A0=
 8 +++++---
> >> >>>=A0=A0=A0 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c=A0=A0=A0=A0=A0 |=A0=
 8 +++++---
> >> >>>=A0=A0=A0 4 files changed, 40 insertions(+), 6 deletions(-)
> >> >>>
> >> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> >>> index 3b81ded..905ded9 100644
> >> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> >>> @@ -1719,6 +1719,7 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct
> >> amdgpu_device *adev, struct ttm_tt *ttm,
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct ttm_mem_reg *mem);
> >> >>>=A0=A0=A0 void amdgpu_vram_location(struct amdgpu_device *adev, str=
uct
> >> amdgpu_mc *mc, u64 base);
> >> >>>=A0=A0=A0 void amdgpu_gtt_location(struct amdgpu_device *adev, stru=
ct
> >> >>> amdgpu_mc *mc);
> >> >>> +void amdgpu_resize_bar0(struct amdgpu_device *adev);
> >> >>>=A0=A0=A0 void amdgpu_ttm_set_active_vram_size(struct amdgpu_device
> >> >>> *adev,
> >> u64 size);
> >> >>>=A0=A0=A0 int amdgpu_ttm_init(struct amdgpu_device *adev);
> >> >>>=A0=A0=A0 void amdgpu_ttm_fini(struct amdgpu_device *adev); diff --=
git
> >> >>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> >>> index 118f4e6..92955fe 100644
> >> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> >>> @@ -692,6 +692,35 @@ void amdgpu_gtt_location(struct
> >> >>> amdgpu_device
> >> *adev, struct amdgpu_mc *mc)
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 mc->gtt_size >> 20, mc->gtt_start, mc->gtt_end);
> >> >>>=A0=A0=A0 }
> >> >>>
> >> >>> +/**
> >> >>> + * amdgpu_resize_bar0 - try to resize BAR0
> >> >>> + *
> >> >>> + * @adev: amdgpu_device pointer
> >> >>> + *
> >> >>> + * Try to resize BAR0 to make all VRAM CPU accessible.
> >> >>> + */
> >> >>> +void amdgpu_resize_bar0(struct amdgpu_device *adev) {
> >> >>> +=A0=A0=A0=A0=A0=A0 u32 size =3D max(ilog2(adev->mc.real_vram_size=
 - 1) + 1, 20) - 20;
> >> >>> +=A0=A0=A0=A0=A0=A0 int r;
> >> >>> +
> >> >>> +=A0=A0=A0=A0=A0=A0 r =3D pci_resize_resource(adev->pdev, 0, size)=
;
> >> >>> +
> >> >>> +=A0=A0=A0=A0=A0=A0 if (r =3D=3D -ENOTSUPP) {
> >> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* The hardware don't =
support the extension. */
> >> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> >> >>> +
> >> >>> +=A0=A0=A0=A0=A0=A0 } else if (r =3D=3D -ENOSPC) {
> >> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_INFO("Not enoigh P=
CI address space for a large BAR.");
> >> >>> +=A0=A0=A0=A0=A0=A0 } else if (r) {
> >> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_ERROR("Problem res=
izing BAR0 (%d).", r);
> >> >>> +=A0=A0=A0=A0=A0=A0 }
> >> >>> +
> >> >>> +=A0=A0=A0=A0=A0=A0 /* Reinit the doorbell mapping, it is most lik=
ely moved as well */
> >> >>> +=A0=A0=A0=A0=A0=A0 amdgpu_doorbell_fini(adev);
> >> >>> +=A0=A0=A0=A0=A0=A0 BUG_ON(amdgpu_doorbell_init(adev));
> >> >>> +}
> >> >>> +
> >> >>>=A0=A0=A0 /*
> >> >>>=A0=A0=A0=A0 * GPU helpers function.
> >> >>>=A0=A0=A0=A0 */
> >> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> >> >>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> >> >>> index dc9b6d6..36a7aa5 100644
> >> >>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> >> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> >> >>> @@ -367,13 +367,15 @@ static int gmc_v7_0_mc_init(struct
> >> >>> amdgpu_device
> >> *adev)
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->mc.vram_width =3D numchan * ch=
ansize;
> >> >>> -=A0=A0=A0=A0=A0=A0 /* Could aper size report 0 ? */
> >> >>> -=A0=A0=A0=A0=A0=A0 adev->mc.aper_base =3D pci_resource_start(adev=
->pdev, 0);
> >> >>> -=A0=A0=A0=A0=A0=A0 adev->mc.aper_size =3D pci_resource_len(adev->=
pdev, 0);
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* size in MB on si */
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->mc.mc_vram_size =3D RREG32(mmC=
ONFIG_MEMSIZE) *
> >> >>> 1024ULL *
> >> 1024ULL;
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->mc.real_vram_size =3D RREG32(m=
mCONFIG_MEMSIZE) *
> >> >>> 1024ULL
> >> >>> * 1024ULL;
> >> >>>
> >> >>> +=A0=A0=A0=A0=A0=A0 if (!(adev->flags & AMD_IS_APU))
> >> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_resize_bar0(ade=
v);
> >> >>> +=A0=A0=A0=A0=A0=A0 adev->mc.aper_base =3D pci_resource_start(adev=
->pdev, 0);
> >> >>> +=A0=A0=A0=A0=A0=A0 adev->mc.aper_size =3D pci_resource_len(adev->=
pdev, 0);
> >> >>> +
> >> >>>=A0=A0=A0 #ifdef CONFIG_X86_64
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (adev->flags & AMD_IS_APU) {
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->mc.ape=
r_base =3D
> >> >>> ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22; diff --git
> >> >>> a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> >> >>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> >> >>> index c087b00..7761ad3 100644
> >> >>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> >> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> >> >>> @@ -459,13 +459,15 @@ static int gmc_v8_0_mc_init(struct
> >> >>> amdgpu_device
> >> *adev)
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->mc.vram_width =3D numchan * ch=
ansize;
> >> >>> -=A0=A0=A0=A0=A0=A0 /* Could aper size report 0 ? */
> >> >>> -=A0=A0=A0=A0=A0=A0 adev->mc.aper_base =3D pci_resource_start(adev=
->pdev, 0);
> >> >>> -=A0=A0=A0=A0=A0=A0 adev->mc.aper_size =3D pci_resource_len(adev->=
pdev, 0);
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* size in MB on si */
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->mc.mc_vram_size =3D RREG32(mmC=
ONFIG_MEMSIZE) *
> >> >>> 1024ULL *
> >> 1024ULL;
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->mc.real_vram_size =3D RREG32(m=
mCONFIG_MEMSIZE) *
> >> >>> 1024ULL
> >> >>> * 1024ULL;
> >> >>>
> >> >>> +=A0=A0=A0=A0=A0=A0 if (!(adev->flags & AMD_IS_APU))
> >> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_resize_bar0(ade=
v);
> >> >>> +=A0=A0=A0=A0=A0=A0 adev->mc.aper_base =3D pci_resource_start(adev=
->pdev, 0);
> >> >>> +=A0=A0=A0=A0=A0=A0 adev->mc.aper_size =3D pci_resource_len(adev->=
pdev, 0);
> >> >>> +
> >> >>>=A0=A0=A0 #ifdef CONFIG_X86_64
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (adev->flags & AMD_IS_APU) {
> >> >>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->mc.ape=
r_base =3D
> >> >>> ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
> >> >>> --
> >> >>> 2.7.4
> >> >>>
> >> >>> _______________________________________________
> >> >>> dri-devel mailing list
> >> >>> dri-devel@lists.freedesktop.org
> >> >>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >> >
> >> > _______________________________________________
> >> > dri-devel mailing list
> >> > dri-devel@lists.freedesktop.org
> >> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >> > _______________________________________________
> >> > amd-gfx mailing list
> >> > amd-gfx@lists.freedesktop.org
> >> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
    =
