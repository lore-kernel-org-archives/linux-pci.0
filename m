Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968D3D902B
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231777; cv=pass; b=KvZ13SLoGroqsyV558Hf0iC3meOs4d47axcPzW0Dt34NJVA0k5h9MVI/Huu/mOcARuVelJi1AWubL3doWbrnVn6R7ubdiKxeRJLP9Lb6sunlrHhFN0WTJSENoKaoS6xgj6HUx9fjsEwGQqKKG4irGuVCE9bzbATSos1gcljByeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231777; c=relaxed/simple;
	bh=berk4tsWZDjmNM3orug+7lqR7AAUJi2hBtoYZryZJRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDpLy26Hyexj2yXyKGYI7XxutlmfrjfnwBKhDgSG3x+74sa0+plQ++/vMYmB8pyvlprJcJtTxYIj3tJG8lLf3eVkbPJx/muSH6NFMBhdLefXgO/bj480ZZbWbvtvyo0oNsbyw99TJfKEJBsIMOxiVGruNa86xiy4dyDty5QVmW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVtgg8N4; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVtgg8N4"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3870778358aso6250321fa.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 14:36:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772231774; cv=none;
        d=google.com; s=arc-20240605;
        b=S3xGZ8OAAWmR6ZZPl2zyPz/CgQwUooMn4a+KAIXI+GDNaQQPDl5zkrcboBNnj6Rv1S
         YrxKHybxlrhwsTQwDIJVm0gsC/MVLEws1JoBIvOR/1uHPFU5X56sK8KUP4ug13EahFHr
         VoSYDdjDGjK6+cHEep1z508gml6mhMxoG6IoHFlqpQvWBbZnHQEz7eZLEvdbVujKXfcq
         o9IA6ztZGgQpV/V+jX6YfzJiLyx/zJ8UWpmbzikK44rz28nE/yqYjdmwvCwSZ7iN7hqT
         M0+M2oa0MUUmo+dL8vogMk88pdJ2nEknEVUqBwy0tM3SVyUPDQbNDeIeE5xOBVPDWVrM
         XveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNS9W6SZfyDIUc8hBvcmHVCCa8aXdEVnnS9qGJqvemc=;
        fh=XbJGOjH7FrY8p153DjCj4dEBrAGgF8O1ySGOabPXFfQ=;
        b=VtzH+//elcnCbXbSCqJF9JCilTnHs7p1h1FrIz84q8aV+WGOeCVxni5wgo671etCS5
         8qMQ+cq2SXEnClk0krXFwRPYG+uKrkCODLuhD2yz24oZYe6j2u0LI15sYCmGetOPQ/WE
         zOJrd9kmqbqMm+Pus88Vf/3T93mcIULmQ+NJnRY3Vj/8SKsY5WmR90mbx7apiT+rRw+N
         C/WygBUKiIadXSLkWeTFTn6tZHkkii52G51Cw218NyVZ/eyW+cLd+eB/2oFRuO+QxvkB
         kEGeU3ZE+eZ18SMP43f4O8Oj1iQ9EUa4Yerss3MT1N+Tbq3z+/4DYx+9KFG7geuVZB6I
         GIQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772231774; x=1772836574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNS9W6SZfyDIUc8hBvcmHVCCa8aXdEVnnS9qGJqvemc=;
        b=iVtgg8N4xFAGPLbnedfvEO4hhvKnGvP7UyMRM8KNH+eRdwdfMqqovCE3l8sBVa6ykH
         dgwERnHdkIXtDTfJlvMTL4CPWg/D33OG0kMUlWVIlfaqRd5xcIN0DJ/FtkM9s4Lu2QMy
         WGiPz7ev5mcyneZ9lN8vsMUaL3iaVKGlhSyTBDzp3aLV9dWCfM2D4GsdaIEE210HdBsC
         8d66lXztqqEghm8qxhnalaC2afyo2oLfzROB0aMp33KaN6twVI2NS5gze19c41D8ZnfW
         u7zCOuAqBq+FHxc47uRZ56jb8QOLuhhmkdl2Z4cm93JqMKUM53DSJ872cAzZidSBDGwz
         jObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231774; x=1772836574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNS9W6SZfyDIUc8hBvcmHVCCa8aXdEVnnS9qGJqvemc=;
        b=mIxVUX945NRHLTmz1tDXoks+qvCd2tMTZW9Xpn938+sOvy4UnKHje6DicnW2P+Us5A
         JtoFdVFXl0TdwQ3zasRm69ykcwJUhaUx+L4S7qq6lpFrHz0Tcjrvlu0MCq39u48GV1Bp
         ERre8gMZAIaAwH6XG7VBmFF51dAJxV3gPexUol+O0hi4c8bMHkCYoEHZnm2xDo5k/h04
         v264qTSO8kPHiPXgkS7ngO4DjFq78KFZ0hl7RcsfOiIEe29RIhHx5kPHM6GJahVhJhMY
         /0gk08B+DBykbiNqeeUSBBndLOgBxZI/nAh9PBO3KiU+3xhxcS7rrasnEeRTA8EB+gJm
         4Wiw==
