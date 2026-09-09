Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ECD38DC7A
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975233; cv=none; b=hTxWrWWHhfxY5TwG/wP3Vs82Z3jraXNX/ebRif4ofhe0ALNmA6MDNdT0eI3ekRHcPOlYIZ+WQjzxfgLCX0oUhDywexPHTh5+raQWdz4ZbVscJr4Ff5thgMC3c5h+Q0ur/HFzYdb3wkXpbvyNJ5NrSYJCAuYQ/R51pThae6lCvwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975233; c=relaxed/simple;
	bh=9u+KwAb1TPcFPVuhKhGmv1E5ZeXisuF3FsqOK0m16pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=trleKPPvz3BlrYTzUaVbqzX0Coa02TTxR5iy8CW0uH4LZaKKRITZaKHugcOZTOQ03qyqpkjbvv8o6V+mazsiPrMvZtU6W1VZtftyQOqy+PsLF1YINckmhKOIyxnlWpG/44pyQ60KPmgtvuERyy10LTDQjc8HSRz8Vo1DPTLePMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI+FnjZm; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI+FnjZm"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6bd07679624so1805134eaf.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788975229; x=1789580029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aRf99SMBmtl+VTLk0zBUOwJpiJLfRXga4UGT3MjWHTQ=;
        b=BI+FnjZmDneBYigR25MjdRJqjT82N3DMxlvSRxnLleKRhrNsFzyiWtVUUkkBOqlDMT
         atT1IM8X0NM8qhaagZV2Ogre+pM3MxzJuYxEd2a0NFRvyP2mhYOECMIBvuXmImqskmfx
         5yvQ54c1GYeK5i+6gmL7Gz4CRBJeRlQOmMjQOHdICW4Be7p4VdEaHZfRgl2fJXDMhLRL
         4OHQdL5y15iB25XvBVW23XVgg154eww9vmpkujop7JMV2hAIarJum4Vhn/nENodhEYBq
         T/FKoiLTrsk2Pr4fxJ2K9gT9VCpLAubC20KETyRqW24lt+/GIsDqjK4JH7qYObTAsE1B
         WV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788975229; x=1789580029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aRf99SMBmtl+VTLk0zBUOwJpiJLfRXga4UGT3MjWHTQ=;
        b=N8Z+iyegu/2cwlCGTIhAjMiMmlAp98SmPM+ZxZOXcOV+zdOIyAZJkrdEBSpJ8JdHo3
         uMlsm5gxMxqAHCvUm82ZXqbjq6LZHOuyqknF24LqKBFbnxeGFi5A3braf6KykEQj6ZQ4
         16CMqJU910Zd0FY2cW1NnUnnvoWkWyor1JucLO1t/jDsogUAN9AOfJxggSFHJ3sBKuDB
         xyx7oVCfDSzL3bqOUV6EqyJEcaIH0U+9OCBqYaInOdfJl0dVC2UKaZ5Leoeg2PUi2OLL
         EQGeBEJVXHDyd3tsyvNpDQ/4TXxHdI/sZF30qhU2CalBrmz8GMPC4a1/E3uNTUNDGyBd
         OKIA==
X-Forwarded-Encrypted: i=1; AKwUvByPlgRDoZEH2Tu4sElyXq1BUIodcRj/dnQqRn5oQi9ua4f2f8yS0JTqh9hIEmJMvRDFSs4LEljCxf4=@vger.kernel.org
X-Gm-Message-State: AFuF++lFPnORE5pB+wYcxbd2/YOkfXwav1BOhJX1ria30na81YRUQaln
	HP533j+HYTBaPdOXyKcQd8R2snipPBwNYsTzf+N3y68Nj3rzbrFjhuUC
