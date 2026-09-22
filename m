Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE44552930;
	Tue, 22 Sep 2026 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091990; cv=none; b=lViu3qsyGHW1KGczZLpyu6Z2RyyhdYFXTzwQ3zxN8Lia+6iUGkGZpJ1PXRbfsQLnG4nohy0XaJ8QHCT7uuBDN/RDKEargl0bZ6CqBUR8MRrPTGnpz/HkZoeDhBkHxFzo/jAr0AGBftH9dVJNRuTSUQu70Z6inDoGuFFJpes+gqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091990; c=relaxed/simple;
	bh=lS7AdPSag0fx+j6eeWR8p1UQoP5MZTXJVy94nTGbsOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/qG3LM6ptydY3+9TaTQpYcHpKGTU+R0jPi77l2i5CMRmAwEa949WPjaWAcFBpMvYX0bl4XqMk5W+4AxD3CXQzRBAqF65Wm4EUjXumQbUC17ja/ip0VjrW9k5QmMhJu6uAcFLQ04bIfepkFAs2WApmx0GTlmuDUiUXyww2HVPUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRxmwUCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRxmwUCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7031F000FF;
	Tue, 22 Sep 2026 15:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091984;
	bh=xbbKhXCxfC2qg5mXdORoMvqG4gXlDhUweC9q1CgKr6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TRxmwUCQu12HpfIMBOxGt0J6k1oPPrRJ7FxN7MUsVuDKgWhfGwSH94JaTp1FXFUCj
	 6bY/mJu93bsuCdOABzmgIvVfsPUpEFK95p4xcGZ5rPoAoi8BKH742ecdTvBtQ9iVwW
	 5GrgYuB6OPdkxmRA98HU+eQZFAbJ8XyBX3ZUFFMvkBVP8sHhgwiHn79UMn9eVAV0gf
	 cJ7MOiPEgaL4VCiWk+lhjgANXaatHItdFxUq+9z/hN6plXD26fqgMyk+DAyv/p8dg/
	 Ne9WU9fiatKuUI/wtgTv/eEgs4dyYcENbpf4hL/QtyJkNPVPp9AciNhemJhuwsytsQ
	 liROowmWykilQ==
Message-ID: <e2745435-b54d-476c-b492-33ddde9ca57c@kernel.org>
Date: Tue, 22 Sep 2026 10:46:21 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix for storage corruption w/ AMD IOMMU on 64-bit
 addressing
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>
References: <20260908190600.226485-1-mario.limonciello@amd.com>
 <15cebf13-1e28-40e1-9113-19205ee8d604@kernel.org>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <15cebf13-1e28-40e1-9113-19205ee8d604@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/20/26 23:52, Mario Limonciello wrote:
> On 9/8/26 2:05 PM, Mario Limonciello wrote:
>> An issue has been reported by a number of people that corruption
>> was occurring on storage for desktop systems.  It's notably reported
>> on SATA, but the same issue also appears on NVME.
>>
>> At a glance it looks like an IOMMU issue as turning off the IOMMU helps
>> the issue, but it's actually a problem that occurs specifically with any
>> IOVA addressed >58 bits.
>>
>> This is because the BIOS on these systems is enabling a feature of the
>> root port called 'enhanced atomics' which repurposes those upper 5 bits
>> of address space.  That feature should only be enabled by the BIOS when
>> the partner device supports it, but it's instead needlessly enabled on a
>> number of root ports.
>>
>> As some of these systems probably won't receive BIOS updates and there is
>> active reports of data corruption root caused to this add a quirk to
>> disable it on affected models, and also remove the quirk that was
>> introduced to work around this issue in drivers/ata.
>>
>> v2:
>>   *  Added resume fixups for the affected AMD PCIe ports
>>
>> Mario Limonciello (2):
>>    x86/PCI: Disable enhanced atomics on some AMD PCIe ports
>>    Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"
>>
>>   arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/ata/ahci.c   | 18 --------
>>   2 files changed, 99 insertions(+), 18 deletions(-)
>>
> 
> Gentle ping on this series.

I didn't include it on the series while we were getting alignment, but 
when committing this should include

Cc: stable@vger.kernel.org

If it needs to spin for any reason, I'll include that on v3.
