Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738B2E739E;
	Wed, 17 Jun 2026 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781665309; cv=none; b=FAir+gaIkPCWrh+zDLunIyR5Q0uuO3gb4NaXUMKdgkkQnm/dr1MwhRIQEdkfY2UbJnynSL9G/hw+zHxJf+MXmO8I7EnzgOSA+ppPaePPRGS2S0vhBQQI9itP0tbHgQZGWTVN2eOm4kmfD3wGCtIEookIgLEhvqIRYLp4Ny4qqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781665309; c=relaxed/simple;
	bh=HTJ8KYFPVJkyDW+R2yNJx8qe3AsWz7nJqED2wvPH2dw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OuY33h62ZPwZwV1uHaOlLEjcut3Rb0K5v6NOyZlapsQnARq+p42IXtPI2RYGfT+LzHRW1dho899bHUsbJ2pL41DNkdsFVzjVQwUoIC+1YmkdtGscx6+MQiejA00p4onl9LEa74AJIbdLEuu/AEdQM+RM461c6S72VWmLhMfkvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=WpghXdiA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fr2hl54R; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="WpghXdiA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fr2hl54R"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 25D2C1D000B5;
	Tue, 16 Jun 2026 23:01:45 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-02.internal (MEProxy); Tue, 16 Jun 2026 23:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781665304;
	 x=1781751704; bh=njW2lIzSb6RaUWkk7HxgvpO5bJHsizFr4nvO4oEic8k=; b=
	WpghXdiA4CDymprJ2FfvXfIPu2lceS4YJoquUSfs0PMLL3KSH31kNKMM3RbtK2NW
	gQ6gz0wVFXmJkr+FLdUT48ejaZCCmRwQZGr4WynLRKFMzEZSKy9J/ktP1A6MfjHU
	IYsh3odnMzq33eQZFQMQdCFM3rpHoIgf8go37WYH6pJk16jLPBUZBMCJ9H8toLHR
	WSxwQuODsGfpgxs+eNfL+/BpUicdxcecKch57Hq5i7rKYUnC8LIIY6z+K8jFRjZA
	BDTZjzSaaTQr5rRL5f5n16jJ8RJwkfmk/t4X+1WRGv68Po1kDPbcWcIXUq8gUymG
	T4mE1838UORc8riERkOWLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781665304; x=
	1781751704; bh=njW2lIzSb6RaUWkk7HxgvpO5bJHsizFr4nvO4oEic8k=; b=f
	r2hl54RByH7bIH9kb9dAaNBlB0kKs7OVVZV/9rbcnub6Rx9MRGXr8FGmLwEKkmZ4
	zi8HelNNmtLZsOPvelkjGHEC9VWXR6cndiee9MpFH8H0ZDFT0CLFBdgYVkEsA4Xn
	RQe/dDxFFzxYkfL44qR674RoLKnVGFdHGRz2hJ+0HXzoLirY83O9yRDzBTVTmcHu
	oKqzYM8q7o4m4KmetLPIdqsV1o1Kqn3BJGuhGG3H24XRkve+ipGymPoBAJmo13qL
	78eaTi2yXBH8d3iMXTY1MOuJJWiCCbKZFzN/CUqrn32H+vapjGe3ZXRBUrJy4tJZ
	A4CUlaZcRUacM7uvAhF+Q==
X-ME-Sender: <xms:GA4yapSCzQGsNlsIa4LlFZqWowy3cVdCU0yOXvb9VgyTdKrc6GlOwg>
    <xme:GA4yatlk0PuoIFlZkYkungFNTKzJncrdfTlaaV4FNRKA17Hb_-VBnf8daP2umVRl3
    vmkplbFKiVY1BqG55z0Syvr30f1qeI7kMMRs7Xzhti-VQ3ATizu>
X-ME-Proxy-Cause: dmFkZTGzcgHyYJkipBHa/U8hKxZKJ+X3QTV0zh4pEaMQr+rJi/LaKfHctwIanM82+EHGjf
    /G+TuFvJW94BaIXf2a7oW7UiBxAxCdI6JQ9ZPxUTzQp771O7ZapmUbvGGOZUlmZ5n8S7I8
    3Fx9Va22ydTlboC0Rn6SSppwTlRk6L/q7wjDkjpBExI8LFog5QNk6xysxfijFbg47PvdEU
    xJ4QpdKh5dFB2t5iOb38M4T6HpIk+bdzMZhhV15Oe7IZsKwddGvffaFH1VKhPmcLWwd+Vz
    ApzUP+FCqlUIf/+aaw5YkQdSXnPS+D/pp2X+JDAmnR8SW/kFl/DWegu5BdBBIdbo0RoGsf
    IeWC+bP+6QjRRZy5CiO3BYi4UtRfsQxjG/fF34+vY+lmf0USwpLJPDZ5oX4hVCfZpv6OdO
    3wfOxENEfAtuVXBGSIpWSKRBF0im4AVunQVEtKrcB9enFgnGBxSxRhxV9JMeEnd+42FGtW
    5DrdDIqx7RfN5zgX3ThEO8EjeDj16qr8hDIlJEieNifD6+SIRezzQOKg/r2AZ8x/9JGcnQ
    GywI3b2vMBMsidapSJYEPd2slWw9u7nV91NIKEMGYsFBULWXlqPQbC2bpwpfuYVMj5Dsai
    Cvz+zGXKFxaygw+8pnbgJpRbTky6Y07JtoL2ubSooSR6DadkaspfQthI8fqQ
