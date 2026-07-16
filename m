Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAF03D647C
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240864; cv=pass; b=rYzsMXQ7r4zRk7WDxat8OKijEkkWLuWkKoIaureAIj7gfNza7yTILxhd/DfneetiTe4DuA5NScSgbOmYoyNUs14SDUKLugORbnf8+u/oyjM2DOyuVsEOqxMCUbnDePjxcYuF4XFszRBAxMwJyDAAGB2MhvO66nJ+8gvwdpGqVYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240864; c=relaxed/simple;
	bh=6ZU0yywrvxPHG6hK8bj9GpWMCRYihvW5KONWikHDtR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKSFRA0tYLljhjg6PXpSelyAGzGYXeL1DNE0M5alNteHZCdkWXZu8UQC9RT85wzECiSxTuoMp70qcga2HSBF7av3QmtNCa1Z+wPI8rHxEPy0oHJnEINSLDUqy/NZtMDeRJKgYSO8bOjPqx0M49DvARE2h6csWLSWk3epg5xogAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=B7uReKqc; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="B7uReKqc"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664a09bc459so11053502d50.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 15:27:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784240860; cv=none;
        d=google.com; s=arc-20260327;
        b=KKw9SAjxD3px/O5VEByzdiMxf9tdz5Ycl5mjZdwWLT674FTuVfxvUS7yH3bHv2BoFr
         fpnwnYkHSi48PMlFGP7MeN4FYE+a0lhiJ1prHw6aoOGt7qtL4B0xrT86YTQfmePXC8r/
         4QCy80Xml4SlR9thAAJLTCp94bYVvShX9iQAhtvXdJ+jfzkNhiEHJTvoa7xoowh9LN+r
         jykEDtZTrD+hF4nuwjx0UD/F82Wo6skdrxdYSSgVPK/UQaaArEoWDOEwR+mbPJPvs/KC
         PYefr9DXFDmlxyamh768EJOG/AFy9DEVbiywIPN6Kh33zr6bMNTrNqypti9P+get1lkB
         wueA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ZU0yywrvxPHG6hK8bj9GpWMCRYihvW5KONWikHDtR4=;
        fh=XdFVMGhLeg/RABVoK2SpTtk06npfiPYBi2hwecHIYew=;
        b=mUaNY96FFYwe+18oNxkJvMI2Navp/YV2qEDdWXs+DUE88tPDpQ3GjjRsaPyOSlgoEz
         wYMk01OzNbhznh3cS0vzrAqwuin9u5IuNHqz9oNc9rlwjXlvCe81/zCMNyk5KQ38DxW8
         w937kOdDOGvztpghqGzd7LNzMwMGhIE8KPQYi0T8Q22hV5haQtIEjCPQrCpspqsy8TVr
         vzTszuj3LDuIMJxT5isL3rD1GDYu0AKLKscVsFdLZ1dWN5Bu+sD5iH7u+kThqvdUnipm
         JwGSvU5tJbbqQ2mM/ngra7LR+exnBc95OEU5oa6h/fGX7dVfb65tY9pU91jNVdULlDSQ
         0RLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1784240860; x=1784845660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ZU0yywrvxPHG6hK8bj9GpWMCRYihvW5KONWikHDtR4=;
        b=B7uReKqcY4oJJaC/d5Lw5AgCqRE4obs0t/0AKhxqX/OPqpCAcD6jS4g7FOJP9pJ69l
         oda8N4kNpk+cQ43/DYcaTMESqEwkkIL4q6LLaFDtlvOL6ma37FMQ23jmHQ5Zxh3EQUXW
         Zu1t4cdF7My1hJQPySUkMwAweowYJN2zNMWE2sFjNUsrcMGnu48/a5hGKCy+mel8aspH
         rv3/2w6Hl1akqpSYRvboLKv9AzEpiXW9vDoxXnxC7y6YaMWHNWAX3GM/xPV1pJsSvTEU
         g0r9JHGIrIr3TQ11ok+mjHqunli37NYi+9eYzzdKQpMxbmc04Sj8pqLFX8ZBPBsohoV0
         VyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784240860; x=1784845660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ZU0yywrvxPHG6hK8bj9GpWMCRYihvW5KONWikHDtR4=;
        b=CzN0Qd1Zy6qkW52nhc+uD+enm87O5Kp0pjp1OpSpA0tY+aNbGSnMv9flMDtG87NeVT
         8xoYF4lpvtu/prjuLwUZytF12WUBzT5/3XTqzt8HV6OKGdkM8l1EuLUX4BDGcmf5+vUb
         rPeLbJmpaNGO+FQ3IHEj+tq9BOKfddGtaUIpUQ6bVaWLF+M0qJ8XkpqsF9Buc2DpHYKP
         J7W4VzEJKEkgGusnk09aUP6P7MXzXqjJU/HyNNFC+BdNEB7b6Q0zbLhvALN2h4ZoI7ki
         2NVfTwb4TfQlEGmoylXXhAhElSL1zwyJAMlH03DsigbOeL/LWj5Vg8qv6tNdpLmKP/kw
         Fz2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpuChlDY9XE4SYfh3iaeB1abhmpUO5TuJEjnh+l+HAixgBVlyPqcn88Iq/JX2IGFrahOLHk12/zsC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgbk5EoCxi+eMOk9fKOf/wSljO5xSk12YhlLVuMxSPaHRYnNSm
	nRMRc28OmdAdFQZBvr9n1pByDgiDyvz72dafD1bGGZpZptUa9FRT/C2/aq4uuyVn/lZupeaRI6D
	rDHL2+JoIYt4yx8qKpWxTJcgjMZJ/WrzpDhZ0UvnuxQ==
