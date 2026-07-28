Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F67140DB5C;
	Tue, 28 Jul 2026 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233079; cv=none; b=qI8PbloGk9YUSUgdYljVEdZbdW2bUvr0B8unp0f1m0slzB/tFCKSHV5cL9HBWjJwvQSo4Lp72uHxiEQ5s7KA88haXgAPi3PCdmDKO4KWMuNt40j26VgcBfbLmX5AY6gGVMiP23EC/DgY6BB5FmfMnJgTIepv1cgjh1atqzdbFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233079; c=relaxed/simple;
	bh=+qX0PisZeeHdH3l6bVP09rcJGyaK5NPPSnPr7a+dMEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYHlvq1LGOCqzRz3/tURHJRzqDi0Kf9fKb4EQa/JfImLxx49wtpiwj6RCfS3lZn5G/rJnwKkpn+BrTF8rXJ/etHI1on5Rdx5+DkYy34c0vx5y+BG0I3xj3T70TA0O8cW/c9cgmlw5QoxsS1jpubXTz6V+Dg8U0WJh9vfwrLuWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U/3yd7ee; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U/3yd7ee"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A3C61A9A;
	Tue, 28 Jul 2026 03:04:31 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65EF83F66F;
	Tue, 28 Jul 2026 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785233075; bh=+qX0PisZeeHdH3l6bVP09rcJGyaK5NPPSnPr7a+dMEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U/3yd7eegPyWLuJHUkzkeeGrphZ47PXls1SubSIWwjip58s0E+SE7riunJeIfLcPx
	 ppgx9yxl0tVjZeG4zkuT3BFqtreOyzfaMEugWDntUEB+T8lRsqdKjraMXdTxPkJLw5
	 t3w4/FCRW3AqW7K+EwdrIXYR/en1GCKKdGsfQmZ0=
Message-ID: <69b1235a-832b-4a00-bcfd-f51991d23488@arm.com>
Date: Tue, 28 Jul 2026 11:04:27 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 3/3] of: Respect #{iommu,msi}-cells in maps
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nipun Gupta
 <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev,
 xen-devel@lists.xenproject.org,
 Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260603-parse_iommu_cells-v16-0-dc509dacb19a@oss.qualcomm.com>
 <20260603-parse_iommu_cells-v16-3-dc509dacb19a@oss.qualcomm.com>
 <3f5c974f-425d-47a5-9fda-e05de1f39d79@linaro.org>
 <0d0896af-a4a5-445d-8db7-fdb9eecd07a2@oss.qualcomm.com>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <0d0896af-a4a5-445d-8db7-fdb9eecd07a2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/07/2026 5:05 am, Vijayanand Jitta wrote:
