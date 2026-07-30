Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5CA3B38BD
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 05:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785389706; cv=none; b=be58K7sw/MgX6xJ4x3pQnQAPtJtH9VTYgajXKdBsMWP6MvX87qif7jL1S+0HzeLbOk5EJ9FpaRsFaQowQfC43nF/CDeeiAvfzMYF6uwJDybq7GwgeF9CKZmjg1RF+K+VjIqPHJ+Zc3ZkN1mq3ItQ+UAwva+Slc4DePSh0SgXSmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785389706; c=relaxed/simple;
	bh=NtTUDUZ0kPxv72zGehv5P8xkLZfZBYfUYITNSsEXvnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n3VC3kegY1gZ2T5AkgzlfQBGKVY2ROj8jmBlvru91zMo3ZFAZMnXGeXi7j0aKl9zIcxpYQ1CWcJ/3ZoL3m5ttqlXIK/fz7RBXwrf/NY6K3GI8p+xgKnPYYPnxHZcvRvqjMM+3hKLhUuNNuwVlFPpf6idZ6e9Hmo5WCl1yFnmxHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4YCBUB5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4YCBUB5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caed617615so21174885ad.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 22:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785389702; x=1785994502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D1FFkpauLFMhqyNt6jPhwadm71t+O8LamUi+hQvqQII=;
        b=m4YCBUB5yYbp4FvpbAfEl2sYtrI/gZn1tif+/J8a+1NuNVLvrOYB1RaDfhktmTuPqY
         wqKn1yBhc60rSQYIjvWF8O7NN//gMSnnt2VTKh/HNbxL3eNw2hY19Csigx4hC7ypB0ax
         ysafDiXxWstgR7SosSFAtl8Aeqgayj7nAf3DRgvDLqwl7BhDYSQmcCKm2iHVSpVRMmKc
         BYBukqvsl7wA8sokOKA0FAWqNhBwFJ1NULhgirijIJZpdfpuFl7pjaQyoc6RAc4rGJBD
         EmT5wEqt8OzUMOaQt0foqDcgIrPfpkTRrGvM1SORfa5nH7YdaVYCmSRq7q7mqOYkf28t
         N6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785389702; x=1785994502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D1FFkpauLFMhqyNt6jPhwadm71t+O8LamUi+hQvqQII=;
        b=TcRMgbXKWuq9rPfiRUC03a1QxYea5NA/rWe3rUkntqW/uIKnnMCXCrTGRCoBr5+Ey6
         oYH54fTsQowUGAimrBtJ1stZg4T+NM+XUmrwUYKPKstyWmzOaFK76UbsbsenDgvEdPr+
         xxVoX3jCEVyR6bnUxb6S3QVkvFbRhzjYD+35/eU6m9FKqjd8+5WfMH4R6p0u+a1+G40w
         Nu/CSKj+3jl4NWzuqVY8kx85daTzpzWMmM7THHHIpCAWLzObqFK/OvbkkslvYv0rFMDW
         Gpb+2QpKThQtR31pYU7halaLHGbbd2vPLDY4XEo+NQbM1FqtZTAtU52h9HNBp+WZe7iH
         fNsQ==
X-Gm-Message-State: AOJu0Yxw3KHSPdC1YT6q/hMKJ+uEnuSEJVWAbtHxiMR6oMQhow8qowOz
	gOswMKiGwdtZDmfu+sY6oMxHG2sSoN8hr2KJDz9NkifIs/inqkG1AABX
X-Gm-Gg: AR+sD10j9bOzTynbqUb3eaqnYeasepwTHzglZZXFO+6dRY/3q1Hkr52tK7c1jdhYC79
	tu77h4zTwArqXZk8p1HXdBCqr0VPqvcJcj3uZ2VBN0bsZVEmHbBxtyI/u3+L1jknx8FUrkDcYY4
	10aE8qsVaChnmt3bqWVQ4zAh8Ryw8OgKzu+qZwIQQexsDLN1daHzCf2uVv0CVK2YITOPK1Tefjo
	yf1kyTpIfhU4W5RTnAzHujI9J1AjJ8ZFQy1lK1OOI89AfgitsscF1AH9jawuPIyW0BXiwmO/VHr
	63usnZe6Q8WyBpYEXWTUjoBaU9QooQeIp7g81Zq1BMFfjkuABGI4pVKXxYuDSQHnd3/i9++6/I0
	ofjIAOq5bW+rbPouPqmXm6tuDWAbYANFEq9ZHZOK04fNEpkwHGN7UVtsjxIyiyke3u69MlPJ1J6
	hoegBz5t4s180EXPK3LKYm8MQeqF/Jpurj57kjDi+Fzy1E8F1O/X5JPG2z0PLsMd+vFUQ9osf7Z
	b0mYr3RSA==
X-Received: by 2002:a17:903:1252:b0:2cb:ea0b:9164 with SMTP id d9443c01a7336-2d035c1c7f9mr13238145ad.6.1785389702119;
        Wed, 29 Jul 2026 22:35:02 -0700 (PDT)
Received: from DESKTOP-EEO8KI0.localdomain ([118.218.200.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c2d5a4sm20233715ad.71.2026.07.29.22.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 22:35:01 -0700 (PDT)
From: Jiwon Kang <kkjiwon04@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiwon Kang <kkjiwon04@gmail.com>
Subject: [PATCH] PCI: Remove unnecessary static initialization to false
Date: Thu, 30 Jul 2026 14:33:37 +0900
Message-Id: <20260730053337.22427-1-kkjiwon04@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static variables are zero-initialized by default, so explicitly
initializing to false is redundant. Remove the initializer to
follow kernel coding style.
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee615..ee2beaacbc73f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6671,7 +6671,7 @@ static void of_pci_reserve_static_domain_nr(void)
 
 static int of_pci_bus_find_domain_nr(struct device *parent)
 {
-	static bool static_domains_reserved = false;
+	static bool static_domains_reserved;
 	int domain_nr;
 
 	/* On the first call scan device tree for static allocations. */
-- 
2.34.1

