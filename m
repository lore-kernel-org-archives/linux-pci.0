Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226B27467F
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867780; cv=none; b=FmPS4wttzZ9C6yXBSFgilOPJSiJ3ZQDTRRVrjZdXpmTEe/XUr2PLIkCPwB/JEyL+uLSga2af05/QFXCOuBQ3PzBbebo+O37Cs6o1J9+CAT8Gqi3xr5ezRgqrcpVI1SXZWRSSamjsZZcJCXMtj43D/VS3qt6DXd8YkiZxhD4L/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867780; c=relaxed/simple;
	bh=gbI4kKCuIVYd3slz/BDdKsHR65y7lB9h+f5cJIu4c7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNbPAWywdUxlgoq6bVK04tpuqqjwqu08I0/6th6iBcHwf0lJFrYOEZ7288DakQsIoyoeCZZalE+qXCKWFJVpN5xOSf41RIISLAu33FeiuVDXPOfBdaAJHqFZ/az+XICU1/svuYAGSV28iIJh2R3YRiKlI54qNdoXNodfPP4Rj44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=NlYNgjcL; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="NlYNgjcL"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIbfZS710935
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 07:22:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=G31TJF0EZFmPxGyRVjY8ZspmC4oSoYUwBfQ/uR97foo=; b=NlYNgjcLYCes
	Ofg/4s0/n1XRiQWeLRIjzd6QVkk0OpCbGHal/Ge0Jq2cDLPCZfNOVmhF011TZ9Ku
	qWmn44NJ03a02wgldm+nKd72cnaC8EzCV0FstiknCv3GVafEAg+zZn1cksANpvAW
	xQerZGEDIv5nxlrVAifESLIC9SyrHmWBgiLFk243IVUbRIy2mD3FEKG3yi4LTpQ3
	v5a9UT8jXq5ZrfGrVN60QLe/F6EQf3bxT9bdGDjld4SyBvMblRoPdfEKvCyqeaOP
	RW28GyDZju9LxLjHcv5jXTWAl2/dBPRuqZRSq+u/HPlSH7K1C62oyaV6kSO7h1QJ
	zqu9lHMtYw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepc5j67-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 07:22:58 -0700 (PDT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ddd8ef5343so5121536eec.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 07:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776867778; x=1777472578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G31TJF0EZFmPxGyRVjY8ZspmC4oSoYUwBfQ/uR97foo=;
        b=ey6yg+IE8MM+h3+jcRoalwhsMS5TaqngXFd3MSBvnEZ6kBW0Hx0SDXAhvU0b9PIvLD
         /Ke5upRoOwxG3I75eL2LT5znNpqwcmTYcXl/oBP5dvL14pz32QZ1XU4DcaX8udWxkc9r
         jGXX+ojKd7GFyDWDNjplC1p4pao1PkxM1KzkKX1l2CRl8Sl3yedvRje4pzatk07jcJWC
         U60LnCk64u8O99KnQrB/8IPfZmU51KJaJd4naN9LbmrhtycQdCoIS23xJORWgM2iaadK
         Y3nr13+e13kW9LlJvdr6nt6QvaL0Lkl6PrtB3ynsp65stRbYf6rW/7q7U6+zRScAlrOi
         VBTw==
X-Forwarded-Encrypted: i=1; AFNElJ8WoQ1Vb9f9JUAzLCJnmyGgFb+m4LB2z3tO7OOC4kHkzU9SIH5Z3uIS0v4Qx/2y8n3dCKw5WyLTQOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrbRYryNL3DScs2O4c83LaqgpavFYagDy2vzYvBwJkEbemq47f
	PEXQJV/il+UoHMP/otcCGO9IHm9MT0BxgZ09OUoyiQXU2aeQp1mEGIA5dOHK7VnA5nULoRVUk2z
	CSk2gKbZezrbw2LNUVhypHR98aK4kkz474a3GGfX5VjEct92JlI6yJUMhA4q8
X-Gm-Gg: AeBDiev2zGYFolsNuJrMINtIznsI7MLKznLiOH2Mdy/NFCIoMr4sEIHBlhZ1698zz+G
	wxFJYBS4qnbtCqTt7u8dQfTnhdzKSRHGXmEAJpXrxpNeQc0I64+YTTNlTZ8Wn+TLVfV3WgyxLc1
	8OJTuQ0go2lS2DmhgNN5qY4RNE5q8HosdFROsjlw7MAytkR23Zm3FlO67YvKR2ZCYxCZPoiY26b
	n26StX8uOE8sUyN/COgIfLMSkLBqHcDAlC8a/adJSkWkfI0wycjZB+N9IZh4dLYUBWgzisbyRut
	LFHGPFhRG6BfjugOQ4rnac7AqqAqYdrxhDZwn6cQQ3v8VLKXc2qhzBFim5TsIkcHQ+Rg1CbXyrW
	nygDEFAfmmSaggvJSCA5GnpxHdwlxFWzOlU49L6LO
X-Received: by 2002:a05:7300:fb94:b0:2c5:220c:5670 with SMTP id 5a478bee46e88-2e4646ccd74mr11096508eec.2.1776867777856;
        Wed, 22 Apr 2026 07:22:57 -0700 (PDT)
X-Received: by 2002:a05:7300:fb94:b0:2c5:220c:5670 with SMTP id 5a478bee46e88-2e4646ccd74mr11096470eec.2.1776867777092;
        Wed, 22 Apr 2026 07:22:57 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm29466650eec.8.2026.04.22.07.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 07:22:56 -0700 (PDT)
Message-ID: <a42eff69-e31e-4f99-a63a-5db2402154eb@meta.com>
Date: Wed, 22 Apr 2026 15:22:53 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/P2PDMA: Avoid returning a provider for
 non_mappable_bars
Content-Language: en-GB
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe
 <logang@deltatee.com>,
        Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
        Niklas Schnelle
 <schnelle@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260421174351.3897842-1-mattev@meta.com>
 <20260421194954.GA28413@unreal>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260421194954.GA28413@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NInlPU6g c=1 sm=1 tr=0 ts=69e8d9c2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22 a=A9ac8u1S9ebtMFDS4YIA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: vk61F0ax3pCnbmfZa7oZTq8dywNpF-N-
X-Proofpoint-ORIG-GUID: vk61F0ax3pCnbmfZa7oZTq8dywNpF-N-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEzOSBTYWx0ZWRfX5Cxi+gjyqnIa
 FN6xC0OVnlvzLyhcFXcTYgGVvw7zI1tIv7CyU/FOpEUQWHTQDGF1MXaWTV3lgRpRdMXttAteROo
 52pMfZkUYGFJAIxMjZtADEQpQ7cpClNbl/07op74Z2wyhCViLOeOVp1eEH7GV15ut7KPDcuRhnK
 FL1iCRB93zguU097gigYlVWAHPv6WM3zB6MovSgUA5kVLrjHvBeg2NuIndmGvv/WbiDYgwYmLsv
 Dd4vg7T1lo7gvtOzbQRO4KZMfk3IJ58vdjBpxvG4A/bY/FCuAUc+UXSAKkzTZoUSuOsJu8WAEkC
 N7NcYnNsCmTxIAk2W67FqBuO45/3OTwbGbq6WLUUzo2GgSuJ/EaWgjiUKEHQwi2WoTlCEKZGHrI
 eC/Hu4AsPifexVL313+7PrGhxGnYJHLtqqf0A3Tw8hyLwfi0OW6yYLTtPbFbzJMJmuBJUyok1h6
 VnaloN5kfGc7OoUBCWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01

Hi Leon,

On 21/04/2026 20:49, Leon Romanovsky wrote:
> 
> On Tue, Apr 21, 2026 at 10:43:51AM -0700, Matt Evans wrote:
>> Extend pcim_p2pdma_provider()'s checks to exclude functions that have
>> pdev->non_mappable_bars set.
>>
>> Consumers such as VFIO were previously able to map these for access by
>> the CPU or P2P.  Update the comment on non_mappable_bars to show it
>> refers to any access, not just userspace CPU access.
>>
>> Fixes: 372d6d1b8ae3c ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")
> 
> I don't object to the patch, but this Fixes line doesn't look correct.
> non_mappable_bars applies only to s390, which doesn't support p2p. That
> wasn't prevented before 372d6d1b8ae3c refactoring too.

Thanks; I'd chosen that commit as it adds the function that the 
additional test is being added to.

As an example consumer, vfio_pci_core_get_dmabuf_phys() added in 
5d74781ebc86 ("vfio/pci: Add dma-buf export support for MMIO regions") 
could do an export when it shouldn't.  (And with my other mmap series, a 
CPU could then access it, not even P2P.)  I suppose this patch could 
point to 5d74781ebc86 instead (which allows the naughty DMABUF export), 
but I couldn't prove VFIO DMABUF export was the only thing using 
pcim_p2pdma_provider() added in 372d6d1b8ae3c (especially as that 
symbol's exported).

It still seems most watertight to treat this as a fix for anything 
containing 372d6d1b8ae3c, but if you feel it's not right what would be a 
better one?

Also, in the other thread (linked above) Alex made the point that whilst 
_today_ non_mappable_bars is only set by one s390 device, he expects 
future quirks or reasons to exclude mappings would also use 
non_mappable_bars so we shouldn't consider it a s390-specific thing.


Cheers,


Matt


