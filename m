Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0513BB12D
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718789; cv=none; b=tHFADY+HqVyJw6ddr+k2fjGceZhXqGgBb+n5lnQalECpINsmcjVBslc4Aw9VdWMkUqkVXbT3TngGW9Wmw2annExOfWaKHeX1f1JuBKqObC79gLTu3JWOOsO8CmXmI7nUAgZjkUQvDrTh51a27tueHcjmgCSxWh9tE24HL7Sp4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718789; c=relaxed/simple;
	bh=SLWJxUiNoHAtZnCZfKjICsopCm149nKp65AomgWi7OE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RQM1sqtAAapj38LmnQQFaXcefoda2QAd/WSAgKmwI/NWNggTTIcyY7GKQbBfPcxs9UJrArZiKWcbvS+Aust89o8yUCK2R4zO394sbcDrqCXGxDcFxG3O+j5rNtOEoT0UnswHfGO6qKpet51Vk1guJeTFA/IENs25WmS7LKaZIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNKErh0j; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNKErh0j"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1215843a12.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 14:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783718787; x=1784323587; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YGoZNXB/ZYxw+GyFT2bV+z2qLaGl3Mol8FyZ542tK3Y=;
        b=RNKErh0jJBlNC3kxoddKs1dJ57CXNnIHSoEcUQROY2oG4vButRCQlwhoA9iaFyAvrx
         9iXvR37eWrJRO2YKTxB+TAfCfFonBrLYMwN3n/KQfrOfoRAIejwEPbsyJfGZTP63EF0V
         yAFyLxUTQwDaRG9KChpQ0YJrvVpgkHzfnXJ/YH7P3YhuVFKAvvOwfs+psrvT+pDXXcJd
         YdpbZznmWjvvytd0tnrsX+o9ZjyBO4VuCk+MmYnm8tBi4aRH61/AARoXJEL3gbYPjUuD
         inhL9I3wA+XWGJOSXuruNHITsUcX6eg8Y4rE/EeSMdGTFJuTsGvV9ClnSTiTLoggRQ3x
         bxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718787; x=1784323587;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YGoZNXB/ZYxw+GyFT2bV+z2qLaGl3Mol8FyZ542tK3Y=;
        b=e5pCEymsh8X8Em4Lg0c/PhrekJPbvCgObZ0PwA0X+Bmvj3d+tlB7OfDbl3iOYaFqp4
         Z9NiK05WXvAOcg/qx1WR6Uwcy3U9v9oBCoBbI9NUVJGpHtCmRZLVV3VRwOthJwTEPDVh
         MZYe9hegb+nyBmqrXSf00bLQB46IppBX9fdPxR782p45HjVTn27gQCCs/iwPxrpIvR1H
         nX/zInwf9Z+kRf7rcQMDvazaLTRbU8u6Jl2okcBZr6SlucGmqkNn+PD7WZrfBbUv8bnM
         7EavqWW5e8cghBOhN1O7iOsJr7c+PIx8+7ZNsOyVaUylmXE/2iP6hHXnWckqLtuTvQKd
         Ar5g==
X-Forwarded-Encrypted: i=1; AHgh+RrDjb+NO+XOVFMWX4QREeRx5nB1irzekWifHtW8yqs3BuxKFChUAZuUpv7gi3jAVJDF9A9E0mwFuqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQEmj39MtBeHKJ8P9V0bF9Ja/ww3CceepYzbnkpQh2TjVKeJZ
	jE78T/2jjkdmhGptkG+KR8UdRzdRur7DeiIOIxycCmugR0ObLxJo/WVEjy6fKQ6h5sV1Zuzw9uS
	OUX/PhhJ+S77RaA==
X-Received: from pghx9.prod.google.com ([2002:a63:f709:0:b0:c85:c772:c6a5])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:4304:b0:3bf:bde7:d671 with SMTP id adf61e73a8af0-3c11060a6cbmr641192637.20.1783718786556;
 Fri, 10 Jul 2026 14:26:26 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:26:07 +0000
In-Reply-To: <20260710212616.1351130-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710212616.1351130-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260710212616.1351130-5-dmatlack@google.com>
Subject: [PATCH v7 04/12] PCI: liveupdate: Document driver binding responsibilities
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Document how driver binding works during a Live Update and what the PCI
core expects of drivers and users. Note that this is only a description
of the current division of responsibilities. These can change in the
future if we decide.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index df6a02240aa4..a067632e70d1 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -70,6 +70,22 @@
  * preserved. These may be relaxed in the future:
  *
  *  * The device cannot be a Virtual Function (VF).
+ *
+ * Driver Binding
+ * ==============
+ *
+ * In the outgoing kernel, it is the driver's responsibility to ensure that it
+ * does not release a device between pci_liveupdate_preserve() and
+ * pci_liveupdate_unpreserve().
+ *
+ * In the incoming kernel, it is the driver's responsibility to ensure that it
+ * does not release a preserved device between probe() and
+ * pci_liveupdate_finish().
+ *
+ * It is the user's responsibility to ensure that incoming preserved devices are
+ * bound to the correct driver. i.e. The PCI core does not protect against a
+ * device getting preserved by driver A in the outgoing kernel and then getting
+ * bound to driver B in the incoming kernel. This may change in the future.
  */
 
 #define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt
-- 
2.55.0.795.g602f6c329a-goog

