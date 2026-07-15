Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D93CBE7C;
	Wed, 15 Jul 2026 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103384; cv=fail; b=PfaWjryf1UaGq3N3YGWnb+6UxZCj98lKV/gPf9e+dgSyRfNWMTZyGkbqoEkC3S9eblr74y3RElVe+5apYvZBzkxo4NONkKpJRshTlmLr0ilx6nMRqfVtx7NFxSlT9ypRckhF09nADVU/8hAmlaS7AzsoSyQE4ilvqNtCb0I2ca4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103384; c=relaxed/simple;
	bh=5JgdZlFvOQ+QkRObJChuAti5DqGbpctNGzBTm8phk30=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CVdONAdqSJkjb2kSs27pmX4cUIr4lgVBvRvB58Bnnqukx4AGyQlWcZYg3+mcNdcKmJGcGRZmDtGjHd0F00FXfsjNaRYqf9YlD/jbHSbzYRR2j5CvLe2t3necACK+WYgO58toDDNpsOiGIMNxp+X9SMCgQsniuYsy8s1CVoIDMok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ejmxH8NY; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Cqb3KgoZ; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ejmxH8NY";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cqb3KgoZ"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66F3jXkx2575349;
	Wed, 15 Jul 2026 03:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=yQlqwBfc65FH+2HxRqwcBbEnVVowm37MJ277WssqS
	VQ=; b=ejmxH8NYSRSCejNDqtE2y5Q2vGDCanccvvLm7Jo6gzzWkaBKAYD1b3H4H
	BNAuRM+pHCJiR+8gLb9/pbOWduZgVAzBJTCUYP0HIEqflViv67d/aaZ0U6FyRM/o
	mUmiTQy3R92CXYN3dt56mW1wKNVFSEeMX7xO4kMmTOPSyPxrrQFXFtkcLrXW5Hxo
	P815WlCFVNSHKhFA8zrw0HEMkfsyZVzzGopCT87WMw5yJ8jLGVIaNZ8EHLgZvHlw
	2lBhY5CoCeBIruKvKzSP4LPft1Jn7460wQ2qTK2Z7Gateijmjj1gLgA7bxjyC39d
	5tVPZpup4vkBKKLfqZC6ji+qxnGWw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fe0501sth-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 03:15:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlZ861rLNlOJRQ7qAW4xb6H3Zg+haEjZCDikyooajIflfJ5G4W28nJUQpHgqT6wD/h7Al487WV4Z3aqeSlFn64qii0RZLDmv3F97p0J/YPzyq0Np+7lxseV1p9g1i2J1qw9pfK1+/uHKcq1CsgBJgCioO51q2uPQe6XT9VQVRQofZWEquFIInpKVjHyCJnjET3+WfBrzeqJ0wb8D2bXrVSFTTZXbcgPONszv1YXAhep0sxqb02Txz9nbQbdENiYNokJPynzYU1ZVoBh2UdZEBB7kkuVfoCKwiCmrWcBGwCLCLbkXGZAVFuNCW0qsPIP8/ECJ2XBhwUERH+5tFmYQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQlqwBfc65FH+2HxRqwcBbEnVVowm37MJ277WssqSVQ=;
 b=UBaac9kdDJ91HKmAEPZ4LYe8ADnSlpCvNxmY8RIAnq4P0gzlnd0wleg85r3wRqTQi+X9ReqCLXecTCw4xg4QPs8p9BGfHwkL0TfUiNl/HO2S35ipym7XtE9IvUJEPRk3XWZkM4Gw9E/nfK0QDMpe8wD/uX6FcrTOiNmPIqdmSjE5RxImTjCU3BMU5w8M4Pby1PiNbibDDfGu6ooLmflO4Wf7v419HcQ+5Lm/QRz+THZpHtzp5cpztVODVfroyulxqsHeNRtprSVLgPh2n7UEEkNaxC0eHC2nDky+OiWV42/AGUn2V/HBsMbl9Q0IoJoIHq3YDVPvv1nK0QjXsX87qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQlqwBfc65FH+2HxRqwcBbEnVVowm37MJ277WssqSVQ=;
 b=Cqb3KgoZkwoo3WbuVHhNxhgLhjcTfiU0FZuiCDVxQcLXo55QvLoJMmOpqaYTOfEomyKobaIKBPBEgzVsHJHAp7BWTnQQVzeV6ZYuLUjCs8NXAj7YN9jexY+Rm43LbBSIbt9S41YqPaI2/IkWkgrhkDOG5ytFlsrVgEK9orUoyC4=
