Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF73A8FE1
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190553; cv=none; b=Rpnv2QcdTT1uwwUkwfDG8/+INEB/SWNecXHxouXDXJPC4nQ+cGMpTtXUlNvchVUZuDsY4S/Y8QCjrOIyTVEsZf3zcdw/7XW8QpB3mYcHkCBi7Hzbt9KctPgqs4Dqn3A3/sGgi3rY48CUDQXGAB2asROABByPfKIAzJk3dEm451w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190553; c=relaxed/simple;
	bh=dOOuhz0gbslsD4ST8T90RiWeq/7Jv/QR4cCMBYVI1hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smRcS7DpX/7LeIMvn0QgDAC6I7Ui4zn3opljJZknNwB1wMJSGMFiTUWZrPZ6duTieGwoo09hqYrCPA/Ua52/CeXlcDHEXsMDqKhUVYSBCVByi3up4lwTHy1FFBqjmfFuwP+GIdj/TtfKSbvxL5DK7bMflkPGfr+w/2gQ/Mmq3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5g7aXWG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5g7aXWG"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so3621740a91.1
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 21:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782190552; x=1782795352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFkOkaN8XWyxvc+VzvECi+ZxhC9H35TOQHN9OYiWt/E=;
        b=c5g7aXWG6OnkRxu7j/T0CXq7snxW9d0lWuLsrpRhsp5tZua8CXoToHbdtlJaUGIKyu
         XXwSUTgRIcHpy2vEe6ivFPM+IJohQwAMP9VokzBwrUEsdPkUNjGF0DW6Xiumz4krKmyD
         oGcBU78604WZkviApyN+DTVSmFHm7XO6mYJXUBQubET5EZwKUSZNlocUzLOAFIwK3A4/
         JWBk/EEaHg1G+d4IHFCnm5kwiDkf0x15k7gBeMdpT7tPvFIk04ADvinFc4T9rAHG3c4X
         0M2gnX4jQc52aleKN8NazNjh4CD0/YqLhha2WqRWriHnAXIvy7Z49p+juCXztix8TvxT
         05YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782190552; x=1782795352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RFkOkaN8XWyxvc+VzvECi+ZxhC9H35TOQHN9OYiWt/E=;
        b=MTgvVJnmoskDmN9cEjqfvBbqssyCj9+ChO/SQXnINzCoDYNjJblgXiDeVwxnJBNYup
         f24yWnuDAvbVYNiTBQmPsujyTqvASK5zfLFuHBCH5o1f1E6rwX/RtyvEg5gM6EWBo7Jb
         HfAf9o3X/RlaVXNuY62WtbIZ1xnS9Ut6obwgsj8EReozhpu3tAAcZEUpOa+Xt4DTa+I+
         fTM/tyJpy26XTo1Cnsp6/3mQxfrNhe4RnzxF46d9v5jDYcY8Q8tAVDh2xZkAh9PlbS0K
         hQKYVDgltK11jVMpwn3WOt4POx9WIq90U/0wQldBBPqkuJayUe0zNYF0xen8zPI3B2Qy
         hmSA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4Az1oVhJSgt051Mp90g5p5P9m4C13PhKwW66LxvQ/T+OwNYBCIj7z7zqzjcbwzmFq/WvskP4YbZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTGbn/bfb1MjhENtUN94Gd/5qJ5eDcvQeexIhQy5oBIOzrFWhm
	L3o6a4oukhPAu/sZy6YeKwrTB7ROJvJrRHCPxGP0rBIkoIRYz7xWp1dT
X-Gm-Gg: AfdE7cmlShPMBaEcnykHIeJ5UZ5BWXrAmXK6RYiJ4cgXShV6Xb8+cf1etKiirmYduaC
	J6E1+WIpJ1YvMP5na7hF8ronzfTlshXwalZgDW7l6uqAB8k6c3/tUFEyoAdM2EPT4TUGU9wja2D
	lRtjv/OCneFeBnyyq0DrSuvVB5uzCE2X0UtG6e/5ZIyRxSeuomlZOGEH2Qo27UkVo+we2dJYmAl
	RY95VkAvMALdP7Xw6GIPFtAmRZUmuyRKhe8Ny/GHAmlbsAAJDUfl32zC4oLW+fc0kc7slwNM8Y2
	S2KWp99Kx56Uog0c5PQC+pr6OKWhof+WVM26JlLob5oC/YuiVkZ1Uo01y5eG/ssE7vEAbcLQOYC
	3nyJHZYe9mcuNWEvp4ZjK7ZbpLeyyUByfik/ydv5fI0YiyjMKvHb0oWkzAjVHwjWnd1ZXb9pLuC
	2kSlcMpNCUKcn7tPFmlQ/IncD4Sz4LCOyzpxgRX+cF
X-Received: by 2002:a17:903:32d2:b0:2b2:ec46:dfed with SMTP id d9443c01a7336-2c742b5ae34mr136450075ad.31.1782190552159;
        Mon, 22 Jun 2026 21:55:52 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8cf0sm89734785ad.50.2026.06.22.21.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 21:55:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: akpm@linux-foundation.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	lukas@wunner.de,
	alistair@alistair23.me,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com
Cc: alistair23@gmail.com,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	tmgross@umich.edu,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 11/21] PCI/TSM: Support connecting to PCIe CMA devices
Date: Tue, 23 Jun 2026 14:53:56 +1000
Message-ID: <20260623045406.2589547-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623045406.2589547-1-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

In the next patch we are going to add a PCIe CMA TSM driver, as such we
need to ensure that is_pci_tsm_host() will allow us to connect to CMA
capable devices. These devices don't necessarily has DEVCAP_TEE or IDE
support.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/linux/pci-tsm.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 950e2c36a4ca..80e76ecefe71 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -3,6 +3,7 @@
 #define __PCI_TSM_H
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/sockptr.h>
 
 struct pci_tsm;
@@ -130,7 +131,7 @@ struct pci_tsm_host {
 	struct pci_doe_mb *doe_mb;
 };
 
-/* physical function0 and capable of 'connect' */
+/* device is a TSM host and capable of 'connect' */
 static inline bool is_pci_tsm_host(struct pci_dev *pdev)
 {
 	if (!pdev)
@@ -142,6 +143,14 @@ static inline bool is_pci_tsm_host(struct pci_dev *pdev)
 	if (pdev->is_virtfn)
 		return false;
 
+	/*
+	 * Report capable if CMA is supported, which can be supported on any PCIe
+	 * device.
+	 */
+	if (pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+				 PCI_DOE_FEATURE_CMA))
+		return true;
+
 	/*
 	 * Allow for a Device Security Manager (DSM) associated with function0
 	 * of an Endpoint to coordinate TDISP requests for other functions
-- 
2.54.0

