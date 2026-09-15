Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEBE2F8EB0;
	Tue, 15 Sep 2026 06:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452751; cv=fail; b=L4fRSMY7ZiPSVVvdzwXA2oJ5tJpjY8V9UMtbv34eAiTjzDcbbhJQB7neijSKAvrzg6wzaaMHcqUMqkE+jYwChuul5amPlLIrOrE7EW8a3vkEYGjl5uCwrspQIaVF8hjs2my/8hhyXLgDpBEim6QcnSNmsXaghgshWnXZ+1VqC/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452751; c=relaxed/simple;
	bh=tSwdFulArEyfEvglcVC314s+fmxyCT2vGY/Bnf4eBtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZO6T7AAfUsWo13Ty93pXP5RDS5Tc0Xidr6jgHLlmkF6+vU19N0VMI3LOTk7mn5wzjdg3LpilxVi8cxTVtMlJYO6v2jiGBITliUcMYg5b+RWJOoiRYZZVd4827xdXXsEjKANm3e8B0UQ6iYX3R6abmyUuoz/I49o3q92QH2fjxaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=pDd4IRbo; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PCnhcq3i; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="pDd4IRbo";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PCnhcq3i"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68F2lhhG683778;
	Tue, 15 Sep 2026 01:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=IqYEChbHJk8TYUy3WlOOJI2o/h/XSiB5hoiXiWKQf
	nA=; b=pDd4IRbobcn9YydgqWISN6qyEVOtg2cgudyiIMvdktTOts+lzV1gPltZK
	yTowLHm/1rQTkUN1zou+kcvsDdIczZoBDPlhg88mgGhJx5HfvOQ6BsBQXZ9Wk5V3
	5fB9gQCq4Nj2Inv2h/uwcGKhB820wSplu2oQpfQqy3Sm2xNpMld35IRI+cW8plQC
	CYF22xoQeNOXfjxwq1F/UP1ttwZvIf3xxLsmX3koxbXL81eQ5sgQtmZ4mNI9j0vt
	iN3ULzyMyFUywpd7k9l56UeCoMSbDHnaME9BQopEFzRiE5HpH7f3nmhSDT2y4PGI
	lh8N9jpubukeARif/gIC2UeUC4Frg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gpvpa1bha-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 01:12:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkI236HhX9HJpNtnDfXYrgzTm67lgTCfWOuRkLBBVVjf3aLv+NbT8/luAGCaglAq9RIGugWr59CghUJyZNOAvZHLSGPyvOS18trh8xtI6WjBgLqbfKaYCrIoh2xWm4GLZcqjtwms5HiGv96znIXUMoL5ek7p4ujo/lxfXdD5ceNF0I38Gj8nEZyZZEca2Bp04i+IQFAb+EVDz4TB6slZwWn0XbWzcz2r9c9wT2vt9mWFA0SMiht3asG1N6jV8/hyOiaXgE5ieGiCy8drWkCdaQoO52erYmnkCRHuGhvr1Bsf0fkmevw9Y+Akkx8FvRKTqu7Ay1jC/YBGv0V0e+4+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqYEChbHJk8TYUy3WlOOJI2o/h/XSiB5hoiXiWKQfnA=;
 b=EIrb6sDeEbenrqWR/b/KfMQq9esneifyjs868VGptkKmY8bV6lXDr4lcuB1KVcjykqM/GAR/uEQru7mQBTNBrvGkzWCQXmaEPjNDWaosKDMQ4J12Ajubk7zFnCG2Mi+b4E56kKEyOyUtsnBrwSIYN4OS/sVmIOjSLt/kXpu+PVUcbefmPn+0USjRMb61zhv4MQUsvHG3v7ndZ+T7gy9JOLgu+UoXG13DBV4GuUrZZLtK/0Kb6hpFVwjrVdY4LWIH0OM4VVfEK03wJNLV8+M+NlP5LHD+x/934+HcdxeaxkzZYsBJ4/CSnt9LmlkaqasTQvr8iWyeNwAOdJCSQ7uUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqYEChbHJk8TYUy3WlOOJI2o/h/XSiB5hoiXiWKQfnA=;
 b=PCnhcq3iA5C0Eg4KWs8eN3xdUDACbjW0Z2nlHPzx00wNOODc/AMiAq3+B7viyobMr28qbTbWyf5wxTgeruk6uZ1SfXXYXkKVo0O8kIjTRDB2GuGXADxcMU83NYfa7hOm4RrltHPwHG3Ux5xpAI8+9MIPfpjaCvGF9vkIk5Hgk/M=
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by DS4PPF717557185.namprd10.prod.outlook.com (2603:10b6:f:fc00::d29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 06:12:14 +0000
Received: from BN3PEPF00022BC6.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::52) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue,
 15 Sep 2026 06:12:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF00022BC6.mail.protection.outlook.com (10.167.248.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 06:12:13 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:11:39 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:11:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 01:11:39 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68F6BYgD2664949;
	Tue, 15 Sep 2026 01:11:35 -0500
Message-ID: <137e1bf8-6c39-42e2-8825-693e1d226678@ti.com>
Date: Tue, 15 Sep 2026 11:41:34 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] PCI: Remove device links to Generic PHY
To: <vladimir.oltean@nxp.com>, <linux-pci@vger.kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        "Manivannan
 Sadhasivam" <mani@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Siddharth
 Vadapalli" <s-vadapalli@ti.com>,
        Manikandan K Pillai <mpillai@cadence.com>,
        Felix Gu <ustc.gu@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20260912161440.1032188-1-vladimir.oltean@nxp.com>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260912161440.1032188-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC6:EE_|DS4PPF717557185:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c9b416-20f3-4f96-a958-08df12f048bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|23010399003|82310400026|10067099003|56012099006|3023799007|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	3ZjjltiXMcl2OuC/XYxIKHWE/9LnjL2nHvS4zcbt7Nk+DyDP51Jc+g21RvtWopkBmXmAoqz49cv2gtq4yY3q/ADxDqcnI58Zvmcf/ovfoS/6TgpuFyh8EGFsZKWvKTBQ0iQ2LxIrkev2Ruun85M2Qr7uOIDT/bLcUIc1P/sL1iQdL2fqKKDKt0CB+MECrAYrBKggrJJZbAYDx/kz1Z5oNBmUn/rXBa3fx5IQAEmVCUbNmsLK/RoGejiFUJcVKsnWCAjtE4iFy/CPVmLZ44SUlO7UDpQBKM4Eypy/beP8C2Axke30ag0LND7RmS1+ijvK5+znJLhn74WL8N9b/tfqzbDCrwwxuyJyxnoafL9e3G6SRzNd4ZeOXHu5CmGNKLPuaKaryiCmyau889/ADZq7mPHz+3zUb+oNcawIXHCOnytpX4oXViaPw+o6v3z6HuyiA1l/z6rkrnI+KgI1wdGqiBW5THlFk2K2I9g3RDt0zysBAFbWsWYlazXGI+Li3zyIZOQlu8AaeEq++6nb8sMgL78GgcUD4EdDr+4HnIPGec1a7sDwF/T4PhDHgzKVubyjpfVmtpZJy1HFqiMz28zwz25eWXbbU4ahW4NEqNwuobiAksWO28BaqU3V3QggaZn4eUXnwZJkfJ+qPl6gPO14YMDsv85LzsOHPfV1G1SLhwO3veqP7It+vuz7brzNG7AdLE3QSCo2ixcOqsskdA+yEA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(23010399003)(82310400026)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GaIb5YlifJwpcckIEjy0UlOYHD/DV5T1o9jWM0dsVlHadFWxUlrDUVo+M0atIvVZmMheVQmpODipwK6CgTha95n25bUF9Pxqn8t4raOHk17TGDDITaA7cOR95S/y64HRUv7yGHqT8pNAx6o64+qKiT9gMlDDHWWPelgRhN6NW1GZpq0q6U7uWChPDYPDaplmEYJl7y7HBkvhvpVI3RUXRYn8TgcjQ9ban3e2Xj1A1Pk5yTO0apsKsZy8wtbVHb2lUpDyhQk8zflvDrXqi/EfkqACQB0HvbozPxNz28AyRT+uD8mA8lQOZ9GesGsWyBBIZeK6YUhV0fIOCnCoErlaZig5leCt+pcjBOI4vcMRzqS7o78LYdluI+YE7mfzg3HCqkOkmiubm1A60+DKk/92sjjqp6zbHI4+IHh6+swlWt4qMSsEQJWzN5ZTfa7QVS1s
