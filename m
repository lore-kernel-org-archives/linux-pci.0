Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68803A05F2
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384502; cv=fail; b=fpUmGOpaZ1depWIZdQqpxVf2LePoKS74bGM9GtLiZlqlJNVYjO/yVs0Ev33LIsHfKM+e5obd7BCzPWJ+sz7k6Uxx8qxyy4EYXB8rRL3R+6AxWPH4RwPSbkGbkkVAVaqpROpotCfrJpWsRiiP/0g4JhjZJgEP+bvx5niBpAnd0/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384502; c=relaxed/simple;
	bh=GNbqOP8/vOBlC/5NmVa3CquXtyGbio1xnntDWh6iGKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENTpE/Vn2Z3P3wqdhe//1Ss+Ajch9/yVK+f2QAZZFdRjbJFMTlmFkWjA8XW0rQmrO1BQeeE9fnmAHi9zmisTUcXEcGZM7Q4Fj/n0NDvcaJPsgc73S6dBE3e4II2xTRj3hPGKbv6tYMtvGFr2wSkLTvhqBPYYg6WyCTx6XbKD0XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OQZ6oiRN; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OQZ6oiRN"
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651IbPTf1925927
	for <linux-pci@vger.kernel.org>; Tue, 2 Jun 2026 00:14:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GNbqOP8/vOBlC/5NmVa3CquXtyGbio1xnntDWh6iGKE=; b=OQZ6oiRNKfXF
	HFDFBWZ8BdlnmCUnJoqopQ8ht44IyIcRngTo5vzbD9eE3PHci7hw9MS25fO/+eto
	Ufhbzh5w0syuQ2ggQfOY2tYEThW6kK0fREz6MbHOgTTfppfQkpqdfn+SQPXexuAD
	Ie6ANRJ+b1YRc1xewkyhZx2bIIsI7MRe/jwOSfdaywuF9473KLIHfYoKIPRCh2Y8
	WWdocGE13zKd1J50r3VdsLTAZO5pqjzJkcYBoHjogiZO27cQxUvXRQ3zUmWXlq15
	g0ZF1xKWkn2Pxg3MqRPI0HmbFBBYIOMYNp9JoPpIzHq9+nA8JFAN2q0RoJ8mT7O6
	eVDAMsqcKQ==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4egghhuqj9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 00:14:54 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6b5fe5484so4882283a34.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 00:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780384494; cv=none;
        d=google.com; s=arc-20240605;
        b=k4Tz4LCzWtecZrQcpY31jgnYRo4nAeLSIt58/IHxCkbhCiSZUhC6AMemW4Qw/24a8B
         6ZkveQe+zKF/sInxIZ3Zi6tQfebIVFb8VGL9OyKii2uq8QrVdLTtTy+FRHg6BPzbX8+4
         RPUL+QwtYRoKsTpuo3otLvMd2+eQfZcvoG5V2oPWtKHf5xSkHBSynHjWriiNkWV4KpPK
         nhhO6n9f3W1vXpq+bw0E1b1XuvvpixLc7/jyiu2LU26Po8WbzRiWAJsMxcbQ4imGmstX
         wPrqrNBTjxU3QOEx221i5bEs/r3j2zm20axTuXfMXExSCfqdJu6e4ZYx+31taxdVy2pP
         cp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=eU0M4rF9MI3wrJoAUMjH5Oo4i+TWDq0gEOuY0ahh7I4=;
        fh=lyzqcoemvL95719UwBpC5RN+2MmoEUgFCVl+mgChE2c=;
        b=dfBkXELAF9uWcdrjCMClPAwQAltxS3j78f6lFQ4vk2qaz7BLkdtnQjGL5lqQEl6XTb
         /3h8U8KOglmg7XK1aY75IlfUIdDFQIwdRmdJXIB48voeTa2TkO2VDkF7AceK35U3jK4W
         noRQcjjAcscepVtziMn5YfsJFfJ1wMG3MYROQtke0zd8/bDfV7AAl62gC31zN2Kol47p
         DIyrV9P8Ia/yTDgYQW2RYnYm+SL/p2daSAPOhwCPzWbHbKoyeaZng2+oiBn5+0PmvB4R
         q7MJXPg3yy7QMqt4Xfqgl/wQ5ZFK+SdyoyI3OCidrp7yJ91C3h8GGsyK+1cTH6ITSzD4
         apAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780384494; x=1780989294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eU0M4rF9MI3wrJoAUMjH5Oo4i+TWDq0gEOuY0ahh7I4=;
        b=A4FcZSj0eBTe43vHeeDB6NF4UfKf1hQWMIPF1IVbzS6HLacAy+AOuuy8xPetzrMdLq
         MekHHEHrhxLM/+sbHzIHN33StOT93dHoYEJOE7cg9Y4MELoE0LAgnJfzpQTLBn8S4vD+
         QPAHB+CfUjKCcWRIUCBarAIFABcbTcBrMLQoOlNPYtQ/t2StUShmP4GOAVb8lsQH7qTq
         3ed7u4NWeIjqbQvgvSnVaTP9pSZbLpc6C22pXBJMTaVvQOWGCxHV4YJizSpnyTdFyBND
         DqIzpd7Y0Hc/HSXNnY/yZ/LJ1uz87Eyof7Imzld6BqN4L6+rlPdV90pH+8I7AnD8cQBQ
         6Afw==
