Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79773932F7
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 22:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929189; cv=none; b=uvPI3ZWyhMK0fej6DuUSvalRRmuYB5ZL6cxTjzaPhoBSbafaCFqX2I6bs9/aQM1LcqZYtVJgA5LuVC7UP/9vnEgQHdY+ACTShIFwCv14E9IChEOwO+ZmmS9EZqY5NLaw5Avr7T4l+KvV8NuOh/cC1LVcEDIhsG1NZDT9XlxNex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929189; c=relaxed/simple;
	bh=R4mw4YXqKd2LrDQg5vzz7Mwn/J4jo8bx27rr5OcWF+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nD/I76t5Ws9rbzaL/SpkX5W8GIRO9aS3E7XmKqSzvvjo2h0Svgg08yzqbrBfZxLlij50MO9MVXdu7JHZyNPv0gHxj8RWLVyrIpkYZdZ+LG0ZaAZbRPqauRcsRlyhGQkZEeu3OAFD2MxL2wM/5EZVBhyPuxoWLTaUSpZSoa7maE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=ING3eLxQ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ING3eLxQ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53504882980so41740321cf.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1791929186; x=1792533986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=umQgXj7ysEV3zD1fFGyj23U4O8i1rJgqwEHTF6H4HNg=;
        b=ING3eLxQT2U9JnsicqETxyH7Q0tI63R4vz+m+DAcDZmj6dSU0d3M5u4FJXmtumPoF5
         uN07hSI7sdDWf8TZD7QYkHiB8UC936qKjP67pwBIbDmD4WdJ8z9Hz2DBI7DRG8gtl5fF
         sKd8Y+CCK4ay/keEe7KmYo5SoavAyglFzbirsJ2VToWgmVY0j3u+sxjyVjwZlOxF5HYI
         BVK+sKtwNoA8FWnYdPuLY05ZjJ1gJt8bwjnoH9lYqq6cT1Kdd2IgAP+FXKwd51XONsa/
         YKp/4bxF8w5Evv7qDsunbLli1IIbFbB/4cSM7utJJN8PIKinp8ObDxewy0f6yMoeQUP5
         +a1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791929186; x=1792533986;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=umQgXj7ysEV3zD1fFGyj23U4O8i1rJgqwEHTF6H4HNg=;
        b=s3UwoFz1loq7F3ikaiSaeTqdE9xXLuCvEg8Z5wfcU6Z1ho10GZAHnloI+TY/maOEM3
         V2EEqRHoPETD6VT2Ocnbx2rq0nwkljuCobAAj8IVT8ESZHD2qfuBVfq0Ne+gUn1x7u0Y
         Js0Diek0NnIrQRLPswlNV0Q4oAooTUPoeRvBF+8924S/8QWnPmlUrZF/otsDxHoFA3Ov
         SlQ8cuxRlGr/+cYrlqz78kGciM4accFhvZzvhnKF/nhVK2QAUQay2e6rcxk7GL6avMRl
         RmfLjpwvaXhJZz30uhzcI41bPfk5NzhWCFTyGkWGtHtHFztxx01vMPPD6jErA2H09yz6
         DhxA==
X-Forwarded-Encrypted: i=1; AKwUvByo5ElfTHkHqELa2OOBv6DRsNwD1rtSSli8oR4Q0j5XAdtypcJb9AWPgWy+CEbhTEQOxhoPiNo+Pmo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIccjuv/JQX8aZirzHHIpJtF2JwpAMAYIlr4Tl/u/ZUrP3bfIOM
	RE6vlS0JJSjISYnOBrWI0yinOZCPpnQBZ1K2xOUfBqUiI0s/LmY31Jx+qPxF3IuayVI=
X-Gm-Gg: AYBFou1U94CLISba0ueYMAR79Vj7Faq/lQxj+AOd/zheKTF0fgf8lpPFqIIcSnnsdni
	7e0+y1ZG55N8QxdNFrhektCdGb6YsvwJXtnCWI9W2T8ARqpY5MhuUFaRP6SbSpj8W0zaVdmRsjh
	P299rEK5B3ZK0igVyt/9piCT9AiRm07MmxLMfQ57gdJTN0T87UBRm/OthLSZg2jIaT0A5fEbEj4
	ip87ByGBELr3qQgyI6IUpviKobR4HkNvD2YFBAZnWUP4UxYjB2vyeFAwJUgihqYuA6rFzHpNL/H
	mTf5vmhgVBCtvdcLkvnnGhCIXgsXr4JdaOAhvMQOIfNl17e8Oz0iMKp26RybRcCppN1zZVWUghQ
	sSt8UMYdMPoMZYVl50c/ioqvl8Q65Q0Et6JjimZceDfl468trTXhNNLgcz+HubLVqcHPv2DVDS0
	GnLrkPtB6R1qTk7oI3ZLvk6ngwcroh1rGjY1BPoxvkDCOks9vWfYiB3A+BqCxVlstD0wnlCzg=
