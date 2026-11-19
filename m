Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.230.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059132;
	b=S1kK1a1A1YZXon9fFiFq4BjSJcGdur3ok6TlkbmWwfWhsDdGONZ8ehVkfjwztB1G9jEO
	 UHjBQgz2mzFf7wLzAGmM5APusJdbxW+9ELLC94h9EXyFsXSg2Ueh9hmYWkTWsEIW4sDf0
	 riMea+DIFvzluWFZ1BDlnrephNr0fWpUkL/pxTzXBnPSFFr2ZzdZUlNdE+J2fww2vO6L3
	 clInwOBafyso3ChMttVtnRT2rbAZ221+5Uo/nOvh2vn6hZGhJKz98Lzv7qdM/k1K6H4Tp
	 sYMNxM8ET+uzeuFcudMM6mutsyBexL73w3G4YpVfg0i+4vKJOBHSRoRE4aBpe1FuVIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059132;
	h=DMARC-Filter:DKIM-Signature:Cc:Mime-Version:From:Subject:In-Reply-To:
	 Date:Message-Id:Content-Transfer-Encoding:References:X-Original-From:
	 To:X-Lms-Return-Path:User-Agent:Content-Type;
	bh=PJA8HI/26n09BDtdxwvrwKrlkq0uzVECslo8UM0vFOE=;
	b=mwMM4ifN3e47Os7sv89DcLp2ld84Yo3x9SNRW/RHAMNOnkqyTmJKjQHGITdiDyIVCdho
	 FcAKDBzQhbiHG2Vw+enbj+DISVYaI9EM34ncbc6PKXFPmmnEnshqaBFm0TXI+rd2QbiFg
	 /YasxbqGlTwuhQUJ4ymn2+5j0l02djkkhd+p9t6Gcqqw8m4HGk/dC71sopAB+Ald1qrVU
	 V/S1pbtb31ojSbUKmpW3Ms/8Jw7K+M9/j2trKMLcP3O62JEpmut8g/Or+Yl+5UMNjlLb4
	 KrdYtLOfcIC9iH7q2dAVN0s4PfK4GIaVFbYkol5tHhuuD/L4+Tq7Ef/tY70f2CBCChw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=pwIcxiyu;
	arc=none smtp.remote-ip=209.127.230.112
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42478606A31C
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 03:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42478606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=pwIcxiyu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1795059126; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=PJA8HI/26n09BDtdxwvrwKrlkq0uzVECslo8UM0vFOE=;
 b=pwIcxiyu58O8mtEa60Kd5PHF/aqExu1gO+sMih2b3/WHi55PHH/m53gFeaokF/bfpcURpa
 ibYacbeG4ja6S9EGC0mGjsgT7ACKfZpa8+pomwMnuCGkoo3++m3AA6AGJllBxAzl/BPpFq
 gbtSzE7Pl/ecLr5WSZucAqIT83ivSJlSRHaKbUggMiOSyL6BuB4gw8rwx2Xq+Ax9x0/VgP
 PLBx4ijd90kkfZHPm61rDtcCeKjTzTEI8QVPtZ86spKTrb5M9ykd+U36g2fO/TdrOGS1LB
 8yahnIZSdGAaneXpkt+jVH8/iH6n2FlV+VhilUllr4FC4UFlFfE3PG2lmzG+gg==
Cc: "Keith Busch" <kbusch@meta.com>, <linux-nvme@lists.infradead.org>, 
	<linux-pci@vger.kernel.org>, <tglx@kernel.org>, 
	<namjain@linux.microsoft.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: "Fengnan" <changfengnan@bytedance.com>
Subject: Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
In-Reply-To: <8d42a690-79f7-4431-bffb-73decfc97dad@bytedance.com>
Date: Thu, 19 Nov 2026 11:31:50 +0800
Message-Id: <e5de8bb4-6605-47f0-98f0-d7246602e566@bytedance.com>
Content-Transfer-Encoding: quoted-printable
References: <20261013223543.395054-1-kbusch@meta.com> <16e8bc03-42c2-4bc8-bce9-dab49aad66b8@bytedance.com> <20261028150712.GA16374@lst.de> <auIRf1QATQjVDtkH@kbusch-mbp> <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.9ea1a2e5.340e.41d7.bbaa.69129ddcead9@bytedance.com> <8d42a690-79f7-4431-bffb-73decfc97dad@bytedance.com>
X-Original-From: Fengnan <changfengnan@bytedance.com>
To: "Keith Busch" <kbusch@kernel.org>, "Christoph Hellwig" <hch@lst.de>
X-Lms-Return-Path: <lba+26afe6db4+9347c7+vger.kernel.org+changfengnan@bytedance.com>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8

