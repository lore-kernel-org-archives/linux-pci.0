Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E591533F5A9;
	Fri, 10 Apr 2026 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775862187; cv=none; b=U1SCTDhB00H0Siyie0M8Pu2roRr5RwiMPAeZ/lCsXm9e8li665ZBNJDkwHsNbGDdMjlIfJluZmG/hPcoVmPe4oyJ56tYrI6yVFpOnRzAlPlWyDFOwgMtwleliMtaoATBfoztT25CzBsYZ2bUYogi0vkqsTUGvc8GHogxecTiHkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775862187; c=relaxed/simple;
	bh=RJbHTACYPsKias2m26X60C9BBBMflClnp6hW86zoAqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWGLfJh/tuQ+w3dLFYyQF4tKU/nFOoJpjBPJKYwcMUYXSvaAj51/xODlAI8RUvdf2JHyHvoP8Nma4K/0sIEvy98HsCNPWQjt/BgVGbkStjZkshvzioKKBYKVaoZeb7XdwbEaVCj8hBbNvbKIzBQpve1Qsqk4Y0DkPMW2hIPAhyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXY8oKHl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXY8oKHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C72FC19424;
	Fri, 10 Apr 2026 23:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775862186;
	bh=RJbHTACYPsKias2m26X60C9BBBMflClnp6hW86zoAqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXY8oKHl4vSwLdY/zGXq3J8T4QwqzBbzvw7Bmgce0Xis94PGGUMm1yhhVaJX/Yzfy
	 d5ujayv1Jaj4vfL/IvxUBb5eLoEODftvfopZbdZNNtBbrZWlj76BPQy013sF4I4Lj8
	 dixjTjDCM3Ftx1RCwENUmtVMOkDUk4EMZ/a0w26S2z7MqejWmP91WyUQH8miHbzCCO
	 0hzPYG7aKnt78h9nXLlQJbLi1ktNw3rlluiK+dH5cVs9Gx8IXAGh5KOTZpBWxhczYy
	 sVEQ8PgC+P30NLL3iung2tz4n/RJl8HCfK87zg5hUhYSnUyRpNhH/rviTEAj+PZ2qi
	 RSBIyQKD8wE2w==
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
Subject: [PATCH v2 1/2] misc: pci_endpoint_test: validate BAR index in doorbell test
Date: Fri, 10 Apr 2026 16:02:59 -0700
Message-ID: <20260410230300.135631-2-carlos.bilbao@kernel.org>
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

pci_endpoint_test_doorbell() reads the BAR number directly from an endpoint
test register and uses it as an index into test->bar[].  Add a defensive
bounds check before the dereference: positive values >= PCI_STD_NUM_BARS
are out of range, and NO_BAR (-1) as a negative signed value would slip
past an upper-bound-only check.

Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 74ab5b5b9011..0d0b430de0e8 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -1089,6 +1089,11 @@ static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
 
 	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+	if (bar < BAR_0 || bar >= PCI_STD_NUM_BARS) {
+		dev_err(dev, "BAR %d reported by endpoint out of range [0, %u]\n",
+			bar, PCI_STD_NUM_BARS - 1);
+		return -EINVAL;
+	}
 
 	writel(data, test->bar[bar] + addr);
 
-- 
2.43.0

