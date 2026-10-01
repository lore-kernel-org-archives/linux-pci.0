Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B694B2BFC85
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 23:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897623; cv=none; b=tz/qW14KlDCvwggZVUiiMtW5Uz5Su+gZRwXL7/D1Nj9bWjt/6GHqmEdWgfc5Gk1BA30+NH037+nuXOY1PNqaQwWCF1qwJuIzdM9fGVeR1Jnao9A0BpWTBU9PEyNh5yL6lYSCFCshjhH7wY9hEXE7ng3/EHtl8CXoEkxwmjb+FfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897623; c=relaxed/simple;
	bh=HRFTVZPTrQyJy2a020pUzNZDKZFK/ppdVVD2t1GPGNE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hq6kl7cmT89yZZVHTflr4o3avV02K9ELbYDoPdwmPpLTveRwcE2wT4KhKYOBZF7+Rpvq7P6pkEBHhPTIYoiga8C/1EANiyaOSUr1nyisf3MGT+93cI4RakX1/xzC7DVg2MEG2uyXd97cDNgRkci50aJap/nvs6FTWYzjKUkh9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZsaNMEz; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZsaNMEz"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a47617a0b3so5152122a91.2
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2026 16:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790897621; x=1791502421; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t0hyqHon5Q93ynr004Gnl+hdl/5Yk9pqUGYkxpwIh3g=;
        b=FZsaNMEzLUARTCC4Pi4ImWU7/H/6AUyqflO5BZHpR+KAizynE9xEyngkKBO56gD5Ys
         +K0UNLCXsU/8e/n8KRNfy00eTnP7ie7kMIe/aEvDGG9QwjNmpvTKMX1Y0fhy8f1vCU3S
         cH0IO4WqG5bwt6LSzcl1aTcb5UAwL6Z1HzTciM9j/emYai+F7vIAAFwY/eL+TVuQ4J3N
         MTC1LW8QeQq+YbkFsdCniLx/bxgMkjziZhmCe0h0VuvnyVQXkV6dm+XfyzZt1v2nuBYu
         1Biz0O/jG7seYcHenH8JpcJ8MHg77DYQH8vmcvx3SmNYvmXDOU9oiQXKNqDBW/K38nDE
         3MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790897621; x=1791502421;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t0hyqHon5Q93ynr004Gnl+hdl/5Yk9pqUGYkxpwIh3g=;
        b=a6Lj7NNFqc+n014KUeSu6EFWQZu0Ta5jFP0x2POr+7nhF1+tz7N7DmrWpcI2DXpuSM
         nrnRnDP9g8/tLM462N0LS5j5NavSNYRT2fr7X1xwrnmStlR97/vjkcpmsoxp1zK6XpFr
         B+ie81h1ZzP7T3ZwRR4S5JU9g83tx9lPrn3AzNrY+v2vveL5uLodVuAoHP2G308RTe2r
         BNpORHAdRMaw5tICwBZnR9vQYABALYKTN9RfzQobDmrRxPtiBnFT68Zxmx9gSAMEm2eY
         CzDZoP3m3XrK3jOAH+DkjOeQcFgT8fXvbEfB6ZyskS+FNGaVwkcpY+Jq/so1W8jIKZaK
         Eu7w==
X-Forwarded-Encrypted: i=1; AKwUvBzYUrvwAOx3sr3/Ym7sXBE49vnePUOTeeUCiSM1x02iHkCey7yZVaSTdkJJzytcsRDzoKf/xAbcvJM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOquZS7oHx07R+54zj69YxfezeEppXnQp3Vpb3GOwEyWGjtTuM
	awqdQ5YyCiabfzZ/CreXvnwIfykmgWgR8vvGJsZrpwqjYVFVZeyXn7CXQQEaojGvhod1lQTS/Dx
	5Ug==
X-Received: from pga7.prod.google.com ([2002:a05:6a02:4f87:b0:cc7:a18a:c58f])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d44c:b0:3a4:cb59:cc28
 with SMTP id 98e67ed59e1d1-3a6ced272bbmr557384a91.54.1790897620752; Thu, 01
 Oct 2026 16:33:40 -0700 (PDT)
Date: Thu,  1 Oct 2026 23:33:37 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001233338.918408-1-praan@google.com>
Subject: [PATCH v4 0/1] PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()
From: Pranjal Shrivastava <praan@google.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: linux-iommu@vger.kernel.org, joerg.roedel@amd.com, vasant.hegde@amd.com, 
	baolu.lu@linux.intel.com, nicolinc@nvidia.com, jgg@nvidia.com, 
	skhawaja@google.com, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

This single-patch submission represents the final core enforcement for the 
PCIe ATS robustness hardening effort.

This work was split into two parallel driver-specific consolidation series:
 1. Intel & ARM [1]
 2. AMD [2]

All the prerequisite driver refactors from both series have now been 
merged into the IOMMU tree by Joerg, with the latest merge commit [3].

As the driver-side safety checks are now fully in place, Joerg 
requested [4] that this final, PCI core patch be submitted through the
PCIe tree. Hence, I'm sending this as a standalone patch rebased on the
pci tree (for-next branch).

Thanks,
Praan

[1] https://lore.kernel.org/all/20260615235037.259909-1-praan@google.com/
[2] https://lore.kernel.org/all/20260910142655.3281464-1-praan@google.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/commit/?id=622384f54a8415f28bf7cf11cda95ab125488ca1
[4] https://lore.kernel.org/all/arUOoLwpfNlIvIXy@8bytes.org/

Pranjal Shrivastava (1):
  PCI/ATS: Mandate checking pci_ats_supported() before pci_prepare_ats()

 drivers/pci/ats.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

