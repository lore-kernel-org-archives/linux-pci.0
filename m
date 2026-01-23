Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33C3451BD
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769146782; cv=none; b=E0fDLntKUZmrzPF8Yi2hM3FXpIj7GerOQSSibG9aWAiIS7eC0EUqUenj68yTYLO9BHwVRgD3OUVZA4fLtLLPm7GvgkjpfQAM5h34kOQiYGAzuwXK6F4F3bIQDTcmKJvrS2hS7pp6HeobFjPn6aZ0aVHQ9FWdVWCxCLp8BuNQnZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769146782; c=relaxed/simple;
	bh=I8rYsPArjClMI0OlY9LdFMlzeRq2tpFxbh33gFcF2Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vA3JV51pXCDu781/yVgQYshvdnUF93us7vLfZFzz79mH2XaKc6ns9YI0Rh8lInPgH/fLiWw5TB/ILwgQfxeylyMqFFQ6uH1ocpgbM9rbrdE0pV4g6H3eFE2FAmFeabLfOqqyg5xzpQL9DRZIqO40eUDftJBDcL7GRlNmJM59fMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=p6FF3561; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="p6FF3561"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 91F813FAE8
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1769146767;
	bh=zLCXslpHHlmT4bEIPeZoanKUUqxnGQJncWC/wm2gT8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=p6FF3561yXGfz5fqeqQz2r4udX3FHAQUJXjNi7jt9JjUqkTwwT1KfEwklwzMs36Wx
	 LqrAR0m01vr7iwk7fgS9JednvyYJ+kbwS1arr49in5duzpBb5AnHnmuCJ1d/YeWM3l
	 cJ4Tuzj7vBy82hfSmdzE2xMk2k2tNvXHh0OWooul/qyGVZsgcvw3ZL0sYEI8+HAeL4
	 vmJw+MSbRTYfmT4rWq+mk6ZHw6OpmS10/uW0LhGBcMClkjlhpAhnzcdNP4MNLPUU2B
	 C20zXIuunk8sTD/7cOI5i0NRYhVP7M/q0LP6qGfbW++6YSiBb3thlo+eTW6eWxUp/v
	 f6Rueb74GcszESsYmqPPtVRPCVG8cJyPuez+NC+NNe0DxZvAxiNhP/+LNxIHZb1L87
	 dUX8/8QY4ItBbDFN383HP0o1JIqAtxyGHYSkTJmN5cP7iPiweXxEZv9mJoaLUoIumv
	 jmKxH3bSFprk9+vrDjsp3cHv2hZdAv+AakLSGI3ibfpz0BYe3NHkBl08x7NQUmFMlG
	 lgxIyAeLPycjdmOM9Dg2GQ/7bA2G22pBgsqhpyhPJ4aiRzn0sxyo8Mqe6Pq+EDdA/p
	 jw/Q5YzY7yglKmRWXAD7xd2aDkrdnBY0RHei8qgvdjmyNhEaeWUe6uf/B2OvKqHplI
	 p5KLi3k9zaFwMaZbOgMiDWhw=
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a08cbeb87eso19340825ad.3
        for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 21:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769146766; x=1769751566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zLCXslpHHlmT4bEIPeZoanKUUqxnGQJncWC/wm2gT8A=;
        b=pGsR8SS5R4GliCbx43ce1jytsAMhccRjZ9SClGMpY/uFHSjROnUHiNbp8xn33WiShs
         hZrZlmnisC0Ois8jv2knRkubPkw7kj6U8CCZ2luMjWW0Sid1daUasoPhkv+Ef6NyZRaJ
         To8M+I4KWj/omJzMyisIvxypNqXGgpIQLwztIcnEixQOy4is3cP7RNBQhoebJD2rgHWd
         ZaD1g5ZOIAPomHLi6d5JSlQFyAvJ5PEdExsODgPgcp2UrjvClvSlYnuhruf/wkPvRkLu
         h3ePOZEADB/b/IL9Agka9IsBnN4RESWCqosaNUIeFOu7QECI4dtUTgMtylFWyWFUkKJy
         /fYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDQGhiFKkjBPFXefuSgnDaplLkgHWKdM0ia8rfbWJfN1G0IF1/wYcig/wAG+Aifz7U4ANpPIzJHaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9Wi/vn5ZVkUjN//CrBueIBqjaYWZA8lV9EdjVaJk/oDpB3IF
	Whhxg03T1s5GugsZD5+3L28hB5oQbo2YmyjHS0blbwLovdhoXdVNzfoy0zkh2cPiLwZZzcNBIDS
	zhR4kRFR5bsKTNHJhXkTOb4bIICHg/uikdOzea4HdwASqRa0XTEgLWyUzQs56UAQWNpgJfdRgVO
	tANg==
