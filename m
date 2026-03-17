Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9083A4F5B;
	Tue, 17 Mar 2026 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741698; cv=fail; b=hhgJ5rZJ7rw5jtaVJEYpvZu/X6CBay4j7Iwk6jL8eK5rAyW0XBZarz5QyKQZIaiT3h1JsUvbKzYNa79tjFs0EWe9G5DSMs2iA3LoKD1e+XcJ6kU6FXKXbs9AZIrB4zbtqaML6/9Hicro3uhat8Lj2Zk41y3tObQnR1rWtbssPdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741698; c=relaxed/simple;
	bh=Wna+h3euQzYHerPwfEeRLf3+gVwaSgNj39yMaOED+QA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=lb7rrh1KgBDTBqpjiOLu85j/EYLWBETfiil20c3aAI2vHUOjt2kei3LC5wTO4dV8H3+V4dCjjDJlNBjCH+aBUbcOO77JLe5rJpQ9G2U5uZA88dWPhovCKfXvPAv/19UrincO7Bj9d2kzQ87Ino9W+HtIE9Y7KaR/riKshoQn1+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=LvMtPoDE; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="LvMtPoDE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGJspjHFOhEYyKmzPRcskt0BUFQ+4vJzzek6heTpV5uiXV2glsF9/8MFhVCnKegZAHMwV9NChvfXjdToysP+WpVj75Z9afrp+tji0WYDa/XwzclrjOmICBf7O7XgL35cE5RobHle1mD/7ZvkDuGaztMhblJ+E4KkPir2bmdDmr4NxZWFBkav4PsGZJE/GXVM4JJbR/DT3h2EeI+ZNWCmngrs8dFDQZqEssRFbXvndkC+HoCaeol210bJCGjuegA/g158Bke50TUl6d8lJ2ElWalyOylrO3cQMRRJI0hxl5y/U5yIjOIXdS1yJu3esuSXPzWLR2lG76TfpCSM3ZCJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvOuYV9wCqJOvmnNkJsHWJ4gKOvkptsF89vPBhbPiFc=;
 b=qbAyfvufjHZhNZGT643tvLqMjWLadz0PJn5bAI8XTeDFTMiYWvhA7SSISu0g+XQMWmDHQpS2W6PHxlmD008AWe8DsAGyB97MFdtWcOj93gmb7j5kplsnPk/r6fxo4VxRo9lH0o+s4BT+Lu25LO9luU0NK4dZvQ3o3p+ZQ+KN6MlwBbzWQwMEI96bT/k+BAzec9o0OHbHCOGpCkC0g23KzpujIibkvzkck8z5DCz92x8fs/rBWTMYHhJGyZtETyxJGMKj9GGoVFusXM3Vwmy18L4bATZBrIm1csGreZJV+g2m/kJYYcJPGPmY5d/FuIfWOwUpmi6gNbW52800Y8IFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvOuYV9wCqJOvmnNkJsHWJ4gKOvkptsF89vPBhbPiFc=;
 b=LvMtPoDEXcHN5V7PUk0t/K4Mokx5Fpbd7TNbyKj6r/SLx0MaVim25YlHFk/yvrpPUIGBABox6ntfuttF9VWalMq0b33wJeY6EiAUF5DpKlIOR27H6cUkeY4quBNPAJC4ARggJUfV5VitP+Vjcu9XZd+3qYhicSfEXws+gr73ecrlVeUe8x2ffQr7dE9qrBMyt6RAGVKOHu5E7O9B21ojy99B0kK/VOr6z99fNmouaHvCPIGhx3/hJ4liwZgpHmZcb8193Avj8FqCnl/FicdkFeAgN5hhv5ASTFo8yXYx+rZoiIVI9F5UlRqPcr09rOZvz0eM28gGD8AIJ+/IhpLfPQ==