X-Forwarded-Encrypted: i=1; AFNElJ+HTr7YT64RQSLuEt6Kl2jAWbLfBA0qqJIqqIeXYFiIsrhP+lqcqRH+U/KH7xiDK3MXoUlVR8gdTjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoVBgr4mybdio8n79m3NAowC/iqjTvnV3K1dY9mNabOzyBf6yy
	EZ7ASv4F2GRIsqsIHdRHOx1vTr38q1CMav5msegUYDmP82A2DfovN6kQsKkaMWm1FM7+BDBwFvb
	vBsKRPm+sALfBum6s11UlYuz0qo+zcaCQTkSu9P42bHATCbLAnxVQtrkCeQLEvw2qS3rX78UmdL
	Q+mvtRShJKTzNy6oURW72bjGr0rRB42no0F1w=
X-Gm-Gg: Acq92OHp4pSNxcVbAzmXU/HfJGzmUuXVBUMcDrMkk+eZ0YLlCULZWUFO2eL6iqMlLU8
	nbJL/WI/5mwsNP/yEkuJj9cG/lpCAzvj04iU90IQ+5utZz5VWVkSMkrkZnex+DuqBmnpeK81kaz
	IEszceGkxh3OjxpyJqWJ6yLtRtZsI6eHKPmAuTUIa02uwvgXHGVeUV9yaYI3BwlObEfjmHjcmCq
	tfXN/v4xqwhCSpToZ6C3maj/6pqxfMnuwhv9/Fev6h7FDhHe/E=
X-Received: by 2002:a05:6830:b8a:b0:7dc:d725:fdb with SMTP id 46e09a7af769-7e6d22714f0mr1524746a34.8.1780384494166;
        Tue, 02 Jun 2026 00:14:54 -0700 (PDT)
X-Received: by 2002:a05:6830:b8a:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e6d22714f0mr1524729a34.8.1780384493717; Tue, 02 Jun 2026
 00:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527123634.GK2487554@ziepe.ca> <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com> <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com> <20260529201130.GU2487554@ziepe.ca>
 <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com> <20260601174734.GB2487554@ziepe.ca>
 <dedd8e8f-118c-4ee5-9552-cd2220dbdd23@amd.com> <20260601184838.GE2487554@ziepe.ca>
In-Reply-To: <20260601184838.GE2487554@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 2 Jun 2026 00:14:42 -0700
X-Gm-Features: AVHnY4Is8GEC0NoEl3YOomYHVUTID0QdEceI4eqR8x2YX12M9DU2UU8lLqhKsf4
Message-ID: <CAH3zFs0Lz=oe4coFS=Ws14rKsY_Wi0=ueT1DGx+YpaSvt=DkAA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: jFXNkcnixbQoXMeTH-KWcKi3NAZqcUJt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2NiBTYWx0ZWRfXwINiasZ19AQm
 NZrhCvEwn8O6lFNnnKxOWq8Tbw/c5WItmjF1Ixo0sxoh6QqhGPc5xN9LGEOYGrZsKN7MPywdUEq
 tFMr2XJpHmQeTwdQCMfvs+QP56XMgnCMX92KqUZ/0cBSZ6+2ht1LkAsuLtSv1saWs8AnOtMt/eo
 FzEECRzVSJ9J1XGl30drTEsFS4NK4mPR9uDEzsC4yhuX+yLfgkxmde/IJ8xkbpdT1sMfz/DwkXy
 xsg2RCmxMEOKkztPMQdjy41dENLomnJ8uX69GZkNe26etETcbVts1xNJtWnzIsTCqwE2YrL6ZRg
 hS0SuQxhcq2M9a90sbz+KdDHN4aZ5bljErafyqsl10/KhS6jk2w9PTU89Z7hXQUPidPREq5gdkM
 nwPeTCgmH2cnBiMm+KWG8Za7PWh4K3B8Ixm2dG5R8ueaEQMvw+ZTfb54KvDAug8PeOvfWNwCZKq
 lCEvAUEh4m2VUwIOctQ==
