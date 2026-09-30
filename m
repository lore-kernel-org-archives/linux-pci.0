Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FACA2264C7
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 04:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741584; cv=fail; b=Jl6W2sQqslt6h1kPnlrVY0lDld87PPi7OrqpjcmJavLqdKiiKuxtp8nGhFPP/PPo9lfNooPNr1VMwOOxhEvx6V/lfK8LWCooj2dJdnYKK9jXzh3W62G2n+NDIi0rRbf66zlR/8kYuHjpDF4ewQ9F4cbaB8bltAoY44GI/Ad5FDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741584; c=relaxed/simple;
	bh=gA0HsHupo4FU9bUtpaRulN63OUUHUNcMxnti4HA41AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b02kL3aVkfFRkeDPBYFfvsE6VJcUFZXLAPEqsYimoWABzH8xQSzx9rjkXmlbCOGjSIlKRykWSxbPU1o0yOzJW2D3cnPL3twOHs7shC5Rs6mXakLpOG9mbt/BhdXFiPzatqTlBw3+S3Jm10fwVeF4b03HmGulk4X8ygZr1n8C1yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=mPGjunQA; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=YSoTN9zL; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="mPGjunQA";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="YSoTN9zL"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68U2YIEa2569321;
	Tue, 29 Sep 2026 23:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=UOB1niwIaBMtnRvEsf4hBuEGA+TWDzG67tVdR5/77
	X8=; b=mPGjunQAO5TOETt9SYtJdnDwvAbVBLpq5rRlDZ7/AHcgotU5Ki+WEncVW
	pw2RtYiOMbiFuN88Q7wTrLQwBScnKJ6QudWGFqi18Nkoj3ViaED2zttLannnTZZW
	pa9tQJGSv1+3TOHKV2oONBm/JvYj2pQpw72yo9pX8z/SYSzyNFb36YY8OcXDoiHy
	r4gnNS+ZPjSK+SoaoKniPEs2yU0yeP47VXAw+9nsjfSXaeIh/3KlEISY9YV3yyzF
	pxSUr8Zo2E6Q581ib5GvRrADdJTmqD+m4PIyCLUvP/Yt5gDX9kkzF7kH0ygaa7gM
	KLa5d1A8+gS7zvyA3KMkkiDrbZgLA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
	by m0384305.ppops.net (PPS) with ESMTPS id 4h0srrrk4u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 23:12:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUc7b0SZfxSzbbVpXiG9DVklKJ/nQytioy5oq3mc4YqHdcjwyroVfEofzp5Y9KteX5wrHl3zTREryyxsbneYlabMg6fiHz94n4ni5yRBANieSewKU5VwnOnPfyOoRqAHZfxOz26AQv5nMqp/jaFcjqLNWI55TkEsWfVSET1Bq12rqY9MZ7pvzHa1zDpTVD8Y7tdektLw4rA0PpxF+FEySVaSmSwdR+dKs+8MZELAaDgM6Vs58tNpSXvv6fUaHrWJE+BUf5qJlqm5uqO3DP7mqpc2huebltm/LzwEfWdd/x7DNRCYMWHwW83dTxbcX0egXDlkOI08eMqUO3RjxpJ2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOB1niwIaBMtnRvEsf4hBuEGA+TWDzG67tVdR5/77X8=;
 b=imfsLu2qe78Ghg7IwWtBdgF5FRf+wFl4mfBNSw7pzfFDT2RD/JID+4P7oenoF87nSiH53I9ZttBcQqKqNk70luu3WDkkaMiBCAxi/QyjefqTXFTLoUBmgS+BYFZXLyxoJlCblMDotM8fg655QRH3tGwVkL2hDXNpNrcLTHACh9O00yRSSltf4KHEphGA1pJaJ5826fVCzIDDqWf9qqtqpj7SDjkUXGtB0bktx/TAz5OLFga0ZII4PRDWv/+12CngmMJTLL2iEW0BQikjtqRlqG6f4BftVe9iMeuYvGtoHNpZsCQITYVaJaiyC92MedjIWutC5IMRlnUWYvikSXs7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOB1niwIaBMtnRvEsf4hBuEGA+TWDzG67tVdR5/77X8=;
 b=YSoTN9zLekBrkyyHN/+0sd+2nNR7t9bKbwZS7TP6uJ6Yf0LabkwDhYu6jLjOAlqZlpo5M+pZLb6tr99V2eXjRdxVl3JklFuumr4vx2x0HP34HUVm18YrIb43Ka/u0dlqJjBupAL30+hB3XlTpRvBy0UgYIlqh608PwrdKJ0v27U=
