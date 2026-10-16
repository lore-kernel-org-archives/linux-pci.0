Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0879497392
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154135; cv=none; b=fq+lgriOXyS5xICWQv3w38HHQky67AKJkisIqjM/hBBYyWRagXpjTIa/Ct1mv/EoV+IhKqh+tpPGpBP6D9A7VNmNct6R/KfA2zBwjn9IkawQsA4+stN7nTZ3aWyqg/Y9PZ29o2+sDN8tm1jkFh6JVn+HoSETjYZ9LhR3T66kShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154135; c=relaxed/simple;
	bh=aSu4fPkvdgD69XVSSJdgQhQsUOzXL9ufWnahhnOOFfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxLWftemhb7mcrdR7ockzE204yUG0Fv4jFDkMVHJ0QfMPLnFijqNqtdxxnZe6Asy9iQoFu/bKbyomed1p466PjPi+m+s3hAwkecBeBlxy1fgpROQlna+9Qy7BnCcthzC8rnGiuxHRroXV2iR7q4sOp1dhMAIpZ2ScJvocz5ItgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LS7uMZsC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LS7uMZsC"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a0213948d3so40234705e9.2
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792154131; x=1792758931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Oaxw1ojTm33dUVZ3YmdLAwJF+qVMH14EEkliPunBjow=;
        b=LS7uMZsCWzoGBSjI/KzRbrH7GOvwnvOdl0Mx4RNXWVsISnfctBZMR2CHsdWMH/Hf5i
         iqVwIMuGmTSQOF97TxKX2cgEL+BTAsqsCINnUbnoDx8K2JvkfsHJPfSgUgfoBe9DAqTq
         Nh8r6Xf8LUaROaPAps78xk95B8rGRxRw91b1DBhxleIx51rufx+aopXgazMbXMll61La
         SMVXpXoNzcSd9vTARbEygIVFUHGIzjMlYqZDMSQUaqu5aTF9aYSLUN1Ah/g99Jqe1L6e
         v4O26TqeUeUwtSjwC/vAD/NFg6smWAMMson008OxFPFT7XYRCIFGEsHkjZV0nAbi1GhB
         BkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792154131; x=1792758931;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Oaxw1ojTm33dUVZ3YmdLAwJF+qVMH14EEkliPunBjow=;
        b=FXEsAUO9rSEZL0Ez/q0AB76whDuawlON2KSKCAYXNijeyLwy2v+YYIx3f7MAaVhicT
         oLNHK/4n8IrWoJ5i2AVYYu6H3C6BtpJy4VuEyHQnzdLyDelx5psTZsr0pluUTRd/n+uA
         ujybFO2cTetQ1XnFvfaVrd/V7lDtrvtir0PgkvKZZU+A2P7gW6sLY2HV9n8sftyp5hTo
         d+9v58y+gAhWrp6UEm/bA1uEB8jiEiHF0ur8hoX5n03tJjaFeTq9rhYe5thS8Y1B13ct
         WJ5sAcIEO1JEh0HJTBfQi+wD+xPWW6J+qrhhTiTVg/cNRiYT4IqDwqBlGaNDZryUffuG
         Gq+Q==
X-Forwarded-Encrypted: i=1; AKwUvByDcvaqNwO99cjNcIK9KV4BpKbOMnHmNXe8PjXrDbgKl054oF1jBQPUDoCbzbt30E249Q6xEbKR+Z0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX04tcLk7hSTSdhhaAW6VkO3eS8Cf70CmCMVdHUSNq/1deaOb0
	mPB80Job/3/3mud6IKKj6M1AJ7OajWONu2eh8rQXGOpwwlVURi+LP2gbUEIbakqQa5I=
