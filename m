Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2EE3783CB;
	Fri, 10 Apr 2026 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862188; cv=none; b=k66NTRZEnbW7etCSRvIlFAwuSjC8FqAdrfaqYTChP3XJDIUE826L6DbrHdDfE2qMfIIediUq6fwpa0JBkdDbEF8or1cVXpY7U8kDAEhNws5KpZVac7aY3jUyq7XJNQosnP0Kq2RUyhSEPhJFnC9SE4mipKtc7avkM5VafKuC2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862188; c=relaxed/simple;
	bh=orC38s5pXuBhm6Fdof8xYniPptfpMYASy/IAuLznHD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjBzlLw5TalQ1tSO3WaylHIr40Ldj0hOxOJUsqH+Bl1CeygL/Q0LvUhoFQj7mhtQnhRdSgptE5mlbrOzH9HEQUemxys0p5LMjmUPYJn750SmP+ylRazZBxBfzB0nvZBFlnFUflBxUAEUO7fYqwtCkLeDQ5eR04KoAkYeTblRUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoW3/9Cf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoW3/9Cf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708B6C2BCB0;
	Fri, 10 Apr 2026 23:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775862187;
	bh=orC38s5pXuBhm6Fdof8xYniPptfpMYASy/IAuLznHD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoW3/9CfYhYw/9oq+RGMcs9vWeKqw4E7p0tWAMCzHyc8zk0moKGBCW48iG0+bZav9
	 8FsLCm0SoCk0dcZmQAb050QRJCkt5MI/4Idq7OrgYvv3EsK7xf7+A6UQghu5xCZtVq
	 WARvgWdr8BoeK0Fl/DT2dexx8PT4tVyelhKzC2m46NsmkJzfiWTIPTsSNmNlGqko7i
	 pfqkEuzzTdo7K9VqHhmLEH9ZM7G7bys4aXXYCjCC8Jpcn5BubHUXvQkjsK8Eo/G0aJ
	 7E0pZLCJwtwsv3A/K9cKSYoRk0C2zRvpZncFJSI0xsfU4SZw7MmbmrQ2rKJvu2TvSz
	 mQ+1fJoazRHiw==
From: "Carlos Bilbao (Lambda)" <carlos.bilbao@kernel.org>
To: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	den@valinux.co.jp
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bilbao@vt.edu,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH v2 2/2] misc: pci_endpoint_test: remove dead BAR read before doorbell trigger
Date: Fri, 10 Apr 2026 16:03:00 -0700
Message-ID: <20260410230300.135631-3-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410230300.135631-1-carlos.bilbao@kernel.org>
References: <20260410230300.135631-1-carlos.bilbao@kernel.org>
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
Reviewed-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/misc/pci_endpoint_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 0d0b430de0e8..7affab786ae4 100644
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