X-Exchange-RoutingPolicyChecked:
	CKqKdAXX8TBRUmup+0J/qe6nmVV947zqZiJ9LUkfRQ04Rxf6RmL4+2E1zkse+hzLmAh04t5W+J22zKfzdMq3CNLtqLXc6pylWnk68d34oWp6Y73LKe12DEFXSY4OwaoHaHBLRy734He+I0fWxZ/e+GKUSjLed14YqcNgz/kmimm5hSpYIJiQmrhspkb4jLoHQ0yhE9KMLVY+MDXX97h8LPkiEtFywANSr1aqxVTS0c5TNQAHwADZpfh6ot1GEg/vwmOva/goSdGbfjAgQ4UPEBFXMgVgd8+Yb40oCkZxrZuA5W+mpJY62YkaqQEzJv/+P540AnJ9OH1kq+3ePYDskw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:12:13.0650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c9b416-20f3-4f96-a958-08df12f048bf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF717557185
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA4NiBTYWx0ZWRfX0eaeUsGEcXJD
 40wsewqyfw7vO/P7+km+TQRW5J0ArcwC2qEkJkpemLoEPIBNt7e7Bq2oCJdE+KwY/oGXDh1JZRt
 48SZYWH8MF+7phSqQV9qYSt42B5BNkE/+XeqL7ESOCTK3v0vqlxbMuhYUFoyb7pcqjepQfXteHn
 rnAg433vlmZy+NS+Gmbm7+fUVS2VS0B26H3CkMtNRJj7lDHHpaciDG8Wb32stdsCch/jFo0GOTN
 NQiFpkRP9FGrGGdD3gju7Yi3cYXmJ0Q5YtAGJM6f71noayU6u0IeHCYmD9swe+zhWVxPa1LuZtC
 yzrF65yioRSK0Lno4UXSYjpLW1tgIKMlzBk+9jBzr56fVLNomvkYTkF57LvK/sZ/rlodqi+Km67
 YG785PcqgY1VCrJl43tkjEB4m36u6lMjUzNoeHA1Mmr7dgLU/LC+CMbhGDW91g/rc5IXlv6HiWz
 jqYaLWKbYjYKCz3erXQ==
