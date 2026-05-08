Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04773502A9
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251179; cv=none; b=tHHyAx+kfuYBD/h/CD+TuzP9Li+5UXzpEKZBuKLQFaV4Rz2DqaZHyMM0EPTBpKvafUmnTdrrgsg7W6zNmS2gEyOZdpKMaE/mZVMhrmLTGlSxG/ZLbjzLV6doToSFLlnezHypzHIH2l/VkRf7L+3WCz5haYWvjWLmOQ+TpXlBkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251179; c=relaxed/simple;
	bh=CRo+41M0qXiyDrMxBRd9ybpoOu9d/b6QhFbdrm5JsyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iHghi3kGgnRvb+0O/NvxS2HTjI4LwQas5W8tX+s+7++El2ed9yYbMEMWLV3wavbDLXS5k02Svfx3qm+622V7voD/JXiOjxk6/jMyse+9Qg3muONl/1O4DVvNSwmNu7TJrcuwSurTrJRCHNxHwail9STSCzPsEPjKOdgL5YUAjfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISGHnfyp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISGHnfyp"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8016d642b2so1476479a12.0
        for <linux-pci@vger.kernel.org>; Fri, 08 May 2026 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778251178; x=1778855978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXdrkYkgPTA26PL0ikladf23kOngeqlDqPwT8C8tFUc=;
        b=ISGHnfypC8TkYLFtcBPjBgtTf/t1/VHlTkBaNu9CxUeh8/3DjOGCSNd0CxfBjBTWla
         FYVR62/Z8jthfzurSzCaxFjKex4hdTGk0U4jskO3EPnZUEleJHuYd55wJ42Rab/aeMgg
         AYZ1P9Wo41umOlANk0PV2BsGljOhHcvfNKf08HOMS7LB5ZrmRy4U+QKnVH7u6YNXNJoW
         1QPLizm83TJiIjhweZzrhEcmqsv7wjHK55U6xSokNskri5tyIKlKUKekUqFgRVYCZeiW
         uqRuly1BQciK35kurXe65+6o9VpIrckq2YUwK15rN0u/FrMw1UcKW2MGHAJcvMYldufO
         C/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778251178; x=1778855978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXdrkYkgPTA26PL0ikladf23kOngeqlDqPwT8C8tFUc=;
        b=HAAZlJmdoz50gbrXb2r0bgl3kWe2m8Fn4zop+/bf0yTB7wNMxaJQPbGvLE8QYM1N1G
         PBlh6K7Ny9hGJcsn6y4eKcw4BN2wtvRc4TZOOq1d4wWauR+Rt7BPhYiwOmY+Go+DsFZY
         /eG8wYDmH9NZTtX1lukQyirSQzewyXYQ18Gbuh6HDlejjttbNAaEvPFJrF3qyGSLa2xE
         Pa7P+QEP9J50gNX3P3mnELoej0jtwtgZporUl4YL8rhryWzQ9L43Xaj8yKiGkRLVOBYE
         LOvOb9DFlDP22ndZKmgDT6wDSppGjX44Us0ZguQgP9uEgiTJkAoVEvyu6Mt2ilRX9YeH
         MpjA==
X-Forwarded-Encrypted: i=1; AFNElJ9bAZ1FjTt6oG6PKB89a6Z1eroHTBSK6yrv162MZsaJ2EQvPd1IBuT8AE7V1RSe0d6txAhKqPoaOQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg6IledDDC5sQaczzofK7IgcnZfZDIJ91MQbaXAbm0hDjaVIn4
	oAJcUfsKAP2Q/m2maAE3bzqHg/mKwlonWV1U9AjqQnYvyvh1+m/65c2P
