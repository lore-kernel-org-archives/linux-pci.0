Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112B280309;
	Wed, 18 Mar 2026 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822925; cv=fail; b=LQp3j/A60JsxOLknqY6Ta+9G3bDUNmMyy1pE3unkWXM3senB+S6eFGbVlIhq3ZwpTXOsr7MpDwCq4564QE9NfSf224Q2odfG41zlhX2pP3kWgU7vB1Qd5Vxpi1XaZxmn+XcP6NCPaK5vUeYBX0MufvN5HaZjnjmsVB7lxROlgaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822925; c=relaxed/simple;
	bh=kPLrgAcy65HGT24KWRoYJ2esMLUuVjCT6j57H+L80sI=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TecFcBCnrIaHbvJiWwy+9G4c6JDqAVehVGo00/3JF+iwqpcnYskn1i17Cf2OHyl6idOFB97wieZe0cpa0izJGA4XUaRbjFysOQDOokcnJVpl/7EKv/uqJP56YueyQgeVfgU2Qhe6lAE2xjALoOczlnrLfoDQKsowFsMsK9zWDBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=c+lfnt//; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="c+lfnt//"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7IAKznuYARlCLJq0IC6asTpDWORqoHfZ/S+9do0Y5aIPPW0NDTNkD2OB1bFJDPxt2efwGeiON2Rwkt9Kv0ZtO0etQ00RymIFunohSImY0Wu3jrikMD0zackWXkC9LK1b3hRoBywEmmDu/3ql0csiooHOdz5vJd1AMCE6kDxMQvdDbDA9AH9hzAHTTFiN+lkxJLunyL9lU1wDKME1stwtXwD0V1t4vxQ5XC76KX4cJFZ7nPrMEk7/fxg/9AyqZPv2hCsDMhRNU7g8524Yq1eibmOAeE4vzpX7IFHwSc29m6TxQLdi4vV4YDVvzHUTiqoYVSFz1Za1HcHOPd2DDTlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1Y2TBx3lfqSluiZedY5erOyr7h4jGEcEePTNIpsbSg=;
 b=OEOJ6LbvgqHxSaqF0wDvkWlMVagzTtBKipf4/tH8+YYoAxOIFv1uqPxuj9xugtwFP3ZAfYv3uiRe2p5qr/oALZZvCzjUlrkzUzKJTZbtCd1z/WLeV79wU/8pXSBEngctI8f3a0z7FRee4QUaQMg9mEi6fKW50h56LVnJZTn/rlsYtiyDSec8jRzPkniXgQnEFTfy6X9JFSIEzVhrVkj0Be/9SFCWqf7CR/4PiIwgr8lYVgWhDwIvwKHqAu/iJFfIPSRsZKW8MEG2AXVCyM80ACN32iK1HExT4BzkCzdHLwfKB/J/+BAKSa7LNI22sI+3mL2ZXt6gZAH4H1XAoZe8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=valinux.co.jp smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1Y2TBx3lfqSluiZedY5erOyr7h4jGEcEePTNIpsbSg=;
 b=c+lfnt//yXH9JZhm0yEzhSt0CjJeox177Z4U+fl40mUUsQCjBTZllHaTp6VxGKexRaP+1TgrmkVm/MaWXs7GVBmQYhpjpiEYBblM5s+xyh10bCtXTpu9+GuNaybd4wWOsE5TOEe03SQmVBwONRx4BOgyXnsWj+htvm2oonfy8VdFrfr/yWF6J81KKFpchzJgwT2550BPBBUMOZmJo63VUcyGLX4Ne474BXIK++Ewx2Q+aN/L8sa8LcUjJwcJ+fxd4afZ58LVPCWZU4OhtseNgSOlGajd5daCu+EyMxB3AROsji7+BfK1nXSTSUOY/MqHTPv9ORltpamZPyLOHRvOAQ==
Received: from AS4P195CA0024.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::11)
 by VI1PR10MB8110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Wed, 18 Mar
 2026 08:35:14 +0000
