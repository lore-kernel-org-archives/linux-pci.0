Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73120273D8F;
	Sat,  4 Apr 2026 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775265608; cv=none; b=UILycQsDJizlwFAXCTy3dXwDbE/e2j5tjNVf15j9C5gVbMbxBXhBCjbhyHGCtPYIC8Dki8Rscnc9PLNPgSrCnT0/mH91wFoPRVr6VfMIcyqE9iZNYONg9ED/GWR9SMCTrEOfu5rslgJTRpqdOdFX+3fLviw7o17JfIFTWI7FRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775265608; c=relaxed/simple;
	bh=V3grCh/IvHL38jRC5lY2X4Fg0tr+ZJOpI/LmrS+pa6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVgi7FU8szngNdkyP3qHluWxtiWYQUVNao6oNDgJ+Q3k2CetjFTjAdbY8x8WdaUKlrxlbZGAxLyJfiCB7N5stdOGEdWYi12lWEJOFlNqyK2Rs8TSaN2YYZFQtQHvELANtGyKQZlej1qV33VkFoggGWlwn3Z6yO54N4o7/liBGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUEUtbzd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUEUtbzd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BA1C4CEF7;
	Sat,  4 Apr 2026 01:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775265608;
	bh=V3grCh/IvHL38jRC5lY2X4Fg0tr+ZJOpI/LmrS+pa6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HUEUtbzdKhLyjc6EOrrhoXAoqPJiBI0SbLWgSK7Sod9K91v0P3iXK0RJ32c7jxFNw
	 48mW/d8LC4NkMFcmFcCgqB4WzD4DUBVonsLXnNW5ZNXG2+/Ie5qyic6tomuqxG+whO
	 zy4eSWk1D5YwP3TfcSM7i7JU4lJMDifwcPsGYfLtifRWTlg+MxbwV/fQXm+Yz+KiSd
	 yrdvAEbxmeo6Q2ScSbOLLamLGoCVEb6oz1ToQSMgWnBoCKemSBDJaCCb8YoNTC0CbM
	 7FEpLiz/n4Y81dJYMl3aLiEXZmlKAz29Ov2ZEe5+/I+xh8nACdnQ/ZIJ7Qua5N8rNi
	 5IzvLAopuk9eA==
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
Subject: [PATCH 2/2] misc: pci_endpoint_test: remove dead BAR read before doorbell trigger
Date: Fri,  3 Apr 2026 18:20:02 -0700
Message-ID: <20260404012002.111873-3-carlos.bilbao@kernel.org>
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

The assignment before the writel sequence is dead code (bar is
unconditionally overwritten by the re-read immediately after) so remove the
call entirely.

Note that the DB_BAR register is a plain value written by the endpoint
firmware; reading it carries no side effect.

Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 276bed3f1c18..07c5f19d5c5a 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1081,7 +1081,6 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
 
 	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
 	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
-	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
 
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
-- 
2.43.0

