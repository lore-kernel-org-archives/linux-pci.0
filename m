Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA8C3F9F3C;
	Fri,  2 Oct 2026 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949926; cv=none; b=oml66BDHdDG7RaOtFUSs2g3MvmEIjpp6R+wo/B/tXFPNaFTp9NIAon613XTWe8WORxtulW5pklHrSNj6S7/u7xh/THbUK9/lST9QJdMYB1K+QiRpQ0Bx8igftbwxrMVGTXW/Wl8W5/wySi0gWJOilik/g328KD8IbJz4DzJTenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949926; c=relaxed/simple;
	bh=1vxcTXuBCxqXwoQBIzmW3rqlvuTa07ZNaVeUtHOifdM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QGpXFjEK6Ys5ufnCbKTY33oR0r2vAbH5xrFiaGHOTMZquMTDJ7GcZZJvvIehfyXbKGPN/7ng5S4V0yNWzN9g1H6INPOeuupAVynXPoagV3uKhUXtX4xpzeawTHmvn2MWig9+icblupIkgnF1Tz5oP3o8nk4hZSgKJlo+ptd070A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=dZhb3mgq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="dZhb3mgq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1790949882;
	bh=BAoZsisDnlY0LO+TduzgC6g/Q+8iWDR6OcyZyRZyWNU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=dZhb3mgqrZGt9We8M7wy4kUi8RDLqBxp+dSeqrnGinNUgE3cp2JCb5g25ZszfRS0/
	 3OQomL/ZZan98v95D1OLV91MUwsfSec3jzmKoviInvLYlqlKacVZT1GiqhK32xg9XR
	 gYdceKx7LwwI51NMR/g3I6NMROCse5XRMAc6lO2lI/OSDbXiiZzAhaLAQYS2a4Ke0A
	 k9lQIs+pvIsTnYyw+8whPYPvnv2FsL8YH1Qw6gKWEds1EM/YtypDZhAZe2jXUa76IP
	 6WR91iWgzB5042mky/irVF1YtzY5eNSasK1Oy8mRFJw3jgAHLLqRe91tmGqdx21OnK
	 Z+tWDurs/SNEw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hx9Wh1Pvtz4w1l;
	Sat, 03 Oct 2026 00:04:31 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v7 0/9] vfio/pci: Add mmap() for DMABUFs
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20261001153834.4a2528a2@shazbot.org>
Date: Fri, 2 Oct 2026 15:04:49 +0100
Cc: Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Manish Honap <mhonap@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A758FB87-95D3-4CE4-87C8-C50FF0ACE026@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20261001153834.4a2528a2@shazbot.org>
To: Alex Williamson <alex@shazbot.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hi Alex,

> On 1 Oct 2026, at 22:38, Alex Williamson <alex@shazbot.org> wrote:
>=20
> On Thu, 24 Sep 2026 16:21:43 +0100
> Matt Evans <matt@ozlabs.org> wrote:
>> Dear Reviewers,
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>=20
>> Along the way several related issues came up that warrant more
>> eyes, and I'd be grateful for your input:
>>=20
>> 1. If VFIO fd is opened O_RDONLY, it currently can't be mmap()ed
>>   (because PROT_WRITE is rejected in do_mmap(), and PROT_READ alone
>>   drops the VM_SHARED so VFIO's mmap rejects it).  BUT it seems we
>>   can export a DMABUF from it, and then pass the resulting fd around
>>   for P2P writes.
>>=20
>>   I don't know if this is intentional/relied on/a known limitation,
>>   or a bug?
>=20
> Seems like a bug.  In practice it's probably not very meaningful, the
> user can still potentially change the device power state and trigger a
> reset, but being able to source a writable dmabuf to a region on the
> device fd that isn't itself writable seems semantically wrong.
>=20
>>   a) We could reject export w/ -EPERM unless the device fd's f_mode
>>      has O_RDWR, to reflect the RW abilities of P2P
>=20
> This seems sufficient...

Thanks, I=E2=80=99ll take a look then.  I should=E2=80=99ve said this is =
cdev-centric=20
(an explicit open O_RDONLY), as VFIO_GROUP_GET_DEVICE_FD always
generates the fd with RDWR perms.  The path from container/group open
through to device fd generation and then export is similarly=20
semantically weird, but maybe less clear on effort vs benefit to fix.

So, for cdev open it looks like some plumbing, and that it won=E2=80=99t=20=

conflict with this series, so I can look at that separately.

