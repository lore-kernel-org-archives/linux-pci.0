Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.22.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675806;
	b=d4P5qavS8J3TDzfrtWe0Sfa67xwFor/NBe/CP5jDbqHVRcK97Nt0uzPg2gNcb+uq/dxh
	 iKsDfLDxxQQ5e5dFszkY3S9eNCvhsWdF5yliVeTztxJzQRgLnpYHDTQhMuqb66ZqTiXTP
	 TfyQLTwVXO14xo2Ofq5iz1zKxUrwp104Cl6mHW2n52t41QyrhzyZSbXHkyO+l0U6JSMqO
	 iRsOqJoM5RqQAmjEu32jlghlKBkFY7uJV8se06qKG59QLj76ElV9jsqPcz1DzI3cpHkyV
	 JEQmZbrH9ho4hYG91kzl7/7F3g3dH1ljzGRVKnIKBzfa/MqwPaaW5E1arHQiOqmXSqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675806;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=Zb8du/ZgL0YkfsGgvKac3zPx2H5lc212zhD70YfpTrU=;
	b=KJjd880CT1LVmIwLhdQm06qZ8yBhrbZWR+OiMGFo9wQ88jTEQgOFfZg2jnqHaAQUjAMF
	 2LUXI125CFmPGexNlbn7pBtS8w8gDuXGtt4tYrMIBYv3KNkkCSkcAAYYLgG83pGe1Neb/
	 oQSI6Dqf6hCsCGteHRsKDrFM9jHuKKs6PC1L4D41lc7IjvJfL94PEziLWi8gfKDj5FXAK
	 ZN82r4zDxgVF7ftuhOOZHFy05s/imop88G9rs4PbGCl58+LxgA9yT4F/OCnE68Ei31kMo
	 MoNZW/NexmGzY4bfsUwCDmqsKXm9mbKEXOb5RxjsNaVckMk6hE0gQliFITtEJFyy5zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=TO2nPYD9;
	arc=none smtp.remote-ip=54.207.22.56
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7A606A31C;
	Thu, 26 Nov 2026 06:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50A7A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=TO2nPYD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795675764;
	bh=Zb8du/ZgL0YkfsGgvKac3zPx2H5lc212zhD70YfpTrU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TO2nPYD9Db0kjNbmLJMH1nNszoJRWuKKs+IqptIIufWk9g+vdms5yKKk9HRUw5Vdr
	 IpYcrlYIkhQ0GS8F6mvGsNgAHo1N/dYMAWm+XMZn/PJzbNrpiD96d33D8CobEYQsz4
	 m1uhSrBeWR5KRlJV6VGNpCPz/g7ZzASZvGhbSLiU=
X-QQ-mid: esmtpgz12t1795675758t6d13b64d
X-QQ-Originating-IP: nnQhQgMbQLxG9h+7D6IUGi6L73nTL4IBmyUz3o6QQNw=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Nov 2026 14:49:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2135634178366383156
EX-QQ-RecipientCnt: 16
From: raoxu <raoxu@uniontech.com>
To: bhelgaas@google.com
Cc: luiz.von.dentz@intel.com,
	tglx@kernel.org,
	pengpeng@iscas.ac.cn,
	brgl@kernel.org,
	wangruikang@iscas.ac.cn,
	ligongwei@kylinos.cn,
	maciej.fijalkowski@intel.com,
	michael.bommarito@gmail.com,
	18255117159@163.com,
	xiangzao@linux.alibaba.com,
	vidyas@nvidia.com,
	lihaoxiang@isrc.iscas.ac.cn,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH] PCI/MSI: Retry a mismatched MSI-X message once during restore
Date: Thu, 26 Nov 2026 14:49:01 +0800
Message-ID: <4EDB2ADA2CFC5963+20261126064901.1798104-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MfJtHqZtrd+O0mh5CtnHDBqW/sHpDZ/gOFDYCi/XrgxZDJIOstGj/afz
	7pa050pRmYJtHCOVXt18zIo9UIE1sP8Ow0KdL4VllEkCBUXawxHbAQ9B6RM2ck5Wo1iS9IW
	fVP5xQxVW1lV2dAiSvB2yyKLrJFWOQjRygbYk+fCcHr4w4OEHDRyUtW/xLCrnBnGkuWljKf
	73sECnTwsPzjwcqsdA8MEy1w2dSxVGcFeJhhCqW8XKP195ckbNDengp5n6N+JOxJ1Y46QhH
	I6gkHB9fmAFMgLXnptht2oZE9BVQ9TA3tsLy+vgSWfy/guB/iwcEZVEF9cqLFHU8SuFF1jl
	ohWz92CN2z005rPT7uUHBIs11lvbMka6CA4bQSYDQdx6rPt7k0Po4RBLx7qUy9eBeidVNdp
	hzHH6GgjcQ9DXdT1kpLIB0ImZTjtEy8eWDFEDmMUW/r+eiT2J/vcNumazeFp568310+rrW5
	xdaH4tnsBSsHEIGoPWK/TUA5CanutBvCqMvjhwTqPmr+8XgAicYVJ6qMoqqttKLL5d9opo8
	VxAR0yODu+ZcXQlgyVeb+3m2hJVhjNJYTXtRVa5Kbobb1K4eAAmTmHtN5yTV59PC/wD5D5S
	iV+mYXcwM3oq+DL/SWi45HAGLgH0m46Qj8NRW/l7N0IBSNXGzmRtoYDI1JnrizVGmSPYKOr
	st6yPRBf1TxqV++lbYNafYLB1B1QT5fKUMC8Ofg+YeP1VmZpVmEKsgrt5XN/7UeNLo39ZVe
	3Vcb2Uwi3LtNuoTYOkI10nGHgH+MsuPgmuiRk6DceZ+AsIhqyLVCAeuKLrlpAbcS3vH4Q84
	m6Qo4mZ5DxYSIQspyuPnJfelm1qhLZYj9SQdrMbfaUYWg0YcvNYTqscqAnjGD742zLmpMe5
	80Al8gYqUc3QWCzassmxSgHhvKkTPdQLdRsfZGAEdlAxPkDVwUFMa6rrCB2issjsISVEBCB
	RDmpAkrr/EU3+7/n0s8JVk5hA295F728T4VEB8sP40R8/kVvHLDiUWEkJUnsejwVFcjsiHW
	L+H5om9bsgI7I2gmkvlvV0x1+ph4faJoySAYs/VNzQmKhpSaM1p+PFZIl+7vZEqOHsPugi6
	Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

