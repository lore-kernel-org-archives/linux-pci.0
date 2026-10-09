Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB118476059;
	Fri,  9 Oct 2026 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791530807; cv=none; b=pm6FwEwwC0vIggZ5vObHRYhiWxHCfx5KClFFJQxUloViuzManq92jJ3oB0GmXDGlJpF3kEciwRXqi4ycG/bjygTe7pptofluVUQCz08M316x4OkCVjI3kEPkeVbmBkUhNKOJf3A3J2070JfQS7E2APQiaH4ofjsaxV8bmW8j14A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791530807; c=relaxed/simple;
	bh=DIow4ld3pFo36PjrspJn2e3kaWZmK6goJLIiBAKgbmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fl1vpe+lcOBQ/FWhlTQZ0pIuJ8x+AX0hH8OM3yMPsVPrzwSH5kATAUnfggdPp/D7eKd274a5DbeM7DLcmxTP3N34TgEnXJVg7njLIl/2ba4OQ6o0EQezdL1Gpa5e6x5UIKUMAwLqoRX8PdzbOFw2bYM4STi7RBgHpnjDXp9FWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1791530728tad1c9cc9
X-QQ-Originating-IP: IiPjdafqOWaJIc7LS/EsCn6gUz0ZNy+99dN/fKXVZDo=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 09 Oct 2026 15:25:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12217376092923936028
EX-QQ-RecipientCnt: 12
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 09 Oct 2026 15:25:17 +0800
Subject: [PATCH 1/2] PCI: of: Correct pci_set_of_node() return value
 documentation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-pci-of-disabled-bridges-v1-1-08708f9e1802@radxa.com>
References: <20261009-pci-of-disabled-bridges-v1-0-08708f9e1802@radxa.com>
In-Reply-To: <20261009-pci-of-disabled-bridges-v1-0-08708f9e1802@radxa.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 Daniele Briguglio <hello@superkali.me>, dragon@radxa.com, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=sophon@radxa.com;
 h=from:subject:message-id; bh=DIow4ld3pFo36PjrspJn2e3kaWZmK6goJLIiBAKgbmE=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFknpj2xkzvYsuONv8GRiQZOrC6T67f2N0gbz5wTLDLzN
 8PtQy3tHaUsDGJcDLJiiiwK8Qxz2Stzrz0VK9WDmcPKBDKEgYtTACbSfZvhfyp/xsnLb5/N4VuY
 t1w9ZprcTfeb/XG31TS/R/NcU7fhcGb4Z/ji+WWx1i05s6apyfgKXIjRUP7QsaXkoXyNUMMyZ3s
 DDgA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Noy+ibaQGaj1afX7ejVyvY/Shg5XTcJLk3Pg/bl7yxNM3xQxRvFf2AvE
	TcbO5RXTob1Hr0XP6Fx8h+OlwF482dPoXHQS8Hz6M+SPb8UDGqd2XkzpGyJ3U4Fj0bNwiXD
	YTmzgGGyj/6HVy1HNjiW+dfWokp2UtN3miFsdRln5Zkg3OnjvWg23AKdy1mnMc7RvhLdlAd
	LKevVMBfKvhr0x9t2Gc+mWx9LDiaVoxu8+Fb2YkdcMDFJrCmI4AdDmfnJhY+IgSUSbcKObE
	G97PzW7JWGhinRLxXdx4YR8IMOkHuReEgkaHiI77gtTh8btDOBXEfBSxu9wbEckuISjbz+S
	M04NnJCh3Pdx7ux8JBySGoJttoDfIiyElrPHrfS6og48bqDVR1zcFNdSMKs51+rreIQClRY
	813kmnIvmR+K7l4QwfAiyDCu/menfuoNcesrEpBGNGZzF+2negmYE5DtGJmTFxogk2EhvIl
	I1T8B2ZHalsHQkKAsZ0ZpZSFZyFegdIj61JpIGCr7aD9p/Y2/Dx7+dsRiEy0GfgdyZxOkrz
	SG8BsH6i/eqtvaK1nhqx64hBQoaaj1pch9ewb5E8mGBR+lGmNNHUyG/b7WkY1kf6UMsoYJi
	XoFIhRH79YcFc1biBxHcKi63ZAaAhidgOkLYFDxwI2Y3MxZH0MEnry3HEGy1nt8yznSZipo
	wmnRJyR59CtSP6h1v2eygZjXD00kf+6bztkS1fu2aWDOmOcX+xePK3aY7LA6N2dLo64Twy0
	v/2Ig3OI/5koprpnTWxsanqUy4gYtx7yXMiY5xA2G/vWJXTw5IYcwbeFYkcsCWiXGltTrMH
	NW+KYR1A70qGJI5Wq6EG04YRkOIuJSqG+2NsnI7Lca/Y+qn4mKhaeSkSIyoiSVRPQajGNjR
	Wibg4CiprZNxwkFzH/BDJEjfLxTteoN6CRsNbYFu9AkAAt/iE6Ukn05jdAFQ284DYL2y7F3
	acMoXzb4EQnlV/S22/keoLMucTNhQkGgIadPHQrZhbd3eiRo/Ii+k8w2dGqdnakjGC8rH+E
	ng05wUDcZbp6KQ91TcM4DRqTpj3CQJRkGLHW2K2uYY98LP3NwqBrLgp7bVl6Vt7t+0BFLHF
	c6FvcJ8Nt8GZ+cgeK/YY5Uf7KrY4ROHHNBMSu6xM0FL
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Commit 1a8c251cff20 ("PCI: move OF status = "disabled" detection to
dev->match_driver") removed the availability check from pci_set_of_node().
The function now returns 0 even when the device is disabled in the device
tree, but its kernel-doc still says that it can return -ENODEV.

Remove the stale -ENODEV description and use the kernel-doc Return:
heading for the return value.

Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/pci/of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index a51dff91b196..9e82c79be3d8 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -24,8 +24,8 @@
  * pci_set_of_node - Find and set device's DT device_node
  * @dev: the PCI device structure to fill
  *
- * Returns 0 on success with of_node set or when no device is described in the
- * DT. Returns -ENODEV if the device is present, but disabled in the DT.
+ * Return: 0 on success with of_node set or when no device is described in the
+ * DT.
  */
 int pci_set_of_node(struct pci_dev *dev)
 {

-- 
2.56.0

