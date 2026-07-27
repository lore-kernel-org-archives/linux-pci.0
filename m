Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394E408022
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154269; cv=none; b=dr4rsAoDytWV7L8jk9wE9ppxuYx3CGDNUU9y4ighmwGcvVFuDFqgowj86vtwHmsTokML0lqFytWiJja8WxcuTq+3MCFzAtfJkdRdSEaL1l6NkZqxvTSeFMui+h56dgLogSJCrZJCVZ1k50/gwkWxOM5na/jtYevUIWpZhBa5i1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154269; c=relaxed/simple;
	bh=f5yWEycCLmhwNgNs+7yltFCigM8U2L0qmiC75nRPZPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/odQylw9IKO27BhLDnvl5GmG5D82g7EDuIoEjcAiSTlNPt1JMv0zCmE2ANwZ851K8/D7LnJH1r5x6LzDaI1XMXDokVeszU1MKvlX00erfkDUsedAg8qpffuJEixNLdtI6yflpztmu/ABnbARXwypUNQ8rUeG/g8/Carc1kkqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=0DM/6X0U; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="0DM/6X0U"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4957eefd361so19899495e9.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 05:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1785154266; x=1785759066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yngGEtXt8XdvhkSci47p7H95S2e1zfXfAmsSjMJsNNY=;
        b=0DM/6X0UeAHvgmATILO7CjqVWXyRUWmZqNQtvA57/21VIrbr+Rw6jB7daOu+gWwDwR
         zbSPGj8qRxW9TAW3TBCZEm7Bmhn/KQJObYX7825fEJMxp4sbNwlpUt06DebRk53PyQMu
         0brf4fhCMP2gnXSY2T5j9SyzjQpnKHI81waHUZy46qSrQvosgQ5rh4jY/UMx9fz5duGQ
         gRJ4gK0z4nNS+v+941blcej5Dp1rBC0o9GJ1D3IhSrAJFPvoolTVF963MJev9cA2H9Jy
         2iVWHIx9lE6uebjBqNpHk5NXqhd1oPBwm5Xi6XnoLdevlk5M8rGFmsE5BbtvVqK2xi8/
         aXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154266; x=1785759066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yngGEtXt8XdvhkSci47p7H95S2e1zfXfAmsSjMJsNNY=;
        b=CcKV7B89ADUd0NGtvzdiVy88giHyA0CrZV4rN4Lo24qmw3Z5+2D6JNb0p37sWT5FqJ
         uqR6vlamBRPgOna2lo0DzIoZw9g7J15Q+MaOI3nycIgvCH622WeSn14CeaHm7SydHoky
         Utj305e64NxZHc8KE4w5/N10tQGRDJV7NmOhdra8BSJDyC7MXQPT0r8sszaIByMzRy3T
         g/loGFhu7K4ZOULd8aUpsEUbptAfu1rGgqi6WlE3GDt1SaRl1ebDhRsJjhpoFoYqia3u
         Uk5blyeZjKopekfAFaM3z5AfGDCgSRz5OXqNQ1R2JJ595tJZUYg8aQIkWUOHzISJ/MXa
         r9dg==
X-Forwarded-Encrypted: i=1; AHgh+RrZT5nweR3AEI4QMDGmB8LPThQTQRN8AUXmyl0aeEmby3J8DmEk0QNhkxuuLzSV6K1ch/ojuXGO5BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKaiYdPguMaTK4jas6X7ZeRVSSVtOD79MhwK8q8IXf+pTtno5O
	WrMmuxOTjI58ZbkZCcWvU/2SZKnpFp8kJgYrEUC5OY3E8QvAYRXbPYOUaG0E+gDAm+Q=
X-Gm-Gg: AR+sD12F73Lh/KAhHFx+pAADJhhE3UAFSh9xYKe7PUJiXF5wIpqCYSM4Q6XXNsaGh+7
	/YfHnpYZWSxPAuyq0bYnZmhusbUsiai//+kYFzCLIHzD+7DI63yJ/NXHlQKJqKN8eERCq0OIbLu
	qOeZdd1TqoudXVnoEgdMrTy512b04aqxmV8ADQY7OFCaTE/6S/jP8qy4Q+9HPvfZddvLWyUkvz4
	xV5ccHDb7Oite1sg6lNOjKVg6r73UHZUzDgipT20m2IZTtCssQm8M7qzy3ayC+QPphduL6VNnit
	EPbj28pJANM1PJVCIOjTtfigGV123XDkXsaOMe0m4uZ3cdXYrrNk+xsL13/48PYpIPn3VCoue9r
	eooYGBa3qZuG0nslgPWBGmmRKYf9T7HY5POgAa07UXMTH0Nw7MaDmDbicspNRXDBHMpGoclWX0+
	umZacgO/+AhSHHVCKWp7k=
X-Received: by 2002:a05:600c:5492:b0:495:7eab:3abd with SMTP id 5b1f17b1804b1-496b5736f4fmr117417715e9.33.1785154265733;
        Mon, 27 Jul 2026 05:11:05 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:7aab:bc55:e039:4aac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4f302f8sm211778055e9.12.2026.07.27.05.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:11:05 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 27 Jul 2026 13:10:45 +0100
Subject: [PATCH 7/9] ACPI: nfit: core: drop unused assignment of
 acpi_device_id::driver_data
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-acpi-refactor-v1-7-ff900aa326ee@thegoodpenguin.co.uk>
References: <20260727-acpi-refactor-v1-0-ff900aa326ee@thegoodpenguin.co.uk>
In-Reply-To: <20260727-acpi-refactor-v1-0-ff900aa326ee@thegoodpenguin.co.uk>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Zhang Rui <rui.zhang@intel.com>, 
 Kai-Heng Feng <kaihengf@nvidia.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Dan Williams <djbw@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Ira Weiny <iweiny@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 nvdimm@lists.linux.dev, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785154252; l=993;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=f5yWEycCLmhwNgNs+7yltFCigM8U2L0qmiC75nRPZPg=;
 b=FPBuwEoNc0FwTPiW1OLmoke/+L0vL95t8jlgufvJHvdNH2cU9i9jhCZ2SIOLvvfU3dElEbK4X
 ffdwTvMsuVIB49CLJL8HnAYzDHIg3Q2vmuDwUv6QV0kEAdHSx50UKZC
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

This module sets the acpi_device_id::driver_data to 0 but
the field is not actually used within the module, we can
just drop it from the table.

While we are at it - used a named initializer for the
acpi_device_id::id field to increase readability and
drop explicitly setting the list terminator fields.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/acpi/nfit/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index cb771d9cadb2..5732df5d53f0 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3515,8 +3515,8 @@ void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
 EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
 
 static const struct acpi_device_id acpi_nfit_ids[] = {
-	{ "ACPI0012", 0 },
-	{ "", 0 },
+	{ .id = "ACPI0012" },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
 

-- 
2.43.0

