Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.243.244.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795780265;
	b=loDRu4QbkHVW9qvtqrsLfZBhe2kxY13qslbAhePZk6zyiY2Ee9GDYqXQXGY99sopXqHC
	 ybB0I1+yAVaCzsjTdIYKj8PYjCHjcgaVnv1AGfcVMtH7zCMdj7Eo+eZWKg4x+6hd8iYB/
	 G6B/ANA463lIGngLCMJw8ifjs2/AEHUFHREYZ+SvutY8fkfqlYO+lU3efVCpj8fxx/LhY
	 oIVQCLZDM7kHFmDkSAeIywS3qK6++QOykvcTOb+Fxg94RLy+uFaPXfRBmneFUdzUwKsM8
	 4NikWsTg+/x9FNfA4uoPzjC0hDKjL1wUCEmWs55zVFmMaTLXUyFvmVeEF1JFPC8WFXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780265;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:
	 X-QQ-RECHKSPAM;
	bh=LeIkLzKkDvUFHkvwd+1spI4HrRS2YPMbvTtXbbEthrQ=;
	b=SFdQK4zh6K09In4LbhL2ndQL5CUhTMtTU1y5NHsSj5TMP3zsqTNBg1VzNrmMAp2qYzB+
	 M/5Nm00cmYexitpTj7FdUuCgo+UHixc4PbotLZUYDkkfIFQQPHKBOUwWKJ4niOV/YBn4h
	 MaxlA9JCsVOBS4A+RN9yCFM27D/GlYJ/K+EtHmewqkeL0T7Rw0a4GpJCF1Yf7j2tQKqa+
	 Cr5IO9opRzqLzBTI3R27t6X55xGeL5lBQf0gkl5zUfn8drzo3wefL0QwXjazpGwYduSvp
	 /9zQc4w2WKUTi7iR+Umu6IAUADMeBZQIBixHuMawk68+ETZCc0nWUk3hu5l3IVfr6iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=radxa.com;
	spf=pass smtp.mailfrom=radxa.com;
	arc=none smtp.remote-ip=54.243.244.52
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746F606A326;
	Fri, 27 Nov 2026 11:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2746F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1795780183t4d1fda40
X-QQ-Originating-IP: G7ajAXhux6tUPStxBQXe0BE92Mg7JngGoim0GO4Wasw=
Received: from [192.168.30.32] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Nov 2026 19:49:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13024802239966438896
EX-QQ-RecipientCnt: 12
From: Xilin Wu <sophon@radxa.com>
Date: Fri, 27 Nov 2026 19:49:32 +0800
Subject: [PATCH RESEND 1/2] PCI: of: Correct pci_set_of_node() return value
 documentation
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-pci-of-disabled-bridges-v1-1-3bedcbe51cda@radxa.com>
References: <20261127-pci-of-disabled-bridges-v1-0-3bedcbe51cda@radxa.com>
In-Reply-To: <20261127-pci-of-disabled-bridges-v1-0-3bedcbe51cda@radxa.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>, 
 Daniele Briguglio <hello@superkali.me>, dragon@radxa.com, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=sophon@radxa.com;
 h=from:subject:message-id; bh=k/kLlokSneUeoKS4FVw2ibyiWAgmHjBwSfjL3GuN8sA=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDNmceUGTLP+yv2dbcGRJzNTbEx9ILVvGKWDQxG2S9KNm/
 Zqkr8sudpSyMIhxMciKKbIoxDPMZa/MvfZUrFQPZg4rE8gQBi5OAZjIMxmG/8ExnAY7zOui/San
 Sc7fZiTEITeDY+bM6CPdT5Xdum0uuDAy3J+u3sFopZtwyGuSM//ujoMVM86KOe2qT/q2edmtxgN
 /2QE=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NYzuS3BMnxktMljWXz3mVi0hqyL4cM1fkfE9voHCt3Y+swAm85wH7ndV
	Ib2Q+0Xv4axQiXT5FkyqvGGEr/eBYydL9S53++lKcOGGh25DGTYUeAYfEvnve2vOzOljHI+
	y5A7doNV7AZlibD4T5JWejIezdNdwWd7gdG6eZCPaIp8CXt8dA5YuvmHeyedEN94CbvRZgG
	qKM3rN9wdqiLz7xy4HTMq7JHFVDIp9+MlDsE1/lo5Gz6mhqwi92cN4tjZ0dfdpApuTrzRkd
	v3UgDvXCVi36XuWn6c4agv6YjNIV7WK804tZKsStzR1ecMr34br8jRpxaoRwX4YY9fNrrTO
	3X2AzERFdJ4ZMsUuPIyKW4LAtAcBcp6isQPzaA447ZinISEfxYpS8SdB8Jl1bgt60CoCTnw
	cZQnRpRYdKibRoFUhfk/NfIFgyXiYHi6g06XlL1mAPwHcRcxNY50e64glwKjfiiTanlfOEx
	ldTa7KoMT5FNWNv6V7fv7+esdKZQmDfeXgB63IlXre4l/GFueYSylm8CiycrAu4LO7C69IY
	dJDjxUOOfZ3E84LGJTyeENGEY3pAHhz1YMlx7NyD0g3ngsnyllEd0kguL/5e/ML2eEabT5U
	BwM0scGkqLAy14gW8I2dDggx3yoGIVlKFhZEmDyO5LQobKtxtR3fZd03AxZs7NRFaJtZYr0
	JhwT/g0o4b/IM1r3M6oYW66G2Zl9zRvmwGPK5gsorNanDqrph09ap+v6uSKWgcMio5CzRhV
	Hs6niD7AiGQ7Xhrfd5d6ke/tk1Ei11wHlClRvZX3YQO7EvPUu9EzBA9h2by8xqOV+zrROJ6
	5WeLa2XJA2IpeQBpgXfGSa8wPUzbb/gTKPy/5T71k2JgOW/lNCTIqLyFBhrIWn20L94qXAB
	+5CYE0h7nO9Ceh7VaGhLir2MwRa9bnpGntLMBO8qdVywgeATVTStNHSDX/iwv5r734IsXXE
	8CbojH3YkeSSabXstc/ODQoXrHXkpok0lDkKBYy0iu/CS8CgyWZvNo39tJ9wCfeUUBHjnCd
	WlQ9G193P72+ZPO18T/5FudrcE0BRbINjU0yQ2l84uKKiv64yAFQuN5maXyBy3XWBq2V2RW
	BMCh9fUyHeImwiwz1qbLlTOOr9Kz2NrVA==
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
2.56.1

