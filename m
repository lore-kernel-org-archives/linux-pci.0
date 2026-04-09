Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B163DCD9C
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746900; cv=none; b=J8LVHGffzzIfFtb8qXwUi1GiFvS4/m8FDMhZCrKT2eN0653PuEvzIRXHCXQQwYdpwlWGQdTH3kgVAI/ysdj3eCtiBVigrRKrhulQ+U7aTeHIdYj8buWlP5vMk7eLpezwbcSbCaLcMBGvdZiGxrAmtg4r0R5A4fb8nSAi13jXhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746900; c=relaxed/simple;
	bh=G9OvV7vXp/wWZxzfIcoWe97Q3YUGjNO5GzlbZys/VW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L9W7FXbNMY3tVOmV2pAaDualaQNo9vFb6kNUgzNM1y2yA9xfAM4CRpJwMJDLSMhtM8nO9UndVIDs2iSiPTpzz4WhKrj/R/rRehLHDRPSyw6mzjHsk0sYR0X5KZIsUmJhdRiSRPtioh6YR/E/ngzI+pNkrmQtQqtixXN7CsnALBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RguL8IJG; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RguL8IJG"
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-6054a46d802so1278509137.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2026 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775746897; x=1776351697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=99ro2vXgYbLolPPBo8Mdr0wz15miyOgxU6wtwQUoCuw=;
        b=RguL8IJGgwYb73v22ra/Nuk8UeYO8iiHJnAkJ0U7peqA76eBkzk9pgpa7DkqQTyyMS
         PxaSB2xSBI8ugAqGMo3wGAy+IzU6HJbEcH8JEl3UouEk8RlN7BHXb3zViyaFYzYrVz9m
         hFp1Nox6pR5j+SQ7xbXopBFnPOmRCsvKklpJPNJOCYJuSFL58MRDItw/6QmK+qEw4yK/
         ZXFe0PF+XEWtk/xniTcLd+EObV4MlHUXDDj9XRhXSj260Bpex35VDLmB7VsVcGWCgAz0
         yQOXHyjIH2yMjCg/flEswP9b17VeCpKAlcBeccYhGsoI3CLDjPbwzGzN63fBZEVYJiym
         EhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746897; x=1776351697;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99ro2vXgYbLolPPBo8Mdr0wz15miyOgxU6wtwQUoCuw=;
        b=joEiGf6XyS3WC4lVbfwzL6ycJhTKI6VtHFeVUyZdtfj894pYfXxbamX0mpLtxCKMaU
         TEz3RYxux2NrqPkqlarpBD/WZrE9eJ9TyKnDcbxo61DzhQ5f961SNAlhMEIa146MC5lr
         N60MejfGNCnu9ZTOaFA/sgivpRGUcy2fbG9DWpvNkZEv8Y47lH7QdDoECXiGE8vvlUEh
         DUOp2zKGZ5NsGPG6UATNyJGJPASqzCAog8HOyGGZTVZQZaDpEOAwc/9n103P8l+GV54e
         BnPvbmfsiKwn2wcbAcxfL7oVV43oEsq1ObPSb5KgjPKr7g6uoTW4DoP/xjnA3B1YAbA9
         2k8A==
X-Gm-Message-State: AOJu0Yz+phoQcGRBV7C0nkFGxVhcclSZ5v6O5HWFY9P6sAvZ/i+rzDzC
	WJC9IjUwvLjpFIzEHizup0ZlgsqnGaw5V+fDpS4pkoFT+/nQoeaS6y15aSCq7tkNMPTb6kbpgsk
	5qLYslA106A==
X-Received: from qkld10.prod.google.com ([2002:a05:620a:136a:b0:8cf:d0b8:9bfd])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:442c:b0:5ff:cb2c:a04c
 with SMTP id ada2fe7eead31-605a4cc1e5dmr10588809137.1.1775746896355; Thu, 09
 Apr 2026 08:01:36 -0700 (PDT)
Date: Thu,  9 Apr 2026 15:01:23 +0000
In-Reply-To: <20260409150123.3538444-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409150123.3538444-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409150123.3538444-2-jmoroni@google.com>
Subject: [PATCH 2/2] PCI/P2PDMA: Add Google SoCs to the P2P DMA host bridge list
From: Jacob Moroni <jmoroni@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	David Hu <xuehaohu@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"

All Google SoCs support p2p between root ports, so add a wildcard
rule to the host bridge list.

Tested-by: David Hu <xuehaohu@google.com>
Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/pci/p2pdma.c    | 2 ++
 include/linux/pci_ids.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 25e9358d0..7c898542a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -548,6 +548,8 @@ static const struct pci_p2pdma_whitelist_entry {
 	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
 	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
 	{PCI_VENDOR_ID_INTEL,	0x09a2, 0},
+	/* Google SoCs. */
+	{PCI_VENDOR_ID_GOOGLE,	PCI_ANY_ID, 0},
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 406abf629..24cb42f66 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2586,6 +2586,8 @@
 
 #define PCI_VENDOR_ID_AZWAVE		0x1a3b
 
+#define PCI_VENDOR_ID_GOOGLE		0x1ae0
+
 #define PCI_VENDOR_ID_REDHAT_QUMRANET    0x1af4
 #define PCI_SUBVENDOR_ID_REDHAT_QUMRANET 0x1af4
 #define PCI_SUBDEVICE_ID_QEMU            0x1100
-- 
2.53.0.1213.gd9a14994de-goog