>>   If we agree it's a bug, I want to do this fix (a), as we can now
>>   export a DMABUF RW from an O_RDONLY device fd and then succeed to
>>   mmap() the DMABUF with RW.  (That said, even with an O_RDONLY
>>   device fd, the device state can still be changed/reset.  But it
>>   feels cleaner to prevent export for a O_RDONLY device fd, and match
>>   the device fd mmap() behaviour.)
>>=20
>>   In future, we could consider finer-grained RD/WR if there's a
>>   future goal to tie DMABUF permissions to, say, iommufd
>>   IOMMU_READ/IOMMU_WRITE permissions:
>>=20
>>   b) Instead of just failing if !O_RDWR, we could limit the
>>      get_dma_buf.open_flags to the VFIO device fd's f_mode, such as:
>>=20
>>       VFIO device fd perms:    Export flags:           Result:
>>       O_RDWR                   O_RDWR, O_RDONLY        OK
>>       O_RDONLY                 O_RDONLY                OK
>>       O_RDONLY                 O_RDWR                  -EPERM
>>       O_WRONLY                 * -EPERM
>>       *                  O_WRONLY                -EPERM
>>=20
>>     (Skipping WRONLY because a PROT_WRITE-only mmap() won't work,
>>      though it probably should be included for P2P.)
>=20
> Certainly more complete, but I'm not sure there's a use case here that
> really warrants the effort.
>=20
> Another angle to the dmabuf permissions is the region permissions
> themselves.  We don't currently hit this since we're only exporting =
PCI
> BARs, but for instance Manish wants to protect the HDM decoder range =
in
> the vfio-cxl series[1].  Again, there's probably a simple solution to
> simply consult the excluded ranges list, added in that series, and
> reject dmabuf exports overlapping it.  I don't expect any action item
> for this series though.

Interesting, thanks.  Reading.

> =
[1]https://lore.kernel.org/all/20260916183540.3813685-1-mhonap@nvidia.com/=

>=20
>> 2. The mmap fault handler takes a bunch of locks non-interruptibly,
>>   and potentially depends on a lot of DMABUF-related activities
>>   completing.  I'd had a go at converting them to
>>   interruptible/killable forms, but that revealed there seems to be a
>>   wider issue if move/revoke doesn't complete in a timely fashion
>>   (due to buggy importers).  Where I got to was that just updating
>>   the fault handler won't fix the user experience of an unkillable
>>   task, and move()/revocation will need thought too.  I don't intend
>>   to fix this here but wanted to start discussion so we can address
>>   it in a follow up.  There's now a dependency between mmap_lock in
>>   the fault handler and the DMABUF resv (which might take a while to
>>   resolve), though revocation will be rare in practice.
>>=20
>> 3. vfio_basic_config_write() has an error path if
>>   vfio_default_config_write() fails that releases memory_lock but
>>   doesn't un-revoke BARs in the case of PCI_COMMAND.MSE being
>>   cleared.  When can the write fail, in practice, perhaps surprise
>>   removal?
>>=20
>>   The effect on this series would be: a write of MSE=3D0 revokes =
BARs,
>>   vconfig[PCI_COMMAND]'s MSE becomes 0, but if the physical write
>>   fails then the physical MSE remains 1 and BAR VMAs stay revoked.
>>=20
>>   This seemed a mess; fixing isn't as simple as un-revoking on the
>>   error path since vfio_default_config_write() has already trampled
>>   vconfig so that'd need unwinding.  It felt like a catastrophic
>>   scenario where BARs staying revoked isn't a bad outcome, but want
>>   to hear your experience of the likelihood of this issue.
>=20
> Our vfio-pci story around surprise removal and DPC is pretty weak, I'm
> hoping that some of our parallel error handling work will shut down =
the
> device when this occurs.  For now, leaving the dmabuf revoked seems
> like a reasonable thing to do.  In practice, I don't really see this
> coming up other than in testing surprise removal of NVMe drives.

OK, cheers.

(Maybe a couple of these bullets are ~rhetorical, just to get a =E2=80=9Ck=
nown
wrinkle=E2=80=9D searchable somewhere.)

>> 4. The exchange of a VFIO fd mmap()'s vma->vm_file with an implicitly
>>   created DMABUF's file has implications on LSM.  For example, an
>>   mmap will be checked against the policy for a VFIO fd, but a
>>   subsequent mprotect() relates to the policy of the DMABUF file
>>   (which is anon/unique to the mapping).  This is pretty confusing.
>=20
> Maybe I'm not seeing the issue, but this seems like correct behavior =
to
> me.  Policy decisions are made at creation time and later changing
> protections on one object doesn't affect the other.  Thanks,

I think this is a change in behaviour re LSM rule, should anyone have
applied any to VFIO in any fine-grained way, so just flagging that.

I=E2=80=99ll send v8 shortly, resolving Christian=E2=80=99s request.  As =
ever, thanks
for the input!


Matt

