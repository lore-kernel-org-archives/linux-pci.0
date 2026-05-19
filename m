Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48D229B12
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156272; cv=none; b=WV5Kv+uOzNaDVxPukGFF6jbwCRRxSnfkOKPHpY5hvk9S5TPRKsCnek05SEqmOuDSxhyBZ9fnr7MqM/FN8EMbRBcJaL4mjI01ELfGHKKjVegvoU2mQkJZJIoChAIswE9zX1y9ofMpfep+N1YVRntv77wsFq9ec0K+k9UtX89kbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156272; c=relaxed/simple;
	bh=mtDxrH2ML3rAfUA3/UHiz5Sy+Zdm7oLZPzmLm6Pwbg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iwnfAlhQ1L9BUK7raWEeW+5XWB9gACckO+v9ghYjVUK3/bCZW1GVaUQGQu8p8dKJdS2V8kiAPQxkNeIAZnstaZlZ299Lj04reeIGW3aqiH7piXgmxesfmOIdLBUQ0e/IQhDRkRx4FfylApJouNIxFR0eilR0+RFgfmtvvDzD+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FS8oQZ4/; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS8oQZ4/"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8c92737a8d3so19091966d6.1
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 19:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779156270; x=1779761070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BblohSwa0klbNckZW/zVf9pvlxoTC17ivxwsp6TLmWQ=;
        b=FS8oQZ4/Os6a7gGM1e1wyVTG98P0Y7CyMcJ+hv2mYoDkM8ycLRG9X+LYAv35pixj5a
         0Iv8SJrciam2PLYt51iRF2Jd4JYeh+28C0kWZQA+u2sXNttI1xlR6nPsts5voi7VFrWK
         /Rh0GgnIxCDKj85eA7L1KdvWvx0Zbtb0k4wmfeKOildfEOI8DKNBFdBronnBTl0DL+DA
         GKo6ypl0WP2pFT2wgUsxWbTbZ8d6d9Tnq1QRQCUTD8JrMin0vAosMp/ZHMqwi+u7/VeS
         WSOO6JNT25vZcw+sE10vf0ZLBZudEgInGeP5x43dblO0vS0kRRqLj2GA3PUnItMgpmVf
         cbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779156270; x=1779761070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BblohSwa0klbNckZW/zVf9pvlxoTC17ivxwsp6TLmWQ=;
        b=rFwlPPHakFlm/1RR/nl51gS+Xn4Hldum+2sHWuFK0rVwiKjiV6GqmITsmIoIk3JVvz
         IqYCOc4WKfrK0fHW8NoUZe0uaUVi4Nuz3/WfOqEiOG+sOkqrmSR+0jeEgmnDQH58MFxg
         EJp1oEIAV8rWPSiDZm6JO+n6DkreYCZBHj6ig/1emEglAV/2+qSTBgCbbA6NrIv+X3wH
         XiI4YA8Z4oLwNa1wWP4TenAzz6LEU9SO5+yBAtw8l2umrhEzhTAzKVe+zSDKMYBOYdHM
         psMxIrIDhp7Vu37F+UjwEUu9YYpJcTg0rQfWC5cc33+kfpkVDscqXv1Ttc8ss5e1IwKo
         IdVw==
X-Gm-Message-State: AOJu0Yw6jIHUG0sSpw23dnNX+Sl5ybVF49ec6NXLhbBKhTyQqKOEfSH+
	UEFnemuBirA7F3WHfr2/6wXdsGzi+iYwalHo3YLfDFoatEQqPnfU7pKniGQhnc6G
X-Gm-Gg: Acq92OFHt7/1I/JtSvH3CzoMd19VLTLwS8t24qSum9HMsakVXZ6/f+20BzlwapcjRlN
	CKo3zUTEqW03oKW9Ntxl/d9cn53RntZ5n4cM+Er9UQBZUka+/WFMRT1o2Q7p6wfuFsNI4GQIkiw
	HRAK7/WQT5Mgf1OOrDdyE4F4Roa1fCu5pzgij6Mw0w/QmUjMM0IJItvtrGlwF07b/D/HLpzV5Ed
	2qOn6vhXhrHxai9GcWM3Al98/3HwSViXGsHk5idhhVj475jwIFbugiiVA/zWx2Tu+I3HIqTMqBQ
	Nnj86uqweSUFXXtn2ddckpE79hvPHdSoeHhhAMHwWrisaLt4+uwjmSDXD2S95PZOFG1qnY78Q5d
	+BxCPzzQcud3j50MixPE08241Ic+CtlvcZ59g0NBlVmguQ2S8vlp0Ihv8B1TnRBwnIC6/m63lCj
	H857fyd4jwChE6JPMDMn0grHyQkLLTSS++hN+X9tx4aa6KjLGRk0QkztWcv7InEjaOOW+7XZVHH
	66S9TdFjc7aEEmEWEImpc10qoCaed3dp1dIERnkUPeqhA==
X-Received: by 2002:a05:6214:478e:b0:8a0:4e92:c45f with SMTP id 6a1803df08f44-8ca0f5dcfbamr258372956d6.11.1779156269964;
        Mon, 18 May 2026 19:04:29 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3609784bsm75066726d6.16.2026.05.18.19.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 19:04:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: ibmphp: remove unused variable
Date: Mon, 18 May 2026 19:04:11 -0700
Message-ID: <20260519020411.635150-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rc is set but not used. Found with W=1.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pci/hotplug/ibmphp_hpc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
index 2324167656a6..bb9149798428 100644
--- a/drivers/pci/hotplug/ibmphp_hpc.c
+++ b/drivers/pci/hotplug/ibmphp_hpc.c
@@ -786,7 +786,6 @@ static int poll_hpc(void *data)
 {
 	struct slot myslot;
 	struct slot *pslot = NULL;
-	int rc;
 	int poll_state = POLL_LATCH_REGISTER;
 	u8 oldlatchlow = 0x00;
 	u8 curlatchlow = 0x00;
@@ -810,7 +809,7 @@ static int poll_hpc(void *data)
 				if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
 					ctrl_count++;
 					if (READ_SLOT_LATCH(pslot->ctrl)) {
-						rc = ibmphp_hpc_readslot(pslot,
+						ibmphp_hpc_readslot(pslot,
 									  READ_SLOTLATCHLOWREG,
 									  &curlatchlow);
 						if (oldlatchlow != curlatchlow)
@@ -829,7 +828,7 @@ static int poll_hpc(void *data)
 				// make a copy of the old status
 				memcpy((void *) &myslot, (void *) pslot,
 					sizeof(struct slot));
-				rc = ibmphp_hpc_readslot(pslot, READ_ALLSTAT, NULL);
+				ibmphp_hpc_readslot(pslot, READ_ALLSTAT, NULL);
 				if ((myslot.status != pslot->status)
 				    || (myslot.ext_status != pslot->ext_status))
 					process_changeinstatus(pslot, &myslot);
@@ -842,7 +841,7 @@ static int poll_hpc(void *data)
 				if (pslot->ctrl->ctlr_relative_id == ctrl_count) {
 					ctrl_count++;
 					if (READ_SLOT_LATCH(pslot->ctrl))
-						rc = ibmphp_hpc_readslot(pslot,
+						ibmphp_hpc_readslot(pslot,
 									  READ_SLOTLATCHLOWREG,
 									  &curlatchlow);
 				}
-- 
2.54.0

