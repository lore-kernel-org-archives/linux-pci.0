Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A2B4446FC
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911626; cv=none; b=OhGnysqU/+cOu10/ua9v7CMf2BG4uMMlycszOUhYPgECMf/0+sdlsNlNiayfpUASXYjo1LdqXO9VTumsBf9WdBxmMLzD56kPDzY6n+XZv6EM8AgbqY1ytI8y+UkDYcQR8PCt8rioomIAMAp/ueAXbkRn2TveE09HVFLCoCVb+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911626; c=relaxed/simple;
	bh=9NYcmLdbUWrP+mU//pO/mmqOOgJ12dK5s4oIK8p5CTA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbYDMKE+HMuu9ZSECMVeLhPqHcGW8YSZEaxb0Tgy/iQDdnA540zFARauM9XFE/aooQMjJ82gkuHNHE5HsPiudm5DekpXHIiOZqO8tVFrNvLGF/BPRlOk7bN70E+0/xj7aYvPlto8sVinO4AIOUnJEflRNPSuEr66U9TqnQ/9FLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKXCZ1Hg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKXCZ1Hg"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84830c774a0so707288b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 09:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784911624; x=1785516424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LXWL3A5rMUnEz/bSY0B31M4CG2x+3yDzIFpO8mfVO/g=;
        b=YKXCZ1HgtcYariII6zoa/8UO6Tz/vHBoKWTJ7d7XJBhVx5r24ZBlIzzrK7zPPXOTkw
         0DlufLkPARRIkjTfSeIwC5WeO48xZtjBbSTAD5mJsAzKcw1A2NUOjerAqYCHAolmPBC+
         YT0Kd16OuLm4iq4LQjfvPqUkjl6OW6c13xBPUe9Nzoj/ZDSn5uz9rFgZsaMw03iEg3Ms
         klP8G1ZOmnxcNn2zv5Do7MepEgxnBnM8XHHMvPRhqObt6gqDdD4iRHtYlbhuDy4fvA/h
         u3KmX2ATr3nGrVqjVvpVDyqQnyas3MzUCDJO2pxOxssyHvci2PmjxroCwvKQbFwD13+6
         Etsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784911624; x=1785516424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LXWL3A5rMUnEz/bSY0B31M4CG2x+3yDzIFpO8mfVO/g=;
        b=LcKF3K0o/LEBi0ac1R34E3W1ZR52zWh3DPiB0OlNzP4jSPdDi5VMjM7ev/0V9ZRqw2
         zJzvyxu2xRxnKp+T20/i3SRzpAhvJpkg9D8zgb4G5EqVGeEPg3zJ03d+c303mRv9GgW4
         SqYmHHQWxWReduClYLngn3gH32zDXuArliueFRsVUkK9yOavN/hbshmUe5bhsfIYR5ln
         BnBIjbIwWqDtlN3CinjXudgrBp6eP5JTMEiqNXR+Omnm0oUDGZnUj+y215pHGjODUjT3
         IvfG6EolhAuOLD910yOlsVX265Y8whdUlUA+UW9KpAHfd/Pj9YsJRPXgob9NREZtcgAJ
         R8jA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4HIQueE6Icl38uEPSqMlW1olIQJsp6KL5aAasuLfNuY0oOESQUFNk3FTERz+SDCyvj9r9FZq2ARw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4PqEoe55dt3/dLEW2ErI+Uz9j/VKRwgD2rqopKJ8ggUmwbPMp
	ScVzJx3SCRGjF9SkgDfYG0a32dTn+e/B8mtWrzcXsmJQztHdFtFzgIQ=
X-Gm-Gg: AR+sD106cvDHNIrHt6x70a9zkTEbPjJb18L5CTB9WSHCuqu19A5voFc0AtaxZMa+I5E
	Ta9q7+mMMxwIqwjqLSSkSFlQhaQ24/wdvXcJFaaki4TvUanBcsCYTls49IblfimpaMaNhb7h+EO
	jfPxj6um4yaeechvSb2NsJABI+vhbMAjb93QcFVvx/u3sX39kL37SVfJhadGuLdQllC0i1uDPID
	UWTjT6Wduc1tFm3H8gxW8/ADdDZvFAtEMwduUJPDECnxKjPiw0BWW3j2MhsaH4/QBgRxdIlfGXR
	6Rgn7oU1Co1xAqkGHrkeodz/NphrxkPBfaGFFw+U62SXHDFLdDV5za4xcEyyFddOC/VoPmlxq0w
	0AHXPSoVXl6UmSCq1+WBA8r2ATRvGDBy8EKHujWFl3deql0decUBDuZr0JuF8ah2fs6Ygad7eaj
	uX2lozU/oUSqNgYc9AvtECiNb5nrV9VyVdwvgjHw==
X-Received: by 2002:a05:6a21:6f0e:b0:3bf:7bf7:7913 with SMTP id adf61e73a8af0-3c44af6dbdemr9141519637.14.1784911624220;
        Fri, 24 Jul 2026 09:47:04 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.60.19.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548e29sm918244eec.15.2026.07.24.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:47:03 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Add Apple T2 NHI device links
Date: Fri, 24 Jul 2026 12:46:35 -0400
Message-ID: <20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com>
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

Changes in v4:
- Limited TRP check to T2 Icelake systems only
- Optimized has_apple_t2_chip check
- Included pci.h to drivers/thunderbolt/tb.c
- Used __free(pci_dev_put) to avoid label

Changes in v3:
- Fix build errors with non-x86 machines
- Used __initconst for apple_t2_devices
- Removed UEFI_QUIRK_SKIP_CERT as its unused now
- Used IS_ENABLED(CONFIG_ACPI) in tb_apple_add_links for the T2 part
- Removed !bid check to remove warning with -Waddress

Changes in v2:
- Used a less generic name for has_t2_chip
- Used DMI instead of PCI for has_apple_t2_chip to avoid PCI problems
- Initialized ret in tb_apple_add_links

Link to v3:
https://lore.kernel.org/all/20260721063412.11588-1-atharvatiwarilinuxdev@gmail.com/

Link to v2:
https://lore.kernel.org/all/20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com/

Link to v1:
https://lore.kernel.org/all/20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com/

Atharva Tiwari (2):
  treewide: Add a flag to detect the Apple T2 chip
  thunderbolt: Add device links for Apple T2 NHI

 arch/x86/kernel/quirks.c                      | 37 ++++++++++++
 drivers/thunderbolt/tb.c                      | 58 ++++++++++++++++++-
 include/linux/platform_data/x86/apple.h       |  5 ++
 .../platform_certs/keyring_handler.h          |  8 ---
 security/integrity/platform_certs/load_uefi.c | 38 +++---------
 5 files changed, 106 insertions(+), 40 deletions(-)

-- 
2.43.0

