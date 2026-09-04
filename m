Received: from out198-11.us.a.mail.aliyun.com (out198-11.us.a.mail.aliyun.com [47.90.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3AC3A9D9F;
	Fri,  4 Sep 2026 03:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491955; cv=none; b=QkJywPUevEveuekPYQiUL7xAZBjMa6AvCzffiGC9Vhi94ssYI+6XDaUytbnFPVfvpLN2rQUkDwnmeq6LKtf0T6Pc0JWylUM3Ucw7LpEjTlYmYNSErVzRs1FLh64ofFGP788KnmFPAd3tF7raM0lQfpK2z9AaqNyd7k0VFxNy1sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491955; c=relaxed/simple;
	bh=8bj3kFGznYiQ6RR5gdU9r4z/p7vrDRFuTBVMi+8Xp/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3/fqXbZRG/UQtBaUUf/h14ubbQIt+fs0TIPqTHyNYuaKbFke/JXDjZ1fHXFzre/FMZ4JJe3OQa7fPZhFKetPH+duuwMvqENq7lU9GGL8P27cBVlqlwon183VeG3ieM6Tjh4fGFULNtkSwuwdQHNEYzllQ6HO/yQS7cUZzohCio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1785951|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0139258-0.0016253-0.984449;FP=2722154241417888959|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=wanglin@open-hieco.net;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.j57dyL2_1788491933;
Received: from 172.18.24.170(mailfrom:wanglin@open-hieco.net fp:SMTPD_---.j57dyL2_1788491933 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 11:18:54 +0800
Message-ID: <cbaa7601-3614-4e76-9d4e-c56e022e0917@open-hieco.net>
Date: Fri, 4 Sep 2026 11:18:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] pci_ids: Add Hygon Family 0x18 DF F3/F4 device IDs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, yazen.ghannam@amd.com,
 mario.limonciello@amd.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
 bhelgaas@google.com, x86@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260903221043.GA2261875@bhelgaas>
Content-Language: en-US
From: Lin Wang <wanglin@open-hieco.net>
In-Reply-To: <20260903221043.GA2261875@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/2026 6:10 AM, Bjorn Helgaas wrote:
>> +#define PCI_DEVICE_ID_HYGON_18H_M04H_DF_F3	0x1463
>> +#define PCI_DEVICE_ID_HYGON_18H_M04H_DF_F4	0x1464
>> +#define PCI_DEVICE_ID_HYGON_18H_M04H_DF_F3B	0x1493
>> +#define PCI_DEVICE_ID_HYGON_18H_M04H_DF_F4B	0x1494
>> +#define PCI_DEVICE_ID_HYGON_18H_M05H_DF_F3	0x14b3
>> +#define PCI_DEVICE_ID_HYGON_18H_M05H_DF_F4	0x14b4
> It looks like these are only needed in one place, so per the note:
> 
>   *      Do not add new entries to this file unless the definitions
>   *      are shared between multiple drivers.
> 
> the #defines should probably be added in the
> arch/x86/kernel/hygon_node.c (or just use the raw hex values).
> 
> This helps reduce conflicts when backporting changes like this.

Hi Bjorn,

Thanks for pointing this out.

These IDs are only used by the Hygon node code in this series. I will
move the definitions to arch/x86/kernel/hygon_node.c. They can be added 
to pci_ids.h later when needed by in-tree users.

Thanks & Br;

Lin