X-Gm-Gg: AYBFou0oE5zFaKukBwi/zGBRMbc7Hk3HSijDi2Nltpf4yuLZzyT1lBS6Gc0IzHAN18O
	eM+RxwjV41oU5hvskRcxEfXohOSKYjKPpQ8b81ASEWNJ+c0W/8rQT/MSEOYJgXy/OWhyJQxZszz
	6+/0z1/cZkbvhPP2yzTh0l2dnIBWoYHfrreZR8vGu3ZZc5Sy0vkKR113ZYqT4CnL6+VdCv4hHYN
	eddvPNgULQ9uOm5GLWI4goOp2k35hNtNwC3KEKo/OZQ8X07zM76dYxeeQWwFdwQ+1ILhbEgRzGa
	JWdlDEgf+EyCz/nHOiDmBn3MdaFE4JN5M7LT/ch+RhHhQM9CINnjh0otSnu6/8YoYuD35l6nUIM
	+4bekJT2b6gLGUVBbbaCUVELwQWS6EAmFc0mHEUdsY0MDCGa76rK0id0bL41hmOizrYkRTz9mkf
	eZQUIioj0tzLmcLMkDAs71gurBuhkN1tNSi+3ttGDParie7xiy7qvpmQuWTaHp+oPBpY/UfliMr
	XZanRcFU37g72a05CUpBGA+ujRcr3DdGd2q5vBD8mDt3Iiffm12mxcbnAknyhzqMD0=
X-Received: by 2002:a05:6820:1888:b0:6b7:46fc:1cb with SMTP id 006d021491bc7-6b746fc0236mr17849545eaf.42.1788975228770;
        Wed, 09 Sep 2026 10:33:48 -0700 (PDT)
Received: from memorizer.fox-kitefin.ts.net (47-163-111-11.bng01.bytw.tx.frontiernet.net. [47.163.111.11])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6bac11fc29bsm10396408eaf.6.2026.09.09.10.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:33:47 -0700 (PDT)
From: Yudi Yang <2000jedi@gmail.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Michael Bringmann <mwb@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yudi Yang <2000jedi@gmail.com>
Subject: [PATCH] PCI: rpaphp: Fix stack overflows when constructing DRC names
Date: Wed,  9 Sep 2026 12:33:00 -0500
Message-ID: <20260909173300.1144301-1-2000jedi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The drc-name-prefix field of ibm,drc-info is supplied by firmware and
is not limited to fit within MAX_DRC_NAME_LEN. Using sprintf() to append
a suffix can therefore overflow the stack buffers used for DRC names.
Use snprintf() and reject names that would be truncated.

Fixes: 2fcf3ae508c2 ("hotplug/drc-info: Add code to search ibm,drc-info property")
Cc: stable@vger.kernel.org
Signed-off-by: Yudi Yang <2000jedi@gmail.com>
---
 drivers/pci/hotplug/rpaphp_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 2316de0fd198..39109a50fee6 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -252,8 +252,11 @@ static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
 		/* Found it */
 		if (my_index >= drc.drc_index_start && my_index <= drc.last_drc_index) {
 			int index = my_index - drc.drc_index_start;
-			sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix,
-				drc.drc_name_suffix_start + index);
+
+			if (snprintf(cell_drc_name, sizeof(cell_drc_name), "%s%u",
+				     drc.drc_name_prefix,
+				     drc.drc_name_suffix_start + index) >= sizeof(cell_drc_name))
+				return -EINVAL;
 			break;
 		}
 	}
@@ -355,7 +358,9 @@ static int rpaphp_drc_info_add_slot(struct device_node *dn)
 	if (!is_php_type(drc.drc_type))
 		return 0;
 
-	sprintf(drc_name, "%s%d", drc.drc_name_prefix, drc.drc_name_suffix_start);
+	if (snprintf(drc_name, sizeof(drc_name), "%s%u", drc.drc_name_prefix,
+		     drc.drc_name_suffix_start) >= sizeof(drc_name))
+		return -EINVAL;
 
 	slot = alloc_slot_struct(dn, drc.drc_index_start, drc_name, drc.drc_power_domain);
 	if (!slot)
-- 
2.43.0

