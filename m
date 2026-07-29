Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B23A3E8B
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785306572; cv=pass; b=qjz7J/uvkTMMxLm6qIMhl4amggnq+WfstjDCimu0RwZ3qsScZIttsDmFA9Xy0X4mxy21ezSU13HJreNj2s6xUKGo8nNUuYkF241k1/A5HeqZmsQ8rC8CpcSs+2xKATLSgi+OHrBnCAOVEypiLs9R+FNgcV37X8WT84POdNhfZXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785306572; c=relaxed/simple;
	bh=qxdt7QUrXAJkM1a9eOk7Ix7nMrzBh/tA8S7MgOzOEz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKMb+Jko1DDLZ7qjTK8XYrrhGfd8aZwsKr6hPlXDVLuTMWcLfl3LYt5d6sHVMOn2GVduQehZs8YMbfLI1sBpFKrLOjVhT4cT9IgJmTNvZgOHgs2CKrLprgzPpDtEvduhNHxgZMNP1yn7FeVlvxUyVGxog2vwqc4LSlRPDJZCO0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJTbTC84; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJTbTC84"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ecf499af9so9624887b3.1
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 23:29:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785306570; cv=none;
        d=google.com; s=arc-20260327;
        b=SiFZ42+ElwGziG0r7kCWFiOcBLMRyriFL7sg05zwMhIeiIQrh6fJEeUBCZ9D82HCo7
         IWdI6iPoFn4ecxwOuHyl+pLBdJHe425cztQ8lIK8JFZ6E/g/3jd5nAC0nYEnulhnRMdN
         zBfXjf8vZyUrpT34LyqnBv/7ZjGr0VsuGO7a4Tal4+UsFDOLfXlQdMJwekha0WMlsRlR
         q1vDbUz6Ry8VwhPWudVgZyG/8C901pQ6IgZNr4IQsiWVI0umuBTOlbNGhzU53WHOS4oC
         Ey/mAX8nfm04lQYmFRQA3bpCqR6y1jgGeGMzdTIW6k8Kmnw4iWYEWScL5csspQegPC/7
         brYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6q414tQsnWLLmJlg/sHTYWqN5wVB2lO+CPgWmbqWy5c=;
        fh=72FsxGFBLGW7Ctyj0LnzmZIApuOh+ufJ5N73YNu4Vf4=;
        b=Q8i7hQkkE6QYiVB2MgnKGqH+4bsrMeZXToXu9nOV2asTlY9Vvnz2cmXk/KItEOg5rj
         Ww9BZFmH06GaI9+EpqXDM5+rL3HKPfad1imv6WyeZfUJaEPbhG1Dz1np/hQbZ9lPUz7p
         riotPFrhf/8AfdRieljGj6XBCpqqJ4dmZX+ipPqSHOAL+eLpcPEb+9IJfxuw/KE0rS8u
         4HgeKAxnoyV+oHZWY3zlB0M/EGQGFGZc+7ujn8xZNkFHaqr6iaLC3207evpg0aDGNYNG
         On4aJNNr7fnBpwN3RWYMtm/CTjSDuqa1/DYA31+ty9MV5VprS0uvsQ1k1+l8B/fhnjXa
         vNiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785306570; x=1785911370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6q414tQsnWLLmJlg/sHTYWqN5wVB2lO+CPgWmbqWy5c=;
        b=LJTbTC84roUdHUvJ/0/Vwg00PbOrJHGaHUBr3DWt5VoERS0+C3MPOWhgGspGR2eZsu
         4gR+Ybd/19LmYBg1kkwt6ch1MYvXVI+ZS+rY7X3J/BUke6dyRNJPPjsyRYtfT/s3L6Xz
         EslPV/73nUHZw67hiA/UVWXpsBcbUJOnVpuQ9xjmgXrcL/JFhQINYMiOWpclmMfmpONC
         dPzZVgStc9Pn8ypuh6IYdbdFvWkrZ3c+rDbhkmEOSNiogMA0CNkrxlPaBrkuRSk929PB
         RyP/BX1XVo2jfrBThVS5Nm7L8AbXDSS66c3gRsUAHfq3ProDJQ6yAbp77YMF6qOjBuRv
         nQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785306570; x=1785911370;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6q414tQsnWLLmJlg/sHTYWqN5wVB2lO+CPgWmbqWy5c=;
        b=QxOtV3GXGOZ/zbzI6DW5h4zGK3iowMa8aZHRZxGduoOWvr3LtWWpYt0lLOj8ot5xMQ
         mfa7p/TD71qfbgiKjqL6DhJT/2+e+SVsh8+waxqEabFQaXVUE20jDnOAxdAZObvN6jL+
         F4rhOaAhj78gaiu2KL/QIBh0V746M6aypItuS5OrpUmbBTUfo/pHP2dAulnbF37JGpi9
         XHEtH8CGJqzG7fMy1CBm6DGI38c9MixjMjHpnA4um/vzN4wgLTGGQV0xx/enSX/nINz0
         sIc/iag4NyUfg5Cw+K9rzXRdDDIFaqaJdaqyns3J4tlUdCmAxWanyc/5ls45MmSDtyT4
         f5sQ==