> 
> 
> On 7/23/2026 6:47 PM, Neil Armstrong wrote:
>> Hi,
>>
>> On 6/3/26 09:13, Vijayanand Jitta wrote:
>>> From: Robin Murphy <robin.murphy@arm.com>
>>>
>>> So far our parsing of {iommu,msi}-map properties has always blindly
>>> assumed that the output specifiers will always have exactly 1 cell.
>>> This typically does happen to be the case, but is not actually enforced
>>> (and the PCI msi-map binding even explicitly states support for 0 or 1
>>> cells) - as a result we've now ended up with dodgy DTs out in the field
>>> which depend on this behaviour to map a 1-cell specifier for a 2-cell
>>> provider, despite that being bogus per the bindings themselves.
>>>
>>> Since there is some potential use in being able to map at least single
>>> input IDs to multi-cell output specifiers (and properly support 0-cell
>>> outputs as well), add support for properly parsing and using the target
>>> nodes' #cells values, albeit with the unfortunate complication of still
>>> having to work around expectations of the old behaviour too.
>>>
>>> Since there are multi-cell output specifiers, the callers of of_map_id()
>>> may need to get the exact cell output value for further processing.
>>> Update of_map_id() to set args_count in the output to reflect the actual
>>> number of output specifier cells.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
>>> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
>>> ---
>>>    drivers/of/base.c  | 168 +++++++++++++++++++++++++++++++++++++++++------------
>>>    include/linux/of.h |   6 +-
>>>    2 files changed, 135 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>> index d658c2620135..ac7961cbab94 100644
>>> --- a/drivers/of/base.c
>>> +++ b/drivers/of/base.c
>>> @@ -2116,19 +2116,49 @@ int of_find_last_cache_level(unsigned int cpu)
>>>        return cache_level;
>>>    }
>>>    +/*
>>> + * Some DTs have an iommu-map targeting a 2-cell IOMMU node while
>>> + * specifying only 1 cell. Fortunately they all consist of value '1'
>>> + * as the 2nd cell entry with the same target, so check for that pattern.
>>> + *
>>> + * Example:
>>> + *    IOMMU node:
>>> + *        #iommu-cells = <2>;
>>> + *
>>> + *    Device node:
>>> + *        iommu-map = <0x0000 &smmu 0x0000 0x1>,
>>> + *                <0x0100 &smmu 0x0100 0x1>;
>>
>> So the sm8650 PCIe controllers has:
>>
>> pcie@1c08000:
>>              iommu-map = <0     &apps_smmu 0x1480 0x1>,
>>                      <0x100 &apps_smmu 0x1481 0x1>;
>>
>> and
>>
>> pcie@1c00000:
>>
>>              iommu-map = <0     &apps_smmu 0x1400 0x1>,
>>                      <0x100 &apps_smmu 0x1401 0x1>;
>>
>> and apps_smmu has #iommu-cells = <2>, but gets flagged at wrong:
>>
>> [    7.538800] OF: /soc@0/pcie@1c08000: iommu-map has 1-cell entries targeting 2-cell #iommu-cells, treating as 1-cell output
>>
>> Returning false in of_check_bad_map() triggers:
>>
>> [    7.642680] OF: /soc@0/pcie@1c08000: Unsupported iommu-map - cannot handle 256-ID range with 2-cell output specifier
>>
>> I don't understand the issue here, we use 2 cells as expected by
>> the iommu-cells, so why is it wrong ? can somebody explain in
>> comprehensive words ? I'm super confused, it worked like a charm until now.
>>
>> Neil
>>
> 
> Hi Neil,
> 
> iommu-map = <0     &apps_smmu 0x1480 0x1>,
>              <0x100 &apps_smmu 0x1481 0x1>;
> 
> 
> Entries here are not 2-cell format, Even though apps_smmu declares #iommu-cells = <2>,
> this DT only supplies one output cell (0x1480/0x1481) — the trailing 0x1 is the length field,
> not a second output cell. (<id-base phandle out-base length>)
> 
> The new code detects exactly this pattern (same target phandle across all entries, length always 1)
> and falls back to treating the map as 1-cell output for backward compatibility — hence the pr_warn_once.
> It's harmless and expected, your RIDs still resolve to the correct SIDs (0 → 0x1480, 0x100 → 0x1481).
> 
> The second message is a different case and shouldn't be coming from this same map — once the 1-cell
> fallback triggers on the first entry, it applies to the whole map, so you shouldn't hit both warnings
> together on the same node. That error only fires for a genuine 2-cell output specifier combined with
> an id_len > 1, e.g.:
> 
> iommu-map = <0x0 &apps_smmu 0x1480 0x1 0x100>;
> 
> (<id-base, phandle, out0, out1, length=256>) — which isn't supported, since there's no way to
> linearly scale a multi-cell output specifier across a range of IDs.
> 
> Are you seeing that second error on the same pcie node, or a different one?
> If it's the same node, can you share the exact iommu-map entry that triggers it?

I think Neil is saying he bypassed the fallback check so that it *did* 
try to parse the given map with the real #iommu-cells=2 in precisely the 
way you've shown - so even if it could have got past that point, it 
would have then blown trying to parse the second "entry" of just 
<&apps_smmu 0x1481 0x1>, since 0x1481 almost certainly isn't a valid 
phandle to read an #iommu-cells value from.

Cheers,
Robin.