X-Gm-Gg: AYBFou1PspB0/7sr6usHnTvSbYuWlVOoJe8dAzz/CxnjGWhnozDAjJ7dSfmyjpcInMD
	+Aorc1Ei9QiPMJlxsiu6vd79r6EjpCbtyHqKKI2DweeOu1PiyLtpDpmu8HBTFeXbcpNVjdZ7296
	QQKMNbH3qL111O17sxe3+UxNx0fVIXObkJ+gEcNLe5/u6IoM6xCX6S3uywKIf8BnUokVPfVErvn
	sD/fUtuIqA+pnae3J8zD1TopWaw7Wf1rzf8uho80XLS2E5a5YkirMQTeSc2tsxAGHaQhZfeLjHz
	vOCFyqooveGFkC/UTicIyNB9784GB9WA6L/zdw6PlJMkbLrKz0Oealdvqcw4f/HzgAYUS5evHdB
	3kyh/XMJq9IeyqpvfK0sNu+ABOJG4slvxMaxGF70pa9oD6tCmFb38Oma8DkhVznUaBrXskR6eXo
	zCPgUBEc9UoXsmbFYjGGmXg0dkOabsbBNWZAPvMPf2EobWYQWYkKov942OinrlQdio2RSo2Vp4r
	gPxI91q5kXTynHXoR6nRp6j
X-Received: by 2002:a05:600c:3f18:b0:49f:fbad:29c1 with SMTP id 5b1f17b1804b1-4a18e4cedfcmr420105305e9.33.1792154130780;
        Fri, 16 Oct 2026 05:35:30 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b35a6sm140099685e9.6.2026.10.16.05.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 05:35:30 -0700 (PDT)
Message-ID: <230ba855-0a7a-4187-aee4-ac551c1cac76@suse.com>
Date: Fri, 16 Oct 2026 15:35:28 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] PCI/TSM: Create MMIO descriptors via TDISP Report
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
 jic23@kernel.org, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, jgg@nvidia.com, aneesh.kumar@kernel.org,
 aik@amd.com, iweiny@kernel.org, ming.li@zohomail.com, icheng@nvidia.com,
 bhelgaas@google.com, smadhavan@nvidia.com, ilpo.jarvinen@linux.intel.com,
 Smita.KoralahalliChannabasappa@amd.com, andriy.shevchenko@linux.intel.com,
 linux-coco@lists.linux.dev
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-2-ankita@nvidia.com>
 <7605d698-b08c-4fcb-b86b-3f79927fb0d5@suse.com>
 <atIRRUO/t/Fj4VX6@yilunxu-OptiPlex-7050>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <atIRRUO/t/Fj4VX6@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.10.26 г. 14:57 ч., Xu Yilun wrote:
>>> +int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
>>> +{
>>> +	int i;
>>> +
>>> +	device_lock_assert(&pdev->dev);
>>> +	if (pdev->dev.driver)
>>> +		return -EBUSY;
>>> +
>>> +	for (i = 0; i < mmio->nr; i++) {
>>> +		struct resource *res = pci_tsm_mmio_resource(mmio, i);
>>> +		int j;
>>> +
>>> +		if (resource_size(res) == 0 || !(res->flags & IORESOURCE_MEM))
>>> +			break;
>>> +
>>> +		/* Only require the caller to set the range, init remainder */
>>> +		*res = DEFINE_RES_NAMED_DESC(res->start, resource_size(res),
>>> +					     pci_name(pdev), IORESOURCE_MEM,
>>> +					     IORES_DESC_ENCRYPTED);
>>> +
>>> +		for (j = 0; j < PCI_NUM_RESOURCES; j++)
>>> +			if (resource_contains(pci_resource_n(pdev, j), res))
>>> +				break;
>>> +
>>> +		/* Request is outside of device MMIO */
>>> +		if (j >= PCI_NUM_RESOURCES)
>>> +			break;
>>> +
>>> +		if (insert_resource(&encrypted_iomem_resource, res) != 0)
>>> +			break;
>>> +	}
>>> +
>>> +	if (i >= mmio->nr)
>>> +		return 0;
>>
>> Shouldn't this check be if (i == mmio->nr -1 ) i.e all descriptors have been
>> initialized, given the for loop condition i can ever be at most mmio->nr - 1
>> i.e the actual index of a descriptor?
> 
> The original if (i >= mmio->nr) check is correct. Valid i is at most mmio->nr -1,
> but you need an invalid i to finish the loop.


Shouldn't the check strictly check for i  == mmio->nr the loop 
terminating condition, which means "we've initialized ALL mmio 
resources" otherwise perform the cleanup, that '>' can never be true.

  While not wrong per-se having a strict check would be far clearer, no?
