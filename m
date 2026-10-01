Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23047206F
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890726; cv=none; b=TxjlLbceO3ArQ5j4U7DWem97XBSZSKnheUiwZS80bNezyXSFwq7VuhZt/hvmPT9oxKjB2fUMPyzciKwDVQm+JAJI2GWhvMG383eIBKPw0h7OtmZso0KAxE7HpbG7JnhymB0xvh0kA72V7CoWsZO+UhajJ81+D9+1ch18gdBCsaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890726; c=relaxed/simple;
	bh=A3Kob3V4Yu3iHrD9Ak0AoUPAtSE9doe/SGvyKrqKS04=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QG8tqIAgCx3XkKSr3DhOpHmSGvpySO7JoNpFiKk9/CiWTUTKfYom019Jmslg2xzt+rMQhu27jEkvLwCWZa9h8rZseMcMMs5kHl8hO/Vo3JhlS5yJ6tP7N61oyDlG+DFtbSC3PPmR47aYS3qqnYxl1RkDbD7NjKW8PR2FhO4/mno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=No80NpFh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BfTPewuI; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="No80NpFh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BfTPewuI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 26B887A0156
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 17:38:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 17:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790890719;
	 x=1790977119; bh=foKCvGIwn36eZyqZp/q9QEf+xEnfIfo5MgV4pCykpWw=; b=
	No80NpFh9VtJzEPjVzH6YjHk/JHyrKah20k7zCtEejB1VI8Ls9wpDybxcKJ1HQ01
	pFfAGh6RxSB6ujy81M8t2rLnFBzgf4nGCOK779mWtNG4WfN3ZdVypjuox5TM/Qim
	Xv/W8uBxFn1HoFp33BeYhidJhO7Eu+0i8v6uWL7S+a+OfKE07V/HUKd+BT+a4Aow
	PH7kTvz5u3LW0AME/XXhlOkcl52xs6AepBcM9DxzyXelSDLfraFym55q+nIdL6jM
	jK23jRVT1ozskGTx5zHa03bFEAZts27RHKJk/MRezvBg9aUN3i1NFoX9K5hb8+xt
	yQv3p4TdGxCguqGIVukPGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790890719; x=
	1790977119; bh=foKCvGIwn36eZyqZp/q9QEf+xEnfIfo5MgV4pCykpWw=; b=B
	fTPewuI9zRNqULFSWOmlXCr6FMXqvafnYUeXrZu13Cosbsm4gu2mZ928ir2BW6fI
	pdsweg0x7chGqPO4O9x58lbhcO6fr3hgPdL+VY0LMvJecX2v+1ToA8dZsaXXJz+m
	ffvL4CUvM71yT+Mk5YFPOBw2+zN75SVw3X8KgvbWn5NItZppvPOM3NvtirrD+YTC
	dgRrn3wvrTLBzggOQpo3dEeLobMocY+mcDeCAIt2mSY+FFHmyxZ22z6AG4MO/m1+
	DCwDAckefc2w3ELV9bp/TqBuXf5nGGidnpJHKbhdyQtMt/VKHZ2uqFf4dSA5es0Y
	7I82cPIXckdfC+5RfKxjA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790890719; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:xK1G4aklK9XKEPTPN5XNNK89yIKmpen9A9R6w3yAknwRo+r
	uqMVOfPpqn1warLL/+jZIE+9x+8EQtud4L/2Hw2vtrXpcNQdqBTaBje0FiZ6qnvg
	gxvlSH3RbXaHFksLdG4iVZcYwYFwPUbSlvpfk++tnXyjdN8LBXVChN1zxuTHu20b
	Dd93m++mYEK02swGns7kaMO2fvKOrDbQohh90n11f+EmUNJTuzzYA4O83xtYxkn7
	mPKMGXeHNA8lD9DZC5oDVQluHjFFsQVKs8zAH/yk+1iel5uGneA9GLaVk4ccPECl
	1zUgYTq0ZzqNuLS9XAMgEWyBQ41/38yfo3qB0qQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nmZX/2Jo9x6oEAom8tVOzN6xUvhAb+27SXfcDDazOMk=:A3Kob3V4Yu3iHrD9Ak0AoUPAtSE9doe/SGvyKrqKS04=;
