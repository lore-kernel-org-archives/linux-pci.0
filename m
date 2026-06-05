Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E13A9DB9
	for <linux-pci@vger.kernel.org>; Fri,  5 Jun 2026 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640811; cv=none; b=dwJa++FseZwf+AQIvYDk2outgP4wpaW/AzyOrCbiAZ33P9IO0Wku8Jjdm8+8WtgyZ3ZT8xv5ROcrPH8Od5UIqytpGbieLCfdm5ycNGkmPAGrdYjJ+6w8ftsEQ8EzgVdPn61wZ5MZHaMIaYG7HR5xlwokEMIsaA20WttMBnzgssI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640811; c=relaxed/simple;
	bh=O96Kd5nCMNC5vhy8bUzXigz/IEAI2pnsxYggVkV7Sfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fGWvVzZ9MDgVMrx3ZHkCdnTh8OliD5D8VvYDBowNtY/ckjrFfrzsDUeo169Isk/G/x0mPJSMGIUHU9tXU3uhbUYZGRYHGcugn2hFhqQlJ2hhmXaf3WIkhlyVLDH51YVDDF9WPHXyPttSFRc7UbSDGjy7llGm3Nfb12NWhlhKv0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usIHUtce; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usIHUtce"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8424aac207eso1326831b3a.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 23:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780640809; x=1781245609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=khdJqNPKXPEiqKWLMRj6izd0dTEEX7BxQCSIjhtaalo=;
        b=usIHUtcevkqWp6FR2gipqBiZN56/sjM7fgpd911vnZyDcUBD4YKXJAgnUPfJlhhiNV
         VYNTJbaHIhXnWfMK721a3Q506UqT+dDGMhM/g4Q7nGAKz/2RP/z6QUfRVsHgF6Se9vp1
         cTcpK/hhr9jSmXJL2jKkmKDFHMuj+5qGrywsTsqLi2ZN8MjSWJayW+UDjIRV05Qs+CBf
         ycE9yHNeVEKrgQraEPxT14JJXCkWpDUgkaKaBfSzP9N2ixAATnLFnDVoHLPvDFgpz3wA
         gBu2Os9HfVRgJ2rm0bQzznA7pkaHkwHydYFQRTmRiQO8rGpgAxnfGj2RM/bLekcGgPlR
         inUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780640809; x=1781245609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khdJqNPKXPEiqKWLMRj6izd0dTEEX7BxQCSIjhtaalo=;
        b=DdxnKTSTI1hJTc/s2UJMkDl1Sb2vZCuwMuTR8/nHM4QR1ohBZQxwzIvDD0yXFowOrC
         E8AfihcrPraihu6mw7TMyHsm2MfDWfU9W5fnjf5zisQHfk/3ZA1xVspBddfzq7qaIKHK
         zqoUv6TlfvgEZ0x+rXIZKOqAKLM7R08vKYW7pmpeAdcinGrQ38vINahxkYvPFvFvGolk
         XAyjqgEA6tuPnH1boiIUztYVUZ7nzUPqpWbZ9AtlTnd7VQlz1A+y82NivGCZg/zI4+zn
         m7cyBkdkIdp3Dc7hCpM8oI6jReDP3UBTdMgXU5YW7CUEhTlbvWE3IKkQ13/2EOKCIbky
         JBmA==
X-Gm-Message-State: AOJu0YxSncyrTEeQ67PyOYMT2qEhFzj3SyU54LFFW7LcZR29N6HOazdh
	xjVDgQGzf1E9HkZySoD76FzYCezJCIVuaNON64N+1Pno5K754CAg0QoFtNNzGG4li5+yIglr1jY
	gQw==
X-Received: from pgbda1.prod.google.com ([2002:a05:6a02:2381:b0:c73:bc95:cca8])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a94:b0:3aa:f9cb:d438
 with SMTP id adf61e73a8af0-3b4ccdc2d18mr3060292637.21.1780640808801; Thu, 04
 Jun 2026 23:26:48 -0700 (PDT)
Date: Fri,  5 Jun 2026 06:26:47 +0000
In-Reply-To: <CALzav=fgi_ezr7JV3to=RM-RC7sF_XsEcash_+vp65J-jXnkWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CALzav=fgi_ezr7JV3to=RM-RC7sF_XsEcash_+vp65J-jXnkWQ@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605062647.4025725-1-praan@google.com>
Subject: Re: [PATCH v6 02/12] PCI: liveupdate: Track outgoing preserved PCI devices
From: Pranjal Shrivastava <praan@google.com>
To: dmatlack@google.com
Cc: linux-pci@vger.kernel.org, sashiko-reviews@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, May 22, 2026 at 2:28 PM David Matlack <dmatlack@google.com> wrote:
>
> Gemini found 3 files where pci_dev_put() is called under a spinlock:
>
>  - drivers/net/ethernet/microsoft/mana/gdma_main.c (mana_driver_exit())
>  - arch/x86/pci/i386.c (pcibios_fw_addr_list_del())
>  - arch/powerpc/platforms/pasemi/dma_lib.c (pasemi_dma_init())
>
> OTOH, pci_release_dev() does not seem atomic-safe. On s390, it can
> take the zpci_add_remove_lock mutex via pcibios_release_device(). And
> on all architectures it can call kernfs_remove() via pci_bus_put(),
> which takes multiple semaphores.

AFAICT, Sashiko seems to be wrong here.. pci_dev_put calls put_device()
The put_device() doc clearly mentions might_sleep [1] to warns that 
dropping the final reference may trigger a sleepable cleanup.

Any existing code calling put_device in atomic context is in violation.
put_device / release are *expected* to sleep.

This patch doesn't introduce any sleep-in-atomic issues.

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1-rc6/source/drivers/base/core.c#L3812
