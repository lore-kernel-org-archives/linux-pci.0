Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958401;
	b=2wQK/dThIzpLZVehlGuMaAQSWK30bXRq1Jqhioj/YdCA7e9U/KNbqRdCnmTaQY1ElOwb
	 WzZBrodS6t302GhH4GTQ6rq/LSm+ONUcOaZS7EzqL6x4WLAF9iL7VNrUJleozvgoDqvDD
	 gJollnCVVqotA3JV0B8WybDTg4WlD3n4h31iCWstXWeBe0gXYO7k+/9EScabb7aS1S7Fg
	 14KvHfKQ7skg5KfEWJktsj0l16U4hJe0hRv/2SqEH3RtM/MbQHkHvlXf9WWb0CXt/6zJf
	 7fOEwDMBiV6IsHczCAbO78Pm2amceg9e46Cln0LI9deRkhQofjxM4J4Ce7GXtKogVNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958401;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VVypS2BH7BTIDP8XvJg3P0/Wb4ccvreAy4viuz45dWY=;
	b=2vCqQeIt5lupxtL4MmHXVBfcjI2gXD5SlDFn/BgsvIuYrWi0CvuHswiL5pXPQuUV7ZvN
	 VzlTgWSn3Fi65ThLhSkMEQ6m2LOJIY7NtBUPDQtoin8p4QVLzeoS6FCcK+dfIe5v5kP5p
	 nY+sjzUaQUBZZBA8BAXlWLjxS2oJPS+9P3x7xnZgDwFQ6EUYeOmJ7ydq+ZWm1DVzteR52
	 k3T/ISRtfevtiSLab+0IM88rgk2etCoi8dp1bbAV0GWCq3HKpYnTcp6KmQhTdC+e0HL9C
	 MbUGSQN+wweeS8hwnt9AqDx+mKVLZkbzXzETgOo0MwNP9b98AWm8NqM35Y0MHQw1+/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b="O/nAIQ7K";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wsdD1Jy0;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE58606A885
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 23:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEE58606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=O/nAIQ7K;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wsdD1Jy0
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CDE82EC0912
	for <linux-pci@vger.kernel.org>; Tue, 17 Nov 2026 18:33:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 17 Nov 2026 18:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794958397;
	 x=1795044797; bh=VVypS2BH7BTIDP8XvJg3P0/Wb4ccvreAy4viuz45dWY=; b=
	O/nAIQ7KIz9miCX8OUQv0exfIWDQo6GU4ZnGJjkSH5NHfhU0Vu2iqezwq1Tw5iwO
	qgbLYGQ6OGMLLJgVYcoB0mG/GpNpaNRR31l/vgRmIXqEU4zrDeqdbs5KOlMYdfKW
	OpLa/KYF8nhviereQVFZE0gdQ3s73d4iCq14zGRS5Qplir7FovxBb9D3CBNa6aRf
	gCGrQJ88auWUxJ+H8Wv9vS+890bwngIH1beLu5uKJMERw4v/aji3xpXCiGLmQqB5
	kEMzDNecRk1OeZZfQTF7zmHr6LuiP5zi2i+iaO7acETL4+H2omj4ugIc+QPaJZtI
	BvBIfYwC7asH/6k94hTtqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794958397; x=
	1795044797; bh=VVypS2BH7BTIDP8XvJg3P0/Wb4ccvreAy4viuz45dWY=; b=w
	sdD1Jy039J3NtkZibDurMKuGngpWJ1hYQY5vV4YjfjIBNTbCLguD9broxlEUZbaR
	2izOMSi5IBzFXBPmHso1PSpjYvmH6+K7XexGqiHCxojQhmvNgvQG/fVewthpBS8S
	wkT1nVPWdmVmxjxaS3tMppAfdGggY0fdKwAVo56D+JPge6u/nNTfnxRnWlzihOs5
	cfA6U0TuFIgsnEgx1RjMzuiz+CQX/mV0QsRhr+J1rjLPnJhze2f/vCEPc8cXKQHx
	+HMD3KuoN9iMTv5Bm2S7vSd7c6PlHL7qWJK4TySMLftqE/F0nM8H+pO8lmQVj781
	aDIJMYARTQP8WabajZDwA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794958397; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KvAYHQXBA97gHWQgLHusEUUDufCj5NbiMr4EEAXkg01wFj1
	MQkTOqgZnqgaSu3BaZsgS83xf7rXgwrVCXCd/wMUQFOUNW37jOcwW3zK39Z+hHgl
	rfc3TPW3YVtO03ND8NSR7YvOSYaAEGmUvonFrmyF5L0wsa3lnAA1zx9OKC12QPPL
	zLdC5IiFqJI05cV+wLzZ2Tq58UamuRzxlkkG+8UX9R3Dv375NYZWc1jSv8/MOm7m
	OQ/pt9zmp8U2nKDEBqb7EIGNxab4EVMm6PPvvilZkQ7JYCfg5fi0YGr1nrp0gdCM
	Tf/oE7daLQK6gbSE1gltD0ffScFyCTQTFbvhDBg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:27q+KKo7XnsStduA99iu8sekMRO96NPbttKWHrolhyQ=:G/nOOdXrvsS0XmMnQ6K7L6R8U7MrOUPnWlNPXGT9/WE=;
