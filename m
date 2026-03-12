Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464083254A3;
	Thu, 12 Mar 2026 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320620; cv=none; b=GGA9yhxnLKYjOI2SUfA19uNtgSKZvRr7p9NHY84b81St4/B27B7M9hjf7KKO1KmD/UxEwqfw24p21LWb8INxSKjIbkjR66bHVozmnAJZ18ncTvyWxFGeNugKhNkRgD09ibxAoTZzpom+IlrvP5Rw4wWF8rryQnIwKGhmLbEYU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320620; c=relaxed/simple;
	bh=Hd5nSxb2ldI84kKFsCIK5FhWGhb3PvdBxayOMKngjak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAZboN3Asdoidel9QMj74PlHSB5MNP5pBLG7WE7z5sfuovvQgC7QQHUzT+tB99GozJkfzFuvS2Pa0I1QzPBKECxCXnOgnepO+wwkbx6b7WYd6Rn6FKtBHmXQ6/T2UqydKPVf43uGyTdqjOlVBtUI7c0yJVjbFjAhYTm0YVsEQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJza3sfO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJza3sfO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941D7C2BC86;
	Thu, 12 Mar 2026 13:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320619;
	bh=Hd5nSxb2ldI84kKFsCIK5FhWGhb3PvdBxayOMKngjak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJza3sfOyN+Y+RF6ybpBMGFeyRFPhlbUqePq4FLgLN9vyr9MpAXaGwhMhXREhO7qs
	 FeywWKcKNcO77VGxlgUEdLCCRPVIPY/YaJnrkpvw/bcMrORXH4tQtBjQmwvokgmoDm
	 almRyxz4gIyMBuqNufOoqlqtcowWu2VZ7SOscneO/iYbX5i4T1qP6Yq7j7IUJavd3Y
	 ZN/1GNBbbgJodSiiuYHnXvqykFA1tFEZb0JM/B76bpUYjZgzkzz6akhiRn7CfBJREn
	 e7MiumOs727+/SySZWURv5C1Hcs/Ei0ciTLu1fMcyfpJ9zIoT6xHNXWXuEpfNLRsHZ
	 sxruNdXGtavGA==
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
Subject: [PATCH v4 10/10] selftests: pci_endpoint: Skip reserved BARs
Date: Thu, 12 Mar 2026 14:02:38 +0100
Message-ID: <20260312130229.2282001-22-cassel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312130229.2282001-12-cassel@kernel.org>
References: <20260312130229.2282001-12-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=cassel@kernel.org; h=from:subject; bh=Hd5nSxb2ldI84kKFsCIK5FhWGhb3PvdBxayOMKngjak=; b=kA0DAAoWyWQxo5nGTXIByyZiAGmyuXCjMFU2E0DUAwyDciWlEz1ekFB2wmqSZyBzRYTeVzmC2 Yh1BAAWCgAdFiEETfhEv3OLR5THIdw8yWQxo5nGTXIFAmmyuXAACgkQyWQxo5nGTXJ/CgD+I8pk mdGS4hUDjDOHGE2r/4gP/Bomj1unKIlYBHXteAYBAPDZQF8KjCEBMbwh0BYBe11w7JZ2kTFOUKg P7ED3YwwM
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

