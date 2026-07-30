Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD42368950
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 08:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399502; cv=pass; b=knseHSy5yRv7BN0+c8SUWQvUrCn1XILbaWxLc+M/RJJAlx6XPWcy9Z2FbgFMpfqXZnS+kxDmWjuzUFe41b8UoDqR+x1JJCjUB83wIJhHzXxnHUG8FmZckuI1JozVgBzuLPWehcRVrKPDBs0YN3OvkPJbHrwCMJhg4U8iJehZUlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399502; c=relaxed/simple;
	bh=f7QRhfPhfuanj85ZYxwPDOHyrGPoaNqQTqn4TimE2bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMmTtYv8SkrzcwKCIW8ewlwOm+y+/Xf7iD9UhxDg/uSFfG5KY4QbbYzWfRoZmG0Pg/pCyFYrR3Xh5qjpEIlkrl5v0dcqGYN8fuhYTedYGA6VMIa38Z30lFijpyc8roxWpQmH6r7mtGEicVxmVdTXKnu3ThfZqZSntdiFAPuiPHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nearthlab.com; spf=none smtp.mailfrom=nearthlab.com; dkim=pass (1024-bit key) header.d=nearthlab.com header.i=@nearthlab.com header.b=iJWVo4C2; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nearthlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nearthlab.com header.i=@nearthlab.com header.b="iJWVo4C2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf50c6f235so20677985ad.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 01:18:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785399497; cv=none;
        d=google.com; s=arc-20260327;
        b=ovlt8WDhCldeqcevnzPBDlm8FCiSpKbQZCbpeYu/T3VlyCMC5U5VyivsppL+hogLFo
         3gw/CnkgXMTzPV2Cvxh6dr2VUeqFOkD2RaBMVRPA03kWtimKU/OmFjz5zPdZ7n49NcSx
         QVJ4SBOsE+MPwp1NpJUlm+fKaB2ef4rAGS3dsZe8hEmDa+YETy6LU/cjY5Wkq9L9z2qa
         nE7X8/UuEOKPvSaBG1n7OvJiHCyadY/lq8LktDzXeCO5w+bWNuPj+WHMZsi+V0J/pwKQ
         TBGZpIWBmubrlOyJyzgenpop3/JPYkh2JXDSSI3Pr7rW4BUESCNO85/lQ13dmklHR/+V
         Fcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=is1ZQk2S8/kibmO+4EhDqlrn7RhSaBF98AwRFvKrWvM=;
        fh=2E8G5L5HRIhYv0SLHRh0bmuG4bK/RxhrEd6+zC1U6gY=;
        b=ZfmqoHm4vuFBtQT9RdIC/OlsqBlI6uDhcPvIyuWaPFPxXRzvOXCQJ0zH67IsB8lzBS
         QsbWWrx7NnGhZ0KriBobckQKNaVnSN5zjC6ebLogwFYCoUxKa8GHq087MvgSjTLWxKWS
         7oJMUN2occiYJ35fvIkBzXWDhkDwE2TJ1ek4kaUQ4qd9yjuoc1tX0cPNec0ShyFMoHO4
         JvIyDwGHo4QG9fTFnyIfAuMq8IgIqHs4lh7t2UhG2nCtz8MXfm+3gxAXcL65HyZtN+I1
         k/YYEF98D37wxxa7FfVc6FE5EKiDEhNwD9no2CU//7m8mLCOuojkfbMNts3hwIPf9PS+
         1w/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nearthlab.com; s=google; t=1785399497; x=1786004297; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=is1ZQk2S8/kibmO+4EhDqlrn7RhSaBF98AwRFvKrWvM=;
        b=iJWVo4C2sNR6K/F9aqYYjsgx6iVIWc8Ljcw9tzxB6qbWCquYC15kuOiPSAukuakBl1
         ppkFzjjIwbZ1SFcGpNjjxrmozxB9LVQHcS1Vz3wK7YUYdZs+GGSzoCQDjv7fLNWCAWB1
         vtz+Y0Xi84pZD2YQIo5J/El74BjYWdXW6H0tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399497; x=1786004297;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=is1ZQk2S8/kibmO+4EhDqlrn7RhSaBF98AwRFvKrWvM=;
        b=aW+xzTQoUqMC1HjG+RRyr31vyAXFoAFqsUDZ7pKJvoYd42ZjrCZHJcJ2XtvpQjtyWe
         y4rV93CX5lvl2hQThiyYQBDCivcAjuLwMVstN25BNavVwcmosCo/E0FOEi68BuzgVNdU
         zNu6TnNV8g4j+k5tXa4Hv4yPE2nA+fEjTQcLB8ApZweuYRMXnt9f4OgnB/jfq+ledG09
         Xh/v55wIHy86p87P0jjH9yMm1yljheH+Y7Pvu0QvYibonP/mLUYwCH6o54QZC574m5t3
         85AFsGk8Svw/RIEWeHsGiUOdp7O6tw5p9dMCVu+Vl/ncGAkr/RB6AIMhy1bL+N+l6NJe
         aPrA==
