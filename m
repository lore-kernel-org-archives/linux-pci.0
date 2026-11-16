Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848196;
	b=YQMjsNVh7k6V9NzexPoNoD15HD/YG5bPYLvGad6rRhcNo7KHf7PC261KKsNMrWfe+aog
	 OlGLb0NZHj8EPA2hXiKnNCamlXRzLM5/cAdFjdL4pkhBvpd/LGwVeNAs1s6aGvuNbUiuw
	 le6HMnxqVlPrpB9UXzpcW8LaM/WQxm91XXqTTaxJ5cCabxZh3Hij2LSjStX94wOoVNEHd
	 28KOwh1OmHrahX8KloE9Y/Ut+AlPs0puOp0U+KhNSrb55cz741ld4kJktB9XaSiBKjDBy
	 yv1+gaXIIMxt9yoR3hV2gJNXswzUBy4/xA2LeYLETPbrCUfyHL9bg6W8fxvPGWBDDVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848196;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=nGtKkqWe9UgPpr5+w33nzRYd1BYTGY4QmLZE2nVpS+Q=;
	b=YJy1ZKwYLXRoqQyX3oTtxtGAiQeanu+2x71BY4YjBWGpA8fVJIBbSQ3x+faQ7Eiq7tYK
	 omZWMBAxnbroSTA10NJFYBtHx9ryPCGI/o6+pMiTLLDoV6+T3iv8QbtSjHytCJkjSbkiS
	 NR+VHneRFQVHGFHUt63VuUl0te23Rk6sr8YjbT2RYSEmxnWYTd4f8Y/rW8OhPvCRPA+TU
	 /kJHWBNEGNiUpf57uxNAQJpWAoZuqfgxEJvjVXBAhG4G2/U+qzkBy+t6z97keX7TYil7E
	 Rl2MrI/lE+vTZSF8wvY5UCRxUekg1JwxGYyzHIAF/XTbnt2rQn2/oMgyfd1wW50CrSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=ohcFigdh;
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C07606A883;
	Mon, 16 Nov 2026 16:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C07606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=ohcFigdh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794848196; x=1826384196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nGtKkqWe9UgPpr5+w33nzRYd1BYTGY4QmLZE2nVpS+Q=;
  b=ohcFigdh3dwvAcbzegXsTgUoFwxlldPuqKl+jOlFHvF1rgpPD0m9TLlY
   6Z74R1TvdyzXpdCwm89ujYnMl7L3SSHIxuPt023BVGDDSXqOpLkIS9aoK
   GLFVXyDXO2L942AdnEfq7tMj6ICO81qeA+qhvBEWuGSdE7TUcneh/y4mL
   uktl7IFk5Dj4vSs0sBVdBQKflFMkUiJtXBdRiSWrN44hNPTvWohxCheeq
   9gxoFWUq6wY50KnHt4FOakld4MTuD5hbGm8WIPPwCYNfDqAKWmNlTYq/H
   lmmtxSXxZHtyvek+ruNGn4YQFzgvj6a/9Us53gkVIkC9yUy+N78NiQv62
   g==;
X-CSE-ConnectionGUID: OAg241cfSXOTosfqpRuRvg==
X-CSE-MsgGUID: 7IbTfab9SLSOmksQINR+kw==
X-IronPort-AV: E=Sophos;i="6.27,217,1787011200"; 
   d="scan'208";a="34067159"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 16:56:35 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:6090]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.250:2525] with esmtp (Farcaster)
 id 53290bc3-64a4-4e73-bba7-410ba37a59a5; Mon, 16 Nov 2026 16:56:35 +0000 (UTC)
X-Farcaster-Flow-ID: 53290bc3-64a4-4e73-bba7-410ba37a59a5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 16:56:35 +0000
Received: from dev-dsk-avivb-1a-8cc559d6.eu-west-1.amazon.com (172.19.102.34)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 16 Nov 2026 16:56:34 +0000
From: Aviv Bakal <avivb@amazon.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Zeev Zilberman
	<zeev@amazon.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] PCI/PM: Keep hotplug ports that can't wake from D3hot out of D3
Date: Mon, 16 Nov 2026 18:55:22 +0200
Message-ID: <20261116165627.2775780-1-avivb@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <avnqWd1gVH-i2Jkk@wunner.de>
References: <20261115171831.1498006-1-avivb@amazon.com> <avnqWd1gVH-i2Jkk@wunner.de>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Sun, Nov 15, 2026 at 07:22:33PM +0100, Lukas Wunner wrote:
> Intel Catlow Lake suffers from a similar issue:
>
> https://lore.kernel.org/all/20261103193136.2410148-1-sathyanarayanan.kuppuswamy@linux.intel.com/
>
> Please try to follow the approach taken there.

Thanks Lukas. In the Catlow Lake case the Root Ports still signal the
hot-add with a PME interrupt, and only PME Status is unreliable. Our
ports are switch downstream ports that advertise PME from D3hot but
never send a PM_PME message, so the Root Port gets no interrupt and a
pcie_pme_irq() hook would never run. Keeping these ports out of D3
looks like the only option for the existing devices.

I sent a v2 that fixes a runtime PM imbalance in patch 1 when NO_D3 is
set by a FINAL fixup.

Thanks,
Aviv
