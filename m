Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792937980;
	b=aWbMgM0k26km/Oe97cikUTE0hdPQJCLpSNCg8Ja2yZTiPTgZrIpMXsn8PDh5zYE0DmXG
	 VDDBt4wzwtWv06jfnd30PFj6L1O1QMQ0RPSwlb442P92qaLEWWp/9N1TzVJXaUsrSYaEq
	 YqqCr4CdowE27vhpxoAzXGJoRRD93PzZAZXXkaIA3Y5vd/GCRczAkez42NhHwvBaWZKuE
	 TqgvbdDye21W8Tlx3WFVKTsZHS9xQqYlcQ8gdPztbyznsFplW0dd0i+0uXbYy7hZFiQqg
	 8FS4cJq+A46uiTND5Xed5HQLZZ6+LxD8FU+NITL78c26vVuEdN8SE5l7evsPMLe+Nug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792937980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=afEw9oZKmLEt3nCw5DyljPgEXMVJGWyX00qdwnVO3iE=;
	b=h+V2Iy6pSzr3cYYyi4wn4zU0KbGOjgEyOUN+c7wzS1NC+M/yv8NK4tn0CJAxdVh70k/t
	 nkgpmGSS7GbaUP0ENGbGwl2v0rlviQRqc70S1db9jd9jkKRKkCCrZBfuI2yWJ5B5oNBM7
	 hPurzoH2eA6tzTqpGmUZTrr0NousM0f19mo4UOrJUSR4vDXkGXnEngVupoA4Yn7gqx9vk
	 Egja0PUcw13iINF351L0Zx+qeDX+t3Vl1UTuWYSyq/RZOcArTbBsFJ0W0lKMPQDc5IpPJ
	 +OibJtGjVh4sXZlN14yet8/aso4v6LZSIyZVgm8yRhYKJMZPImd2jL+dBKw5vpCPbIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rpwWsubX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5C606A31D
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 14:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FE5C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rpwWsubX
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53394bffe0fso37455521cf.1
        for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 07:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792937979; cv=none;
        d=google.com; s=arc-20260327;
        b=XfyAF2GMyqkTd/IATtNAPtyvPp26WrzNvUubTN8c0JkDL2WvM42rFdTrvTr3jPt3UC
         hzVVuWr5MbnP1wMEv1wRCG95eynvlFg5aXU9JHM0H01N/LC84mfHA+TRVZa7SgLsIYYG
         Of5bI0QulGt2YrezkuCdrKjxtDuECf6kziHkmcEf/NRju7LIIdgAtfgJcb2h0kKrwAXW
         bE3Nfabno0NJ1E5xdm3lZ+TZ9mvkRQoFijOU7HsClPy+7zhdmaD2F/qjpCOFNYVjdWeP
         666iRMkzKRO8fmzS7G0SAE8+b50DmNJ1RU/jaTcajjTOVwvXNAij5CckTHptdpAS2GWY
         7qYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=afEw9oZKmLEt3nCw5DyljPgEXMVJGWyX00qdwnVO3iE=;
        fh=gnOaVh4cbO6OBvS8dl7dJrt5xIcgU6/NCt8ySgN5EE0=;
        b=XfqqcebX/RfrHyyVOFeFVP+W9OAXSqRxN6HQcxFVuxmNR0j3VaJQl3rgwHEOGKEoy3
         Dd1oiTehEjTlNWrpagle5T8EapZ2FwQ1rb12fWa46u7kMfkRu/CAwEElvEDr8b3hXnaw
         ZsL55QDtcAJIsCy+IoM3PPYiHkGFj1SBBOpl0DhiD9PFIrXyedtE9gYAOmwvT9goz1vC
         v+xvacwl4w0RmO8XGI0eBmzqrrTkYjVL7cXAODB3d+yEHVNXX9yPDAZmz8eGa0WpkAtD
         FfbsQwFJ3gIkcr3AivNIGXbV7YyjlPF+IJ1MTbjTFj2ouT7hg2qNPwdXGZ787rnAkP0X
         WRbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792937979; x=1793542779; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=afEw9oZKmLEt3nCw5DyljPgEXMVJGWyX00qdwnVO3iE=;
        b=rpwWsubXievo0YLcf+Vs4oyL3gUbEkkg6C/OnQYw2QmkGoL1qKvYRJywg5ShhEZKOy
         MisnyD6P198DHVaIT3z17H+r3SCXdXNuADpOlnmAUbMHDbljFh7euejz4u+2PeIJGXm2
         j12GCrd6aQ5Gpp1MoNwrET16wv3oSBf2kipGQ69776/FBPtADAwSfOQDL680cq0s43BK
         /9uMfVW0W10KZBZjigT/5ww3s+CfO4TlIAn+ErZAbnshbSf8Qc+dABZhxFWn11iXxoSZ
         AJbi8CHNQkmbDv6KDkZkYhEMKwn9xLgzYHihgLdHZ7Ez9OJZ4z12mPgj9iIJDDLr/bjK
         d4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792937979; x=1793542779;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=afEw9oZKmLEt3nCw5DyljPgEXMVJGWyX00qdwnVO3iE=;
        b=GqIu7MsyI+dzV1cB6DISU0e10W6YCnLGeAE6HSS/WzvN/HxNL7A5sYmpSJ2/DW4s8N
         sx4tRD+LDJPHzy8PBfM/GP168e8piAxOaUQV/Ex1cp+5WuW04i/WmnCgJ6oAaH1CTewl
         XTtnPWZSYc6QNnBb8wax5FO3AkfbqIY+9pcyFE+qJoCZHsm+pWQTv7rKGj5VzDXC6132
         YcurwMAqqOrrDErSOVAwhYEtxwJWDh7Y2GqBuqSRLLwxwydV4We79BJieyp1VKjr0eCL
         FqwMVSiguE1KttDBzqLQF2IdAjLISZw+CnQ2X2pYhWTR1bABEM5ay13rnX1+V5XliluX
         qRiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmqwOw7lZS6up7nfVyMcBwCOBPLHuF3L/ldproXzu9EWHWVQaEeABuXV/oDnuXAvKttSLeJjZZN4k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxZPjoOzIgLBMZj2CppSWZy4fU1UNFsMPn8l3s1gU7ah8GQzCz
	JSUAXQhE4WzMuDO7dpfK7QrnUNaff6TMp2noReXkC/fYsP9U/LTiX0yBhTdPIN5V6RGq9+j8dAZ
	1cmYw622uwstU/XhmP1q1FnJPgy0cL5s=
