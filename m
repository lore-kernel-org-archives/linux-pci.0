Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E738D01A;
	Mon,  2 Mar 2026 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445644; cv=none; b=ZF9AP1Ys9FIIjrAhRbqwU9PM0mPzwpMOcf4ilFFoBYJF6L5qDnPKnVadcBWQaFyo2tDkf0CDvDTaC5csHpReCXmytjUGnNh3v+6TMzhjR49t0ENvHUMmGwmdhivBKriPBXnM95M/rtMD/CoR6KtVLWOXnLxnq9C/dUzi5kZUOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445644; c=relaxed/simple;
	bh=Hd5nSxb2ldI84kKFsCIK5FhWGhb3PvdBxayOMKngjak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxAU7jIGxvClZxNSWzhdl6TJKA53BaU8vGzCWoGJNRgmb6NoBnUaLE3Ha2su9I4sKU0iMjGwbQFuYlkXd/kXO56YzhJ/VFRAjQuHhh0LTNPAHrWpJXB3JiUUEUvrFmmSQVgFUlWtSpqpcWa2NZrF0UY3VmdCewb6PWz16FK/V98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMyWNY+9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMyWNY+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6BEC19423;
	Mon,  2 Mar 2026 10:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772445643;
	bh=Hd5nSxb2ldI84kKFsCIK5FhWGhb3PvdBxayOMKngjak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMyWNY+9FqR7FSouYOy7Ikq5rn4Sr6tnTM4EQVZSjmcrke6lm4w8TsTswMk5gKmXO
	 G0XlFbViR7bEvOouRDMjGE/lElQLUyy//Zmd/1kmiYXWsCJMkRH0KsX7iptIZswzn6
	 hIEH/Q1vBPvFBkp5aTukTg7s0pljZmLD76AUx52RWS1E8ftHGbkTKGlXRiLexoepoU
	 XOTpSfo+jlst4MmIdOVYlweoZKBRROqMahDUYCJ0CVHogLctlhF8rj1U9aRottzKrE
	 vzqq502MjTU3pImV6xa1+MzAI5exUvfMNd27WI2gFM0P7uAHxVvjrQRN/4N6WfCbdS
	 LzYeC9bbaFxbg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 9/9] selftests: pci_endpoint: Skip reserved BARs
Date: Mon,  2 Mar 2026 10:59:21 +0100
Message-ID: <20260302095913.48155-20-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302095913.48155-11-cassel@kernel.org>
References: <20260302095913.48155-11-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=cassel@kernel.org; h=from:subject; bh=Hd5nSxb2ldI84kKFsCIK5FhWGhb3PvdBxayOMKngjak=; b=kA0DAAoWyWQxo5nGTXIByyZiAGmlX3ujMFU2E0DUAwyDciWlEz1ekFB2wmqSZyBzRYTeVzmC2 Yh1BAAWCgAdFiEETfhEv3OLR5THIdw8yWQxo5nGTXIFAmmlX3sACgkQyWQxo5nGTXIIvgD/YQB2 9o/tlA5uSRnqulWPc8nu2w3cSvuVuBe0pgszaOIBAKK7oxeNSvQYGV4RaCTgP0uzsmkyhBJisal lvNXiWDAA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Running a test against a reserved BAR will result in the pci-epf-test
driver returning -ENOBUFS.

Make sure that the pci_endpoint_test selftest will return skip instead of
failure or success for reserved BARs.

Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index e0dbbb2af8c7..c417fb3a198b 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -67,6 +67,8 @@ TEST_F(pci_ep_bar, BAR_TEST)
 	pci_ep_ioctl(PCITEST_BAR, variant->barno);
 	if (ret == -ENODATA)
 		SKIP(return, "BAR is disabled");
+	if (ret == -ENOBUFS)
+		SKIP(return, "BAR is reserved");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
 }
 
@@ -84,6 +86,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
 		SKIP(return, "BAR is test register space");
 	if (ret == -EOPNOTSUPP)
 		SKIP(return, "Subrange map is not supported");
+	if (ret == -ENOBUFS)
+		SKIP(return, "BAR is reserved");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
 }
 
-- 
2.53.0

