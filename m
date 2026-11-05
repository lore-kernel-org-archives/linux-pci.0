Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=50.112.246.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889384;
	b=WvqZk0xDILZx3iN0ya5KHw/nP0mt1a7UsChGZ1hczjK3gSbLpWIVYc2pDkYBjYFNIu6U
	 oRy2XBmaNZMuIu/pgRfb0hS1rSBAqfIWGZLzjT5oOzx8TzX7B9XJLj0WfA4buAqAte8qB
	 wv9WZnM6dBC8Aq53dNztHT4jnHy3zVQnZ0/O/6xt6U0psi1eC913ksiO0aagzY4S9wJtz
	 mpWXLZRERIHwd/JUlmY9JEAr+PY4eARw5uknRalZgJ136o2FKtbqlUlrI4bLqBkIs+dks
	 pM+0xm2sGSpf1mQOX+LPlWV/6pmK13Huz0hfOj9Q4Y9UeGzXhRRx9VA5Vv1Fh+83wQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889384;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=RitqX72VBywyZ/8gIe4GxDQsV9RWlpPjVkp4R7+U95o=;
	b=0TlkTBKJCu9rF7zs60hQSVXbJIkpRk2AIku3oxAdUQLxcpWAcZnOh9wqJkT8okmnBSSt
	 Rxnnp2z94tDoLOmVxH9Ng3xLBzZKzZr2q24Y1SMXzF2pDcfhmifQES5EW29qzbgaj9k+t
	 JbFDNbKjwhcZPerwdYq8YvHsFVQEsp5++2pidMmdz6LekudJl7sUmtHkCQanI78APlsLU
	 eHl6cOmquERkwNZZ+8WkQu634oi87XiZTDJ0rba2yMtF2xwoAUGe35S8TSBd+9CGtMlCO
	 84y88Qecly39/5GrN6+M8oewSvSrbCYEXi5p0f/FNN4ttT340gmoYRKnwCMjYoLDPfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=U5r8Inmr;
	arc=none smtp.remote-ip=50.112.246.219
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5DD606A328;
	Thu,  5 Nov 2026 14:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E5DD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=U5r8Inmr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1793889384; x=1825425384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RitqX72VBywyZ/8gIe4GxDQsV9RWlpPjVkp4R7+U95o=;
  b=U5r8InmrqfFszKgPS3ipFD/vHDLI/XAWFn5FxBMU5ueUyKa3PieHXqUJ
   5UnRkxC3v4d2dKiRloChx0i/7w92FcskqwBHXgIjKC+1uK8+d0xLEj+Rd
   9kNLJrtAIQyitkOuTb37BGG34LNCAw/Bv7WWwa9+KJCO+L6YtK7ib6C7v
   KIAGFLhkc/uAHRsmPZaQukBVezr8aROsDea2DNFMOZJ6jhtktu8c86duN
   0m8eG21l5yyCWM0aWpMhSzNBgEQZmjfL2rW7aIowmENeMMbE08sNei8sK
   66Y0Kj4paOOE178vGu0YZhPM1t0h7QN78l1LnhP+tyvsl+Wvj/l+0Nuiq
   Q==;
X-CSE-ConnectionGUID: oYzvpLw9QEmc4MZKTbbi6Q==
X-CSE-MsgGUID: w/FZ20HwTzKvNmnmiaxW/g==
X-IronPort-AV: E=Sophos;i="6.27,197,1787011200"; 
   d="scan'208";a="32977905"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 14:36:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:30175]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.80:2525] with esmtp (Farcaster)
 id 698d68bb-711d-4975-bbc1-15ae946784b4; Thu, 5 Nov 2026 14:36:21 +0000 (UTC)
X-Farcaster-Flow-ID: 698d68bb-711d-4975-bbc1-15ae946784b4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 5 Nov 2026 14:36:20 +0000
Received: from dev-dsk-machaujo-1c-d6b511e2.eu-west-1.amazon.com
 (10.253.100.8) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Thu, 5 Nov 2026
 14:36:17 +0000
From: Joshua Machauer <machaujo@amazon.de>
To: Srirangan Madhavan <smadhavan@nvidia.com>
CC: Alison Schofield <alison.schofield@intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Li Ming <ming.li@zohomail.com>, "Alex
 Williamson" <alex.williamson@redhat.com>, <vsethi@nvidia.com>,
	<alwilliamson@nvidia.com>, Sai Yashwanth Reddy Kancherla
	<skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, Richard Cheng
	<icheng@nvidia.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v16 14/18] PCI/CXL: Reject reset with unsafe function scope
Date: Thu, 5 Nov 2026 14:36:10 +0000
Message-ID: <20261105143611.31563-1-machaujo@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029145703.2185231-15-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com> <20261029145703.2185231-15-smadhavan@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, Oct 29, 2026 at 02:56:59PM +0000, Srirangan Madhavan wrote:
> @@ -515,6 +515,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>  		return -ENOTTY;
>
> +	if (pdev->is_virtfn || pdev->multifunction || pci_num_vf(pdev))
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;

[...]

> @@ -5026,6 +5026,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (!dvsec)
>  		return -ENOTTY;
>
> +	if (dev->is_virtfn || dev->multifunction || pci_num_vf(dev))
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;

Could both checks go at the top of their functions, before the DVSEC
lookups? None of the three conditions depends on what the lookups
find.

pci_init_reset_methods() probes every reset method for every device
that is added, and enabling SR-IOV adds the VFs one after another.
Where the checks are now, each VF probe walks the extended
capabilities twice before it returns -ENOTTY: cxl_reset walks the
VF's own list for the CXL Device DVSEC, and cxl_bus walks the
upstream bridge's list for the CXL Port DVSEC. All VFs of a PF share
that bridge, so its walk repeats once per VF with the same result.

With the checks first, a VF returns -ENOTTY without a config read,
and the result for every device stays the same.

Thanks,
Joshua
