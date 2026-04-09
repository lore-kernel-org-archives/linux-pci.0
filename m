Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8B03932E3
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775724997; cv=none; b=TyPh2QwF7G6WulfB8GAdgN/stFEPJ0RJtw01ZugrX5uuo4r7QV/b11XCxUr8FcveMKNI5gCpSdATksWPdsrDlCad/Conq1aXlVRmsjngj8bAnmFVaHh2GmBkrVktWP6AgPAzBpixI2m6ACIeyLRruMbC47gbpn2QpHK278WY+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775724997; c=relaxed/simple;
	bh=WcwVq5/9fgi1xjKMepCQB56yilXqeTSjBbMxnY1af9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOjzVspUeo5h5bSZuPYSFQwNKN8nh8xxszy48MO6V1U/ESIqU18s7JelJIiWljN2CFaLTCmHrUnbrLKX2UWxZnqO3BIKecA3pCCAlQJC2UdCAxyQau6JsK5RBo+9RUrlmaSMJqq6lVrR3w9IigfbyLajWRigmRnzNXlfdP7GVQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X2ANfS5S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qtuI8GAG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X2ANfS5S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qtuI8GAG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775724992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zwk2fh7y+C0RrsYFO5wfxM8gZjDw/BYRnFc3e8tTqpc=;
	b=X2ANfS5S+bXt6T8O/1aSQnx6PgSUoM+Nl6/1Ei+rp/RcD+9SUsR4LrkJsTaxUBu+EatFis
	M62iSTaw23vo3CDmUboUklHzi8Zpi+8SI+jGc05T842P00EFttEwbNrmE6zS3oRc5HGNf0
	WNn89Y1e8pJfJhkoOEkbWMlB24TpZ+4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-v1mEKJZyNNKv44gRjL9OPg-1; Thu, 09 Apr 2026 04:56:31 -0400
X-MC-Unique: v1mEKJZyNNKv44gRjL9OPg-1
X-Mimecast-MFC-AGG-ID: v1mEKJZyNNKv44gRjL9OPg_1775724990
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-483786a09b1so6603815e9.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2026 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775724990; x=1776329790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zwk2fh7y+C0RrsYFO5wfxM8gZjDw/BYRnFc3e8tTqpc=;
        b=qtuI8GAGQ7UdYywZG8NRnAMt8A6hLwDwxFXdBbzlNjTa8Dm7QAiATssdm+YZAT8E2u
         A544SkTh8bg4oW1nu/tyxym6LL3Kz1FM2FQbLbt6H/vKgV68m2F6TrWS1J2OwfVsQQsn
         MHJhxWmZL+uF0Ujjt33xeX9mBCuboS6ITrffIu0t6nc63dq4LJG/EYBOSNsyP61Jnv9b
         kr+X1qjMBKx73dOktljrBGK7+49ZFpSIFDU5cibH9lpDHWrhzzNhKW8wOdbsK4pNBSI4
         MGVUvxYqASl9RbEjhgv7boQ3i6P9c0Zncrr2RHD4JjFRTHZmiou+EbG9ziHZR3l6LQWM
         L6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775724990; x=1776329790;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zwk2fh7y+C0RrsYFO5wfxM8gZjDw/BYRnFc3e8tTqpc=;
        b=f10oNxnNpeOvXm58znfYMycPG570Vx59ALlSgFyoty1uX9+VNmJ46Cs92pXlbXR3Kc
         VQFykHVaW+hIr45P9ZcEH3sYoGEtcIxipGDS0bV9mRlam2Sxt4OZ/yGOcN2g9ww19193
         qVxIDL6hArnVVf3zLTIxKHKOZhTaxJY+rcdP6y5AaOMFSVpZaKlpBj6BoKF9q2L/sa+U
         ESnflizEbDJV1tD37os7aa7z9Cpe/WBQ333Yv3UEwDuUPrsT1EBaZQlz6NwxXUe9c00G
         3i7G5oBNhb2qoGyz2UlVlcWg4HOEpSdURyZUYOboiPUnRleadgxesql3xpPTAAE00P/t
         PUXA==
