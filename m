Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7B31E830
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776793262; cv=pass; b=RpFJ0Ee3ZTjr4PjK0mBYXmqR74xY/TPo/XTgoaHIXH8SJEqOOaSeHZaF5UYCKykpl0NZgiGEsZGQ09RmUzx/2/TZpEI1xpGIf6WeNYh7GuVf4n3bqHsJ2NASrq6Vtlz80cuOoLwtrmfxfrCoywxExJX2+rgrCALWoP7NrRfUrKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776793262; c=relaxed/simple;
	bh=tCH8EMRzy1X9IMXq6R2TSgftHF1nceCRK1je/4RFR+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=App1krrbtv9zKl9vRQr36u8bz9Fw7kU9Bl7tgIEIkH9x8vjEoKGZKvtEwnPfGTL6Y1VIho4rKm+kSQVGzyB0JJntHSD4ZyeooQe4MZ2nAHLNkMQeEzxdYlenky0IX9aXRDoipQrId4cWJfAa4kI7ytiKqwiWpdGXH4dudDHa10Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbjgHHau; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbjgHHau"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38e7d983f79so35341701fa.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 10:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776793259; cv=none;
        d=google.com; s=arc-20240605;
        b=UjvwNARbmwu26IyuNGXnJ0AUmWUNVy8sX8m4kZLfQ/ACBHB045Uh0THR2sy33gJKoU
         LpxJR//OR2zlJlR2H4JHe4pBI1P8m4hC7NQKkbo3uJkq0NY924ztKlwxhU0dUWtXqfoe
         hjBMJLS8A8R1MWXyzRPJUnYuLpXH+T6A2AJ5E46/xb4iow6865c+B4B6p/zvwNVIGLVI
         lE5C+0hEvmj8hqUX1giM/648VDd3FwlfzxPwwc58wwS5w4gwmGXYCHvwpC/k/syYOyiI
         KRr+UNrVfES5UBSVA/OoQu6yfuOPHdfwEv3CjWeOagDUfWugqPfBqS31qFqCJ8bAoK3C
         Qs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gAM3zLbl9RAB5ix2RgDFnveQg42iFe43IZ/4vSwL0po=;
        fh=t2G6/F9s0p/fVnpdEpI8ZuhoBc06EdHlz6E4D7HhbZY=;
        b=bna0u/pJlbYC6hUsMd+a/dCdc5IRELSYAgQVxqFGQl/b6dPuRvZeA7k6EMdZjae+Wn
         5YBd1hrlZT5WhtbeOcem/dc8SE9mOfs+vTpBiiS2vhHdFO4XunXmZlLRqKRg0Q45frgh
         czwe96jsRXq2AIaOCj3B8JitUzCJB7KrZcN+oRK1ae1ACB4z2B9MLJDwVzZ9/1klhHCv
         JmPyDjAuNL034idzXaDSlQ/htSpb5NGDUQjBEgcythV0oqEwQPftNrFF60oRmCIM+ib2
         2kZOPDt/boWTmDyF0W+suKRru8tDHpfQnWJT3M309TLezvSQ1SNeczFpwrEUXuahsI4e
         /gQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776793259; x=1777398059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAM3zLbl9RAB5ix2RgDFnveQg42iFe43IZ/4vSwL0po=;
        b=fbjgHHausqRnAQv/Gm0WB1KYT5Ef+TjO137SVJmjln5wwrHMvzEM38YMAuW7lI2DTb
         NmEcU9H8n+70Xuk4H9OKhUBfjM+y8aqzI61ep7qrPQsvQuLY4PBSJrvyNi54ZOD0lQEb
         hc9TLUSu55ru6RHCT9SmkNPdZUWzQ0RwesPUupmg+Vkq0H44zIrr6UN1iMayAsCbIDYP
         w2pI6PeAKZlgHOp1DYAQD7SK+YIsZxubN5NKtf+JS68fS9biWnuos4dDvBonRAl2iC0d
         1nUIA2R+ep93u2n9Fq+p91C1rVCx8xwQHIcIpKSIVBGgn85bcpA+5RwGL9/kDfPaelwF
         fr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776793259; x=1777398059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gAM3zLbl9RAB5ix2RgDFnveQg42iFe43IZ/4vSwL0po=;
        b=XApKNA539HYD1y/3PgDPXNhfDSdfMiB6SzdpE2ibsDd5EPm6tkqDbo8rkSZUO7opBG
         tIHpQdG4PHVDBt0OR9u6u+MH2IaxV7zAEkgx+dr2QNvVzP9zpwKQ4os0R1ovTU/xviN1
         jnfTPzR9K96e2nkWjohmazbhAcLsWUAUQad64v4y10gMzVv0Yswzp8vy+kW8WFcanJbW
         BL/cUcF9+oNl8DVBYSRZUIYAyIRtSzgh4EIxn1pUfwa2Ta9HBFJitItJ17DzOV72rmn9
         o8NvceDTxsDJB3w23YJAWSo43+s9GWuBmgoxytDySmRBrfhD/Q7MbO7QM0knuShtBi1x
         BBeA==