X-Gm-Message-State: AOJu0YwQY+U4jXO54mkteNnDWDhf8thviEe8NyttcQmRGFFNpe8pJ9tE
	YhBt7cN7i0Z7TI3zsyY3haPY4crNSHonQd9fR/SxhnFNUsGXUtJatDLTh6w0NVsVweg0PpT8FYr
	27g2WOgu6dUVkjoYGEK2uBrYxWI6JuzzWj192Uf8=
X-Gm-Gg: AR+sD12zb31lCzSTvWBfKd1KyCoMn+cDf+vpi83K5wp7ZQAw7BBITyX3gYZ2OZ/HuZ4
	WgDfLRzgRPis+9JGI8VsrE71nvX/0BddtM4vZmgRQ1pA2+/aqFMIn5twxw8S4k5BpS/hzf+b5Kw
	jF9uuctxcaYc3P+kV+v3wquX31nbkZmKPOTuBoYRFVBYgluCyyf0EpgjNf+6qvRPqgPMtsE3Bvl
	unykyMgf8xeo9pSW3h4WolNgoMc2I7BjSdTu01vHJtnvKNgG00eC0fz7whWnxeHJ+aqucm+263W
	CMwq6Kj5KoxRCYNw3i76PHd4gMw5rvRPtCaKf9ofc1Hy
X-Received: by 2002:a05:690c:4b83:b0:80e:bd63:178d with SMTP id
 00721157ae682-81f990ee26bmr28856527b3.2.1785306570147; Tue, 28 Jul 2026
 23:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKudn=rGv-xwAwTis8wpg31mxekyE4YH-E8CQoDTYovsPrENnQ@mail.gmail.com>
 <87cxw6hgli.ffs@fw13>
In-Reply-To: <87cxw6hgli.ffs@fw13>
From: santhosh kumar <santhu.linux@gmail.com>
Date: Wed, 29 Jul 2026 11:59:18 +0530
X-Gm-Features: AUfX_mwVkd8qCUZmin0VY24Uglo_tjQuE_HhYzSCufXgYxawJb8xtMv08XuQhhQ
Message-ID: <CAKudn=o7C1xa8TN6pqJeJQ1Wy=6iknHsyttW_Yo07n3_Yq5GCg@mail.gmail.com>
Subject: Re: [RFC] PCI_IRQ_AFFINITY limits MSI-X allocation on 384 CPU / 1000+
 NVMe system
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 4:22=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Jul 28 2026 at 12:12, santhosh kumar wrote:
> > Observed:
> > - Linux 6.13
> > - 384 CPUs
> > - 1000+ NVMe devices
> >
> >
> > With PCI_IRQ_AFFINITY:
> > - some NVMe devices fail to obtain dedicated MSI-X vectors
> >
> >
> > Without PCI_IRQ_AFFINITY:
> > - all NVMe devices obtain 2 MSI-X vectors
> >
> > Investigation suggests an interaction between:
> > - group_cpus_evenly()
> > - irq_create_affinity_masks()
> > - x86 vector allocation
> >
> > Looking for feedback on whether affinity-constrained vector allocation
> > could explain this behavior.
>
> Math perhaps?
>
> Number of CPUs:  384
>
> Total number of available device vectors: ~ (200 * 384) =3D 76800
>
> NVMe devices try to allocate min(nr_queues, NR_CPUS) queues where each
> queue requires a dedicated interrupt. Add the managament queue to it and
> then it's obvious that the total number of required vectors is larger
> than the number of available vectors in the system when the number of
> devices gets large enough.
>
> Nothing to see here. It's simply resource exhaustion.
>
> If you want that odd setup to be supported you have to talk to the NVME
> people and not to a random list of folks which have absolutely nothing
> to do with NVME.
>
I am trying to create 1024 nvme devices , each device requesting 2 msix vec=
tors.
Total we need 1024*2=3D2048 msix vectors
Total number of available device vectors: ~ (200 * 384) =3D 76800
But still seeing following messages:
  [ 9166.370948] Interrupt reservation exceeds available resources
  [ 9167.455029] Interrupt reservation exceeds available resources
  [ 9167.455572] Interrupt reservation exceeds available resources
  [ 9167.455888] Interrupt reservation exceeds available resources

