Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C1352C4E
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123976; cv=none; b=rCZIhNcgcUFnWRbBz50f9ApGnjpZs+FJrh89Y2apyIlrZ/ocde45lQc0qOzO/eXud1HWl1wc3AxrXDNSCJnoATNHZ9XX1/im3oxq5u/ELnLDBYx4F6W180Hhx964462ow8GnSpnivQflE/02mODaGvx9dFEq/mrIaFjcX3Le7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123976; c=relaxed/simple;
	bh=qACc7jkiN2tn8itG+iPm58U9NJ9vJrsA274Qf7Q9SVA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=ckC2HVKSz/aBzupkXlvzsLUXfMkgLLD4oDOE9Whgpl+cqN8etmUc8kcHQEfdCb6k1+NHCMx/cnFqeyCDfr232Rp9BpacPbAWM90nkMelAbU0Ug/e6En7lkhYcZBxDlUPqtAwDI1jxK1ga+siRQO1G2+srFbMP0nIO+FZwIobkQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDFZaCr8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDFZaCr8"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-835386ff122so2703802b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123975; x=1779728775; darn=vger.kernel.org;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zllnXd80rkp5aHt7G7/Ts91W3aw+U7xcISZlpRJwkn8=;
        b=VDFZaCr8EfAQRle4XMus9cIfAxtfYiT2gib2oG62i1Jxid0hNgEHXi3CDFSl9Uj0mX
         muUxHtwDs9Dv/YziEoyur44NZUaSn8Tl2pZZ9lJnOay64LDqoQFytBF5XQNPrM5wXUbu
         5JIS6ksLSLAusVbfx6yFoctddOpldgoVj9w0t3YhKl+tZfzKJV9XVVpsGUEpZlZnE91h
         BMeqwWUc1L1fYaURWEQ5lNMKo8EaCv8G77kaTTzbkeryVL4/bwgZsVlA6V90bKWpz5Nt
         ZvqC5R+AQFb8n/vX8ICQBTXGlMEadaQKrOfojfkEaRjb9xmwBrcn40U7r2BLxlAgcunH
         hDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123975; x=1779728775;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zllnXd80rkp5aHt7G7/Ts91W3aw+U7xcISZlpRJwkn8=;
        b=kY+eaP/8DonIZhHmN7my2S3NQYCT0l2YrZNzgT42KqPoQJGawgmRO0yJemY0XBl0QO
         3+XZDcVQQcuDAoYjCLiyLoaIFJuyCMJuZqhW1gdjxDhrYT8s1p9O+dQqWc1lNrtf/kpW
         4noKJs4sb6TKpr4Utm42aPsYHaEhE/Z69m50y+jtnovn4HR7WxxOB9aMeCZmDh5zO20A
         pm6cuNrdWFN6spjQsCwD0UxeOFwpqqXuCERKGOl/vntKUkDo4ESwjKdHxMBWbpRe0pwb
         dkJYOf+ZqwSpc38n0RdNw4z4Yjaupd5n2MIDVBDGRD6mgOwOTnJujulXutKPTWhplljV
         Zmgg==
X-Forwarded-Encrypted: i=1; AFNElJ8FEA3gEPNvMt3oAt8VAf+OGw9k8i5gP7ewxEr47EkVCa/DjuLAf4kcFWvHGM2ccFHtJhMCR7xvrjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HoY2homBhjj1e3I+KABRsiWRJmIubc44ms7PoSLWFZhu8z7x
	Mz9kDGSH+gvEuNeFBtvQfvfylpBX0oIG830CS5GndaZu0QwXe9YQLYUdVgkqDHiq
