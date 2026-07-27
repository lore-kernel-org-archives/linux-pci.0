Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B603C457A
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187105; cv=none; b=Fl1+XBoMBzwfdkTojg/1NEgp7c3M4Hnf8wTfgCMnvu2fg87gKR9ektaM/4OTW1Hel/J6amF9zP9w4OnGtpCYdZ2Zp1AfUBGVP8v6wqHhzjk56HKKz3S691s9cvmz+dXljlQ5fx16OtwilXqiKkEfrK+mxyH0L+Fa9uzS3JSiyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187105; c=relaxed/simple;
	bh=3CbbR2OL6iy/vE34PxqlFInK6NVsD5LXXqSf2ANoapg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R4yfvdh2MXv7i9CM66HhXGhjKmuAm1xbv5rS7rEaMZtrmxFK9vPXpIa2nPavrGvUXBjt1fmugI5Jor4SihYvHj2HpJeZQ9npIgU1oO4jQ4lCiYja8Ik28dAUQ+gDUE4RgVtM87yHlkxpScfMoruxOY1EAH4X8EYbRMIUwbT98Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFfA7oTz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFfA7oTz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf452def93so2955175ad.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187103; x=1785791903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQqWUZmrvTZ8p8YK697dL17ozshe0vWXwcEmOAnzcLQ=;
        b=UFfA7oTzWtADJOJQVdjayW1f2TQ/CJoE8usBj7JBhWwURagylWHJK396z6tNaQa3oN
         40S5VwbF6aTrpSAXYmZQXrTJnOsQ2pRq8nsmS636FuZ6BWtP81c6aPGnu9isfchiHDOY
         XFGePtabW+X0pLo528k2KPgBEgllNMfh+oFHlK0ks0sLPH+uSDcJ/cqcbvKhdShl8UsP
         cSg6sOxyvfzwB+9gHauioh8WldlRTKHWYoUTC4oq/HcRw6PFPnMJRqIY8md/EOnMYa+U
         0RxXaRJNTp6svu94HuMf0SiTSITcm4uFJgdumTBlXuMBunCV3SBYQkymTou5ar8rtCWW
         LwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187103; x=1785791903;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qQqWUZmrvTZ8p8YK697dL17ozshe0vWXwcEmOAnzcLQ=;
        b=qS77f3mJ2jTHB8SwTqrUbfNPRnnndnTixmN2HkLxmGSngMPVPxlfRp/JTwKDRxyM4F
         z6I21JRRrahjzx7JdGQCcLUeEmrYEL7HBe6gkN3ntHYSbexP9Um3CWQQL6aIp9ZrHbZX
         i2srbCsc5GNl7Wl8Xb0HgPLimPKdqy/UNo1pUxfCA3dFa1NEiAkIHUVWaOc7Nv9qcBAV
         UUrs4V1D7oNdIhJRMxqx+Me8Qcjjz/DoD4hNTPDzWliWhxzfTl2Zsz7xnzGETq4j8ZEV
         L/tj2P75lUPR5teR6FS41EaJJlhyPEjJM5fiScKvLxFjhF8C7KRhf/cAroxrkSj4C3p/
         jJkg==
X-Forwarded-Encrypted: i=1; AHgh+RriqFxSCpB4sQ/3hBDv6mDYg18Sv/6fPsSrMt+nVurqSrfZtYZ75ZCeTrrJRtRI8ejVm/msKTvqtqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGhNtKo7VPvuL8Dy6UBUfHCV27SEF8D10mH4IaCvdggSqwSNlL
	RdQAebfmMv4lmSUvbyTS2pvoLfmq4s/LqHFK4Wg6lHL8Vt+s0kMd+/0=
X-Gm-Gg: AR+sD12XbhWUXpK0Q8qTXAYbZOZmoNx0MELtPYAGS60W4YXkYOREjNCUeXpcS8xWwHF
	A+nRbb/c+Zzpeg5kx9auRpkoEbddDtk5eyOX/4xiJmLAWoMa5kON+nKbHcOx+EmgZ8jHdqvmYMM
	tM6+/5CprV/wYSH9HA3tLY3oBiT2AvRv+3fMlchYxHWPnSYwSfApmOsgH1Wf49i7/1VKOmZiN+I
	WAE8BiUNhLtGvIeHsxWPA8/vItV4D0O7FHCBzFx56oQAtSaK5VKPUtSqet/lpE6x1yfkyThYGen
	56Zuxr4T6qH3d4tSwWdO8aigbCBR9Bx9U26rR6lik+onlCcCyEpHM+2gBlq0uX9ySDbqkIZBPSH
	XFONHzsjmuLpy91UhrRVE6qm3PJ4e6iH44SN/a3VFxkZA2zTTnHltemMboTNUd5I7G/M0F7CiUg
	kFUPyhJ4B9vHSbHMRYOz9n+ga1i4ZPpgcmYFQcen3n5B83anhMAoQIacAGBzbgyAUhbPK2M7Ysj
	EG/WF3ksKj7egiwXIL/o83VQQwWyyEpCw==
X-Received: by 2002:a05:6a21:7706:b0:3c4:2cd3:f0bb with SMTP id adf61e73a8af0-3c7857620bfmr410550637.10.1785187103141;
        Mon, 27 Jul 2026 14:18:23 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.59.84.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314e17a6f5fsm7916699eec.31.2026.07.27.14.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:18:22 -0700 (PDT)
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
Subject: [PATCH v5 0/2] Add Apple T2 NHI device links
Date: Mon, 27 Jul 2026 17:18:01 -0400
Message-ID: <20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds a cached flag to detect Apple T2 systems, then uses it
to create device links for the Thunderbolt NHI.

Changes in v5:
- Used Icelake root PCI IDs for detection of root ports instead of TRP

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

Link to v4:
https://lore.kernel.org/all/20260724164641.2239-1-atharvatiwarilinuxdev@gmail.com/

Link to v3:
https://lore.kernel.org/all/20260721063412.11588-1-atharvatiwarilinuxdev@gmail.com/

Link to v2:
https://lore.kernel.org/all/20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com/

Link to v1:
https://lore.kernel.org/all/20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com/

Atharva Tiwari (2):
  treewide: Add a flag to detect the Apple T2 chip
  thunderbolt: Add device links for Apple T2 NHI

 arch/x86/kernel/quirks.c                      | 37 +++++++++++++
 drivers/thunderbolt/tb.c                      | 54 ++++++++++++++++++-
 include/linux/platform_data/x86/apple.h       |  5 ++
 .../platform_certs/keyring_handler.h          |  8 ---
 security/integrity/platform_certs/load_uefi.c | 38 +++----------
 5 files changed, 102 insertions(+), 40 deletions(-)

-- 
2.43.0

