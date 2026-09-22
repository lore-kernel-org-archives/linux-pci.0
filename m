Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D548EC69
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103238; cv=pass; b=KSGwtVCp6KTJzuxaE6BV4srKBCSc7Zc+pV9kLiwno559rlke6iaD92Ph4jQyAp07T7Yj97ysU+FTlP6NW6aRDwDtVu/+gbls4lznZvaKhel9wps558OXicpOJcq+lplly8yta0GUrbmYZsNntTP9ooLcndvpRpmP93RUVRlS5ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103238; c=relaxed/simple;
	bh=CxQ5R0YiXXR5pS5OlXpEM54373E5joJN4ppW4x5rEyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNTY+yb1hZlvrZCYhbBsIBsPcadRgPuyFxRfyp3V2FKqnD3bLrroe+YOIWfo4e9vcUuWbrZIij0hdG4AXxVE9Z2nVXPF+yo0kPmst/qoFVkQpFbSYwxL8sIP6eG5i6Q3PeRLZJsG7vgx4kEbSi4N/H+iYWT9uQQsS8goyf9NIwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RETCNeQu; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RETCNeQu"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f5603a0so21243566b.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 11:53:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790103235; cv=none;
        d=google.com; s=arc-20260327;
        b=PYhRKlRJqoEn4dYUy81Zwd4BoycbF6go0hwcb7C4NulRkgnsvO5bPWyrwvKDqZJXwV
         ZJ13sEy1RykVHtQpfuuWBHAF9WNnPAVnnJ0dt4hKR4Xyxi8KcCreit/y3KrXh1Ie6uH7
         espqSrnRBZQlRca69X8UpaqoP6o1IUeu2c0iwynnp2komN+6r2qtne4uv9FzTJdxuldR
         HiY7W8Qib8GPXv32pc5zjBV07AC3XNsIY4BNi05ioENlUVVprYUrezis078ZPmCCMLqd
         ZJMBfKM+qljAUALcPDpfvbNHP4NwLgsu4LmATxp+Nz922pGo9+h79vnyEDMl/4SNW85J
         DloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mk9DB7qPIG0z2a0BppKMxU3ch/ZxTA+4gqsB2SAa/tM=;
        fh=cljuex+SwC6bqF7X9c4fPde9qssG63zBh+DbgLNG5bA=;
        b=fA2z59QrVk9NchAyzxIVEyB6owBrTQgf9dywjp4/N/BMF7RmufBJbV1xwnSTnkX7z+
         i8redExxoNBPJnPHtsqOYrSKXHm91MoElIQMZ1wfYwH5MGrZuGrUP2ylcUQ6IV0HUUZu
         9vtwdJ19IYo2LezIxjqN13UQybJnwZzPnYaxM4Pn6XXP4QSEWrAmWnUDY1OpOZuJIRJb
         GN/GIHNgb0t0Gd6Njgw99hII+TJWybyt/Y8DtWkt5sJlvB+EhVDd5XgvRnMHw5g1XLnn
         tZFg9Uc2wBCM5ctAOYAhmgxM7Oe5xUt2279YP0K5dYjMNDvoFqrbryXjfmwFuwVfzlL/
         dUZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790103235; x=1790708035; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mk9DB7qPIG0z2a0BppKMxU3ch/ZxTA+4gqsB2SAa/tM=;
        b=RETCNeQuvVm9JTLE1lCy4CsIYJJeNE/cA2myl+TuU7D1MIDOeOul/CwsE6q8scD7m5
         WVODIsA6t7K0B9iTuWQygUWmSSeZmUzvvLvBDTSD63myPi86GWvWRG3MqMYRPwMk5wkE
         q+TJEe6B8v51PCjt5cXZVXfTRij30TLiR9muOA6MNns/GOJC+39fgWqRj8XwKeTbErkM
         MWJVnBi6TE7+Zz7lhsxsZbZQf7DlgSTmmk9tqPJnyuzLq8WDCJWOoKJkhgz9UZxY/Fvv
         jYdcYfTzpBeEztYVBVESm+u5IHxaYnPsvtRRvsyuUzvc69HgDcJD6m0fbe1t/y43UuCK
         1+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790103235; x=1790708035;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mk9DB7qPIG0z2a0BppKMxU3ch/ZxTA+4gqsB2SAa/tM=;
        b=UIFXLebkvubMVj8zu5c1eiQ8cK7sAEdgETVxZLBPhnn1uTgmFIcAtXMkCkOVnIHjAV
         LzO90C6tqCL5tQymkLAHYmKtZMHbPlqsenLJhnVy/ZO+Yi6W2ZU3BcdojjxVb9gYXJTQ
         R/S/ErTWYJqOTH8G9q7w7WuG5WVmbx2g3sah/xGpaGlCdIvx+NPvIuec61BLKQSGFtur
         jWNaOlTJqAEfB4C2FGHMOQiP3SNet5zWt9Lh1sCdSSzTAI92D6Xv31fLw5zg5L3iFlIN
         1px7fGId3N49WLIgEAsIxQz3XgsYT/pYjh12HXCPWB5yoQIPwxTclIMJpvPM6CcwOvr1
         jxaA==
