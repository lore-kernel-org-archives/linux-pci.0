Received: from mail-108-mta161.mxroute.com (mail-108-mta161.mxroute.com [136.175.108.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3581366DB1
	for <linux-pci@vger.kernel.org>; Tue,  3 Feb 2026 05:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097674; cv=none; b=andPe+7mpW+TlsG+c4pmuy2qptILL3hoCK0ZUUKOUh1hpvDFcL7wds+bAvXP4afeKPjyCjbW+UvDVL7h4pSGzRGBZTWXnUyEOzig0cDXOs3H/24HN17btnGrzEm6lJdFzXaJ43h0NmzXC33LvSIfwSXNVGvyrqTi8tFsH28p6gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097674; c=relaxed/simple;
	bh=7ZioxNEjYitRwIpo8V/hMCg6vXoxq+/eeTF+IvDImOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeYa2Tn0Ar7EMdlqEbqzkDIWxDKQejpqo+NRaarfGHIfkbRSpxS245SW7i253bpsnhpP6UJczTN9TyzUsF+2TxTvVPOCHaoq31CsLXmTJ+UPp+zmB5OYjml1xQ6OV8naB/sS1WXEGgxm/nflzwGmWwdlgPziH1g+SECcekmgSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=mmBb+5xm; arc=none smtp.client-ip=136.175.108.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="mmBb+5xm"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta161.mxroute.com (ZoneMTA) with ESMTPSA id 19c220639ae0009140.009
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 03 Feb 2026 05:42:39 +0000
X-Zone-Loop: e5baac1747890a71f36723d94d1f025b6ecdd05ce3ab
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=g0U8j4hwK2RHOwhzAeojkh/eKJubBFV4p6Zi355Ueas=; b=mmBb+5xm+V4MzRw3Yqcn0+yHuK
	RTAE/17LkzkPB+egXYMGr+1w23VMahTp69Xu1fY8rXofK32jDpPcbX/4PoTUJHZhYL1bO/W1x/P7b
	PR/44lg9kenyRsDwsoYYMRNqBoAsTp9QLlzcn/hZdu213MxWkyJyt7Poopdwb+i9xX/6g8h0MbPo0
	T/zHsjseFVpnxHIbhExrqQ4BJNSVPsq1wq8MXfdgralsnOwCxaMnrBZj27BdVBLk5rPERmbOvSSTD
	9amXG0h1sxiNsazlOmJPU/vl1G67Og1uHYz6jSh+B0R/7QBS3ToP7nFGoM+LY9w+JNHthRxpi736r
	tfGh6qrw==;
Message-ID: <a1b5b7cb-b31c-4895-8057-bdbb0b0eb629@ry.rs>
Date: Tue, 3 Feb 2026 13:42:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] rust: pci: add capability lookup helpers
To: Zhi Wang <zhiw@nvidia.com>
Cc: Gary Guo <gary@garyguo.net>, dakr@kernel.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 ojeda@kernel.org, dirk.behme@gmail.com, lianux.mm@gmail.com
References: <20260201074248.1629393-1-zijing.zhang@ry.rs>
 <DG4KFDZNRSYS.28570B2QPH28E@garyguo.net>
 <2f385010-0a47-4d0f-8554-b841f6026561@ry.rs>
 <20260202215715.1000e2eb.zhiw@nvidia.com>
Content-Language: en-US
From: Zijing Zhang <zijing.zhang@ry.rs>
In-Reply-To: <20260202215715.1000e2eb.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: zijing.zhang@ry.rs

Hi Zhi,

Thank you, Zhi, for the detailed explanation. The shift toward a 
stricter OO-style abstraction with `Io` trait integration and 
`register!` macros makes a lot of sense and probably you could fold my 
`CapabilityId` definitions and lookup logic into your series at your 
will and consequently, I could withdraw my patch set to avoid further 
duplication.

I look forward to discussing how to best align our efforts. I'm also 
interested in taking on additional tasks, such as the iterator 
implementation, once the underlying `Io` trait refactor settles.

Best regards,
Zijing

On 2/3/2026 3:57 AM, Zhi Wang wrote:
> On Mon, 2 Feb 2026 23:41:42 +0800
> Zijing Zhang <zijing.zhang@ry.rs> wrote:
> 
>>
>>
> 
> Hi Zijing,
> 
> Good to see you working on this too! Welcome to join the party!
> 
> I think "thin wrappers" were indeed the initial thought for many of us.
> However, after several rounds of discussions with maintainers at the
> summits, the requirement has shifted towards a stricter, OO-style Rust
> abstraction rather than direct wrappers.
> 
> The key takeaways for the current direction are:
> - Enforcing boundary checks via the Io trait backend.
> - Using register! macros for definitions.
> - Implementing proper Rust iterators for Cap discovery.
> 
> Since nova-core relies on these specific safety features, I'm pushing
> forward with this high-level abstraction. For nova-core, our immediate
> need is accessing and reading registers in the SR-IOV capability.
> 
> That said, there is plenty of room for collaboration to achieve a complete
> framework! For example, support for normal configuration space
> capabilities, the iterator implementation itself, and capabilities other
> than SR-IOV are all areas that need work.
> 
> Currently, I am waiting for Alex's Io trait cleanup and refactor to settle
> before deciding what should be included or changed in my next re-spin.
> Also, any input on how to best organize the traits between normal
> configuration space caps and extended caps would be much appreciated!
> 
> You are also welcome to reach out via Zulip for a quick discussion or
> catch-up.
> 
> Z.
> 
>> On 2/2/2026 11:02 PM, Gary Guo wrote:
>>> On Sun Feb 1, 2026 at 7:42 AM GMT, Zijing Zhang wrote:
>>>> It introduces `pci::Device::{find_capability, find_ext_capability}`,
>>>> thin wrappers around the PCI core helpers (`pci_find_capability()` and
>>>> `pci_find_ext_capability()`), returning the config-space offset when
>>>> present.
>>>>
>>>> In `pci::CapabilityId` and  `pci::ExtendedCapabilityId`, Capability
>>>> IDs are wrapped as newtypes with `from_raw()` plus a set of common
>>>> constants.
>>>>
>>>> An in-tree user is added to Rust PCI driver sample to exercise the
>>>> new API.
>>>>
>>>> Previous versions (v4)
>>>> https://lore.kernel.org/rust-for-linux/20260201071450.1614172-1-zijing.zhang@ry.rs/
>>>
>>> Also I'd like to mention that Zhi Wang already have a version adding
>>> the same feature on the list, sent before your v1:
>>>
>>> https://lore.kernel.org/rust-for-linux/20260126215957.541180-3-zhiw@nvidia.com/
>>>
>>> I'd recommend to work together for the feature rather than creating
>>> competing series.
>>>
>>> Thanks,
>>> Gary
>>>
>>>>
>>>> Testing
>>>> ---
>>>>
>>>> Build
>>>> - x86_64 defconfig-based kernel with Rust enabled (out-of-tree build)
>>>> - `CONFIG_SAMPLES_RUST=y`
>>>> - `CONFIG_SAMPLE_RUST_DRIVER_PCI=y`
>>>>
>>>> Runtime
>>>> - QEMU x86_64 (i440FX) with `-device pci-testdev`
>>>> - QEMU x86_64 (q35) with an NVMe device
>>>>
>>>> Changelog
>>>> ---
>>>>
>>>> v2
>>>> - Run rustfmt on samples/rust/rust_driver_pci.rs to fix rustfmtcheck.
>>>>
>>>> v3
>>>> - Base on pci/next.
>>>> - Add `CapabilityId`/`ExtendedCapabilityId`, switch
>>>> `find_*capability()` to use them.
>>>> - Document the common ID constants.
>>>> - Update the sample to use typed IDs and exercise the new helpers.
>>>>
>>>> v4
>>>> - Minor doc/style nits.
>>>> - Use early-return style in `find_*capability()`.
>>>>
>>>>
>>>> v5 (current)
>>>> - Fix sample build by using `pdev.as_ref()` for `dev_info!`.
>>>> - Use `as _` in constant definitions.
>>>>
>>>> Zijing Zhang (2):
>>>>     rust: pci: add capability lookup helpers
>>>>     samples: rust: pci: exercise capability lookup
>>>>
>>>>    rust/kernel/pci.rs              | 150
>>>> ++++++++++++++++++++++++++++++++ samples/rust/rust_driver_pci.rs |
>>>> 31 +++++++ 2 files changed, 181 insertions(+)
>>>>
>>>>
>>>> base-commit: ff0e2f679ab0de50a2e9e88fabc1026bc3be04ba
>>>
>>
>>
>> On 2/2/2026 11:02 PM, Gary Guo wrote:
>>   > On Sun Feb 1, 2026 at 7:42 AM GMT, Zijing Zhang wrote:
>>   >> It introduces `pci::Device::{find_capability, find_ext_capability}`,
>> thin
>>   >> wrappers around the PCI core helpers (`pci_find_capability()` and
>>   >> `pci_find_ext_capability()`), returning the config-space offset when
>> present.
>>   >>
>>   >> In `pci::CapabilityId` and  `pci::ExtendedCapabilityId`, Capability
>> IDs are
>>   >> wrapped as newtypes with `from_raw()` plus a set of common constants.
>>   >>
>>   >> An in-tree user is added to Rust PCI driver sample to exercise the
>> new API.
>>   >>
>>   >> Previous versions (v4)
>>   >>
>> https://lore.kernel.org/rust-for-linux/20260201071450.1614172-1-zijing.zhang@ry.rs/
>>   >
>>   > Also I'd like to mention that Zhi Wang already have a version adding
>> the same
>>   > feature on the list, sent before your v1:
>>   >
>>   >
>> https://lore.kernel.org/rust-for-linux/20260126215957.541180-3-zhiw@nvidia.com/
>>   >
>>   > I'd recommend to work together for the feature rather than creating
>> competing
>>   > series.
>>   >
>>   > Thanks,
>>   > Gary
>>   >
>>   >>
>>   >> Testing
>>   >> ---
>>   >>
>>   >> Build
>>   >> - x86_64 defconfig-based kernel with Rust enabled (out-of-tree build)
>>   >> - `CONFIG_SAMPLES_RUST=y`
>>   >> - `CONFIG_SAMPLE_RUST_DRIVER_PCI=y`
>>   >>
>>   >> Runtime
>>   >> - QEMU x86_64 (i440FX) with `-device pci-testdev`
>>   >> - QEMU x86_64 (q35) with an NVMe device
>>   >>
>>   >> Changelog
>>   >> ---
>>   >>
>>   >> v2
>>   >> - Run rustfmt on samples/rust/rust_driver_pci.rs to fix rustfmtcheck.
>>   >>
>>   >> v3
>>   >> - Base on pci/next.
>>   >> - Add `CapabilityId`/`ExtendedCapabilityId`, switch
>>   >> `find_*capability()` to use them.
>>   >> - Document the common ID constants.
>>   >> - Update the sample to use typed IDs and exercise the new helpers.
>>   >>
>>   >> v4
>>   >> - Minor doc/style nits.
>>   >> - Use early-return style in `find_*capability()`.
>>   >>
>>   >>
>>   >> v5 (current)
>>   >> - Fix sample build by using `pdev.as_ref()` for `dev_info!`.
>>   >> - Use `as _` in constant definitions.
>>   >>
>>   >> Zijing Zhang (2):
>>   >>    rust: pci: add capability lookup helpers
>>   >>    samples: rust: pci: exercise capability lookup
>>   >>
>>   >>   rust/kernel/pci.rs              | 150
>>   >> ++++++++++++++++++++++++++++++++ samples/rust/rust_driver_pci.rs |
>>   >> 31 +++++++ 2 files changed, 181 insertions(+)
>>   >>
>>   >>
>>   >> base-commit: ff0e2f679ab0de50a2e9e88fabc1026bc3be04ba
>>   >
>>
>> Hi Gary and all,
>>
>> Thanks for the feedback.
>>
>> Zhi's work on SR-IOV is excellent and provides a higher-level
>> abstraction. My series focuses on providing the fundamental lookup
>> infrastructure and typed IDs, which are intended to serve as a
>> general-purpose foundation for any PCI capability interaction.
>>
>> These two series appear to be complementary. I am open to any
>> integration path the maintainers prefer and would welcome Zhi's thoughts
>> on how we might best align these efforts.
>>
>> As a newcomer to the community, I am passionate about Rust PCI driver
>> development and appreciate Gary's diligence in maintaining the
>> subsystem's quality. I've taken note of the feedback regarding the patch
>> frequency and will ensure to allow more time for review in future
>> iterations.
>>
>> Thanks,
>> Zijing
>>
> 