Received: from PH7PR10CA0004.namprd10.prod.outlook.com (2603:10b6:510:23d::22)
 by SJ0PR10MB6373.namprd10.prod.outlook.com (2603:10b6:a03:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Wed, 30 Sep
 2026 04:10:41 +0000
Received: from SJ1PEPF000037B8.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::2f) by PH7PR10CA0004.outlook.office365.com
 (2603:10b6:510:23d::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 04:10:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000037B8.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 04:10:41 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 23:10:18 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 29 Sep
 2026 23:10:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 29 Sep 2026 23:10:17 -0500
Received: from [10.24.50.130] (uda0132425.dhcp.ti.com [10.24.50.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68U4AFXw3296437;
	Tue, 29 Sep 2026 23:10:16 -0500
Message-ID: <c29cd5cf-6646-4f20-b5a1-cfa73f679d02@ti.com>
Date: Wed, 30 Sep 2026 09:40:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: dwc: Rename pp->irq_domain to pp->msi_irq_domain
To: Shawn Lin <shawn.lin@rock-chips.com>,
        Manivannan Sadhasivam
	<mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
References: <1790734930-217000-1-git-send-email-shawn.lin@rock-chips.com>
 <1790734930-217000-3-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <1790734930-217000-3-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B8:EE_|SJ0PR10MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d5ba05-6522-4698-b1e2-08df1ea8caab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|10067099003|260925022911599003|260925021311599003|260925021911599003|18002099003|4143699003|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	n+HAwS8QwDknzPpWtQwd7RLIPWclON/0LsRztMtHr7v//bvlTf9LAsJPqeWTsddRqYd+Xnn2K96Zh2YAmdytoZe51nB+PGPKfT5RdqX5WB8H0A4H1imKzIude7qEwZEaJRw0D0qeYockju9d6BNsFVNI6OsPt5D09oAwyMFjvpQyZte/b5J5Y2fQwsKb5+Gmu/o/ghbhpr4IJOgV/n1MXq/xBRl/KMjFg+BpMjSQXn/f0roL1ED/5DWrnK6FMdHFkal0yL52Wg5h59GiUevzix2fcndP3bSApDbYA2zJqrvBpZDNDl5VBJAUJxUlNb//IYVpzlttGV1s/0l/vP4cW6cpo9Jop/ZvbtXFznJtPc2vE1ZMschbuHnTHC/GM0HlJZIqbqdxWn1gsAKFKWFYZ3VjQxyg+xF9eL0/Ykr2JaZwcCdoe4Jfn0S7m8Ly+2I7BxO1g8mL5YUPXfPYdmFiZ5Ihe87TQq71gX7KpyyZdRHZPfXw1mZPKWHsHMj8PhTYNETWR1X6hUAuj4dzUtBdonNmGiFVgbEMKuk+ohcoReWWI31hHMzLj5XRSHP8Wy4LXAcctr78oYmg+S8o7Y2xE6jUL2FRaU6OBIrWFokkeyqNUUWxqi70DXeaIroJSE3/ojvsE5oArnV1Hw+NoapzHA==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(18002099003)(4143699003)(22082099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y/P7tOmfsBe8H2IE81Yx/YzzrnDiYkYCk35T5mYWM/LCFpMYpnX/C1bZCyxDquRhtM1CV+CZ3sOP1kIhwYsgOwXNEvxJr0mcM4InmPSpDwUUK93LK1g59gw6N9jnJNZArHTzlk/jqxc6nuIqP/1aACnGGIOxCYc1WYyHREzrZSbgO49qklqeEZdwI8GvXJrGraMK+hVBMPLZ+NhpNmsgP0pM8KL0iXd0Fl0gj1kwT//RMqNgLnCLZeNweR6gOryo4jM2gD0Z0zX/zMPJw8nvOOkj3ihf7OjMQ8lgpz9DsCt68ZNAEJES10SNfC/7SphefcTWespr2B/uS/Ac834lsfxJ/0CzqtjtoofBovo7ZSyygcUzWm7EIGKNdo9l0Oaml5G2HmaxzosWVA2DOQgVHGOgPmqRYaUwC2qyl9TOP0nhfqj2V9uUjgsIDxaygwHH
X-Exchange-RoutingPolicyChecked:
	d0b7M7jGBmi7GJSNcAfN7lXliwaTZP9hJqjpIKQbmkShMOXoa42tx/JC6UgjKBV0rz4p/PEtjt9SdzNgc0bXhJGsNegKtoW/GfqsbbNqS5C0hFxKGAeZtkeC4bkUsp1yT5AhtuuRJVGwLfGkJxAl0mtV54h+Bb400UMjIP5s5um7HtH5xYm/ccRNo9c7xWycWbJ0QKR9vFpuU2hJYow5FjlwVaQWSEN3UwZHdAg8QQmq+Okl7zfla0aAdwd2VL1+InLni3jDF4PasuAx52ojKqzwyzaHC9FvbQnOdmcrA03kN6RzBEDZHSwASMaSyBRvT3tR0s8cpF/vvKJJsTtjhQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 04:10:41.2138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d5ba05-6522-4698-b1e2-08df1ea8caab
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6373
X-Proofpoint-ORIG-GUID: _fs95ecZVBONhG2RBnC5QKAM1kx54q9A
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAxNiBTYWx0ZWRfX+zN/NxfTw7Dl
 WqaDTik1EMWYo+r5kDOXdiDlb5vhFX8moYeNFudakOqHLr9xpeu8UJmE8bNucAy/OdTNaNavcwA
 jAn0EVmXEyVXvkxRpIMT2Q3OWCajPA8=
X-Authority-Analysis: v=2.4 cv=Q79HcI2a c=1 sm=1 tr=0 ts=6abc8c45 cx=c_pps
 a=+JqGDqswvm8kVNJxtWojiw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=s8YR1HE3AAAA:8 a=sozttTNsAAAA:8 a=RijU5f18trn8fw5C3bYA:9 a=QEXdDO2ut3YA:10
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAxNiBTYWx0ZWRfXxc3S2OW6NAiS
 9ECFC2BMtnuumdl/egGox7Lnp2hFrDa7246tDC6Ajaxn4Q4E3qYjyZDNp6PW/UJmBaq3CxSBj26
 9yFCk7mBx348RBZ4VYzbzMgQLCiiwW4NXCpj34+TxHJu8MfHjLCrXMWUPAtPGMS0nzLrCsYC83W
 1vJS0gptELFnOer1kS1tBIMmoxzWvijZeaM44ACgK/x+WXPyh6Dk6/CJA64mPF7an24YIyE+IEV
 pafVrgYZcZ5JKqbYcHPJQ9Zl1dFz490yszrmQB/ZF4LncQzExNoZjkEQK9ovwNSnb+57hcano2t
 Ie4cn19zSI6LKGOLAJfzC4iraX7HBEKcFZo8GMR2Ft2Cw6/JOtnXOzPVgq9b2JaR6FRcZYw8QrE
 8i1U7KVs9PgjbnBcKRa4wpwz8v8nznPVO7mzz9hbKE33DhkCB4ExY3hoH2LLlaAOH9ut9/Z/esz
 39CMX4m4UAGp0d1fA2Q==
X-Proofpoint-GUID: _fs95ecZVBONhG2RBnC5QKAM1kx54q9A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300016



On 30/09/26 07:52, Shawn Lin wrote:
> pp->irq_domain is exclusively the MSI parent irq domain: it is created
> by dw_pcie_allocate_msi_domains() with msi_create_parent_irq_domain()
> and is only used to resolve the MSI child virqs in dw_handle_msi_irq()
> and in the keystone and dra7xx MSI handlers. The name gives no hint
> about that, in the same way dw_pcie_allocate_domains() did not say that
> it was only about MSI.
> 
> Rename it to pp->msi_irq_domain, matching the previous rename.
> 
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 

Hmm for some reason I dont see this on the lore:

https://lore.kernel.org/all/1790734930-217000-1-git-send-email-shawn.lin@rock-chips.com/

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>


>  drivers/pci/controller/dwc/pci-dra7xx.c           | 2 +-
>  drivers/pci/controller/dwc/pci-keystone.c         | 2 +-
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++----
>  drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 3460a83..0d56fd5 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -213,7 +213,7 @@ static int dra7xx_pcie_handle_msi(struct dw_pcie_rp *pp, int index)
>  
>  	pos = find_first_bit(&val, MAX_MSI_IRQS_PER_CTRL);
>  	while (pos != MAX_MSI_IRQS_PER_CTRL) {
> -		generic_handle_domain_irq(pp->irq_domain,
> +		generic_handle_domain_irq(pp->msi_irq_domain,
>  					  (index * MAX_MSI_IRQS_PER_CTRL) + pos);
>  		pos++;
>  		pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL, pos);
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index c35f3f4..388a97c 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -633,7 +633,7 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
>  
>  		vector = offset + (pos << 3);
>  		dev_dbg(dev, "irq: bit %d, vector %d\n", pos, vector);
> -		generic_handle_domain_irq(pp->irq_domain, vector);
> +		generic_handle_domain_irq(pp->msi_irq_domain, vector);
>  	}
>  
>  	chained_irq_exit(chip, desc);
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 7fb165c..0bf9a59 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -82,7 +82,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
>  			continue;
>  
>  		for_each_set_bit(pos, &status, MAX_MSI_IRQS_PER_CTRL)
> -			generic_handle_demux_domain_irq(pp->irq_domain, irq_off + pos);
> +			generic_handle_demux_domain_irq(pp->msi_irq_domain, irq_off + pos);
>  	}
>  }
>  
> @@ -217,8 +217,8 @@ int dw_pcie_allocate_msi_domains(struct dw_pcie_rp *pp)
>  		.host_data	= pp,
>  	};
>  
> -	pp->irq_domain = msi_create_parent_irq_domain(&info, &dw_pcie_msi_parent_ops);
> -	if (!pp->irq_domain) {
> +	pp->msi_irq_domain = msi_create_parent_irq_domain(&info, &dw_pcie_msi_parent_ops);
> +	if (!pp->msi_irq_domain) {
>  		dev_err(pci->dev, "Failed to create IRQ domain\n");
>  		return -ENOMEM;
>  	}
> @@ -236,7 +236,7 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>  			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
>  	}
>  
> -	irq_domain_remove(pp->irq_domain);
> +	irq_domain_remove(pp->msi_irq_domain);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 22e8f95..f2fdc29 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -454,7 +454,7 @@ struct dw_pcie_rp {
>  	int			irq;
>  	const struct dw_pcie_host_ops *ops;
>  	int			msi_irq[MAX_MSI_CTRLS];
> -	struct irq_domain	*irq_domain;
> +	struct irq_domain	*msi_irq_domain;
>  	dma_addr_t		msi_data;
>  	struct irq_chip		*msi_irq_chip;
>  	u32			num_vectors;

-- 
Regards
Vignesh
https://ti.com/opensource