X-ME-Proxy: <xmx:GA4yau2xGiL-tJH5K3phjKYbpsMYzI8JBHR-TWoCnln734WSTPaFgw>
    <xmx:GA4yas-CmQS1zjFDU8T68pvqUO20Zr5My-5whmIVIUq2axd5QxYGNQ>
    <xmx:GA4yaj7Hgcl4xnXDZqSZsUGfTKxDmuT5iHrFHNV3AmwMaHMx7hborA>
    <xmx:GA4yakv0nJNY7VQgPofW9OwaOA6dQRCbIlyCrXkJW0a40s0sfwJlTw>
    <xmx:GA4yalYVNoWR8gkycteNF_3jL5l9q8T43Ei3WgwnrEDnRW9M71sFf3So>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 320F115C008C; Tue, 16 Jun 2026 23:01:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AnXwzOjrN2xN
Date: Tue, 16 Jun 2026 21:01:23 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: helgaas@kernel.org, wathsala.vithanage@arm.com, wei.huang2@amd.com,
 zhipingz@meta.com, wangzhou1@hisilicon.com, wangyushan12@huawei.com,
 liuyonglong@huawei.com, kvm@vger.kernel.org, linux-pci@vger.kernel.org
Message-Id: <c3d7ce59-bf5e-40fc-8f0c-6232c58c7495@app.fastmail.com>
In-Reply-To: <e2db72ab-6d51-4d19-8dba-0612207008a3@huawei.com>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
 <20260616144224.GB3577091@ziepe.ca> <20260616105754.784be22d@shazbot.org>
 <20260616172728.GC3577091@ziepe.ca>
 <c913116a-35b4-4934-b78b-8fa0a08a00ae@huawei.com>
 <a81c3479-1749-4b9b-b913-cfb20c621690@app.fastmail.com>
 <e2db72ab-6d51-4d19-8dba-0612207008a3@huawei.com>
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU to
 steering-tag mapping
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Jun 16, 2026, at 8:33 PM, fengchengwen wrote:
> On 6/17/2026 9:30 AM, Alex Williamson wrote:
>> On Tue, Jun 16, 2026, at 7:18 PM, fengchengwen wrote:
>>> Hi Jason, Alex,
>>>
>>> On 6/17/2026 1:27 AM, Jason Gunthorpe wrote:
>>>> On Tue, Jun 16, 2026 at 10:57:54AM -0600, Alex Williamson wrote:
>>>>
>>>>> IMO, this implementation in sysfs more so proves that vfio is the =
wrong
>>>>> place for the interface.  vfio has a use case to consume STs, but =
it
>>>>> doesn't produce them or own any of the mechanism by which they're
>>>>> generated. =20
>>>>
>>>> I would argue only a VFIO user can consume this information so putt=
ing
>>>> it in general sysfs is overkill.
>>>>
>>>>> The weak point is whether this bin attribute, exposing an array of
>>>>> structures, fits within the socially acceptable norms of sysfs. =20
>>>>
>>>> I'm pretty sure this style of sysfs is not accepted and
>>>> counter-examples are things that are ancient or slipped through.
>>>
>>> After weighing all feedback, I'd like to propose a lightweight singl=
e=20
>>> text sysfs node
>>> design to resolve both your concerns, without introducing binary=20
>>> binattr or masses
>>> of per-CPU files:
>>>
>>> 1. Only create a single r/w text attribute =E2=80=9Ctph_cpu_st=E2=80=
=9D on Root Ports, no
>>>    hundreds of separate per-CPU sysfs files;
>>> 2. Usage flow: echo target cpu_id into the file first, then cat it t=
o fetch
>>>    formatted human-readable ST/XST text line (cpu_id vm_st vm_xst pm=
_st pm_xst)
>>>    for that CPU, e.g.
>>>       echo 10 > /sys/bus/pci/devices/<BDF>/tph_cpu_st
>>>       cat /sys/bus/pci/devices/<BDF>/tph_cpu_st
>>>       and the output will like: 10 2 20 100 120
>>>    In the case of concurrent access, users can determine whether the=
 first value
>>>    (cpu_id) is the one they expect by making a judgment.
>>=20
>> That's a terrible workaround for an inherently racy design.  Thanks,
>
> This is because the DSM method is slow to invoke and involves many=20
> cores. Therefore,
> this trade-off is made.
>
> I propose another lazy-cached read-only text file design:
>
> 1. Only create one read-only sysfs attribute named tph_cpu_all on Root=20
> Port
>    devices, no write store hook, completely eliminate read-write race=20
> risks;
> 2. Lazy initialization: All CPU steering tag entries are fetched via=20
> batch
>    ACPI _DSM calls only on the first userspace read operation, cached=20
> inside
>    afterwards to avoid duplicate slow firmware interactions;
> 3. Cache invalidation only happens on Root Port PCI reset events,=20
> including
>    system cold boot, AER fatal error recovery, userspace manual reset=20
> via sysfs,
>    downstream hotplug and root port driver re-probe.
>    No CPU hotplug notification hooks are registered to avoid extra cod=
e=20
> complexity;
> 4. On every sysfs read, iterate over the cached entry list and filter=20
> out
>    offline CPUs according to the current online CPU mask dynamically, =
so
>    only valid active CPU records are printed to userspace;
> 5. A read-write semaphore protects cached table access to support=20
> concurrent
>    userspace readers safely;
> 6. Plain human-readable text output complies with sysfs text-first nor=
ms
>    Jason prefers, no structured binary binattr is introduced;
>
> Usage example:
>    cat /sys/bus/pci/devices/<root-port-bdf>/tph_cpu_all
>    the output will be: cpu_id vm_st pm_st vm_xst pm_xst
> 	0 0x00 0x00 0x0000 0x0000
> 	1 0x02 0x00 0x0005 0x0000
> 	2 0x01 0x00 0x0003 0x0000
> 	...

This is a more complicated, more bloated, less functional version of the=
 same array of structures problem as the bin attribute, just in ascii.  =
Thanks,

Alex