X-ME-Sender: <xms:3tK-ahLuGtB7ifDqzbCX8YvLK1FqDI5SnD1y-Fbg6XSYqCKjwKbsew>
    <xme:3tK-amN_YjvdXPgjoEtLNaEF-IbqN8WQHubA0KGMlYj7mMN-bz_MAjZVtgmmvAgr8
    8w9GMFuoUDfcP7Ai4gDLnz9912R9JLg-Jxf6BhhoHQIKs--S-sU-Q>
X-ME-Received: <xmr:3tK-aiyMExU9nP8QcP9Iw876aPvs7PgS-IGXJW-h60HlySoIampFBX4-0Q545A>
X-ME-Proxy-Cause: dmFkZTGH7Rp125fuiTBE0ZthBe9aERn5bLSNSBdrsSiiYO3UBnkmLsJVXBmJQepqh/shKm
    +5cqXfcLVfT1zhRzeZ8fhTajDsOs6e+PLlMZQGpC0Y6MdxvdjHAv4K604xkJoTVV9fYqC1
    mmtNH9CdK6jEua7RIMtBR2PbpBVqLP+1nsR9xjHN+LaP0ypBSQSMFZSSDzbjd3gJGwYwqQ
    2Bl2O02m0MFuZr7V6XeXMiFcYaFMklhVwkqNqMyeQ4JVgv4YG4RX2A77VLwMEIn3dYNqo3
    uRrz48p8tZMZWGkBWiEvtlJLArr3o9I3ZcT0S/kzDV7jVehDt/MgUTe1HQlsPUbHRVimlL
    1EuaWlSCgYvwTo0JUoRcivblyxEsheGLQ69Q6XIqgXkrm95QhVoWAUu2pt6mhsnEVVIBj1
    8fQ9GoGP7UDobsWtDOhqLHtTryltwXmgSjASkKekXQ5U4MnmhvkWAak3A4/k6R15emG6tu
    mtrpHTb5Ei2AKxhRCTSjjFoUMpgjTV4CPNn4yHHAsrTZtH0ftKaCBfMdaNHXdWNJe1vpc/
    71DrgR7qlZFMiDh/3ct8HVu8LjNCxbQPTcXEwH80HLSU5rENNchIEBepJAumJNfxgEgVbG
    cpz3A2SzME7kxu4arVJZkAJdthhEMqzwgo9EjD3OfxtBMf0t78DjNFqY8oWQ
X-ME-Proxy: <xmx:3tK-auK1tApIYxv8QbiLFJ_snJ0N0zhvygpROwNE_27wncHkgUgTXg>
    <xmx:3tK-ahqEiumQaccuT3mJ2kPBSp-NYaA6xVBzQtxW3WlL29H-MeZDiA>
    <xmx:3tK-aktSUh6hDnyKnaGOfy_AC7cMwdB2qWgSXyUEFx01bX2vXIuaWw>
    <xmx:3tK-ahJBqPyBEG056ngxcEbETy2P7nNeabtK9fqW5X54yOmpTh5Wwg>
    <xmx:39K-amoJdlU5be1Kh4XsC_M5aDdEyqUQxRaiNifiMidDvpUNNH7xcnkX>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 17:38:36 -0400 (EDT)
Date: Thu, 1 Oct 2026 15:38:34 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Logan
 Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair
 Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org, Manish
 Honap <mhonap@nvidia.com>
Subject: Re: [PATCH v7 0/9] vfio/pci: Add mmap() for DMABUFs
Message-ID: <20261001153834.4a2528a2@shazbot.org>
In-Reply-To: <20260924152159.49702-1-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 16:21:43 +0100
Matt Evans <matt@ozlabs.org> wrote:
> Dear Reviewers,
> ===============
> 
> Along the way several related issues came up that warrant more
> eyes, and I'd be grateful for your input:
> 
> 1. If VFIO fd is opened O_RDONLY, it currently can't be mmap()ed
>    (because PROT_WRITE is rejected in do_mmap(), and PROT_READ alone
>    drops the VM_SHARED so VFIO's mmap rejects it).  BUT it seems we
>    can export a DMABUF from it, and then pass the resulting fd around
>    for P2P writes.
> 
>    I don't know if this is intentional/relied on/a known limitation,
>    or a bug?

Seems like a bug.  In practice it's probably not very meaningful, the
user can still potentially change the device power state and trigger a
reset, but being able to source a writable dmabuf to a region on the
device fd that isn't itself writable seems semantically wrong.
 
>    a) We could reject export w/ -EPERM unless the device fd's f_mode
>       has O_RDWR, to reflect the RW abilities of P2P

