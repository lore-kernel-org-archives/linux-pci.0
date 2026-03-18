Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949373DFC67;
	Wed, 18 Mar 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773845226; cv=fail; b=mG/BCa3VWBt4PnaoKpi7HDwBYFR2+nsjBB2TC0f/l1112n/GrrYL9CkT/lDxzwTkTd78T3Hfht0vsKSbzeo2YIpTk6Iuf2XiYD17cBASlP5SnTmuzFc3noJoCk6MF5UoMF2+mrNRtOIZ6JvuOY78in6rtnOZihXJZ6ecv9+oVnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773845226; c=relaxed/simple;
	bh=/k8ruzYD2WtHdQhFHp+nTagvIC+OdPDg4uZb7mrks1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HCBd5Jx5isledxyPv6mNrU0HQKA54AfT8eOeY1I2vvwNyyJArSh1TsLAqQFB1zMfXwKJo9/fu2OBPMjfVhsu4KMo+1p5sHHS3+7rndP4dSVOly5U2oRn9aSBsWWmb7nQrFbY5WXvpeVtsCUyQrojd1glpquXDI8pfxaZE8/kgWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eDoz4Kji; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eDoz4Kji"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZbpcTfCdmY0XkdBHZmRs01c5EWZ/6yFUz2VpEwx9NgjhmgEvQYL8TlXDlcMzvHGsXUdCxQKizB5OEJHb3wNFr3RBcfIjrF2v0GZ36K3OKk0pffUjgB2Csx/ZDfCXKO6kUwP07WqTEymKu8w8CZ4TDgMrEpg7N/LHxHMXu6YJKVyBswgqfDpS3Fcv8+YQiuZRBdvZaqbjtlPiuw2kjfrrRW6x62vRVgaZvpFCtYUohWysi/F3e4HaTwyHD5fv8DQONU4wZyiU2rtzuPXPt8h8lPyYV8nC/ykxVh9mePDipKSzHUPlDt/Y1bfiD/gqRQSZrN5TST6F71XMP3g4QvYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XrZ8zDAyjr2Sm5UaJeo7y5sN0PRihSoyLMkPhWCDwg=;
 b=hSs40iUoVkvu0S8y+mMCQT7IxxV56OwbiY65rel9cyK/jDqpR6a9459UraEDcpEbYl5ZmJcZuba5LekZXtk6Cb3F8GlZfSj86etP1dyNzgZacIRB1MdYwQXTRmz7Vm4ZGePNorcQCaMLDHtGkrNG8opvMBAk8UlQntVcCRrsdZIT1uMIoSCwK82/9MVisyfEUleCFsQyICXNU6sSrYRUNelzZqbwdgiwhTz/nhP+/G3Dv5YU2Bpdut4cP2HJxzG/Js3PEG+W7z0l8sranTwavSN1wNnqu1qPQzW0PfG0YOsleFKQJXp3v7QNbK5HxHaEdlX+fYarWboAxUlh9nR6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=arndb.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XrZ8zDAyjr2Sm5UaJeo7y5sN0PRihSoyLMkPhWCDwg=;
 b=eDoz4KjiO9VKS8davKdEm1EDOutztyA6hg9TgGca3xbCluYEpv0k+5a09o3AvIjhH+ayAMmFI527PKQy1xs5eN3d4EEseu8DGAf/hSAetwcmcfn8SiMA3sQf2TACZR/DWe4gNtXhMP66ACYJ06tL6ftK1VXyYxAT7546G1c8bQyEZFt2j26PnDSZuafouW+hC/xRAnM8vz7+ROk0j0+zpvkgdSegPcGEctZB2gscgnvncgXa8tYHfs2dj4tASo4fTAQx8TJyuXBBIOCLiwhkWJ/gQQDcNp+21AmNJ2IPh5H+iyxFPDZWWVyRB+LTg4b6V2/hi1iwjb1ENgfJ5wXawg==
Received: from AS4PR10CA0009.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::12)
 by GVUPR10MB9774.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:35a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Wed, 18 Mar
 2026 14:46:52 +0000