Received: from AM2PEPF0001C711.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::1c) by AS4P195CA0024.outlook.office365.com
 (2603:10a6:20b:5d6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 08:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM2PEPF0001C711.mail.protection.outlook.com (10.167.16.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 08:35:12 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 09:37:47 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 18 Mar
 2026 09:35:11 +0100
Message-ID: <0df07ae2-3e01-41d6-b857-01f5a81adbf8@foss.st.com>
Date: Wed, 18 Mar 2026 09:35:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
From: Christian Bruel <christian.bruel@foss.st.com>
To: Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Manivannan Sadhasivam
	<mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, "Frank
 Li" <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Bhanu Seshu Kumar Valluri
	<bhanuseshukumar@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com> <abkdu_7n_lePaTIY@ryzen>
 <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
 <c9278648-1ec1-419e-89ee-0868a4c7c86d@foss.st.com> <abkpFpD3cM_cI_nB@ryzen>
 <ee9b1b8e-4bc8-4fd3-932e-9b944516e114@foss.st.com> <abkw5dltSWVThJYA@ryzen>
 <gbpwik2ad4cuqg3h3wbahhnvvudai3uesmrqinrzknluw555ff@rdkc6i66rge4>
 <27e7aa65-9464-4de2-b70a-575b99f6187b@foss.st.com>
Content-Language: en-US
In-Reply-To: <27e7aa65-9464-4de2-b70a-575b99f6187b@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C711:EE_|VI1PR10MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4aefc1-188a-4d55-af36-08de84c945cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EdRUiDTvxrvgt3J/GlBPmWkCOfNCRwekuNfKYWOqAtHLFnNri8TSaYlco7O5vi28aoblKyVr1k6rfbtN00CdYaWy1UgzSMi51rM23kCjF9ASDV7TMz92Wh6Qc3D8EL2cVZCxVer7l8Y4PfR6HxeMoLBGtD1a37TZ14dVUzyG2On2qEprK1mA1YWzsDNJIUx/RaN0XW52LalnFpC+GUEr5uqvR5LRv7nhRpzuwIk36BOfdS95l87KBhbPniTSvDC0D/dqTE5Y8zqwpoyjYQ3vA+fxIfGc+FUz5TnpHVjXgMzVRQBdUw8q92VQRTXTI5vm3tRrxkOytCvoKRV2H+wBQ2c3bz7eTc61Zuz2M4lFs7vECAHZQwISf2nJyzl57xooOPTkLKK1zMsRVC17rKT6ii+zEQ+5xV6wTZod2sC3vQpiohwyPAjCNytFNruBW/R3dX5mFXIIv+JhJ26QpuVBlBaAuwUn6AVfmXn+CMnXYdbsBioPkgEbB09eI20xeMprbzCr8g7VpebEkExYFTXi6xOGJHRmCPrqOZn29hBTsZ9ygj1UjcQMJPULbXy010f7ZOPoSUPqugpXQ2oFme/bGzBaHPZ5USMo/dx9zA/eHKWPf9VXQJcWZ0K18cNotl007QF0LjZLUoWjPA1Zd3bPA1J95zEEo/ZbCscd7+z8l0aWITU71+WgYF9bwf3bewqRPRwePYlBmmPd93BoIf7XYXruLgdRZNLQiDRNN6pITX4VYCY17cT9bZ0teblFFDsltxAIBD1kQpUjPfpiVGiqow==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uNfQGI2wiUpr9gO5vzYUMTVDyX+ZR6oRIU6EHcytx+hrJx9VuRgEPqbMiUTpiXNZf8wNtMl6FUaMf5nOA+VMOGyVU0qVlLWg+Z1qWBvdi5JzAf95rbPhFx0q/MhVvP9gKn4evyWNASeQMIAIDTGJZX7/a9z5NtZL9vY0p2PIkkTqYuFM9RzIpGKOj/Fko95BCqzZiUBJ+lswTZV6Ck5TxY7pJ9jUBIqC6gWP1kBUNR6MecjxhrkodmGxZAOCP9VgPkSwFCYPzkxhockkJg0GBD2CBcEYnkiIqRlUuwP5GcvXYBUs1ElnGNMOVRUfYgzqXzAQjLKWEZxcjmJK3HKBJ9C2g5PcHpRPdOlLQFY5dkpj1/qcIdr1Qd0CTGSM6oAWRtM2hMc/y7MQR9GhiuMciNh6rtt8KlTnWLW5ntYbGF5lsx5tzuvSZ+Pn3Bz3Wnzn
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:35:12.6688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4aefc1-188a-4d55-af36-08de84c945cd
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C711.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8110



>>>
>>> I think "modify TEST_F to SKIP if ENOSPC",
>>> since it will solve the problem for all platforms that have few 
>>> inbound iATUs.
>>
>> That sounds like the right direction, though I think we would first 
>> need a way
>> to propagate -ENOSPC back to the host side, instead of just collapsing 
>> all
>> EP-side setup failures into STATUS_BAR_SUBRANGE_SETUP_FAIL, which
>> pci_endpoint_test currently maps to -EIO.
>>
> 
> I think the epf test function can return several bits in the status 
> mask, in addition of STATUS_BAR_SUBRANGE_SETUP_FAIL. e.g 
> STATUS_BAR_SUBRANGE_SETUP_SKIP, or STATUS_BAR_SUBRANGE_SETUP_NOSPC.
> I prefer the former since we want to pass the cause, not the action and 
> let the skip decision to the host
> 

Rethinking this, having a pci_epc_feature to limit the maximum number of 
simultaneously allocatable BARs might be a useful addition to the EPC 
driver. The epc driver would need to keep track of the allocated BARs 
and check it before calling set_bar() for skipping or not.

Do you think this added (minor) complexity is worth it compared to 
simply returning ENOSPC in the status?

thank you,

Christian

