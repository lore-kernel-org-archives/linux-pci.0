Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB44355814;
	Fri, 17 Jul 2026 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308371; cv=none; b=mW4Mhua4VetOUiC0LzlrHmVm+kyTv63EsZaScHl7H9nLAE619gMMIJ4yhW7nbz0ryOIWxY+Dafwy3h/OcewNTm7sIKAuMMQAx3sT/QQ71wbKl3rSGG932tofuutm2D3vmHviCHEZ7M5YLQUrePTEY+CFB9F4goebkdHi7dB3oZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308371; c=relaxed/simple;
	bh=aS7id/eBCMoARautj4ypXq6wb5YcFfvkkMDAecW8hkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTive1rWrnIbFVeV5ik3hsDX0XkkN4Q1nHP/O8H+O854cW/st36XdEa0lDTtlW2xnHilirxCu0vE86WRStVN7QmYllof7vBCAfyhVk/bkAaytU0vL7KT6YBvs3YmppmyR6K0GljmOgKjLqx+ieYSnDKYM+AoEEsjGuzVgBYPNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=grMfq6z5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="grMfq6z5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1784308357;
	bh=nyQdVDt2H7mP+A7V2At5qUwCiDU5WOHl96LejnRVOxc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=grMfq6z5BYS50WBYtl+dz/vvrBLXOBxSXV+F4f/DrXEUpHr8WGgc7jUDHqI3f8P2C
	 4G1so0MlfCytQcKSy8ChQG3ba6hIDYyhmfCHK95mUS/vXauDvOwMZL12DAW3T9BeRs
	 obatIMcVKW92Dz+aiJSCAQa+iaYqjIUZ0C3hvtORC5YObf+jvaG8WSbrKSYzoVq53p
	 KGw4vABqDVjuLwO+VgGrtWPaT+2Y6HY+rjUDyfhZV8Bk42IuGNOErRfYOPLfR3O2wo
	 B7OozPpY0To3P3I4NUzVRG8NkWKu/f5/6JCPq3+WFF5VC/v/V7EkYyRht//Zlu0Wax
	 R1uvk0dGQ3z7Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h1xL415l5z4wB7;
	Sat, 18 Jul 2026 03:12:27 +1000 (AEST)
Message-ID: <cc59a80f-afcc-4b2d-8e78-20f74c6b6871@ozlabs.org>
Date: Fri, 17 Jul 2026 18:12:22 +0100
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
 <65ba06e7-4c54-437d-9fbd-632c0468f66d@ozlabs.org>
 <allLypOmtbnPrgbw@google.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <allLypOmtbnPrgbw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi David,