=E2=97=8F Summary: Affinity Mask Generation in Linux 6.13
  The affinity mask is generated in multiple layers, here's the exact flow:
  Key Files:
  1. lib/group_cpus.c:347 - group_cpus_evenly()
    - This function creates per-interrupt CPU masks
    - Spreads interrupts across CPUs in a NUMA-aware manner
    - Each interrupt gets assigned to 1 or a small set of specific CPUs
  2. lib/group_cpus.c:14 - grp_spread_init_one()
    - Actually picks which specific CPUs go into each mask
    - Tries to use sibling CPUs (same core) for cache locality
  3. kernel/irq/affinity.c:26 - irq_create_affinity_masks()
    - Calls group_cpus_evenly() to get CPU assignments
    - Creates affinity descriptor array with masks
    - Marks interrupts as "managed" (cannot be changed from userspace)
  4. drivers/pci/msi/msi.c:669 - msix_setup_interrupts()
    - Calls irq_create_affinity_masks() when PCI_IRQ_AFFINITY is set
    - Attaches the masks to MSI-X descriptors

  5. arch/x86/kernel/apic/vector.c:295 - assign_irq_vector_any_locked()
    - Reads the affinity mask created above
    - ONLY allocates from CPUs in that specific mask
    - No fallback to other CPUs!


  The Problem Code:
  // lib/group_cpus.c - Creates restricted CPU masks
  grp_spread_init_one()
  {
      cpu =3D cpumask_first(nmsk);  // Pick CPU 68 for nvme0q0
      cpumask_set_cpu(cpu, irqmsk);  // Mask =3D {68} only!
  }

  // arch/x86/kernel/apic/vector.c - Can only use that mask
  assign_irq_vector_any_locked()
  {
      affmsk =3D irq_data_get_affinity_mask(irqd);  // Gets {68}
      assign_vector_locked(irqd, affmsk);  // ONLY tries CPU 68!
      // =E2=9D=8C No fallback to CPU 200-383 even if they have free vector=
s
  }
  This is why disabling PCI_IRQ_AFFINITY fixes the issue - it prevents
the restrictive masks from being created in the first place!
   In Linux 6.13, PCI_IRQ_AFFINITY causes MSI-X vectors to receive
affinity masks generated through irq_create_affinity_masks() and
group_cpus_evenly(). On very large systems with hundreds of CPUs and
thousands of devices, these masks can       become sufficiently
restrictive that vector allocation is limited to a relatively small
subset of CPUs. When those CPUs become vector-constrained, some NVMe
devices receive fewer MSI-X vectors or fall back to shared interrupt
usage. Disabling  PCI_IRQ_AFFINITY removes these affinity constraints
and allows the allocator to place vectors more flexibly, which
explains why all NVMe devices successfully obtain two MSI-X vectors in
the same configuration

> Thanks,
>
>         tglx
>
>
>
>
