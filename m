Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59BD274650
	for <linux-pci@vger.kernel.org>; Wed, 14 Oct 2026 05:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791957311; cv=none; b=QEndub6FR9q6w+b+Oc212ZIYfQMblhK7RWt6otzZZKRk89NIbKL9TE3q80N+ktIWrwcP9w5mMCkAeUPRdFvu5WvJbbbVro3EOzRIESL13f5vYmdh2ddCWv6jYXYp6STNLiz73hG7UXTScJMrvdGHHphTGKCCJs1OAAsyE1yEL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791957311; c=relaxed/simple;
	bh=v/XJD0u0mRGrnYfuyBZTGqSJ1wo4h9aPIrP/FnjLRNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1n4vZJk1fcFfHRr5tYrEcmIIzG5XQJgsrxwdDnYuoFrXMyzih4/8MaeSRbtYdHVywbkesRijQHefdYTiAP4y4pGzunWmRe21lQUeCeH9npUK2ee2Fvf7xSgHMj+yuoYsw02cpBESlhtj5PjbDrtRSGqrPJf+Rh7GVza9JqXH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLtn9C0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLtn9C0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48DF1F000FF;
	Wed, 14 Oct 2026 05:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791957310;
	bh=h9yPdE1XiSsicQyy1XxmF2RPe73Zlckr4rKj09LKzjs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FLtn9C0goJ/TCVzbkwl7YikGbnMpmyCklY35gBV/qMoZneru/OVRZYmhSt+S1rhfp
	 l4OpSMNuVw8zvpM4f5sPGH9jpZ0xJMMCtGwGg+bM5z7qnuUZSIlcSYAb4ijgS0TTJ4
	 kyVj246HsVllG2aFnioxQhSjXNWlGk9Nr+7Bk98ou6RIjxl7sEBE0lUrSGaIc+1+BM
	 +nZo6QGUg5KAJggmaAyRJIJCKHzjlseLe2qvyLV156efwbCRSZ2cukU4rXX5ZovBfV
	 TXSOvonEgCJ2H1uQjbb2hvJn7n3q06oFtkGfwxA897yaPN3XsKXHQvPDExClbu0SQN
	 eI5qAZI5R6APQ==
Message-ID: <8a8fc5b8-cccf-4849-a0f4-b7878f1de511@kernel.org>
Date: Wed, 14 Oct 2026 07:55:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/sysfs: Add lockdown checks to legacy I/O and memory
 handlers
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Kees Cook <kees@kernel.org>,
 Matthew Garrett <mjg59@srcf.ucam.org>, linux-pci@vger.kernel.org
References: <20260720211541.1509744-1-kwilczynski@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <20260720211541.1509744-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 20. 07. 26, 23:15, Krzysztof Wilczyński wrote:
> Currently, the legacy I/O and memory sysfs handlers do not
> check security_locked_down(LOCKDOWN_PCI_ACCESS), leaving the
> legacy_io and legacy_mem files unprotected when the kernel is
> locked down.
> 
> Commit eb627e17727e ("PCI: Lock down BAR access when the
> kernel is locked down") added the check to pci_write_config(),
> pci_mmap_resource(), and pci_write_resource_io() to prevent
> userspace from programming DMA-capable hardware that could be
> used to modify kernel code, but did not cover the legacy
> handlers.
> 
> As a result, root can still write arbitrary I/O ports and map
> the legacy I/O and memory spaces while the kernel is locked
> down, which is the same capability the lockdown is meant to
> remove.
> 
> Thus, add the same check to pci_write_legacy_io(),
> pci_mmap_legacy_mem(), and pci_mmap_legacy_io().
> 
> These generic handlers cover both architectures that
> define HAVE_PCI_LEGACY (such as Alpha and PowerPC).
> 
> Fixes: eb627e17727e ("PCI: Lock down BAR access when the kernel is locked down")
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> ---
>   drivers/pci/pci-sysfs.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5ec0b245a69b..c24d9270a7a5 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -913,6 +913,11 @@ static ssize_t pci_write_legacy_io(struct file *filp, struct kobject *kobj,
>   				   char *buf, loff_t off, size_t count)
>   {
>   	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
> +	int ret;
> +
> +	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
> +	if (ret)
> +		return ret;
>   
>   	/* Only support 1, 2 or 4 byte accesses */
>   	if (count != 1 && count != 2 && count != 4)

This hunk was misapplied AFAICT. The commit 747b9bbbbdfd ("PCI/sysfs: 
Add lockdown checks to legacy I/O and memory handlers") applies the hunk 
to __pci_legacy_is_visible() instead.

Two effects:
1) pci_write_legacy_io() is still not covered,
2) with lockdown, __pci_legacy_is_visible() now returns EPERM which 
should trigger a WARN() in create_files() and it would create the file 
with 0664 (!), if I am looking correctly (and Claude confirms).

> @@ -937,6 +942,11 @@ static int pci_mmap_legacy_mem(struct file *filp, struct kobject *kobj,
>   			       struct vm_area_struct *vma)
>   {
>   	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
> +	int ret;
> +
> +	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
> +	if (ret)
> +		return ret;
>   
>   	return pci_mmap_legacy_page_range(bus, vma, pci_mmap_mem);
>   }
> @@ -957,6 +967,11 @@ static int pci_mmap_legacy_io(struct file *filp, struct kobject *kobj,
>   			      struct vm_area_struct *vma)
>   {
>   	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
> +	int ret;
> +
> +	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
> +	if (ret)
> +		return ret;
>   
>   	return pci_mmap_legacy_page_range(bus, vma, pci_mmap_io);
>   }

-- 
js
suse labs

