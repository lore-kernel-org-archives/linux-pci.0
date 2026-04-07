Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869F3B38B0;
	Tue,  7 Apr 2026 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563503; cv=fail; b=TcTTRGW15FC7H+bsWQZARpCWayAlHi8zo/YcNG8Oxg1YehAe9l02xHUlv+MhkMiuwjKal4P7goQNHPdceuM8iKiaLSINF6Y7sbGxsn8Ym0yJU/9Xq2aWISpbds8SZmrkWwPtFEqOBJGS4ElTjXf0yy4MoxG9TlrBdcMM5gn1xi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563503; c=relaxed/simple;
	bh=xMcfUHTj5oivJiHTBVgp4jU/mITcHy3n+k8Y2SWq2io=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=fb2a5imPcELldmYm7/IS2Q25nJKZmyogLcf/RGwsicp33z8qcknfXLIx6mXKUHUDJAQpD4q+D9RMZiQnYw1iFawuFUQnKLM5K0AqpM897DmwdYfpFW7KREWIfIwctcnTlth/HTMvEbZbLJHjBzjJRVjuTpQToq+P1st9e+NZnRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=TAW2TQKW; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="TAW2TQKW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGeuQXJK+ARB1i+T8+YPKL8eprd8jozbPpaIXPiEGDPtMghcUWl0hkgkv2nS96Gk4kBay2NbCNJQ3Cc3EUSenIZUb2dvBGbdBmVEhAk91DazZDvXyXSlYHjZCR97YtfDXf/lJU2WZLlP+XbfkgHdvRyxD+DdefYwSTUHLCCUO7yxpTFycL/Ys3zaHNdcaEX8J6SNc0kI/+3MmLWW9jU9mr/B+1s/fT/PBBcYoCGgSbU9ADtIWFuWsMSYlKg3N2mVWua3J7vKmdjHglVg2CAJsH/KxsEH60oGyI/JkcHS06QR5aCR76ZPWsK+FuuOk27v1/RQ6GRJ/vyl1AZHMqzfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q9NNeqD4cuk4qVRSfTnmOZzZ+MVmSz/luaQsJdZ+Hw=;
 b=AKIRiDDdzey+ufXp+16qVqbZdDkXjmtnXnvuuRDrY4i7Nw9+7BW3tNUTrCb2zQJpFn0cvnSqfJ0HBqHZlgdrVB72j9qQbyD25/jsr1iMszuVeVP0hk6n/8a6iGAwRpNzTMPQsuS7HZkPJq2odI1MKElzUFAotO5YUXs3Ravr/kx/fMXHKI/1c4btl3ra0yWDLN8mspYCOCCz0bkIStHBQHIJGrWwFCs5sWCKxQDKROMy6oyXVUqwGSOds3XreAakikkHmlzZosprrXpRVjmKfp5p3BN8tPeDpw7aHr/0gkaPo9VVgniJNYI9hIFZLIZxk8NewMYS+gSPk/7Og7b0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q9NNeqD4cuk4qVRSfTnmOZzZ+MVmSz/luaQsJdZ+Hw=;
 b=TAW2TQKW+JcmhCr0e+6PZAndhdtmMRvdFhZyivVm7qM12MoCUCPoiYmgPAKj4DQgTkzB4QDdlyKqvHZ5smmwsbuu8QsINsRMxJ1pLlm6Bn/UMTXMJ/7qheAQUZJ3+CjNBUYBHFmzzb8f7pEfIbPgAZnBgOfBZ0CZ2gV1/rrs4JWgcr2JhQ4eM3J3wuaNK2LZiuJ8g3TZQZw1kPz3UYA2/nShXDNVyYV3rQ+0Vhjbz8BJ2vVx5GyAx8uJtQd9fzqlSyRGg0AVl6kO3HqihUXxJx+rtmVYboqsyJch9+zUJEhivD7PYOLJB1lMZBUPyiFN69sw6jhN9g/7vfxJwIv8HQ==
Received: from DB9PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:10:1da::12)
 by AS4PR10MB5845.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:510::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 12:04:53 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::cb) by DB9PR05CA0007.outlook.office365.com
 (2603:10a6:10:1da::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 12:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 7 Apr 2026 12:04:53 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 7 Apr
 2026 14:07:25 +0200
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 7 Apr
 2026 14:04:37 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH v4 0/3] Skip subrange map tests on DWC iATU allocation
 failure
Date: Tue, 7 Apr 2026 14:04:07 +0200
Message-ID: <20260407-skip-bar_subrange-tests-if-enospc-v4-0-6f2e65f2298c@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALfy1GkC/5XNQQrCMBCF4atI1qYkk9imrryHiKRxYoPYlEwti
 vTupl0pbnT5D8P3nowwBSS2XT1ZwjFQiF0OvV4x19rujDyccjMQUAolDadL6Hlj05FuTVoeBqS
 BePAcu0i94w5KL5RQBmtg2ekT+nBfNvaH3G2gIabHMjnK+fqPPkouuJdW1xulsUG785GooKFw8
 cpmf4Q3E9QvJmQThBHeVEYqffo21d+myqausgl1aTeN/jSnaXoBpifvQnwBAAA=
X-Change-ID: 20260318-skip-bar_subrange-tests-if-enospc-c26f03038e92
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Koichiro Den <den@valinux.co.jp>, Niklas Cassel
	<cassel@kernel.org>
