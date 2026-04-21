Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B79227FB35;
	Tue, 21 Apr 2026 04:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776747497; cv=none; b=FmSQPPTA9rI15byI7ET1BBofwUIlUJmIuXhF6VIvHQr8Ej6hOWMuEIgkLe0Zt11MV/lqqNAbjX94xi/bBuztrE96/Al7dIt5p+co2yNJ7b5Rb24x9d92RS8CqYneQ05CcRw7ZYk19HL9LvN26X648LGqD1UiQ/C02rjIt8NDb2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776747497; c=relaxed/simple;
	bh=RzdQvxvjncNtiwz+LfigQHgUZc1LPQ7GlJttmJ/tAzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cg8FzMH4FM8s1dUlUoTwGQ/D/lZBosieY9HU30Jv/Kl7Hf9MDNNkpTrbMPPFs7gxYKaI6MzOjhcb0PkJt07V0Oz5BvC2sarP0B70NUte+nkUnxwyaUVk0FbyehcvxPMIljONSY8fli5fHQAF4YnlbHf5gS4z1+vQGUY3sqDT8WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bysuRRY7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bysuRRY7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sWELmUNLrj+Rw+ev0cu4eeG06hoBoAV7zKwuPQRtKy0=; b=bysuRRY7eAxaTJ1ySj1io7PZGk
	2k6nNkf1Tp12Ti3QJ4YO+Q9p4CMiYhYTT+dA6JcCaFB412kWRo4ERmYpi2thJczSfL/1Zdq7W+97A
	YY76gpLprFUvnw3sL/jdguMoUJfYNOSKPKYXbohfIwSgfUQegumJR0H3XXN4EwEhHNG72yOa0c8Zs
	bXgyE4CeVt7JdzpNvfJGjFCjgT61oC5mYEFS9RZPVjpRtNXPfDvuIT9U5qXqP3sKUaQeHBefGXo2u
	x0RR41R+GF4PSw4lIwwHJxQiFOO7Y/VWmF8Sopw92Wez+6LgWlqd4Wci6dv7UQfhOR0SZqOrsIS20
	xigXIJHw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF3BV-000000082KY-1xqd;
	Tue, 21 Apr 2026 04:58:05 +0000
Message-ID: <49403d1f-fe82-4a39-8326-90e787e4da42@infradead.org>
Date: Mon, 20 Apr 2026 21:58:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix typos in Documentation/PCI/
To: josh ziegler <joshziegler76@gmail.com>, bhelgaas@google.com,
 corbet@lwn.net
Cc: skhan@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260421012059.251492-1-joshziegler76@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260421012059.251492-1-joshziegler76@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/20/26 6:20 PM, josh ziegler wrote:
> Fix "chose" -> "choose" in pci.rst
> Fix "result an" -> "result in an" in pciebus-howto.rst
> 
> Signed-off-by: josh ziegler <joshziegler76@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/PCI/pci.rst           | 2 +-
>  Documentation/PCI/pciebus-howto.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> index f4d2662871ab..be35e9a1ee75 100644
> --- a/Documentation/PCI/pci.rst
> +++ b/Documentation/PCI/pci.rst
> @@ -338,7 +338,7 @@ the PCI_IRQ_MSI and PCI_IRQ_MSIX flags will fail, so try to always
>  specify PCI_IRQ_INTX as well.
>  
>  Drivers that have different interrupt handlers for MSI/MSI-X and
> -legacy INTx should chose the right one based on the msi_enabled
> +legacy INTx should choose the right one based on the msi_enabled
>  and msix_enabled flags in the pci_dev structure after calling
>  pci_alloc_irq_vectors.
>  
> diff --git a/Documentation/PCI/pciebus-howto.rst b/Documentation/PCI/pciebus-howto.rst
> index 375d9ce171f6..9cc133ccdeec 100644
> --- a/Documentation/PCI/pciebus-howto.rst
> +++ b/Documentation/PCI/pciebus-howto.rst
> @@ -97,7 +97,7 @@ register its service with the PCI Express Port Bus driver (see
>  section 5.2.1 & 5.2.2). It is important that a service driver
>  initializes the pcie_port_service_driver data structure, included in
>  header file /include/linux/pcieport_if.h, before calling these APIs.
> -Failure to do so will result an identity mismatch, which prevents
> +Failure to do so will result in an identity mismatch, which prevents
>  the PCI Express Port Bus driver from loading a service driver.
>  
>  pcie_port_service_register

-- 
~Randy
