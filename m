Received: from mail-108-mta59.mxroute.com (mail-108-mta59.mxroute.com [136.175.108.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830D3793A5
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046919; cv=none; b=O7gyss4Ce+SBYiSR/fl0lWYX6ATtpBNsmSYpf10RgM+iENkXRJJJeurcdfhxP68/kSjNSQzPV3XjjP6wYYU/PzL+7M5/jgC15P02y9jcm6Q7NgRPSwpbaDDBW6QNp7wAo6wfEiZcQxhX+dcBkKJPPG2O7kaj+mbaQu8wokjUVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046919; c=relaxed/simple;
	bh=ev+hhs81v19swe50w8EELCmEz7tSygZP42rSqenHQT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/eQE6fRUuRnNHu2AifuEb7YmefvPkwzsWJro2Xj72YkQF4jHNn3aTdhXgt0EXWdu7LP+Mhk8p9FSypjZniGSRRheAD+FGNe4SqF40aA5unq34aj8C3kgrXQQ+KDdyKaHMLxTaEFwJmQ7m/yJryAunUE/pZEhrjsVNRL/MFKMeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs; spf=pass smtp.mailfrom=ry.rs; dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b=msybueXO; arc=none smtp.client-ip=136.175.108.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ry.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ry.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ry.rs header.i=@ry.rs header.b="msybueXO"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta59.mxroute.com (ZoneMTA) with ESMTPSA id 19c1f046eb50009140.009
 for <linux-pci@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Mon, 02 Feb 2026 15:41:50 +0000
X-Zone-Loop: 81808c2d37b3c9278075403b0711661d6a042d77f3d7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ry.rs; s=x;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7CMZF9xeUUyWaszApwHAtL8kxi/0URq232tQLjbCRJc=; b=msybueXO2VjQsfInIppr3RVmm4
	8B1mwGWnlks3KXukhB3TH1eu7aqOrFtMes9pDS2r6EvwrzUN1wnwBS2xppzwk8l/oejbbQAOCxyr+
	2KjF0Tm/AIale+mOtW7KQisGk0JsOCZ5DcnZxmrhJMh5cfAl0yGAiHDX8wlvgfzP4xZOkxzpmqwiw
	EBR5bOIph7CaO6z/bhmRDQJMM4swterS5K82oMfcLyWYsdMYlpCTDkjVMAs6gP3mtcESDFaYN/CQQ
	wpFY96ewRJ/nmm13UFRYUSLFZrDndgjgkht+CTWx81hGAUi0VAS8i9bhE/tVDHSFYjoTHqkWdfbO4
	Yz+sLiXA==;
Message-ID: <2f385010-0a47-4d0f-8554-b841f6026561@ry.rs>
Date: Mon, 2 Feb 2026 23:41:42 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] rust: pci: add capability lookup helpers
To: Gary Guo <gary@garyguo.net>, dakr@kernel.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
 dirk.behme@gmail.com, lianux.mm@gmail.com, zhiw@nvidia.com
References: <20260201074248.1629393-1-zijing.zhang@ry.rs>
 <DG4KFDZNRSYS.28570B2QPH28E@garyguo.net>
Content-Language: en-US
From: Zijing Zhang <zijing.zhang@ry.rs>
In-Reply-To: <DG4KFDZNRSYS.28570B2QPH28E@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: zijing.zhang@ry.rs



On 2/2/2026 11:02 PM, Gary Guo wrote:
> On Sun Feb 1, 2026 at 7:42 AM GMT, Zijing Zhang wrote:
>> It introduces `pci::Device::{find_capability, find_ext_capability}`, thin
>> wrappers around the PCI core helpers (`pci_find_capability()` and
>> `pci_find_ext_capability()`), returning the config-space offset when present.
>>
>> In `pci::CapabilityId` and  `pci::ExtendedCapabilityId`, Capability IDs are
>> wrapped as newtypes with `from_raw()` plus a set of common constants.
>>
>> An in-tree user is added to Rust PCI driver sample to exercise the new API.
>>
>> Previous versions (v4)
>> https://lore.kernel.org/rust-for-linux/20260201071450.1614172-1-zijing.zhang@ry.rs/
> 
> Also I'd like to mention that Zhi Wang already have a version adding the same
> feature on the list, sent before your v1:
> 
> https://lore.kernel.org/rust-for-linux/20260126215957.541180-3-zhiw@nvidia.com/
> 
> I'd recommend to work together for the feature rather than creating competing
> series.
> 
> Thanks,
> Gary
> 
>>
>> Testing
>> ---
>>
>> Build
>> - x86_64 defconfig-based kernel with Rust enabled (out-of-tree build)
>> - `CONFIG_SAMPLES_RUST=y`
>> - `CONFIG_SAMPLE_RUST_DRIVER_PCI=y`
>>
>> Runtime
>> - QEMU x86_64 (i440FX) with `-device pci-testdev`
>> - QEMU x86_64 (q35) with an NVMe device
>>
>> Changelog
>> ---
>>
>> v2
>> - Run rustfmt on samples/rust/rust_driver_pci.rs to fix rustfmtcheck.
>>
>> v3
>> - Base on pci/next.
>> - Add `CapabilityId`/`ExtendedCapabilityId`, switch `find_*capability()`
>>    to use them.
>> - Document the common ID constants.
>> - Update the sample to use typed IDs and exercise the new helpers.
>>
>> v4
>> - Minor doc/style nits.
>> - Use early-return style in `find_*capability()`.
>>
>>
>> v5 (current)
>> - Fix sample build by using `pdev.as_ref()` for `dev_info!`.
>> - Use `as _` in constant definitions.
>>
>> Zijing Zhang (2):
>>    rust: pci: add capability lookup helpers
>>    samples: rust: pci: exercise capability lookup
>>
>>   rust/kernel/pci.rs              | 150 ++++++++++++++++++++++++++++++++
>>   samples/rust/rust_driver_pci.rs |  31 +++++++
>>   2 files changed, 181 insertions(+)
>>
>>
>> base-commit: ff0e2f679ab0de50a2e9e88fabc1026bc3be04ba
> 


On 2/2/2026 11:02 PM, Gary Guo wrote:
 > On Sun Feb 1, 2026 at 7:42 AM GMT, Zijing Zhang wrote:
 >> It introduces `pci::Device::{find_capability, find_ext_capability}`, 
thin
 >> wrappers around the PCI core helpers (`pci_find_capability()` and
 >> `pci_find_ext_capability()`), returning the config-space offset when 
present.
 >>
 >> In `pci::CapabilityId` and  `pci::ExtendedCapabilityId`, Capability 
IDs are
 >> wrapped as newtypes with `from_raw()` plus a set of common constants.
 >>
 >> An in-tree user is added to Rust PCI driver sample to exercise the 
new API.
 >>
 >> Previous versions (v4)
 >> 
https://lore.kernel.org/rust-for-linux/20260201071450.1614172-1-zijing.zhang@ry.rs/
 >
 > Also I'd like to mention that Zhi Wang already have a version adding 
the same
 > feature on the list, sent before your v1:
 >
 > 
https://lore.kernel.org/rust-for-linux/20260126215957.541180-3-zhiw@nvidia.com/
 >
 > I'd recommend to work together for the feature rather than creating 
competing
 > series.
 >
 > Thanks,
 > Gary
 >
 >>
 >> Testing
 >> ---
 >>
 >> Build
 >> - x86_64 defconfig-based kernel with Rust enabled (out-of-tree build)
 >> - `CONFIG_SAMPLES_RUST=y`
 >> - `CONFIG_SAMPLE_RUST_DRIVER_PCI=y`
 >>
 >> Runtime
 >> - QEMU x86_64 (i440FX) with `-device pci-testdev`
 >> - QEMU x86_64 (q35) with an NVMe device
 >>
 >> Changelog
 >> ---
 >>
 >> v2
 >> - Run rustfmt on samples/rust/rust_driver_pci.rs to fix rustfmtcheck.
 >>
 >> v3
 >> - Base on pci/next.
 >> - Add `CapabilityId`/`ExtendedCapabilityId`, switch `find_*capability()`
 >>    to use them.
 >> - Document the common ID constants.
 >> - Update the sample to use typed IDs and exercise the new helpers.
 >>
 >> v4
 >> - Minor doc/style nits.
 >> - Use early-return style in `find_*capability()`.
 >>
 >>
 >> v5 (current)
 >> - Fix sample build by using `pdev.as_ref()` for `dev_info!`.
 >> - Use `as _` in constant definitions.
 >>
 >> Zijing Zhang (2):
 >>    rust: pci: add capability lookup helpers
 >>    samples: rust: pci: exercise capability lookup
 >>
 >>   rust/kernel/pci.rs              | 150 ++++++++++++++++++++++++++++++++
 >>   samples/rust/rust_driver_pci.rs |  31 +++++++
 >>   2 files changed, 181 insertions(+)
 >>
 >>
 >> base-commit: ff0e2f679ab0de50a2e9e88fabc1026bc3be04ba
 >

Hi Gary and all,

Thanks for the feedback.

Zhi's work on SR-IOV is excellent and provides a higher-level 
abstraction. My series focuses on providing the fundamental lookup 
infrastructure and typed IDs, which are intended to serve as a 
general-purpose foundation for any PCI capability interaction.

These two series appear to be complementary. I am open to any 
integration path the maintainers prefer and would welcome Zhi's thoughts 
on how we might best align these efforts.

As a newcomer to the community, I am passionate about Rust PCI driver 
development and appreciate Gary's diligence in maintaining the 
subsystem's quality. I've taken note of the feedback regarding the patch 
frequency and will ensure to allow more time for review in future 
iterations.

Thanks,
Zijing
