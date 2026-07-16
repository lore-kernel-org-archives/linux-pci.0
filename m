Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76104314B5;
	Thu, 16 Jul 2026 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213531; cv=none; b=PhpiCMb9WSmIm/mENJitj5yb8Q24susK50OYKgNZZ54cNdcNB6g6sKRlWdaMjQU2ZJ5yeZplkpqrmniPeXZRb+cYsUkGSvHecoGl3TaWavK/5H0KR9wPlA9P6pX0p07TuEDXXJI70JX2bhUYuhkgdJXRPetLL6CxrYJXovJYSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213531; c=relaxed/simple;
	bh=TuTsjPN31M25u8PLzlelAkIFQsYrdWbAw1dIZXt13wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBr0ARJ1rI2MI1OLLzcQEI8duE6L5XtAC+z9WZpA5nzWABBjvCRZlSi6RgbX1mHRG97kX3lnavs59evIZAUuisnR+U3T3qysr6EaP0YtbfrYoFWbqUnWw7QfQDd31EWz8lNEVZCgpkJbY8p0jY8Ue2xW6QCzFk3rmwu5gSGvxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=VCkdAHd/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="VCkdAHd/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1784213526;
	bh=7ZOJgefRM+KEbe4ZB1Q8iqDP2JY0QDQGCT3PXzWU564=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VCkdAHd//w7wW7x5Ce9IH1CrZjj405bCnWx9Rk4XZpJdqj7MGvcHMZQ7u5nzwXH7+
	 k0Q7lL0a1tQGWqZ1smwin8CkwTGaev6Ee7uMVmEgfp42wQvzQyfUKF6nDdsLKn+QRZ
	 wcSjLHk+VeV4+xMMxd1SvI44hvxKx8KG2ZvahSFY8HjOuFQnlsSId7BCsxkc2lP+GH
	 hKqf74vRVv43f+lI45LGNpJZeaIPXXrNfZxA1c+Zi9n8ZW9E2M9s+D+0UC0CKgB6o+
	 LHiE8HcGD1OZAO0re5ZzQn66TgMSLRLVBKRTsM4E0BJmpglmQjNUls6kcS8LS4YLe9
	 5NXLKI7Ay9GCw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h1GGN6Cy8z4wCH;
	Fri, 17 Jul 2026 00:51:56 +1000 (AEST)
Message-ID: <65ba06e7-4c54-437d-9fbd-632c0468f66d@ozlabs.org>
Date: Thu, 16 Jul 2026 15:51:52 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] vfio/pci: Add mmap() for DMABUFs
Content-Language: en-GB
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Pranjal Shrivastava <praan@google.com>,
 Longfang Liu <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260715174737.15287-1-matt@ozlabs.org>
 <CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <CALzav=fH7N+ionUnELqw5ZaGrPmgp_w6kxoCtoY8fMmZY_S4zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

On 15/07/2026 19:12, David Matlack wrote:
> On Wed, Jul 15, 2026 at 10:47 AM Matt Evans <matt@ozlabs.org> wrote:
> 
>> This is based on v7.2-rc3.
>>
>> These commits are on GitHub for easier browsing, along with
>> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":
>>
>> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-dmabuf-mmap-v5
> 
> It'd be great to have this test upstream. I'm happy to review it when
> you're ready. Looks like it just needs to be redone to use the VFIO
> selftests library and kselftests harness. AI could probably do the
> conversion pretty quick :)

For sure, I'd intended to catch up with you on best approach here. :)

Aside from the organic structure of the test (the open-coded VFIO
device/group setup/init needs to go), the main issue is that it relies
on a hacked/out of tree QEMU "EDU++" device with a second larger BAR
(containing freely read-writable memory).  A subset of tests run with
the in-tree EDU device, but coverage is too low.

The desirable properties are:

 - Having a BAR that is pure memory (all locations present, writable
without disruptive side-effects) so that mapping aliases can be
constructed and detected.  This is good to test things like non-zero
vm_pgoffs and VA space presentation of physically-discontiguous DMABUFs.

 - BAR >> hugepage size so we can eyeball huge mappings work (or better,
 mechanically test for them).  At least 32MB would tick this box for 4K,
16K page systems.

 - Something QEMU supports*, so one can run the test in a VM/TCG system.

There were some real device models in QEMU that could be used this way,
but needed a fair bit of setup;  I didn't want to rathole
vfio_dmabuf_mmap_test on including a ton of device-specific code for
some video card or similar.

I'll dig more for a simple target that provides these properties --
obviously it would be better to point this test at an off-the-shelf
device (including silicon!).  And, proposing EDU extensions to the QEMU
folks may be useful (there're uses for a better EDU in other contexts too).

Since this test uses MMIO for a specific [class of] function, my first
thought is it should be another VFIO driver-type test sibling of
vfio_pci_driver_test.  For example, we could extend the driver-type
tests' backend struct vfio_pci_driver_ops for functions capable of
providing a Big Memory BAR, like QEMU EDU++.  EDU can also memcpy, so
could also support vfio_pci_driver_test.

The spirit of the device backends hiding setup of a complex device is
handy, and it's plausible that several backends could provide this "big
memory BAR" service.  What do you think, any concerns with extending
vfio_pci_driver_ops like that?


Thanks,


Matt
