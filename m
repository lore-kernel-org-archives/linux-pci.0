Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1D3409272
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584271; cv=pass; b=X7IVp2COespzH7anNHdz7MM2kq0TKOKqfCfvVhR1HLCENNxoVcfpm16vmI2DUrDqbZg1SeG8jmw4id3e1v7MAQi0CL5iU3M1EFngBnOpEti/v9YyhkU0OvsfpaiKWnOaM2uWcBGFK045VxYDtSxpJwkZjAgqxQuiSZVEvi7W30U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584271; c=relaxed/simple;
	bh=FWetYHTKU3plFs91yFZPvyCfOh01CzXliAvG6YxxB2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oa5ydVKSC0iuQ/xDrO1t0MwpXYoW7Yt/WH0+cLqxLrGwhiQSvbYJbyJb+AaEftUszXoZR5CwJk69pX/nmH5dYNP9+9aP8+Vr+hiEM4BE0vpviWahJ/FwXrNkXrwjwnh7o1L7bgYQvPgGgiSS9Vc0rlVUsaWo5Am9BxO2CP+ip+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjawJNAd; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjawJNAd"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848882fdb18so7886192b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 14:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784584269; cv=none;
        d=google.com; s=arc-20260327;
        b=AA7hK5Ko2OU7NJ0+rC9Cxs8nQEuFwCHyskV05GQnZ/ZnoMDCRrgr399rxAAzatR1qO
         pFDz/ercB6R5wc5oJcFH02RY/PY/glnIuG7XBseOpDwiMl4bWtLhpM9JGc67oWtn7fuG
         6xEb1FSW47ex9FxISr3H41CcRI540ZoD/wsq40h71TsbAUVxV2WaC2RvelnnzrNtUiFz
         mzsQ0qtpRbQuBMq+Z3gwo8h2NfFExEiCSDZQR7NrqOD5DMkISt2PEZDqQCx45XuFR2rD
         TNUsGc5yVnDtdvoSJrU8Fxgmvud2QmkiaMVD6U1K6PEPdZGz44a/ldlEH1m0GTdlEG0+
         ZO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bdKI9817I2WeOtdz9Fsw1SXm2Wjzy1v2qUyVdVHNzDU=;
        fh=cw3/xDU5jvNch3WrETw5vc+OIN+ZdHoMsWCfJEnRw2o=;
        b=Og48eOZvAIVzW0ASL+gFSDdLCKnf6R63bJm97gMHSqw6jLpXCKdHmSDRa7/WsIDtQW
         diPHDdZw0IYHfv6r54qf6KSCZe86VhYYNNR0LSLtVXoFFCDC6yDqKZ1IMjrksa2zvjCv
         3a5so6uieDzTouZOq8F6Y7esuRd1G1ExTZLvHHspYtqISIXSWlrK6ahAdCS4MKbec4QM
         aPC5NFS+ukkb8JpMF3YLaoC3eAvuxCekC+faNvBR4Vg7zT8DB7O/bg0feU3dqtp/KgAK
         XmjIo90Y2U5jFAahn4wO83HMSdM//g+ZKPqgBpyUQ7ZKhsGhSvm7Uzhxj+zvjm/4ULUm
         n+yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784584269; x=1785189069; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bdKI9817I2WeOtdz9Fsw1SXm2Wjzy1v2qUyVdVHNzDU=;
        b=WjawJNAdqcugnTKwxXUZ4ACIjQmP9/n0gIYP2U5eYHlWacJ6VaKb0aUxFhK/tGVaDQ
         Y+H78c8sMN++nrKOAHjLUhrtUFaFmZEZ0MGuTI+oL2/Dsq7d3SFT77wWuXgc2rU2vrLL
         ah05hnV9JF8EK8nSkI7ouqCVV1n1JbKWrsVh/U77bg0D+Px8row5+Oxd03HwB3XzHRkD
         73FmukO26nC/8PiSMALnHzkWMRANUK1tZnalvla6czJSQPbbdftaIx+8jFwsxNt1vwtJ
         mqGAFTykrGCDrPEwepdi6lE86WsLtmF6ygxQrG0f743qTlr+GyVbEu3YJ9/lKO4jpAP/
         mhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784584269; x=1785189069;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bdKI9817I2WeOtdz9Fsw1SXm2Wjzy1v2qUyVdVHNzDU=;
        b=iv2A1Pe2Ss6gazem1jkweI2ReFwxwOjT66CM10/MMaxo+PMY+QBwJtra2uh9eDzVrf
         N4uefsJoECG6KzNWBsKlVmKGPzPQ7x2yARy7TRhulwkHput1NZiNiHdI1SR6qWFduYKI
         +ygs11ooNNZ69ZnHdnrFgQZFx5aktW7Tr2BBnXhDhpEx/HGlC35ztrycC2st0agQy+T9
         Fz7TbbrWDpG+ytDr7Af6kBzzaFFG2m3E8GiX7HUAvA1IUlOzXrR1UvdIHS0zzCthSoyr
         5rtdZW7nmp0A2cZKvSHkALUUVgEMswGj5X7nKZ44tYqj8KW2aa4J6W/wrMt4ZYnuwaZc
         ZTWA==
