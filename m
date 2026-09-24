Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B22444238A
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253778; cv=none; b=g88T4tH+7+tSkHhRoZV6fOtH3aIMQnERD+hOkuBZv+3kTMaNWDE7stwg6yX7nzCa/FZgvWXTMbDb1eC10Cvo+dHuP38zFy+QwLLbQBTUjSI3FvUFE5DqLs9SGSpTWm28/W+FamlFfUZwqBb4FF25xOJu/HkfdFkDh9ER9h8fm1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253778; c=relaxed/simple;
	bh=nP84PB3kRCTCnlOz1Nc7H4NTVYOtR4vU9qO9eligIho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDyScyCixJwiVf0lXGtt7/tEcRYYX1gZOAJzuEwq0p9s/09w81wKYBv8E3qC0HgeyUukuMK6ha+R1EZaKcrc0e2iqVtuVBDppMUajT94DD9Acqx3zpKR6aK6qNvL/tmskhxf6N0DAAOhEhF5KisoduDVcWK284+9u7Y6Sh18Z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfIQTf7g; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfIQTf7g"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab18so638954c88.0
        for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790253776; x=1790858576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yLhM0k1QZB/+EkXXYqDnetrlY3awQVlONe5SUYK8ebc=;
        b=TfIQTf7go+LelDElSsQDh9v79KldngZrQ8IQ+b4c1nnADzUjCV3XhN/8gjXar0jwX5
         B4No3ZD17hhXSUkoa3u0GNj5TIImvSz13lviliKfX6r5XcfwTsP+qdM1IjUelgRR387C
         qdykUt4r2TAn75UhF/UkIDKF2J0yEKrcVdsFt1K+AadCTcnT/rJY67UFaQtjwzA+CLoX
         nRcJONfLcwIqP8U0ntycC3Gld4LC1Sca0Uu0DUYK0XgT8OkBj0zr6nhkQiB+CEmSOxsE
         ahXZgeigbKDWr/4Ty/Oaayjs6n6orbh34rCFxDLgs7i/4geg0rGjPxHZxTCi7BKFm9Yg
         O0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790253776; x=1790858576;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLhM0k1QZB/+EkXXYqDnetrlY3awQVlONe5SUYK8ebc=;
        b=s+O075RPbksesw1XHzNQyfhkjO8g/7Evy4bhdubjG1AEJO51ca0m4NHyeKIqZ+hUhP
         GS0yMwQJJAXvaBd+xv/170Hf63G9NkXuRPA0lNULjAIA6WAYgi5imT/2S2UT7bMH/3VL
         FM1oo18jNIIm0ram7iviqLei+jJ73JSdpnDt78MOEtq8feLBItQ7O1rDjFlBgIiADER7
         POcqAgcTV63BVBW6TeXR8YC7byZwoSUioBR+CCPeOeG+WCVl+TLiPQmxyL3J4x8NQgnV
         mSHC0KUQati6aLyoYsZHNH+/TI5pJwhVuBIQ4ngTMRa1kbOfdgwx+Vdml3v8XUh+/+Ne
         h/fA==
X-Forwarded-Encrypted: i=1; AKwUvBxfM6Kgy8AMCiEC2QdRw98sH67+d1IL45IvvasUyReIH7slNeO2TcFZb7LMX1kJ/uyFBbJajmzNi/Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lAmTXfb2Sv5GcYs2yfWWegm9+Eu0D/UGy7qdqq5/tiaY5q2d0L
	Y2So/pcN8uIvvttbcVpsvomVw0hl2ILcqRur0k+GKrvXUJFLdxlcs/pp
X-Gm-Gg: AYBFou25+41Vq4/gp0pr8qgfsNfyPgFenI0nelV/ZX0Iku7wrkxlcvi4IS4amL798//
	zcYIYKTTyqaL7XRZUgQ899llySPuL414t5xuvEv/UvzILiMQkQoyix2RHs5WEDGlhe7GU+qsENr
	xEeYBcuQReFPtwdNilesR8fufyIya9rgyj5dWsqHZtRsy4H3OxQuSNhbcctD3sLlS8wCnD41vmb
	LCtV4efD4R9gwyOZdnwOsp0+qFe183S7swNOocJB5l0GybikuZIgEuVDz5sYF6KXzbRgKlzGW5w
	9eGv/lnPkYJTPq/Y6p7AncV+cXhgIxqDnn7SyJ3jwTyO/gyZMnCRxt+YlKO+po5z6fRI1OTPyod
	yaKT6vtjgqQpCLH+O4V9GQGlOQUplxfn+IqsLV+PBo5e0u6KW039gM9ZsHOxc7x8n85btMz8h+N
	yrhUtutmjBuTAcOYs/Z7LflQYOQpRO2fiBviKcG9Ws5Kg+Q8im8rJw7/gvloQr3Bkar3l1bvKu1
	RxyUbwi
X-Received: by 2002:a05:7022:b055:10b0:144:f47d:c2d9 with SMTP id a92af1059eb24-1450402286dmr1943677c88.38.1790253771515;
        Thu, 24 Sep 2026 05:42:51 -0700 (PDT)
Received: from maclinux ([2803:c600:9110:8ba5:43a9:9b8b:ebdc:6411])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f986e465sm13466113c88.9.2026.09.24.05.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:42:51 -0700 (PDT)
From: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] usb: hcd-pci: Honour pci_save_state() failure
Date: Thu, 24 Sep 2026 09:42:18 -0300
Message-ID: <20260924124221.12374-2-fbeltranmillalen@gmail.com>
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

hcd_pci_suspend_noirq() calls pci_save_state() and ignores its return
value, then goes on to call pci_prepare_to_sleep().  pci_save_state()
can fail -- it already propagates failures from pci_save_pcie_state()
and friends -- and when it does there is no saved state to restore
later, so putting the device into a low-power state only makes matters
worse: the subsequent transition fails too, and the PCI core then warns
that the callback returned without saving the state.

Check the return value.  If the state could not be saved, leave the
device alone and return success, so the rest of the system can still
suspend.  Leaving the power state untouched also means the PCI core has
nothing to complain about.

Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
---
diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -541,7 +541,17 @@
 	if (retval)
 		return retval;
 
-	pci_save_state(pci_dev);
+	/*
+	 * If the controller is already inaccessible, there is no state to
+	 * save and nothing to put into a low-power state.  Leaving the power
+	 * state alone also keeps the PCI core from warning that this callback
+	 * returned without saving the state.
+	 */
+	retval = pci_save_state(pci_dev);
+	if (retval) {
+		dev_dbg(dev, "--> not suspending, device inaccessible\n");
+		return 0;
+	}
 
 	/* If the root hub is dead rather than suspended, disallow remote
 	 * wakeup.  usb_hc_died() should ensure that both hosts are marked as
