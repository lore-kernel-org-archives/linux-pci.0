Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961624772B4
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308354; cv=none; b=NvkRzYzHGsYNJEhTt3o5txYIboViDny25KBLNrQ2/Hu/BqXlrPVQRarSf01PNxDFrsx3goaWyW4zFrebzzsg2Dk2dZqY66zX8H6df/fueui8idH5fy8TkRWbX9gg8tQOdYlLl3nrseu/9ABQcM+6OXaZYBnyhCRZFcuVo7vmQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308354; c=relaxed/simple;
	bh=DEtnr+b9HaHk7PxBKBvVrNRgKvE2vE7tn4UqesELAjU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S41yX1FEQrJP5WXjdus+QrplyR2aRR17XjhOAP5oIDYH7JqsuydjgSYrrQ74Hpl2C0+JcI8N48AR4pQalVtJlpfrydWoYuGDXKCUzeb82qzGXVhDq2x8Q0tCQjaKdmD5b2tBJbONWS4ioS1ca64fmeXCnSqjPNtFQSPJ+LAKfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gWua+S9W; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWua+S9W"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb48f41343aso1651914a12.1
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 03:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787308342; x=1787913142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3dhvNT9qqCp6MpIDTd8WAvQoo9257Xa/PWTZDK4wnb8=;
        b=gWua+S9WgIqBvoSntp/MeEDbMpoaATMy1hSQMwrtCJNr6NgG8AD7QsYR9At4i5qKso
         0tGLS9OsVTd12PYWSTVCScu+3THuaGr9ZsI9QQi2ERLA78EJvjWSHlthKHAk8MLjZkv/
         2T3BureSCukEsYz5S1SgTm2x7cP2ZcY/FQgmb8seaTfVyybp115OlezL1JZuKgv7tlQQ
         S9oe2D6GDKqy8UQijDwhA3n/mQ8L6HEYYNKNbR/KCYwKl+DALcL3HovuyhMNANtzKNve
         SSopkYpv3S17Nj0bphPSrNberUWi1JSyLCnvA0PylDyqDp7eymdBgXnBYdYF6v3pCV8q
         lqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787308342; x=1787913142;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dhvNT9qqCp6MpIDTd8WAvQoo9257Xa/PWTZDK4wnb8=;
        b=N60/Hq0T1A8alv+/b/M/rzsqn7YaVvmNtClFhPWCZU5AQCWB0uOuum3+z1P8C3RwLD
         HTXAAtypH0UnjMn4W061UTDtaJUcCYS8rS53/1DW4gWgoAGe74qKRpw8ihHs/DFJD+Ew
         6eUB7RJIHXeQUtEOF9+5zp4lxBEGY0woVaQ3sM9X0rKN7Df9/Xutcn+3aLzUZvVidYnB
         mbkNE31WWZqa/XeSJaUm6aldLOMRjBz4h2b67ZulCzZdk4m+if4cOku9mNYuOzmNEHz8
         Si8RYuGkGpgmUaK6DF7GpG/nRTTIGRiKN0e2F6t+Dgog0mbnWZQmGoMCoOH0uUszk4QW
         Cyww==
X-Gm-Message-State: AOJu0YwyIju5+WmkN2zNH0gFS/L2PLvFhPUNK4EzccjnIeYPpYyMDU2+
	nPhhusvkqwQONBP3l+5Dp5SLP+0HnsrB7L9ywWgEnG6qNbjObB94nPZAYHyjpKKrjih6TcFnA44
	BTSyj7DgEmlCnGPEzxXkyTvwtVXvMwA==
X-Received: from pgnb1.prod.google.com ([2002:a63:7141:0:b0:cc1:58f8:d2e7])
 (user=aniketmaurya job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:d49a:b0:3c3:750f:3cf9 with SMTP id adf61e73a8af0-3cd14f226bamr18992470637.11.1787308342414;
 Fri, 21 Aug 2026 03:32:22 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:32:14 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260821103214.2049218-1-aniketmaurya@google.com>
Subject: [PATCH] PCI/ASPM: Clear L1SS capability when L1 latency is unacceptable
From: Aniket <aniketmaurya@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Manu Gautam <manugautam@google.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, Aniket Maurya <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Aniket Maurya <aniketmaurya@google.com>

pcie_aspm_cap_init() initializes link->aspm_capable from
link->aspm_support, which includes PCIE_LINK_STATE_L1SS (L1.1, L1.2, etc.)
if supported by both ends of the link.

pcie_aspm_check_latency() then evaluates whether the exit latency of the
link exceeds the acceptable L1 latency advertised by downstream endpoints.
If the latency is unacceptable, it clears PCIE_LINK_STATE_L1 from
link->aspm_capable. However, it does not clear PCIE_LINK_STATE_L1SS.

L1 PM Substates are substates of L1 and require
L1 to be supported and enabled. If L1 is not capable due to unacceptable
exit latency, L1 PM Substates cannot be supported either.

Leaving PCIE_LINK_STATE_L1SS set in link->aspm_capable when L1 is not
capable causes:
1) aspm_ctrl_attrs_are_visible() to expose L1SS sysfs control files
   (e.g., l1_1_aspm, l1_2_aspm) even though the link cannot use L1/L1SS.
2) pcie_config_aspm_link() to unnecessarily invoke pcie_config_aspm_l1ss()
   during ASPM configuration.

Clear PCIE_LINK_STATE_L1SS along with PCIE_LINK_STATE_L1 from
link->aspm_capable when L1 exit latency is unacceptable.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/pci/pcie/aspm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 172783e7f519..38eb7b1e2377 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -666,7 +666,8 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		latency = max_t(u32, latency_up_l1, latency_dw_l1);
 		if ((link->aspm_capable & PCIE_LINK_STATE_L1) &&
 		    (latency + l1_switch_latency > acceptable_l1))
-			link->aspm_capable &= ~PCIE_LINK_STATE_L1;
+			link->aspm_capable &= ~(PCIE_LINK_STATE_L1 |
+						PCIE_LINK_STATE_L1SS);
 		l1_switch_latency += NSEC_PER_USEC;
 
 		link = link->parent;
-- 
2.55.0.766.g2966f0265a-goog

