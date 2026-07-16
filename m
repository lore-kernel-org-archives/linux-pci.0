Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7C40EB9B;
	Thu, 16 Jul 2026 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208408; cv=none; b=qoKHMIyMCuLowScor7TxIG0d4nQw3J9Htj9h0ayFWgO/guqWirRtv7UO0tjBwwzDtlYOrrf67REjel5OOkgkkbL586ZmELRKOK2iV2eZMM0KroIvXeEPVOpIOlNzV2r64rD9B78UPT7FF3lUu/bWxVUq+xich3EqIXRZCOhb0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208408; c=relaxed/simple;
	bh=eGQryNlAUMNPciOIzyN4Tx3VtHRirwO14jVc/VYRMgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ng+1LenUzen5ucpVjLc5eao0uJKQyzzNnm/5z9QNz6uXLMuYJj8dHUZLm1hY8bs7L6xWkX8Yrc0+VBQu2yyXdoBEanWKWnY9fzJmm1QCXiH2syQS245C2uqMPQtPyBnZEnqNp8oMdPx2O8Kqc/QgcfulyIYX4FaOMd+yJF6YvOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIRSVVT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIRSVVT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4859B1F000E9;
	Thu, 16 Jul 2026 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784208407;
	bh=lR+t3rY5y5u5VwDM1J4gWW/TmuexRfYrfq+T8gv0cbg=;
	h=From:To:Cc:Subject:Date;
	b=DIRSVVT9v1fGW6M3Rveluj7lUJATnIFwPq2YLeRscFBoxHeLlg+jrnmYrvYCYEhEJ
	 3KHCOcH2HMHQnVMY8W1BtDew1GkwbXF39uz1LF9T8l69Q/65oufA5UwgiiDnFcb0Aq
	 7KgKPcWpSin/PT8h5leiueA4rPQvPw8HPt0pXMwjnIMS/86I8IzLj0lSs/Mvf5IiSn
	 yZX29slO4qIsGNJK20IChP3rHy6ueXysfVkewGFTM2XBe+wS72lsP5s3KKMXofgPGh
	 kE+EQ06RQrXQw1/N4ccY+OhDbikTU2T3xgR2S0HhlKSXPLR1kmiTV8vGoXWOetkmMx
	 A9RPZJY6+wmqQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wkM6v-00000006ZEq-0LLU;
	Thu, 16 Jul 2026 15:26:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] PCI/pwrctrl: tc9563: take i2c adapter module reference
Date: Thu, 16 Jul 2026 15:25:32 +0200
Message-ID: <20260716132532.1565340-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i2c subsystem currently blocks during adapter deregistration
whenever there are consumers holding a reference.

Switch to using of_get_i2c_adapter_by_node() which also takes a
reference to the adapter module so that an attempt to unload the module
while in use fails gracefully instead of blocking uninterruptibly.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 1555e8a9b3ca..e6a8abd9da8e 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -548,7 +548,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Failed to read i2c-parent property\n");
 
 	i2c_node = of_parse_phandle(dev->of_node, "i2c-parent", 0);
-	tc9563->adapter = of_find_i2c_adapter_by_node(i2c_node);
+	tc9563->adapter = of_get_i2c_adapter_by_node(i2c_node);
 	of_node_put(i2c_node);
 	if (!tc9563->adapter)
 		return dev_err_probe(dev, -EPROBE_DEFER, "Failed to find I2C adapter\n");
@@ -556,7 +556,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	tc9563->client = i2c_new_dummy_device(tc9563->adapter, addr);
 	if (IS_ERR(tc9563->client)) {
 		dev_err(dev, "Failed to create I2C client\n");
-		put_device(&tc9563->adapter->dev);
+		i2c_put_adapter(tc9563->adapter);
 		return PTR_ERR(tc9563->client);
 	}
 
@@ -624,7 +624,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
 remove_i2c:
 	i2c_unregister_device(tc9563->client);
-	put_device(&tc9563->adapter->dev);
+	i2c_put_adapter(tc9563->adapter);
 	return ret;
 }
 
@@ -636,7 +636,7 @@ static void tc9563_pwrctrl_remove(struct platform_device *pdev)
 
 	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
 	i2c_unregister_device(tc9563->client);
-	put_device(&tc9563->adapter->dev);
+	i2c_put_adapter(tc9563->adapter);
 }
 
 static const struct of_device_id tc9563_pwrctrl_of_match[] = {
-- 
2.54.0