Received: from AM0P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::16)
 by AM7PR10MB3608.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:134::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 10:01:31 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::1f) by AM0P190CA0006.outlook.office365.com
 (2603:10a6:208:190::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 10:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 10:01:31 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 11:03:47 +0100
Received: from [10.130.77.120] (10.130.77.120) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 11:01:28 +0100
Message-ID: <c9278648-1ec1-419e-89ee-0868a4c7c86d@foss.st.com>
Date: Tue, 17 Mar 2026 11:01:28 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
From: Christian Bruel <christian.bruel@foss.st.com>
To: Niklas Cassel <cassel@kernel.org>
CC: Koichiro Den <den@valinux.co.jp>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Kishon Vijay
 Abraham I" <kishon@kernel.org>, Frank Li <Frank.Li@nxp.com>, Kees Cook
	<kees@kernel.org>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Bhanu Seshu Kumar Valluri
	<bhanuseshukumar@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com> <abkdu_7n_lePaTIY@ryzen>
 <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
Content-Language: en-US
In-Reply-To: <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000042:EE_|AM7PR10MB3608:EE_
X-MS-Office365-Filtering-Correlation-Id: 937bd867-ca21-433a-cab9-08de840c29fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YPWD8sp+lL5oPVZETo4uOtlJ4Rpic+HTXeyhjBj69hbp8HVCRMIpOwef/Xem4AqLZcGvoc49vdRBKUUn1MHgx0WEJ7TdD/+Z+LQgh2vnurzXpBfRrwy+d6Z3dndV7WAeX44kB/lBlwWgtT8mtew9XZhb6hKVfBD6r4SqO2qUq6KF0Rdcrvev2Emm+Z4A3nn9rQDfnNVOJxxqEdATh4f840xN1qo5u2ZYA51EWZkyQDgYFe+/Y3tsiZmHQkap/j5L1DOkZ2Mmdybh6zTidX496yFNqglPe+a6eRR0LflsIOArRM68NPGwANtFUAT4+WOcaYVl7yBn9lgLcot0drJaZ6wZWSFHL8TROk/sULOtKrVgYkJA4CkGChF4uJH2c6q0f+xR+jtrm1V7wZKAJi5+I8pGrtjQCKFbuL6+VqtjO+mD6rOItRz5AeODy1qd2TNmFRkdcb4tvG8HVlviOzGvPZcE7Q7+2xs8kLjPntWlFqrJi+bj1aLobfGJ1Zl4rBi0TrYqZ1erZVg7YzdtkwRdmDilwoSAFE1ZWnGhflJMMyllOpXb3IL3Zsmj6AuSHGgBpp6CXXg6FwQjHl86No4/5wjvRxtVH1NlbMYoACUwvqa1/rKrtxrNltrsVBG/gBTy3En9+AJJ118D6aZy6SMcArLCQ6+9PnnfFUi277eBseGiFQwS63AjX8hth3yeOTMwz/lVN+L/sKa54TnZ31sv6ImxRbdAuexKNyjg/cuO7oG+5gM2oyjX6Od395FLv+fKpcgfbaF20jWU5mkD2/uOhQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kYP0QrKSGKeSVxiY0cSdyCYvlvK2opPRcy4nrR8w9gCAMxLWNqev3udY5esgv+FIxr1bHqFRo8/emlzINOmv0wKSKUIJUarlMjdUr7RpCVmFuajAs6/udGXG/1DzPXxhenlLuNhv79fsFgOiBCpwaMVvwc7Lh+40KdxsQezquz2z2m5bD75lJXXnRZ3hNBo4pPW21zo15ORy89F1tPhxRqeseVuuaQHJvmTDso2+p1A5fqJYGFnhYBrbbAF1XEIhqDA1JEAMbB+IZ5mPsvkF9kHv7RKspkAPc9/9xsML8GMV0CwKCtoz5opaEjdVk+fJuWyPfeh1kcCg+Uz7hVtT5wjUw5Z2UeiSsdaffofYBAq9/sJr4FlX2/F9zgW34Ee+cF46cts9lqZ7zymRxMw9FpZSum9Tfr2UK+yPfrQ9v+NouI1D0uZS/3r2LJjnXYrk
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 10:01:31.1333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 937bd867-ca21-433a-cab9-08de840c29fe
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3608



> 
> So we will need to add a SKIP ENOSPC case in TEST_F(pci_ep_bar, 
> BAR_SUBRANGE_TEST)
> 
Re-checking this, no need for ENOSPC test. The real condition would be 
EBUSY. Which can be handled nicely in a stm32 ep_map_addr helper.

Christian