X-Gm-Gg: AeBDievIIw5K10nZB89oZXirEuCrRpqagYE755dlJ5gdKjD77tzzeiYj0njdYlmbO8R
	y0F0obaMXWynlogIvf7wsIOQR9T62dg7ezaUAuzpwEXhnaKmrpxQo9ybBD4d8MYryqLlf4a93YI
	WRHmstPXKo3aS9YqU9F4XVBOvKLeEVn5BAh2LJ7oNYGtZJzWpzKXbfFBJnJ6XNbY4yjYIbfMogI
	4f6HMNfB2G8rxHEhovdP9ryUv7E11DTCOsZazdEwGHwlZdQqJPaRecGyviPSlp5hiG/CxX9MKZ1
	bRVUv+r3CbXXqs3HxUHTDMFwWI3S6wsswCBiTlH8tE98ZR+FfMdaHijW4MJ9ZFONFNtgEkkZTMo
	5rJxLY/Ctl24Vdy9SqTLovdUagOXT31CUCOO74JDA4nyySt5SaGo3xphgPAXBYwVf8AWkxRw8F8
	Y1hp0lvCrFhC4ikhIUmaU=
X-Received: by 2002:a05:6a21:3393:b0:3a0:babd:b959 with SMTP id adf61e73a8af0-3aa8beb360amr7436988637.9.1778251177970;
        Fri, 08 May 2026 07:39:37 -0700 (PDT)
Received: from mincom1 ([115.4.79.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8462sm12395499b3a.38.2026.05.08.07.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:39:37 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [PATCH v4 0/2] AMD Promontory 21 xHCI temperature sensor support
Date: Fri,  8 May 2026 23:39:08 +0900
Message-ID: <20260508143910.14673-1-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds temperature monitoring for AMD Promontory 21 (PROM21)
xHCI PCI functions.

Patch 1 adds a small PROM21-specific xHCI PCI glue driver. USB host
operation is delegated to common xhci-pci code; the PROM21 glue only owns
the PCI binding and publishes an auxiliary "hwmon" child device for
optional sensor support. The glue is built-in only when enabled, matching
built-in xhci-pci, so PROM21 controllers are not left unbound during early
boot if an optional module is absent.

Patch 2 adds the auxiliary hwmon driver. It exposes temp1_input as
prom21_xhci, does not wake the parent PCI device for sensor reads, and
documents the register access and empirical observation method used to
identify the register pair and conversion formula.

Changes in v4:
- Move PROM21 PCI handling into a PROM21-specific xHCI PCI glue driver.
- Make USB_XHCI_PCI_PROM21 built-in only when enabled.
- Rename the hwmon driver/config/name to prom21-xhci,
  SENSORS_PROM21_XHCI, and prom21_xhci.
- Return -ENODATA for suspended parent devices and invalid raw values.
- Remove temp1_label and the runtime PM module parameter.
- Simplify hwmon remove/read lifetime handling.
- Expand hwmon documentation with register access, runtime PM behavior,
  sysfs lookup, and observation details.

Jihong Min (2):
  usb: xhci-pci: add AMD Promontory 21 PCI glue
  hwmon: add AMD Promontory 21 xHCI temperature sensor support

 Documentation/hwmon/index.rst       |   1 +
 Documentation/hwmon/prom21-xhci.rst |  99 +++++++++++
 drivers/hwmon/Kconfig               |  10 ++
 drivers/hwmon/Makefile              |   1 +
 drivers/hwmon/prom21-xhci.c         | 250 ++++++++++++++++++++++++++++
 drivers/usb/host/Kconfig            |  18 ++
 drivers/usb/host/Makefile           |   1 +
 drivers/usb/host/xhci-pci-prom21.c  | 111 ++++++++++++
 drivers/usb/host/xhci-pci.c         |  11 ++
 9 files changed, 502 insertions(+)
 create mode 100644 Documentation/hwmon/prom21-xhci.rst
 create mode 100644 drivers/hwmon/prom21-xhci.c
 create mode 100644 drivers/usb/host/xhci-pci-prom21.c

-- 
2.53.0
