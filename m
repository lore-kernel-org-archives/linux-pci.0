Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364B2F9984
	for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2026 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771485746; cv=none; b=jZ+c4YUP4GrqEqtezEcsDvJ9++zBEEQbx9bREiS9WQK9mVIRwJDOLXaD3H6vurVie6K5eba0ho5CNCYO4vmOkl9fcYKGODVp4ynNeYU/XCJe2SrU0Dpnc1nivJ0uapPt/2qB1/nMTZir/0ewIdymy8T2mwR3ds+PhG9Swf0Tigg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771485746; c=relaxed/simple;
	bh=UQozAXeN8Qz1bWIbUDm6pOxjX1uiJvZD+/n4YlOy6nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpwD16EqVHGyXdNf0sUvGI8pLV8ik/3fY7hMQ3Ojjgx53w86iM02MLTRLU4VT3VjE4cQWpJe5YfjlT1nmV5U0TSpEr1Jm05wrkAp9PSiOFnExKJYHTDogNinqpyLwqsSzQ6W8VI90KTjq+i9EjipNCBKtruTydp9TCrwL7nO4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.107] (unknown [123.118.222.47])
	by APP-01 (Coremail) with SMTP id qwCowACXPWkhupZpoFpACA--.15858S2;
	Thu, 19 Feb 2026 15:22:10 +0800 (CST)
Message-ID: <6f02c046-1ff6-4086-8fd0-a276eabece10@iscas.ac.cn>
Date: Thu, 19 Feb 2026 15:22:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/pci: Initialize msi_addr_mask for OF-created PCI
 devices
To: Nilay Shroff <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Cc: tglx@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, gjoyce@ibm.com
References: <20260217174537.1154686-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260217174537.1154686-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXPWkhupZpoFpACA--.15858S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4DCF4xWryUWFy5ZrW3trb_yoW8uFykp3
	97W3Z8trW8t34xCF47Cw18ZF1Ygws3Z347Jw45t397C3WS9rnFyr1fJ34UAa47Xr4vkw10
	vw4j9w1vqFyDCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUqiFxDUUUU
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 2/18/26 01:45, Nilay Shroff wrote:

> Recent changes [1] replaced the use of no_64bit_msi with msi_addr_mask.
> As a result, msi_addr_mask is now expected to be initialized to
> DMA_BIT_MASK(64) when a pci_dev is set up. However, this initialization
> was missed on powerpc due to differences in the device initialization
> path compared to other architectures. Due to this, now pci device probe
> method fails on powerpc system.
>
> On powerpc systems, struct pci_dev instances are created from device
> tree nodes via of_create_pci_dev(). Because msi_addr_mask was not
> initialized there, it remained zero. Later, during MSI setup,
> msi_verify_entries() validates the programmed MSI address against
> pdev->msi_addr_mask. Since the mask was not set correctly, the
> validation fails, causing PCI driver probe failures for devices on
> powerpc systems.

Thanks for catching this. I had naively assumed that pci_setup_device()
was the right place for adding this initialization, and didn't think of
other possibilities.

I grep'd for pci_alloc_dev() and found these uses:

  * of_create_pci_dev() in arch/powerpc/kernel/pci_of_scan.c (this patch)
  * of_create_pci_dev() in arch/sparc/kernel/pci.c (*same missed init*)
  * drivers/char/agp/{alpha,parisc}-agp.c (fake pci_dev, should be fine)
  * drivers/scsi/megaraid.c (copying from existing pci_dev, should be fine)

So, while we're at it, can we fix the SPARC one as well in v2? The code
seems similar to what we do for powerpc.

> Initialize pdev->msi_addr_mask to DMA_BIT_MASK(64) in
> of_create_pci_dev() so that MSI address validation succeeds and device
> probe works as expected.
>
> [1] https://lore.kernel.org/all/20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn/

Nit: Link seems redundant given the Fixes tag below.

Thanks again,
Vivian "dramforever" Wang

> Fixes: 386ced19e9a3 ("PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address mask")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  arch/powerpc/kernel/pci_of_scan.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> [...]

