Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795136483;
	b=obEHlco+Zkb9WnznqZ+OfLwN7SlLTzWtovc9clsaOO2tdy2z2M4RrmGNC6WgiqgwvLgc
	 Kch93FC0idV66n4oJ+c6IEJYioCq7xdcKdCaO/CIm/inKRLAqFDYhEcbsImasOPwh6ZOh
	 I+uoeC182QCpEfplyYvdc4EJ/C2BDD5gcFmZLn+vzaNOrgj+KmUU4oKOrBYfYHrBdWxnW
	 UPykR90xx2nXbuFMWdiQWTx99CJMkrGx392dp+dxCeL/vFgvan+FMQtZ/41zyqfPC4OOo
	 AdXw4SkZjoa++f+qJE0yE82b4d2FC8prHVEbP4LfR02X+oztlDT9/Y7cwGRxuAkRmiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795136483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=tQwX2YSXjHFZhdcGcul9Os/DsNb3L2Z/dlwRM94y3qk=;
	b=nvwLRHHhW3dL13kdf3tVb+vj/ETtqvCGQoTuH5ON0HLPD6BEoFEGKDWqv68y4eG6KuVU
	 WTYZDMuB/1aEDuRJvuMdD0MekXKVoTpjvcgyK61/gqtGML5PHJaxVnjDjRrH4RDwsWHjx
	 9vPYPN0pnBwBBFh/i8lxsV8Tnqd2piSiXLGWu8dWtxjR+S+CP/2L7sFRFAKOCDjC45dk4
	 kj6FHfxap7g8/TEhtMycUz0nP3GsZ2xR+WADi0pVG3tXQjr2kVIXQYRDCraDg2ozdsLoq
	 iEuelXC/aFm+J3GYZi1skyt8RZRcc7BKVpPx6cNSV+HhuL606mFtYDt+jMgmhiSkyyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aB8MFpMM;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E0606A330
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 01:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 331E0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aB8MFpMM
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cddac941ed1so145737a12.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 17:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795136482; x=1795741282; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tQwX2YSXjHFZhdcGcul9Os/DsNb3L2Z/dlwRM94y3qk=;
        b=aB8MFpMMrxKiPFy6+JAlCebkuTAfB8STJ/MwS9WIwLqCpnefzKeDmhq5EVEBXBTAtk
         iZsFiOjSaZIDuUxvIML1Q/Pli5/DbL6gnCoGLgbUYawH5QdgI21J9H40Mcs3J1SkkOvI
         uWizmt1tDmGonLNXZ5YXlF2PsmUADiZT4OHccB3JI6LVrjbu/MATocrXjp79XyuUs34p
         GeFTzL2WyAVHxcYDZfAvaAkSSL4rOyfBbi+O8FFV0R2xboCacObeig/kcXV1qJPWJG1I
         K7A5+1J8wG+SXMXJhKIY8LO6D59Ticfnt/qzBmbcW/9Y7XR175kyxD2+3VefSFEg2uUQ
         J/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795136482; x=1795741282;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tQwX2YSXjHFZhdcGcul9Os/DsNb3L2Z/dlwRM94y3qk=;
        b=ybs8dZqp/+gVVUDffYvJHyaDnd3jZ9WnnRAywA17CR/0s1FOYmHHpu3Z7/1jC4CIOu
         bMjw/+HooS4AVYGZ0r8SAUYNluMDUYOtzS79CgVj2nXdCpSM8AaSLLrejsoBKWQtWxji
         KFl5iMwvV6F661/JTUdjuEC3mhXuNrZAAXg2pM7cJK4/SwP3GQfxNT3m+X+Yo/fYZHct
         f7KhLUi7wV5ARfiA5Q5ty1Q5iX17rzaEtHyYlcux42u6IkfMuEDRKK/JE4R4yGa0aern
         d3OBvt8LPNr0AglEl0A6hRkhvHMFS6Txozz1bQHMHh/sTKrAE1RivmUuFEe8Mnodtzon
         FvKA==
X-Forwarded-Encrypted: i=1; AL+hErFycMWnojmIhxxQL+Bv4uT6EhrWQejaYkVKEM37FdOx2NAOWSOs2PMW2WS6euw9i8fbaMfbCvRNWMw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rBIsMGhqmZMb25Jn08wKaQG6RpKMLFBAPQiZdsx6BYbb2Docv
	tEe662iJU9uzrT0m75hjVNo/lDaIRS1tro1je7S1XLVo8oNdaOMA4Jll5PXM5bcF1A==
