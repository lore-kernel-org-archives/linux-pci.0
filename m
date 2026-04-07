Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE783B52E6;
	Tue,  7 Apr 2026 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563523; cv=fail; b=myqTS31CV5vo9vf4+v0Rw8X7O+eZ1rsG3h/2YkBe6hity9floOJ1wbOotHtd9rUKhP8V4bIRpEi0jTTVSsYojNYmPEoD9JISQ7OigUEta1MoBvg3wQtdXkM0jsmLBWO9Bj/QxY1RJSd0dTZ6ZgZOj6YKg0ltIdhy9ry/8OsvrBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563523; c=relaxed/simple;
	bh=Ur+hC9N9q+y/Bh8yS4xBIsJPSa4Y2dnTerXd1DGE2CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=J+tH6gdtARWkUnd7JNKnk5w2dWqj+/AfWB279ymIzMk5lLtJW5S0fwSs/2wjagKmuPXOvGRas8EqY/fxLFFFRIjuoMH6w/+eyE/MAJVUUSfDlf37fYqR6n4riy9Xb1BUupkdxrkn5pnOUjgUFztSXdXDgFeF7Ea5KMbaUX5tCXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=O8nCqh2b; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="O8nCqh2b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIA63srrwU8ZeJdfck8csstIHXr6UsF+5bd0h2c4Z1A0G2Qkpg1RqNYCsi9ZNrp9T5zK2BtVCrqPMVL6JZMALFFis+NAoQQGS+8kJUelil0QPHZNB5jpnfyB0zcM6XMAuYkIasw+oLDTE7hoVUzxmoLaJEIhCns4k4zOaDONRcubfb//R+C0YNUDup7UowIi4EL9+Hur7l7cCq6sWovPIPYdZ88N4eyJkj9h1wDA4Z8jf46FyN4YkbOr+RnAPdPJ/M/LfKnGEyWtAR4QiCMk2KbrpMrEI32ulQxZ8yqTf6SIdqQDvdVYo06R0oAaJIgocUr8bm+rZPbhoUIEG8+5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uH3ZDdmV13hTziajxqns6OfIHTyAmNNk0yj21yeqzMc=;
 b=eLlHRSZ4PUV0euvyIUDA/U+Csj+0yfs2D1zA8m0pcXOAUZXZT7pJdj68Lyz1qxgYeuWuOae85LxBfyVf87nAfrk9QHUjmS0xzGUYw57U4v/31x7uhYPZYGg99QQ5YI2ApWw7KGVFP2FoQVRNO40bnotE3PZ1zwq3Npn1/kIBq7NJHFiPmQJYkkkG7OR0ftnWU7DKfMFpqWW/TACuAwad4rDCiPVrPjHTag9aYOSmHXxL4OFijdgtFJ7ipAnChs9I1GPR0zdiQoeUhs5AnoI2h1HexWRIXr5YQ09l9HadjpU1q0cB3ut6CwAQnTd/KLeoyfKMVIw4scdt+h729kZQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH3ZDdmV13hTziajxqns6OfIHTyAmNNk0yj21yeqzMc=;
 b=O8nCqh2bDdiepdokmUkCBpLQ3KfocESBEuhVwioDN4+xfIMYPB0/y/8fVpETWOoV5ahqZp+9yyXbyXBoUj2rB9JgvjT7ZmBOunkDVI7KwfLv0O3PjDLwl9BmN7x4KLuEGgdOKfXWoqn81sRxU7oXGjykxnLhbOzAeC1AZ1lBpFKa0pGOK78vO2Maoj7ma68DAMvrW5TCx+b22q8Pxx7U1P4OZDzQofTqunMxEqfZVqJ07Sm3QTbDhJHHgCsGLAhw+5BBbplLVw3/4Q/SEtPXD/4uq9PIrtM1xCze7Lo7OAYCqbwK9G/Bm3sQL3QnUYM5qd0PnWLLmCoST+ks0Y2AqA==
