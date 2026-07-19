Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD133B6C05
	for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484232; cv=none; b=txNkrlpFtRFFk3wk60Lg48Q579ruL2YwJzgsZFtNS/n16durTqg5J2IqS2+63+V+RkkPSxxZTNn+YRo+PL3LHFa3qJ/sOJltIAOp8cpjWRlbreA7ABAkAu+ovCzoiO+k/bQBv7tKITnO+d3W6eh7O8ZTstqBbuc0SzBRurIS1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484232; c=relaxed/simple;
	bh=sVlAnhzfkzYQa1PcZYfpNzgJJd87BozZZNakBNALqlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVLIMvzSLu00F+thIpRwJZmpGwwz6SRLlYKM442ywY4P1jg7Sry0uq+dwOWKkk/vU70NfVVnpnccrDU1bXNwX4zwwl4X+r1dR95N2Zk94HkxUh3SGPyDmEUsYud0oWMCOJ4TCVBxWbWn3svzSCLA0QDKeD4zU3FpXrI6+pFx6qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO41oVYo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO41oVYo"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf52d15d88so7425865ad.2
        for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784484226; x=1785089026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jxozXjIKJbQZrZVReseOqoF/OLImpOhluGTGzSR1yOE=;
        b=VO41oVYojY5nNLDlQiMn6nnfXahXoClP/cwC9XHBUJf/aNsn76YDQYHUlyO81zd557
         YvWIt5o0EWh+URbiaqycX6C7b4JQt/Jkzlwh8vd7xrZXTmKfEfuwHMSGnTkXrDaN7FE2
         jSZFoJRDwcnJip5qO88NGfDWikr7Cx+J5uULPkgBrEJWj6uiMOdjQ6rzsYZ/1KKRU7RC
         1BVYN7Zxn4jAfRXOB8M5vEabMD6GvZgJYYREyQE5nBg4nf/rgZZkgSgCRUcqXBJbJHhl
         49JfSkQ30IgEDQQ63i5kq6otw8ArRObpqTIcFtA6nlbIUih6FG2u+71BRPxJlAbaoVwW
         aAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784484226; x=1785089026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jxozXjIKJbQZrZVReseOqoF/OLImpOhluGTGzSR1yOE=;
        b=bnA3y48+35YSMnRx8Z0EZHBZ7QNer5qtG8yIBLcey+hjYMkpQpip8lSKFHO6d0pQlm
         0/pDq+uJG67KD843fXuTwz47lLhxP/8W/vlqXLOIlFSNXQmJmzrC7eQ4VhXACqB67goN
         SU57DoicWNVmqvKBJ9Im4XQGd1yvnGK7TJrNPwEtUkRxVLhcmSvZAgt3kBsOzJWZePP8
         yULqgbGG/j4/IDIH8EwSsXyPIqqyXdG+g4nbrPWU00BK3YsM1xkGeMj89thckxVBCLJ4
         dNNLyKNB90JndbHgv2Ppu+/ygQfICADzzIKwdFFD1/u22v4IeTRZISiEsNAtPhI/6s49
         hdaA==
X-Forwarded-Encrypted: i=1; AHgh+Rpz8cNS9qljXQCqmfqYOaH/cH33ndtwCwu+FULPv9P3B1MFxHPkB9CQqzoBJR3KQ3PATay7ltjY7LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ2PoWoXinuOZs44tOw2gIsDpqcYhAU5+gqH4Fkf6PAMBZI/39
	HYyRc+xj/Id+jto54BF8lpTxfrfBUKMKYma4hdRZ9QYbU3JRDjV1pM4=
X-Gm-Gg: AfdE7clg9YRGLVMSq1saB/zRYLTDs61sLm3po/CfE/G/L8uuVpf4lj2Uaj4eg5x0lxP
	3pFRq4kmXb8029PhSkj3t9/pnT6Tb7B76L8wJmhVgJ8nmH8Hc256MzyrRBn7qu4lGizuc3FWnQu
	WeeQBVDa5ahr/VsNyXhpUQUEGSS/f5+ErpwMkNYSA5hEgSTd7UfrXRemP4n2RoKYa1h5aFfaOWk
	Xpq7vtKJLHpCjpcH1tSRVL9TRLZ8AUvAnlX70q4CR7XdYxy/sN8vkhU9Sb6ZfYkoD0Y27t/QOz2
	cTM6RzsTGg6NxfWAl+YHdtYE9wRNTlpaL/Je2+LvxFLQ0Oi8K7372reRuXYuZjB8yUfilwNFFgm
	6WqiPh6LMHr5cUsY/MlSMj9z3mK4Kwy56FqBHjkyIL8oRx9hvjgXPO+EpgzpWjW14eAW3p0dxFx
	YsKLb8q8VhJ9Hj1XEd/USz9CVFWaI+Y4XcXVaBPDkRV6yfAaNSbSU=
X-Received: by 2002:a05:6a21:6cc9:b0:3bf:6237:4d46 with SMTP id adf61e73a8af0-3c3ad7ad65fmr11766169637.28.1784484225791;
        Sun, 19 Jul 2026 11:03:45 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([106.194.66.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a02b7f2sm27967645eec.13.2026.07.19.11.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 11:03:45 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 0/2] Add Apple T2 NHI device links
Date: Sun, 19 Jul 2026 14:03:02 -0400
Message-ID: <20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a cached flag to detect Apple T2 systems, then uses it
to create device links for the Thunderbolt NHI.

Atharva Tiwari (2):
  treewide: Add a flag to detect the Apple T2 chip
  thunderbolt: Add device links for Apple T2 NHI

 arch/x86/pci/fixup.c                          | 10 ++++
 drivers/thunderbolt/tb.c                      | 49 +++++++++++++++++++
 include/linux/platform_data/x86/apple.h       |  5 ++
 security/integrity/platform_certs/load_uefi.c | 38 +++-----------
 4 files changed, 72 insertions(+), 30 deletions(-)

-- 
2.43.0

