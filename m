Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8811A9FA0
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 01:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785375516; cv=none; b=WpARMuXK2bqpuB4MT9XUk65X2ge4l/fznyPTNBsxKZpBdc3fXqfJSjMdB4hVsxloWnG5Lx3RmeG+uaeCYSJyolNItCSSRqwLKIHaqw7bNwHLAeyjvQVCE4v8iU+5SHm4TNR9oQG7NarFTMSj7br4blpV5VfBB481TfMGBhd6TLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785375516; c=relaxed/simple;
	bh=d2thIbU4aVMmJkx2yMy4QClnhiMF5Mo5SVGnril75Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i6Pje2Ohg7A3xJunRjAFTFRAruTPEGsGeLNjB4FJIuFavRkiKFTaknTMO2eDdTMWOapEZjz1ED5BsJCYBefzNqHJ0WXcMAMg5FvFxVRMs6cwjDEZaPV5a4gH4a//Iz9suCT57Gk83SJogMTk4ayqlYSvWqtGJ6Hd5YxsTlym6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN4gZWNx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN4gZWNx"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf27856f9cso17096095ad.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 18:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785375515; x=1785980315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0i8JBoGZqm250W1UMwkZ7CxXnccJE53LG7LBF0Lb3wk=;
        b=IN4gZWNxJaC5JmeAzO88K6u6NPKAPbKwgjEbSXAb3KM5O11j9jFe7K5l7yKKW1zs6l
         jYzVZlgfp3+CXPZ0y3mECDTRkQOhs+KaK360GgCKUT67jJdXECmhuFkPTAStaJzH0WfD
         +ioyg4paPlfNUu4znJS/CzC0aD6cMAT6VzIzZcnafQXaqWpvRgUGK8zRziUO5cfvRG05
         3DN/53tu1BzzuS1VOMyv6rH3q2p+XZOTtAOaJmqJiClJWW42zyScuKu7NzZnsiY/s7lG
         c1M1JqgxnIAVHaiCeq/IeKhHWr7z5Mg2c79cpEfxw1Jxc5vMZ0EGCN5XVGUrGIdcazKA
         02DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785375515; x=1785980315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0i8JBoGZqm250W1UMwkZ7CxXnccJE53LG7LBF0Lb3wk=;
        b=Jrmq5ruPc+BVlCk3LC5FSBkWTCiDHDleUTLaiIzPTW+AWZN9N8LwQW+ktfgq/jyJvZ
         X4g+TPFG7DFMvy0Bkm/5nJcAUSEpMr306JB2sqF0Ph3Z7YEL/sNZHKOGKh6Cu1NRDd3o
         G+2CPwxX4kI2EtXzhDATafWosKBloFK0SuvOXd/hD/++i+DcKGoJyIdRTKG2zehyK8ZJ
         nBq88HvnsqNgJtOxM310E7KXPvhiwCo5fV3L/oSe07hGAQRXOSRI7NWkMnANTZQ27OnB
         RoyOl7ANm4xXDjPAPovbkXvxwa1K8cmvtnjxg1kFNtOBNa2GKaT0nMJiyyDOCG0Qov5Z
         R4JQ==
X-Gm-Message-State: AOJu0Yw1qHnMiDvwbuR+Vl8KYuL/CWyp7l8vqtBf5z3JTZ39keBR/ULm
	L4epaJVwzl2p/ayQthnnWNKUMpNjh7FCWpf2KMhDXFqH80t44Ea6F/ItWhLUgTB+
X-Gm-Gg: AR+sD11arNWLYmT1duCjwHCXWcVmCyg20bVvUD3pgmUSnP+slifcuOoKTFr42/UYQWl
	PgkuNePOr6wXAaFapKjtjK/4t8WzW8tJ4n1YQSX82TfHswIVw1HW+hltOZ647MA61E1JVbzOMPZ
	g3CLWo1klM+tU6nSsE0IzZWpSdLrqIBUJdXaGuuUiv3uXFh29pcrimm3qw62AyuL3q82Uk2h9ri
	N0nrt1pZGAe2qEM2D8qf3irTdcsDnT7ClGIiVCH5/YKUEre+ZwolL9ROD3F2G7z6XCXwSpdZRH3
	jGRYVaO3PhuZsP8m8FHkQwp5eyaJFUcjsB2FiOwU8taxDZ3EuEBYENZ9RdJaUYe20Nv18J/bka+
	y0LrAaOmdPJtD8SNQmEeytbCPu3tdOfDLYgKex9znuTW94Cu0yNR4xhnJkqK/UYxkFbPUyBA6/q
	tCsNvFl8847UgJaASRquqbFvEnxrL8nOowRHoekjRsf0E2DCxEn/vIlwk9Ah21DXlQlO/lfm5BB
	GPy2K4gBQ==
X-Received: by 2002:a17:903:185:b0:2c9:e261:95ce with SMTP id d9443c01a7336-2d035cb4bd5mr6136135ad.30.1785375514698;
        Wed, 29 Jul 2026 18:38:34 -0700 (PDT)
Received: from DESKTOP-EEO8KI0.localdomain ([118.218.200.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc6d56sm18298165ad.49.2026.07.29.18.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 18:38:34 -0700 (PDT)
From: Jiwon Kang <kkjiwon04@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiwon Kang <kkjiwon04@gmail.com>
Subject: [PATCH] PCI: Fix coding style in pci_sort_bf_cmp()
Date: Thu, 30 Jul 2026 10:38:20 +0900
Message-Id: <20260730013820.20147-1-kkjiwon04@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split single-line if/else statements with trailing
return into separate lines

Signed-off-by: Jiwon Kang <kkjiwon04@gmail.com>
---
 drivers/pci/probe.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dd0abbc63e18d..f5972c2c50340 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3527,14 +3527,20 @@ static int __init pci_sort_bf_cmp(const struct device *d_a,
 	const struct pci_dev *a = to_pci_dev(d_a);
 	const struct pci_dev *b = to_pci_dev(d_b);
 
-	if      (pci_domain_nr(a->bus) < pci_domain_nr(b->bus)) return -1;
-	else if (pci_domain_nr(a->bus) > pci_domain_nr(b->bus)) return  1;
+	if (pci_domain_nr(a->bus) < pci_domain_nr(b->bus))
+		return -1;
+	else if (pci_domain_nr(a->bus) > pci_domain_nr(b->bus))
+		return  1;
 
-	if      (a->bus->number < b->bus->number) return -1;
-	else if (a->bus->number > b->bus->number) return  1;
+	if (a->bus->number < b->bus->number)
+		return -1;
+	else if (a->bus->number > b->bus->number)
+		return  1;
 
-	if      (a->devfn < b->devfn) return -1;
-	else if (a->devfn > b->devfn) return  1;
+	if (a->devfn < b->devfn)
+		return -1;
+	else if (a->devfn > b->devfn)
+		return  1;
 
 	return 0;
 }
-- 
2.34.1

