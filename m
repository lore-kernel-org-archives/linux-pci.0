Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7B2175A72
	for <linux-pci@vger.kernel.org>; Fri, 17 Apr 2026 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776441101; cv=none; b=ly8sb/e9x6Hx+ESUO7tqthWNJS8oq/RO+zJsVX5Eg5FpqH0CHNieR16ZV6VTTL2q9IQ+rRt7GR3cOcj0RLzQ6j5AO3Sr9US+nxOuG2KlrRr94u9FNcmwpL9lGFo0yr0oqpgJGkPa7psq5gy5zAn9unkPT/CDEf51jW5InaAhF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776441101; c=relaxed/simple;
	bh=ixbHQbDg5pJETt37zIjFO0J4AmJGuU3o+3aRQBgcbhU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=sR4HssDEzC60m+uiGQtAMb8PsjNmQi+VUKOo/cbYPy2MTrujdKrSITR8qJ4f6hGjBSs0JA/1wmzjV5UzQwB18RKJZTO1zTq0G5Bx3Q5mJJ3Mc1/Jx3W/JgJlwQWaXy2sYD8mjCXWJWBS1j+bxRS2C8SwHPcW9B881TXLb+mOEgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=g/oYhrQA; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="g/oYhrQA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=9AvDY0ISEyLjnWkJjYEzw0I+S9rjrAOHDSJlPQul7Vc=; b=g/oYhrQAHC0VuSr5pkvzrz0Hjo
	F/M3jw2TYaEzdFYdyhlGngQRZ4iL8MUKAmbPGVZoHZeZV7CkL5paDCUMaPcSBAErt2GFaYwyI177g
	ii4lS1fHvUggZu7ZUT5VeZJQkaJsQiMj3TCPPP84lF607bu4OC2rCuRjMy4B+njmZzo4vou7LSm9Y
	zCT/aHGu628Eabx8diLdGRqKh5cQRmfhGI5KoeAsO+F/lzJ/UZBrsYOrkwswKWIUXF+6YvuwUvVWj
	TBwAm12kRq85I3VoPfmvtUHAune6aGMjuUUfteGArjjuErGCxjDVhDvy0pMBP34ul2epEzQIBDyCh
	94hRDC7Q==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([96.51.150.74] helo=[10.0.33.11])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wDkwf-0000000EGsO-0LVR;
	Fri, 17 Apr 2026 09:17:25 -0600
Message-ID: <f232e368-2546-4206-97f4-dfdfea636a05@deltatee.com>
Date: Fri, 17 Apr 2026 09:16:46 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>,
 Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
 Philipp Stanner <phasta@kernel.org>, linux-pci@vger.kernel.org
References: <1776392767-83668-1-git-send-email-shawn.lin@rock-chips.com>
 <1776392767-83668-3-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <1776392767-83668-3-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 96.51.150.74
X-SA-Exim-Rcpt-To: shawn.lin@rock-chips.com, bhelgaas@google.com, nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev, kurt.schwemmer@microsemi.com, phasta@kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 2/3] PCI: switchtec: Replace pci_alloc_irq_vectors()
 with pcim_alloc_irq_vectors()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-04-16 8:26 p.m., Shawn Lin wrote:
> Replace pci_alloc_irq_vectors() with pcim_alloc_irq_vectors() to
> explicitly request devres-managed interrupt vectors. This makes the
> driver's intention clear and avoids the ambiguous implicit management
> previously provided by pcim_enable_device().
> 
> The change prepares the driver for the eventual removal of the hybrid
> IRQ management pattern from pcim_enable_device(), ensuring consistent
> resource management through devres.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

This direction makes sense to me. I remember thinking it was odd that
pci_alloc_ir_vectors() was applicable to managed cases without the pcim
prefix. Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