X-Gm-Gg: AYBFou1C39f4R4nr3+8e0ld154N3MKPZjUzc3C8dNYP9cpFlHd3w1cHn9QPA7D0Aeym
	hMLgfnMz3WqKvSiCMU8miBOHaLWmaHdR9oRXD+lt27rxU20nZBN2Hqq98869YfggeUMgUqFTC6P
	iKLlFeo/ZiFvy0xqatK18R9pywBN+b/tHFi873dpiZn8r1nIY+UlRfyRmQhVhm1LBJ8IUT6M6AD
	vvKhQtCtcLjWjc98Ju8bmp+55ci+lu84aUS+kUwajMVLbZvctDLJCu/xJ05MnefFekNXLbDuycW
	JvYOuIYa38lz/SGfPMI/D6WNAhtRHYFrQ0H1FrHYCdtLTDC5QE4EhmWXXgk3hEmd425FNMcDnSl
	P1CcG0UZjPZ4JOvL/AiC82Yxs6U1WJ3zFvWwd3t1r2iFu3dGJJlTfNNnPgNBQbM651R7BoDh5Ea
	yoDOyYkR3+lyYsyydFNARRhUGBjJgB+AIDu1GfaNdtM+47pZpZS/dcd41H+/MzrKPozlm36Wy2
X-Received: by 2002:a05:622a:44a:b0:537:548b:77ed with SMTP id
 d75a77b69052e-5383b66676amr59161561cf.30.1792937979282; Sun, 25 Oct 2026
 07:19:39 -0700 (PDT)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012-fix-aer-mask-override-v1-0-49a0d7aeaea0@google.com> <20261012-fix-aer-mask-override-v1-2-49a0d7aeaea0@google.com>
In-Reply-To: <20261012-fix-aer-mask-override-v1-2-49a0d7aeaea0@google.com>
From: Daniel Pereira <danielmaraboo@gmail.com>
Date: Sun, 25 Oct 2026 11:19:28 -0300
X-Gm-Features: AclHuK8BBiPLOfqYYGvUYpW8KblsSf6Aue6WOkhnIkNSO4BT_qaP3xQuaMz486g
Message-ID: <CAMAsx6dLGdqr+ZxG8FrwN-6r=5yVY8hk-c+7CVrAkS0zpKPmGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: PCI: Document aer_inject's
 aer_mask_override parameter
To: rathodpriyank@google.com
Cc: bhelgaas@google.com, lukas@wunner.de, 
	sathyanarayanan.kuppuswamy@linux.intel.com, ilpo.jarvinen@linux.intel.com, 
	dave.jiang@intel.com, prarit@redhat.com, ying.huang@linux.alibaba.com, 
	terry.bowman@amd.com, corbet@lwn.net, jic23@kernel.org, 
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 12, 2026, Priyank Rathod wrote:
> To exercise the handling of such errors anyway, e.g., of those that are
> masked by default like Header Log Overflow or Poisoned TLP Egress
> Blocked, load the module with::

Hi Priyank,

I read the text against patch 1/2 and the current tree, and it matches
the implementation:

- the -EINVAL refusal for masked errors is the existing check in
aer_inject() for both the Correctable and the Uncorrectable case;
- 1/2 drops the writes to the hardware Mask registers, and
aer_inj_read_config() clears the pending injected bits from the Mask
values it returns;
- the hidden bits are kept set in dword writes through
uncor_mask_hidden/cor_mask_hidden until the module is unloaded;
- PCIEAER_INJECT is a tristate, so the boot parameter form applies when
it is built in.

The new section is also a proper subsection of "Software error
injection", and the documentation builds with it without new warnings.

There is one thing I could not reconcile, in case it is useful. The
text gives Poisoned TLP Egress Blocked as an example of an error that
is masked by default. In the sample session of the cover letter,
PCI_ERR_UNCOR_MASK of the e1000e reads 02400000 before the test, which
is PCI_ERR_UNC_INTN (0x00400000) plus PCI_ERR_UNC_TLPPRE (0x02000000),
while PCI_ERR_UNC_POISON_BLK (0x04000000) is clear. The vendor register
descriptions I found also list that bit with a reset value of 0. The
Correctable side does match: 0000c000 has Corrected Internal and Header
Log Overflow set. Internal errors match too, since
pci_aer_unmask_internal_errors() is only used for CXL.

Perhaps the example could name only errors whose default is confirmed,
for instance Header Log Overflow and the Internal Errors, or cite the
spec section if it does say that Poisoned TLP Egress Blocked is masked
by default. I may well be missing something in the spec.

Thanks,
Daniel
