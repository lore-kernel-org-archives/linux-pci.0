Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40F2F3614
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058416; cv=none; b=gXaerwq3WhW/ygKwnI2zA5f0yZSxZGHmX49rssIq8TapZzHx6HaHhe4gzkQDGKHMw82p13+FtJ3GoZrPIaauLGCa/MOXx1ELHdsrT0jeYtS6pIRUTxLabXdPHCgBt8X2Q2b+yXbVr+geGWYEGeIBrbVdQdvJXtowfUiWD42krVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058416; c=relaxed/simple;
	bh=wcpAJ5UuiEZH41sqXH6Je92801Aq4N1agXMqVQrdJPs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LBi2nkCkkagMjHmbZblrxKSfjH/aFyxQXpubc8DMgaD4mtspMIIaiNu+6A3d4dyHYzdDK9JS5VoeaWPUXJS79RZFBuazRLl3A5ld87p7cwIur7Qi0e2jZMUwppBET2kvhrUAy0cvzGuvJIxcuQFGN3z3TrErIlufelFyOUMenuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOtdRvbu; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOtdRvbu"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5674d8be45eso130057e0c.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 14:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772058415; x=1772663215; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TcgCgCEo03Z5mFFecYPzQD3Rq4C5qPBZUB42/osw6tY=;
        b=mOtdRvbuHaEqpWrDxye6wD/GBtunmw60rp1JNfUMQBxvQN3KYXXFnLQ8aDnjQ/AqQG
         zNeVAkrZkr/misVHw1Bsr4qanMP3mDJU8EQhddIWM5KQjhNaB0kw6NEojn35P7FA+B5U
         rXXRvodlnT8xKq5EMJEgAMZlOoFvMZ3ajoKe6JYb9yjNd6BuQLY8LYffJmMl5PrghJ9E
         ktLr9TNLCtLAitPV5TWqPsxw468EKb3HXrIwiVIUSfoOPguQCnSnzXalyZhNlLh+5iG9
         89fhAE70ZOqDAjm4rYKhBKXQxjmAoVhc7tAmlv4UGzT2Hj4fYgsK13tg8bOdYAVqtMfz
         4GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058415; x=1772663215;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcgCgCEo03Z5mFFecYPzQD3Rq4C5qPBZUB42/osw6tY=;
        b=FhN67FjKOnIMeFXvOsH1aZDS8NYz1rFE9NFQcZ60CzlhlBeSzAgPdLlOqQFwWlkXfQ
         I1PyihJ9A8bXfMQo9ZzFKi7OZ39d3yNRwizQnXCqWbMfGR5/bVpRllxlQgomo/pBYGjk
         pEIpEUoOLNkcyrBFXkJY01pPTjBUIiaeMsrT19WZuuqFuYZNTW6dgkD/n0Kmlm/2uNZZ
         Kp0NHzGDZjBjg112jijsnJFIIkmnNgzI0ZRsfCMjnAkI8NpM6enkbHtvN1F5ruD5OIvn
         i71wqvttslGfrr0DfV6RHV9ZSBltfn+pGYdbYgwSTQqsEZowgDIZzKKd58hYl8ozIHl1
         cXSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP35YU0y/yGhLFMnHkfqMKXnCA0bFtRXqNHKNG22Zm1PY/j3o1OmCoZbmiiOCNPfG5+KyAEkU/S+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQsfzB4+AMSsRBYswyg/oUZ3orRr3wwH4K3/wohLKnBciH2XY
	k7N+Uzv/6BdN85G/JJEHPhoWM89wue6iXJz5eoA1Qo8breFS1IIw/gpF
X-Gm-Gg: ATEYQzwyB8Bs26S0vDT0Y+ITyiTeZtBTsJbGlDqVsb/VWrcM32mEWrSSVSOVI+BGVoX
	gD+JHgYgrH0VSYAAUO2SpGfD2gCK2sBYzejgHVJod0y1YZyBZD370wkB+kPzKhBRXSbAlbXOHoa
	z2DOjh73v3rr5IoNrtc/P7Ym7OkmteYUBcIMUPLzvt3j6BPTabbBR+GKxrZCBuLGLeXEodPOEE0
	4lxcqJBycXw/U9OmHZZDhF1BEy7/RnpFdqFLS10yl3WvfgbiOsNFcBxE8VRUtFnKmoeT3hxKLv+
	332f6l31QNWUDCZiMp/y2Wo7nH8+XInppvaPIWvH2nSUlbaAuTAPbanaq58JlTLmZuCmugD4ZEg
	qveQ3vto1GCxtj+rK/We3Nags4JkbGjS/B/s324LvZ6U884qeBG7TDqS7BjZljNjPW8t2b1aImd
	he5bMx/tSHdj3t1iDgHO6D
X-Received: by 2002:a05:6122:3b82:b0:567:443f:a772 with SMTP id 71dfb90a1353d-56a92ecd28amr155892e0c.0.1772058414356;
        Wed, 25 Feb 2026 14:26:54 -0800 (PST)
Received: from geday ([2804:7f2:800b:f14d::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91659421sm592428e0c.0.2026.02.25.14.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 14:26:53 -0800 (PST)
Date: Wed, 25 Feb 2026 19:26:46 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] PCI: rockchip: 5.0 GT/s speed may be dangerous
Message-ID: <cover.1772057799.git.geraldogabriel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dragan Simic already had warned me of potential issues with 5.0 GT/s
speed operation in Rockchip PCIe. However, in recent interactions
with Shawn Lin from Rockchip it came to my attention there's grave
danger in the unknown errata regarding 5.0 GT/s operational speed
of their PCIe core. Even if the odds are low, to contain any damage,
let's prevent 5.0 GT/s operation as well as add a comment to
Root Complex driver core, documenting this danger of data loss or
worse.

---

Changes in v3:
- Clarify warning message even though Rockchip won't disclose details
- Drop DT changes as they were applied as subset by Heiko
- Link to v2: https://lore.kernel.org/all/cover.1763415705.git.geraldogabriel@gmail.com/

Changes in v2:
- hard limit to 2.5 GT/s, not just warn
- add Reported-by: and Reviewed-by: Dragan Simic
- remove redundant declaration of max-link-speed from helios64 dts
- fix Link: of helios64 patch
- simplify RC mode comment
- Link to v1: https://lore.kernel.org/all/aRhR79u5BPtRRFw3@geday/

---

Geraldo Nascimento (2):
  PCI: rockchip: limit RK3399 to 2.5 GT/s to avoid data loss
  PCI: rockchip-host: comment danger of 5.0 GT/s speed

 drivers/pci/controller/pcie-rockchip-host.c |  4 ++++
 drivers/pci/controller/pcie-rockchip.c      | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.52.0

