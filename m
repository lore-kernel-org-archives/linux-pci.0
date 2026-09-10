Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB714BFE90
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042427; cv=none; b=G4IGJG8riS3C0DSbInC9bHm+GWEYYSt52wahT8WTHZdv6fNN50yBVD5n4r5dcNXBND/+vwVuPrhgNQZfGxUOpjAtBIMVCSOCVQ5nCIzI3XUXC89SvV7Lg2vRnAfcR3r59YV+G+3ZN4Qp8UHwpGrpLw2HpfdZB0Lk32RnRlVKy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042427; c=relaxed/simple;
	bh=7AluFq65iw/e3a/VrEcoJyeiRqVzarE/IVafDI3Q6/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CwS7BtNj+zgzmR0g9gHGpN1JnO10umEHdx+bKmhyQHXBTZ8zdV76LBsZpcFZne795bFo2URoIwJEU3Ee4hCIuvwnX8U3fr8jlIC7N8HreYQNdQ9jCrYemfQRk4aixH4I28TOszLR3xtulwHbuz4/LMgfb3LAKTaRL1cAqhsxwFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJXX2exZ; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJXX2exZ"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910c3d02aso127943585a.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 05:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789042425; x=1789647225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4hqhe5nL5m8h0oyKqgGFnsjXQH8e2lSBQ7XG7ZTQ+wA=;
        b=IJXX2exZrIZPkHnsW62tS6uZP6t2AGS9WazFiux2eMlt55VaIisij1vhS0JKRC0xKn
         JtrZX5H/C3FuP5DaJ2mV/bbF68zuKPPys2FoAc7SyMcmi1C6h48usHNmhy/2p+f+8oJI
         eumLzKEnl7Bo6ovc427tlD8RnQhpCfb8br4wF9uDpPDhea/TabZ4JEmn6BBmivAVIhVc
         8P6ioV67Xy8Fq20mVs3wirbY4Y0D+gQM8Hw8EsgDBJxOeAWpX1X+Uhr5i+XlOGQsO6nD
         oGcMgkqAaNgmEaz3Th23pswCKQ9LsQLVOEOID1Dc8KO62hOKe+hdHSjPcLRMzCK3Y32Q
         61Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789042425; x=1789647225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4hqhe5nL5m8h0oyKqgGFnsjXQH8e2lSBQ7XG7ZTQ+wA=;
        b=iO+IiuUMs+WLzzLkq1RZrvCRWdylDx1M4yXp2XXUz38HNbbbYeIbBixtidNj9f4xyh
         v5kFiHsWj2X5jeMWJQ8TkD/wxsNG1p5yLIYaRO/lAdBAQ1MlnZnO/OcdZ9mqqAEjKnQ5
         GYSUnIy6EhAxoYtMVKudcIgP1HjovmuDdSJr6l479LxOinkcaN/bvZwcdbRewYf21Fdk
         osUPrtmkbgXZ/53Ptt+6w+FgZBbEsO9gT4D65VOChrbQjSKjulwI+c2yv4kXtj9GwoGm
         h1llN4u3qeyicDuFgHF7wlYqRFtEuA9lef+k7xn9gCquQXHM+Pdba5NB18oaqiuc1SA9
         /fyA==
X-Forwarded-Encrypted: i=1; AKwUvByllKFEEJnymadXSC0L/5dYjTiOLjcatlaEbdDCaFVJAflivRGaLJdWz4ihfea/GFvnm9USKt3AOsc=@vger.kernel.org
X-Gm-Message-State: AFuF++lhFSTIHj84uEMW20wMYEGYPwaRnInZnZKl0MOrKrdADyL57IPt
	8UFK5KVssbyrkWEQ2iBhlTsNWthCszJNO09bPAT+64T7QiOtfFAaTuwo
X-Gm-Gg: AYBFou07GTW6WPmtawWGpD5aGie+SGNPlLHNGkAisDq/j3w0Slfq2C4oPvViCaVEZSU
	wzqNIN+Vzsl0hbZ3W4udimXrlxARBB+B8lI2u5k0nIPv0kHBtTHXKg+ePKt1wXylTzrfeiyOahH
	La7NZ2AJkf0trO3Pwzc84gx4GgvmWKdOOsuuOxieHTKpUUaxzh30B0SX9/RNj1p1raKRW1WpBM9
	/Z5oPPeuSRqPe5gIpKl3hftx63+mPwJBzCE+A+nj7wePlAJv7HZDMfJzL2VwHJXLNqUAGAzjHF8
	Btl9AyOONLajxmG0/R28B5De3605aZp3kY+p3g9QuqJmM7wrXpR6D7nyJPTC03a5Uiq3qkh+y8f
	PPZvc1c+4rz/a+jnP+YW26AuxkyX+Mf1H7g2ZgWqSS9zFdy5AWym+G32JHu2MlBaxyaJf48QdBe
	QvdS2QPwtxlMO08E2WBtzjywNHg3BXwFEnXXkQkFZc/w6zsXHx9RgEq7yqdPQOlX9Fxlg1wGDt
X-Received: by 2002:a05:620a:608b:b0:939:934b:dd61 with SMTP id af79cd13be357-939d7fa9584mr459351885a.22.1789042424724;
        Thu, 10 Sep 2026 05:13:44 -0700 (PDT)
Received: from adriano.lan ([2803:9810:3d22:1608:a801:3f8c:3321:84a0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbe31c6sm1691021085a.46.2026.09.10.05.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 05:13:43 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linas Vepstas <linas@austin.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] PCI: rpaphp: report first slot registration error
Date: Thu, 10 Sep 2026 09:13:30 -0300
Message-ID: <20260910121330.339150-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rpaphp_drc_add_slot() overwrites retval on every loop iteration, so a
failure to register a slot is lost if a later slot registers
successfully and the function returns success.

Track the first error and return it, while still attempting to register
the remaining slots.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 drivers/pci/hotplug/rpaphp_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 2316de0fd198..af7241d526cf 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -376,6 +376,7 @@ static int rpaphp_drc_add_slot(struct device_node *dn)
 {
 	struct slot *slot;
 	int retval = 0;
+	int first_error = 0;
 	int i;
 	const __be32 *indexes, *names, *types, *power_domains;
 	char *name, *type;
@@ -407,16 +408,18 @@ static int rpaphp_drc_add_slot(struct device_node *dn)
 		if (!retval)
 			retval = rpaphp_register_slot(slot);
 
-		if (retval)
+		if (retval) {
+			if (!first_error)
+				first_error = retval;
 			dealloc_slot_struct(slot);
+		}
 
 		name += strlen(name) + 1;
 		type += strlen(type) + 1;
 	}
-	dbg("%s - Exit: rc[%d]\n", __func__, retval);
+	dbg("%s - Exit: rc[%d]\n", __func__, first_error);
 
-	/* XXX FIXME: reports a failure only if last entry in loop failed */
-	return retval;
+	return first_error;
 }
 
 /**
-- 
2.51.0

