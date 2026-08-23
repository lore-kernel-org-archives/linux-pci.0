Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1236938D419
	for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510111; cv=none; b=cTWSkkxKIekMb2d5nW51qn6j05sKuqNZcmhEc7Cn0GA53/cuPJy4PRFw4wxE3KkysYURzN2ozrYegpU9tgFTLEsCHSx5euCTEgHVBo+T9i2btyGI/WnRYtjAnouv3U9qlMi02ODt/QV8ZtdsDO4y9GTAQlP/RDgoVIFwHIzmsrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510111; c=relaxed/simple;
	bh=55H5C1Vn6kHJjAVaTokSUMg7w44PdxhSFTQ7W1a0KgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUJAvqpxHAVKqOBQH8C+wLq1MUeVJo2pSdik8cPzJcCsxjwO0RPhTZb97WXbsW4r7HP7I0cC444DWGlw379m1UyWyYUsDSmpaJR709ljgFaLO0buaETxMaTZVBfW3R3cvVw9KSyQj9HXspYGt+JQRAWPyHofQfGWsPofumoACX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snWFRohS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snWFRohS"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c167aa9500dso408479466b.3
        for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2026 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787510108; x=1788114908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x1CGqHxj1gYluvAoTnY/OZsvt6mzgTLD3jk4hAmnXP4=;
        b=snWFRohScMQ6ftM/z0LHU+/YhQUBTXOmkEXTk7BtrHX6Gqhg5XY0+WPH2tQ7fkG5eG
         CRb1ifskkqlqdzQYGNeDGDPEhkLC6AADpccYIugSu3q8JqencwWQYGnUXe/Qthl1ErAM
         z5F88WDfuDKeGcOsf/lIkpntuB/fsJ1MoB01NsSXVOWY8nloznChHkggippdrtkwLBE1
         9VXD0B2nBivkQsHt7lWXFNZzAg+V8ugwQdBPD5KZxz0fYizuTxwQl276u0i7jjXuXmi/
         I7U2XFp7elRJhljizFEYW6xPvA2BC53oVBcxvWhEXkX6wmfXExtReK1BiZJGK0p3Aqzx
         X6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787510108; x=1788114908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x1CGqHxj1gYluvAoTnY/OZsvt6mzgTLD3jk4hAmnXP4=;
        b=IqiRJiOrFl/WQ6kkrZZPDwfw9x3d40PwoDXAe37XPvSxHW7Wk/9TsRxXFN3PM0wpAP
         KaNmJvSe491BYKqi0cnDNaRD9h/ROc/Shfdu0lCB6pRtKPrMLvKDap5jNKUli72ooVR/
         nmw/j9/b2jf7LyUFSZtS17Kha3qtU/bevu4XQNRzA0OoCN5mrQh+UgCQwrA7i8CfYGzy
         S9R1i7IIytJPt/BXqSDV+IoIufZVK0HWyekmgwk85ZrPGxw01w9oo6KKmmFnRsUJ1aHK
         vaAXIRSaafYNmoqDCPum2iUMEypLlsuFv3M2w092DGhczxDud2J1bOGJ//YlZ/GcHxrQ
         FjOQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJLT5Yyec0BmCva87jubk8XU3nRB8qfaX2WH9s0vYOnWvbKEXOB2/xi9tQOjElHx1TZg29jqPQpI0=@vger.kernel.org
X-Gm-Message-State: AFuF++mQXaCJ53I5vW339lBnMVzrqgzqj5kGpKEITauWo3ukquBCH8bW
	Lr1zbDUU+daAKMtbuy9RGVf2T01T93WIlRDoHPL7wi/y9HDNL3uIJXUj
X-Gm-Gg: AR+sD129kWQ+xyZ60KXo6ctHeilh1yPz7bSDn+fgWmd37bVluVEaWuBqN6cPXjALXje
	KyEN8pIqeoV7J9kQKgSb2zSVJqRDaCaJRfSVFQcXfMAnE9iH6jAVE2JkFRESPoIHDH9veqtrFUs
	Xq8rxo2FU+CK8QiSmPH96R+PCXlAfFXT8pAm5BRI9vih5MQXZn/zkLZNw5rQeUHCHiJ/Ldp86xG
	JIVrFyynx1bCXrxPeG3U1TWKjOb/Q2XuIVSnrJzBEy6n+9GdOcgcJD88USObjhbwG9nXQhttLQb
	gqB/gNQU+4qLdouJO/uYLLSU83v1iuSt3HiMWZg9TFCLjte/iCVr0Pkp9Tl1e+1wWZYHUEYmy5w
	HHSK/cf9EBUK7Uj/N4xSYAXPyjRbOlIbbRHhr8XgwczJbQRmNwg206pyysMPeam0RyfHNAOLmUh
	ryJRU/R4BSZOItaYUPiOPLXJ57bH9G59Sev/tl3jjdxa3O4tlKtlUPF2gU3e4rLID0fZVqc3Pc8
	0L2kJKnOE1qaVaG2AYnKEzyeePJvu6RVYWM3fR/CpggekeWiOqLYzMi1U0dwulIEg==
X-Received: by 2002:a17:906:b286:b0:c21:752f:c44e with SMTP id a640c23a62f3a-c246a67492cmr1878483566b.16.1787510108329;
        Sun, 23 Aug 2026 11:35:08 -0700 (PDT)
Received: from 1c44f78ca37e.fritz.box (dynamic-002-214-002-133.2.214.pool.telefonica.de. [2.214.2.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bbea6sm805385066b.27.2026.08.23.11.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 11:35:07 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: lukas@wunner.de,
	mst@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	stefanha@redhat.com,
	parav@nvidia.com,
	axboe@kernel.dk,
	kees@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	xueshuai@linux.alibaba.com,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC 2/3] pciehp: add disconnect_work work_struct
Date: Sun, 23 Aug 2026 18:34:54 +0000
Message-ID: <20260823183458.982699-3-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260823183458.982699-1-abhinjoses@gmail.com>
References: <cover.1752094439.git.mst@redhat.com>
 <20260823183458.982699-1-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- This work_struct is used to dispatch disconnect events directly from the pciehp_isr, as we cannot wait in pciehp_isr

Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
---
 drivers/pci/hotplug/pciehp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb..c8ceb9320e2e 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -116,6 +116,7 @@ struct controller {
 	unsigned int ist_running;
 	int request_result;
 	wait_queue_head_t requester;
+	struct work_struct disconnect_work;
 };
 
 /**
-- 
2.51.1

