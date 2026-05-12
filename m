Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DA8274B3B
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611737; cv=none; b=JpSlfd+PRNpyYnMPaMPjq/O/XiHnGkmJtXhMPS8mh1lSaSIscanUFonNkQ4OuHdZGNoknsvrtKp28BSKOZdKf7tYTiyd6CHq8s7Agmq8ue62zsgpVN6RaM+baqHgPHs8pjTzJzMr+vUVfCr0nNGhlmA/WWZQSq3hb2prKzEVMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611737; c=relaxed/simple;
	bh=kXFrFswYpEL709FjOymCy/isLgjgU2/Se8PexxdvCK0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Or+Qm+OPqAI+Q8ZFGffOeDFIbtiqtX/cFZq3GZKy3B63DmJgIRlmzZJnRi9MkX6z68q7FD4uQCFzTBe93EukBnVPCbwtHcxSuSRh+rdwpOb5Hms/v9UaZPmVCtTcVhG9cn4ABE9FHW0ncJSb9urkT+Czw4A3DFrHxRKI/4qKOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=leImKQ89; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="leImKQ89"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f85179263so6805503b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611734; x=1779216534; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OwTVELbnzNRdH2phaBPDBaeaYhhwivLmx4DuUtuYrYk=;
        b=leImKQ89xI/NJC3L6+23r0qhf3e1kPMK7qX9zM6fUw8taOzNi4lEZ+MIztjrS6qSrV
         hn6M2NeYQr6QUV8yWA0xJK6HsknY7Ex85Rs6bIlaX3ZgrDA4BZx8Z17fY5a7yqGfbp1q
         EWQgYtbTmwX4vdL3ddgyX4BMAkq55eyCPk7Y6H3nFTrIF/+evgu/UufhrPJuBxLfTTEq
         xLf0ObKsrKXZo42B/XuMQ0A1u2IWosZDqrgrkoLOa2TgpK6fJ95ro+M/RkeLOBldBBLm
         j6yTrGdST+igwBPuzy/XTH5ZL0+fRO/etB75LEtOhOm5KQs6Vkh5CmPk+Pcx57XEoeEe
         hIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611734; x=1779216534;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwTVELbnzNRdH2phaBPDBaeaYhhwivLmx4DuUtuYrYk=;
        b=lTjK8Z/Ndpv3GBT6OP1DiTtzIg17iLeZwB8RUTXOIhbeAjY/YbVDBY3nAHrGT1QyHo
         +hby/Ybjt5ARNyyo5Gz68b4PCBEGJPWn6m1CaQAVSuRFL+mGYi28F87CKolCSIUCB/RH
         xxrVmAwLctmY7y3604xkOzZsKzqgO0EKHu2kXeyhvRpNXxCvsxambYM1Ke2CeLvJnObz
         V5nJd4eDryaOhiRzMBM+jbrKEGj0ssrN6QI+0Tz4nz5ygMAYF8D03TzqyDsOLIIjotZW
         +X5dZcHORdPLavWhSYS0BZqpojm+AwKdS8gj6hCUhx1l3AS//zrX5Un5WQZltKzAJsl7
         FcHA==
X-Forwarded-Encrypted: i=1; AFNElJ81ZjZWSoDFtTD5czKBoc5QyUQmip7K91FQ5TQcgAd0drMJi5glqw9y7RwCXmlPiRTh+cOn3GpBjlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpX4XN5HdSk6RQNE7XAoVoXXlnQrk5pPSbVatOEiB42iYrB8f
	UHuFJh12EahyA5el2w2B8e6sOwzdsU0XkvXXdmsw2TgWiR6RQxhuCpgQoEMAqA3UWhNsWqs5l+n
	ZCvxiImjIwXiItw==
X-Received: from pfbfw6.prod.google.com ([2002:a05:6a00:61c6:b0:83e:c864:caf2])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e83:b0:835:405a:7e62 with SMTP id d2e1a72fcca58-83eebe71c57mr4745750b3a.33.1778611734335;
 Tue, 12 May 2026 11:48:54 -0700 (PDT)
Date: Tue, 12 May 2026 18:48:39 +0000
In-Reply-To: <20260512184846.119396-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512184846.119396-1-dmatlack@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512184846.119396-5-dmatlack@google.com>
Subject: [PATCH v5 04/11] PCI: liveupdate: Document driver binding responsibilities
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

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/liveupdate.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index f14396dd1477..d77e64906a25 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -77,6 +77,22 @@
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
+ * bound to driver B in the incoming kernel.
  */
 
 #define pr_fmt(fmt) "PCI: liveupdate: " fmt
-- 
2.54.0.563.g4f69b47b94-goog

