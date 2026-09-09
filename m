Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8122F44C4FE
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788943979; cv=none; b=gE9a+3cWq6EBqfYkYPDpBULBxVUdlzL4ZVcOQQx3YyfgHWkAnkMMOG2uinMDoXNbT2FRaE4sCxof9KTEYgLzwRebdgOPjb0YtOnEh9RZGVRegJ7C4nykVyD74Iikuwke7on2WbzqS1bio5mu+Cc7Feo6AIEHFOws7zhsXNX3Z90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788943979; c=relaxed/simple;
	bh=cq7Ae+f3RmWaAVZ5M2GZcg5KWymPTZkW1haOlMIWGyU=;
	h=To:Content-Type:Mime-Version:Date:Message-Id:Subject:In-Reply-To:
	 Cc:From:References; b=ewNnf3wi3Djn0ImOtn5A94yAthgOQ4qUOvbiJ4UuQZQ+ZJiHQCPKxPq1VEJ1gk581bjsMz6bey76TDscoeKHwYomjqWXgRZet+QmB594gRXnGOG+gtq6z5cLVsR54QeCTJZRHiyZOKAi3YUXaP5osa/bKOGfoWh89nwmWhm8Jsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Va+nyMI1; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Va+nyMI1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788943968; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=42eTvA3+zf7J2g0oBhjdgayHhzy7hkEc9NIuW1rhfg8=;
 b=Va+nyMI1D+4ByyiJbOWpl2gpoaHAQ8ujhtZsJK1xUQugG0og0ecc4ZRTLwRXABcFx6qbix
 XW5CGjEYW6thywI31Y8NeTIbKv3v6Jv83k6CykBU66TPxuEzVGPrQk+dFHyeFK77p5GPDv
 cI0Ny+gp1xJqRt5lb0FVZ4CcCvkvF1GyFxQs1X3o6eCowGIjVk1en80FyBRW5FeB15Moee
 vKQRrhYUCqsS2qgixj89w1nyDWscaIvXdE0R1nPYpJZeAj0zIhhawUoDYuz6MkgyPFlHzf
 gWCI3zzY+3/DuJUgHCvvbLr1Vb81+U1vjyW/RVzFRrFcm3OHbQ2p7CAs2cHRQA==
To: "Luigi Rizzo" <lrizzo@google.com>, 
	"Christoph Hellwig" <hch@infradead.org>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26aa11e5e+7facaf+vger.kernel.org+changfengnan@bytedance.com>
Date: Wed, 9 Sep 2026 16:52:27 +0800
Message-Id: <8e816cdc-a714-49d8-943f-677617682352@bytedance.com>
Subject: Re: [PATCH v5 0/7] Global Software Interrupt Moderation (GSIM)
In-Reply-To: <CAMOZA0Lt99A1H45Hp0Snq4aSEw-Xr_Mh4xA--Cx0Qh_6vsQvOQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Marc Zyngier" <maz@kernel.org>, 
	"Luigi Rizzo" <rizzo.unipi@gmail.com>, "Paolo Abeni" <pabeni@redhat.com>, 
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, 
	"Bjorn Helgaas" <bhelgaas@google.com>, <netdev@vger.kernel.org>, 
	<linux-nvme@lists.infradead.org>, "Guzebing" <guzebing@bytedance.com>, 
	"Keith Busch" <kbusch@kernel.org>
From: "Fengnan" <changfengnan@bytedance.com>
References: <878q5f5tlt.ffs@fw13> <aqD7FDvDhiEF_u0N@infradead.org> <CAMOZA0Lt99A1H45Hp0Snq4aSEw-Xr_Mh4xA--Cx0Qh_6vsQvOQ@mail.gmail.com>
X-Original-From: Fengnan <changfengnan@bytedance.com>
User-Agent: Mozilla Thunderbird

=E5=9C=A8 2026/9/9 16:06, Luigi Rizzo =E5=86=99=E9=81=93:
> On Wed, Sep 9, 2026 at 8:25=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>> On Sat, Sep 05, 2026 at 10:30:22PM +0200, Thomas Gleixner wrote:
>>>> it appears that GSIM is only effective in scenarios where multi disks =
at very high
>>>> IOPS; in some cases, there was a noticeable performance regression.
>>>> If there=E2=80=99s something wrong with my configuration, please corre=
ct me.
>>> So we have a NVME specific mechanism to tackle the same problem and a
>>> more generic version which is subsystem "independent".
>> I'm not sure they tackle the entirely same problem, although they are
>> very related.
> There is overlap but it is accidental.
> The difference between the two mechanism is the following:
>
> - GSIM addresses hardware limitations (SoCs that create huge PCIe
>    backpressure on each MSIx interrupt, eventually reducing the available
>    bandwidth too much, regardless of how many CPUs can process interrupts=
).
>    The goal here is to throttle the total MSIx rate, blocking them at
>    the source (PCIe device) rather than later in the interrupt controller=
.
>
> - the NVME mechanism (and NAPI) aim to amortize interrupt processing
>    overhead. It does so by recreating some fine grained single-source
>    interrupt moderation (something that NICs do in hardware, but NVME
>    does not, with 100us being way too coarse for modern SSDs) and an
>    adaptive scheme to adjust the delay and decide when to kick in.
That's a great summary.

As for generic solutions, I've tried several approaches before, but none=20
of them
could achieve the same or close results as NVMe adaptive interrupt polling.
I'm still experimenting with different options.


>
> I think there is a reason for both.
>
> GSIM because it is more general and addresses an issue the others cannot =
handle
> the subsystem-specific scheme because they can be more efficient
> (eg they can hook into existing helpers like the threaded irq handler,
> call directly the handler without going through the full irq chain,
> use more targeted heuristics to decide when to kick in).
>
> cheers
> luigi