X-Gm-Message-State: AOJu0YxBw0a812o+ziLzQ7l2n8oHSAM31sJa4tHVADHZKFw56Oyd24P9
	jxr4tsiKNNaGnH2BPjgAesrJdbTByBCXgk+Ie5drawrcoxt4ufXPiiz29VMWDUutaJj86nu2aEZ
	7ULZdcG8DZ/pYbbkJgIWZd7TSj8/k5DzKJD8c1T1hP3Yqz7uRGExq
X-Gm-Gg: AR+sD11YZdEbtPnmmInflW3s41swyLJJ2cH3hJyT0ASCCvGxVSsASMuWHTWGp46gogr
	dHiUwZh7ORw4hKhfmJhQfu0OKGexsLleuKeLAbl32MGt18eFrwaaFyk4wPETqI8aQ1GHX0sEiMA
	RsWub7B30bB+vRGCSuYmy9lgco9gpyTH5NHhDjKNuSUUaErvay31GK2h5oYkwjCEDHdr/U8qrFr
	/+FYCtKTaM5PahIA1s5oz1RDeUzHnI2wt1Qa1w1D4Kf1kLMfSTlgIeH8QQzZRdrSh832hM29wpa
	tp+ODarCaPpDlEy0IzcX87TJ6tIQ+RfufR2G9B27/bggrg==
X-Received: by 2002:a17:902:cf0e:b0:2c9:fb11:1bf4 with SMTP id
 d9443c01a7336-2d035b89e1emr17737995ad.7.1785399497022; Thu, 30 Jul 2026
 01:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730072215.2090974-1-sangwoo.han@nearthlab.com> <20260730074626.BED8B1F000E9@smtp.kernel.org>
In-Reply-To: <20260730074626.BED8B1F000E9@smtp.kernel.org>
From: =?UTF-8?B?SGFuIC8g7ZWc7IOB7JqwU2FuZ3dvbw==?= <sangwoo.han@nearthlab.com>
Date: Thu, 30 Jul 2026 17:18:06 +0900
X-Gm-Features: AUfX_mxYgeKuB9t87txmyP8OggIl-yRobUNT0qaQCA1nud0Zwhpc-Uj6JPiYNXM
Message-ID: <CAFg7d9b4yLH+s1KZC3q0zOxEvMpAQgMxoNEFKtgKmBzQXFqfjg@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Because bitmap_set only reserves exactly nr_irqs bits, the remaining bits in
> the device's hardware window remain marked as free in the allocator. If
> another device is subsequently assigned one of these trailing vectors, can
> the first device's interrupts be incorrectly routed to the second device?

No. The PCI/MSI core masks every vector the endpoint is capable of and
then unmasks only the ones that were handed out, so the endpoint cannot
signal the trailing vectors of its window.

msi_capability_init() masks the full capable range:

  /* drivers/pci/msi/msi.c */
  /* All MSIs are unmasked by default; mask them all */
  entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
  pci_msi_mask(entry, msi_multi_mask(entry));

And each allocated vector is unmasked individually:

  /* drivers/pci/msi/irqdomain.c */
  pci_msi_unmask(desc, BIT(data->irq - desc->irq));

This is observable in config space on the endpoint I tested. With 5
vectors handed out at hwirq 0x8 and Multiple Message Enable programmed to
8, the Mask Bits register reads 0x0000ffe0: bits 0-4 (the vectors in use)
open, bits 5-15 masked. Messages 5-7, which would land on hwirq 0xd-0xf,
are blocked at the device.

Reserving the full power-of-two block does not provide isolation either;
it just never releases it. The irqdomain core calls ops->free() once per
vector with nr_irqs == 1, so bitmap_release_region(order_base_2(1))
clears a single bit per call, and roundup_pow_of_two(nr_irqs) - nr_irqs
bits stay set for the lifetime of the controller. That is the leak this
patch fixes.

irqchip/gic-v2m.c and irqchip/irq-alpine-msi.c already reserve exactly
nr_irqs this way. For instance, gic-v2m moved to
bitmap_find_next_zero_area_off() + bitmap_set(nr_irqs) in commit
2ef3886ce626 ("irqchip/gic-v2m: Handle Multiple MSI base IRQ Alignment").

Thanks,
Sangwoo
