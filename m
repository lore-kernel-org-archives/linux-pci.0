Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F78480DF0
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357374; cv=none; b=HgCobuQPyK2uA2LU50RI78eQYLoj5nbd7UV6YQJC3reJY7Rv+kZ8r9DjAzNQ9DWe7kc2OedOTpYqOAdYCABkCUKtCXNNfQtfw6YUS81ppVtPXjzbL83U4s5J9/qaQEHqg1qkCaHz7eTq13zB+Jinv7OTm4z/5TmICxiRKqpIzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357374; c=relaxed/simple;
	bh=S2v10Jpc+KT+ABsxPSBblM3oR15HWludxkic5eqROT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQcrWjKd2guBur3HZbD7VdZhxrqK7d2pNeOmj4sFPlQjs04gIMrRgWN6qjBgRHzpdDQUwhXzAzRAmM7T4xa3MuDODOIeZZPVeCDAaEd9FIEReazgJe6qK9TRRy+cZRbeBjHbU9A1Y7iAl+7NcvSUvSJRtvz68lD6qDqBQPUAAb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=GuVp7hMc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="GuVp7hMc"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so3960968a12.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2026 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788357371; x=1788962171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HzTSP1VerAgUKbe8KO4iSf2T699TUXzKoWe3KwKSiDU=;
        b=GuVp7hMc+ZQwpRqcBLbeL8fFh2OGcD+0sbiFqyHB29Iz+UQ0oXa/U6vxPV33SrhF2/
         pliwCiMN77cGacbMpWCHzqumyJvmfbMRE1W842dUAlIjjHwGlmiJ8C/w+RplU8OZPD9F
         lf7zMxYFrGZlZIzC8l1mXHSNlXHhpxV0Pv6zciyfgUHDjW74TGIZS92OM6P0HicSWorT
         FBjviNPHhvjF8fE+P67vmcp+F3etn2UWQzDIMFuQVXs8zEy49KM0+DeieRbyfq2rgUqF
         nSjhAoVd8HGOOMzRNw41B+xRKG2cb0dQq8PWByMO4Y+40rWWaurEyTz1myRW/ap7VKvb
         KbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357371; x=1788962171;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HzTSP1VerAgUKbe8KO4iSf2T699TUXzKoWe3KwKSiDU=;
        b=htMxxOCw2sbnY7rqvsBYe1XYaH9w+BS2ymdTeWB+XbWopYsHujtb8cWP+rQXbdSBcC
         wYPChZQ8hM3arRA8E4au5h/e/WjKdSMUQ1aoa1otYQWwqXtYYaQthZOuwrK7pB3I7GaK
         fuoMwteu5lyF3CMBR3d1WDYmdW3GtDJu5arY9RwGql5PGif7YBjPv2Qi381CcF0rGdXf
         gWgVtHkgJkZRpfoxqf1onDfBVknmJpHRUjg3oLC38x7nRI8vcOUDGr0+khA5mK+8nFJR
         Q9XXcwMfysPIgaw+DnI42nVKfIxuyp1drMo44YkNSLdj/D1k3dmc5v+rLjtfZB+79fc9
         verQ==
X-Gm-Message-State: AFuF++kDRw0ICQhp3r9b1GIPoOitQ6tZGLxhRXOjhKlE3yARvhmzNeHG
	PRSl7DI37RMuQY0ph3Ed/DPeaD3lkT1OgMs393xkW7mxobtoMPwR+4yAwA1EyJ7rnT0=
X-Gm-Gg: AYBFou3iBZdGrkOd48YKNM+rwb4E5UlrhUfO+OWepGNWnm76JdQY+PBwm2RjDSQnNX+
	5wrycB7sAtzthwFn49MmSOnJtKDli/iTGwQRCgFW7oWzdJ86PozBjHuuYLl2xLMIKVq380Z0uC9
	Se4JHeeNnBvuWYRIJRw09fwo/YizV1WvJ3UDyV3Z4puZZTiYZruikQF99z+4Xp588QJueZf2kUe
	HU/uDv5HTaKbcwwETXRiWZSdC9v8YOmhLCDsVXejgHXZeUJfFdBbiVzoFPihwh1KuegAoE+Q5qa
	xcfTeaQFiDtIIpe5I6Pe1rLIR5OIIeRf092/esE/QX2XXS3PEk9wtTDJ6fJ+KIFbFtL6/Y03i+W
	556NWP8wGvVnUdoZJdzamD4f2LBgwwzBSL9HUJAAclrhBDytWjz6CcZIJHJraJsJX7RWbO+7cv7
	fdI7O3yJM3vzqGvJyAECeaG1MBWW4wKuSVh7pVs6JIeC8f4THvt8D/r10L/fYYYYpOBxoeeqg=
X-Received: by 2002:a17:907:3fa6:b0:c1c:2218:f317 with SMTP id a640c23a62f3a-c25dc9bedbcmr195324866b.2.1788357370921;
        Wed, 02 Sep 2026 06:56:10 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc7116sm136119566b.9.2026.09.02.06.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 06:56:09 -0700 (PDT)
