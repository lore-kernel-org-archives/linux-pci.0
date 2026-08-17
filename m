Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D1444AB99;
	Mon, 17 Aug 2026 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982998; cv=none; b=UbnhwUHAjrbWrpT/ANWuxYAaVUkQw7nf/owt4w7IvFOurT8KkiYm1auzvfvYWj0hJLEGzPmTDXrW+xEbqT9AXTSQm6AXBq5rVmwBLeWfgxbiDhJrT1yLmXZzKYh7By096x3T87FexpoYrKNfxZOzbnpEmP3Y4T5f6BW1rAOMOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982998; c=relaxed/simple;
	bh=0JL1/m7zpkpcy4wimsu+LK6Gqv2lsBXTfkvhd5FuNfk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=BFyNWsZLcrVMV5PQubugo7vdqS53gX8yJi8h0cNQYvqRU+VetKhRliBMi++k6somnKk9KOe/otLt7wYi1zOtevv5lRwxs3VejyT8FOsJ88D45DEa4D8v4EsYHaQWJ1+ffOQVPLR40hTIqlMWi+o7A7omuL2PugCBJ8qyWdpS4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=NI9ABd8m; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="NI9ABd8m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Zsh2gTWUzN2dIhEO6xqGrM+bze4sMML+mg2E1OVs7pk=; b=NI9ABd8m7T1nCyAHna8FtBxhn2
	EH6RmBtXDiZH7t7Z7ZBbwNtvT1+3FDOwwzIycpbWNTRDGnB0qgsA9Y3Vl+4mRAI1x46Gu7tuGWujs
	QIdxouyOv0spyBru4mfe9m2wn+KPtUd/4o4ivqXFAwYS3jDiAgpuNINLxlrVoE9yIjYW8UKlg0+fX
	RTIvwrLCG5x0Fo8E4f15MMC7As1+H5rj8DxIKfkgPj9GxTFiBDmE+Ks6v+ClDQdAWof+5b7BaxG28
	YzuqQks94UO2Gkj7Ojs0ymQRradQBzrm2mNpCuSAsHU4cA2SGy5gxmT7xdfCtvnDoH4NbGpIcIZbC
	6v9/DKOA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wvzuK-0000000029y-0Y4O;
	Mon, 17 Aug 2026 10:09:52 -0600
Message-ID: <3dc699d8-a5d1-4100-b717-07fd0956e61d@deltatee.com>
Date: Mon, 17 Aug 2026 10:09:42 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, "Natu, Mahesh" <mahesh.natu@intel.com>
References: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
 <20260812-hmat-p2p-v1-4-75ac41380585@nvidia.com>
 <5e7eb09b-a47b-4cb5-8629-0ca5fa39f1f9@deltatee.com>
 <20260816123836.GC66924@unreal>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260816123836.GC66924@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, rafael@kernel.org, lenb@kernel.org, saket.dumbre@intel.com, bhelgaas@google.com, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de, mahesh.natu@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH RFC 4/7] PCI/P2PDMA: Prefer providers with better HMAT
 performance
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-16 06:38, Leon Romanovsky wrote:
>> This feels backwards to me. If ACPI is kind enough to include
>> information on P2PDMA support then I feel like we should use it
>> exclusively. Not prioritize the old janky whitelists.
> 
> Right now, there is no ACPI support, and I chose to prioritize
> existing systems that already have some form of support over an ACPI
> solution that does not yet exist.
But don't we know whether ACPI is advertising support now? Certainly if
ACPI indicates support we should use it above all other considerations
today. Otherwise fall back on the white lists. And that should always
work. Even on my old hardware because the ACPI on that machine doesn't
advertise support, so it should fall back on the whitelist. I see no
need to ever check the whitelist before checking ACPI.

Logan
