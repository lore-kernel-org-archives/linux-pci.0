Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8A30567B
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586581; cv=none; b=f4JQ6WSMUHHHtV/PB3QTltaxTJo0C/V4zQEjE5ghzDhLnTpzDQgcE+6jPa2pGE6L7heLKec1FyJCfvmLsUdj+G1ZWzfUNNthKZO7iIdfubKPtMLGPlEDh4UgV0uVWR+kPV/Ab9/1lA2v2WL4IEF8chlcnQ4E5/OcVlPqA8qrmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586581; c=relaxed/simple;
	bh=SuHJHgsbXbehBdZAhEmJOZuACfGZSY3eTwmxF9UuawM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=Mphlh7/oGNdRbC90pqnQeE/FOrrbefmjmyQhmZyCFTzI1P1d6Jr6H7dgRRylmBJjrCByVr9rXk7r3dXEpS6RTOE5y8aIcLGEgyYEONGYDqfwUXUhXSafYayW3PMaArUnRC4elvMymDMp0zFs7l7QL2u476JR29V2sf1OmYlBfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=r42WDk12; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="r42WDk12"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=a8CR1O80KuUaJiDxCrOz94MkvGtJYa97MbOwSgOgYRI=; b=r42WDk12wwA2lAHjllUKDLKVj+
	lBm+QIrOhdznLwY2k8OGrjQcP76q1c08MyEXUSVfKYOdkob82JaC9mbFVmIQicosHwwRqtzZwg9dc
	ArsqwHALTqvyed9dCgBnlHwYo2VZiZGB6YMGKPavEs5MJHKheeZv51HmTVW/KMGQABU5SIYS3H5K5
	L+ukmuo5leEht7Q8KQgJwk0hP/nWWK09CYzYx7WRYubb43HcOQ5sNZGDO9JXajqHBIQZWy5RVaUas
	LEIt1z62XbUBKIKdxY9CexR3SUmOF6NWd0mIXaWaEc4uuU2jb+3HBkif3oc4TTdPlZxOyl3UpmQdc
	YmTFodfA==;
Received: from [104.157.31.28] (helo=[192.168.1.251])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wV9uG-00000002M0s-3Gx9;
	Thu, 04 Jun 2026 09:22:53 -0600
Message-ID: <a830ffd4-14a1-4739-b862-25e664394a96@deltatee.com>
Date: Thu, 4 Jun 2026 09:21:50 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: linux-pci@vger.kernel.org, qat-linux@intel.com,
 Damir Chanyshev <conflict342@gmail.com>, Simon Richter <sjr@debian.org>,
 Tomasz Ossowski <tomasz.ossowski@intel.com>
References: <4ea5265495876beb5fb5e6d479b2782f882bcbb3.1780570508.git.lukas@wunner.de>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <4ea5265495876beb5fb5e6d479b2782f882bcbb3.1780570508.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: lukas@wunner.de, helgaas@kernel.org, giovanni.cabiddu@intel.com, vinicius.gomes@intel.com, linux-pci@vger.kernel.org, qat-linux@intel.com, conflict342@gmail.com, sjr@debian.org, tomasz.ossowski@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI/P2PDMA: Add Intel QAT, DSA, IAA devices to whitelist
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-06-04 5:50 a.m., Lukas Wunner wrote:
> The first device on a PCI root bus determines whether the host bridge is
> whitelisted for P2PDMA.  All Intel Xeon chips since Ice Lake (ICX, 2021)
> expose a device with ID 0x09a2 as first device.  It is loosely associated
> with the IOMMU.  All these Xeon chips support P2PDMA, so since the
> addition of the device with commit feaea1fe8b36 ("PCI/P2PDMA: Add Intel
> 3rd Gen Intel Xeon Scalable Processors to whitelist"), P2PDMA has been
> allowed on all new Xeons without the need to amend the whitelist:
> 
> Xeons with Performance Cores:
>   Sapphire Rapids (SPR, 2023)
>   Emerald Rapids (EMR, 2023)
>   Granite Rapids (GNR, 2024)
>   Diamond Rapids (DMR, 2026)
> 
> Xeons with Efficiency Cores:
>   Sierra Forest (SRF, 2024)
>   Clearwater Forest (CWF, 2026)
> 
> However these Xeons also expose accelerators as first device on a root bus
> of its own:
> 
>   QuickAssist Technology (QAT, crypto & compression accelerator)
>   Data Streaming Accelerator (DSA, dma engine)
>   In-Memory Analytics Accelerator (IAA, dma engine)
> 
> Whitelist them for P2PDMA as well.  Move their Device ID macros from the
> accelerator drivers to <linux/pci_ids.h> for reuse by P2PDMA code.

I'm sorry, I don't fully understand this. Are QAT devices functioning as
root ports? Are there devices in the tree that are doing P2P
transactions through theme? That surprises me.

Logan
