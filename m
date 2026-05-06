Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D935CBD7
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100053; cv=none; b=h+ITUpgEhwdM0mnlubPR6NJRcc6D3lvBEuAwp0GAQnJXsy2Dwz/FbYfXeNdYIAwt3dYkh7l4KwltUf230sM0hCODfKBJZsP6WoMt/9Bmhy5aAnbJd0xfTt9QE//b+bZJpFKa8VPpYvBPKrutWb/eZTMfRlh27PnFuQKTHEhPOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100053; c=relaxed/simple;
	bh=N1utPvEcBUC2CgJY2X87EWrYwsuzry0dWKDcX8h66DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH8Dg43ycFEPE17Ic75qAhDDcelJDW7pYMMtv3UbsGhcKUkAXwyog5ZXPIxxvbksGyOVsTdijevU6XOZQqP5+DNxVeR5O8nKs9QRbgSFjFZH3X6sRMkHOmtxlDKxLYh+bp0IiFPbnw4MNKKHisa0KKiyCnqIS0Y+G+ucv2SqeU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIMjQzpe; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIMjQzpe"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-83945063f70so654473b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778100050; x=1778704850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab/JEpZ7Fi0qyubDO84DlmrRRJltgbTbtMwqDlljXhg=;
        b=BIMjQzpeeyTopXwFqVsgfksLN2mbJuj1WTDU/RFyIVutzwgeTPvFdDxpkZC6COUobT
         Pva7KSrREIRVb5dPNEdZcuR+ZPGfAEj+TuQc+ssBZT4i1jzCxvhF9GKorY5ADvzXLo4H
         QNG4VH6NadZ2M3fbjI7+sqYdYjhfjGapfRKUSSgJ7hMaV54a9foMIggYjV9km/0hr+Hf
         cWpVabCDnYuqdjsXTgNWX6sUzYqz43gXD3mGX53BIxw4LbbEQxXXfbHBI0BKxHmDxeab
         ZWzPPZZH84U7SGlgv8lH6jwiHj237nFbrIo5mIqU5+iAO4c//z63PkM+Jw3prRWKYTKK
         yetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778100050; x=1778704850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ab/JEpZ7Fi0qyubDO84DlmrRRJltgbTbtMwqDlljXhg=;
        b=llRjjxzXr3Krf7jWrtkWW1nClV8HFxfZjxvwjEGwpArCK0Jbb033L5NZJ8cjx7Dflf
         J9HMEK9XTM3TNn7V/yNfLu/HMPm+uvrlcZBdSUA/U8OdL6ZfnHjubx63VFljGhEuaclh
         NA9m1wDirfwABVlHsHo8+PIJsWu5gW5nX+U3njXepSNHzjpDLepISaQ3D4sDJI9iC4UB
         iPbwcfgjscZU9SA2vLnxukJz21MTUqG68y/laRkQnSDI1qelcsJJjFZbn7Q13/nlKJ9n
         V+iXSAVTnSIJ75mJF0xtSr06+NTKa8LDsLee73hpVksJpv12mqVfnX0eFEV0eQwlhVFy
         4bwA==
X-Forwarded-Encrypted: i=1; AFNElJ9M6oSg59qocoAVoxNSKIxMLG8qf3l6nMlqr3VCDG0p1fOmPof9o8d6WxoSwgIwHdsBLp98NZgqVj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5NWHlEkO2bnwcyJKuSmWsNhw3gI2m6lTyZka8I5+K6pxQlG3
	pJsVDfMuBjPLkUdp1pr2BFfba9JMvOabffo9JMGvQDCOffOxz7scHVI4
