Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF231E83E
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585325; cv=none; b=TO4LEYfCOkriJEd/rGq/emBM0/OQuaEST/l7V4D097bK/IdLMMsTv7eT2AvwyAfMNayXoOOl1R3Fm/23ZymdRxSK7YGMQ14M0otA7gxjvvAsrTnzVa3N77OdTzCcC+7MdeUcUuLZmAbq382dZZm3TgTNbeTFVNhRSXriobaONBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585325; c=relaxed/simple;
	bh=cqs9K7t4GQhb0P+3IHmoEk0x+onZANKdAYdq39+2FfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ot8beTXzGe0L3VSKNcPB3qpdgVf9TL8eA3Znj+GtdicWqIcZ9QpnT8dZJ4td4hvHEaEzDNpaMKaxJx1jEZH99DZ4binHH5GxWY9G50024aRRS0ZpnRpJl3/oJXoNY3/W/Eg59w1S+WGzNhXY1i6DCcwrYWmpqlVhpLfbw9sITz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRGH6gYj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRGH6gYj"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0aa420401so6578315ad.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585323; x=1781190123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZHMOC3ymQk/hCIs6rXv5bV3psfV3xxIvT+fp4eN0Hg=;
        b=sRGH6gYjG0Rz0SBoOVpia+LGsNemn35uuntazxcY/yNwqlBrt0wQRJEutejVOALuvi
         3wETN/JiEc++YVPtM/uFx1+lpMHZvh6C2TOJ1GG0sLvTQl9xXaonrTERQsCpXrHtlBrl
         fb7kVnB3Q/ebejKJG0EtUZY6TvG7Aa86AauFx1X3XwgVK1FQZ1pl2PrjVzo6S5S1zPU2
         iLnHhyu9rWCmigQxvg2Au/DH/ZMeLjvmUC5geEsxCrax1yYS4DngjdDGdSZx9tP+ec+N
         cK4iRwKkm4j4p30jNGP6BqbVcAzqfnKldbz6UI/IEME+P0JJXM5EjZVSeuZgGPEYfloA
         1LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585323; x=1781190123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZHMOC3ymQk/hCIs6rXv5bV3psfV3xxIvT+fp4eN0Hg=;
        b=UuhKIiap75KudtPnwcI1iB7ZjI+1IvYrv4I8Bzk+xBUf2epMKc6hNhyj1JZjCmGrJj
         btSXy0jwzyipEFEUoXMtwxcAtiB0hHcDFLJUDmP+eok8gDCFN01aQquY6+icBAtEQGSD
         uALYZTiinRX72gP57GNlfwm5skBhYBTt/7e9hoXnIw1PSOsYxFPwZE9HLVqSE4fGAFO7
         HzMunRjUs1JNMLCAO5r1OfIo1OAhpVfz7S12R17fpOopFrs0X2TnVTHKrhHDe93A80Zg
         +qKJjOkQgMQ09f2I4YZ9spyaQ/vjkT741e6agUz00vFnrcreGhjqFQ7+qMB40Sqpr+h9
         9zng==
X-Gm-Message-State: AOJu0YwrLaY0eXBF47US29Ksvf9RKcPXbE85f1XNV1W73G/PgDdeR9oT
	zTc4484J9b3GJ/L1HvOh78fwQFgKdTzbOoinUtGEiQGcfBHr0IG17HY1
X-Gm-Gg: Acq92OGuC0G2aIYBdquQxPVZaneznvrh5sOmi6CZSJvWgvqIc2A/8w2FuJB+uOhXONT
	p1leB2bVnUe1kO3o7r4ot3DGBvVqyn9AEMfFQUDexC1+cVFwsrN9XMvrqx/qjJo0KZzwaiYvhQc
	wB4q1H4O41/+2CWv2miHIMuulk8MKXYzHWgdWBIVlXkboTwkohhMs566z53ctVAUjJfoWxu3sbZ
	m8PEV547vwJgSqKsU5b3KBhFEWGHQP5VCLw6miEwlb9nJ2RrV9sS8rzItCzrqbkXAqrun/uxQA+
	JMX0K6HMHTYlEHbEpbgRuZKbYDkVvy9XrxjAA3YiT6zFynmHNN2wcQmyan7qst9B3rw6wg6HfIr
	b3S+irFHx8HhF4mtnCi8IGoT/PAh7RtBV6e2R7wr4E5t4cIM4W5PYCr0Wm/c+3VVqaA4z+VwdGP
	RfwZGheXFC8U4l2P0hfH279Ai2d99FOqgkgna+5GQ=
X-Received: by 2002:a17:902:be03:b0:2bf:13b0:f8ed with SMTP id d9443c01a7336-2c163a28b4dmr55201165ad.3.1780585322733;
        Thu, 04 Jun 2026 08:02:02 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:54::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad138sm64224585ad.82.2026.06.04.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:02 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 05/12] PCI: Convert s390/pci/pci.c to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:46 -0700
Message-ID: <20260604150153.3619662-6-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dimitri Daskalakis <daskald@meta.com>

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 arch/s390/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 39bd2adfc240..5e6f600bf60b 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -611,7 +611,7 @@ int pcibios_device_add(struct pci_dev *pdev)
 
 	/* The pdev has a reference to the zdev via its bus */
 	zpci_zdev_get(zdev);
-	if (pdev->is_physfn)
+	if (pci_is_sriov_physfn(pdev))
 		pdev->no_vf_scan = 1;
 
 	zpci_map_resources(pdev);
-- 
2.52.0