X-Received: by 2002:a05:622a:4086:b0:535:231d:653e with SMTP id d75a77b69052e-5359fb8efc9mr209706161cf.45.1791929186563;
        Tue, 13 Oct 2026 15:06:26 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b6fa173sm111107631cf.7.2026.10.13.15.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 15:06:26 -0700 (PDT)
Message-ID: <8c0afe7c-a5dc-49a0-a413-1e572d69129d@riscstar.com>
Date: Tue, 13 Oct 2026 17:06:24 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] PCI: of: introduce of_pci_build_prop_ranges()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, lizhi.hou@amd.com, herve.codina@bootlin.com,
 andrea.porta@suse.com, daniel@riscstar.com, mohdayaa@qti.qualcomm.com,
 lbiancon@qti.qualcomm.com, mani@kernel.org, robh@kernel.org,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260924222444.1351466-1-elder@riscstar.com>
 <20260924222444.1351466-3-elder@riscstar.com>
 <00eb50b8-20dd-3079-7bcf-7e30a9ff3b20@linux.intel.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <00eb50b8-20dd-3079-7bcf-7e30a9ff3b20@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/9/26 5:43 AM, Ilpo Järvinen wrote:
> On Thu, 24 Sep 2026, Alex Elder wrote:
> 
>> Move the bulk of what happens inside of_pci_prop_ranges() into
>> a helper function that builds up the value to be passed to
>> of_changeset_add_prop_u32_array().
>>
>> This helper will be used in the next commit to build the ranges
>> property for a statically-defined PCI endpoint devicetree node
>> when it has a "pci-ep-bus" sub-node.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>

Thanks for your review.  As I comment below, I'll add the
#includes you mention, to ensure the symbols used aren't
declared by accident.

