Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7BC3AF65A;
	Thu, 24 Sep 2026 02:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215459; cv=none; b=uOzxFCGW2833QzAz0l3B+HZBmwEk9SGuVXiivPXXe0MSmGrHiaaJMQ6FGvcHQIKlc57kMrs+GYA7llockVOreCgPY96EbjkzbRdSiSg3osnrv/iadFa1UYUN0B0Yz3vpnyrOpkPhxH+J8XSngbv5vpnB5TvyATkiA7UFq6O7SZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215459; c=relaxed/simple;
	bh=Sq/Bmk4yORgByR9DGnLLTWgLehmQZuZU/1N+/ooi0u0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tuDXaBUrVnjaWdL5A/YTao4Ocyhqs7yUpKCKE9AEXkt+jTGvZklXPk3wRvvdaZK7VRFnOiX3UUHCFQ9jpesa4CcsqEhh8e6F9F9jv+A7dng1fuTSSYwdCBMFxyWH/5ZN8XwOW/X8+v9KxCJanjz9GW7oTzWmx3AzA4hHTZ/npuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=vnoHjDAG; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="vnoHjDAG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1790215414;
	bh=s3CNAx4BQMr4l63eYxA4KnmxnUvSjG39QNEvmt1VyIo=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=vnoHjDAGxgfkFD6r5IQQmytgxMGem+RVl/ys3MXcczSrFlJV2P1Fa6TK32OI+t+Hj
	 1163pLE1jLGvly9iBtDEezqtA8bRfnI0QomRwmKS/0awcl9mKl6sqTbnj4jzg87MSc
	 GF4qRRFzQJun2DIWjD70ihe+weU1oHaLvF2BRzLs=
X-QQ-mid: zesmtpgz3t1790215407tb9e7a6b9
X-QQ-Originating-IP: BYfzCy6nTypQWy08C5EApOMYUoFWUOLwIQk4cKlrwzY=
Received: from snode1.dc.com ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Sep 2026 10:03:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7833649255534898788
EX-QQ-RecipientCnt: 12
From: Encrow Thorne <encrow.thorne@linux.spacemit.com>
Date: Thu, 24 Sep 2026 10:04:48 +0800
Subject: [PATCH] PCI: spacemit: Ignore link partner PERST on K1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spacemit-k1-pcie-fix-v1-1-002b5c1ba9fc@linux.spacemit.com>
X-B4-Tracking: v=1; b=H4sIAD+FtGoC/x2MQQqAIBAAvxJ7bkE3Cusr0UF0rSUq0Ygg+nvSc
 QZmHsichDMM1QOJL8ly7AV0XYFb7D4zii8MpKhTPWnM0Tre5MRVY3TCGORGarsQrPGNIQ8ljYm
 L/rfj9L4fooo5lWYAAAA=
X-Change-ID: 20260921-spacemit-k1-pcie-fix-256ffa8d382d
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Yixun Lan <dlan@kernel.org>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Encrow Thorne <encrow.thorne@linux.spacemit.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790215510; l=1795;
 i=encrow.thorne@linux.spacemit.com; s=20260922; h=from:subject:message-id;
 bh=Sq/Bmk4yORgByR9DGnLLTWgLehmQZuZU/1N+/ooi0u0=;
 b=z6eP620CfxXQFP6H0sQF3XjlLbwrhD3S+Yj68RfV5mBp3vFjolWOnArwjsMW3/k9Q7sLWpVEX
 mppB6MoCTSMBQbrhKewQknqWhxrVafjqqaXtP3G3GEDKaum/+OzPyzI
