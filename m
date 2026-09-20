Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8813D886;
	Sun, 20 Sep 2026 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789875484; cv=none; b=tkC731iO+w1O+Gur15sux6fi0305hn7IYZhmiqHOg6DR7YvapZhTPtA16MAJOmdpaOTCb6u+iNXqhKHmu0MoouM0rnCDlmo7XWP+wJgpwHCsEn1zplQHtt6TbOQRlXFI5mdTUhwuYeUVNbwcYAOd/t9NXGGe4VGmIwh9UiQbYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789875484; c=relaxed/simple;
	bh=cm9nWh8pH9RB9jU9eZqd6ba4L/3iuZZxenTc9UgH7z8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p772jn3FqdEsSg25hJ0OLdlD73KNPjhtNixFRVY5HeRbIn39M741eDFVfRs66sASKUc69MiZ0/3ML+KG2T+794EAyi8oZeQM4II8dBKcZGCxJGtitN3r4bNcdmtNMstYtVBsNh1SclorcoWZKlJndxJN4axcZLGIKFLzuv11Kgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mc2HTetA; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mc2HTetA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ii
	D8BlwNqKyX2cf1nZWhUxxdH2tvwCrHzATad2JUYoI=; b=mc2HTetA5O5UJLvtVA
	7cbzf+UPBLlf+6IbaP7Jp00BwBc9iULrM5cuTQBY4Qold1xxzZETZGo7x9sV7Oed
	ZCTOPj30Ju4QClJqyl8hFPMeEfh8+x66jMocxT1PqSvSQhSqkuzqvTwqJZNgSwS5
	vVHyX9LmNvoOIM0RJfwAzrpuQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3J8sDVa9q4l5RAQ--.42957S2;
	Sun, 20 Sep 2026 11:37:40 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: zhangsenchuan@eswincomputing.com
Cc: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	ningyu@eswincomputing.com,
	ouyanghui@eswincomputing.com,
	sef1548@gmail.com,
	hppiscas@163.com
Subject: [PATCH v2] PCI: eswin: Publish the platform driver OF alias
Date: Sun, 20 Sep 2026 11:37:37 +0800
Message-ID: <20260920033737.13957-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3J8sDVa9q4l5RAQ--.42957S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw4kWw15AryrAw1UCw4kJFb_yoW8Xw4xpa
	y5J3yIkFy8KF43Ja12y3Wv9FyYk3ZxCFyjkrZrGa47Xa43u348ur1xtFyYqFyDAF43Ww13
	tr1Yqa43uF4rArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uba93UUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7QTcpWqvVQSL6wAA3k

PCIE_ESWIN is tristate and eswin_pcie_driver uses an OF match table, but
the table is not exported. The resulting module lacks the OF alias
needed for automatic loading on an ESWIN PCIe host controller.

Export the OF table. Keep builtin_platform_driver() and the intentional
absence of an unregister path unchanged; module alias publication does
not require making this interrupt-controller driver unloadable.

The issue was found by our static-analysis tool.

Fixes: b593c26d081a ("PCI: eswin: Add ESWIN PCIe Root Complex driver")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
https://lore.kernel.org/all/20260905134251.67210-1-hppiscas@163.com/
Use the full author name. Preserve the registration model explained by
Manivannan; do not add a remove path.

 drivers/pci/controller/dwc/pcie-eswin.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index ce8d64f8a395..1bb44696057e 100644
--- a/drivers/pci/controller/dwc/pcie-eswin.c
+++ b/drivers/pci/controller/dwc/pcie-eswin.c
@@ -388,6 +388,7 @@ static const struct of_device_id eswin_pcie_of_match[] = {
 	{ .compatible = "eswin,eic7700-pcie", .data = &eswin_eic7700_data },
 	{}
 };
+MODULE_DEVICE_TABLE(of, eswin_pcie_of_match);
 
 static struct platform_driver eswin_pcie_driver = {
 	.probe = eswin_pcie_probe,

base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137
-- 
2.50.1 (Apple Git-155)