X-Gm-Gg: AZuq6aLZ2ujmye+0jih6kp3nEVmpuFiRyWyOhW2kXdCzz6I9r9gcOvR4eT80bLkogu5
	ND+K1NpAA5EVh/BbPLhY7SuCGmR1OQ8HRwlDrHkYqzMf23xv1DqwKSmAUs5UQp/Mjv64kfkur57
	rkT1CSWLcw+5cxA157XAbHioV+Nb1GjP9KfWv91VyYAXMAbgMFxZNE19kiFtoa00/1Sm0vZmUA8
	fZydyOEyoXI4kAEcVxwkdYDPSOpLT2ppvFVqAv8A7SmEyDpLWenQ7tXbCuR37uW8PTlIsQ1RKlW
	Vd+MDZqPmH/8nl2xCgoIL/o/ou8Pbj3nWy3Wd9zVTx/1UpXtI61YAOn1emNPdWWI6WTIZ3RQA9i
	r2GUJbDSujpfVTYeyWm9RNxc1rgHm5cnZmzjV89cQw91pUop3D5o=
X-Received: by 2002:a17:90b:5625:b0:352:bdcd:118a with SMTP id 98e67ed59e1d1-3536894d548mr1542082a91.21.1769146766169;
        Thu, 22 Jan 2026 21:39:26 -0800 (PST)
X-Received: by 2002:a17:90b:5625:b0:352:bdcd:118a with SMTP id 98e67ed59e1d1-3536894d548mr1542072a91.21.1769146765830;
        Thu, 22 Jan 2026 21:39:25 -0800 (PST)
Received: from Garunix (122-58-172-36-adsl.sparkbb.co.nz. [122.58.172.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536f25c4c5sm417930a91.6.2026.01.22.21.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 21:39:25 -0800 (PST)
From: Matthew Ruffell <matthew.ruffell@canonical.com>
To: mhklinux@outlook.com
Cc: DECUI@microsoft.com,
	bhelgaas@google.com,
	haiyangz@microsoft.com,
	jakeo@microsoft.com,
	kwilczynski@kernel.org,
	kys@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	longli@microsoft.com,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	stable@vger.kernel.org,
	wei.liu@kernel.org
Subject: RE: [PATCH] PCI: hv: Allocate MMIO from above 4GB for the config window
Date: Fri, 23 Jan 2026 18:39:09 +1300
Message-ID: <20260123053909.95584-1-matthew.ruffell@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <SN6PR02MB4157545DAFDCCE0028439DB2D497A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michael,

> > I wonder if commit a41e0ab394e4 broke the initialization of screen_info in the
> > kdump kernel. Or perhaps there is now a rev-lock between the kernel with this
> > commit and a new version of the user space kexec command.

a41e0ab394e4 isn't a mainline commit. Can you please mention the commit subject
so I can have a read.

> > There's a parameter to the kexec() command that governs whether it uses the
> > kexec_file_load() system call or the kexec_load() system call.
> > I wonder if that parameter makes a difference in the problem described for this
> > patch.

Yes, it does indeed make a difference. I have been debugging this the past few
days, and my colleague Melissa noticed that the problem reproduces when secure
boot is disabled, but it does not reproduce when secure boot is enabled. 
Additionally, it reproduces on jammy, but not noble. It turns out that 
kexec-tools on jammy defaults to kexec_load() when secure boot is disabled,
and when enabled, it instead uses kexec_file_load(). On noble, it defaults to
first trying kexec_file_load() before falling back to kexec_load(), so the
issue does not reproduce.

> > >  	/*
> > >  	 * Set up a region of MMIO space to use for accessing configuration
> > > -	 * space.
> > > +	 * space. Use the high MMIO range to not conflict with the hyperv_drm
> > > +	 * driver (which normally gets MMIO from the low MMIO range) in the
> > > +	 * kdump kernel of a Gen2 VM, which fails to reserve the framebuffer
> > > +	 * MMIO range in vmbus_reserve_fb() due to screen_info.lfb_base being
> > > +	 * zero in the kdump kernel.
> > >  	 */
> > > -	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, 0, -1,
> > > +	ret = vmbus_allocate_mmio(&hbus->mem_config, hbus->hdev, SZ_4G, -1,
> > >  				  PCI_CONFIG_MMIO_LENGTH, 0x1000, false);
> > >  	if (ret)
> > >  		return ret;
> > > --

Thank you for the patch Dexuan.

This patch fixes the problem on Ubuntu 5.15, and 6.8 based kernels
booting V6 instance types on Azure with Gen 2 images.

Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>

Thanks,
Matthew
