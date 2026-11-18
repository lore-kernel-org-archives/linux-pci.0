Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.207.19.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794990771;
	b=cKhDS0uYt735EjobxrxmDkkGbmEWsYuLa2+0G8u310WHBoSysvVFE4KzBX9BisaXZkjH
	 0nb7ft8ZG2H59raLCixZFrS8072jhwKBywMpQpoXYIKAyElQzvoMLgMHPzlRs1hMOoJu6
	 mjWDmyxUVFyKeN1+Vmd3uRoeNDodZOG9B9tTmSFl7fEbkWiCGf8jc4CSPYl8sJigxQawu
	 CcYijueR6r4NsTSzjwBH8cg3uuTWdCY6P8foprCmEaZDwvTb33lIV8hMz6xO+LS58YnHe
	 0bgqxu1bq/D0eQleL3EkZT+rusFmhwHjzynQVvlJz2Kd6iXMVZ4uy8OHtiVVIXeqz+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794990771;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=02+A9zrKaZBd7XdpC3N5hJt041ephwJkz2ThkbcDFLM=;
	b=fThLR3fkVWhhE/K4bzzFQMh3vLb/4DX1/SUUwc3b8hzOO1m4vv0TFOr8nHh22ENwNixv
	 vrWTjLylCJR6hNsIRxQeMKMNWi3yCfunutYl+GGztkXLiyq83v/C8+jI6lI0kVqug/uea
	 R12KCRfu/cDNVPP4Fum/lz9Q7DlT3HIkMXSPHng6bZTfm1y+1y+mfhTlSKK1Da4ENUkED
	 AK4mwgxFLGuNVwu6POXOsNUKVeAunu98pRvzWPTKOLGYRqmqsduOf9dzCDHPglBjzUqoM
	 NJav19Ta/LDYHb60G/FtOb1el4Qe6KOboYutF+hYhAEgnPGOCeJqKVDoVaNyo0Z1rPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=net-swift.com;
	spf=pass smtp.mailfrom=net-swift.com;
	arc=none smtp.remote-ip=54.207.19.206
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF64606A325
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 08:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF64606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1794990746t504c5f07
X-QQ-Originating-IP: 0rDBQPnzGL9wHWwyuG4jfmlHlfwR7N/hDClJvFM/d+k=
Received: from localhost.localdomain ( [115.204.248.161])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 18 Nov 2026 16:32:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18164301716842919370
EX-QQ-RecipientCnt: 8
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: linux-pci@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@net-swift.com,
	bhelgaas@google.com,
	helgaas@kernel.org,
	kwilczynski@kernel.org,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [RESEND PATCH pci] PCI: Extend ACS quirk for Wangxun FF6XXX NICs
Date: Wed, 18 Nov 2026 16:32:22 +0800
Message-Id: <20261118083222.45366-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
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
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NJcWJJyfcVSIVG0Fce/CBQE8tzBkGSQtv592XKBJgnLfLQa9wckeNV6s
	UOwh1TEyyyyUGNqkpSF/fUTZSSiI4TsVs0S+xG6DkM4lRjw379vw07Qk44bT0Nvr2VnEddA
	Mi97vx9RpEkxtrv9u8ten2S03Fq2/MESmx0k6E76BwMrSmu6Eww27jV6jViucGs6z5e+jYQ
	DwNrOLNn0UKTQplB0TgFjtLlIXOUbmHlWnZmT9nX47nzNYbw2rLZKQk4dY+k8QzJR53u7h4
	u5oIPguCxF6L36rqo0UM7+YefBW9uyAMQYorAJtx8Dkp8vWdyUAhcAMKeb6eCNXUZoKt2Sm
	8LZFr0f/Rdh80hKIii6ttn7v3nNuNbzpptogujYV3i7I3yCpvJ8AuS/K/MHXZc1zzkjAw0h
	mfuuOgeZHMGQ1EXkcyCR98JFjJMcYd2B6LqtZn2cMCd4DOM2d/+PP3LTgQBxxJhZKFXh2qS
	lVZ2XC9MlimD/GeRfKoeza0ceCAYJBXxYMOgyo4Szgpv3Wt9eeHtkvbGYtjTpEdF72Szm/T
	L0WGEEu/kcUiS8rQSl6Pl05T15UD7YmCOVVMb70AugNOPNouF90wQGaS6SA+dFZFQgDeAiH
	/Ovh+DZrQW4th9wQRQ+zoRyXz4fxnLC0mBzM5XWrigNavheqMy7B4MOH6leLJdP+GNN2ApO
	RKlLRA+nPs/1uwwi1yOEI0cHwa8o2n1VcbkJZxfs2NwLo2KWIRDaCDqdW61HjTv4v12yCGb
	OkmHh7m9z9CWBew9BEEb8SWK1++o+FRKZVAvj5hNuSE0KDRsxN++ILhFoZ5ibJSdfwo+eta
	tZwa9GhJE1/0W8L8udFzlM/yKKaa2eUU9FpClWMKp4W+GxBpqf3xAKeZRbrH7sRx1Zjs0dJ
	q+SI7NZHabBH4osvcizyxLnokEXUSpozuxSYT+0ntsLNUWcu/w6jk6JWjmlBQa5Uf7J8Phf
	dlTwxpSytBtvCU8UA1RxoHhZ+mGBq2CuAVdPqz8E2uxk97cIJ3FQhOYeacLzJ7tRM6FZXWn
	C9o3Ef/XyRjTW29OcNt1EssSxSyW7BMLVeDu/akvQji9dEjrmaLTxWmKkkelZcd27Aht2p+
	uprETcjSuE8MURVNuKm9rk=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

The new Wangxun NICs do not advertise an ACS capability, but the
hardware isolates functions on multi-function devices by directing
peer-to-peer traffic upstream, providing behavior equivalent to
PCI_ACS_RR and PCI_ACS_CR.

Add the FF6xxx device IDs to pci_quirk_wangxun_nic_acs() so the
functions can be placed in independent IOMMU groups.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee4..e61b5c96710d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5215,12 +5215,16 @@ static int pci_quirk_loongson_acs(struct pci_dev *dev, u16 acs_flags)
  * SFxxx 1G NICs(em).
  * RP1000/RP2000 10G NICs(sp).
  * FF5xxx 40G/25G/10G NICs(aml).
+ * FF6xxx 100G/25G/10G NICs(am).
  */
 static int  pci_quirk_wangxun_nic_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	switch (dev->device) {
 	case 0x0100 ... 0x010F: /* EM */
 	case 0x1001: case 0x2001: /* SP */
+	case 0x4010: case 0x4012: case 0x4014: /* AM 10G */
+	case 0x4025: case 0x4125: case 0x4325: case 0x4425: /* AM 25G */
+	case 0x4101: case 0x4103: case 0x4105: case 0x4107: /* AM 100G */
 	case 0x5010: case 0x5025: case 0x5040: /* AML */
 	case 0x5110: case 0x5125: case 0x5140: /* AML */
 		return pci_acs_ctrl_enabled(acs_flags,
-- 
2.30.1

