Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8534A1DF6;
	Fri, 25 Sep 2026 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343113; cv=none; b=mrBVUWuOE/e3fQFAwXPc2RWvL8aIqBCKVUN/bRYZOErt5s0ytpzY3MX8gGNYp5U1R/EhGpYvyX5wNUnkkCQt12h/byZwYtqAY47YwnZQrc6GcHI9f89bYoegbk0lzihON1NfP7nqG91moc5ObDMNMaNm3SzfTQsF6mX2yjMM3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343113; c=relaxed/simple;
	bh=1PZmj32CRTBPqeXsEu/4paBeqkMGtbVNIlBpO3t1akw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJXqTj7ADZdRgXSYku3vaWtb3u02lt/B9rB7Sf3FFpKQZmhRKqnnUb08QhfvAQLQY9IxfoLI3lVeTjSYN+YDJq7aSIAmQaVGYylERG3LRXQbKeDA/n4tnDVht7mg1CqGQMjq+lYXYNQQPHW/IFCYlsx/rmVAVp8oaxkhnjp4KrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=JBAOeDIc; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JBAOeDIc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
	Content-Type; bh=Q4/9ic0XNq6fQcZmyLRi1JoQNXeypJEroEwy7jfonHY=; b=JBAOeDIck5ah
	VfgkoiiGEovtouCDdjOs7p6Kp9K1xONJ35y/GoIwhj8QSqAMN5lumXzoGFsCii9FCkmHygCSo0nT3
	V1SCBDQOSppdkGFwM2o957+l9gq5nLz/hNXJ5bsG/Y1WcyTrjlWcFYg8wgetSMwYHJ1bTF/tTDE59
	7eznKo1248cbUx/ez1ZYvnSbLNVBSswdX24Q3mNLmhJwXqxFGnKPmNpmjT0INcU3qe9rvZxA71e8j
	2cBFOuUPXVW1YY9x9KYs68o/VEYQOna22XC+GtCWFpTQn3aFb5+27xK4IE2sZjlSE8V62n9VFDnSE
	B/vKlpr8Zyx9qSDvL8ZW8g==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=LekKit-T14)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <eva.kurchatova@virtuozzo.com>)
	id 1xA5yn-008Orv-1u;
	Fri, 25 Sep 2026 15:31:45 +0200
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
	linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: pci_endpoint: skip when the test device is absent
Date: Fri, 25 Sep 2026 16:31:32 +0300
Message-ID: <20260925133141.3634476-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Every fixture opens /dev/pci-endpoint-test.0 and asserts on the result,
so on a machine that has no PCI endpoint test device all 17 cases fail
in fixture setup rather than reporting that the hardware is not there.

Check for the device once before handing over to the harness. Doing it
there rather than in each of the four fixtures keeps it to a single skip,
and leaves the fixtures to fail as before on an open that goes wrong for
any other reason, which is not something to skip over.

The harness parses its own arguments inside test_harness_run(), so only
the plain invocation, the one kselftest makes, turns into a skip, -l and
-h keep working on a machine without the device.

Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 .../selftests/pci_endpoint/pci_endpoint_test.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index 588d75c97ad1..efec4a84aa15 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -286,4 +286,20 @@ TEST_F(pcie_ep_doorbell, DOORBELL_TEST)
 		SKIP(return, "Doorbell test is not supported");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for Doorbell\n");
 }
-TEST_HARNESS_MAIN
+
+static bool test_device_available(void)
+{
+	return access(test_device, F_OK) == 0;
+}
+
+int main(int argc, char **argv)
+{
+	/*
+	 * Only the plain invocation, which is the one kselftest uses, turns
+	 * into a skip, so that -l and -h keep working without the hardware.
+	 */
+	if (argc == 1 && !test_device_available())
+		ksft_exit_skip("no PCI endpoint test device %s\n", test_device);
+
+	return test_harness_run(argc, argv);
+}
-- 
2.55.0