X-Gm-Gg: AfdE7cnoiT3UDn2tYHT+2tRDoKJXhJhiFKHbEfIyb3IfahTwaefR4qUt9xvYRmMGWBS
	srsLUfJsw+xEC6L/d6RTpNszk+UiIMId6XT5TIwwfDXpt1iKVJlyOkjnhGZEXSodadRL7VpkA9z
	ihV1uGhSD+chihHtNQY1nnhibEH4luxSeqDKDnyg4qBw31lOkK8EzOJNT0haPtg42A7STeC3spW
	bg0vkFojjACV9AkhqVCyZQ1LTn6vk5jvbxAKtMKIQpez4HdpDwnLdDbUneQiteyp/+hLYYvL072
	JRgmB8OWt6b4sHcBDw==
X-Received: by 2002:a05:690e:4292:20b0:664:ae6b:b499 with SMTP id
 956f58d0204a3-668134128f7mr5521399d50.78.1784240860157; Thu, 16 Jul 2026
 15:27:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-rtw89-spacemit-k3-v1-0-e577bc63706b@oss.tenstorrent.com>
 <20260715-rtw89-spacemit-k3-v1-2-e577bc63706b@oss.tenstorrent.com>
 <e7a43955e41c4dbdb864e89edc3d9fe6@realtek.com> <allZOmTRIvot39Gj@inochi.infowork>
In-Reply-To: <allZOmTRIvot39Gj@inochi.infowork>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 16 Jul 2026 17:27:29 -0500
X-Gm-Features: AUfX_mwxPqzyWp7O4WLTTM2K_5Fn9GaDNvcy6d1xA8kFX3CnozHTqWZXOkjwN2k
Message-ID: <CAEev2e_QaaGmc-fSd4dWQAm2YOqOmBDn-xi1coWrAnoh0JUqRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: rtw89: pci: enable 36-bit DMA on spacemit K3
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Bjorn Helgaas <bhelgaas@google.com>, Yixun Lan <dlan@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"spacemit@lists.linux.dev" <spacemit@lists.linux.dev>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Inochi,

On Thu, Jul 16, 2026 at 5:24=E2=80=AFPM Inochi Amaoto <inochiama@gmail.com>=
 wrote:
>
> On Thu, Jul 16, 2026 at 09:22:17AM +0000, Ping-Ke Shih wrote:
> > Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com> wrote:
> > > The Spacemit K3 Pico ITX Board has a RTL8852BE pcie card behind a PCI=
e
> > > root port, but the SoC doesn't have any 32 DMA addreseses which the
> > > rtw89 seems to use by default. Enable 36 bit DMA ability that the dri=
ver
> > > has when this particular root port is detected so that the driver can
> > > probe on this SoC.
> > >
> > > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> >
> > This patch looks good to me:
> >
> > Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> >
> > But I wonder how this patchset goes via which tree. I'm happy to merge
> > them into rtw tree and then wireless-next tree if people can ack
> > patch 1/2.
> >
> >
>
> These IDs are from my patchset.
> https://lore.kernel.org/spacemit/20260709040027.958400-1-inochiama@gmail.=
com/
>
> I think Anirudh can move this ID and add them to the pci_ids.h
> directly, And I can adjust my patch to depend on this. It still
> needs some improvement to be merged.

Sounds good, I'll drop the dependency on your series and just have my
series add these IDs to linux.pci_ids.h. I'll send out a V2 tonight.

>
> Regards,
> Inochi
>
>