Received: from AMS1EPF00000094.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::a8) by AS4PR10CA0009.outlook.office365.com
 (2603:10a6:20b:5dc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000094.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:46:52 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 15:49:08 +0100
Received: from localhost (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 15:46:49 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
Date: Wed, 18 Mar 2026 15:46:27 +0100
Subject: [PATCH 1/3] selftests: pci_endpoint: Skip subrange map test if
 iATU allocation fails
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260318-skip-bar_subrange-tests-if-enospc-v1-1-f1a49534ebea@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000094:EE_|GVUPR10MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2a7a64-c376-470d-f075-08de84fd3198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EeVyd5aQsclHl7yFoQKnolHv7CeP/7N3vkyR1eMjlQedaWvsP8lH4m+u7dppEQwfJ/Cy6MWrQ7UZIqQ9mRHiRXHB41Zu72bVNjigSP8vvOZCeDdxgxQVtZ3zrF35f7mrukyBdMBhzRCsqPIZOZ3vpBF9pDmpk0WxaVzX6pXEpziI+OkinxcgijSsRDn3WhPGK77ADCYfnfzmMJqKjzh+RyaN2onCeEXrgVNnyEGwMrHtUswwCSaNnoO0Rnx+rVq2NEZY/esJyql5GgNLRnSgdKdk4ECNkbwxhTX7dFDph7OvytFJstI4oDppTMWGaPDpIPslE2w2ZUa+lPCIIxEJIRJvuBJ9Kq9URsnzYqzudV5jkjNwAMiRUyjPKst5Jh1LHOO4s5XhK486HkJxCS1wn3CFFJ8yFa6dMNKRPH980OsbPwh1c48ixJaoiB4vk10Rs+3GaIcrk891PJctD/9q53ohzJAxltx9txPKFioDlpa4iHv0MIMFB3M8PJ4+gocyS/thmuez1r5uMOxq/KvMBn/9BvWgl56Qe/48hJF5XZQjOywVhOQMJyfXrMb+Mcu9HDwFUeZ4bOjDoWq7CIHbPQUZTV7IYeTAv8uds886Beawiqu9cdva7ZV0YoIAu2Gnqy/2W4DZ5DO2XLUh7h4qJrgOoB8Qy2vFY0PsnGuIV/c1gCS3X87KXu7kotWINkC2fuLdhMHOghF+fj2Liyc49bNr6zrFvoAYIwLaZJE1zSncFUsI8WMvaquhXwvFEEIaijOgrAdE+uOyI/ANss2BkQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gr4VDDKQG07h/Va6QO1PTUmn3guKZFacvHnBvakaCsaIW8b6Nl/s7x/enmMIw6G8Zwyf8BIE0TfT2eosn3kIU2NDdn3MQ8WyeQ31zvcAau8cX38x9huMdNyYsxmyTWPMwYrAybUafHmFTaa5DSERhck+GHOZyRsK4CL7UuBGU7gMb0yoOZLDt5GaQ3zNzdkFcvW41Y/l+H/URCE9lhSbl123UNwawVJ7l97rbm+W1mAIsJ+Suer6Xyfoe19LcNC0LprhaetQPYgTTDN/HP3Sb56LzpQFGFKdlaunlUR2IuYttGOr+I2UWWTt4J6vgnAYrV/2Y3nWiK4UmUeotXupzLWf/xzgFU8nQuWK36TQXthY3pp7e6/gVq4fUqAA1f6Oowf3SLaYhoW1q4Q979Nb9TezooF/a4lGjJ12CDRSlOZttK2EAa1dXOnMezhLsrJA
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:46:52.6091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2a7a64-c376-470d-f075-08de84fd3198
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR10MB9774

Handle -ENOSPC error. If the number of available inbound ATU entries is
insufficient to map the subrange, skip the test instead of failing.

Link: https://lore.kernel.org/linux-pci/20260317152707.GA85951@bhelgaas/T/#m87e4c24173097a0ea70195b71aab294ad8d6c283
Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index c417fb3a198b2d92c3060938c23807cc8bea5573..8ea2fda4539d11eb22b22800a7cb8bbaa99c91ba 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -88,6 +88,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
 		SKIP(return, "Subrange map is not supported");
 	if (ret == -ENOBUFS)
 		SKIP(return, "BAR is reserved");
+	if (ret == -ENOSPC)
+		SKIP(return, "Not enough ATU entries to allocate subrange");
 	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
 }
 

-- 
2.34.1