X-Forwarded-Encrypted: i=1; AJvYcCU5h86mjPVM0Bqs4+zFjj/WoBKcWugINSSdcGKCLJJRhXxrtdQ2okL5gyx8d5xbJhYUEQ2Fh0UIsHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBm07/kZhwXjLCrT47T4IRbF40cOYRlYEmQD+CD151Nb+Ucp6k
	9TdRgQ1lnwsrouhuSWW8nUt8wz0LakT3SvniBayTowDILoru6m8ew0PRXgaEOJj91EF/NLvgXSM
	ge3oDGHLTgWYVTHQWTA5nm+2hY1IEklDKclFkSBrm
X-Gm-Gg: ATEYQzyQqlzGCBJfncuxptHPwKCFw4bDJSH7AsOc45+vMKKAu9SSGQ5Wk+4JHDA16iE
	SyDGn7qsNoNd5XQ0WasFBgD+WkeA19GLJx2X+xa+3YyB81sQZf3WbJPOQcNrkJbxUdR+3daPif+
	muk15Jd4bceWDsM+HUGF26nnO5WTtTsSC+qZ6lkudB3OLyNd/N062R2srO+YvWAUT3174oiDh3i
	xy1VfRASaBYKVC36Dn+j4qzvjPZ07O3QBusudMn5f80n35C9Z96mUAHrMTKVRchhCUilT2Sh9S6
	fhhZIDw=
X-Received: by 2002:a05:651c:150e:b0:384:9355:6a7e with SMTP id
 38308e7fff4ca-389ff144dcdmr32194241fa.17.1772231773691; Fri, 27 Feb 2026
 14:36:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-3-dmatlack@google.com> <20260225224651.GA3711085@bhelgaas>
 <aZ-TrC8P0tLYhxXO@google.com> <20260227093233.45891424@shazbot.org>
 <CALzav=dxthSXYo13rOjY710uNbu=6UjzD-OJKm-Xt=wR7oc0mg@mail.gmail.com>
 <20260227112501.465e2a86@shazbot.org> <CALzav=egQgG-eHjrjpznGnyf-gpdErSUU_L8y82rbp5u=rQ83A@mail.gmail.com>
 <20260227152330.1b2b0ebb@shazbot.org>