You commented on patch 3/3 too, but I'll respond here:
you suggested adding an include, and I'll fix that in
version 4 of this series.
>> ---
>>   drivers/pci/of_property.c | 129 +++++++++++++++++++++++++-------------
>>   1 file changed, 86 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
>> index a6c0cca986bdc..9f30b3c09a730 100644
>> --- a/drivers/pci/of_property.c
>> +++ b/drivers/pci/of_property.c
>> @@ -102,57 +102,100 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
>>   					       ARRAY_SIZE(bus_range));
>>   }
>>   
>> +/*
>> + * Build a "ranges" property value that defines the mapping between
>> + * child and parent PCI address space for each of the given PCI
>> + * device's resources.
>> + *
>> + * Returns a dynamically allocated array of u32 devicetree cells, or
>> + * a null pointer if allocation fails.  The cell array is built as a
>> + * of_pci_prop_ranges structure consisting of 8 32-bit cells in host
>> + * byte order.  It is suitable for use as the value of a PCI device
>> + * node "ranges" property passed to of_changeset_add_prop_u32_array().
>> + * The total number of cells in the array is returned in *count.
>> + *
>> + * Caller is responsible for ensuring the returned pointer gets freed.
>> + */
>> +static u32 *of_pci_build_prop_ranges(struct pci_dev *pdev, u32 *count)
>> +{
>> +	bool bridge_device = pci_is_bridge(pdev);
>> +	struct of_pci_range_entry *entries;
>> +	struct of_pci_range_entry *ep;
>> +	u32 resource_count = 0;
>> +	struct resource *res;
>> +	u32 first;
>> +	u32 num;
>> +	u32 i;
>> +
>> +	if (bridge_device) {
>> +		first = PCI_BRIDGE_RESOURCES;
>> +		num = PCI_BRIDGE_RESOURCE_NUM;
>> +	} else {
>> +		first = PCI_STD_RESOURCES;
>> +		num = PCI_STD_NUM_BARS;
>> +	}
>> +
>> +	/* First count how many resources will get a range property */
>> +	res = &pdev->resource[first];
> 
> pci_resource_n()

That's better.  I'll use that.

> 
>> +	for (i = 0; i < num; i++, res++)
>> +		if (resource_size(res) && !of_pci_get_addr_flags(res, NULL))
> 
> + ioport.h
> 
> (I know you're mostly moving code around in this change so these missing
> includes are a pre-existing problem but it would be nice to finally add
> them.)

I'll gladly add this and the others you mention below.  I like
to include whatever I need but I currently only do that by
manually scanning through (and fixing it when there's a warning).
> 
>> +			resource_count++;
>> +
>> +	entries = kzalloc_objs(*entries, resource_count);
> 
> include
> 
>> +	if (!entries)
>> +		return NULL;
>> +
>> +	ep = entries;
>> +	res = &pdev->resource[first];
> 
> pci_resource_n()
> 
>> +	for (i = 0; i < num; i++, res++) {
>> +		u64 size = resource_size(res);
>> +		u32 flags;
>> +
>> +		if (!size || of_pci_get_addr_flags(res, &flags))
>> +			continue;
>> +
>> +		/* Record the size in the range entry */
> 
>> +		ep->size[0] = upper_32_bits(size);
>> +		ep->size[1] = lower_32_bits(size);
> 
> include.
> 
>> +
>> +		/* Record the parent bus address from the resource */
>> +		of_pci_set_address(pdev, ep->parent_addr,
>> +				   pci_bus_address(pdev, first + i),
>> +				   flags, false);
>> +
>> +		/*
>> +		 * For a bridge device, the child address matches the
>> +		 * parent address (including its flags cell).  For an
>> +		 * endpoint device, the (flags) cell contains the BAR
>> +		 * number, and the two address cells are zero.
>> +		 */
>> +		if (bridge_device)
>> +			memcpy(ep->child_addr, ep->parent_addr,
>> +			       sizeof(ep->child_addr));
>> +		else
>> +			ep->child_addr[0] = i;
>> +
>> +		ep++;
>> +	}
>> +	*count = resource_count * sizeof(*ep) / sizeof(u32);
>> +
>> +	return (u32 *)entries;
>> +}
>> +
>>   static int of_pci_prop_ranges(struct pci_dev *pdev, struct of_changeset *ocs,
>>   			      struct device_node *np)
>>   {
>>   	struct of_pci_range_entry *rp;
>> -	struct resource *res;
>> -	int i, j, ret;
>> -	u32 flags, num;
>> -	u64 val64;
>> +	u32 *value;
>> +	u32 count;
>> +	int ret;
>>   
>> -	if (pci_is_bridge(pdev)) {
>> -		num = PCI_BRIDGE_RESOURCE_NUM;
>> -		res = &pdev->resource[PCI_BRIDGE_RESOURCES];
>> -	} else {
>> -		num = PCI_STD_NUM_BARS;
>> -		res = &pdev->resource[PCI_STD_RESOURCES];
>> -	}
>> -
>> -	rp = kzalloc_objs(*rp, num);
>> -	if (!rp)
>> +	value = of_pci_build_prop_ranges(pdev, &count);
>> +	if (!value)
>>   		return -ENOMEM;
>>   
>> -	for (i = 0, j = 0; j < num; j++) {
>> -		if (!resource_size(&res[j]))
>> -			continue;
>> +	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", value, count);
>>   
>> -		if (of_pci_get_addr_flags(&res[j], &flags))
>> -			continue;
>> -
>> -		val64 = pci_bus_address(pdev, &res[j] - pdev->resource);
>> -		of_pci_set_address(pdev, rp[i].parent_addr, val64, flags,
>> -				   false);
>> -		if (pci_is_bridge(pdev)) {
>> -			memcpy(rp[i].child_addr, rp[i].parent_addr,
>> -			       sizeof(rp[i].child_addr));
>> -		} else {
>> -			/*
>> -			 * For endpoint device, the lower 64-bits of child
>> -			 * address is always zero.
>> -			 */
>> -			rp[i].child_addr[0] = j;
>> -		}
>> -
>> -		val64 = resource_size(&res[j]);
>> -		rp[i].size[0] = upper_32_bits(val64);
>> -		rp[i].size[1] = lower_32_bits(val64);
>> -
>> -		i++;
>> -	}
>> -
>> -	ret = of_changeset_add_prop_u32_array(ocs, np, "ranges", (u32 *)rp,
>> -					      i * sizeof(*rp) / sizeof(u32));
>>   	kfree(rp);
> 
> Isn't totally rp unused now so this frees with an uninitialized value?

Wow, you're right.  This line needs to go too.

					-Alex


>>   
>>   	return ret;
>>
> 

