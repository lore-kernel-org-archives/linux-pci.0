Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BDD554089
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933275; cv=none; b=Vj4AVfgdkjk9xlGYqU7MW2kOuJd8k24cmHUva0P0jKGKNBW+8iErGnKTLJXAcK5GpbY8KgMic1l7HyuXBRBhZgBb7x5ICxbhhyCITgwpkz9K2OoXxyeIS9FtvOPkwUM6LrsDvZ9UON/zNL7MxzQasw12FzjJ2Va2qdzuIn84Mko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933275; c=relaxed/simple;
	bh=Leu6Vw0vpHNEmrDvmbiE7XSoF7VFKBhfY7Qt5b2AHjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVQJ3ovOlzaszsNB3YLnSS7JYyrM3KBJdeQumJOIkDC6mVbadtcXDL7JUlHZLaaKbX9ZwPzTM75et/E1rFGoDALzDV4eoJjtyO0E4hJyVd/Az/RqPV9HmIcu8pJgJpqhIFoxe7x7gE9dkPpJ9HLpAwcg+CLzBsW52iDosQyJkGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=iUEZdbws; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cUpa9VHz; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="iUEZdbws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cUpa9VHz"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D2251D0024C
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 19:14:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Oct 2026 19:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791933269;
	 x=1792019669; bh=NQjoiq9XP9LFknAJ3kp7KjC0ecGkyT049eL51lOLhlE=; b=
	iUEZdbwsxwwDZaozB9/BuK183J5S9cnWz/WMBpVg3o8o7vaD4F4V9J6nuSE6I+l5
	JbEUOxV8QEq1zgyTvWXymuHpLkExC7M1yA6o4A7G3IZjApsl0CndzG8lWn/8lsYS
	6u1B1NzZSafhxuHzB7yI0lqg3MqO4hccG94SKa5HS+75uykni/cY5/i8P27XWy8t
	PWBpIfyf9ZMazQjru9A6Wn7elwSCAk/jSvbP0PV5gFn19FTcQXDhNQt8VRDCdXBl
	0LpWrrrOMxqnHRgvF1cvUZdUK1aI/5ZAsOs+6OcofII3O0aDVCYJDWK0Q+QwQVtK
	ElqXc8qzFvUDybhwiwoNKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791933269; x=
	1792019669; bh=NQjoiq9XP9LFknAJ3kp7KjC0ecGkyT049eL51lOLhlE=; b=c
	Upa9VHzvXzEjLXXKhu7hj1ubeMrmgMJKbAtcSwyu0p013wzqTS35f0zdReGYQZ/l
	q5ISKzcGN7boIcWDVq7kWYoith59K8C3SwJSlqq3m7bh2IlAzbFxnD327wdxcW7X
	Sed6A9JBxUXlqryOZTCw+PDdoeytYrF7F82C4arDzeDERBgn5ukLHtXjyTaSv7YR
	rUUnSY9zot+fBBAu9ygrdUvP9fgaxgm69XFWX+7k+WNtpfsGsJJt82THxBfxRgN1
	bkjch+cM4SExNfFJlmqh48S3NW04SjdotDvrdoHMGN24b1ovyFnNfAEm/DdoPMSZ
	tc3rcVrrC5khUygU8GfMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791933269; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:YPOnrewRTf9idt0fFB3ACVWoidEMTO3fJn4Rh1+AplFhpSf
	RmnJ7KawDglYiTQiGRsi+b+F0XJFKFsW9UTA5LbdEKKfMI/Im1Cua66QyXBhI8Ye
	Qfd7BdiZJsV61zfcZedjujGFd6c/pymyWyFmR1Zo+7TqOgLlcO49hB/eE0tmwWfy
	W9d9V6ym/n4q83GCx2gGnne8KvvJznjz834I4sfHYfRTdmX9GJvzmCjFmrdht5Z6
	KIZ5470Zy9guTRcPRoxfLIiLK5sKVy0g5CT2ysw0NZSr5zcOJkbrI/74m1VEhope
	yjIw33p1UqT6UWydrougwFzVk3uhEjnFowhMdMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:5MJmPZHPOvi/77PJDsQpXVp2EVB1Msp4/Dx+XYDbLCw=:Leu6Vw0vpHNEmrDvmbiE7XSoF7VFKBhfY7Qt5b2AHjE=;
X-ME-Sender: <xms:VLvOah8_WGMYa6INKZ1z5h2roRnaC9OrHLbwv2hRCjh6O_1gq6aWkw>
    <xme:VLvOanXBpb2S0of_hkQoCYO94T5lc4ugb3uLXbroIUyriNL2mGO_iFSHnQvs2R8GM
    ljinetyhlT9-sDnUiU_gvwOW4TiDuY0hRcRxNVXs0yc42TFkn4GBQ>