On 16/07/2026 22:23, David Matlack wrote:
> On 2026-07-16 03:51 PM, Matt Evans wrote:
>> Hi David,
>>
>> On 15/07/2026 19:12, David Matlack wrote:
>>> On Wed, Jul 15, 2026 at 10:47 AM Matt Evans <matt@ozlabs.org> wrote:
>>>
>>>> This is based on v7.2-rc3.
>>>>
>>>> These commits are on GitHub for easier browsing, along with
>>>> "[RFC ONLY] selftests: vfio: Add standalone vfio_dmabuf_mmap_test":
>>>>
>>>> https://github.com/metamev/linux/compare/v7.2-rc3...dev/mev/vfio-dmabuf-mmap-v5
>>>
>>> It'd be great to have this test upstream. I'm happy to review it when
>>> you're ready. Looks like it just needs to be redone to use the VFIO
>>> selftests library and kselftests harness. AI could probably do the
>>> conversion pretty quick :)
>>
>> For sure, I'd intended to catch up with you on best approach here. :)
>>
>> Aside from the organic structure of the test (the open-coded VFIO
>> device/group setup/init needs to go), the main issue is that it relies
>> on a hacked/out of tree QEMU "EDU++" device with a second larger BAR
>> (containing freely read-writable memory).  A subset of tests run with
>> the in-tree EDU device, but coverage is too low.
>>
>> The desirable properties are:
>>
>>  - Having a BAR that is pure memory (all locations present, writable
>> without disruptive side-effects) so that mapping aliases can be
>> constructed and detected.  This is good to test things like non-zero
>> vm_pgoffs and VA space presentation of physically-discontiguous DMABUFs.
>>
>>  - BAR >> hugepage size so we can eyeball huge mappings work (or better,
>>  mechanically test for them).  At least 32MB would tick this box for 4K,
>> 16K page systems.
>>
>>  - Something QEMU supports*, so one can run the test in a VM/TCG system.
>>
>> There were some real device models in QEMU that could be used this way,
>> but needed a fair bit of setup;  I didn't want to rathole
>> vfio_dmabuf_mmap_test on including a ton of device-specific code for
>> some video card or similar.
>>
>> I'll dig more for a simple target that provides these properties --
>> obviously it would be better to point this test at an off-the-shelf
>> device (including silicon!).  And, proposing EDU extensions to the QEMU
>> folks may be useful (there're uses for a better EDU in other contexts too).
>>
>> Since this test uses MMIO for a specific [class of] function, my first
>> thought is it should be another VFIO driver-type test sibling of
>> vfio_pci_driver_test.  For example, we could extend the driver-type
>> tests' backend struct vfio_pci_driver_ops for functions capable of
>> providing a Big Memory BAR, like QEMU EDU++.  EDU can also memcpy, so
>> could also support vfio_pci_driver_test.
>>
>> The spirit of the device backends hiding setup of a complex device is
>> handy, and it's plausible that several backends could provide this "big
>> memory BAR" service.  What do you think, any concerns with extending
>> vfio_pci_driver_ops like that?
> 
> I wouldn't recommend leveraging the driver framework unless absolutely
> necessary. It makes the test harder to run.
> 
> The biggest issue I see with the proposed properties is being able to
> treat the BAR as memory. That obviously will depend on the device and
> may require device-specific setup. If we decide that treating the BAR as
> memory is truly required then using the driver framework is the way to
> go. But I'm hoping we can avoid that requirement.
> 
> Instead, I think you can get pretty far by inspecting /proc/pid/pagemap
> to determine if the mmap() set things up correctly, without actually
> accessing the BAR. You can use /proc/pid/pagemap to look up the PFN and
> PAGEMAP_SCAN to detect huge pages.

Hmm, possible, although that's quite a different test at that point.  I
agree never touching the device has advantages, but it's harder to test
certain things if we _never_ do MMIO.  The mitigation effort to get
coverage may not be the right tradeoff vs easier running.  I can think
of some "easy" VFIO bugs that would be challenging to properly verify in
userspace (e.g. PFNs all having some undesired offset).  The current
test method is harder to fool per unit effort in writing it.

Though, I will have a think about this no-touch flavour of test.

What were you picturing regarding populating the VMA PTEs in order to
inspect the result via /proc/pid/pagemap, whilst still upholding the
principle of not touching the device?  For example,
madvise(MADV_POPULATE_WRITE) won't work on the VFIO BAR regions because
they're VM_PFNMAP/VM_IO.

> With that requirement gone, then all you really need is a device with a
> large enough BAR. And even that it not a hard requirement. I'm sure
> there are plenty of test cases that could work with smaller BARs. The
> few tests that want to exercise huge mappings can inspect the device BAR
> sizes first, and if they're all too small, SKIP() the test.
> 
> If you structure the test this way, then it's easy for the test to be
> used. It can be run against any device for the basic functional
> coverage, and can be run against a device with a larger BAR for full
> coverage of huge mappings.
> 
> Does QEMU emulate any devices that have 32MB or larger BARs?

Yep, looks like `-device pci-testdev,membar=64M,membar-backed=on` or
even `-device bochs-display,vgamem=64M` would be suitable.

So I'll also try moving the existing test over to one of these to at
least remove the EDU++ device dependency.  (bochs-display has >1 BAR,
and some MMIO regs which are nice for a quick kick-the-tyres access test.)


Cheers,


Matt

