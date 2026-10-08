Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498B74F5DE6
	for <linux-pci@vger.kernel.org>; Thu,  8 Oct 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791485750; cv=none; b=JKDFQJ3z+vp89kKtkCxEbMBwZvmn61TOyRA6FtwF+QE4qRABGVk70H+xGjD3vv0U1yD6OiquZ1FZmPly5vrZovq/wUnllJ14p8ji6I9SOZRbxX06uFs83opiSWnXNXa81yefzRTjcuafom79Xngi6uWVu6pDrh/XyZJzwwV24V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791485750; c=relaxed/simple;
	bh=IgB3sZHNZ2GnpYpDmh39i8B9BgxADBtTRCiRUlW7RBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGtFCwmCyEC1pEHi28uZGU0WC5r6zzO88S1CTOfZGSPG23OkzwelHKuCD+XmaKlNJUAiW+9g9I9b7PPDYctuJkLUKbVGcuS97ijkxKuzq365THbfefY9SsjwcNW8vwapuPJoQGUUEQvEJDp4NvE0g/Kkp6/LyG1Kkfx2ZpPVuOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rrell.co; spf=pass smtp.mailfrom=rrell.co; dkim=pass (2048-bit key) header.d=rrell.co header.i=@rrell.co header.b=hnlbnynh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rrell.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rrell.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rrell.co header.i=@rrell.co header.b="hnlbnynh"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso2425752a91.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Oct 2026 11:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rrell.co; s=google; t=1791485749; x=1792090549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IgB3sZHNZ2GnpYpDmh39i8B9BgxADBtTRCiRUlW7RBs=;
        b=hnlbnynhgEH+/YQ8wKGSrgMpsk5IoIcrcfS6uRXLrd5NZ40XmGepTnUpGynHJ6fY0f
         VXgzDTiFv1kpoFV5gQQg0vvc6CDEJMY6W4XLFYPYgfaS+OZ0Bg9nTjB7IbwKPL0VW3Kf
         A52vSdUDzOTxJF0MgI//OhOwv+Up6L6SCH3KC1TCkJ4lsnT4bM7BEZD1m958frarRwvn
         LWWBjrYevGwKdwzo21zPkoxQRgF+8mp6rBaIHFtY3zEAFDlWyL7TOR1eS5hqFrddKtb5
         qp4Hs3NCQvFpP8gYbMGrvd/mSkSTOAIhUXawj0FgkcDm8oPpsBR8BT2oj2eYW4MCvAMQ
         8bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791485749; x=1792090549;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgB3sZHNZ2GnpYpDmh39i8B9BgxADBtTRCiRUlW7RBs=;
        b=GuSM8XTJU6LgR155qTpdxC/SCeMnd69DxAzZe/39WjP4eB+3JNgNIwqtMdbghus6uM
         y/21jF98JDo+zGV0XoBAtr8wnbLLjOwYchCPjhGfaNcYTk0iJWreNEkduzHl1dUjMpX2
         A9OMYAW4yEsV+o4d8t3r7Q1NhtjvqEPQubUp49rg6V/fIR94vKJoVFnnhvCNcDAG8HY4
         0T8Mvim7ZI5hOUnLzRdOmgBtWB5SHxJ7PiwGGts929H9A9n0IfZtICA4tgBLq7fZMvsk
         Ud78QFwxRxNXk9CNDbhpKJD4izDUCz8wzFzJ6KhYgSsa0mQKZj5m2DR5RaIUe8U1dxc/
         faPg==
X-Forwarded-Encrypted: i=1; AKwUvBwe6UTnPvD7gfPhelK4gxFSXGDPRDifzpgmilnVPIZFos69UmsBZjC1wC7/hYNs1QIdcm5Am3DiRew=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQxT4ddyKze5ECSYB34C05ixkUNgC7PPGjexlmRsKZTdUUjWPg
	0DFh+TiOhrS7YGbovJIIpZGr1QqaHD0hfG95PamU/AkLxPik32SicVELPGd7AmZD+8k=
X-Gm-Gg: AYBFou3PrH2+8Q5hf3SYJ5h5z9zb/XCcKZJk8ZC5HZ3EzENE/jQvs+/djD54j+/gNgV
	vOOojXSDz9QWWDmtWA0qcbcg1zynIaWPZaTNxs6xhTpcacUR6z4Tyom+2LoNZnM3Xw27b/EnrLr
	nCoeYNX8rLsjzC/CRx/jHfeHjBeZ0Hrk0UlBHsI2G4SQAGWjNGAFksvv2p/Xej1RolX6jglexSc
	TXTpFngBqnJHGZug/v5t22ekb8ntgeM9jxtuU3hmAU3xPG31czA0niIIrIcxtTiGvftxG0oUi3C
	1dfjRcsZ7Lv91kc19ClvDlL8HA98QNXEBN/gs3awbw4wwdtmbA4ZhLrNoYAYdDVPsrI+zmJX3kh
	EJRsE+ycK1MaRAw1nV/DIMWdJvkqI9LdHWRcDpjr4UjtVF6Y2FhCpwgTqSSPxzSMmKHm3vYFO2M
	pvd0eMnbFeNDSU8sh3YchRYicN5Jq7/JDqtbvBsB5tEwqUtWCrn6wn7vOyZheZnbo0xe81xJi/D
	1YXZw==
X-Received: by 2002:a17:90b:28ce:b0:3a6:582e:5e17 with SMTP id 98e67ed59e1d1-3ab36d2514bmr5568a91.48.1791485748615;
        Thu, 08 Oct 2026 11:55:48 -0700 (PDT)
Received: from omarchy.tailc658b0.ts.net ([172.92.210.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3690474esm54003a91.0.2026.10.08.11.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:55:48 -0700 (PDT)
From: Darrell Gum <d@rrell.co>
To: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
Cc: rafael@kernel.org,
	bhelgaas@google.com,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: PCI: take native PME control on Apple machines
Date: Thu,  8 Oct 2026 11:55:45 -0700
Message-ID: <20261008185546.86200-1-d@rrell.co>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924132859.24751-1-fbeltranmillalen@gmail.com>
References: <20260924132859.24751-1-fbeltranmillalen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 24 Sep 2026 10:28:59 -0300, Francisco Beltrán Millalén wrote:
> Since commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly")
[...]

Tested on a second MacBookPro14,3 on 7.2.5 (Omarchy's linux-omarchy
7.2.5-3). Your PCI/PM v2 series and the Alpine Ridge quirk were
applied as well. The full report is in reply to the series:
https://lore.kernel.org/all/20260930141914.6678-1-fbeltranmillalen@gmail.com/

Stock 7.2.5: with both Thunderbolt xHCIs (8086:15d4 at 07:00.0 and
7d:00.0) runtime-suspended, plugging a USB 3 stick into any USB-C port
produced no kernel messages at all. With power/control=on, it
enumerated at SuperSpeed immediately.

With this patch, _OSC reads "OS assumes control of [PCIeHotplug
SHPCHotplug PME AER PCIeCapability LTR DPC]". With both controllers
left at power/control=auto, the same stick enumerated at SuperSpeed
within about 1 s, and 7d:00.0 runtime-resumed on its own. A later
run gave the same result: about 1 s when plugged in before a lid-close
S3, and about 3 s for a replug about 2 min after resume, still with
power/control=auto.

The patches were tested together, not bisected. This is the result
that maps most directly onto this one patch.

Tested-by: Darrell Gum <d@rrell.co>
