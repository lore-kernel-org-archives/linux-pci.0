Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FA3286A4
	for <linux-pci@vger.kernel.org>; Sun,  9 Aug 2026 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786251596; cv=none; b=ffnoKgk8Iwi4M8+6lWGTNOHUaB7Fz4A9NtvwfZVmgEj16UgYV1nmOny7DP15f+JVo2BzzmsWdVztNZkIvKfmRP20wOuhKqMRTmWBwNCccxE1Y7+QWByFKt9su4gxqwgDUPns5NcxPDTc9wmPf4XiKvCDrsSpuZd+JoU4saQNjMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786251596; c=relaxed/simple;
	bh=Dy2SW52S6wIHzgh5Fk0hmevYpwcxuvjho96umBZ0ZNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDELB7HzZfaSPNTFf2suj+xqdpdgMECigoy3ZnSXeOKcxpf8zYKHPuyQevO1z3njnX6BL89pPWcf7upf6uuTAXaJKsuFaFOWSlVhIeDJHAKdDd1PdpJ0gFyzLzxN2j5d90oOXJXcvOkSOLi1nRwcAehAnH8T3Wpdyelu6dYpkZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpNW5aLm; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpNW5aLm"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so679652a91.2
        for <linux-pci@vger.kernel.org>; Sat, 08 Aug 2026 21:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786251594; x=1786856394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aOAGGIInYSgX9juJ4EdGcal8nKqpzOwqusrNGyQRlsA=;
        b=kpNW5aLmA5a0kDJUD7IpqmPFjW5E0hXmn38AEov/b9TBCANhb/ydObMuiq81/D9zpT
         apsKWatREBieefiB3C9lNKZ76XxcFwKoB9Hr+gVuE/Rg31Czueh0QoJCMe4if9+j+qMY
         ggo0LAqSeAEQKiDw3BYJzbb0wKgryrUKa97RIzgc0EiftKMv9GdhNq1O6B/QniJCBZcx
         Z3+ioe7NHNk0jqjdCbNbn1I/1Ro/9tTkrgVZh2OBEnL+kpUauBKVzbpSjvI5cPxjXxJZ
         aLAdKejLC4H7L/TCnkTZjVsNNrkKLvlW8h5hedRz6gx6k/hRsXtL1YdNgHJiSX7H3eum
         c8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786251594; x=1786856394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aOAGGIInYSgX9juJ4EdGcal8nKqpzOwqusrNGyQRlsA=;
        b=WW10qR3Yk6B16RN8wzvj9OCEJ6N4uErrUicQQXZ6YZ5KIM1ezhmIeMmDAvu8rkTXNG
         2RGhfS9OasrkN4LoJR1XCZLSylYfnih9YDe2H8aYo75sfbySdyFFriGroj1/OLYaFIkc
         U4MYD8qZAhLOFqlkY/u6+UHClCGWQJfOqS/DAhE3j+MM8UlNwOAtacCI9RVLjOi+KXtW
         CSjku9POdGL73+kHnHh2rNdkT8Of5LVHhfLTITwpcCFDn93RRO3LOHTTaXYOAlNscREK
         MhZgqBaXZGHgBQoR/415XEZZJHV7+XHOlfTmkW14tAmATljtKdy78vKfy9Ki3ANPj+uN
         HkVw==
X-Gm-Message-State: AOJu0YyC/I0HPq9tVGrBKBQSPCqxpmgq1WarUeED3Jxw0Y+ZywDQf3PY
	wcLjHU4DfplZtCp4dNiEdR2oZrLXuPZ0dVVc3HYEuPK1G7i2+ifFM54N
X-Gm-Gg: AR+sD12Aw4/Hs6RhKiJsdV0hsmmmxDTA84dFXbg3i8sQFq0Y2SfnAyqu8pRXcQwjeyY
	tkFN9J05JJkTQgyhk8y4EO/dzGKqKO5qGp/su9lmv7kpFPDjJYmOBSKp0dkRkI2BO4eAN+Hep71
	B2A9dfYdaWzKTrBN+C8RRu6ykEwp2rpE4AyMdWPptG8SJNmOZzvDYEkWmtUG7qYFR/rZhVGNEPm
	ERTMmXVvKC9c5HwXWsM4Y+TSVnXsVBv2xmtkFSl60Q3YOB2GP37kepDAxGZ7/sTH44vrRQmx6XZ
	4qfkruK41ji75wK9bx8qLBI2LKnV7+zN05cSYE2x8mcJJW9/MQPTDN/ev7IFVFKvl4Hnt3Hr80q
	BIiwn8Ya908mWIfXYeCC9VHtLS13dUu8mYVZNKMIss1jngLj8LGOPLlJeORZDe5u5GgMHnEtTZ4
	03UTA0eQsEre1nHtZO6qE3G7+sTJ53a4FGsW1epoVr2kYmFzMJJD0kuowEE9FcCP2HUMYrel24s
	S/RsKw0A8FE8q+N1IAgKGR/YROo8AVsQBhNmsS7JKC1
X-Received: by 2002:a17:90b:5444:b0:381:1f51:1ff0 with SMTP id 98e67ed59e1d1-392821fc107mr10923812a91.2.1786251593992;
        Sat, 08 Aug 2026 21:59:53 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:746c:8928:e990:23a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec128a0sm30150480eec.25.2026.08.08.21.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 21:59:53 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Subject: [PATCH] PCI: sysfs: Reject unaligned resource I/O port accesses
Date: Sun,  9 Aug 2026 10:29:46 +0530
Message-ID: <20260809045946.15638-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_resource_io() validates that off+count stays within the BAR's
range but never checks that the resulting port is aligned to the
access size. A pwrite64()/pread64() on a resourceN file with an odd
offset and count=2 or count=4 reaches outw()/outl() with a misaligned
address. On arm64 this becomes a store/load to a Device-memory
mapping (PCI_IOBASE + port), which architecturally requires natural
alignment, causing an alignment fault and kernel oops.

Reject misaligned accesses before they reach the low-level accessor.

Reported-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7134530b25073b4ef373
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/pci/pci-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5ec0b245a69b..72f0404a34e9 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1175,6 +1175,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 	if (port + count - 1 > pci_resource_end(pdev, bar))
 		return -EINVAL;
 
+	if (!IS_ALIGNED(port, count))
+		return -EINVAL;
+
 	switch (count) {
 	case 1:
 		if (write)
-- 
2.43.0

