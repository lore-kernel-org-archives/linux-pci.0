Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF039E184;
	Mon,  9 Mar 2026 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057013; cv=none; b=YV/7PgmiZeUFCA2IUvZ8SY1nSfuN67fEiBAEbuAemo2BGrVTJxisq5OOaSomkBJvOpcod5/rLvEjoL1pqgtB+hYcIO+tgzJbYqLLjQe3gPDBEgGOGclnLO4isTM25r6W0NNXrthpRzFZHJo8f1QSJ0f3Q2F9eMMpNpdDkauuzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057013; c=relaxed/simple;
	bh=YDUAj5DnhBo8lDRaOq0/tLtvkwQZJRcm8wLa3h04nVk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPv7s7bnE8n1+SYqq5yQYB/VPixkKY0F019FZ5VGsHh/nlwGnySbwMcAnv9m0ayQIhLPgRF4bRy5bzZvuU/InLHTCKhJqvtUWM5UIzkoqDsXmRlLzfnLoH5iKStjz6BLNUzDbh8oT9ifzIGPYM0azpiQXn5qdiii6Y5WTwHNXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fTwKL3ygXzJ46C2;
	Mon,  9 Mar 2026 19:49:26 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 69ABF40584;
	Mon,  9 Mar 2026 19:50:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 11:50:08 +0000
Date: Mon, 9 Mar 2026 11:50:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<bhelgaas@google.com>, <joro@8bytes.org>, <praan@google.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <dan.j.williams@intel.com>, <vsethi@nvidia.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] PCI: Allow ATS to be always on for pre-CXL
 devices
Message-ID: <20260309115007.00005442@huawei.com>
In-Reply-To: <c715b10b49d50eea5429454108d4221c1a78efaf.1772833963.git.nicolinc@nvidia.com>
References: <cover.1772833963.git.nicolinc@nvidia.com>
	<c715b10b49d50eea5429454108d4221c1a78efaf.1772833963.git.nicolinc@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 6 Mar 2026 15:41:16 -0800
Nicolin Chen <nicolinc@nvidia.com> wrote:

> Some NVIDIA GPU/NIC devices, although don't implement the CXL config space,
> they have many CXL-like properties. Call this kind "pre-CXL".
> 
> Similar to CXL.cache capaiblity, these pre-CXL devices also require the ATS
> function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always on"
> v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases.
> 
> Introduce pci_dev_specific_ats_always_on() quirk function to scan a list of
> IDs for these device. Then, include it pci_ats_always_on().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Seems like a reasonably tidy quirk.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