X-Forwarded-Encrypted: i=1; AKwUvBwDUJae94nbdZJYJXluQKRgjwF/fKR8wVvf7I0fYldVLh2/9vQQBzF+xekshJqx1sSuiDuJ+h2zck4=@vger.kernel.org
X-Gm-Message-State: AFuF++nsqIQusYYV/RhRgszRaB7xINOMGX4817rSNsRWm/RLHYYkczNg
	5Su3wPx14C0MPR5Roye4bTP+LPMTRHnQBMHrVAqfKoyeXuyljBB7xuSIz7a8utG9ysISRRBAsj9
	nCWqgz4FEdVpLcYXt5BG1XxAHr2MJlrkLxNF+JU80
X-Gm-Gg: AYBFou2eNNGuFCnk5gIhZ7h5JqxpcjRQnxcYsWMIWP9hSPWM8vg1wd70uTwr0rqf98V
	2mvoU8uEH+E2zVszR56sU+pLtdkv2VY9/5ydZvtcyqY13PcvkWGil0Uwp6DgcvD3NKoHn5BEkc+
	XsRNww7GjjxDAId3PDFMiuNJiZptTEqXUREal2Mehi+NH3VqINk2hxGHzMVz323bAqx548168Nj
	jOC4cZGUpQzKk76DxnJyvIqxcDH736SYcapl1TTDGRf0bPK5GCYSgPMr58mT/6pWuRZ2BKjXyMx
	Oi4GdPxcWHS3O9B8QpAXzSxZRK5K74L6JR7Z7D8GMdZyN/JhYZKCR45Sug==
X-Received: by 2002:a17:906:f58c:b0:c29:448b:f5d4 with SMTP id
 a640c23a62f3a-c2aae2b0595mr11895766b.35.1790103234240; Tue, 22 Sep 2026
 11:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918200640.887030-1-dmatlack@google.com> <2e88b92a-d3f2-41f7-bdbe-11fd71690606@linux.dev>
In-Reply-To: <2e88b92a-d3f2-41f7-bdbe-11fd71690606@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Tue, 22 Sep 2026 11:53:26 -0700
X-Gm-Features: AclHuK_mAcmGN2d4gu0q1ERBsbnyv84fOIFniqxdriBGbAgM5X1zIuozEi_ewvI
Message-ID: <CALzav=eJU+fnPr-QN4s7gY_Lj8Pc3T6KXfC9kiQQ=g4rPEDMuA@mail.gmail.com>
Subject: Re: [PATCH v9 00/13] PCI: liveupdate: PCI core support for Live Update
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 11:36=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> =
wrote:
> =E5=9C=A8 2026/9/18 13:06, David Matlack =E5=86=99=E9=81=93:
> > Future Work
> > -----------
> >
> > Following this series, we expect to make further improvements to the PC=
I
> > core support for Live Update:
> >
> >    - Allow P2P across Live Update by avoiding resizing or moving
> >      preserved device BARs and preserving all upstream bridge windows.
> >
> >    - Support preserving Virtual Functions by preserving SR-IOV
> >      configuration on PFs and enumerating VFs after Live Update.
>
> Preserving the PCIe topology, bus numbers, ACS, and Bus Mastering across
> kexec is a foundational step for minimizing downtime.
>
> As we look toward complete end-to-end support for DMA preservation
> across Live Update=E2=80=94especially for VFIO device passthrough and dma=
-buf
> sharing scenarios=E2=80=94IOMMU table/domain preservation becomes crucial=
 to
> prevent IOMMU page faults when devices continue performing DMA during kex=
ec.
>
> I would like to ask about the current status and roadmap regarding IOMMU
> Live Update / KHO (Kexec Handover) support:
>
> Is there an ongoing effort or RFC series for IOMMU handover / page-table
> preservation currently in development or under discussion?
>
> How is the coordination between the PCI core Live Update mechanisms and
> the IOMMU subsystem being envisioned for preserving IOVA mappings (e.g.,
> restoring domains or handing over root tables)?
>
> Any pointers to active discussion threads, RFCs, or future plans
> regarding IOMMU participation in Live Update would be greatly appreciated=
.

The first IOMMU series to support Live update, can be found here:

  https://lore.kernel.org/linux-iommu/20260921004834.2601285-1-skhawaja@goo=
gle.com/

The IOMMU series builds on top of the PCI core support (this series)
and the VFIO series linked further up in the cover letter.
