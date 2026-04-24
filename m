Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57F30C629;
	Fri, 24 Apr 2026 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776999523; cv=none; b=T8WL6r4f49mFmQkeCPvz9vvIbu0cJgb891N4U8nx8xaLag4KrQtSy3qO1L0I4KR9ORbk5f1jgXFogWPRI55nyqKu+k4XRwFkRRCdpy1DVQT3VILBl28VBwglVHAWwjM8XNoQrvwC17AmWbkejbTmf5qzZ2kjX6i2SkUt6LS9YeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776999523; c=relaxed/simple;
	bh=LY7ylunqk041+wYs1GYZnUQlrTZKJSzxWmD03SswSJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ufq0e1Q7Kl453pmdMjBDWV3cGahFQTtGbkT4/twclSdaO7g6w08ZFmo4i5orZsHgR/nQKry0F32v4vsVSSPN4HwmiV4M4tdICc2LZwqqwtHKxLmWhGLle8lSsnpaLVnNJLTR9Jz5HyLN5q7oOAzLCa+TNEwu2hOgm2Nw4kr8Brk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljBJUnfC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljBJUnfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776999521; x=1808535521;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LY7ylunqk041+wYs1GYZnUQlrTZKJSzxWmD03SswSJU=;
  b=ljBJUnfC/snVKNKQN1ph8T9M8QX1Th4u6Ejow3u1eiZz0VjBZYLG9zNR
   rVhmrfyQRR2sA6PLeE3aafkC3x3wYke7BGDxduQGqYzTbpxaXy6TwtWAV
   OF7aCavgIkEYxVkAFu6zhkNb9ybN8vOHQyQH7oWODoVihJSAKS+APRBUf
   h4tfNxnSFme3a+eyS+CdJL+yc3HJA+tfAvdP/me5rSJMMdlOAUydgr9KG
   3Xl8hk1iuB6a4qeJ0EnXOuYtfsPqeNpJt8pq99+RlZePFO78V/qok77as
   iJYxuvlmKKGmLpZBMmA2VoCar/V51aIb9GdsCMlikvsMW8fOnijRXDmii
   g==;
X-CSE-ConnectionGUID: to7Ff+GmQS2e3ewMHFBnbw==
X-CSE-MsgGUID: QmqxEN8BSZCh8WRp0tSa/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="80560117"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="80560117"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 19:58:40 -0700
X-CSE-ConnectionGUID: dMsNdGbxQ7+V/twVt5iNEA==
X-CSE-MsgGUID: wQSmWBAmRnCEOkwzNUW2pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="256345644"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 19:58:36 -0700
Message-ID: <fa3d734c-4447-4b7b-9a8d-bb95ffd0e851@linux.intel.com>
Date: Fri, 24 Apr 2026 10:56:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] iommu: Pass in reset result to
 pci_dev_reset_iommu_done()
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
 Mostafa Saleh <smostafa@google.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com,
 Shuai Xue <xueshuai@linux.alibaba.com>
References: <cover.1776381841.git.nicolinc@nvidia.com>
 <bf99f11ac9a42b5552ec3367d02840366459ae7b.1776381841.git.nicolinc@nvidia.com>
 <c8c8b482-3781-4d33-9aea-866467d15b69@linux.intel.com>
 <aerZa3aQBMCwzzT8@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aerZa3aQBMCwzzT8@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/26 10:46, Nicolin Chen wrote:
> On Fri, Apr 24, 2026 at 10:38:09AM +0800, Baolu Lu wrote:
>> On 4/17/26 07:28, Nicolin Chen wrote:
>>> @@ -4083,6 +4093,18 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>>>    	if (WARN_ON(!group->blocking_domain))
>>>    		return;
>>> +	/*
>>> +	 * A reset failure implies that the device might be unreliable. E.g. its
>>> +	 * device cache might retain stale entries, which potentially results in
>>> +	 * memory corruption. Thus, do not unblock the device until a successful
>>> +	 * reset.
>>> +	 */
>>> +	if (!reset_succeeds) {
>>> +		pci_err(pdev,
>>> +			"Reset failed. Keep it blocked to protect memory\n");
>>> +		return;
>>> +	}
>>
>> Nit: pci_dev_reset_iommu_done() does nothing if reset_succeeds is false.
>> Would it be better to handle this in the caller instead? Something like:
>>
>> 	if (reset_succeeds)
>> 		pci_dev_reset_iommu_done(dev);
>>
>> ?
> 
> It would also need a print and some duplicated comments. Actually,
> that would be my v2, which Kevin suggested this against:
> https://lore.kernel.org/all/BN9PR11MB5276706AE4E0BBE86F0F6E158C4EA@BN9PR11MB5276.namprd11.prod.outlook.com/

Oh, I forgot that comment.

> Though I don't have a strong personal reference here, I do see this
> version slightly cleaner than doing in the callers.

Okay, you own the decision.

> Thanks
> Nicolin

Thanks,
baolu
