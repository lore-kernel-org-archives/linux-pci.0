Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1D247DD76
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253784; cv=none; b=tR0r662mW7Po1Qqneoet5bquJ3P15AN+HWQ5iJ3b4DX++OSDz6aRBa4vCqSZ84r2uWSJO9et+csfHTtmWwVTh1l95dlzx6oRTW8SjDHSXiGvsRHvZ1mfupf+DlKGb1vuIuyLAQ2Xh+YUbncQUHhclYN33JE6JnDdPmqFQEkGyT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253784; c=relaxed/simple;
	bh=iSvvSNclJPG2ooYiR9bHRNj3aceifTgkKrBOLKWAyB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mas8QkM2gUAF19KWauKZBk6YaEHL/gs4QeLwRSL8rC6eEeAr/FUybsG25UyoQAA27+5sAunXmnkT0V7q705dCPiudEznPC04LUyy7KUr0PseM+9qPcu20FbaYKJzpgmPZy73CGOnWyAbdI3Nm2uOi8iBDyIBMkqsxyRPNRg+UIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knqcXpX1; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knqcXpX1"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd04f7f2so2184270c88.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790253781; x=1790858581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3nSA9EEF3/n3h1KuMWloOJQEZf6Lv9q69NWlFq+IQMA=;
        b=knqcXpX1HYDFlM6xJNqj6/I99wiQHxzEUFptVmk5ZGa+hFvxG28bXy0XT/GV0BxkJh
         m1GFRtv3gcNtYhJawk5Gw9/WTR0XrZ6cga8KvST3NJMiJOnZt+4gAVWn4M1nb79TGVMQ
         UCNvitdrOuhPArXp4C3tnjRjot0O04hH6S9jYtow/Ay54Uj73LwAH3NvGTNqMTkZtrT6
         Z32V7YeeoiweeLuMapO6zBR0L/ua5HbWp3qql1DipzOCnwePioIA67m5A0/bTzVSMyCl
         AFbNDTCigLbIDNWAc55SyDAkJxvhqMqLtNJQPbjMnehFE9dfRkPzq9UCilqhvLCCMfqW
         zYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790253781; x=1790858581;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nSA9EEF3/n3h1KuMWloOJQEZf6Lv9q69NWlFq+IQMA=;
        b=1ZB+7YXrCuTs8NXo+AtWBSrjHvKACjX8KpqKuBAuXmDQ+dNY+FWlcoL2QWPliRFsmP
         4cGAhhSY5cXpfnUkwoiDIccEPsYlwo/uA/WlQ4XPK92ecctOihvlTixPxjm7EE94ecfK
         mw62sRPz7f3704HeOM34Tk2Cm5gcC/PHN0ah7MCfnVUOOYa+WFp3tERsxWvii7xKDnax
         WG7uTM9ltndNKOf86I5aYO/5VcGHisvlx6zJ6sHemAqRRYBH3c7Rel222Q4cuntQDPhm
         onWI0k8c8enH7SfMzbMbnjeLHSdlsK7Qs/rL/tqlaPBc2dBAOEaqEXljDggYdHdUmG6S
         L01Q==
X-Forwarded-Encrypted: i=1; AKwUvBy6idIQHHsc56mvkQiZU0sdJNzrl1fh2s/8cfWwjiXVEJJ9HGKJJQZRXqD2MFVJZ2/AapkYdZkWi78=@vger.kernel.org
X-Gm-Message-State: AFuF++kKBSpltrdFIEXcMD/140TY3pEplbcNukLZpNoYV+FNlYmTXGXR
	7HPElgxxIZMxI9kzvX782x6FKFeFI8PXm+lFbnwQMLaAJJ3Kj+0bY9VN
X-Gm-Gg: AYBFou28viOSAuGeY6gC4n3CH1GcmlvGgMwb1isCXc4vsPv42b95XDd7p2IFJbrGzf6
	feB8fciZcc3Eit69S4O6ZjP2+4MBsbGLctbkFGMMx/ZDuOzmTegNXdFaaih7RH01XPwyw0zXnRz
	HgRUQUl0hWNscsRf5KoDVWNLP84DHcTVO6d/g5D1axLG4187nylX9DZaCutmcNzSGcVuo/Odc7a
	EmTlqsnxerSUtFiw+eu7DUXlmzLcQ7zoi0hrNRheDCywpyKOSFks+/35Fl6Yjm6XAerUZCc0lCu
	+OywUH2ZlGfLHUf+ySIfYGfgS0LYp6Xoh2U/aEyqC3HVt3HbqSugQiFdbYl5OyXJQ5sNczNlRvO
	OGbLIlR58rqbRTqY3avz0Ni1meyb9y8PWYX+lPCCjN3M0jHOjDWIKWpg31JGrxnrp69SSlvaDaa
	c2CHUD9UZe1Za7+IK6vw9q0qV30ImlhWlyDuiqNtML3+kbLSp+MCU7dKqjEWF7K2S/ULoJ5wbs/
	arLI+je
X-Received: by 2002:a05:7022:c4d:b0:143:8829:5fb9 with SMTP id a92af1059eb24-14503f3c3fdmr1827214c88.16.1790253776803;
        Thu, 24 Sep 2026 05:42:56 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:43a9:9b8b:ebdc:6411])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f986e465sm13466113c88.9.2026.09.24.05.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:42:56 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] PCI/PM: Do not restore a config space snapshot that is all ones
Date: Thu, 24 Sep 2026 09:42:20 -0300
Message-ID: <20260924124221.12374-4-fbeltranmillalen@gmail.com>
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

Belt and braces for the previous patch: even if a snapshot of all ones
is somehow recorded, never write it back.  The vendor ID of a device
that was present can never be 0xffffffff, so a snapshot whose first
dword is all ones is known to be garbage.

Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
---
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1833,6 +1833,17 @@
 
 static void pci_restore_config_space(struct pci_dev *pdev)
 {
+	/*
+	 * Vendor and Device ID are read-only, so a snapshot whose first
+	 * dword reads as all ones was taken from an inaccessible device and
+	 * is garbage.  Writing it back would corrupt a device that has since
+	 * become accessible again, so leave the hardware alone.
+	 */
+	if (PCI_POSSIBLE_ERROR(pdev->saved_config_space[0])) {
+		pci_warn(pdev, "not restoring config space, saved state is invalid\n");
+		return;
+	}
+
 	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
 		pci_restore_config_space_range(pdev, 10, 15, 0, false);
 		/* Restore BARs before the command register. */
