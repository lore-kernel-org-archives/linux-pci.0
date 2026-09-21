Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D55340400;
	Mon, 21 Sep 2026 04:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789966332; cv=none; b=DY285WHHovB5fYimJJdpbcnt/67EnLtXxLG7ELiSdikRXUMwNMpx6iLKoOrAeqiedPPg06vkvu/dTAcVfyJtOPW2B3szCW83Dq7Rk1uTSlv8TDw3AcePm7F0Kgi3yZrPdQy4/Zw4YONN6vcfIgtESAxNsexI5NB/icRYGECzFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789966332; c=relaxed/simple;
	bh=bTqmrvpUXlA1mQVCiLQ2/VKxw52s1dgUdWL4gFNXhXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8dRMYV23iUlE+m70lLOhYfTdLyrTo9lQpASy2DeC3VKlwymrr5ki/pSxRCN8TKggXAVMPiiKKUJityOmR6psUfbX32QEKiIlkGE1jUNF4pdYcmftjlvIm8ktDnzdQJBw2H4uQhC4mU443VmbW2vNT6gnyyp91p4oWo1mzmCwTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+COzuW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+COzuW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADA61F000FF;
	Mon, 21 Sep 2026 04:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789966330;
	bh=MVet7qYLYYdgVfZXBN8sKyK1xnl2RfzVXflZkC/ZMYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F+COzuW7/pACggwXYD5vef5yxInElwke2g5sdSnQVO+NknSy7RyK3/+CRZCV4VwEy
	 5d4FduQKxn32lrhko804uUa3dRF0yl5qyVgvIpmytzKkKZAvJ1o3+8S1Y3x4/W7ssM
	 elFGsxyvtL9sWmliVhOodjUfhQYCiZVnAkW4Nz7CIC3weke8FuSNUbwP4ghLoRnAKq
	 OSziOK3ezK6tdUKiERfpz+Qk4jzvv6KP7o6XQBKdWYEjqFKgrpD+//db6CPHGu0ujp
	 jA0VA5TWrk78R53PvghofnOruuNZ7v1wllhePj88XcXMtC1ctonkid2FEICjUmtfh4
	 uuPfgj/ZwkAKQ==
Message-ID: <15cebf13-1e28-40e1-9113-19205ee8d604@kernel.org>
Date: Sun, 20 Sep 2026 23:52:08 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix for storage corruption w/ AMD IOMMU on 64-bit
 addressing
To: Mario Limonciello <mario.limonciello@amd.com>,
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260908190600.226485-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/26 2:05 PM, Mario Limonciello wrote:
> An issue has been reported by a number of people that corruption
> was occurring on storage for desktop systems.  It's notably reported
> on SATA, but the same issue also appears on NVME.
> 
> At a glance it looks like an IOMMU issue as turning off the IOMMU helps
> the issue, but it's actually a problem that occurs specifically with any
> IOVA addressed >58 bits.
> 
> This is because the BIOS on these systems is enabling a feature of the
> root port called 'enhanced atomics' which repurposes those upper 5 bits
> of address space.  That feature should only be enabled by the BIOS when
> the partner device supports it, but it's instead needlessly enabled on a
> number of root ports.
> 
> As some of these systems probably won't receive BIOS updates and there is
> active reports of data corruption root caused to this add a quirk to
> disable it on affected models, and also remove the quirk that was
> introduced to work around this issue in drivers/ata.
> 
> v2:
>   *  Added resume fixups for the affected AMD PCIe ports
> 
> Mario Limonciello (2):
>    x86/PCI: Disable enhanced atomics on some AMD PCIe ports
>    Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"
> 
>   arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
>   drivers/ata/ahci.c   | 18 --------
>   2 files changed, 99 insertions(+), 18 deletions(-)
> 

Gentle ping on this series.
