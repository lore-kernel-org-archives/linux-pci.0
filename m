Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFA447DFA8;
	Wed,  3 Jun 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512795; cv=none; b=Qr44e0LHSd472vYldoRssjKGMStqN7AkUoOUT2dmhnzrrAm2Kc0SOoNJviYbeiP+24aCC8rz+axdmFHDxsmdPJ/h865v9xH0zeFNYuItXVVVrcA5AYaEcRYOBOjDX8S7mk76fEraBCXORCkPpuhB3aLIci3NWJKww2S8T0QnClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512795; c=relaxed/simple;
	bh=mVbT7k1/qN7xKmRbynqTvZJgdEnKvVf5p/xZL3wfePg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCDo75xwiduUsqr4WzPoyvux1/pX0iI6+5hE1W++As07ntkq27KGT8gAYH3ja5rg/hsc/9hRCOovKiJQ+LVFpoUEaQ7WWNNkArP03rLmzipz6PAiWR+Hg01gjEOI1z7e4qSVRMCiPgaiFeLwsSP3AiGRY6iZXxBkqqDJfcWYHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=A4YPeC+S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YQdKCi/D; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="A4YPeC+S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YQdKCi/D"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB4067A00A6;
	Wed,  3 Jun 2026 14:53:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 03 Jun 2026 14:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780512791;
	 x=1780599191; bh=8wljJNHlry9YcAPBfCnl9IH179FU6WGGZsowDo9O5Pc=; b=
	A4YPeC+SWfoOeY3rKq83ZtKgZA6GUSJcO/9aUqc+iwgGJ8ZJjhi3kr1wgSkZCn11
	8Wy3qe9Tf7v0THZi93/F3hi8tRyWi9VqDLaE0WAtOiCWAp/k2OPBuUWbuaYGx0sw
	p4yvjXbMAGFPIAuM9pydbNvaAwfJE6bF4CD17JaGNxn3+2ZAKX2Thfv57/NfFkMP
	rwmTic5q7KTDBkUDiRgM/k93c4XdXi61n15sRgw14HkMnipb/Cd8MdrlPvOHD2JV
	Dvj0MTGfwzhPTdPrfLdMtmGbqeE3aHdv1rcpj4xSf7ejLFHv9UlTSSGHKiGwAlT2
	ZBKOaWqHTtsXjgGN/QCXkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780512791; x=
	1780599191; bh=8wljJNHlry9YcAPBfCnl9IH179FU6WGGZsowDo9O5Pc=; b=Y
	QdKCi/Dffo2fFp9yReIthQAcLDa9zBNvUZ5M2wUnv4oGePY59lZGGbR86Tg9kktI
	Yh0X2k/45GRBayXXZwF3yDXhYvwCIJIOVrShL4Z4tAa6PHJ5UgPA3yzLjbeEwg7Y
	bcAfUtvjEfHgoc5zet228kYqcxyoPkvIGQ6HrKSg28tbU7HZ8kQWeTJDJVDedPIU
	2Oadbu+b4Vwkc5LXXlpH42OtaR/jQzkp3teUJArxorMw6dJU/zEDDIMVdGRx0ZWw
	7uwrDbUjGjYXaVWfLcM6oejgbbBj93qOJ3pJLOe9+MFBtzd/F38v2r5XaxG6Kg4p
	z5F13mx33toaJX/yaWTzg==
X-ME-Sender: <xms:FnggavdZCbc8MtVrAVd2_6MK7syrMoq533lxCeqRBA7j1h0RBJ996Q>
    <xme:Fnggamx1MaozSPtu42bcY-y90tqAUqFImuuDGrg_bKAdlJxt8CkH_H9sBSKHJcGXb
    uPvLs07eyOSSwJsRDY54TSl2MDJ0A3XKOiIq8QGEa4ktXpHdzKdNw>
X-ME-Received: <xmr:FngganydqBSagYPmjC7cDwGyYEyBobPqE-UOfLH3j8TPsjFgijk6OGB1JUQ>
X-ME-Proxy-Cause: dmFkZTEPRM+mrew0zIQlYb5sH5cnFfUHsRDNq1OawcvFPUkOp5kVhP9xYpb5UEpb+ZLl7H
    6B2J8uthaOmhLi3ohaqRBHlU+4FhI+E2sUMy4bp6GePlo8ht02cycczIKpYZgABgQ4tFNz
    lP+b9MeqqdxoTRWqMSltLqq1lm+XdI7xePMTGOU4h2ICBGOcswvG9YcxIKmmxpCejIPqfD
    e9heJfwU5Qmzt/kdsDtjpVGAhma8IgrJ5rrENbVAju3m4b8UUqtP1TmfeWiSrsq0gDX835
    UX/F6g/SNuUTjaef4SPfaNWlGfyLk8/LYKAPJ6QeT7AJcyQBZnJgik4ip2CKk3ypVWlDTf
    Da4UaBZYuQChZti67v8PUBJ0prDL1Nb4Moh/1uO8e3lA8IL2m9cC9vpF8aB8UwnFmlWGtT
    A8Rne11F4oJuGKInDp2jc4WUsQwGJsJeQjrVsd+7T2fefG8vnKRh1Wrw/rBYZZlZpRvyEt
    YPY4hXsi7JLQ6hCnu745TIN0G5TJ23FSfgPLK5qsNVK2rhlPO91DrrvO38qJCWR7mrGW5H
    63VbvFf3+TDLZizoW/aXzvaF3+2kmTAaEmHCTPNUp96fbBwW3mJ/AwuyKTPDt+JYmVozMr
    ZCVxSQcjwKv6MmNLpz//vsnUqs0cXi4qn2xumtmEBRJUnXLcrX97MINhyu3A
