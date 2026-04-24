Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E82E0B71;
	Fri, 24 Apr 2026 03:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777002309; cv=none; b=jp5Y+PF6jMIjwb72q0XcyHNx/+2yVsTQ9B5ZNVNphs4Guz7hbFtqc7nci8CvJjlqwOvlsjQK+iQ3OGU8JRh2n6JEx6kgTO0Y+r/ieuxpgQe9qyKmGRDtPCdspXRea7sprJKQtC73q0M/sEkXOPJ6TY0PMSS5mq0QlEWk+GD2b20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777002309; c=relaxed/simple;
	bh=X+5A40scbixq5u9H1j7Me4opxgGy+ZP/KoDdDgkH5TI=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aMwNewFSTHMr5ZWyf+a51obk9nz6Snt1QUsnNJzhH/F7hzuz3DK8OLTeKEgS4d6vmgAWRI0h+BGTdXKYQoKwzTOKPaxopdWv8m5YBd4mDIukxZmMKWOpEBTlGdBymu7A/rT/iW7GURbRlGftAM4lhJk54XQiWQip43qVZqgN2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0940584|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0806922-0.00173379-0.917574;FP=17147295947610981819|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045018182;MF=fuhao@open-hieco.net;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.hJ8d75U_1777002301;
Received: from 172.25.21.240(mailfrom:fuhao@open-hieco.net fp:SMTPD_---.hJ8d75U_1777002301 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 24 Apr 2026 11:45:02 +0800
From: Fu Hao <fuhao@open-hieco.net>
Subject: Re: [PATCH v2 6/8] ALSA: hda: Add support for Hygon family 18h model
 5h HD-Audio
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, perex@perex.cz, tiwai@suse.com,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260410224735.GA598593@bhelgaas>
Message-ID: <7a1d81b3-176f-9b06-5ef6-c3dabd46fa47@open-hieco.net>
Date: Fri, 24 Apr 2026 11:44:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260410224735.GA598593@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2026/4/11 6:47, Bjorn Helgaas wrote:
> On Tue, Apr 07, 2026 at 04:24:56PM +0800, Fu Hao wrote:
>> Add the new PCI ID 0x1d94 0x14a9 for Hygon family 18h model 5h
>> HDA controller.
>>
>> Signed-off-by: Fu Hao <fuhao@open-hieco.net>
>> ---
>>   include/linux/pci_ids.h       | 1 +
>>   sound/hda/controllers/intel.c | 5 +++++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 406abf629..19d968017 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -2613,6 +2613,7 @@
>>   #define PCI_VENDOR_ID_ROCKCHIP		0x1d87
>>   
>>   #define PCI_VENDOR_ID_HYGON		0x1d94
>> +#define PCI_DEVICE_ID_HYGON_18H_M05H_HDA	0x14a9
> 
> It looks like PCI_DEVICE_ID_HYGON_18H_M05H_HDA is only used in
> sound/hda/controllers/intel.c, so it should probably be defined there
> so you don't need to modify include/linux/pci_ids.h:
> 
>   *      Do not add new entries to this file unless the definitions
>   *      are shared between multiple drivers.
> 

Thank you for the clear guidance.I will modify it in v3 patch.

-- 
Regards,
Fu Hao
