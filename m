Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99FA3AE6EE;
	Fri,  6 Mar 2026 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810673; cv=none; b=Ds7r0FDjRL/FiXkT7vUlIeBy6SFjhfCIRz2p7aRQgfM9tOMHLqWThqwAIs1m614RQLCN0Nyzr/HpcHm3AQJM5tPjbp+m6yD3hASfygYFaRTMg+bUz5IYyns2pdJjsXVyK2Y/ZcZXwVZv0AstpOcQS3YBRhn14LvB2/0qtKoKMYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810673; c=relaxed/simple;
	bh=uzrTuoY+mNLtvgWPJYmqEAAvoSSdRfgSv66yIESWPos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWL0N03vb4Zip+PGl7m3QBA1fEUq6+aCuwAleihHCGcKZz31LVpq4ruBrSxziKsOEu11SK2o+zzMZ5pnG2AeD8Sskdgz1dAs/+pW1ZkOBS4nki/6ypFfUVfIB5Zl9mczmM0cgJkMkSbyRUmiqPjZzd6iqLXrkMkgFTgyWcUMzGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B97B0497;
	Fri,  6 Mar 2026 07:24:19 -0800 (PST)
Received: from [10.57.57.97] (unknown [10.57.57.97])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEDC63F836;
	Fri,  6 Mar 2026 07:24:22 -0800 (PST)
Message-ID: <03461707-783e-403a-86fa-ae7a5107fa30@arm.com>
Date: Fri, 6 Mar 2026 15:24:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iommu/arm-smmu-v3: Recover ATC invalidate timeouts
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, joro@8bytes.org, bhelgaas@google.com, rafael@kernel.org,
 lenb@kernel.org, praan@google.com, kees@kernel.org,
 baolu.lu@linux.intel.com, smostafa@google.com,
 Alexander.Grest@microsoft.com, kevin.tian@intel.com,
 miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com
References: <cover.1772686998.git.nicolinc@nvidia.com>
 <ca7ab934bf0f433b62a5c15d42241632c4cb9366.1772686998.git.nicolinc@nvidia.com>
 <a5ff7a43-ea52-462d-a316-d3a6c08410e0@arm.com>
 <aanwTQtMMplXY3du@Asurada-Nvidia> <20260305235252.GC1651202@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260305235252.GC1651202@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-03-05 11:52 pm, Jason Gunthorpe wrote:
> On Thu, Mar 05, 2026 at 01:06:21PM -0800, Nicolin Chen wrote:
>> That sounds like the IOPF implementation. Maybe inventing another
>> IOMMU_FAULT_ATC_TIMEOUT to reuse the existing infrastructure would
>> make things cleaner.
> 
> I think the routing is quite different, IOPF wants to route an event
> the domain creator, here you want to route an event to the IOMMU core
> then the PCIe RAS callbacks.
> 
> IDK if there is much to be reused there, especially since IOPF
> requires a memory allocation and ideally we should not be allocating
> memory to resolve this critical error condition.

Yeah, sorry, for a moment there I somehow forgot that we can expect to 
use ATS without PRI, so indeed tying this to IOPF wouldn't be 
appropriate. And given the general difficulty of trying to infer what 
went wrong and what to do from the CMDQ contents alone, I do like your 
idea of trying to return a new kind of sync failure back to 
arm_smmu_atc_inv_{master,domain}() so that we can take any defensive 
action from there, with all the information to hand. We'd just have to 
ensure that if a large set of ATCI commands needs to span multiple 
batches, every batch must contain its own sync (since if some other 
batch of unrelated commands could get interleaved in the middle and 
issue a sync that then fails due to someone else's ATC timeout, 
everything's likely to get confused and go wrong).

The fiddly thing then is that we might also have to be prepared to 
"handle" CMD_SYNC timeout by manually checking for GERRORs, in case the 
whole invalidation is in the context of an dma_unmap within some other 
device's IRQ handler, which happens to be on the same CPU where the 
GERROR IRQ is now pending, but can't be taken until we can complete the 
inv and return out of the current IRQ :/

Thanks,
Robin.
