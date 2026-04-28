Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924D9230BD5
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353640; cv=none; b=BLPhIuNfYs+TTDY0GXAK+rB4Ig51Sw+gqDFXu92fWZP9nS2Jp0fYu40qcbZOQTOoNwUxL9GIUq/1aePoBiPnPaxZFNvbuXAR2S9Rv5LO57wnetZaV/Hk4Nc/t/itUK2/nNekRmkKLlm110fSzhbPv/ugenahZFtyCv/5Qu/s++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353640; c=relaxed/simple;
	bh=r0NaKSrbWovG8fnj5rcxOfRmVeiW+EFypm3Ane1/QPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQIeUe3mEWpyna3MMIm3lBc+r37AtGD6SbaGbkuyKAOxYm78ZVklNDBheAf7DUoaFq8ZLfhP9EdGgzjTUOdKscPxoyZinBiwSBghwg5gY3Qss61xIpOyVU/gUWPW8yMLsH9WOiPnVpzzS7gqegMvNe9WysMtaRUtJ28dW6B8mTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dd6tINap; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=i7yXMyHL; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dd6tINap";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i7yXMyHL"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g4TKc3SHcz9vNy;
	Tue, 28 Apr 2026 07:20:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777353636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4wwGgUUCKqeRNLYSl7iZJU/nm7FONjxVZ+Ai5uDXmYE=;
	b=dd6tINapR5hAhAfGHlqoznQjuCE9kw+c3Yu/Hj54atcQvTrZQKeFPImaDXGVW5Y4qQEssy
	YwkX65tpQXg+0FVFn2KNpBXT94oyD29y7ao9HXgIPnrJwKZKGiAplnGzMIh0W09+a8ekKk
	afiTFJxZW0wxFaFAhu+Wnh9utwJ1wlpQQ72+HrHFC13J1muw3vqygpOYNfzg3ZIVMder48
	rSXNa+INHOuCasYX2xp7KBOVZlALi1LhqclndWR2U18oR2irIikVuvZpswlBZrGxQGGVPL
	PVY0JW3sMCA1EVprnvoUfRHZQXXNnAt/wpXS5gjr+/KRZVPfeADdOZe/eK35Eg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=i7yXMyHL;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777353634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4wwGgUUCKqeRNLYSl7iZJU/nm7FONjxVZ+Ai5uDXmYE=;
	b=i7yXMyHLkd1+/ZMLzaR5apVclFEYJIc5xrtYCXZ3iC4e0ah8II6JaWb2oK5vvDCfqqqWW1
	VDT6Rz5o0bMEiH4ecBn+rt57wJwflyDhMCXXiIWCrpNVn7d0+ucCRuGmD6xAM0O1+4jWDb
	34RPjfo8qFoPQJTBHlFz+e58soedyYQjjrAasu8tHfzx4hmuMKHzX/5n18W9rT8nF2vyan
	vSU9+l3stNNMa3s3Wcg+bPTLbSWgdOf9XPiOTj3NNG5Enzall6haJzPYgwGL2g32K1SfrB
	W6rGbuLzDOHZp9TpFQ2P5tr+NmQJW9ynmp8P5QgRfcv9HP+lXCiFnXxOOfk0Ag==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] PCI: rcar: Fix up MAINTAINERS entry
Date: Tue, 28 Apr 2026 07:19:54 +0200
Message-ID: <20260428052030.51101-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7c316bcwq66sdwkyigbdr1iswiqk49z5
X-MBO-RS-ID: 567965118288e21acf4
X-Rspamd-Queue-Id: 4g4TKc3SHcz9vNy

Use up to date address. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Koichiro Den <den@valinux.co.jp>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-pci@vger.kernel.org
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c871acf2179ce..1c87fb5b2f66d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20440,7 +20440,7 @@ F:	drivers/pci/controller/plda/pcie-plda-host.c
 F:	drivers/pci/controller/plda/pcie-plda.h
 
 PCI DRIVER FOR RENESAS R-CAR
-M:	Marek Vasut <marek.vasut+renesas@gmail.com>
+M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
 M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
-- 
2.53.0