X-Gm-Gg: Acq92OFauzzPj7cSkugZNbVeLNkg0orEFkyUI2Ga8q9v1bLrloR17UDP5qaeqNEX+3x
	o6oq2I10fjm9ZeIodcAH5i2bIV4m1Gyy9OI/juYRvemECkPRpRwYBwdhdbjQkdEWDL0mcudz+33
	LIiq47bL58MmzPV7IO9ONjr9OojyTKwH1MLEE2DJ6wahY3xC5DmuduUImB2uopv2SHh4vYDomzY
	AO9E9lhRVeXdOsIroJrtC21bLDcGXchXx0drhGfD7dSK3MR2kUkknWhuc2gfpy6dbDQ90/FF8xY
	LbUUBHl1HKMvejsh+kMHe52ZHBXbvYmrn6GT3Kewd7xq9m4U5oOoYs9hwiR94+MQrOCNgWnyGqG
	43VWL7ClQxzc+E9noYwf7fC1LUUobHdWHVudpK1krRY6qBMezPx3PVV4KEqSwFL9V8MTBr6EbWt
	EvQYwjjqE6ngDQw933gEPM6Nf71u8LP4aOfRwx/+86XTSJvhZYQHBiMT5QGF3fd+zPp5s/WQc3y
	mEqBKRZ7BdNsiVSXQ==
X-Received: by 2002:aa7:88d1:0:b0:83d:b0a0:90e3 with SMTP id d2e1a72fcca58-83f33c344a1mr16612881b3a.31.1779123974543;
        Mon, 18 May 2026 10:06:14 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([110.44.115.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7ed3fsm14932377b3a.45.2026.05.18.10.06.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2026 10:06:14 -0700 (PDT)
Message-ID: <1a0c86ab264cdc1c79c917e984b90991af51d827.1779123847.git.shuvampandey1@gmail.com>
In-Reply-To: =?utf-8?q?=3C0f97352506d8d813f70f441de4d63fcd5b7d1c3e=2E1779123?=
 =?utf-8?q?847=2Egit=2Eshuvampandey1=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C0f97352506d8d813f70f441de4d63fcd5b7d1c3e=2E17791238?=
 =?utf-8?q?47=2Egit=2Eshuvampandey1=40gmail=2Ecom=3E?=
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Mon, 18 May 2026 22:44:18 +0545
Subject: [PATCH 2/2] PCI: meson: Add missing remove callback
To: Jingoo Han <jingoohan1@gmail.com>,
    Manivannan Sadhasivam <mani@kernel.org>,
    Lorenzo Pieralisi <lpieralisi@kernel.org>,
    =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
    Bjorn Helgaas <bhelgaas@google.com>,
    Yue Wang <yue.wang@Amlogic.com>,
    Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
    Kevin Hilman <khilman@baylibre.com>,
    Jerome Brunet <jbrunet@baylibre.com>,
    Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
    Fan Ni <fan.ni@samsung.com>,
    Shradha Todi <shradha.t@samsung.com>,
    Hanjie Lin <hanjie.lin@amlogic.com>,
    linux-pci@vger.kernel.org,
    linux-amlogic@lists.infradead.org,
    linux-arm-kernel@lists.infradead.org,
    linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

meson_pcie_probe() powers on the PHY and registers the DesignWare host
bridge with dw_pcie_host_init(), but the driver has no remove callback.
On driver unbind or module unload, the driver core therefore proceeds to
devres cleanup without first unregistering the host bridge or powering off
the PHY.

Add a remove callback that deinitializes the DesignWare host bridge and
powers off the PHY while device-managed resources are still valid.

Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 0694084f6..c96e2244a 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -451,6 +451,14 @@ static int meson_pcie_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static void meson_pcie_remove(struct platform_device *pdev)
+{
+	struct meson_pcie *mp = platform_get_drvdata(pdev);
+
+	dw_pcie_host_deinit(&mp->pci.pp);
+	meson_pcie_power_off(mp);
+}
+
 static const struct of_device_id meson_pcie_of_match[] = {
 	{
 		.compatible = "amlogic,axg-pcie",
@@ -464,6 +472,7 @@ MODULE_DEVICE_TABLE(of, meson_pcie_of_match);
 
 static struct platform_driver meson_pcie_driver = {
 	.probe = meson_pcie_probe,
+	.remove = meson_pcie_remove,
 	.driver = {
 		.name = "meson-pcie",
 		.of_match_table = meson_pcie_of_match,
-- 
2.50.1 (Apple Git-155)

