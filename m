Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E16734B662
	for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889311; cv=none; b=B6GT59KV6oiMzZ9WLBc/kwXmQi6JnWhqoTEzvIP59ruXv/GXRHUxgUSiCpZaYz7AcWipJIjaA2hQcCSa0dyw8J0BTRqeDt+/U8iPQunuarXcOlDGA4d0aORWqpD1cuFz33LsTUoxPkW1ax9DAmpfqvsWP+n/6uPsZQeYfXrvCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889311; c=relaxed/simple;
	bh=/W1Q3b0Ug/An/xASMJ2pUoki7spcWSdV/fbQZmnCzec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A5pbOhb3K+17aMO6UCZj+xnD+W9umo+29ZozofSDod8U/LSA/qR40y5a67D9mwY+Vpr5ngITskurfBNvXdq1dn3SObZI5XyjYyB6T3/BeczzwBrN7W6yTZK8BS7w2TMrY6MHTCoG9g7AN+OZxK/DOKtxYIKVFsAla0T8vZGEfbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1789889285tcd1a6c28
X-QQ-Originating-IP: 2LWhSFEewbzTjLyM7ItfCPczIggz4xiD+kO3jgAFf0U=
Received: from localhost.localdomain ( [125.118.25.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 20 Sep 2026 15:28:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3101724138690995387
EX-QQ-RecipientCnt: 6
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: linux-pci@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@net-swift.com,
	bhelgaas@google.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH pci] PCI: Extend ACS quirk for Wangxun FF6XXX NICs
Date: Sun, 20 Sep 2026 15:28:01 +0800
Message-Id: <20260920072801.61016-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MDGUoPnBmw7sPREF4YgrfPkhvr9RpGH7LIMzTBBXinSRvw7dSMzkzk9F
	9hoIZWma2nCy8fC3rjxPYoix3YtURguBAqelKqeR5hCNX0ruvVHJyuumbRxFq+yXHF6eNrw
	fEE3pzZhtgHK0OJKhdDVyAIij+5Cv5W1jJhRejATR3tLHsHbm5UeXjIUO/nwGYzgHY6R8y7
	/OvvvhRVsoK32GOpojmca8pd575+MyI70G69bWE3y6ysOyGE4R880d75BmOhCyybM/a8O/q
	a7q5LyQ41mjqmL62SMLfirs5nUlzkx7IwK3u2SQvDilgNQgdRXUYgTacIi3xD21mxmw/56K
	9FTGQ/ocOs0eFD9GE8gQB5tA3E4SGmfv1zavmQwC+F8Go+N/Rf0ijJxRKIAs2ed2QHlTPCH
	70kEmkasYWCJOGYVagjC/QZSumo06VhE7K5bY2fx/ARa2p7rr8OXp59NEpuvA57wBU22JUD
	W0moewhmoxeYrz4DKlTpzMNCdDsEbx4/Ekw1NDgCybMoFJtSvq+k3C/ZVFiDglENUfHpYUi
	o65zQc7vMpBoiNqF+1jLEzLclJCbNAjpvCuol8hrlzgt/SOMMn2I4ZP2iLP3jBUwUY2xcFJ
	Q/6nFvBoJkd/fFa1JIpFP8nTgWsAQsZ7DhePREv7xC8y2wzZZAX/DRtSS0t2O3wqiyTRzDv
	qKKVB+Qb7PJ+xa2QelW6TDvTAcZwiNj8cL4eyJRYPIMhlivVi0uu4yqf9hTNy0J4uYXZF8A
	iYOdMUOXIVpJ5o6ag7Lru99GozrVK8zcegvbYr8y4MPmuWWtDW1+6X0GyZVziQDjocmY5LQ
	4pMFavtUj/fe0IYgVbFcsd1gYq4xG83QBNHtXtwCUT6X4DrxDKnirh6WS7eO7Az8OpAI0lu
	x6oI6D+HrNl6A8N2ROvK+PFVar+Mxq5RWtboqyiy7X5HjIKX292tEbhKSBtgP5RP9U6UTKz
	Mj0EzMOi5de602hYvixbiNr7+NFzoi01o9EvUsnlvSNo7yuJ6c0ucMyMrebZuqzZVC+wUQ8
	EQ38wzAvuGP/sQWxqMNXOi/mGNzAfP40LcAE8kUFrlSY3fCySnvPC/1xCr0V8BvtDradxYu
	Hrue/iemP+h
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
index de9bbccda21f..a6ec300202d6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5062,12 +5062,16 @@ static int pci_quirk_loongson_acs(struct pci_dev *dev, u16 acs_flags)
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


