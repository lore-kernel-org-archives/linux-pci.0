Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CCE3128A2
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475300; cv=pass; b=cUROPBYHolMtcwjVe3kiKhkB8HqN5QohAjNNMxN7BskcPNY98jX2F86T++IyRWaznM/lLe2tgr1L5zRH4K3MFbSq7P8dE0zi29vzih2l6MW/HKDXKILs2yCwJeIp1bVFKv/MGJ6UYLR84jFbRkEpHMsG7ORL7498VJysvQRUNrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475300; c=relaxed/simple;
	bh=BTi+4ARakd9uxctTdqjtJnxTFNq/yPeOIt/d2iLvfuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvP/apoN1a++RF2d5/lsKEnsek05CkvtkGjKDwkoqlvD3+6S1cpa24q35u6awVOscCg/JgovrVN65yF+ggfaP1w6F8JNBZDl1UUX3bQYzOxj480FQ8cr3TgnHi+d5v2xJvv7TCO0TTA0MVp5RygRa8diTBRR1i26+3pLyKc5h5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTMZwI8Z; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTMZwI8Z"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-389e2950f54so12974491fa.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 10:14:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772475297; cv=none;
        d=google.com; s=arc-20240605;
        b=IC5+/N1S+RkiCha/Ur0Z8JKkR8APx+SWMIBgb4geCgrDcDFimTB8/wqDVhV9/rVyWq
         TiHBvKaaQN4CPtlpGqeR5eIAxuGtffCDAxt6FeRuDRL9vOsRQ38uwrutDLKWj3hFXzh3
         PIl9QBhr0Lu3gPrKd5JO5qyQYCB/0ls2HveX2sBDZB14ye8K6bMxbY5F5bgGs0wnMccK
         8ybKaltr824cGiOopKa4IbPxML9dqrpI0cwy2J5b3siVgBNjnQRWgHJWQprWUe4SjFlI
         8Ml7aRZzBt7539UuGrAz6pCBTygYhI4RWQ9Aei7A1yXa1umGiJfvTy6Obe7hoTYvMwjV
         EJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZw46QiejIxPJc1G5DNZGnj4KsLWM6jIVrYLGkqOkHQ=;
        fh=F11k4juNd/fiErRxy/mSBTaCJFOLnaq5KRTHZxQ4h0c=;
        b=k+jR9Q7BKE1j32mFQh4ht0aR1GGrmSJxDaQecvERlw7AtPOLqaHS6JiJ7KLZVQITfI
         9WMtbiWivBkv94ukXQESpwgz4+t/oZBtFzs6xNLjYU89nCq19fSJbDPLtsbDqgSawDhW
         gWV/DgfAUS8Dn039umkKgEc9J6Aj5vAupZRUJBlCvMMYC/2h2g9pVzJ3KvnFJqGsS73E
         a3rMUuvTEzhjV9jPEBvvcqIG7zRCfMfH/WhIs7zNoznvJpcnJYtDLggPwjuroije9cxn
         Fv7fTW99fg/e5NPvIjgdQB+MOhpSYvHWO8+Rq4+i2nQwk3AdzNapVWsQpuQuuqApXyTS
         SDwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772475297; x=1773080097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZw46QiejIxPJc1G5DNZGnj4KsLWM6jIVrYLGkqOkHQ=;
        b=bTMZwI8ZdQqnj4AgTxkJe6IjG1pfNONBuMwDLAvSla2GHqfEkX0h99WhB2RdJaxT+T
         ujJn1WMtH6ol/zVwaursQALwAzikhqQRDXCXEVQw3oUlr3T6wYY/W1MLeTLqR1U0ivhK
         o6px54O0EN+5JWoPVTj/QKoXmNd1VRfu++gSIhoN5AiBjhlmwEUJsUfn/rAaKxPB66UU
         TgVupI8uG5Ma/tMs0zMwft7t0/FZmOkm4e6VdgXJ5uE9PhQ3K1eQqmyVK7Xy56dQ0n+C
         EdIjgD9nrHWAmhLtECRerfHkXFdZoUUZGd/7Y3fpDuU4gxAd0M745lS0yWkTmNo9M+Rj
         J7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772475297; x=1773080097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZw46QiejIxPJc1G5DNZGnj4KsLWM6jIVrYLGkqOkHQ=;
        b=qyK0g+633ybTEdn/MPZpt6rFSAdsyr+LcM5ef8n2Bq82HX0FxwexguccM1pWKUD71G
         6jhccJ/fOATLDCFPHPkESLQTx4sc8XABVoHYYOoBEr+TPC3Lbdd+A5Jj37tJhHi1q2sh
         Fna0blPCzK6I26II55XbG9yJt01+dlKOLjXY7IRZONWS6iZAPSzr7NicC3U2kgX46wzF
         vhXFr5YUH/rbksgKUZjEUBJzF/zM1ADhNeTN+6iRcv562QbU1B06aduVHAKuGCFk0UuK
         DP2UKSfIKosCB1/t4pT0NHKXLRcKU8IyBxzUeIjz8Fgxe71LlDm2QKK8BmCQqwdu5KQT
         wN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXipqVWckfALOFh7OpqTWwLrFQURb5g2k3L5KwxeFxzusMhnZDuYNfWVNlUOXGHu/Ha+VC9UugzD0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSzXiSx61ciVeIPDJnsGLyZtMq/U1XCW5s0DPJEQlmp7zjUs26
	Gou3ht0MlmwsiM5LUiWv/9ji5h83NP9jwejLUnsyyxntYQSPWsFXl5Akgw1gjOmc0wK6DGfC3Mu
	D5KbGuPVJ/8Z4fM7VlW5TO9LzsxdD52XqJ4w1d9ps
