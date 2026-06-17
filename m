Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0A24E4A1;
	Wed, 17 Jun 2026 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676291; cv=none; b=nuTt6sn2/7+c3qjUXHodMsOoxjqq2SuX2s0U62bFBJjumV2JLVtJCNQWm/O6UNNXxlf+HWXELAVMEM+JRwdmkA+5Kk29btFbo+tShQXuL5vD2Xu7NXIK4xBI8Bajk/hXaDgkyZKQQ8c3Xerco4hEr69rm32YdAdda3pQi4YTXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676291; c=relaxed/simple;
	bh=zeVqG8QwKiNGoJia860pFeSyhKzx8pz7tH3khKBY/pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=byb6CxWi9UnR3WcCmZCqtT18Qu5Eatl5MXFB894xkWBWBJ0eoToQoRCm8HIcLW2cSK+0kQ8Nyryx/mC/NkkSyM27I6WRgNPsWbkmTljIJAIYh88PngyqX6G1Fu8hs9Hc9MTytoLsh2zPJAp8bFfnHRi8iNiUXQyTT9Bqz9FY1W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=CF8q1O0T; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="CF8q1O0T"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fK2zIfm/N/U6SDyLNH5Zyv67f3YJRuTdPGqC4Doyudo=;
	b=CF8q1O0TF8ZH3+TAhlsJW9QPeHnwNBbJWlA150bx7KF2oBPU+zL5BdfsHXed3PEz7t6PY9YCI
	LdbdyG0kSvtGU61uCgMCqldCqFdac9qw5NdBjZCFSBtPNKoiEWLCyy02u69XMlfy1G1M7MMZKKy
	NCMGCKzIuPb6aA+u0FIALwc=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4ggCm70VKzzmVjY;
	Wed, 17 Jun 2026 13:56:39 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id B73B840561;
	Wed, 17 Jun 2026 14:04:38 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 17 Jun 2026 14:04:38 +0800
Message-ID: <72bf8796-4ff7-4616-a5ce-492e150d5a58@huawei.com>
Date: Wed, 17 Jun 2026 14:04:37 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU to
 steering-tag mapping
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
CC: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	<helgaas@kernel.org>, <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
 <20260616144224.GB3577091@ziepe.ca> <20260616105754.784be22d@shazbot.org>
 <20260616172728.GC3577091@ziepe.ca>
 <c913116a-35b4-4934-b78b-8fa0a08a00ae@huawei.com>
 <a81c3479-1749-4b9b-b913-cfb20c621690@app.fastmail.com>
 <e2db72ab-6d51-4d19-8dba-0612207008a3@huawei.com>
 <c3d7ce59-bf5e-40fc-8f0c-6232c58c7495@app.fastmail.com>
 <c1ae7910-6028-4dae-a462-e7464a35028f@huawei.com>
 <20260617035003.GA1415869@rocinante>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260617035003.GA1415869@rocinante>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

On 6/17/2026 11:53 AM, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
>> If the community still prefers option 1 after this discussion, I will fully
>> rework the binattr implementation and send out v18 following all your review
>> feedback.
> 
> Perhaps configfs or debugfs would be a viable alternative, if this is
> something that does not have to exposed all the time?

For debugfs/configfs: These are not suitable for production stable ABI use.
DPDK/SPDK virtualization workloads rely on permanent, stable userspace
interfaces and cannot depend on optional debug-only filesystems.

Thanks

> 
> Just thinking out loud...
> 
> Thank you!
> 
> 	Krzysztof