X-Gm-Gg: AZFdTZetXBfk2aZAW0JzXxFtctAvDXKMWOicWZTjdhUZClpBfPDAUr2kPMKN9KZ2Sbn
	ItpK6FK62Gg8IwFN4Rlbkhov6j89ohGTiiX77gimdTtfVM0lf5OrxA8yYBMBTtHWxDHIoBKMcVt
	rceewwEt7SD3PoIfYZK8tIvHoQAzA3UaTOvL9J3ga8s5S7i8NSibqr142Ew4dV2oaEpwteoJIwk
	CJeBU9Ff3RRPMSe8GebRvbk9F5Qj2eSr688TVMpq5HaPAKSjaCCPW+RP0TZHOYY7VI2QlX/zp5f
	0dz+9tl6E3jasuAYFDnaEYhDctSBRHi5kdS45bVC37F9PDX+jeuS15teeaIWv9utPP2GyjEjtGF
	/t1AXMWdRgkZYBtwgbeEn8nlKDPKOgnvqWwRNmHF0+R4/8yIOM6qaol0Kyk18i8z7mVMbwyB4or
	nctPMsN4oDIRAsSctG/u0CCMuTIFlENc93eCQ3YUdiDH0vDIHBE37JW8tCkrkMjOD+mhAbnvbg2
	bc59g2FyFqFG916UZy3v28CziVaXs6Cxuv8RRVETSrd0tsplOqTsqCwoGaGFAdfg4KavyXNw3FU
	jAdyhq2PqNAIGADESvxKfz4ogEKYbrZwAqT1COWk5e6aG5Pyz32wX/kA0E9XlBdj
X-Received: by 2002:a17:90b:4b87:b0:3b4:a63:d55c with SMTP id 98e67ed59e1d1-3b41c93b17cmr965473a91.30.1795136481385;
        Thu, 19 Nov 2026 17:01:21 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm4865271a91.10.2026.11.19.17.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 17:01:20 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 17:01:19 -0800
Message-Id: <DMZMRTXS7OSC.M79XF39ZVEWE@google.com>
Cc: <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <dmatlack@google.com>, <graf@amazon.com>, <jacob.pan@linux.microsoft.com>,
 <jgg@nvidia.com>, <jgg@ziepe.ca>, <jrhilke@google.com>,
 <julianr@linux.ibm.com>, <kees@kernel.org>, <kevin.tian@intel.com>,
 <leon@kernel.org>, <leonro@nvidia.com>, <lukas@wunner.de>,
 <mattev@meta.com>, <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files
 after Live Update
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
In-Reply-To: <20261102153656.1431701-12-vipinsh@google.com>

On Mon Nov 2, 2026 at 7:36 AM PST, Vipin Sharma wrote:
> Enable userspace to retrieve preserved VFIO device files after a Live
> Update by implementing the retrieve() and finish() file handler
> callbacks.
>
> During retrieve():
>  * Validate the handed-over struct vfio_pci_core_device_ser header,
>    sizes, and flags.
> [...]

Please make the commit messages in this series easier to read. They are
mostly long bulleted lists of everything the code does, which is hard to
follow and largely repeats the diff. A commit message should explain, in
prose, what problem the patch solves and why it solves it this way, and
only call out details that a reviewer can't easily get from the code.
This applies to most of the patches in the series (e.g. PATCH 07 and
PATCH 13 too).

> Do not implement can_finish(): closing a retrieved LUO session invokes
> finish, and refusing can_finish() would leak the session and leave
> unclaimed devices running. Instead, finish() always completes:
>  * If the retrieved device was claimed by opening it via
>    VFIO_DEVICE_BIND_IOMMUFD (which consumes vdev->liveupdate_incoming;
>    subsequent patches replace the open-time reset with non-reset
>    take-over, reject opening incoming devices other than via retrieve(),
>    and protect incoming kept-running devices across runtime PM, dev_set
>    resets, and non-noiommu boots), finish() simply completes its PCI
>    Live Update participation.
>  * If the device was not claimed (never retrieved, retrieve() failed, or
>    retrieved but never bound via VFIO_DEVICE_BIND_IOMMUFD),
>    vfio_pci_core_liveupdate_reset() logs one pci_warn() naming the
>    device, clears PCI_COMMAND_MASTER, resets the function, and restores
>    the inherited pci_saved_state just as closing the device would. If
>    the device has a function reset but is not reset, e.g. because
>    pci_dev_trylock() contends with a concurrent driver unbind, latch
>    vdev->liveupdate_reset_pending so vfio_pci_core_unregister_device()
>    completes the function reset and state restoration via
>    vfio_pci_core_liveupdate_reset_locked() under the device lock held by
>    device_release_driver(). Opening the device after finish() resets it
>    like any open, so it drops the latch.
>  * If the device was not retrieved, look it up under pci_dev_lock(),
>    which waits for a vfio-pci probe in progress. If it is bound to
>    vfio-pci, finish it as above. If it has no driver, clear bus
>    mastering and reset it. Otherwise leave it to the bound driver.
>  * Call pci_liveupdate_finish() and kho_restore_free() on every path.

This is a lot of complexity for one commit, and it's hard to review. I'd
like to start with the simplest approach and build from there: implement
can_finish() and have it return false until the device is fully
retrieved, i.e. retrieved and taken over by VFIO_DEVICE_BIND_IOMMUFD.
Then finish() only needs to free the incoming state and call
pci_liveupdate_finish().

