Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90D369211;
	Tue, 16 Jun 2026 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610498; cv=none; b=bZ3m3VcGI+0OEVEjycKZoxhho/K3NORw0ZlqK003wm89AiSxxngK7AcyY1RT0VZI2XuyqcawR7UgYJzWU3MrHSa8g2Vi3jBScO8AuHMimh/b34Ysae9HXSedSkTNoMp7uzHx4rEgSgUqpfKdc3s8gFVf+WDw+NogldMLRRWZig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610498; c=relaxed/simple;
	bh=mPuh6XTA5AG48/J010nDvu7vjHJ11jsGIAtOb9dpwKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jmy0e96YALMmT2uYZRpIjSrDba+bN0Fb7dTU9AlcmDleR1pkShQ9oJBbriNH6+OFcIahvJIdu/xAfya8VEWGbq/btrdKmpm6A15r711QB0c2nDIy+yb7Auf/8/JGlO7ehHFY4vSEr8qy1JdMCTweYIb+lJolG0Pa1L3OorRCagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=by1gU48a; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="by1gU48a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1781610494;
	bh=qE69fQEJl9oZRRpURxmwt3lhJuiBveqs8mE/8tXoWvc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=by1gU48aGo9nqyknUPasVL3O8zwdmOHSX+6iTukXhGM4QwwbgMcmcBwDlt9FVkriL
	 pauByJnAOozbCvQg3RBtEUD8n8RMBhTAKH8+sVOTJCrrI9VqYq52pvetzI+uTWTa2L
	 tBBCwIb4mNYaVXhyLp2YszevLUpBDgVVwkYjgK7FqckdGH7AYklacjsIcWZtN2b7ns
	 flSw3OZpkqy7dYIdGgPtzz8pT2RDWXIOG5Eu69Q6kKayjzEURagu2YcQjFLvLho/6r
	 G6QAty/jyShc/7rIKOrNlG5rh8h+XQw5aEdNk5CvO8zMdM2hCXoGoYJFLgUj9F41KM
	 kLYr4Gy13vzyQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4gflc75zjFz58bH;
	Tue, 16 Jun 2026 21:48:07 +1000 (AEST)
Message-ID: <20fb245b-2dc3-482a-8c2c-a3a6864a9005@ozlabs.org>
Date: Tue, 16 Jun 2026 12:48:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Content-Language: en-GB
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Alistair Popple
 <apopple@nvidia.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-3-matt@ozlabs.org>
 <DM6PR11MB369091A6F1E32054A95AB6788C182@DM6PR11MB3690.namprd11.prod.outlook.com>
 <4d75b948-3b74-4970-97f2-72e54f9c9694@ozlabs.org>
 <DM6PR11MB36903B0203CFFF97197676138CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
From: Matt Evans <matt@ozlabs.org>
In-Reply-To: <DM6PR11MB36903B0203CFFF97197676138CE52@DM6PR11MB3690.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Kevin,

On 16/06/2026 10:28, Tian, Kevin wrote:
>> From: Matt Evans <matt@ozlabs.org>
>> Sent: Tuesday, June 16, 2026 2:04 AM
>>
>> On 12/06/2026 09:42, Tian, Kevin wrote:
>>>> From: Matt Evans <matt@ozlabs.org>
>>>> Sent: Wednesday, June 10, 2026 11:43 PM
>>>>
>>>> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
>>>> +			      struct vm_area_struct *vma,
>>>> +			      unsigned long address,
>>>> +			      unsigned int order,
>>>> +			      unsigned long *out_pfn)
>>>> +{
>>>> [...]
>>>> +	 *
>>>> +	 * It's suboptimal if DMABUFs are created with neigbouring
>>> s/neigbouring/neighboring/
>> Ah, not a typo. 🙂  That is en_GB and AFAIK is permitted.
> I guess you meant 'neighbouring' and 'neighboring' are both valid.
> 
> but here lacking a 'h' should be a typo? 🙂

:D Doh!  Sure enough, you're right and that very much _is_ a typo after
all. :)


Thanks,

Matt

