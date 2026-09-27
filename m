Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615741B8F2
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790528121; cv=none; b=q+1dSbOr2BieZy55DZNK0xMrQsf0AUXd5PSebZaHx3y9KEhTd7Rl7PZPfUmQNnWTyEGQU1VqnQe6d41zmPy0013oOtegkp5u+4/ITu5MhU7W0/jScyt6mieTr8nKmx78gagpBxLQoqcNFDESZ1Ogb/ZM7t6hBdCyO/PPo1zgcIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790528121; c=relaxed/simple;
	bh=kMzfa7XtfKfG3RJ5zxPo/y9bJ/v4XnXOewXyeN4/zW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mt7BUsXe1imBc5jHpBRrdINA8BB3zMyKszLcplBR2aXgdn2HnyTX534I0MXU9uDUHRWgKUoZVmevLP4ObGu1RzVYHjYlXsZXeiSqKhZncJ680fQLcRGEd+e8BND9HDNR4cmFunB6Xk/SztjRhvQvDsW2yaT9mEy5R7EuQSI9iBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pkePKVuu; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkePKVuu"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffde3cec6so4475575e9.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790528118; x=1791132918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nO4LPQO5B94BniGFyWk4r3/clPvyPjMU90wwNe9Utio=;
        b=pkePKVuuv6MA9yQ73Ibpie4V9Tx2XE+OCinzLUlNVS7I3IXzNkNi2uGctT4yDIvn5n
         gpigLAKMomOchJOKi33VrPPIg+6k0gO4sBEaqjqfJP0JnQh3HsqJTl2nOFnYoBwuuQgJ
         UpXPxmPeusyCaNmUAqlwvkXPJZVpMIGkdm0g17Fgdd9jx21jab+oqyH5E8uY9qZH8m0X
         T5n++aYyYX4etS1vkfngkXh6yGD4p8EA+lVSZvhrVo/E6198BUYTom4MQcWwUtPSLKc0
         u9G1jl/TqXINGeIVQe0GxAfANTGUVsZU105nlxSjmIFJaVD2T1DTgKIG/eJdglldIAR9
         DLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790528118; x=1791132918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nO4LPQO5B94BniGFyWk4r3/clPvyPjMU90wwNe9Utio=;
        b=p4yX0G9kQrcDIT8ZXllmFYobAixU2IRfdsTf68dEFxrT+CwMNQmp0KfMbgfu8k6tP+
         81QUxL9z2MtUBsxETU8e6DQw5gyBpGL5nLeF6Kawajw9WGe5lYfVY0F96hlXpKNLQqiV
         sjLCpBmm4dVwToELAX6kHwRrYCDX2ysUPF313NeMEuCkOGqhf7WcGaGVpyTfa+xj9xta
         PsXM36H8KexbciDwaWZ/cYKMBMPUEMB9X6iE/j0EueZ4zURxSmoyIBUbjuUOHwABGGgR
         XGW2jixm3YYodgQepAc19p6/prE36x5VEPDS7UQQ2YtcDnY9z6ySP98PMmIcsH4cZtpA
         uFqg==
X-Forwarded-Encrypted: i=1; AKwUvBzAjFXkk6IioAfTW7jt6JBU0iXf47EIvg0XyhvVEASMP1ygPhv6Tqs+jzrCYs7720rPKMnjgafCulQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lk4evvbx0L5F2TVYMmPaDZgKyCvCfuWKLiJl+c2JgiC5ckIEMg
	cQCqtyrFt3g95kYwDS6h8OKf+lDvVe+ILW6Y2EcuMu3+jis2kA0cUVn6
