Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19574372B4C
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769628854; cv=none; b=EmqAhlNg6Fs31P3z50QefYgJEzlP6epWk6HhnmclHFYf51/Ras9+tu+z2p8sKD5tIYlsCBUnPL8iM7lSerfTRTBYGSsToieHcYlgdANNlb3IutQu+9kow8zGCUwMYEAEdq0mjJQjc9qBmh4zox1zZX+lp3nGxMplFD2Mi7gpQmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769628854; c=relaxed/simple;
	bh=JxSWirymdqmQT+YiHb86d+U8M5o7XJ/ugz12CwOe2Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BsCqZ4q1UNzdqKRgOK1xSmf+UKIgEvvpsL1uExqg2MLuYmjQOgAQesHb8wCEWPC38eqvIbCzqta2Wl5HdHik9FDiqcTPxR/x1hLiVByiSSXoNYHL7ou5PYcswO52921ymZrpsC8DIxTyznYPAuXbHWPizzvWgSjIliWvNwTvI0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from [192.168.2.104] (213.87.162.117) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 28 Jan
 2026 22:34:07 +0300
Message-ID: <3e41a321-9110-49ba-afd1-4cafd4649546@auroraos.dev>
Date: Wed, 28 Jan 2026 22:34:06 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Check parent for NULL in
 of_pci_bus_release_domain_nr()
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
References: <20260127203944.28588-1-s.shtylyov@auroraos.dev>
Content-Language: en-US
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
In-Reply-To: <20260127203944.28588-1-s.shtylyov@auroraos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

On 1/27/26 11:39 PM, Sergey Shtylyov wrote:

> of_pci_bus_find_domain_nr() allows its parent parameter to be NULL but
> of_pci_bus_release_domain_nr() (that undoes its effect) doesn't -- that
> means it's going to blow up while calling of_get_pci_domain_nr() if the
> parent parameter indeed happens to be NULL.  Add the missing NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> ---

   Forgot to add that this patch was done against the for-linus branch of
the pci.git repo...

[...]

MBR, Sergey

