Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26FC4432FF
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253777; cv=none; b=R3Fz9IY9cloQbWF0WH1w0AZGzB5gcrsApM3QbSGFBK1RbHH09vhOqjOqk/O+Osm6R/Z02AaL3pBYqngE1LFG8f8VyhlIb1fp1dge9C9U3NZRBFwjV17OWKjW4EjzdxIz/Lx3OMi3cPDIEFuvTkwz1ZXrkl6L+tmqhQIxXJBZhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253777; c=relaxed/simple;
	bh=8FgMrEmm0JiYVw6ocyB7l9dBdrnuGH2s4bxgWJk2VSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/3d0QI4VvQ6kE1m3VvehqfzF9NvUaWaEd+umaXQJ0Uxym18uLPGNzycQu3FjMw64YqKEBhGvnhXXCFy/qN2C0eVLHn1n1f/agCsC7GR97boux0DH15M720QIz/hT6OkDVBdlA2o9Tf5gNgMzIsru/vit7Q3LpdDsAySDsjQdew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRS/VT5M; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRS/VT5M"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04be84so2376545c88.3
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790253774; x=1790858574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zh0cibQ7z5HGBDLn9XfRjT/3Pcdpg2HZa7+pEHrMH5Y=;
        b=ZRS/VT5MWHrEHXgX3iOtzN7LCtdWMtItu61eG8TthTl5EHamXMqIJ1lHWfWWiBxCuT
         hq+sReBzY4KWrLZg7Hq8Z7fKS2ma5EKrURBJhOj7CBsKDpRbZKjMEw52tiBgb9CTU1Cz
         XWER6kRFanJON3SVZjMBH7jw6EbccvESKOLDyAXPUyU19CFnyCUmxRyIcOEAXIhKVsDt
         umjRh/IopISHHFb3AwljyG7baZ8GD0JkgNi90CtyT1SGaj79H3Um9ahUFFElka+ZvH4d
         Z6IhMahNJ57elgXzBuJPpgp9yOYOih5KspjP1SkIFSqGV79DCpraU3jR5/JjDeIBA3Dh
         tAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790253774; x=1790858574;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zh0cibQ7z5HGBDLn9XfRjT/3Pcdpg2HZa7+pEHrMH5Y=;
        b=YjdDiG8cvrPoggeOLXnBalbrim8hkToCWRhzVlmi/ey1QQCyTt/kR7kym0hER9HUwV
         +JQuExj35m2WNYssw8Ho43NJ86JY2Srn+TI4jzrsQ6UQCdcV0nvAg31P+ZYSXRQsJpkP
         7ruIozUa3CSjGaWQMGyF3VIJRxVM4tt7XRH7A0DQdM8/QFhshkfKUCoX964rUpR/TwvV
         OEg4bTPVhwizoHvIdMHJM/GDhDskDamWptL4jUuqjjN0zRhh7yvTwWpSYlNfrrNH0Z0N
         4j2bDQdg9Md3Aa6cQ5JE5J/1xkhJa9pQTTEfNMb0j5BplXTn27/AyzsLr7aB9aDsABFV
         J4Ow==
X-Forwarded-Encrypted: i=1; AKwUvBxs1XQadA3KQ6y1qkkJw+Y7k1bPpjntxFZXYRy4Ayd19akqnXzupVT3fzUOfRYOIADxd7BozC/xcBA=@vger.kernel.org
X-Gm-Message-State: AFuF++lsuAEponq9ph2laW/OXBWROrWb1CGRmPucE73KCuQLJpk0UMM3
	gwwpMVQuat5AhFELvIxhaQA3icFOWSnb712ef0EEbmEQmDJL1zwPVompqFggia9h