X-Developer-Key: i=encrow.thorne@linux.spacemit.com; a=ed25519;
 pk=2pmSCQKuWBw48bo9mVmWM77uEWdezu/geF0k1YMFzN4=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MLnLowx4CbXMyRItrYTYw0ia9VMa1QZ78XK1oqMQXmDL0Gebm+FjxCz5
	0QmkuQYHM3IuZo9Ip66Af/lo/8hzvQMtKOhAWRrjltH9LSEE0cgazxk7dSGwWljrYzLS8fd
	sGfki5bIVBVQSybiPqVZjaetblWM/Q4chnpAMkD+hG4EqT66AHHa94NOElOTAJrhrvg6Vl3
	gYL0BtHFhqMtBmUsjMXiyXbui2CoY/vpuIR9W7fX49IrvGBlGblobnolnxOWphTAp0HPj7Y
	PGMcqyJxGxUHzz3swAICUcaewCAiRHIFu+2j3ur9oxPgO8+zITZECsjsHZVhbQOOaECGcWJ
	DFQWFV9QILM68AQLxoioQeNPPTaxNey0gwDb2/94c85upqnXa0R9C94+mCdoDbdoES5SY40
	2IHEPzkF0/jbU71pxCufKDYxODG24WXZTHvOLrLn3eXEVoWyB+eEUfbwC1hqKWksQAZ1DY1
	MKwT5HGTQZbibqMN5fYU933bYX6fXd+4E8VwMf7nY9hvoIqm9gsEH9CJwL/sFgXNUFRnoPI
	ExkphLArWhEq9mW/UY1nnMrADeRTfboTMvflCyloncx/1v1H/A7F3qK3l4XrJBOnxf9Ulfw
	IwOYvciAqLkabpJG5US7Nl5lQThrnocqdP2JuZMSmAGKjGuK9VETG0y6l3d16lxxV6K0dSl
	/klzBqKTzOgkhAAOGbi1jcwesPlkw07a0dPdCWyIPwHNrT3kU6CQP5SmcfDBs1pA2F5c3Lb
	aZ8aDVauPzPiKXcts1O7rjLnXg/bW87THHJ/qWSBnwgTR20aa1LSblJqmh3TvbIc+XqE28y
	fe/rWF/ITt3zAc6TdXZyr7uvspj3zaTGPf5vLG0NavdDitMeN2E4zEta+JTBqj061JHtCQN
	a1Cpf/8BLNeqpw0+UyH1eu5yoyTQd8ZsmYU6zzQkQHitHTJKs3btr/LMsX6kIwbUeSzQnfp
	EZ7TaIZLlB6ixn7rPV67sUm4UElK8KFIqtE6clCBnmYfiqS2VnonJU7XoyB0cCkgfkkwx4u
	xKaBDTDkXNxZ0qD9j4AizNLKZQl2HXVwKjXWHfltpDCWTM1IKOm4NuLGSTQjSRNpllLK62n
	E7COiYvj03Jz1AmDunNdjWQxS0gA/EACQyunEPudrWiK1ZddkJ9JMtbMDE42v7BJhpfGKjR
	4PUk
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

The K1 PCIe controller and PHY are affected by the PERST signal from
the link partner during initialization. With some devices connected,
this can prevent host initialization from progressing and cause the
system to hang while probing the PCIe controller.

Set PCIE_IGNORE_PERSTN before accessing the DBI registers. When set,
this bit makes both the PCIe controller and PHY ignore the PERST
signal from the link partner.

This allows host initialization to complete without being affected by
the link partner's PERST state.

Signed-off-by: Encrow Thorne <encrow.thorne@linux.spacemit.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 0564c46e2f48..98f067e1ba81 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -44,6 +44,7 @@
 
 #define PCIE_CONTROL_LOGIC			0x0004
 #define PCIE_SOFT_RESET			BIT(0)
+#define PCIE_IGNORE_PERSTN			BIT(2)
 
 struct k1_pcie {
 	struct dw_pcie pci;
@@ -137,6 +138,13 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	/*
+	 * When set to 1, the PCIe controller and PHY ignore the PERST signal
+	 * from the link partner in both RC and EP modes.
+	 */
+	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
+			PCIE_IGNORE_PERSTN);
+
 	/* Set the PCI vendor and device ID */
 	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260921-spacemit-k1-pcie-fix-256ffa8d382d

Best regards,
-- 
Encrow Thorne <encrow.thorne@linux.spacemit.com>