X-Gm-Gg: AYBFou3BQNp2MQODl6IZ6sNqkWOEYITyH9ywsMHQt7Jb/fPiKrqop5aRkTzAJfw4/zE
	RXRUf8wnBXCz8GMoiKgdPmqHgR8QuY0j3jGHAdTm8QtNjLU1LbYAGNG+Teyjvokjv3m4+1uGqjt
	CPCXqfdLep6DrHAzn8PAGBqW1kqCTZZL2Nap8gdjJdZYronj8/kVro8OY3jw0zlGXA6d3avsogK
	B0AsUIbV0wVtsE9p31BgNt4982AxfWxPPcBLoCLF2iztCqd3qmitWe2m0wr+it/NcCnLcwbSNOZ
	c9MueKl7xJbkv1moygvU3El6nGeZxOlORe18a5qz/TMWVsG6jSgfrekAaFUbnhUio2/em6NcCja
	seKJwVyhhM+XBGZHWj8YuCuauL+EfZegKlNP8UsWEywAfgEVSEjhQsJKN5yiCYwFE8gf1gDX6Di
	H46DQgfq/Pe0rWYU04sGCkvQlHVAVVKaWKtQfyroNNZXBDTJA/ylS+1JnnBU8MRlbUmm/F8mwM0
	dbq7beA5KwPS89tFUHaFlgikPrb082wA58NrgE5Vl4jPicsYJZRFYD/m2xyGPlxrms=
X-Received: by 2002:a05:600c:3b87:b0:49d:1916:59c7 with SMTP id 5b1f17b1804b1-49fe66c8a4cmr227126485e9.7.1790528117881;
        Sun, 27 Sep 2026 09:55:17 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00178bebasm76167695e9.11.2026.09.27.09.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:55:17 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Kees Cook <kees@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC v2 2/5] PCI: pciehp: Add pci_hp_wait_link_change()
Date: Sun, 27 Sep 2026 16:54:55 +0000
Message-ID: <20260927165459.829900-3-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927165459.829900-1-abhinjoses@gmail.com>
References: <20260927165459.829900-1-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_hp_spurious_link_change() awaits the end of a code section causing
spurious link changes, such as a Secondary Bus Reset, and then tells
whether such a section has executed, using test_and_clear_bit() on
PCI_LINK_CHANGED. The answer is one-shot: only the first caller sees
true.

Split the wait out into pci_hp_wait_link_change(), which leaves
PCI_LINK_CHANGED alone, and implement pci_hp_spurious_link_change() on
top of it. No functional change intended.

Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
Assisted-by: LLM
---
 drivers/pci/hotplug/pci_hotplug_core.c | 21 +++++++++++++++++++--
 drivers/pci/pci.h                      |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index fadcf98a8a660..c3e0ee8b36381 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -528,6 +528,24 @@ void pci_hp_unignore_link_change(struct pci_dev *pdev)
 	wake_up_all(&pci_hp_link_change_wq);
 }
 
+/**
+ * pci_hp_wait_link_change - await end of code section causing spurious link changes
+ * @pdev: PCI hotplug bridge
+ *
+ * Await the end of a concurrently executing code section which is causing
+ * spurious link changes on the Secondary Bus of @pdev, if there is one.
+ *
+ * Unlike pci_hp_spurious_link_change(), leave the record that such a code
+ * section has executed in place.  May be called by hotplug drivers which need
+ * the link to have settled, but not the cause of a link change, so that they
+ * don't take the answer away from the caller of pci_hp_spurious_link_change().
+ */
+void pci_hp_wait_link_change(struct pci_dev *pdev)
+{
+	wait_event(pci_hp_link_change_wq,
+		   !test_bit(PCI_LINK_CHANGING, &pdev->priv_flags));
+}
+
 /**
  * pci_hp_spurious_link_change - check for spurious link changes
  * @pdev: PCI hotplug bridge
@@ -551,8 +569,7 @@ void pci_hp_unignore_link_change(struct pci_dev *pdev)
  */
 bool pci_hp_spurious_link_change(struct pci_dev *pdev)
 {
-	wait_event(pci_hp_link_change_wq,
-		   !test_bit(PCI_LINK_CHANGING, &pdev->priv_flags));
+	pci_hp_wait_link_change(pdev);
 
 	return test_and_clear_bit(PCI_LINK_CHANGED, &pdev->priv_flags);
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 23b1605e783a3..2e113806f9f95 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -360,6 +360,7 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 
 /* Functions for PCI Hotplug drivers to use */
 int pci_hp_add_bridge(struct pci_dev *dev);
+void pci_hp_wait_link_change(struct pci_dev *pdev);
 bool pci_hp_spurious_link_change(struct pci_dev *pdev);
 
 /* Lock for read/write access to pci device and bus lists */
-- 
2.51.1