Message-ID: <7a29717b-dc62-4421-b783-7b78e4375268@riscstar.com>
Date: Wed, 2 Sep 2026 08:56:05 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] PCI: spacemit-k1: port C probe hard-hangs a CPU with one
 endpoint on Milk-V Jupiter
To: Manivannan Sadhasivam <mani@kernel.org>, spacemit@lists.linux.dev,
 Bruno Banelli <bbanelli@gmail.com>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 Yixun Lan <dlan@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>, Rob Herring
 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org
References: <20260825052249.66921-1-bbanelli@gmail.com>
 <c24pt2ls62rxxg77xjbng7dmiflgdjlqd3mkoxehc2rvjgh7ai@dcxvmau3ykmt>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <c24pt2ls62rxxg77xjbng7dmiflgdjlqd3mkoxehc2rvjgh7ai@dcxvmau3ykmt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 8:42 AM, Manivannan Sadhasivam wrote:
> On Tue, Aug 25, 2026 at 07:22:49AM +0200, Bruno Banelli wrote:
>> Hi,
>>
>> On a Milk-V Jupiter, probing the PCIe controller at ca800000 (port C, the
>> card slot) permanently wedges the CPU that runs the probe when one
>> particular add-in card is installed.  The CPU stops responding to NMI, and
>> because the probe is asynchronous, kernel_init() then blocks forever in
>> async_synchronize_full() and the machine never finishes booting.
>>
>> The same card, in the same slot, on the same board, does *not* hang the
>> vendor 6.6 kernel -- it reports "Phy link never came up" and boots normally.
>> Six other cards do not hang mainline either.  So whatever the electrical
>> cause, this looks like a robustness problem in pcie-spacemit-k1: an endpoint
>> should not be able to hang a host-side DBI register access.
>>
>>
>> HARDWARE
>> --------
>>    Milk-V Jupiter v1.1, SpacemiT M1 (socinfo: CPU[M1-8571] REV[C] DRO[130]),
>>    16 GiB LPDDR4X.
>>    Firmware: stock vendor U-Boot 2022.10 (k1-bl-v2.2.9), unmodified.
>>    Port B (ca400000, M.2) has a Samsung PM9B1 NVMe and works throughout.
>>    Port C (ca800000) is the card slot -- an x8-length connector, silkscreened
>>    PCIE_X2, wired x2.
>>
>>
>> REPRODUCED ON
>> -------------
>>    v7.1 and v7.2, riscv defconfig (plus PHY_SPACEMIT_K1_USB2, USB_DWC3,
>>    SPACEMIT_K1_TSENSOR, IGB, IGC, NVMe/ext4 built in).
>>    gcc 13.3.0 (cross) and gcc 16.2.0 (native, Debian sid).
>>    Identical failure in all combinations.  Not a regression -- port C has
>>    never worked with this card on mainline.
>>
>> Command line:
>>    console=ttyS0,115200 earlycon root=/dev/nvme0n1p2 rootwait rw
>>    swiotlb=65536 clk_ignore_unused pd_ignore_unused
>>
>>
>> SYMPTOM
>> -------
>> Port C prints its address ranges and then never speaks again.  (Log below is
>> from a run with port B disabled in DT, so nothing is interleaved.)
>>
>>    [ 1.290074] spacemit-k1-pcie ca800000.pcie: host bridge /soc/pcie-bus/pcie@ca800000 ranges:
>>    [ 1.297283] spacemit-k1-pcie ca800000.pcie:       IO 0x00b7002000..0x00b7101fff -> 0x0000000000
>>    [ 1.312783] spacemit-k1-pcie ca800000.pcie:      MEM 0x00a0000000..0x00afffffff -> 0x00a0000000
>>    [ 1.326753] spacemit-k1-pcie ca800000.pcie:      MEM 0x00b0000000..0x00b6ffffff -> 0x00b0000000
>>    [22.348490] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>>    [22.351764] rcu:     4-...0: (12 GPs behind) idle=051c/1/0x4000000000000000 softirq=43/43 fqs=1908
>>    [22.367040] Sending NMI from CPU 2 to CPUs 4:
>>    [32.367049] After 10 seconds, these CPUS still haven't responded to the NMI: 4
>>
>> The CPU ignoring an NMI for ten seconds is why I read this as an MMIO access
>> that never receives a completion rather than a spin or a deadlock.
>>
>>
>> LOCALISATION
>> ------------
>> I added a dev_info() before each step of k1_pcie_init() (patch at the end of
>> this mail).  The last marker port C prints is the one immediately before the
>> first DBI access:
>>
>>    [1.347050] spacemit-k1-pcie ca800000.pcie: K1DBG 1 toggle_soft_reset
>>    [1.362635] spacemit-k1-pcie ca800000.pcie: K1DBG 2 enable_resources
>>    [1.370918] spacemit-k1-pcie ca800000.pcie: K1DBG 3 first DBI write (vendor/device ID)
>>    <nothing further>
> 
> Sounds weird that an endpoint is causing DBI write hang.
> 
> Can Alex or someone from Spacemit look into this issue?

I think Yixun Lan or maybe Troy Mitchell should investigate.

I have not done anything on the Milk-V Jupiter and have no
access to any board of that type.

					-Alex

> - Mani
> 

