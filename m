Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013011.outbound.protection.outlook.com [52.101.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24C3DEAD0;
	Wed, 18 Mar 2026 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845231; cv=fail; b=Ul1sU/bh3SZjnb32oWyjkasQTJjDYZumXKdlHjaS3dtpcD/ToD3xlOz3bVgpkgbx5w4Luxb1UbNkTt3+9PX6FtDjW8dDxSNoHjdp/08TEa31xt/EaCT0VuuibCKm1jDPSl2pmevDq6Bwvu6iJWUfNhp9L+leFS0HsQgcNh4mTvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845231; c=relaxed/simple;
	bh=ojMVSpDYJpUFJDPfI2VjSoV1pdAE1ebF0hFOC3ThjxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M2U2Zny/1wa5MGIvCuQfRpr1XRfoLQAC63f02ZHLZe/tgiIHXA24knoZR/lyb3JLilC+pshzQHktAGydF5ib0Db+7bE22Sog3qV71Jr+pzXSdV3x+eMfpxMByPlAnsXHKVYKHy0OVI4d0+xy4o4Zx/RCuDzP2AWE2weVdGn3CZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ofXIjtq6; arc=fail smtp.client-ip=52.101.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ofXIjtq6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QiLc3VLiVNJJvRniE7kMgefWQLxvjIYHqh2l6F2ughiWPoLtkmo0SHxEacoYgK+QTx3BwTgWTdrlovIIkOujoobBietaFeeCzLc/GSyprUK3NDv5dqNdaGTPXFYiRf0OkiV+IqbJ36RLjnqb1SboXeJyxGWs3s25ihC4LnqXeonNlwMAcUgt1yU2+aGmamqaMx5yt7utPgBlhONEmuOrHl+RbcJm0gVW+PLysHFBM8rIQgVx8pJEeziaqaGSG/wATh1Aaqn0GFKXEuUUPrag6NR0WnT6h1PrsJfhqRIXXWO1CpWGQvtTAFaqjlp5TngqizS2ncZsyFf93k/WVyiaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/QrbvSGIyox4EmU+idF7/wjvGW5ZIWW3l0pQBjgIZs=;
 b=fI0+BqK/SbPBtfUoTtcUpKyWG7YTdPZZJczrRIZK5EfxPePBh70fjv/4GcF+O8e9BnPa9HWY9lY1sdZggr/fAHiMcBgfLZa1ubVClViNAZRGRcqhw9KvJPTu3tNU8o9Ki5E5KV+831II4W5t1ySqGtGqCpDM5FqZwDTFR6fwXUoScE8RcTbLkaRzzRdXBfpM8NN1fhnYurTK8fDY9QWlAHICPkSvdYkJDLL8rktKG0mOdJvlZFDWoZS+CXTCrUyfXye28aG/bOparNM1b/jUxOfGacV42Xm2/YX1jq3hBFhw9+JxqgvMg7gHSEpLdWeyfm2AA1RxW0g0Zk0W+ytwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=arndb.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/QrbvSGIyox4EmU+idF7/wjvGW5ZIWW3l0pQBjgIZs=;
 b=ofXIjtq6RMGXXiXrxt1QQiLQUs4snkkXl2zCZdhfyRbSrsQphiUrbDVc1oAuN0UdZB6DRnejvy1IqWRJFTxFqnEdEGGDGogNqCM/7w/t563tZi4Z9DhGpFxNFQ3A7zZxpBax/TJaPPCcDDN1IM2vJ8OD95Rh1uVxpVg9HzvuDzTJMdTyNgKBrlQXs7gMDYvFOiaar7cMfRc5pcQjw9Yfra4gnkjmqELu5vdFYydQZOIsolEagzv3cr41cXpl2XjJYBYV+g2lqqQ/9v9/rmb/Y61oxF2yVCqcHLPZi1rNm6XPQeQexV4qE0L64AWFMfJC6rzQ803e0C2O0PbTbX1Ymg==
Received: from AS4P192CA0049.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::22)
 by VI1PR10MB8085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:46:58 +0000