X-ME-Sender: <xms:POT8aoQqA35B6qL_87dZHdopUrCwbFiYGMLmDlRhohAM_6jXOpohXg>
    <xme:POT8ana5BD-CqIq4YCJ_VxbZH0f_RrLxPI5pYLproLh_6aS1a4uDFrGJ6LNxMEG1u
    W72883v_U5jPM3AwBCkWTov6M-3pGhlcherrFijxKBC_PhF1FSHeprY>
X-ME-Received: <xmr:POT8ap7gLMc5gBNgElZtmUlkErVQgRxoljrCdyGXwofOstBdGxe-RJmjuxDbMw>
X-ME-Proxy-Cause: dmFkZTEkeKvcm2WWrV2Nam7Bf9ttXaRNcoFtwJYSfKOnyZQAU7CIanTw/rB2zVFRxoJI7h
    IeudW+EeYwM49qZ6JZju/1GP0nP1Yv+kKkk/D4K930wUxQFcV0XlueXiz+7hjD5kmfaxRz
    bBO3bIRzJoak1QL4Cfa4ASNcv2DAa/M8Z/hOx/jaweCnB2/0DIYpjZW1n8hrKjwCE7vNrU
    P6wpF2p6xUeHF/dxlX9rqKdWZnj4adKNhvBP0hSS6o2uLn/cbVB7VrGdYl3wKD8Sodunof
    tZdMmG/A6owkaSnJITXQLPNles7P2CY/46fhuo0jkSJ251dn9SMZ/Ol2LQy+TNqCcgU7Vm
    lm1NNi1iesVxRVZxXbmKOE3n/CdMBi183kA973NWbfyZ0pnChEb3ChV7mp4YXeuqfpwxY4
    Jqltnk4FZ6BiJAdvWafESXPMn9a7Fx26bsfnNsNFwkTO7zelG2w0PlXuQ5fzdgBMbt/sl9
    fjaZOJinNB0XupczM3md3crznTNbVq0htZl8rExZOtos0XXkNm88ky94vlSQyxt3jRm5HS
    2j2MH+LtkUeyPFu5ZHApXldAXs0ySexEJVl76LobcwpHdyBpfE+Ra/iVY9x6zdHO5XG1WO
    Dky123hcOfWBFLokWvfQgqvXTUAkUdbwwKwhHUBC3Ajc2gyrbR5AkJZ2iKxQ