X-Forwarded-Encrypted: i=1; AFNElJ+6gUXFFXJGxwSIATt6calVp/UyVbz+geBExy9RSd20/+LGFNC+XxecAKmhDE6f4+5fRMuSyCi/QxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdTClHgPmX3EnjajEmsmJRDDYtFtEaBB2MYX4xBs3NIx+bNcIz
	q+V6pO2KeZlvWI6BxNHwG4Ne8pOr9VFkcvm5q8YeVKkrX02wdTADtmweyKqkXfQ84T+BynX+nFl
	lWxqECz9X8YHB9abivIlL81Q3YqHn94v8I39WMiam
X-Gm-Gg: AeBDieuLR4O2poVoIOTMbrNJnq1fSfjbs0Kru+Awa+WvhYivJh1RipB1eIfA9V0iyJx
	EoiHmOoywu66iPBZPw4VeF9NUifAs6nHI91viioi/mf4vnW8Gq22+LLAtpEJWD5MpdpRr5jXMkn
	/13cL4ujEtRtRFnsZy622+ZpnBU4Z+sLFiNRqMkKGIacTgwxzPTN2xEVZRkwbr1OvXBwUJ217y7
	SPHUmA3weg39/5kKWVu+SSEQ6d7+SC6+sELDrUMOxvLg007DJLTQqMY4u0vFCFrAQce1irOqmjo
	a70kwX7gfy6vcxNpR3yn2aEhZ4VP2g==
X-Received: by 2002:a2e:a594:0:b0:38d:ed62:f1d5 with SMTP id
 38308e7fff4ca-38ec7aa4a03mr63977601fa.17.1776793258292; Tue, 21 Apr 2026
 10:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-8-dmatlack@google.com>
In-Reply-To: <20260323235817.1960573-8-dmatlack@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 21 Apr 2026 10:40:29 -0700
X-Gm-Features: AQROBzAxQqecIHMlVLo5_fKuOniGGCbgFfk1LcXxhbCrQbMNTrTkqomhARN-2eM
Message-ID: <CALzav=ehpWA=XchL+XLZuaYfYmBTPNWDYt1W3LFY5-6+US4E7w@mail.gmail.com>
Subject: Re: [PATCH v3 07/24] vfio/pci: Preserve vfio-pci device files across
 Live Update
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 4:58=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:

> +static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *ar=
gs)
> +{
> +       struct vfio_device *device =3D vfio_device_from_file(args->file);
> +       struct vfio_pci_core_device *vdev;
> +       struct pci_dev *pdev;
> +       int ret;
> +
> +       vdev =3D container_of(device, struct vfio_pci_core_device, vdev);
> +       pdev =3D vdev->pdev;
> +
> +       guard(mutex)(&device->dev_set->lock);
> +
> +       /*
> +        * Userspace must disable interrupts on the device prior to freez=
e so
> +        * that the device does not send any interrupts until new interru=
pt
> +        * handlers have been established by the next kernel.
> +        */
> +       if (vdev->irq_type !=3D VFIO_PCI_NUM_IRQS) {
> +               pci_err(pdev, "Freeze failed! Interrupts are still enable=
d.\n");
> +               return -EINVAL;
> +       }
> +
> +       ret =3D pci_load_saved_state(pdev, vdev->pci_saved_state);
> +       if (ret)
> +               return ret;
> +
> +       vfio_pci_core_try_reset(vdev);

I think a call to pci_clear_master() is needed here to so the device
stops issuing memory transactions while VFIO is trying to resetting
it. Otherwise I see these timeouts when running
vfio_pci_liveupdate_kexec_test with Intel DSA: "timed out waiting for
pending transaction; performing function level reset anyway".

Sashiko also wondered if pci_clear_master() is needed to ensure that
the device has bus mastering disabled during the kexec but I don't
think that is actually an issue. vfio_pci_core_enable() makes sure
that vdev->pci_saved_state has bus mastering disabled, so
pci_restore_state() below here should guaranteed it is clear during
kexec.

https://sashiko.dev/#/patchset/20260323235817.1960573-1-dmatlack%40google.c=
om?part=3D7

> +       pci_restore_state(pdev);
> +       return 0;
>  }
