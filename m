Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F284501F35;
	Fri, 18 Sep 2026 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744632; cv=none; b=thcC5JkO4ytJsnRC4a6ylodcJmYkJ1KP49dEtx9OLDvqXUAGUWuNpKpm1jY/KFzsm/L5HHlQYzfvlOFtR8djuhVzm24sbIXSdV3LFAUExQzQrfYtlORgxZ6KAcpFOWaGwOUkHRD/PE9f/RIrfzgD+xTGs/xGdBmKaYBk5LmW/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744632; c=relaxed/simple;
	bh=1f0JvopDbb51CIBjzDRqYKy1pWQ0FOjMbMycZaPL2gI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=hcYUdXpvm/D7iB+DP332SpB2nsey9uSTN+Cb+TN/ZXvjoLokezxhOljBbwYnCRjpM6xRGDm3w7A4ZW3wRsSWlba3n5rlraf//mj95x9jVobTvEPzEBQNScZNw+KpJl/6/HBbooigKzEv3ItYkjdw9D0UviUmbc6miisRzqx/ovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=l5l3G9dI; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="l5l3G9dI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=x3RkDcHB2pR+ALJ9HVk2lhj8DLJY0bDmclYDY9x4Mug=; b=l5l3G9dIHsR6bfP6GBN0KJ4r4W
	mx0EyQ+vP0DULq39bUj3vbauKw2isGVD7IDtGH0QtMNYNljCqjABG3VfIHzT517CP5VzHmtx7crBe
	NVmSfBNBtV9wL+8OkALmba2SMcfeq5lqJoWe9wMqmIr+dwtGIz9HjKKEXC7GB+9V/QeykFUdujDOe
	UDSYtie4vT5maL9Y3YyXSAet9dl7/EGtivFhF8Yn6u4jYtidKwNkyhPbJPJops6MngmfwUPSYrZmq
	6A5XVPlq5kiprC9PSyI1/tys5i60RkMPsuuROdG+im1HDGygKxPSI5jnjnBjsjpF0imkA7N7Lr0dz
	uJojfN0w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x7aKl-0000000CpGm-3hUk;
	Fri, 18 Sep 2026 09:17:04 -0600
Message-ID: <6630e370-ba58-44b9-a1ea-4127c1e5e001@deltatee.com>
Date: Fri, 18 Sep 2026 09:17:01 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Feng Tang <feng.tang@linux.alibaba.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Stephen Bates <sbates@raithlin.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260918082412.15967-1-feng.tang@linux.alibaba.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260918082412.15967-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: feng.tang@linux.alibaba.com, bhelgaas@google.com, sbates@raithlin.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI/P2PDMA: Add Alibaba T-HEAD Yitian 710 to whitelist
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-18 02:24, Feng Tang wrote:
> Alibaba T-HEAD Yitian 710 surports PCI peer-to-peer transactions. Add it
> to the P2P whitelist.
> 
> 2 NVME cards with CMB (Command  Memory Buffer) have run p2pmem-test [1]
> fine, under same root complex and different root complexes.
> 
> [1]. https://github.com/sbates130272/p2pmem-test
> 
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Acked-by: Logan Gunthorpe <logang@deltatee.com>