X-Forwarded-Encrypted: i=1; AHgh+RocjmlxPlufx1jVNM9AtUvu4W+/zUKB5jhppwyY2vAFt0vPaDNlHmP7RTuh48cgTMLw2wVQtk/XREo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTqedSUdq2nNy8BKD+JyXf9vfMh2v589hVb1biJ+tlEIxkSvpR
	VJviIKEdEI2qnu8NcVaTGIphTFC7sc1DU6aWuAzsThpc6dGllasxVooyXvM+RgmcbxMvKgaEIGp
	96b283Y2ZhWt1ucrwW4oKGj43waIXySCfK5Q+P9di
X-Gm-Gg: AfdE7ckjSVVNh7sCX6VJLQ+nQBIrPF8yFox9GQNoavqULAp8fxJ0FbzMz0z/JCwn44w
	SyTgtjF7vuWE92L+DQ1sh7/WKgME8w6VeK8X1fDH4vhmDO5cuuDlKZN6DY7ZsATnZISBn9Ahpwc
	0Ox/whZJxt8eEySR0xusyAdJNb/XqmPRPkNbCpmQQtvgs5THHTYbGozynd8QfyPdZs1XKODzlvD
	dgtcaLIJmfBbsm0egSA84tZymU4TU1WdKyIuwZELn3EzwzQtBnif00qAF5ZFJgXLBhjE+2qKZWM
	gTULmRo=
X-Received: by 2002:a05:6a21:b94:b0:3bc:5284:5445 with SMTP id
 adf61e73a8af0-3c3ad7d7fc8mr17622851637.21.1784584268526; Mon, 20 Jul 2026
 14:51:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715174737.15287-1-matt@ozlabs.org> <CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
 <65ba06e7-4c54-437d-9fbd-632c0468f66d@ozlabs.org> <allLypOmtbnPrgbw@google.com>
 <cc59a80f-afcc-4b2d-8e78-20f74c6b6871@ozlabs.org>
In-Reply-To: <cc59a80f-afcc-4b2d-8e78-20f74c6b6871@ozlabs.org>
From: David Matlack <dmatlack@google.com>
Date: Mon, 20 Jul 2026 14:50:41 -0700
X-Gm-Features: AUfX_mwkLBrmrzOblowqnnWuP3v7QICLsI9pjWJDYOH2ogP4CV4E0O_pKuQFz1Y
Message-ID: <CALzav=cGtmkBBpfUA8nP7AQ3azB_Hn7_8jJL=J+E+h61CpOFrw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>, 
	Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 10:12=E2=80=AFAM Matt Evans <matt@ozlabs.org> wrote=
:
>
> Hi David,
>
> On 16/07/2026 22:23, David Matlack wrote:
> > On 2026-07-16 03:51 PM, Matt Evans wrote:
> >> Hi David,
> >>
> >> On 15/07/2026 19:12, David Matlack wrote:
> >>> On Wed, Jul 15, 2026 at 10:47=E2=80=AFAM Matt Evans <matt@ozlabs.org>=
 wrote:
> >>>
> >>>> This is based on v7.2-rc3.
> >>>>
> >>>> These commits are on GitHub for easier browsing, along with
> >>>> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":
> >>>>
> >>>> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-dma=
buf-mmap-v5
> >>>
> >>> It'd be great to have this test upstream. I'm happy to review it when
> >>> you're ready. Looks like it just needs to be redone to use the VFIO
> >>> selftests library and kselftests harness. AI could probably do the
> >>> conversion pretty quick :)
> >>
> >> For sure, I'd intended to catch up with you on best approach here. :)
> >>
> >> Aside from the organic structure of the test (the open-coded VFIO
> >> device/group setup/init needs to go), the main issue is that it relies
> >> on a hacked/out of tree QEMU "EDU++" device with a second larger BAR
> >> (containing freely read-writable memory).  A subset of tests run with
> >> the in-tree EDU device, but coverage is too low.
> >>
> >> The desirable properties are:
> >>
> >>  - Having a BAR that is pure memory (all locations present, writable
> >> without disruptive side-effects) so that mapping aliases can be
> >> constructed and detected.  This is good to test things like non-zero
> >> vm_pgoffs and VA space presentation of physically-discontiguous DMABUF=
s.
> >>
> >>  - BAR >> hugepage size so we can eyeball huge mappings work (or bette=
r,
> >>  mechanically test for them).  At least 32MB would tick this box for 4=
K,
> >> 16K page systems.
> >>
> >>  - Something QEMU supports*, so one can run the test in a VM/TCG syste=
m.
> >>
> >> There were some real device models in QEMU that could be used this way=
,
> >> but needed a fair bit of setup;  I didn't want to rathole
> >> vfio_dmabuf_mmap_test on including a ton of device-specific code for
> >> some video card or similar.
> >>
> >> I'll dig more for a simple target that provides these properties --
> >> obviously it would be better to point this test at an off-the-shelf
> >> device (including silicon!).  And, proposing EDU extensions to the QEM=
U
> >> folks may be useful (there're uses for a better EDU in other contexts =
too).
> >>
> >> Since this test uses MMIO for a specific [class of] function, my first
> >> thought is it should be another VFIO driver-type test sibling of
> >> vfio_pci_driver_test.  For example, we could extend the driver-type
> >> tests' backend struct vfio_pci_driver_ops for functions capable of
> >> providing a Big Memory BAR, like QEMU EDU++.  EDU can also memcpy, so
> >> could also support vfio_pci_driver_test.
> >>
> >> The spirit of the device backends hiding setup of a complex device is
> >> handy, and it's plausible that several backends could provide this "bi=
g
> >> memory BAR" service.  What do you think, any concerns with extending
> >> vfio_pci_driver_ops like that?
> >
> > I wouldn't recommend leveraging the driver framework unless absolutely
> > necessary. It makes the test harder to run.
> >
> > The biggest issue I see with the proposed properties is being able to
> > treat the BAR as memory. That obviously will depend on the device and
> > may require device-specific setup. If we decide that treating the BAR a=
s
> > memory is truly required then using the driver framework is the way to
> > go. But I'm hoping we can avoid that requirement.
> >
> > Instead, I think you can get pretty far by inspecting /proc/pid/pagemap
> > to determine if the mmap() set things up correctly, without actually
> > accessing the BAR. You can use /proc/pid/pagemap to look up the PFN and
> > PAGEMAP_SCAN to detect huge pages.
>
> Hmm, possible, although that's quite a different test at that point.  I
> agree never touching the device has advantages, but it's harder to test
> certain things if we _never_ do MMIO.  The mitigation effort to get
> coverage may not be the right tradeoff vs easier running.  I can think
> of some "easy" VFIO bugs that would be challenging to properly verify in
> userspace (e.g. PFNs all having some undesired offset).  The current
> test method is harder to fool per unit effort in writing it.
>
> Though, I will have a think about this no-touch flavour of test.
>
> What were you picturing regarding populating the VMA PTEs in order to
> inspect the result via /proc/pid/pagemap, whilst still upholding the
> principle of not touching the device?  For example,
> madvise(MADV_POPULATE_WRITE) won't work on the VFIO BAR regions because
> they're VM_PFNMAP/VM_IO.

You're right it looks like it's not possible to fault in the VMA
without reading or writing to the mapping. We could use reads, but I'm
not sure that's safe for all devices.

> > With that requirement gone, then all you really need is a device with a
> > large enough BAR. And even that it not a hard requirement. I'm sure
> > there are plenty of test cases that could work with smaller BARs. The
> > few tests that want to exercise huge mappings can inspect the device BA=
R
> > sizes first, and if they're all too small, SKIP() the test.
> >
> > If you structure the test this way, then it's easy for the test to be
> > used. It can be run against any device for the basic functional
> > coverage, and can be run against a device with a larger BAR for full
> > coverage of huge mappings.
> >
> > Does QEMU emulate any devices that have 32MB or larger BARs?
>
> Yep, looks like `-device pci-testdev,membar=3D64M,membar-backed=3Don` or
> even `-device bochs-display,vgamem=3D64M` would be suitable.
>
> So I'll also try moving the existing test over to one of these to at
> least remove the EDU++ device dependency.  (bochs-display has >1 BAR,
> and some MMIO regs which are nice for a quick kick-the-tyres access test.=
)

This seems like a good compromise.

I would suggest making the test as device-agnostic as possible so
other devices can be more easily added in the future. For example, add
a helper function to detect known "pure memory" BARs, so all
device-specific detection and setup logic can live there. We can put
that in the test .c file for now and move it to the library
if-and-when another test wants to use it. It probably makes sense to
merge this with the driver framework but I think I need to see more of
what's involved to really make a call.