X-Gm-Gg: AYBFou1HXwVJa0rEciihOgYJ6jL99h39g8bOhk3wPtSdGUFOkIsp2PAr5xC3/IjBe0P
	Mn62QGNdr0tIQqvaSsu4a4Ex4nx35ZB0bNb1B+Kh8broDXsY1HbI/qwtN3vnquux5vV5u1kEAn7
	57BdpDrNHkh8/KdkYMTusCB7JbMB0Wu4vRZ54XbhRRIyyz81FrNhoLgMZmTK5/WjNSUZAbXONJj
	ddNBrBC3lPxRyRIfEITTkPBag3Dz70EBemy4/UraTiQwGw7AN/BsEpn1F3Nyw4yPZOGXD4byn4c
	DUPlE7UZPagxRXFeEk9Lb+ryPiAKVWtGVpcxk928PXHQGSK5RghwFyTqCI6K94T5ezWUCmeY53Y
	y/iQfNxtYUgQLjazsM7vOmsaT/3fZl+w+37CChl3NYaAn3qUq8STVJ2iYs2iZOJMwwSvw4/ZZ+k
	W3JI+eqhNvpBhI+x9/XLDIVm9pSstzG48a4GZTcpe/+5aJAMcKSAg7I4IJdhYfiLVLm0M5cRtAr
	0fY49h0
X-Received: by 2002:a05:701b:42d0:10b0:145:f4:13ff with SMTP id a92af1059eb24-14504057eb9mr2029569c88.43.1790253774401;
        Thu, 24 Sep 2026 05:42:54 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:43a9:9b8b:ebdc:6411])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f986e465sm13466113c88.9.2026.09.24.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:42:54 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] PCI/PM: Do not save the config space of an inaccessible device
Date: Thu, 24 Sep 2026 09:42:19 -0300
Message-ID: <20260924124221.12374-3-fbeltranmillalen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924124221.12374-1-fbeltranmillalen@gmail.com>
References: <20260924124221.12374-1-fbeltranmillalen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_save_state() reads sixteen dwords in a bare loop and then marks the
snapshot valid unconditionally.  If the device is already inaccessible,
every read returns all ones, and that garbage replaces a previously good
snapshot.

Restoring it later does not merely fail to help.  On a bridge that is
still alive, writing all ones sets every writable bit of BRIDGE_CONTROL,
which asserts Secondary Bus Reset, and clears the primary, secondary and
subordinate bus numbers, which unmaps everything behind the bridge.  On
a MacBookPro14,3 this is what removes the Thunderbolt USB controllers
after a suspend/resume cycle: the bridge keeps answering, but the kernel
has just written 0xffffffff over its configuration.

Check whether the device answers before saving, and again afterwards,
because it can disappear while the loop is running -- on this machine
the window between a successful read and a failing one has been measured
at a few microseconds.  Read into a temporary buffer so the previous,
known-good snapshot survives if either check fails.

Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
---
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1740,13 +1740,43 @@
  */
 int pci_save_state(struct pci_dev *dev)
 {
+	u32 buf[16];
 	int i;
+	u32 val;
+
+	/*
+	 * If the device is already inaccessible, every config read returns
+	 * all ones.  Saving that would replace a previously good snapshot
+	 * with garbage, and restoring the garbage later does not merely fail
+	 * to help, it actively damages the device: on a bridge it asserts
+	 * Secondary Bus Reset and clears the bus numbers, which unmaps
+	 * everything behind it.  Keep the old snapshot instead.
+	 */
+	pci_read_config_dword(dev, PCI_VENDOR_ID, &val);
+	if (PCI_POSSIBLE_ERROR(val)) {
+		pci_warn(dev, "not saving config space, device inaccessible\n");
+		return -EIO;
+	}
+
+	/*
+	 * Read into a temporary buffer: the device can become inaccessible
+	 * while we are reading, and then only part of the snapshot is all
+	 * ones.  The previous snapshot must stay intact until we know the
+	 * new one is good.
+	 */
 	/* XXX: 100% dword access ok here? */
 	for (i = 0; i < 16; i++) {
-		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
-		pci_dbg(dev, "save config %#04x: %#010x\n",
-			i * 4, dev->saved_config_space[i]);
+		pci_read_config_dword(dev, i * 4, &buf[i]);
+		pci_dbg(dev, "save config %#04x: %#010x\n", i * 4, buf[i]);
 	}
+
+	pci_read_config_dword(dev, PCI_VENDOR_ID, &val);
+	if (PCI_POSSIBLE_ERROR(val)) {
+		pci_warn(dev, "not saving config space, device became inaccessible\n");
+		return -EIO;
+	}
+
+	memcpy(dev->saved_config_space, buf, sizeof(buf));
 	dev->state_saved = true;
 
 	i = pci_save_pcie_state(dev);