X-Authority-Analysis: v=2.4 cv=FOwrAeos c=1 sm=1 tr=0 ts=6a1e82ee cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=9jRdOu3wAAAA:8 a=80MmiaoySdvbWJADnQkA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-GUID: jFXNkcnixbQoXMeTH-KWcKi3NAZqcUJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01

Thanks everyone for the feedback.

For v6 I plan to improve the cover letter to explain what the
Steering Tag concretely does on the completer side and why it
applies to P2P - the ST is consumed by the endpoint's ingress
block, not the root complex, so it's orthogonal to cache snooping.

I'll also include test results showing ST's functional effect on
P2P writes. In our case the ST is used to select in-flight data
operation.

Is there anything else you'd want to see addressed before v6?

Thanks,
Zhiping


On Mon, Jun 1, 2026 at 11:48=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Mon, Jun 01, 2026 at 08:17:15PM +0200, Christian K=C3=B6nig wrote:
> > On 6/1/26 19:47, Jason Gunthorpe wrote:
> > > On Mon, Jun 01, 2026 at 11:59:55AM +0200, Christian K=C3=B6nig wrote:
> > >>>> When you have a complete open source driver stack which utilizes
> > >>>> VFIO passthrough as the interface to communicate with the kernel
> > >>>> drivers then we can eventually talk about that.
> > >>>
> > >>> That decision is not up to dmabuf
> > >>
> > >> Yes it is. This is the DMA-buf API which is added here.
> > >
> > > It is a DMA-buf kernel API that is added, I think it is overreaching
> > > to try to veto a VFIO uAPI that calls it..
> >
> > Well as long as that is a private interface between VFIO and mlx5 I
> > have no objection at all.
>
> Well, as you know, we are using dmabuf to mediate many of these
> connections now.
>
> I don't mind a "private" interface as a starting point, but it does
> need to discoverable and negotiated without weird module dependencies
> or symbol_gets.
>
> > But when it starts to affect DMA-buf I need to make sure that it
> > works for everybody. And without even being able to test it that
> > becomes really tricky.
>
> They should have an argument how it can be used for CPU backed memory,
> IMHO.
>
> > > This exposes a PCI SIG defined TPH capability in a reasonable simple
> > > VFIO uAPI that can be re-used by any other device that happens to
> > > support TPH on inbound MMIO. The uAPI has sensible general semantics
> > > based around the PCI spec.
> >
> > That it's implementing an official PCI spec is a good argument.
> >
> > But on the other hand looking at the spec it's not really specifying
> > much since everything is architecture specific.
>
> Yeah, spec doesn't say what TPH does when it is received. It is
> intended as an opaque channel between the source and target.
>
> Even on the CPU DRAM side we make an opaque call into ACPI and the
> BIOS returns back the right value to use for the CPU. The whole thing
> is agressively opaque as to what the values mean to any particular
> device.
>
> So I don't have an issue with VFIO supplying a value for MMIO it
> owns, it fits the general architecture.
>
> > > Anyone can repeat the demonstration Meta outlined in their cover
> > > letter: Use this new VFIO uAPI, import the DMABUF to mlx5, use a PCI
> > > analyzer and you will see the PCI SIG defined TPH bits set the way the
> > > VFIO uAPI says they should be set.
> > >
> > > There is nothing uniquely tied to Meta's device here, or unusable by
> > > someone else's devices. Arguably this is actually a mlx5 feature to
> > > allow VFIO to control its TPH generation HW.
> >
> > Would it be possible to demonstrate the functionality with some FPGA
> > implementing an PCIe endpoint?
>
> Sure, you don't even need a special endpoint, any endpoint that
> doesn't explode when it receives a TPH is fine to illustrate that mlx5
> is emitting it correctly.
>
> A fpga reference board with an out of the box PCIe IP demo is likely
> entirely sufficient, and you can use a FPGA logic analyzer to inspect
> the packets.
>
> Though keep in mind mlx5 is formally supporting TPH in a growing
> number of kernel contexts, so we do test and verify our device is
> working properly as an initiator. So I wouldn't advocate anyone
> actually use their time on FPGA :)
>
> > Doesn't needs to be anything funky, just the ability to exercise
> > this for basically everybody who can spend a few $ on the HW.
>
> Topologically you also probably need a PCIe switch as the CPU P2P
> likely discards the header.
>
> Jason
>
