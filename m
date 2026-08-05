Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59A4248B7;
	Wed,  5 Aug 2026 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938355; cv=none; b=Jp+sasILZd09iUnboHWYEAg+I1ZN8F4bW/ZJasYyejIAigHvTKW8wXBwkBRtQV/Qud+C4rBhgmL8oTKpeqBb2zWrMZGvkE/KbLzappT4xJtcRZp9iztsvcYC/M8bnyheOH/3NugF75NNmXsc4yZ7hzQ79S6/Tuz/whV5E/9mWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938355; c=relaxed/simple;
	bh=nZCWmFKl3LfWD6TOgQV63DvFZ0w2b2tqc7cSKVYPHH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUlZbITZ5u+ijAZ5tI/1dz4aXAYhRBiYE9tuZhCttr1zFxjn0+r9ceD8cM0UPdhH1IX1SI4AJpme8Cla1x0eQD7tsOCgrk0RO1Bt3wj4Ksn+af+RfoZ5mM2aT0kcyuK555p3chF6LerhXWpiCUUe75ZYMH35f61exGDNToq40Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=b95gvb2T; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="b95gvb2T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1785938349;
	bh=8ZKev4Gomd2h4BZnMddpS4sItcYMIlEiLKSOtv/oACM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b95gvb2TP5dDfbztGLQkGg1Hsi8rixtPTT0hgwmZ9XUcMkRJ8rigLdQSh4aWOCfdz
	 CIaOEgN96ojAF6jurM7yvXzvVQU/1+RpADhFufOUReH1qGjfq0lq04b1RpH9Hq53g9
	 Bq/ZXpW7qGfEakb2jw486rve0G81KGFJ2WTLNDNY9VdrPfsF3pwhUI4dWbKghdUoc/
	 +Vbe7vL7l61WpF3dThn7HKcDkusFrazYFY9/DzmJ0FAPmEP6+pHL/y2bqvQnwfVPZZ
	 ZUgFQ5FVBqPGLymqLUrR+qUuR4smm3aE/seJs/rp5Z0JTLhuDFvl18wUnTFH83wK3e
	 /MMTQALaNga0w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4hFX836TVwz4w23;
	Wed, 05 Aug 2026 23:58:59 +1000 (AEST)
Message-ID: <a0e71704-074a-415c-b910-d4e8b623874e@ozlabs.org>
Date: Wed, 5 Aug 2026 14:58:55 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>,
 Pranjal Shrivastava <praan@google.com>, Longfang Liu
 <liulongfang@huawei.com>, Mahmoud Adam <mngyadam@amazon.de>,
 David Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-8-matt@ozlabs.org>
 <20260729115204.2a9a50b2@shazbot.org>
 <6a964960-722c-44b5-837d-9d582aeb0a3c@ozlabs.org>
 <20260804141022.71b6429d@shazbot.org>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <20260804141022.71b6429d@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 04/08/2026 21:10, Alex Williamson wrote:
> On Thu, 30 Jul 2026 15:47:13 +0100
> Matt Evans <matt@ozlabs.org> wrote:
> 
>> Hi Alex,
>>
>> On 29/07/2026 18:52, Alex Williamson wrote:
>>> On Wed, 15 Jul 2026 18:47:30 +0100
>>> Matt Evans <matt@ozlabs.org> wrote:  
>>>> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
>>>> index 9a1674c152aa..e2b4252e7c3f 100644
>>>> --- a/include/linux/vfio_pci_core.h
>>>> +++ b/include/linux/vfio_pci_core.h
>>>> @@ -134,6 +134,7 @@ struct vfio_pci_core_device {
>>>>  	bool			pm_intx_masked;
>>>>  	bool			pm_runtime_engaged;
>>>>  	bool			sriov_active;
>>>> +	bool			zap_bars_on_revoke;
>>>>  	struct pci_saved_state	*pci_saved_state;
>>>>  	struct pci_saved_state	*pm_save;
>>>>  	int			ioeventfds_nr;  
>>>
>>> This should be in the bitfield usage group since it's only modified at
>>> init time.  
>>
>> This was intentional, but happy to change it if you're certain ofc.  Is
>> it inconceivable that a sub-driver could set it after init?  I'd say
>> they _shouldn't_, but only review will stop them and this placement
>> intended to be cautious.  It seemed a low cost way to avoid issues
>> around synchronisation on the bitfield.
> 
> I'd agree with the statement that they shouldn't, it would be difficult
> to synchronize setting the flag once there are any active mappings of
> the BARs.  Also, if we put it in the bitfield category under the
> comment that the value is only modified at setup/release, it documents
> the intentions, hopefully to the extent the author or reviewers notice.
> An argument can always be made to change it if there's a worthwhile use
> case.  Thanks,

Okay, book removed in favour of bit.

Thanks,


Matt