X-Forwarded-Encrypted: i=1; AJvYcCVTimdM34a3O18I5n90Ej8ZgOAieWG+vtiP1FFyXIAy0NWdEK8FfMx4OdrEF7xuMPKW2UpFdOYqPrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj95P2FQnY7umMuDrqrMFC5pKD0t+NyEv02YTdeASIl0FC+6aA
	WkR7Rmh1KgL8Cq6EDVagD9IgkqYqLtXOZ4uo6d40FRTl2Cii4UaQSvPPeTK/qTCv063GGnlmHd8
	hnEbKI3d6hMtPii2S4SH56Z/RjFSv/OpDDuW8lmXmv6FqYf5faxIsJT+MI/DFow==
X-Gm-Gg: AeBDiesIGiKtEdGf5KeJutl92d+mykMsoAxUxKAD6EQmDsZFZl0Jauz2sw4EFDNny9j
	BLQGVrbYmQNz+5q4tHgLDv+VguZo6DVAudWl0MEnEVupiqPSWDsdWLRZZcbaZewSlyBV5/4lr8m
	c+v6Yoay8GezfOhlPjTE5rpXoa9gqYLh60d/bjNTg2zxcqI3igsGAdJ2WEAdNzSSX3KpqGPJy0q
	tlWQUGJSc2UOiImg9AaZxvgBzyHCrPD0cEKVnHWMnrG0VWNg31GKnP7x3eQk2vXvRudIiS2ywUz
	ZBS643YgebpgPUjpsr8y760orr2SztFjQJrumNbD2uEHbjaFmgKC98B0zKYEaI6P9LO0RKoFCdk
	oN14ETWJ3joTDpwzfFZasg4rbIDmrxQR9GXbVGmOVDZqwGc9+mKtxKi2s
X-Received: by 2002:a05:600c:6384:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488c282e8a7mr126336545e9.19.1775724990113;
        Thu, 09 Apr 2026 01:56:30 -0700 (PDT)
X-Received: by 2002:a05:600c:6384:b0:488:c282:e78c with SMTP id 5b1f17b1804b1-488c282e8a7mr126335955e9.19.1775724989664;
        Thu, 09 Apr 2026 01:56:29 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd19ea26sm56602265e9.3.2026.04.09.01.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 01:56:29 -0700 (PDT)
Message-ID: <2e618260-2153-4c36-be61-d2329c9da13f@redhat.com>
Date: Thu, 9 Apr 2026 10:56:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/14] libie: add PCI device initialization
 helpers to libie
To: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org
Cc: Phani R Burra <phani.r.burra@intel.com>, larysa.zaremba@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 sridhar.samudrala@intel.com, anjali.singhai@intel.com,
 michal.swiatkowski@linux.intel.com, maciej.fijalkowski@intel.com,
 emil.s.tantilov@intel.com, madhu.chittim@intel.com, joshua.a.hay@intel.com,
 jacob.e.keller@intel.com, jayaprakash.shanmugam@intel.com, jiri@resnulli.us,
 horms@kernel.org, corbet@lwn.net, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 Bharath R <bharath.r@intel.com>, Samuel Salin <Samuel.salin@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
 <20260403194938.3577011-3-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260403194938.3577011-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/26 9:49 PM, Tony Nguyen wrote:
> +	mr = libie_find_mmio_region(&mmio_info->mmio_list, offset, size,
> +				    bar_idx);
> +	if (mr) {
> +		pci_warn(pdev,
> +			 "Mapping of BAR%u (offset=%llu, size=%llu) intersecting region (offset=%llu, size=%llu) already exists\n",
> +			 bar_idx, (unsigned long long)mr->offset,
> +			 (unsigned long long)mr->size,
> +			 (unsigned long long)offset, (unsigned long long)size);
> +		return mr->offset <= offset &&
> +		       mr->offset + mr->size >= offset + size;

Sashiko says:

---
Does returning true here without creating a new tracking object leave
the new mapping tied to the original mapping's lifetime?
If the driver unmaps the original region, iounmap() is called and the
tracking object is freed. Any cached virtual address pointers to the
sub-region would then become a use-after-free, and subsequent queries
for the sub-region would fail.
---

/P