Repeated S3 cycles on an Inspur CE720F2 with a Phytium D3000 CPU
leave its Renesas xHCI controller (0000:04:00.0, 1912:0014) without
working interrupts. The keyboard and mouse stop responding, and
newly attached USB devices cannot be used.

The failure was reproduced on UOS 6.6.0-arm64-desktop, revision
d7bafad345e0, build #5.

The affected kernel already includes commit 231c7a57d193
("PCI/MSI: Enable memory decoding before restoring MSI-X messages").
However, inconsistent MSI-X message readbacks still occur after the
restore write on this platform.

Diagnostic excerpts below are wrapped and omit repeated device
prefixes and unrelated fields.

On normal cycle 16, the MSI-X message read back after the PCI
restore write matches the intended message:

  [ 1163.085945] xhci-s3 msg-after irq=86 read=1
      want=00000000:36850040/00000000
      actual=00000000:36850040/00000000

On failing cycle 18, the same readback is all ones. At xHCI resume
entry, the message address is zero:

  [ 1285.211630] xhci-s3 msg-after irq=86 read=1
      want=00000000:36850040/00000000
      actual=ffffffff:ffffffff/ffffffff
  [ 1285.213401] xhci-s3 n=18 pci-resume ret=0
      read=1 v0=00000000:00000000/00000000/00000000

Here, want is the software-cached target message and actual is the
hardware readback, formatted as address_hi:address_lo/data. The
last field in v0 is vector control. An all-ones read can indicate
an unsuccessful MMIO access; it need not be the stored table value.
The later zero address differs from the expected 0x36850040.

The controller then reports a command timeout:

  [ 1295.556532] Command timeout, USBSTS: 0x00000018 EINT PCD
  [ 1295.556557] xhci-s3 n=18 timeout cmd=01013c01
      dma=0x0000002021506000 irqs=0
  [ 1295.556560] xhci-s3 n=18 events scanned=10 limit=0
      matched=1 cc=1 last_cmd=0000002021506000

matched=1 and cc=1 identify a successful completion of that Stop
Endpoint command in the event ring. irqs=0 means no xHCI interrupt
was recorded after resume. The command completed, but its completion
was not processed normally.

Read back the message after the existing MSI-X restore write. If
either address field or data differs from the cached message, repeat
the write once. Matching entries receive no additional write.

With the retry, cycle 263 records the incorrect zero address and
then the expected message after the additional write:

  [16009.367505] xhci-s3 msix-check irq=86 retry=1 match=1
      want=00000000:36850040/00000000
      before=00000000:00000000/00000000
      after=00000000:36850040/00000000

retry=1 confirms that the mismatch triggered the extra write;
match=1 confirms that the subsequent readback matches the target.

In 500 S3 cycles with temporary diagnostics, 491 comparisons matched
without a retry. Nine mismatches triggered a retry and all nine read
back correctly afterwards. The subsequent xHCI resume snapshots
remained correct, no xHCI command timeout occurred, and a USB storage
device attached after testing enumerated successfully.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/pci/msi/msi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 8a0133a6a286..a3304829258d 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -871,6 +871,7 @@ int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int
 void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
+	struct msi_msg actual;
 	bool write_msg;
 	u16 cmd;

@@ -896,6 +897,15 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 		msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
 			if (write_msg)
 				__pci_write_msi_msg(entry, &entry->msg);
+			if (write_msg && dev->current_state == PCI_D0 &&
+			    !pci_dev_is_disconnected(dev) &&
+			    !entry->pci.msi_attrib.is_virtual) {
+				__pci_read_msi_msg(entry, &actual);
+				if (actual.address_lo != entry->msg.address_lo ||
+				    actual.address_hi != entry->msg.address_hi ||
+				    actual.data != entry->msg.data)
+					__pci_write_msi_msg(entry, &entry->msg);
+			}
 			pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
 		}
 	}
--
2.50.1