X-ME-Proxy: <xmx:POT8aic-o_s9k0Y30RnqhRd18SaRIZ9tHLj3dSsdN4TuAEF6_5-QnA>
    <xmx:POT8agcdR7quKdAGTgD1yur1yrBabZ_ij82eVJH_AtuIrQUVbEGU9w>
    <xmx:POT8anGZIAvYlwHPBLRFCh1vJiRMyOgyn0nbg8n2MW3f1X754NtGDg>
    <xmx:POT8avHrFNE4YwcuGc2gLce7BCcooJkx91dGrWJL_egKNT5HJLLXIg>
    <xmx:PeT8aoxvctf3KU46eZg9ZJgxx_Q0Im4OHEmS79puSaSmXa8HwuH-7O-U>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 18:33:14 -0500 (EST)
Date: Tue, 17 Nov 2026 15:33:12 -0800
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Mastro <amastro@fb.com>, Leon Romanovsky <leon@kernel.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair
 Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v8 8/9] vfio/pci: Support mmap() of a VFIO DMABUF
Message-ID: <20261117153312.781fd839@shazbot.org>
In-Reply-To: <df301c78-2745-4c64-a331-c830efb74660@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
	<20261006193643.76330-9-matt@ozlabs.org>
	<20261013171347.54e856c7@shazbot.org>
	<0bd00c26-4f53-4387-86be-99f0c37fa47c@ozlabs.org>
	<df301c78-2745-4c64-a331-c830efb74660@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Nov 2026 10:48:47 +0000
Matt Evans <matt@ozlabs.org> wrote:

> Hi Alex,
>=20
> On 14/10/2026 21:38, Matt Evans wrote:
> > Hi Alexes,
> >=20
> > On 14/10/2026 00:13, Alex Williamson wrote: =20
> >> On Tue,=C2=A0 6 Oct 2026 20:36:36 +0100
> >> Matt Evans <matt@ozlabs.org> wrote:
> >> =20
> >>> A VFIO DMABUF can export a subset of a BAR to userspace by fd; add
> >>> support for mmap() of this fd.=C2=A0 This provides another route for a
> >>> process to map BARs, in which the process can only map a specific
> >>> subset of a BAR represented by the exported DMABUF.
> >>>
> >>> mmap() support enables userspace drivers to safely delegate BAR
> >>> sub-ranges to other processes by sharing a DMABUF fd, without having
> >>> to share the (omnipotent) VFIO device fd with them.
> >>>
> >>> Since the main VFIO BAR mmap() is now DMABUF-aware, the new mmap()=20
> >>> reuses
> >>> the existing vm_ops.
> >>>
> >>> The lifecycle of an exported DMABUF remains decoupled from that of the
> >>> device fd it came from, i.e. the device fd could be closed with DMABUF
> >>> VMAs present, meaning a fault on a VMA could happen concurrently with
> >>> vfio_pci_dma_buf_cleanup().
> >>>
> >>> To deal with this scenario, the fault handler now temporarily takes a
> >>> VFIO device registration to ensure the vdev remains valid, and then
> >>> vdev locks can be taken. =20
> >>
> >> This sounds like potentially measurable overhead if something is
> >> slamming the fault handler where huge-fault is not supported or active.
> >> Have you considered a fast path for the internal dmabuf where the
> >> lifecycle is constrained? =20
> > [snip]
> >=20
> > Hmm.=C2=A0 I'll hack up a test to try to measure the relative overhead =
of VMA=20
> > faults before/after (modulo access to meaningful HW). =20
>=20
> Alex Mastro and I have put together some tests, and measured this=20
> overhead on the v8 series.
>=20
> https://github.com/evansm7/vfio-playground/tree/master/vfio-barmap-perf
>=20
> Alex also generated a similar test with a slightly different method:
>   https://github.com/opsound/vfio-tools/blob/main/vfio_bar_bench.c
>=20
>=20
> Test method:
>=20
> Time accesses to a VFIO mmap'd BAR immediately after the mmap, to=20
> measure the 'cold' initial fault time.  Re-time a second pass for which=20
> the pagetable should now be populated, and subtract.  This should=20
> isolate the cost of the fault (uarch exception, generic pagefault=20
> plumbing, VFIO fault handler) from common costs (the MMIO access itself,=
=20
> TLB misses, the loop iterating across the BAR).  Maximise the number of=20
> faults by disabling hugepages (per concern above).
>=20
> This is done both for a single-threaded case which just iterates across=20
> a new BAR mapping, and a multi-threaded contended case.  Rather than=20
> just pthreads, this test fork()s to try to avoid seeing contention on=20
> per-mm locks (e.g. mmap_lock) and to focus on the VMA/VFIO locking.
>=20
> The default test mmaps before forking, meaning there's one shared=20
> mapping/DMABUF accessed from both processes.  The fault handler should=20
> then contend on dmabuf->resv, vdev->memory_lock, and vdev->dmabuf_lock.
>=20
> For comparison/curiosity, the --mt-map-late option mmaps _after_=20
> forking; this leads to a mapping/DMABUF in each process so I expect no=20
> contention on dmabuf->resv (but still on memory_lock/dmabuf_lock).
>=20
> Alex's test instead runs threads in-process, and goes further with=20
> supporting a larger number of threads (though with the caveat that they=20
> may also be fighting over intra-process mm locks).  It also supports a=20
> mode where threads can access per-thread VMAs (which is comparable to=20
> the 'mt-map-late' option of my test).  Both are interesting approaches IM=
O.
>=20
>=20
> Findings:
>=20
> On the dusty AMD Ryzen 3950X under my desk (targeting a 256MB BAR) I=20
> found the following averaged over 200 runs:
>=20
>   - A single-threaded/uncontended fault became 5.8% slower
>   - A two-process contended case became 8.7% slower
>    - 0.5% of this is the "early mmap" dmabuf->resv contention, i.e. using
>      mt-map-late (a mapping in each process) reduces by 0.5%.
>=20
> Alex's runs on fancier EPYC 9334 machines show a similar (slightly=20
> lower) overhead in the 1-2 case, and go on to show fairly high overhead=20
> when many threads are involved (baseline times in ns, relative series v8=
=20
> behaviour in percentage change):
>=20
>    Threads    One shared mapping   Mapping per thread
>               7.3     v8            7.3     v8
>    --------------------------------------------
>       1       761   +4.5%           777   +2.7%
>       2       869   +6.6%           840   +5.6%
>       8      1465    +78%          1363    +47%
>      16      4152    +97%          4258    +19%
>      32      9927    +92%         10158    +12%
>=20
>=20
> Now.  The absolute timings of these sub-microsecond faults indicate a=20
> realistic application won't see a human-visible change.  Small BARs=20
> mapped with 4k pages are still fast to map;  it is reasonable to ask=20
> that applications map huge (GBs/TBs) BARs using huge (MB/GB) pages!  Of=20
> course, this is just a one-time cost of warming up the VMA, not ongoing.
>=20
>=20
> Alex, my preference is not to complicate the fault handler with a fast=20
> path just yet.  It's easy to think of a contrived scenario where this=20
> matters but in middle-of-the-road application behaviour it would be=20
> surprising if this was noticeable.  What are your thoughts?
>=20
> (In the previous mail I suggested keying off priv->vfile (or a flag=20
> thereof), and it seems ~straightforward to skip the extra=20
> synchronisation.  If you feel strongly that the fault handler doesn't=20
> have enough if() statements yet and needs more paths then we could bring=
=20
> this into v9, but would prefer to follow up later. :)  A fastpath diff=20
> appears small but the reasoning overhead is bigger.)

I tend to agree.  IIUC, in the worst case concurrency (that we likely
don't experience), if we assume huge pages, we're looking at low
single digit millisecond total overhead to fault in an entire BAR
(~256 max faults).  Further, if our configuration doesn't force type1 to
fault in the entire BAR for DMA mapping, that overhead is amortized
across every user/guest access.

So yes, it's probably not worth having two different locking semantics,
but we should note that as an intentional decision in the commit log,
potentially even as a comment in the fault handler.  Thanks,

Alex
