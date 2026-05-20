Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99433A9FE
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779317152; cv=none; b=AGXlzO1UKiYrEI8EYIXokhvx1d55l+mwCbpjV+7Viq4AqPiQlc8TDL/W95Nyr0Xv0eCDuCLrTN9DF6Tuey8AXCXNaz0aE3vw5ogQrddu73J1kR5TN6Au0hnIvNRzOI+6NZecUGqfQWQxhWV+XoHiXdNXi8lOGBNj8gU3/Jwijs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779317152; c=relaxed/simple;
	bh=NL1DLuFEKLwlX611De6uZFVhrhG8WqHFPsk3nbBe+3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References; b=hP/DZCseVvWHd6co1FDiJX+KNK+AduAeO2GEZcv4rsb8BaNcTYsbN1l0j7EEMGR1/sADIiJkPDw+2ZfKI3fqHjWgCcWzZywY62nD81o/tEWwMM6na4FatClkdM3AXnWrrrEywZCWWYp8BquMBfI4g6tObV6LxQXVgLmycGxNR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=YRWbe3Pq; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YRWbe3Pq"
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-50faeb8317bso49612801cf.2
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 15:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779317150; x=1779921950;
        h=content-transfer-encoding:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ikrSU9XktaZzVYO+3LJLhuj5lBGwDhqjYZ9LS64/4I=;
        b=I+cfOSL8WZyV5JHKIzMFgNwUS3gMXWy+JKSanmNfQYrguQqY/60ng48kQeplVpXCPS
         0162rJ8OXltkzZTIknXZs+mKt5N5oEfOde/LnG836sxxH6KIEXeQLZ4LuO+IBjEP7B3C
         IZr4/CNPDP/OtTZU6QLGNvyeRTqcxx50/phrqUPawjXxrLlRNFQrXY9JNf7K/m3EEg24
         89FHEAhEYtClRL2gQY70j4Y+v+qVBW7SvXd90vpem7LMqNSFbzr/jmvZ33zRu0l3jiod
         DUUzaaKd2PwV5hOR2BR7Vd+eA6bB1dBiK4L5+KmdnpCpb8dP+lCgC26gglrQxcT7lPE5
         NbQA==
X-Forwarded-Encrypted: i=1; AFNElJ82ElFiiZTHnzX3vaL4geT9ggjPFRiOI5wMGTQvXwGYWNge+EICKQ7hDDOcxCGhcj4XD4MWSfniSY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi4d6EpB/WsD8tkpEk5dQRMmvp7dgK62rVeAoHAuGeBYkcpPOH
	WierUYGM675P0MUtwyOJDhnQlvLataVhQftDsPvg+yb6L3nybHd+seA4vq0HzCcLeaqbejpbiW1
	g4PKK/x5Jnfp6kcowyXFi/TWIbI7FYajr1Q==
X-Gm-Gg: Acq92OE1ArGn7isq9CXBddNnNIdFOyHTl+7a5cprJwO6IHDtd2QBbiP/5/9F0Ue7L7N
	Eh4bLvs/dQheIqbvwYawlTNcfk3qcIQ5XtZBUAeMfS62LbbQ7yxa/TLcKP7ucpiFX3E7kT0zrk/
	GYIllz7SSYNOnxkQRB0GK/120USuycpmcMJnz1d/B9S3YzvEqiO5YYImtyvX2DZGLES7xs/Pr1+
	DHnroiowfafVe4BMf99RSp3g5tK+nLxqIsk69XVE7MJ3zl4KQVOyKCeMzOHhlg+gk7vY4joXJnF
	923DHOLUvmS93tkrDF0vNeuQ1YjRYy4r0L7LHJBaKSLQDoRMACZxn2Gh0q4AsA4XGpBk6KR0mmW
	v9EdlX9ze5wgZGwq7FMKr+S7d9T2lWYMPk3aqrWa4LUYI
X-Received: by 2002:a05:622a:512:b0:510:141d:9d03 with SMTP id d75a77b69052e-516c544a603mr6986401cf.7.1779317150070;
        Wed, 20 May 2026 15:45:50 -0700 (PDT)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ca361896bdsm10753296d6.21.2026.05.20.15.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:45:50 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1779317149;
	bh=0ikrSU9XktaZzVYO+3LJLhuj5lBGwDhqjYZ9LS64/4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRWbe3PqxTnFYmIgjr++Pr9fc9OzNzYSt6BUETEzVT3CurIFVtVJsAJhzOP+t8/KL
	 yhPbtbjDf6W7PsR9ijEOS8hFwpzveqO/zR3fJKzN4vMU44hmsrNunbtMc6KlmwW8NS
	 endWgVqpNgfns5S08cyk0EBpR8yrRPaRpvOUPxxEDKzmIWN5GzhmZrDgywsmJpaUAG
	 cQZnLjxu3v4Q0oZKVrWC4amr2hx0austHmwbbOlHUpftZh6VxjUcPDFIr5G08fBhix
	 UwLCdstd0xLOIl/yNrGumqLIu+vu3bUmBN/LnYSIa4tpeYCyGiJrke2MatjMySxbC5
	 eeNBOOIOF+jwg==
Received: from gianfranco-dutka-usb-uas.sjc.aristanetworks.com (dhcp-224-35-225.sjc.aristanetworks.com [10.224.35.225])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 33AC5100607;
	Wed, 20 May 2026 22:45:49 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Gianfranco Dutka <gianfranco.dutka@arista.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gianfranco Dutka <gianfranco.dutka@arista.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: NULL res_attr slot after kfree as defence against double-remove
Date: Wed, 20 May 2026 15:45:49 -0700
Message-ID: <20260520224549.3304374-1-gianfranco.dutka@arista.com>
In-Reply-To: <20260520211306.3301893-1-gianfranco.dutka@arista.com>
References: <20260520211306.3301893-1-gianfranco.dutka@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thanks for the review.

Both findings concern code paths I have not independently
debugged or reproduced, so I do not want to confirm or refute
them as bugs from the sender side of this patch -- that is for
the PCI maintainers and, in the alpha case, the alpha
maintainers to judge.

What I can say about this patch: it is intentionally
defence-in-depth, not a fix for the concurrency window or for
the alpha allocation pattern.  The read-then-NULL it adds is
not atomic, so if pci_remove_resource_files() is genuinely
reachable from two threads concurrently then this patch does
not close that window.  And the patch makes no change to how
the two pointers are freed, so if those pointers do alias the
same allocation on alpha then this patch does not change the
underlying free behaviour either.

For this patch itself I am happy with any of:

  - merge as-is for defence-in-depth, and let the issues raised
    in review be addressed (or not) in separate work,
  - hold it pending a proper fix for whichever of those issues
    you consider blocking,
  - NACK if you would rather not carry a NULL-after-free that
    does not address the underlying concerns.

Whichever you prefer.

Thanks,
Gianfranco