This seems sufficient...

>    If we agree it's a bug, I want to do this fix (a), as we can now
>    export a DMABUF RW from an O_RDONLY device fd and then succeed to
>    mmap() the DMABUF with RW.  (That said, even with an O_RDONLY
>    device fd, the device state can still be changed/reset.  But it
>    feels cleaner to prevent export for a O_RDONLY device fd, and match
>    the device fd mmap() behaviour.)
> 
>    In future, we could consider finer-grained RD/WR if there's a
>    future goal to tie DMABUF permissions to, say, iommufd
>    IOMMU_READ/IOMMU_WRITE permissions:
> 
>    b) Instead of just failing if !O_RDWR, we could limit the
>       get_dma_buf.open_flags to the VFIO device fd's f_mode, such as:
> 
>        VFIO device fd perms:    Export flags:           Result:
>        O_RDWR                   O_RDWR, O_RDONLY        OK
>        O_RDONLY                 O_RDONLY                OK
>        O_RDONLY                 O_RDWR                  -EPERM
>        O_WRONLY                 *			-EPERM
>        *                 	O_WRONLY                -EPERM
> 
>      (Skipping WRONLY because a PROT_WRITE-only mmap() won't work,
>       though it probably should be included for P2P.)

Certainly more complete, but I'm not sure there's a use case here that
really warrants the effort.

Another angle to the dmabuf permissions is the region permissions
themselves.  We don't currently hit this since we're only exporting PCI
BARs, but for instance Manish wants to protect the HDM decoder range in
the vfio-cxl series[1].  Again, there's probably a simple solution to
simply consult the excluded ranges list, added in that series, and
reject dmabuf exports overlapping it.  I don't expect any action item
for this series though.

[1]https://lore.kernel.org/all/20260916183540.3813685-1-mhonap@nvidia.com/

> 2. The mmap fault handler takes a bunch of locks non-interruptibly,
>    and potentially depends on a lot of DMABUF-related activities
>    completing.  I'd had a go at converting them to
>    interruptible/killable forms, but that revealed there seems to be a
>    wider issue if move/revoke doesn't complete in a timely fashion
>    (due to buggy importers).  Where I got to was that just updating
>    the fault handler won't fix the user experience of an unkillable
>    task, and move()/revocation will need thought too.  I don't intend
>    to fix this here but wanted to start discussion so we can address
>    it in a follow up.  There's now a dependency between mmap_lock in
>    the fault handler and the DMABUF resv (which might take a while to
>    resolve), though revocation will be rare in practice.
> 
> 3. vfio_basic_config_write() has an error path if
>    vfio_default_config_write() fails that releases memory_lock but
>    doesn't un-revoke BARs in the case of PCI_COMMAND.MSE being
>    cleared.  When can the write fail, in practice, perhaps surprise
>    removal?
> 
>    The effect on this series would be: a write of MSE=0 revokes BARs,
>    vconfig[PCI_COMMAND]'s MSE becomes 0, but if the physical write
>    fails then the physical MSE remains 1 and BAR VMAs stay revoked.
> 
>    This seemed a mess; fixing isn't as simple as un-revoking on the
>    error path since vfio_default_config_write() has already trampled
>    vconfig so that'd need unwinding.  It felt like a catastrophic
>    scenario where BARs staying revoked isn't a bad outcome, but want
>    to hear your experience of the likelihood of this issue.

Our vfio-pci story around surprise removal and DPC is pretty weak, I'm
hoping that some of our parallel error handling work will shut down the
device when this occurs.  For now, leaving the dmabuf revoked seems
like a reasonable thing to do.  In practice, I don't really see this
coming up other than in testing surprise removal of NVMe drives.

> 4. The exchange of a VFIO fd mmap()'s vma->vm_file with an implicitly
>    created DMABUF's file has implications on LSM.  For example, an
>    mmap will be checked against the policy for a VFIO fd, but a
>    subsequent mprotect() relates to the policy of the DMABUF file
>    (which is anon/unique to the mapping).  This is pretty confusing.

Maybe I'm not seeing the issue, but this seems like correct behavior to
me.  Policy decisions are made at creation time and later changing
protections on one object doesn't affect the other.  Thanks,

Alex