CC: <fabrice.gasnier@foss.st.com>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Christian
 Bruel" <christian.bruel@foss.st.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E4:EE_|AS4PR10MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2aab37-0b52-40f4-7796-08de949de090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bBRrSiY2/3CzoUZ2T3YKcUwlvjYsQ8TAC3jbw+El/Zo7UPl3czrIe4Vd7R7prMbB5PCeu5Gpf8E9u7GP52PFfRhS7hbb9aAgRrrccHargYlnnkyGKSsFESxubETkRUB3o35osfYrK90rGa9oCquDObFpFkbi99d9Jp0ahbUFyVDi2h4enskKVAOh9PpLApgxu64JpR/FdjBcfuy02nGNAGJbgNriQ1RmOQy1+vi8E3jtYsMtak9Ys8/nej/b3XJdqtU16TdC0bGjUonKt0L8BAh0JHPhRfXhvBEmTMwGEs+4Bcj8AWylTVJxmLkizbJki5fhi3nfKp3EQTIOANCvZc1H6Kfx1L7XJBis95a8uF9lyL18/vP1/Ss+A5TQW10t3eTQgJirfCcB510QTPdzPBaUg8G2f0cwTL1Xg8ggB4n5RsgQKl4mAwYrr9wsEo70g9ASJ+mF/eG/P1IL6+xHZ+LorK+dwyFFv9EYtDr0KqJSk8LdxXPI4h/CC2NCagFYc+lNp2mOA1LBcsF05r4yvB4aTcrarKBM2Cv4wQnNvjisXUqQ0LWgW/GUYGhVR2jsrGCcFc7AGbWWhSnuHmgUkqdeKVHI3cvBTyTw2+0CIRKI4Y5KFsdCnzpX+Yym53ANtPG79ijaUEphrvxZZfh3ugRMmoMt2UhzH0Tg/6wvJUqDzPCSySVVOOSuoJbafYKBxJFFFfzHxNVzLovHrHMnsmdIP2yPz7aGHLWrD0gAV0KIw1OpNI05kHx2Xwfs/0dcsBRFdmqpDRymh7vbct8/rA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	p9kf/z5VNZa6Y/ywcaLD6EKPuosSIsYbPb7w6H5Om0N17qQuVeh5wrOzwKt+G9DAIEltTUOz7FjQ9EdoAzKmWYgp/vBEEw692lyXempga4ymTmfCsZr2w1gotnowdwZo4rRtubTp8UVqBsXZQLVww0jCiLLSDERDpLw5vXm4x1qHuLbcrVQyYomrRIAyFuUJdeDW+dZM6zUl0zKnYwheV3D5tgCQvtZ+SZk1nx8UPsegzG/PB85wR6uWb7xFSW7Oahh/wSJ2LkkRzTPrFUUgsrtdluaYWLb3hYmSNcavFicdU3Hq8t2KDl8UqaOnuvOp58P+utZnksmNw0ZSSPvMqpiy/3krWzWcCnllWhcHXEY9Rzw1OHX/ZQw/sC5QxGskYdhzhVotQADI70yFwzSSO4G+W+gAoHMRcn1158OyUcjKDXqiOCMcxkK4U0fFsuJq
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 12:04:53.0356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2aab37-0b52-40f4-7796-08de949de090
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5845

For platforms with a limited iATU inbound window entries, pci_epc_set_bar()
might fail to allocate the ATU entries for subrange maps requiring more
than 1 slot.
For the dwc controller, this failure is reported with -ENOSPC in
dw_pcie_ep_set_bar(). In this case, the epf test cannot be run and needs
to be skipped.

For other controllers (Rockchip, RCar, Cadence) the .set_bar functions do
not use this error.

Depends on:
https://lore.kernel.org/linux-pci/20260320140139.2415480-1-den@valinux.co.jp/

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
Changes in v4:
- Rebase to pci/endpoint
- Added Koichiro and Frank 'Reviewed-by:'
- Link to v3: https://lore.kernel.org/r/20260323-skip-bar_subrange-tests-if-enospc-v3-0-4780f296a5b4@foss.st.com

Changes in v3:
- Remove 'BAR' from SKIP print message (Niklas)
- Added 'Reviewed-by: Niklas Cassel <cassel@kernel.org>' tag
- Link to v2: https://lore.kernel.org/r/20260323-skip-bar_subrange-tests-if-enospc-v2-0-2080f878134d@foss.st.com

Changes in v2:
- Rebased, reordered patches
- Clarified reporting message in selftest
- Renamed STATUS_BAR_SUBRANGE_SETUP_NOPSC STATUS_NO_RESOURCE
- Link to v1: https://lore.kernel.org/r/20260318-skip-bar_subrange-tests-if-enospc-v1-0-f1a49534ebea@foss.st.com

---
Christian Bruel (3):
      PCI: endpoint: pci-epf-test: Handle -ENOSPC in subrange_setup
      misc: pci_endpoint_test: Handle -ENOSPC in subrange mapping test case
      selftests: pci_endpoint: Skip BAR subrange test on -ENOSPC

 drivers/misc/pci_endpoint_test.c                         | 3 ++-
 drivers/pci/endpoint/functions/pci-epf-test.c            | 3 +++
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)
---
base-commit: 5ab7a225888baa5474def18ba3b0a298d27e6ba0
change-id: 20260318-skip-bar_subrange-tests-if-enospc-c26f03038e92

Best regards,
-- 
Christian Bruel <christian.bruel@foss.st.com>

