Received: from mta1.migadu.com (out-59.mta1.migadu.com [95.215.58.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B324D33F8A6
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 05:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792127903; cv=none; b=YQiMNMBMIKRp0sVOhImD8hn3uJ71872/FtUZCEtp+s4zFgIuxmg4P+lbvjkmbeRl8DCuaWy4DwfSzH4jRxjOzRFOaLJb+16K7XiqtLXQ/O0zVn8tkOWITXYZIEeR8mslcY7DvND9nuYDQTZPOGYQaZ/Q73deRDjmBNCf2AasSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792127903; c=relaxed/simple;
	bh=nuNjUflfI/QAwtV1Y0WTEhfQS433UWGcl6mNkz5BR3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCIz1te2cWFo4C2sUe3u044dv53E7rZbp031zDYSSjAoO5254C6+lZ2clUrBW688VWthkDwF9eJTBjE1ACvxiHUFejWBlT4dHXyglF0RMj5X2VtFt0mNQ5Je779/+DBvmfp9xUOUXgcyWqKXr0giZpQZIuWNWMtqqg40uqdutI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=hQLADIsc; arc=none smtp.client-ip=95.215.58.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="hQLADIsc"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nuNjUflfI/QAwtV1Y0WTEhfQS433UWGcl6mNkz5BR3o=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792127898; v=1; x=1792732698;
 b=hQLADIscwpr8A/Y3E7yvShPOzlWpIy+e/bf03YwqXmwoqzCEowSEKIYv7X0cU3AoEBC3vofb
 IuRcIlPrmtKKAHUrQLtwW3JdWRfgWWEQLdyH0m0l2tBjQ6XNXsHDDj/dkeRuByJK7bTAoCG6kXf
 +EV3O10HYjMQFVFEdWzJ/yYEiVpKdZZ1yXGiHSm+EFG4t0vtgfhOfdh719/RSXP8HnVXE8+zdb4
 fI4eCABnnjNkP3dixZAVF0Uv1GeYk9Jusb+xV5CpSd258nkMqK3wRYmxJm7jt4VSH+t5niK7NLM
 aUNR0Vkcavh42BkL0i8YDAlEL/vZYGqap5JrMsFeWWUCg==
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5778b54b001c9d13;
	Fri, 16 Oct 2026 05:18:16 +0000
X-Mizu-Trace-ID: 5778b54b001c9d13
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Val Packett <val@packett.cool>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: sequencing: pcie-m2: Add Foxconn WCN7850 subsystem PCI ID
Date: Fri, 16 Oct 2026 02:13:35 -0300
Message-ID: <20261016051745.577777-1-val@packett.cool>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new device match for the PCI subdev id found on the Dell
Latitude 7455 laptop.

Fixes: a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID")
Signed-off-by: Val Packett <val@packett.cool>
---

Similar to 58a003302481 ("power: sequencing: pcie-m2: Add Lenovo ThinkPad T14s gen6 WCN7850 subsystem PCI ids").
The Fixes: is present here because it was present in that one.

Thanks,
~val

---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 0febe4b3d980..56c5d51293c1 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -225,6 +225,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_LENOVO, 0xe0e9),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_FOXCONN, 0xe0ee),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ } /* Sentinel */
 };
 
-- 
2.55.0