X-ME-Proxy: <xmx:FngganZHlyoDbbUQH8dYXi0t3q4FsURvYnZHy27uHSC9ecssGTTclA>
    <xmx:Fnggag1__gpmiL7GAKBIMnYPxXI-QTjxGNUZvcVG3bgL0mVB7JA9Tw>
    <xmx:FnggahdF6AzXNyHq31GATu2VzJiBdfD6BJ2NbXoVuDBo3XS66Pw-CA>
    <xmx:FnggalI2HE3DRdSHWzNBVa38m6Za1Mfle7gAaU5dgpYXogTmm5Ao5g>
    <xmx:F3ggavgKqy1LbMw_WzAuE_URsqYayBwV_i2mAZCi_pLTWhX-KiVq1Hec>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 14:53:09 -0400 (EDT)
Date: Wed, 3 Jun 2026 12:53:08 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: fengchengwen <fengchengwen@huawei.com>, wathsala.vithanage@arm.com,
 helgaas@kernel.org, wei.huang2@amd.com, zhipingz@meta.com,
 wangzhou1@hisilicon.com, wangyushan12@huawei.com, liuyonglong@huawei.com,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v14 0/8] vfio/pci: Add PCIe TPH support
Message-ID: <20260603125308.0116aa14@shazbot.org>
In-Reply-To: <20260603004524.GL2487554@ziepe.ca>
References: <20260528124649.14732-1-fengchengwen@huawei.com>
	<20260601095840.3aaaa508@shazbot.org>
	<59c82855-59a7-4f0e-b534-d35535d04b93@huawei.com>
	<20260602170847.75bd159d@shazbot.org>
	<3f8d1722-6749-4f3a-b630-c96303cec284@huawei.com>
	<20260603004524.GL2487554@ziepe.ca>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 21:45:24 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Jun 03, 2026 at 08:34:53AM +0800, fengchengwen wrote:
> 
> > This translation helper is required to handle varied TPH configurations,
> > including cases where ST entries live inside device private registers
> > instead of MSI-X or TPH capability space.  
> 
> I thought we agreed vfio had to block that feature in config space due
> to security concerns? That's what enable_unsafe_tph is about, right?

Steering tags can effectively live in one of three places.  The
architected locations are the TPH capability itself and the MSI-X
table, where support is mutually exclusive.  However the device can
support either of these and still enable DS mode, thus essentially
a third location.

None of these are particularly more or less unsafe than another.  It's
inadvisable for drivers to write to the MSI-X vector table, versus
using the SET_IRQS uAPI, but it's not prevented anymore via mmap.  We
don't provide direct write access to the TPH capability, but backdoors
to config space are not uncommon.  So if we consider TPH itself to be
unsafe, all forms of it present some degree of the same attack vector.

I'm actually still wrestling with the question whether any of this is
really unsafe beyond the scope of ownership of the device at all.

> > Prior discussion with Jason (
> > ref: https://lore.kernel.org/all/20260414151125.GF2577880@ziepe.ca/)
> > indicated VFIO-PCI is the correct component for per-device TPH
> > implementation.  
> 
> > > The host-only opt-in issue above also doesn't appear to be addressed or
> > > rebutted.  
> > 
> > enable_unsafe_tph host opt-in already fully gates all new TPH ABI:
> > TPH cap + feature ioctl are completely hidden from userspace when off,
> > no userspace opt-in needed.  
> 
> I agree in general that the presence of enable_unsafe_tph VFIO has to
> report the per-device steering tags to userspace so it can program the
> device specific registers, nothing else can do this.

What's the scope of "nothing else" here?  The raw ST value for a CPU is
derived from an ACPI _DSM associated to a root port.  So if the scope
is that the kernel needs to provide that translation, I agree, but
where in the kernel it's provided may still require some thought.

> But I don't really get what is going on with all the new uAPI
> proposed.
> 
> I don't understand what VFIO_DEVICE_FEATURE_TPH_ST_CONFIG is supposed
> to be for, userspace should not be able to directly program registers
> that are kernel controled. In this case it is 'safe' and it should be
> only programmed by specifying abstract information like TPH_CPU_ST
> does.
> 
> I'm also wondering why it needs a shadow entry, that doesn't seem
> normal for config space tables..

As above, the user owns the device and even in the ~safer~ storage
locations we can't really guarantee that the user cannot overwrite
MSI-X vector table entries or manipulate the device to insert values
into config space.

We also need to consider how this incorporates Zhiping's series, where
TPH values can be associated to a dmabuf.  Would userspace get access
to those raw TPH values to program the initiator?  It must for DS
support.  Therefore the interface became one of the user handling raw
ST values and the CPU ID to ST translation became this ill-fitting
sidecar.

The shadow table comes about because we don't know until the mode is
selected whether we're using the DS (effective) location or one of the
architected locations.  In fact, the internal kernel API doesn't even
let us even set a TPH value without TPH enabled, which presumes a
specific programming model that may not align with userspace.

I had envisioned that a shadow would also provide symmetry in the
interface for the DS implementation, but I was never really able to
make that stick with this rapid succession, no pause for clarification
or discussion, development style.  Thanks,

Alex