In-Reply-To: <20260227152330.1b2b0ebb@shazbot.org>
From: David Matlack <dmatlack@google.com>
Date: Fri, 27 Feb 2026 14:35:42 -0800
X-Gm-Features: AaiRm50D90uQBM2OzGa-RA7PnZi6CheC4aDHB2jS6rwjE4obcECpnTV5MTFBKgA
Message-ID: <CALzav=fq-3J4WFD-uNd5zJ_Fx2sHGv0vL+EtpV7WvGO8ddG5mw@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] PCI: Add API to track PCI devices preserved
 across Live Update
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 2:23=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> On Fri, 27 Feb 2026 14:19:45 -0800
> David Matlack <dmatlack@google.com> wrote:
>
> > On Fri, Feb 27, 2026 at 10:25=E2=80=AFAM Alex Williamson <alex@shazbot.=
org> wrote:
> > >
> > > On Fri, 27 Feb 2026 09:19:28 -0800
> > > David Matlack <dmatlack@google.com> wrote:
> > >
> > > > On Fri, Feb 27, 2026 at 8:32=E2=80=AFAM Alex Williamson <alex@shazb=
ot.org> wrote:
> > > > >
> > > > > On Thu, 26 Feb 2026 00:28:28 +0000
> > > > > David Matlack <dmatlack@google.com> wrote:
> > > > > > > > +static int pci_flb_preserve(struct liveupdate_flb_op_args =
*args)
> > > > > > > > +{
> > > > > > > > + struct pci_dev *dev =3D NULL;
> > > > > > > > + int max_nr_devices =3D 0;
> > > > > > > > + struct pci_ser *ser;
> > > > > > > > + unsigned long size;
> > > > > > > > +
> > > > > > > > + for_each_pci_dev(dev)
> > > > > > > > +         max_nr_devices++;
> > > > > > >
> > > > > > > How is this protected against hotplug?
> > > > > >
> > > > > > Pranjal raised this as well. Here was my reply:
> > > > > >
> > > > > > .  Yes, it's possible to run out space to preserve devices if d=
evices are
> > > > > > .  hot-plugged and then preserved. But I think it's better to d=
efer
> > > > > > .  handling such a use-case exists (unless you see an obvious s=
imple
> > > > > > .  solution). So far I am not seeing preserving hot-plugged dev=
ices
> > > > > > .  across Live Update as a high priority use-case to support.
> > > > > >
> > > > > > I am going to add a comment here in the next revision to clarif=
y that.
> > > > > > I will also add a comment clarifying why this code doesn't both=
er to
> > > > > > account for VFs created after this call (preserving VFs are exp=
licitly
> > > > > > disallowed to be preserved in this patch since they require add=
itional
> > > > > > support).
> > > > >
> > > > > TBH, without SR-IOV support and some examples of in-kernel PF
> > > > > preservation in support of vfio-pci VFs, it seems like this only
> > > > > supports a very niche use case.
> > > >
> > > > The intent is to start by supporting a simple use-case and expand t=
o
> > > > more complex scenarios over time, including preserving VFs. Full GP=
U
> > > > passthrough is common at cloud providers so even non-VF preservatio=
n
> > > > support is valuable.
> > > >
> > > > > I expect the majority of vfio-pci
> > > > > devices are VFs and I don't think we want to present a solution w=
here
> > > > > the requirement is to move the PF driver to userspace.
> > > >
> > > > JasonG recommended the upstream support for VF preservation be limi=
ted
> > > > to cases where the PF is also bound to VFIO:
> > > >
> > > >   https://lore.kernel.org/lkml/20251003120358.GL3195829@ziepe.ca/
> > > >
> > > > Within Google we have a way to support in-kernel PF drivers but we =
are
> > > > trying to focus on simpler use-cases first upstream.
> > > >
> > > > > It's not clear,
> > > > > for example, how we can have vfio-pci variant drivers relying on
> > > > > in-kernel channels to PF drivers to support migration in this mod=
el.
> > > >
> > > > Agree this still needs to be fleshed out and designed. I think the
> > > > roadmap will be something like:
> > > >
> > > >  1. Get non-VF preservation working end-to-end (device fully preser=
ved
> > > > and doing DMA continuously during Live Update).
> > > >  2. Extend to support VF preservation where the PF is also bound to=
 vfio-pci.
> > > >  3. (Maybe) Extend to support in-kernel PF drivers.
> > > >
> > > > This series is the first step of #1. I have line of sight to how #2
> > > > could work since it's all VFIO.
> > >
> > > Without 3, does this become a mainstream feature?
> >
> > I do think there will be enough demand for (3) that it will be worth
> > doing. But I also think ordering the steps this way makes sense from
> > an iterative development point of view.
> >
> > > There's obviously a knee jerk reaction that moving PF drivers into
> > > userspace is a means to circumvent the GPL that was evident at LPC,
> > > even if the real reason is "in-kernel is hard".
> > >
> > > Related to that, there's also not much difference between a userspace
> > > driver and an out-of-tree driver when it comes to adding in-kernel co=
de
> > > for their specific support requirements.  Therefore, unless migration=
 is
> > > entirely accomplished via a shared dmabuf between PF and VF,
> > > orchestrated through userspace, I'm not sure how we get to migration,
> > > making KHO vs migration a binary choice.  I have trouble seeing how
> > > that's a viable intermediate step.  Thanks,
> >
> > What do you mean by "migration" in this context?
>
> Live migration support, it's the primary use case currently where we
> have vfio-pci variant drivers on VFs communicating with in-kernel PF
> drivers.  Thanks,

I see so you're saying if those users wanted Live Update support and
we didn't do (3), they would have to give up their Live Migration
support. So that would be additional motivation to do (3).

Jason, does this change your mind about whether (3) is worth doing, or
whether it should be prioritized over (2)?

I think I still lean toward doing (2) before (3) since Live Update is
most useful in setups that cannot support Live Migration. If you can
support Live Migration, you have a reasonable way to update host
software with minimal impact to the VM. Live Update really shines in
scenarios where Live Migraiton is untenable, since host upgrades
require VM terminations. In the limit, Live Update can have lower
impact on the VM than Live Migration, since there is no state transfer
across hosts. But Live Migration can enable more maintenance scenarios
than Live Update (like HW maintenance, and firmware upgrades). So I
think both are valuable to support.