That gets rid of vfio_pci_core_liveupdate_reset(),
vfio_pci_core_liveupdate_reset_locked(),
vfio_pci_liveupdate_finish_lookup() and its bridge and device locking,
liveupdate_reset_pending, and most of the finish documentation. If you
want to handle the other scenarios (devices that are never retrieved or
never bound, devices bound to other drivers, unbind racing with finish),
please add them in separate commits on top, each with its own
justification.

As for closing the session leaking it and leaving unclaimed devices
running: that only happens if userspace closes the session without
taking over all of its devices, and leaving the device running with its
memory still preserved is safe. Resetting the device in that case is
something that can be added later.

It also has a nice side effect: LUO calls can_finish() on every file in
a session before finishing any of them, so a memfd in the same session
that the device DMAs into can't be finished before the device has been
taken over.

> +static int
> +vfio_pci_liveupdate_attach_incoming(struct vfio_pci_core_device *vdev,
> +				    struct vfio_pci_liveupdate_incoming *in)
> +{
> +	guard(mutex)(&vdev->vdev.dev_set->lock);
> +
> +	if (vdev->liveupdate_incoming || vdev->liveupdate_claimed ||
> +	    !pci_liveupdate_is_incoming(vdev->pdev))
> +		return -EBUSY;
> +
> +	vdev->liveupdate_incoming =3D in;
> +	return 0;
> +}

The pci_liveupdate_is_incoming() check here is redundant with the one in
vfio_pci_liveupdate_retrieve(). Nothing can clear it in between, since
only finish() should do that (see below) and LUO holds the session mutex
across both retrieve and finish.

The liveupdate_claimed check is redundant too: LUO only lets a token be
retrieved successfully once, PATCH 12 prevents opening an incoming
device any other way, and the liveupdate_incoming check already prevents
attaching twice.

> +	if (!pci_liveupdate_is_incoming(pdev) ||
> +	    ser->cfg_size !=3D pdev->cfg_size) {
> +		ret =3D -EINVAL;
> +		goto out_put_dev;
> +	}

If the device isn't incoming here, that's a kernel bug. The previous
kernel only preserves the file after pci_liveupdate_preserve()
succeeds, the PCI core marks the device incoming when it's enumerated,
and only VFIO's finish() should clear it. So this should be a
WARN_ON_ONCE().

> +	if (pci_liveupdate_is_incoming(pdev))
> +		pci_liveupdate_finish(pdev);
> +}

Likewise, the device must still be incoming here, so
pci_liveupdate_finish() can be called unconditionally.

> +static inline void
> +vfio_pci_liveupdate_unregister_dev(struct vfio_pci_core_device *vdev)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +
> +	scoped_guard(mutex, &vdev->vdev.dev_set->lock) {
> +		/*
> +		 * Complete a reset that finish() could not do, see
> +		 * vfio_pci_liveupdate_finish_vdev().
> +		 */
> +		if (vdev->liveupdate_reset_pending) {
> +			vfio_pci_core_liveupdate_reset_locked(vdev);
> +			vdev->liveupdate_reset_pending =3D false;
> +		}
> +		vfio_pci_liveupdate_free_incoming(vdev);
> +	}
> +
> +	if (pci_liveupdate_is_incoming(pdev))
> +		pci_liveupdate_finish(pdev);
> +}

VFIO should only call pci_liveupdate_finish() from its finish()
callback (see the kernel-doc of pci_liveupdate_finish()).

If vfio-pci is unbound from an incoming device before finish(), it
should just leave the device and its Live Update state alone. That's
fine: if vfio-pci is bound to the device again, the device is still
incoming and can still be retrieved. And once the device has been
retrieved, LUO holds a reference to the device file until finish(), so
vfio_unregister_group_dev() already blocks unbinding it like it does for
any other open device file.

If userspace binds a different driver to the device instead, that's
userspace's problem. The PCI core documentation already says it is the
user's responsibility to ensure that incoming preserved devices are
bound to the correct driver.

So I don't think the unbind path needs any Live Update handling at all.

>  #ifdef CONFIG_VFIO_PCI_LIVEUPDATE
>  	bool			liveupdate_frozen;
>  	bool			liveupdate_intx_disabled;
> +	bool			liveupdate_claimed;
> +	bool			liveupdate_reset_pending;
> +	struct vfio_pci_liveupdate_incoming *liveupdate_incoming;
>  #endif

With the simpler finish(), I don't think liveupdate_claimed or
liveupdate_reset_pending are needed.

PATCH 13 later inverts liveupdate_claimed into liveupdate_kept_running
and uses it to block dev_set resets while a preserved device is still
running. That can use pci_liveupdate_is_incoming() instead. It blocks
resets until finish() rather than until take-over, but since finish()
now requires take-over, userspace controls that window. If some flag is
still needed later, please introduce it once with its final name and
meaning instead of adding it here and inverting it in PATCH 13.
