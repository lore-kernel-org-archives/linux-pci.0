Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041434;
	b=tnOklIGvr2p2BV9ignF9Ia9kp33pGdYfjNs5N5YxGfboE9lISeDCq7vY3XEV0LxDr6Pn
	 cgDryekz4+amn/uQqgxz//1lEBOtMKdFbczT2I5NgGYh96JramuEWMc0bcJYK9XohTVFG
	 ihuKOmtYcnJ1b9IFSsBLXcu4IF80U1uEMiUjQB7r86uTh527mGieejIiPb65HEpZh4wVq
	 yYobdtvhHLxIOkE0npazu+r1kTzNNaG135lcXInAQBo77DKh0ib+yruQsEkbuLoFPANQs
	 UIUdDp5YJgPgY6CStIDuOuoshczXcCzAyafmTm3c7a0k1gJpHfReksYSvfF4RF8vFGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ad5b7cD20gHMOhZMyF8+WzruE7aQOBAM0dk/O+UacAU=;
	b=39vae/i4Nwr+GY5sRbs8+OPQ++MJF0I58q3XXBvYRhk1XTUhJZa+gMXzS7GrdxE+nHGo
	 i49FVrDB1LuSBniKhub756pSqS6FdlUufLbF3WArCoOX5d7zFO1y2T3JCzOcXic6FvLBX
	 1S4cDZbSprhpgITHuiy+Sjjj5301ze3i5lATZoXAaYIeYB4vzLSVUcRqMIq3GDlylLiuj
	 r1VzxYQL6cPJPP4qF+42T7n3HcKE7XJKlf8upc0GCNSq3Qog5wmrBOHK66fx7ax7pBa3E
	 E0fzy1s9cF39tp6+NSr0rO3sW8Jou5nRN5+1P11N9JlUdzAxNW7V1NCgwB35iGbj3HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aY0tK3x5;
	arc=none smtp.remote-ip=209.85.160.70
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1A60A262F
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 22:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B1A60A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aY0tK3x5
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4566537e644so1643891fac.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 14:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795041432; x=1795646232; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ad5b7cD20gHMOhZMyF8+WzruE7aQOBAM0dk/O+UacAU=;
        b=aY0tK3x5hpEuOgjK1LbmCTTsGON2EP0ZXn4GcuDj1uyXJgXbNq1e9++IerlF6ogvas
         DCSqYO9s3Hd+dz6sxleeiVXnhYS8iV1/0eenGG0cWLbcjrf4wUrLaw8voieXMmJJyBw+
         KENduTvJdo/y9yWvADIlZAH1zwM8dJYQsggsRW7fmKcKCmeKX6On/Yx7PydI4mYvzwp1
         WNTeKmzk4SzpydEsYMM0AoxotZz/2DVzua4TYkszJoQm3KzsBpTTLmTbSWuopIOqxmqQ
         5reOaAymF/v6FIUB35ElHPkP1Tv9VM7uKnUNnENT/cNIUycTzz+mbLBxfrUdwRbX+G/T
         xoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795041432; x=1795646232;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ad5b7cD20gHMOhZMyF8+WzruE7aQOBAM0dk/O+UacAU=;
        b=tb8Aaj4JZCCLhRMXhKkXCgfOVomwOWlU/mDmRNPgjxshLFeq/yi0wDt5CYOCy8H22d
         AOBXplEA4JalH1bkAxmJqcjNigTm+GQDNC6w8XNoH96b0jc+XdR0wHp2zeefLj2nQ2I5
         bh/YsiR1+Yj9Q1satGBAMrHDvI09xG+URFb2JFf6CXkoYry4YMqSbzrZ75C85BzLjhbz
         RfwHQwfmzyLUy/TYk/ojtb+MNbr3ePuoaTf63BtT+dKjqALvWP9A/Rjo4zG2/rJMjvYU
         4+6ShFZXSfCzME+202XfsrYFe/ev/SAC9x1/x0+ajCHJI+cnZr7xcgn6qvO1Qpr0VsEM
         Fk+Q==
X-Forwarded-Encrypted: i=1; AL+hErGf2hkvFh21PKhqy9w6Zl3IiWGbUHMgIm1v3pLPPo0WdyIGnrBIGZu82Hi33M11xl1SwhTI2jaQgt8=@vger.kernel.org
X-Gm-Message-State: APuU4Z84YWR0fqxkWNhhneWq04qBYEgtxHQzGm28IZIPfLxAXDoMbDE1
	UEXppSpXNSlEWBi4rhWe/8VSxc+ALd5aKg65utbfGWnbOxFDqxHiii3X/4s5avIj75P53RXTKJN
	uMMAP0cH80/9AVg==
X-Received: from ilqe2.prod.google.com ([2002:a92:d742:0:b0:53c:2d10:3af1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:6401:b0:572:8a:59e8 with SMTP id 5614622812f47-5773d72c450mr4859784b6e.55.1795041432243;
 Wed, 18 Nov 2026 14:37:12 -0800 (PST)
Date: Wed, 18 Nov 2026 22:36:55 +0000
In-Reply-To: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118223704.3286085-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118223704.3286085-5-dmatlack@google.com>
Subject: [PATCH v11 04/13] PCI: liveupdate: Document driver binding responsibilities
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Document how driver binding works during a Live Update and what the PCI
core expects of drivers and users.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/liveupdate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index b569093bea75..d1b4000c3e78 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -123,6 +123,20 @@
  *
  *  * The device cannot be a Virtual Function (VF).
  *  * The device cannot be behind a PCI-to-PCI bridge.
+ *
+ * Driver Binding
+ * ==============
+ *
+ * In the outgoing kernel, the driver must ensure that it does not unbind from a
+ * device between pci_liveupdate_preserve() and pci_liveupdate_unpreserve().
+ *
+ * In the incoming kernel, the driver must ensure that it does not unbind from a
+ * preserved device between probe() and pci_liveupdate_finish().
+ *
+ * It is the user's responsibility to ensure that incoming preserved devices are
+ * bound to the correct driver. The PCI core does not protect against a device
+ * getting preserved by driver A in the outgoing kernel and then getting bound
+ * to driver B in the incoming kernel.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
-- 
2.56.1.703.gf848ed807c-goog