Received: from BY5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:1e0::38)
 by CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 08:15:50 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::9d) by BY5PR03CA0028.outlook.office365.com
 (2603:10b6:a03:1e0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 08:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 08:15:48 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 15 Jul
 2026 03:15:38 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 15 Jul
 2026 03:15:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 15 Jul 2026 03:15:38 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66F8FXMw2011891;
	Wed, 15 Jul 2026 03:15:34 -0500
Message-ID: <178d9f0c-2ac4-40bb-9214-30948389d306@ti.com>
Date: Wed, 15 Jul 2026 13:45:33 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: cadence: skip the link polling when endpoint not
 connected
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <linux-pci@vger.kernel.org>, <vigneshr@ti.com>, <s-vadapalli@ti.com>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <mpillai@cadence.com>,
        <unicorn_wang@outlook.com>, <me@ziyao.cc>, <18255117159@163.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <danishanwar@ti.com>
References: <20260623095148.721206-1-a-garg7@ti.com>
 <bwaho225txqny2p24nyhezmnc4r3yv3yckurvz2gtzxpbeqs5l@tx4mwgblp65n>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <bwaho225txqny2p24nyhezmnc4r3yv3yckurvz2gtzxpbeqs5l@tx4mwgblp65n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CH0PR10MB5113:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ade7e5d-ee61-42bf-9650-08dee2494701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|32650700020|36860700016|23010399003|18002099003|22082099003|4143699003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	WtBLqeJSobImNgkJwiqTHF5+pvMnamPKApVHBXW4GQYkG4Vd9tNmx1zCgSbBFs3u7zg9sMSPPnItpUmNgmZfgOOnYxbJQ0sVCSaaKb9gOlgRD4wqoyyAzmBbYQ3lYQGSXjq1Lo92G5HrDaBT1PaFlWrn5iV7rcXv4XDXwKEMQU3qos9aMsXlHmrz/HO/pL4/Or+knAMOKmoqrOWOHmmwCIkZ67E8gDR4FgL/ND9COkTG7LdLP0JBxlmLJa0ccVoaRm6r//kfOsObebooteVFnimSHpJaDYr/uF560CZXpy2hvq/YY96wE0aEcjG7/dOpDah9g0WV+Uw4LndtKrtIPWd3L1hjrDRdAj5kqWpVcltDiwjTGjKxcYOcjzqmyhBbKpMY/DbhAH4I39B1mbY5EkLtE8vnSD9gSol7T1fEYljWw8SU9ATdV/4B8Zw4hMCVTC/Q644L93PVIoCeFwRGChkY6Z1N9p2hOZBQZ4PsR3ijYSIyZNE8fDsVKJFnau0IjEaYTwea3wAyosiGe9s1ueTpv8fOS6qeNUzJzidgCGkn9A3RM65uhKLgxrEsKrdsPdFJelbVm5AdVgWlDOihxTHB1pv3r5plXJZ1qiBzOpIFT1BR3MYh1BiEqtlqZo3U+691d8WJzdgJYWgY11PQWSIqJvdZKs93PuxXEkEFr3Z3MxhjF+icVJr2odKnXGfJtcnuwHaAThPYkZME+ry/jg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(32650700020)(36860700016)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e2mUh5sSeJaugSLJe3xvHZu14tbIQQFJZEEVbulWYMS6QJ4ZU4u8J4bJHnSs6SO5ZHisXUYllKdGfXVg+pDXYrB+ZWiFrkVG7unr2Ek5UAQCnMKq71fadWHi/9ajP+k/gV9naO68lUZKl1Gt766424NEp5dAa4zXvRp4Uxw7Y4MM+M6HMMYemqyrVcy//ZoquEOwzXqhCsCpeIQkoAW4w3wnvHVePgj89ZyH1xaLgHQx3rkng+OSfT9kpHfhxvgsdAYe90MyEJNCxQHCq+Wjf6O+De91hl5MoJ0iWZlFqnknFlF0n3s5VZROYaXWpIl199mMXBvxEw7l/kuboUOquhri0R3ajwUYbLh1TcP8nXfOKw3QDh+Gr3DWv6ajuqEfaRkk2ZmJrlbJ8+5Zyo6Yuuw7dSZBIcJKaEv7LWYaxhavlVJAciQuplzYazfYlSbV
X-Exchange-RoutingPolicyChecked:
	GvjWb6LrvHO4yF1wVDjx8b+rWrYGLAh+dTh6gxCBIqJwEsVKIJ9ePyPdh96/wo9BkGF3fUILWl/Xwyq8tJKO5qvttE5u1ZGKJIbDEfsO6/EC4oh7c8Pt7fzueYBhzuQk/YmqxLXMRbonoSEmroSV/4jOFZFrNCEcPBTGpgcWw1ouw0S7kuCWmMdTI6ebNfsE3HtR382SOhUD0N5oC6dY2s2t8aa852yYcLaxs7/cA/uFts6GsAlwHs+QSu5M1Z7OgMzoMXUjMFyktqdWllVYOj2LYMr1nHTJI9os/gWQgQV6cDbMgzoBOhm0vHSCKxpfPYGqq1YD41rtDChzOkV9nQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 08:15:48.3599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ade7e5d-ee61-42bf-9650-08dee2494701
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5113
X-Proofpoint-ORIG-GUID: OChCm1Nn8qr2Eprwx4OH8pTjZF98kzZh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA3OSBTYWx0ZWRfX5DuuBeTPagKf
 tJwPnPT3ig3Z06cRJ45saO/TvrMu1BeqM39rC0rsiLczQG+ecTkw8c/xnc5hRZCw3CI6VUgzbQM
 /MQ3yhOYFk/ha83iLFqxVvE004nhJxg=
X-Authority-Analysis: v=2.4 cv=KfLidwYD c=1 sm=1 tr=0 ts=6a5741ba cx=c_pps
 a=ImwGUT2bfrWU7DBu6bNfJw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=UqCG9HQmAAAA:8
 a=m7-Bn73eetEpg8y05zkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA3OSBTYWx0ZWRfXxTI3VcE1QpZn
 GSmvE6WpAGdJIdWFA8XZMUI3iBz1sbDmYRb3Ah0aJip/XGjcpClqPCKu5vRGMoUjIZfJN9AN5IT
 e+NN1wi9NLS19QN6QSV8xy8SDnbIzI9+QJt7pgx+jzh5QI1TIfSgxJCtqL6TsUp8prLB3mh4Q4n
 2ZhpHDAOnZI2p+fP4NBl2PDEAglCN3tXYVrNC9vv37Yafhuqtn5OvafOdGTVBM1brvz+HNOtnAi
 V22HEvWmDXDs3lxpszsr/wgmLjdQkZ0tPb8dWmRMzXlMqw4vwZ4mYw1qmA7EFrPSp5EX5GeHmBi
 lVSnnrdEqXJgpsS9CDKqTc6QdFSffwS5zzCdKiE8dlH+mbR+1sTlGf3sKwMek5B+Wh49818EgfJ
 T+9mfMEGxLibedj9FlihwKax00PsQdT86C3EoJimmwJoeDUYXcr0imFXrheU0/KiNv8YLWCuY8c
 4DQF0rfF1aSa0yAaJVQ==
X-Proofpoint-GUID: OChCm1Nn8qr2Eprwx4OH8pTjZF98kzZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150079



On 15/07/26 11:31, Manivannan Sadhasivam wrote:
> On Tue, Jun 23, 2026 at 03:21:48PM +0530, Aksh Garg wrote:
>> cdns_pcie_host_wait_for_link() polls on link-up for 10 retries with a
>> delay of 90-100ms each (~1 second). A call to cdns_pcie_host_link_setup()
>> during the resume operation blocks the resume operation unnecessarily for
>> ~1s even when no endpoint device is connected.
>>
>> Add link_down_no_hotplug flag to track link state across suspend/resume
>> cycles (for the platforms that do not support hotplug). If link was
>> down before suspend in such platforms, skip the expensive polling in
>> resume since no endpoint was present.
>>
>> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
>> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
>> ---
>>
>> Changes from v1 to v2:
>> - Updated the flag name from 'skip_link_polling' to 'link_down_no_hotplug'
>>
>> v1: https://lore.kernel.org/all/20260605071922.1724499-1-a-garg7@ti.com/
>>
>>   drivers/pci/controller/cadence/pci-j721e.c             | 5 +++++
>>   drivers/pci/controller/cadence/pcie-cadence-host-hpa.c | 3 +++
>>   drivers/pci/controller/cadence/pcie-cadence-host.c     | 3 +++
>>   drivers/pci/controller/cadence/pcie-cadence.h          | 3 +++
>>   4 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
>> index bfdfe98d5aba..48db7a6cf754 100644
>> --- a/drivers/pci/controller/cadence/pci-j721e.c
>> +++ b/drivers/pci/controller/cadence/pci-j721e.c
>> @@ -686,6 +686,11 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
>>   	struct j721e_pcie *pcie = dev_get_drvdata(dev);
>>   
>>   	if (pcie->mode == PCI_MODE_RC) {
>> +		struct cdns_pcie_rc *rc = cdns_pcie_to_rc(pcie->cdns_pcie);
>> +
>> +		/* If link is down before suspend, skip polling in resume */
>> +		rc->link_down_no_hotplug = !j721e_pcie_link_up(pcie->cdns_pcie);
>> +
>>   		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>>   		clk_disable_unprepare(pcie->refclk);
>>   	}
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> index 0f540bed58e8..31cf50cff8f8 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
>> @@ -301,6 +301,9 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
>>   		return ret;
>>   	}
>>   
>> +	if (rc->link_down_no_hotplug)
>> +		return 0;
>> +
>>   	ret = cdns_pcie_host_wait_for_link(pcie, cdns_pcie_hpa_link_up);
>>   	if (ret)
>>   		dev_dbg(dev, "PCIe link never came up\n");
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> index 0bc9e6e90e0e..50abc657a871 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>> @@ -352,6 +352,9 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
>>   		return ret;
>>   	}
>>   
>> +	if (rc->link_down_no_hotplug)
>> +		return 0;
>> +
>>   	ret = cdns_pcie_host_start_link(rc, cdns_pcie_link_up);
>>   	if (ret)
>>   		dev_dbg(dev, "PCIe link never came up\n");
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>> index 574e9cf4d003..1561022c1a8b 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>> @@ -117,6 +117,8 @@ struct cdns_pcie {
>>    * @no_inbound_map: Whether inbound mapping is supported
>>    * @quirk_broken_aspm_l0s: Disable ASPM L0s support as quirk
>>    * @quirk_broken_aspm_l1: Disable ASPM L1 support as quirk
>> + * @link_down_no_hotplug: Skip link polling during resume on no-hotplug
>> + *			  platforms when link was down before suspend
>>    */
>>   struct cdns_pcie_rc {
>>   	struct cdns_pcie	pcie;
>> @@ -131,6 +133,7 @@ struct cdns_pcie_rc {
>>   	unsigned int            no_inbound_map:1;
>>   	unsigned int            quirk_broken_aspm_l0s:1;
>>   	unsigned int            quirk_broken_aspm_l1:1;
>> +	unsigned int		link_down_no_hotplug:1;
> 
> If the goal of this flag is to convey the information that the platform doesn't
> support hotplug, then it should be called 'no_hotplug'. Skipping the polling
> during LDn is the usecase.

Hi Mani,

The goal of the flag "link_down_no_hotplug" is to convey both: the
platform doesn't support hotplug, as well as the link is down (as both
of these conditions must be true to skip the polling). Hence, I chose to
name the flag this way.

If we choose to name the flag "no_hotplug", then we would need to add
another flag "link_down", and then skip the polling
"if (rc->link_down && rc->no_hotplug)".

Regards,
Aksh Garg

> 
> - Mani
> 