Received: from DB9PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:10:1da::10)
 by DU0PR10MB6131.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 12:04:56 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::b2) by DB9PR05CA0005.outlook.office365.com
 (2603:10a6:10:1da::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 12:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 7 Apr 2026 12:04:56 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 7 Apr
 2026 14:07:25 +0200
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 7 Apr
 2026 14:04:39 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Tue, 7 Apr 2026 14:04:10 +0200
Subject: [PATCH v4 3/3] selftests: pci_endpoint: Skip BAR subrange test on
 -ENOSPC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260407-skip-bar_subrange-tests-if-enospc-v4-3-6f2e65f2298c@foss.st.com>
References: <20260407-skip-bar_subrange-tests-if-enospc-v4-0-6f2e65f2298c@foss.st.com>
In-Reply-To: <20260407-skip-bar_subrange-tests-if-enospc-v4-0-6f2e65f2298c@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E4:EE_|DU0PR10MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: ad960d8d-a194-45a8-3889-08de949de274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NWNk3yHaFqK2Ne5cpL0Ef1CI7oc0I/WHp8kEOJM35380gNDfsrXlJsNmUKqOKrFKA8dRijno651UtHJ3pNZwKfCXHj5jTjgzIO+ubv3GGYKrORoh88sLT0eS1sJqHMFoXojkreGk5lQqx+QGxmizzh3XFiVbF62I/El1W6663JnnC/nLmX2WbKN7IYAYQk/dnxDjD+MIbrtqkVFdzuzBVvTyeUGFn99nuEvfEyJu0YKfRS+zo0u91RhTpA2sSHkTj/3boUnXpYHa+EHM3kUq1drZn5H2LCSj8Rco6/sQgRdWUplvfSnDS3oesZOg+wlrMQIKc7fIua6k0SvZULR/f1yvcIARsKBREhtj31J7WQPXFI9KfGFU9AmYzdyIYTIHq49LR4Mi0NFha/ACWc+EtnQBWVw/5WQCuzYlsWyILYZ3nbGiQq4huUAKptGCJkr7UBDHAYAsZ8rj9jVQ7zI9wafqIPOMhGBPUtnZ/qgp9zcZ5VUQkb0ZhSb6KlVcZhmb4oMakvEIgocC+WzgsaXNRjywfwoilEdC1RlQTimGuyMUzHX60arXXq5Vxmpb2TyhxUaCZCaPDTe1lrajCmOJFWVJEIE0BUq7DyQHUheOP+jcAOHYKMLyVmpMToOLwaBXmYWng+2qNjLVZHrj+MEg8HKOWMFd1lA9P+gdbnjQmLBKg7qcIZTXZA1IMICixc1xJP8LQL+fcVZjsg3lGB6zYkue4/ERKjWhPREzl6W9NNG9SfTOwsFQ4y4RET0URtbxZJwl0WV9zDG2d3eiR/FF6Q==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gLiNeCMs+dwO6woIsZFzRA51cFzHV0ElH9TA7aN4jgPNPWD3pKbw0WMfWAXSIMGC3oFzXUB7maw2BGRWTa9MWGR6I/RZmCDyIERBBfdYMjNVzQs9PSAH/wpXbSftv6P/rP8oMPout7vAXBSxhd9zP51C/Lm6LIIpDrg8VPaK0zRdRsj6kjB7jneskIvv7bD0onwAlvt7zHnLE+I/428hOUmpkJSxNoPrqTtRI2v4z0+PSBEOLEqKw55/RAEpmv21lVFIbvRHdeLADsRvhdLyw26nORVhRd6pZoF5NCKOH7xdVgGtE+0BPtUVrMFoycpusdOux8TVx4wP1r4W2mY7E/leUTHp7q/dawhUX6Qf+KtnikTr53U6iBn89Bb8AWSl6Fm3XXnTEwQuyKGG5T44rKWDjoQd3CBY6PG2SC8C69QAdwg1BUuunywQgKAKCUaP
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 12:04:56.2066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad960d8d-a194-45a8-3889-08de949de274
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6131

Handle -ENOSPC error. Skip the test if the number of available inbound
windows is insufficient to map the subrange.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Koichiro Den <den@valinux.co.jp>
---
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index c417fb3a198b2d92c3060938c23807cc8bea5573..588d75c97ad181d2f8e84c9b86b865439152e20d 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
 		SKIP(return, "Subrange map is not supported");
 	if (ret == -ENOBUFS)
 		SKIP(return, "BAR is reserved");
+	if (ret == -ENOSPC)
+		SKIP(return, "Not enough inbound windows");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
 }
 

-- 
2.34.1

