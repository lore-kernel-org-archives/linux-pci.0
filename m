Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F9539280C;
	Tue, 25 Aug 2026 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688154; cv=none; b=ky1F1+H6TbbaTMXdd2V5F30PVkTQoEVV712/2wXVsZZMSKwrx8HOzF9mUIEvfYYRFRixM4g+oCCDdUHMmrnWKcpmR7Z7qHqiEEFryZTMXxX5nFwBJPIjdwZTUPt5VAPZtB2V0n4TNmen0Fr+kFY/elAu1LthSJbuGtbkCi0zCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688154; c=relaxed/simple;
	bh=LZ6XHzgrZ8iTo1OdWc19rF8Zvn9Gb5uvv4WzoBdp2AM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=oMbIIt3mNK4kkTJLUweDVtreG1YARpzGejH+4AKjrv1Uwm+YUZHo9fvJDD2/G1DGiNbJSD2raWegP+YPCvanz8QPHDTMAftRb4vEbZtpzdaTmtavWnCr140ngYRGkg8b2SfdlGTWHuIuh8rp/LpMTfjvM2MDjOqG1NUan4QZwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=QFfDqAHh; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="QFfDqAHh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=TmVorUF7O4W3XTLbAIlV9pmhvw10RYCSN+rDAyZnW0c=; b=QFfDqAHhEY0I8VXghtrDFb2O/c
	BCFwlPwVL20UoXp5t2lhJoGhuGpv6M5tFzsFRPq4zkQZOjlMuNv9HxRaD6lHPN+o9LXV31uvIO8in
	9uHZmZ0iICiiWSfs304KyKHshMyiCcYV6z0H4PyJhCxHwal8Ry8YItcbhdE2dvp6JhvqmDgRdpCKV
	4eh53/cS5uYbdwFsS43EMGJ3i/UkdtlDcFBiThtvK2sMqtOa/D6DTvCPKjw8SGdOTD7xt/WbMyh4A
	hJtHVbF12eLaElK4kPovQozw0JqxfNkRb52dnIgMj/w+H+pkeHLDRIRWUcffTe1DDvI5s1UD6yHkC
	jb00G6RQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wyxLq-00000006MgN-1g9z;
	Tue, 25 Aug 2026 14:02:31 -0600
Message-ID: <154f7e6c-741a-4b31-9514-3d9066034958@deltatee.com>
Date: Tue, 25 Aug 2026 14:02:26 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Axboe
 <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-18-94426b96de73@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-18-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, kch@nvidia.com, gregkh@linuxfoundation.org, axboe@kernel.dk, alex@shazbot.org, ankita@nvidia.com, jgg@ziepe.ca, corbet@lwn.net, skhan@linuxfoundation.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, iommu@lists.linux.dev, tdave@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v4 18/18] PCI/P2PDMA: Log detailed ACS routing diagnostics
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-21 13:38, Leon Romanovsky wrote:
> +	if (ret) {
> +		pci_info(pdev,
> +			 "P2PDMA ACS debug: Egress Control Vector read at %#x failed: %#x\n",
> +			 offset, ret);

This patch seems to add a lot of printk()s with "debug" text. I'm
wondering if maybe they should all be pci_dbg() prints? People trying to
debug why they can't enable P2PDMA would want to enable them. Machines
that are just accidentally doing a P2PDMA transaction and are not
supported won't spew a lot more noise to dmesg.

In either case, I might suggest just dropping the "debug" prefix as I'm
not sure it adds extra value.

Logan


