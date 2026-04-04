Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8123D7FF;
	Sat,  4 Apr 2026 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775265607; cv=none; b=mufsMFmKRPYJ7YcGXJ/NszVjFM9VUarBHevrZtyLLS7zNPWt6xH/spftLUsoIXnDnNNxabkSrX/UHBlN2JqjeDta8sfBmpPewt+uN3i7W8l9CbWULvvAkIgoRXDzZhkdHVTg37+ItUnHhDjPPdSUc45nn78d5sC7y49Dy+h76iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775265607; c=relaxed/simple;
	bh=ETZOx9K7I20ciJf/L/y9FtbnIEE/Wq01xt8MytYNDZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldYe3Z668qMTlEOO9jDr+KYrljivYHc+25UBekNDEpZm+SDIWaiZxHml1ea0tA0a6t3pr6GwkPNjbxVL9G29epv4CScbkUCfXz55GVs+g7ln7n2zt3eFruuceUN1gdeDFSlUQM0KFv8SxgWrRENx2xqwOYC8D1I1ODUW/0yBEW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgS/UBqI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgS/UBqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCB1C19421;
	Sat,  4 Apr 2026 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775265607;
	bh=ETZOx9K7I20ciJf/L/y9FtbnIEE/Wq01xt8MytYNDZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kgS/UBqI44h1bOI7Qa2G1M7sMhD+fD3e48RoTm48TaOrDKwkcUyiLD5iJTK26a0iP
	 NignMXiiihYuqt6u57+Zvg7Ul83ea9VJwn9w6ahm1oX1eCVCj0lOC97bpk6rORElYT
	 Ws7jq1uxj19GDeivuo1LaI+CGheIjhU9eynbEAFds+GlJtYkgYlIfLvlFH79GmFhA1
	 rFJxDohInZEEzs9RFpSp+U3w5ijYNyku+pIb6EJPVEvtSn94oJc8mSc2t84m1v5TS6
	 Tp3/yg4qTvGNc19Y4KBAyc/HjE+ulF5T38wsleWYO8NEaLmSlgXyWFl7qxafMbD/N1
	 UIUQZ20kT1BXg==
From: carlos.bilbao@kernel.org
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bilbao@vt.edu,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH 1/2] misc: pci_endpoint_test: validate BAR index in doorbell test
Date: Fri,  3 Apr 2026 18:20:01 -0700
Message-ID: <20260404012002.111873-2-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404012002.111873-1-carlos.bilbao@kernel.org>
References: <20260404012002.111873-1-carlos.bilbao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <carlos.bilbao@kernel.org>

pci_endpoint_test_doorbell() reads the BAR number directly from an endpoint
test register and uses it as an index into test->bar[] without bounds
checking. Since the value is a raw u32 from device MMIO, any value is
possible and if greater than or equal to PCI_STD_NUM_BARS the access goes
out of bounds.

Add a bounds check before dereferencing test->bar[bar].

Fixes: eefb83790a0d ("misc: pci_endpoint_test: Add doorbell test case")
Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 74ab5b5b9011..276bed3f1c18 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1089,6 +1089,11 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
 
 	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+	if (bar >= PCI_STD_NUM_BARS) {
+		dev_err(dev, "BAR %u reported by endpoint out of range [0, %u]\n",
+			bar, PCI_STD_NUM_BARS - 1);
+		return -EINVAL;
+	}
 
 	writel(data, test->bar[bar] + addr);
 
-- 
2.43.0