X-Gm-Gg: AeBDieub91IQz/t8eyS130jitkcsSFpP6maxeSbLIw+9Qm0fHHmSQWnatipfLTh9xSc
	Bup4ViSK3+k6SJ0HKwALgsXjipa8VIayBtiG7NmmFFnwYVjd7/xzXK8dJ3ZuU69kxxOSRiLaggC
	Uy+gnU+3qg2ZxU0Y9YEv7Sp2nm2wqAm1XCxhdeA7j9C802w68HIOIWmEtCAkypqX16AJST8VdOG
	p+6M1meqKF3PAPDUAjJOYtFLuNhSVEgsBECz7NO24Zxoqt/5eZKMVrq0cDB1Sicz8HK+BXOn0mo
	IdPk8Sqw8wZEoM6x89RJIhsFiWMoZupZL3ELUyJm7h1AkuiCyvuFqcUultvpqDyjCC25ZkeYMN5
	ZaWd1wgFW3iaoBSDbFlABJ7h57w5s0SOwdE0QpY0vE3VflHRN84xhDm/UuynWgvpLc1u5Ymulj3
	/QU8JOMAi40YFwH9vay8y0g7ltqIScW0M=
X-Received: by 2002:a05:6a00:3989:b0:837:d331:8700 with SMTP id d2e1a72fcca58-83bb65f40b2mr96595b3a.1.1778100050268;
        Wed, 06 May 2026 13:40:50 -0700 (PDT)
Received: from mincom1 ([14.67.155.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8396563f11csm7952185b3a.3.2026.05.06.13.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 13:40:49 -0700 (PDT)
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
Subject: [PATCH v2 0/2] AMD PROM21 xHCI temperature hwmon support
Date: Thu,  7 May 2026 05:40:32 +0900
Message-ID: <cover.1778099627.git.hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506032939.92351-1-hurryman2212@gmail.com>
References: <20260506032939.92351-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds hwmon support for the temperature sensor exposed by AMD
PROM21 xHCI controllers. The temperature value is read through a
vendor-specific index/data register pair in the xHCI PCI MMIO BAR.

v1 implemented this directly under drivers/usb/host. Based on review
feedback, v2 splits the support into a generic xhci-pci auxiliary-device
interface and a standalone hwmon driver under drivers/hwmon. xhci-pci
creates the auxiliary child only for PCI IDs matched by its internal table,
currently only AMD 1022:43fd, and the hwmon driver binds to that child
through the auxiliary bus.

The PROM21 hwmon driver registers the hwmon device under the parent PCI
function so userspace reports it as a PCI adapter. The auxiliary driver
still owns the lifetime and unregisters the hwmon device before xhci-pci
tears down the HCD.

I tested register access while the parent xHCI PCI function was suspended.
The temperature register did not return a valid value without
runtime-resuming the device. v2 therefore keeps the default behavior of
allowing a temperature read to wake the xHCI PCI device, and adds
allow_pm_switch=N for users who prefer reads not to wake the device. In
that mode a read returns -EAGAIN while the device is suspended.

Changes in v2:
- split the original single patch into a two-patch series
- add a generic xhci-pci auxiliary-device interface
- move PROM21 hwmon support to drivers/hwmon as an auxiliary driver
- avoid linking hwmon-specific code into xhci-hcd
- add Documentation/hwmon/prom21-hwmon.rst
- document register offsets, conversion formula, sysfs attributes, and
  allow_pm_switch behavior

Sincerely,
Jihong Min

Jihong Min (2):
  usb: xhci-pci: add generic auxiliary device interface
  hwmon: add initial support for AMD PROM21 xHCI temperature sensor

 Documentation/hwmon/index.rst        |   1 +
 Documentation/hwmon/prom21-hwmon.rst |  84 ++++++++
 drivers/hwmon/Kconfig                |  11 +
 drivers/hwmon/Makefile               |   1 +
 drivers/hwmon/prom21-hwmon.c         | 300 +++++++++++++++++++++++++++
 drivers/usb/host/Kconfig             |  10 +
 drivers/usb/host/xhci-pci.c          | 114 ++++++++++
 7 files changed, 521 insertions(+)
 create mode 100644 Documentation/hwmon/prom21-hwmon.rst
 create mode 100644 drivers/hwmon/prom21-hwmon.c

-- 
2.53.0