X-ME-Received: <xmr:VLvOajFiAOBowgPEq2XFLGZbJu8gjGyxVlcc6-iI_4CYMXV93hNT9py8XzNvgA>
X-ME-Proxy-Cause: dmFkZTGh5K968C2Cl84ptSi+4y/RZ/kVjRI/KuhQFT9EdVF+wlBRkUV3+MnA4Bw8USczqh
    K75Ks9fzzqoUpxb7GlBjbnkhjHyFx4/Ig31C73IxKiEP0jiid6Tlem7NohMXSaR+5FMEhK
    ifHB8gtzfUTonlinprF4mw7WPTut7T/J1hPsQXDLSJK0xqaYcZbKfDVq23wYMjW2iywqpO
    ZIPaJ4ce5Zm6PCb9LkghPIarZYc8Qnu+WxwoCZiOXCKojQi16QdbuVc39mEboH71fqwON2
    cQwxZsIGEE5+oDvRemv0bEM6otLHIcNZE8FD2rvXxw3NzcIK91ZKa9ZQuG1p86j7bXidqg
    9t7XpO1m33t70nRirV2e8oBS+42WIdnLfO+kmjzhh5gMp7XMl+KA/ylaNrUUgu6gGK0PPF
    lUgfUZgOLd49zMhJAvU2lSSg2c85sn3+wNOprf/LJIUwMstPZKOUgFkE6eg7EaD/oTLewF
    zXb3PIOREKAFOkIsX7d2/8qzL7q/ZqXmJd09YA5B5rWEns5/aZIPnzgpeUsek2oBVCBDmq
    lsdcX+U6YXwm2sOWsNzHobpXizo6O0hlmX51X9NbO82zafH7GZaPlFXkIyamzs/ixUcFwG
    4gukCxJf9rLW6ahEI0OUfdWCjaxw6dzi8V2h5XIIAIQ8QucJZYqcKSjSHHOg
X-ME-Proxy: <xmx:VLvOar57n4H-VoKTJoNKVbGEEJuY5a2CJsHNa4-X3xXLmURhq9HI4Q>
    <xmx:VLvOalIANx-diF_HWWV-_ZVeN11a05G_zfEOQC-6NrBnD2Qweam8AA>
    <xmx:VLvOamDCnR515Ox9p0dMhXH5924f7Xmfhxrk6yPRXQKNhW_5gRoxiw>
    <xmx:VLvOarQTeo5Yep6TJDRUh3BBRaDjHR8Afq4SZ0NGoqWOqHsGyXLP8g>
    <xmx:VbvOardrZ84kPc22JimwUCtlE7wxRYU6hJ_24_56muBfKkwTCs-84Isd>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 19:14:26 -0400 (EDT)
Date: Tue, 13 Oct 2026 17:13:47 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
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
Message-ID: <20261013171347.54e856c7@shazbot.org>
In-Reply-To: <20261006193643.76330-9-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
	<20261006193643.76330-9-matt@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 20:36:36 +0100
Matt Evans <matt@ozlabs.org> wrote:

> A VFIO DMABUF can export a subset of a BAR to userspace by fd; add
> support for mmap() of this fd.  This provides another route for a
> process to map BARs, in which the process can only map a specific
> subset of a BAR represented by the exported DMABUF.
> 
> mmap() support enables userspace drivers to safely delegate BAR
> sub-ranges to other processes by sharing a DMABUF fd, without having
> to share the (omnipotent) VFIO device fd with them.
> 
> Since the main VFIO BAR mmap() is now DMABUF-aware, the new mmap() reuses
> the existing vm_ops.
>
> The lifecycle of an exported DMABUF remains decoupled from that of the
> device fd it came from, i.e. the device fd could be closed with DMABUF
> VMAs present, meaning a fault on a VMA could happen concurrently with
> vfio_pci_dma_buf_cleanup().
> 
> To deal with this scenario, the fault handler now temporarily takes a
> VFIO device registration to ensure the vdev remains valid, and then
> vdev locks can be taken.

This sounds like potentially measurable overhead if something is
slamming the fault handler where huge-fault is not supported or active.
Have you considered a fast path for the internal dmabuf where the
lifecycle is constrained?

Hopefully we can get those selftests included to avoid regressions.

Overall, I'm not finding too much to pick on in this series, but it
also hasn't collected much in the way of reviews.  For a fundamental
change like this, I hope we can get more eyes on it.  Thanks,

Alex
