Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481AC2D73A6;
	Fri, 27 Feb 2026 05:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772169948; cv=none; b=FXwcZJPIjopiYO5FTWx7FF3OgsoDtEz+aztRph6Dd6RztjcjIjNnRLWznGrAGUS09zL084bxngH1Pm2xi3GVJi7OKJo6nZ8nZOHhP46ql9IGssIveYp+GF8YR0AK3/s4nzd2vePTuPJlABr75FJ11BaBkbQwoaNmV5zsE3IaaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772169948; c=relaxed/simple;
	bh=+31iF3OoYMGJbCN6LTtZ31nBlwQ8uRo+RoyxWzMNZYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPf9bgBiQXYfFyPvmTVKYnIUzj7p1jhV8YW8LZyB8DRJ40TdIVF3ZzlG/vvlXo03SOGD7ZuRb6MmQtEcvIVuwbCmb+AMX1hcAZUi4Sjguo9Pdq51kgmSE7b8aRoBPyehhfYDis9XbNpFN/KkE8GV0/6dIGaGOIJQ8KPG+pMs1CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.103] (unknown [123.118.222.47])
	by APP-01 (Coremail) with SMTP id qwCowABH72qvKqFp4fXQCA--.7323S2;
	Fri, 27 Feb 2026 13:25:04 +0800 (CST)
Message-ID: <c9329ae2-721d-4127-9380-b1ea454bd8f2@iscas.ac.cn>
Date: Fri, 27 Feb 2026 13:25:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] PCI/MSI: Conservatively generalize no_64bit_msi
 into msi_addr_mask
To: Mark Bloch <mbloch@nvidia.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Brett Creeley <brett.creeley@amd.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Thomas Gleixner <tglx@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn>
 <20260129-pci-msi-addr-mask-v4-1-70da998f2750@iscas.ac.cn>
 <fb23d54a-fca0-43a2-ae1d-03ae52112192@nvidia.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <fb23d54a-fca0-43a2-ae1d-03ae52112192@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowABH72qvKqFp4fXQCA--.7323S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrykArWkCrW7tr1xAr48tFb_yoW8Gr4fpF
	WDWF4rtF4UKry7t39Fvw1DZF45Zws5Z3s3Wry5twnakan0v3W2qr1qyr4aga42gr48Jw4Y
	kryjgw1vqrs8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjTRM6wCDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 2/27/26 02:25, Mark Bloch wrote:

> On 29/01/2026 3:56, Vivian Wang wrote:
>> Some PCI devices have PCI_MSI_FLAGS_64BIT in the MSI capability, but
>> implement less than 64 address bits. This breaks on platforms where such
>> a device is assigned an MSI address higher than what's reachable.
>>
>> Currently, the no_64bit_msi bit is set for these devices, meaning that
>> only 32-bit MSI addresses are allowed for them. However, on some
>> platforms the MSI doorbell address is above the 32-bit limit but within
>> the addressable range of the device.
>>
>> As a first step to enabling MSI on those combinations of devices and
>> platforms, conservatively generalize the single-bit flag no_64bit_msi
>> into msi_addr_mask. (The name msi_addr_mask is chosen to avoid confusion
>> with msi_mask.)
>>
>> The translation is essentially:
>>
>> - no_64bit_msi = 1    ->    msi_addr_mask = DMA_BIT_MASK(32)
>> - no_64bit_msi = 0    ->    msi_addr_mask = DMA_BIT_MASK(64)
>> - if (no_64bit_msi)   ->    if (msi_addr_mask < DMA_BIT_MASK(64))
>>
> Hey Vivian,
>
> We are seeing issues while reloading mlx5 on a PPC64 platform.

Mea culpa. There's a fix on the list [1] since last Friday. I'm not sure
why it hasn't moved yet, but please take a look.

Vivian "dramforever" Wang

[1]: https://lore.kernel.org/all/20260220070239.1693303-1-nilay@linux.ibm.com/