Received: from AMS1EPF0000008E.eurprd05.prod.outlook.com
 (2603:10a6:20b:658:cafe::30) by AS4P192CA0049.outlook.office365.com
 (2603:10a6:20b:658::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000008E.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:46:58 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 15:49:10 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 15:46:50 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Wed, 18 Mar 2026 15:46:29 +0100
Subject: [PATCH 3/3] misc: pci_endpoint_test: Handle -ENOSPC in subrange
 mapping test case
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260318-skip-bar_subrange-tests-if-enospc-v1-3-f1a49534ebea@foss.st.com>
References: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
In-Reply-To: <20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Koichiro Den <den@valinux.co.jp>, Niklas Cassel
	<cassel@kernel.org>
CC: <fabrice.gasnier@foss.st.com>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christian
 Bruel" <christian.bruel@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000008E:EE_|VI1PR10MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: f662fe57-8c84-4cf7-6a35-08de84fd3522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Kj94jw/R/4uWLSZjBopztRb61Q9M0QRAMY3BCp/d+k37J6hOhhUOxuWJroRoUwyx4+7A8rc9TDyLBCD9dfhv/9gWu1Y0NL4PRBOe28qHpyl/eNzO2huANET2TEu9wF4c4/vRCTOk4R109yDxzOSWlXkQfN5IjFJ0aT8md8muputZ8o2lTG78WstbTfEHNLIT/Tj50S80XseCKefvPmxZCnl0FvcCV78fL6khtQSgYkph2+fopz0zVS+nnkQQsVrQ0KF39jfpqOB94SyQ5W/kL/IorVfNFmdvyMp3b7gpU6716IsQeDjydj0D3uHphfP9W8kjhRU3Av4EVAQwCSzH6IStwmBlFOfF8LiMRQSjk3UIA0F4rjntwrSUnUkGaLGKQsKmNVnatD8lt20OpzX/tHTtQ0NqoqNw1bX2cx6grx2EI3v4ZVll4KKG0f3fyM2+xNLanaJm5qBiIj0Ly7AALicKF/8IQunJS8+Op3OwWKsluG6YnB1Vkl9lMTrENyibDkimJ5fJph3e9fRc/U/Z8NrHlrqA/hb+pdgd7UttDbZjHZX6KJs4JhJ0EgAoo3ONl3D09WRp+Cg4zAz3lUfoCdE4dd/b5z/HZyvCpvy4x9E49Zt2umJVNMb/ljVsowapvZfCQeqafEYPMSNt1csspnS77cuRVDApCowPRl3PgGQ/06W5veOVOot6QB02yOf2sXwC3M1mizy5IN5m0QK/yPTA3PwQ5lo8EYgQBuvi3HC59jTqRnnDgHPo+ZOxSu1idfmM7rDKjEI1/FWqLubjMg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p0OL6TZCf6OzHqTnX7G6fdezMYHeTjiGuJJbHmsnkaV3nT4F7ehFtH4et40SgKQjidurAG0RW+q6c85/lPqg9ZrMHGLrVoKstFnNk8kGDuVyWF7GWybXk3ifGj/5O7Vi2B+jVNe/ciOUXPVptigd9lLJ230GgalFhwuuiUck99woOBGtk57RkvthKMbgerCbXt/T/n9GuoA2onTT2qbmfx7KKPxocNf+3eyayzq5JF9XHfE3Wz7si9b3m6XSJWWKo8as3FTVB7z+4ZVFGQmsC3303YXm0HA6MQXyROhav4byZaotvDgz1o1ooJHfKQhX8G3gqngt1Lr5xVSRRzFCi/1fhfJrxNFpKla8t6JlmvbSm6nFI8WnCC4SQXfTPQYmgvaL5A9PSbsJ9snw2MisNlsWXybO76MsBq/5PFAEfdEXpuJ/EIbnQFEM2AB1Zy2Z
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:46:58.5357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f662fe57-8c84-4cf7-6a35-08de84fd3522
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000008E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8085

Return -ENOSPC instead of -EOI when the status reports the NOSPC bit.
This signifies to the pci_endpoint test to skip this test instead of
reporting a failure.

Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283
Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/misc/pci_endpoint_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 55e128ed82f00ae13b6fe9768cdbe56adbe8f9da..34ba06fb53f04e48c1c05f4aae85e6ecd03ef447 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -61,6 +61,7 @@
 #define STATUS_BAR_SUBRANGE_SETUP_FAIL		BIT(15)
 #define STATUS_BAR_SUBRANGE_CLEAR_SUCCESS	BIT(16)
 #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
+#define STATUS_BAR_SUBRANGE_SETUP_NOSPC		BIT(18)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -476,8 +477,11 @@ static int pci_endpoint_test_bar_subrange_cmd(struct pci_endpoint_test *test,
 		return -ETIMEDOUT;
 
 	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
-	if (status & fail_bit)
+	if (status & fail_bit) {
+		if (status & STATUS_BAR_SUBRANGE_SETUP_NOSPC)
+			return -ENOSPC;
 		return -EIO;
+	}
 
 	if (!(status & ok_bit))
 		return -EIO;

-- 
2.34.1