=E5=9C=A8 02/11/26 20:22, Fengnan =E5=86=99=E9=81=93:

Hi Keith:

Any comments?

>=20
>=20
> =E5=9C=A8 29/10/26 10:14, changfengnan =E5=86=99=E9=81=93:
>>
>>> From: "Keith Busch"<kbusch@kernel.org>
>>> Date:=C2=A0 Wed, Oct 28, 2026, 23:15
>>> Subject:=C2=A0 Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderati=
on
>>> To: "Christoph Hellwig"<hch@lst.de>
>>> Cc: "Fengnan"<changfengnan@bytedance.com>, "Keith Busch"<kbusch@meta.co=
m>, <linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>, <tglx@ke=
rnel.org>, <namjain@linux.microsoft.com>
>>> On Wed, Oct 28, 2026 at 04:07:12PM +0100, Christoph Hellwig wrote:
>>>> On Thu, Oct 22, 2026 at 05:43:54PM +0800, Fengnan wrote:
>>>>> Hi Keith:
>>>>> =C2=A0
>>>>> I made some modifications to DIM and then implemented a solution
>>>>> using the DIM framework.=C2=A0
>>>>> Based on current testing, the results are now comparable to those of
>>>>> the previous patch.
>>>>> Here are the preliminary test results:
>>>>> https://docs.google.com/spreadsheets/d/1e8LQPnaDhmv50XlAM3XxI0TMQkhbk=
0bTZwlJP1Hzzdk/edit?gid=3D188992110#gid=3D188992110
>>>>> =C2=A0
>>>>> If you agree with this approach, I=E2=80=99ll continue testing and op=
timizing.
>>>> =C2=A0
>>>> =D0=86 can't speak for Keith, but I'd really love to see this going fo=
rward!
>>> =C2=A0
>>> Same! This is a great problem to solve, but I'm just sorry I don't have
>>> more cycles to work on the cause. I can quickly respin the msix noflush
>>> pre-patches to address the naming issues tglx mentioned, and we can tak=
e
>>> nvme in whichever direction has the best performance.
>>> =C2=A0
>>
>> That sounds good.
>> I'm currently working on continuously optimizing and testing both
>> approaches (using DIM and not using DIM).=C2=A0
>> I plan to update the code and add new data again next Monday.
>>
>> Thanks.
>=20
>=20
> Hi Keith and Christoph,
>=20
> I've prepared two implementations of adaptive IRQ polling: one reusing
> the DIM tuning state machine and one using an NVMe-specific policy.
>=20
> I tested both with a 158-case fio matrix and additional latency and
> CPU-contention tests. The results show broadly similar throughput gains
> over their respective OFF baselines in the tested workloads.
>=20
> Test data:
> [1] Non-DIM version:
> https://docs.google.com/spreadsheets/d/17kmXH9Zkr2jrN-19BwaInSx53HwOdRPJF=
rZ-Hjlk0_Y/edit?gid=3D300100#gid=3D300100
>=20
> [2] DIM version:
> https://docs.google.com/spreadsheets/d/18JADnBXWAGkffY_3LsPJ6ftA9DGH6qpNb=
KvP-lQWLnE/edit?gid=3D300200#gid=3D300200
>=20
> Both implementations are opt-in and choose between IRQ completion and
> timer-driven polling per I/O queue. They evaluate samples of at least
> 32,768 completions and use a target polling interval of 10 us. A polling
> trial must improve the completion rate by more than 1%. Once successful,
> polling can continue while its rate stays within roughly 1% of the saved
> IRQ baseline, subject to a completion-progress guard.
>=20
> Neither implementation uses I/O latency as a tuning metric.
>=20
> The non-DIM implementation uses explicit rules inside the NVMe driver.
> It admits polling trials at an IRQ completion rate of about 100k
> completions/s per queue and applies a fixed completion-count backoff
> after three consecutive failures.
>=20
> The DIM implementation uses IRQ and POLL as two profiles. It explores
> polling without that fixed admission threshold and requires a trial
> to gain more than both 1% and one completion/ms. While parked on IRQ,
> it increases the wait between trials from 1 to 2, 4, 8 and then 16 valid
> IRQ samples. It also discards stale samples and stops the polling timer
> when the queue drains.
>=20
> During development, I felt that the version with `dim` required more
> rules to achieve a similar effect. So, I still prefer the version
> without `dim` because it=E2=80=99s simpler, easier to understand, and eas=
ier
> to maintain.
>=20
> Which approach would you prefer?
>=20
>=20
> All the patches are in the attachment.