X-Gm-Gg: ATEYQzyoYwQQQGva7EwMXwleX86q4+oHkctsgiyb24Yt/JT8ogdVoGmYXzaLq3T6RgW
	mS/So2Vo4PagX3PtHBk5al4GZAULGnzKDPPApRLOx08cjAT8LufAaddv4aEyjd1qF6vbhtee7QJ
	7m4shIM+td/FM0iBxdGogQx62yGEfR6YmvFp3uip/HsYIENBZkSbJW9+ixkQ4b2RMr5uhU/9XvD
	XqJFNfQ+n3AfQKyx8VYYZ4puS8rScV6wu1fMrOdi+X0pF9MeTvYajwSPt9tgIBsN1Y0hIpyhKY7
	pNzHUl8=
X-Received: by 2002:a2e:8094:0:b0:389:ed12:9731 with SMTP id
 38308e7fff4ca-389f1e29849mr81213251fa.16.1772475296490; Mon, 02 Mar 2026
 10:14:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129212510.967611-4-dmatlack@google.com> <20260225224746.GA3714478@bhelgaas>
 <aZ-Dqi782aafiE_-@google.com> <20260226144057.GA5933@nvidia.com>
 <20260227090449.2a23d06d@shazbot.org> <20260301192236.GQ5933@nvidia.com>
In-Reply-To: <20260301192236.GQ5933@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 2 Mar 2026 10:14:29 -0800
X-Gm-Features: AaiRm53G4DyTBgh8HthgkNXd7A4lLjemXkfCrH3k_RfrPJCtk91UZa8WxDGHRMs
Message-ID: <CALzav=eJ63gitLatAerrjEc+o3VXcRor3XwA7_o2PmKYnMwCuA@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel
 during Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 1, 2026 at 11:22=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Feb 27, 2026 at 09:04:49AM -0700, Alex Williamson wrote:
>
> > Not only fabric topology, but also routing.
>
> Yes
>
> > ACS overrides on the
> > command line would need to be enforced between the original and kexec
> > kernel such that IOMMU groups are deterministic.  Thanks,
>
> That's a good point, I think as a reasonable starting point we should
> require live update preserved devices to have singleton iommu_groups
> on both sides. That is easy to check and enforce, and it doesn't
> matter how the administrator makes that happen.

I can add that in the next version.

> You also can't change the ACS flags while traffic is flowing because
> that changes the fabric routing too. This should take care to enforce
> that restriction as well.

I'll look into this but will probably defer it to a future series. We
need several more pieces in place until we are ready to support
traffic to/from preserved devices during the Live Update.
