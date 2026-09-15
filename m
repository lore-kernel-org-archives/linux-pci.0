Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977843C0A0E;
	Tue, 15 Sep 2026 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482646; cv=none; b=BBTxgRKztbTWlHURd02oIRhymb2XZwcxyxIgWsUMtojflipx6CHuZBPdjbkZnIHQKiQTuuOQZ6QRblzIOH64dGqtda+CCnRRSNkZyN/StLP9XWIEqfzrni1XaOcMKbJm5k9zJzYERxO5HJEtBPR92j7O00psKYtq1lIR42rKKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482646; c=relaxed/simple;
	bh=twc0fIx68+kEF+cShbyc3RFtm6NSYj1UGSjcKRuPYUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F67wG8K4e7Okf12j75h4josJW18VBi4XRAi0L0xU7nb0AqCoIgf62WuSlIBExq9a99NOuGQHhnLoO0w/NrSpVsZtRswNlSc/NqiYWcxR/P6kT05tZj+ySc2YSrfyJGEl+p0G94aTQ06JrzG2mdmBejgm2O/XWI75cXE5wj/gnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=HW2jWuBP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="HW2jWuBP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1789482627;
	bh=5x9PVSs1pegITND9ej196jOTL1wg1+lrDdeCERTcAHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HW2jWuBPYllN+POQQWsl9SXygg0v21ChZrs/LiJUyRXjiHTCByo+VsqV60ZoXKldG
	 41ptofyOkN6OVSCyTCHR1WdrTkrEsJKjSkPQlI5Wa8FHPCkNND6LisEhHlWUAj+7sG
	 hkMOgFOh1R0i3F96CpuT5OBkKjiv4ltHfiB3h1SVGuIPXLzKURaSl6QI0Gp8mRSgC+
	 3H1F//DVOQSEQpXu4fmWDq+E8cGaV+JG1rdwfJLGt7FW96YUuatkZBB41ZOlAL5bBe
	 i6BMmYH83fCJ51UmvwtyS/Z5dmcwwO/zQXESU2QH7hNId0BzSxx71viz2QtOnjk9sj
	 rwR69zCQL/Qxw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hkkvH33lkz4wBB;
	Wed, 16 Sep 2026 00:30:19 +1000 (AEST)
Message-ID: <9ebcebb9-94a5-40b4-8764-5d70ea465f9c@ozlabs.org>
Date: Tue, 15 Sep 2026 15:30:32 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org> <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com> <20260914115456.GY13683@unreal>
 <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
 <20260915123517.GS3968357@nvidia.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260915123517.GS3968357@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,

On 15/09/2026 13:35, Jason Gunthorpe wrote:
> On Mon, Sep 14, 2026 at 01:13:36PM +0100, Matt Evans wrote:
>> "This is useful for lifecycle management, to reclaim VFIO PCI BAR
>> ranges previously delegated to a subordinate client process: by
>> revoking, the driver process can ensure that the loaned resources are
>> made inaccessible when the client is deemed "done".  The original
>> DMABUF is defunct, and BAR resources can then be safely re-exported
>> for use by new clients."
> 
> This makes the point clear, you want a way to permanently revoke a
> specific dmabuf fd and render it forever unable to access any
> underlying memory.
> 
> You want to do this so the vendor can fence the vendee without
> requiring its co-operation.

Exactly!  (I'll reword this commit message still, re other requests in
this thread, but you got the concept.)

> "temporary revoke" ie what VFIO already does around reset is a
> different thing.

Yes, right.  From the DMABUF importer (and now mmap) perspective the
mechanism is unchanged.  priv->revoked was always "temporary"/transient
(OK, splitting hairs, but at VFIO shutdown an exported DMABUF becomes
permanently inaccessible).

Here the only change is adding another cause of becoming inaccessible
(direct request from userspace) and the length of time (it can never be
re-attached, for the reasons you mentioned).

Cheers,


Matt
