Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF6310635;
	Thu, 22 Jan 2026 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077424; cv=none; b=ZYX0cVd8j0fBxb2frufnL56VOfoXWF0wdCnOHx/+Q+oWMLOh9bCHnKw6ukLZGtQ6RREcku1svfk8drsutVrM6kOO2pXhJLNKrv/t0H991bqrsAOU6qe7f8VI984znXQgIKEd/7SgXsw81S2Od+4A5RlY8WutuNK/viU1CMJkdf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077424; c=relaxed/simple;
	bh=yD2/iPO1Re6uMZvT5xcs+mmWcDT9/QLo5MO/p+6UnGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKJ9sf7DFcjz2QghGFuXIpV1H9JaLHqdXeKxKi63aDOGB3BeeIsFl4Y8vCoHvPl9lk622nwpkImeP9c+/ki1AecGfdR8dpU3043TC8amP/l4Diy2jMg279R4BLHNisx8SsKAtDxU/kbrd1NoWlIhlIlmJvl1By3j5y3xr5+anRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [10.213.20.167] (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowABXZ85++nFpwkNDBg--.14326S2;
	Thu, 22 Jan 2026 18:22:56 +0800 (CST)
Message-ID: <8e0cae73-3ca0-47a8-8ac7-aa8edba3e0f9@iscas.ac.cn>
Date: Thu, 22 Jan 2026 18:22:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] PCI/MSI: Check msi_addr_mask in
 msi_verify_entries()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Creeley, Brett" <bcreeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Han Gao <gaohan@iscas.ac.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>
References: <20260121233804.GA1221537@bhelgaas>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260121233804.GA1221537@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowABXZ85++nFpwkNDBg--.14326S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3GF15Cr48tryxAFy3twb_yoW8CFyxpa
	yDKa1qyrsYk3yUJrsFqw1UXF1jvFZYqayfGrWUK34Y9FnIvFnFyrySka47u3srXF1xGw10
	vF1Yya1UJFs09aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0pRVVbgUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/


On 1/22/26 07:38, Bjorn Helgaas wrote:
> [+cc Thomas, thread at https://lore.kernel.org/r/20260121-pci-msi-addr-mask-v2-0-f42593168989@iscas.ac.cn]
>
> On Wed, Jan 21, 2026 at 11:49:38AM +0800, Vivian Wang wrote:
>> Instead of a 32-bit/64-bit dichotomy, check the MSI address against
>> msi_addr_mask.
>>
>> This allows platforms with MSI doorbell above 32-bit address space to
>> work with devices without full 64-bit MSI address support, as long as
>> the doorbell is within addressable range of MSI of the device.
>>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>>
>> ---
>> v2: No changes
>> ---
>>  drivers/pci/msi/msi.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
>> index 48f5f03d1479..2ecbcd6c436a 100644
>> --- a/drivers/pci/msi/msi.c
>> +++ b/drivers/pci/msi/msi.c
>> @@ -321,14 +321,17 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
>>  static int msi_verify_entries(struct pci_dev *dev)
>>  {
>>  	struct msi_desc *entry;
>> +	u64 address;
>>  
>>  	if (dev->msi_addr_mask == DMA_BIT_MASK(64))
>>  		return 0;
>>  
>>  	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
>> -		if (entry->msg.address_hi) {
>> -			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only supports 32 bits\n",
>> -				entry->msg.address_hi, entry->msg.address_lo);
>> +		address = (u64)entry->msg.address_hi << 32 |
>> +			  entry->msg.address_lo;
>> +		if (address & ~dev->msi_addr_mask) {
>> +			pci_err(dev, "arch assigned 64-bit MSI address %llx above device MSI address mask %llx\n",
> Use %#llx so it's clear these addresses are hex.  The previous message
> did that, not sure why you dropped it.

Thanks for catching. I misunderstood the purpose of the original message
formatting.

I will fix this in v3.

Vivian "dramforever" Wang