X-Proofpoint-ORIG-GUID: Cl2gDJ3eRqEhAXpOo1UFCUMAHO7JhVnF
X-Authority-Analysis: v=2.4 cv=U7cHnuru c=1 sm=1 tr=0 ts=6aa8e1c1 cx=c_pps
 a=630MGKGvePsHimlcG8SYgw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8 a=sozttTNsAAAA:8
 a=24o-jWoAtj9wDgbWh-MA:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: Cl2gDJ3eRqEhAXpOo1UFCUMAHO7JhVnF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA4NiBTYWx0ZWRfX+6/p7eHBUQE1
 JnIxQssOYWl3qch5a1Ryr5VoWPrroZQcU9kWHwAS4CIs6DFh//6WqOz/tOmVHDJB/z/7cklCnkm
 iyeEv7g/sZkd0P4DCJM9ilLp0MgxgRo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150086



On 12/09/26 21:44, vladimir.oltean@nxp.com wrote:
> This is a request from Bjorn Helgaas to replace commit 9a9d18547ddc
> ("PCI: Remove device links to PHY") from the pci/next branch with 3
> distinct changes, per PCI controller, to handle conflicts with bug fixes
> in the same area on dra7xx in a better way:
> https://lore.kernel.org/linux-pci/20260911221209.GA587622@bhelgaas/
> 
> The patches are formatted against the v7.3-rc1 tag. They do *not* apply
> to the current pci/next, as the change is already present there.
> 
> Previous submission was:
> https://lore.kernel.org/linux-pci/20260810124315.433448-1-vladimir.oltean@nxp.com/
> 
> There is no other change than splitting up into individual commits and
> adjusting each one's commit message. All review/ack tags were dropped in
> that process.
> 

Reviewed-by: Aksh Garg <a-garg7@ti.com>

Regards,
Aksh Garg

> Vladimir Oltean (3):
>    PCI: cadence: Remove device links to PHY
>    PCI: dra7xx: Remove device links to PHY
>    PCI: keystone: Remove device links to PHY
> 
>   .../controller/cadence/pcie-cadence-plat.c    |  4 ---
>   drivers/pci/controller/cadence/pcie-cadence.c | 16 +---------
>   drivers/pci/controller/cadence/pcie-cadence.h |  2 --
>   drivers/pci/controller/dwc/pci-dra7xx.c       | 16 ----------
>   drivers/pci/controller/dwc/pci-keystone.c     | 31 +++----------------
>   5 files changed, 5 insertions(+), 64 deletions(-)
> 

