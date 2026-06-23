Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B539E308F03;
	Tue, 23 Jun 2026 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205702; cv=fail; b=ZhqzWNph+pwe4F5YYTv+/rOxu79ma1utPDs2h1gvYY378Wc0QM8psbu4LAnWgsMs+Q5sx//SrXtZ2rUchkIFcd8j6nMjWRlguHYCp9pj/bg41K2WZMmFHOmmQODAdGGqpqJPVlMWhGb+veS3midiirrsf0bQTuyZTiwTx78rDjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205702; c=relaxed/simple;
	bh=W9tav2pzhnwLxi40rgd4Zhx/cN63D3tPSmPl0k0fwG4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UuZPoXJ7glXeboMgpjwOq6puXxZOeZUT4Fp9901L+LCJAYa76wU1SKJD3f3gBruzRx9qNq4dvpe9ZaiHT5HJQz5ms4ZRMLb3bQHYzP3KzyEWtosHTk0n53JqHhujHKNyIiBKME47lBaedUPqt3XKWZwF0HdCJfAIRt0/akFw2u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=eweD6ucw; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SDRUvEmQ; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="eweD6ucw";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SDRUvEmQ"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N6cWWi786403;
	Tue, 23 Jun 2026 04:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=c+lkHQZP+zcnh
	uHmS38hXrSiKRK7hB7KPvT7ZeFLltg=; b=eweD6ucwMW1CWzcvowWxYpxul9e2I
	xxrbFU4IvU2m/0zHAo8zqpw4WK6Kv6RDd5XxJ+Z0byvuCM3/gaUU0w9V24BaAuV4
	a1lGSPp86Wt+9RzpTw8BpPpyNNGleta15yRoCLAwBn3+73y9PTWsFQsGwMpRcENj
	bldZrga7/wzVMVbnRqyMyyFEmw4jy4hsFPFZXcv643WHKxcha2Lu3vJTxyV8tmCQ
	RnWfGU2+RLetAc/Nm91DAkMIJg2ND2cPrYQO0QWRUrZcoeKxlj3DwDuGhfyqZa5Z
	eKGCPvvYpEXY4OHrWTj8/nJqFB/eDsgi4kKLj0e5jyrG2P/gNWnCZV34Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
	by m0380145.ppops.net (PPS) with ESMTPS id 4eyma1ryet-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 04:07:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaPPzkV8e82BEdTEcoKPiM8mS/a9KT3nh8Nqw4kOD0YAIE80NSngUFHo9cakujzccYO7tgD+KZwHFFp6zGaWUICN0j16w38VLLCO/4WYAekWnERSsOnydnGNa8NQqCAijbjZo2jTrFfoKsXr53dkHWK40cpkiVmzUtMd0i0vjiuhk/7oWAj2565dzyDmWRHhTPJc3l3DKlXHfhrnVtlGnD0hTvueJp7CSjUwYhMc55Nyht0yPESwR9skrHrRzleeRqpwXkPnF6sttWYIQoIzRoj5eo2gXegJm8o7Ivo1epF5f0hyycE9m9shZFo6ZsV/WBwLfQEZfuwo9WreaTJPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+lkHQZP+zcnhuHmS38hXrSiKRK7hB7KPvT7ZeFLltg=;
 b=fDa7WII7RYuuCdkzRcJntOEEW4I68c3gQF+coD+dip4Vd1x3cth2rXypZiq4r5qvNIWA1TyVRR0cXLBWkI5NOjW5MHGgGJSKqEcRRJ3tHaoEywdfdq1fHjYU55lsdhfJf1Vphkr9Mgm1P1bbinOmMlKU/OPpXqgnRBABNRJMbkbqNaZ4V3++ZUMdpp/XUBXrkqxZcVM6TLOYNEPL2B4ouYJx0JKJBEeKNdpMBs+DCObhRZfZm9KNL5Wu5ni6JYFSak7C/rWs4GR4AjFH6eQedUwchdwhW0VrZK85DTNLds1PXyqtjUL5SH+9QrIw6GT9fG03AsglZzw1/lo4xmz9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+lkHQZP+zcnhuHmS38hXrSiKRK7hB7KPvT7ZeFLltg=;
 b=SDRUvEmQKCG2C/zScQsJMwCJbcsE2alhUxL7LVwTucFhyX4GvUAtIKimwLjr291rEoNr4UGLzl2waSCDShyEezFpUVr44/2FS1ATFDuW1qW+SeeqA9r9cs7CIOqGsNZz663UoWd4nOLWOC9lcsdteRNnC6fg7nFzXeOaIT0bUpU=
Received: from SJ0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:33a::29)
 by IA3PR10MB8115.namprd10.prod.outlook.com (2603:10b6:208:506::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:07:44 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::5d) by SJ0PR03CA0024.outlook.office365.com
 (2603:10b6:a03:33a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Tue,
 23 Jun 2026 09:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 09:07:44 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 04:07:43 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 04:07:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 04:07:43 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N97bL22520663;
	Tue, 23 Jun 2026 04:07:38 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
        <corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
        <lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <rdunlap@infradead.org>, <Frank.Li@nxp.com>, <s-vadapalli@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v6 0/4] PCI: Add DOE support for endpoint
Date: Tue, 23 Jun 2026 14:37:33 +0530
Message-ID: <20260623090737.711656-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|IA3PR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: b141d2d1-6a6c-492f-59dc-08ded106e30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|23010399003|376014|6133799003|18002099003|56012099006|5023799004|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	ZqRb3Q6L3k2o4XiDqrs3NLaYyJqFlCvdV70RjgxLT1QfLo9YBKFhtZWYzdwgbDbOSZR4hrePL3IaTcfh3tJV0DjVUxtGBsh3pRdUgd8/PU0C73QKq42kf/o5GcjSo9slYarSS02PfxtM/hqJEx6zA0UsYOm5htFyF3KIMl0C6pqtM19LCaSrOqivgERD5VgnbrZtIQhY83KGevpEmshNnZrRBHoh8WXQQSS6q3CkTR+2iFA9DIRorw7jfJnlhAnrsuaO0CwXgxuu2iSoerNoU7MWL7b0df6cqhvrggM5epTb6zOzF02KLoZ3pbLdDnzZ0wF5GjaRMmTILdJfak+/x6894onfQ3cR8TuBy2Gitv/nDB/0w9R4AJpjFAG/mS4k0kjSe6TYfu2GH3Z6TzPRwGIuO5eXxSL6M/Nr6M3fm+H9iew4CrkXLAoiaLw8XYne2L8EHchLP2HZcHEUFamwCYBQHfg7+EgV4UX+62kMIK0m3/0Vk4nNCmGiaFx3vzPvDLHCnVnyA9fFXscL8s0EbTlVReREXeSxf5t1WfGZiKYmiWx2MTT7NjWcqYRjXg4swVR1FLW8lUXiCCt1xRuSmDQK5v17+npmkXpm+9rzX2QlSKJYIDp4gPu4pTVQxkfzqCSKH69NE3z+ALRE5noVj+EzIU3kPWzSe/gUIv5QLSl9Rq8PoIx+cVY6Js8WxvEyW8HskKYqGRAfExPEsFAttXrG30uD2ThmTtHQD4IKk3A0obsRwV/zONPab+SbUyxH
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(23010399003)(376014)(6133799003)(18002099003)(56012099006)(5023799004)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5WSpi75jiHFDOqgo6XxPiUVu8zwH19OT1+CEXYynfNY5iiKoy3rKz1QEZUuSq9pb4CHC4H5AxOuhvDkx9ee2SAa8ZwSosQe1u/muakGbnGcCJLN7BS4xUXf3FVBPpC7rw2adGE7LlyEcT0Ekp3DJPw2OUbBN1mxVAi7vDeSsBjCizQXRVCwzW9Tu8ZjnRki0flb6rO6+nDAfI6LOng3lpjAG2UuMYqBeHZ3oMWiU90z+4Y/JwF0iI9h3U3ZFWEbeOS62ZACMOSdB61iPT6L0xQJFhkjMXxYUV9GjOfKOWnrFAnB7FZunUsDyxBmaZl+1SaxmAn4O0b6q1uzaHIcl7r7TvUjW0BGrQbuZSN2Gdpth5kci/sii+UWINK3sh30q5N7w2Sa2o6l9Ls8A8uQbScXlScqqJdfpk8vM/at19gzuR0JgLsxyxhNXUKNk0esV
X-Exchange-RoutingPolicyChecked:
	Uq8V6Sd3obbYacJtyNUSyyKMPi1wAYIEMzoECxjh6YQn3YdtlRjvZXZVoWRFP6454m3nvSChSY+5Lav3UHA3OI1zq2cwcIfEn8NLA70DbnpZXuNOjw4oEJ5Oc+D3A+jT+7F8prKi3U/CApzyAvg6Uw2e3/bHqRApp/d1WkQQVqdra9aNMYzuO2p1HTlsqtKSsTNCa+VLpO9DWKTx7Y7+XjIyhZBicMK6MfjyhSOgzPM84UUfXz9KccEi+DJQ26TSaqHd8hvbOhvwnM3+krqPJFr7VBLtyBXEpS61ZcRk3Z2vKMnbOP3i0DeM4p1GSbgGKaILDqR6fMnqL5n6ChTohg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:07:44.1205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b141d2d1-6a6c-492f-59dc-08ded106e30e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8115
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfX9f4AhiLZTyNo
 cMGEE1CUQisz4NZK4fKcFZJJ69d+3H2L8UXwekPaSRlJ2CYfvBJn0ljrzCahOljVTpUcbYtCwO4
 72bNSb/POP+ZHuhWMBuAOb1PxEjyNL8=
X-Proofpoint-ORIG-GUID: yANQ8vbmVF9SH-FP3OIAZPbvrkFc80RQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA3MiBTYWx0ZWRfX4983Y8OadhwA
 FTTdlSEL9TCOb3+uyq5ev3Vi6iZ5Z8CMCLQxUT7eaCYhM1qd4yI44GVcxI13nSRVh40PALUWHov
 GvcARvr+WJ8EFna+pR2MIRvtM5NFdoatjXQ/37cGljyUutASAqFdchpqrh70rHqGqtA1+wmJs/I
 t0ls5hPAQzwmaRSKb+yzOzYoqA5ueSgFHAWhuUJ9zZGqkl2DFaQscnnPvMQr3s55FrtKYzLRdqO
 YMIOu/8vSqmgRHYjcNOrabujTe3/1Etd9yN3r/421HIrARPsinZP8zl/2/3bTCP6VYStL/gMKyN
 2wfs1kEgePBqcMVsj1JII3MPy3/A0hrZfPezd7Qid0wHO4/XBP6+vIWghb0oDuc8JanPk7ME3WL
 6YNCiBid3dB/8/xyZido7ZBS41ypxOCeLe737zLi/y0PtAMFhn1i2jrKuquzA+p7rqxpFDBF7de
 c5RlSuF6yhsaILqQNYg==
X-Proofpoint-GUID: yANQ8vbmVF9SH-FP3OIAZPbvrkFc80RQ
X-Authority-Analysis: v=2.4 cv=WoYb99fv c=1 sm=1 tr=0 ts=6a3a4ce6 cx=c_pps
 a=S6sZQAOjBorY7schPX32og==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=bkmVMmVzjQ8CvuStA-EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230072

This patch series introduces the framework for supporting the Data
Object Exchange (DOE) feature for PCIe endpoint devices. Please refer
to the documentation added in patch 4 for details on the feature and
implementation architecture.

The implementation provides a common framework for all PCIe endpoint
controllers, not specific to any particular SoC vendor.

Currently, there are no EPC drivers which support DOE. Hence, there are no
users of the APIs introduced in this series. To avoid dead code being
merged to the kernel, this series can't be merged as of now, hence I am
posting this series to be reviewed by the time the EPC driver gets
submitted as discussed at [1].
[1]: https://lore.kernel.org/all/fa3c59fa-cfa0-49ed-b656-2e9aaf45e440@ti.com/

The changes since v1 are documented in the respective patch descriptions.

v5: https://lore.kernel.org/all/20260610100256.1889111-1-a-garg7@ti.com/
v4: https://lore.kernel.org/all/20260522052434.802034-1-a-garg7@ti.com/
v3: https://lore.kernel.org/all/20260427051725.223704-1-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260401073022.215805-1-a-garg7@ti.com/
v1 (RFC): https://lore.kernel.org/all/20260213123603.420941-1-a-garg7@ti.com/

Below is a code demonstration showing the integration of DOE-EP APIs with
EPC drivers.

Note: The provided code is just to show how an EPC driver is expected to
      utilize the pci_ep_doe_process_request() and pci_ep_doe_abort() APIs,
      and might not cover all the corner cases. The below implementation
      also expects the EPC hardware to have some memory buffer to store the
      data from(for) write_mailbox(read_mailbox) DOE capability registers.

============================================================================

/* ========== DOE Completion Callback (invoked by DOE-EP core) ========== */

static void doe_completion_cb(struct pci_epc *epc, u8 func_no, u16 cap_offset,
			       int status, u16 vendor, u8 type,
			       void *response_pl, size_t response_pl_sz)
{
	struct epc_driver *drv = epc_get_drvdata(epc);
	u32 *response = (u32 *)response_pl;
	u32 header1, header2;
	int payload_dw, i;
	
	if (readl(drv->base + PF_DOE_CTRL_REG(func_no, cap_offset)) & DOE_CTRL_ABORT) {
		/* Aborted: do not send response */
		goto free;
	}

	if (status < 0) {
		/* Error: set ERROR bit in DOE Status register */
		writel(1 << DOE_STATUS_ERROR,
		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
		goto free;
	}

	/* Success: write DOE headers first, then response to the read memory */

	/* Header 1: Vendor ID (bits 15:0) | Type (bits 23:16) */
	header1 = (type << 16) | vendor;
	writel(header1, drv->base + PF_DOE_RD_MEMORY_WR_REG(func_no, cap_offset));

	/* Header 2: Length in DW (including 2 DW of headers + payload) */
	payload_dw = DIV_ROUND_UP(response_pl_sz, sizeof(u32));
	header2 = 2 + payload_dw;  /* 2 header DWs + payload */
	writel(header2, drv->base + PF_DOE_RD_MEMORY_WR_REG(func_no, cap_offset));
	
	/* Set READY bit to signal response ready */
	writel(1 << DOE_STATUS_READY,
	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));

	/* Write response payload DWORDs to Read memory */
	for (i = 0; i < payload_dw; i++)
		writel(response[i],
		       drv->base + PF_DOE_RD_MEMORY_WR_REG(func_no, cap_offset));

	/* Wait for the memory to empty before clearing the READY bit */
	while (!RD_MEMORY_EMPTY()) {/* wait */}

	writel(0 << DOE_STATUS_READY,
	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));

free:
	/* unset BUSY bit */
	writel(0 << DOE_STATUS_BUSY,
	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));

	kfree(response_pl);
}

/* ========== DOE Interrupt Handler (triggered on GO bit from root complex) ========== */

static irqreturn_t doe_interrupt_handler(int irq, void *priv)
{
	struct epc_driver *drv = priv;
	u16 cap_offset = extract_cap_offset_from_irq(irq);
	u8 func_no = extract_func_from_irq(irq);
	u32 header1, header2, length_dw, *request;
	u16 vendor;
	u8 type;
	int i, ret;

	/* Read first header DWORD: Vendor ID (bits 15:0) | Type (bits 23:16) */
	header1 = readl(drv->base + PF_DOE_WR_MEMORY_RD_REG(func_no, cap_offset));
	vendor = header1 & 0xFFFF;
	type = (header1 >> 16) & 0xFF;

	/* Read second header DWORD: Length in DW (includes 2 DW of headers) */
	header2 = readl(drv->base + PF_DOE_WR_MEMORY_RD_REG(func_no, cap_offset));
	length_dw = header2 & 0x3FFFF;  /* Bits 17:0 */

	if (!length_dw)
		length_dw = PCI_DOE_MAX_LENGTH;

	length_dw -= 2;  /* Subtract 2 DW of headers to get payload length */
	/* Allocate buffer for complete request (headers + payload) */
	request = kzalloc(length_dw * sizeof(u32), GFP_ATOMIC);
	if (!request) {
		writel(1 << DOE_STATUS_ERROR,
		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
		return IRQ_HANDLED;
	}

	/* Read remaining payload DWORDs from Write memory */
	for (i = 0; i < length_dw; i++) {
		while (WR_MEMORY_EMPTY()) { /* wait */ }
		request[i] = readl(drv->base + PF_DOE_WR_MEMORY_RD_REG(func_no, cap_offset));
	}
	
	mutex_lock(&lock);
	/* Check the ABORT bit, if set then return */
	if (readl(drv->base + PF_DOE_CTRL_REG(func_no, cap_offset)) & DOE_CTRL_ABORT) {
		kfree(request);
		mutex_unlock(&lock);
		return IRQ_HANDLED;
	}

	/* Set BUSY bit */
	writel(1 << DOE_STATUS_BUSY,
	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
	mutex_unlock(&lock);

	/* Hand off to DOE-EP core for asynchronous processing */
	ret = pci_ep_doe_process_request(drv->epc, func_no, cap_offset,
					 vendor, type, (void *)request,
					 length_dw * sizeof(u32),
					 doe_completion_cb);
	if (ret) {
		writel(1 << DOE_STATUS_ERROR,
		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
		kfree(request);
	}

	return IRQ_HANDLED;
}

/* ========== Abort Handler (triggered on ABORT bit from root complex) ========== */

static irqreturn_t doe_abort_handler(int irq, void *priv)
{
	struct epc_driver *drv = priv;
	u16 cap_offset = extract_cap_offset_from_irq(irq);
	u8 func_no = extract_func_from_irq(irq);
	
	mutex_lock(&lock);
	
	/* call abort API only if BUSY bit set (pci_ep_doe_process_request() called) */
	if (readl(drv->base + PF_DOE_STATUS_REG(func_no, cap_offset)) & DOE_STATUS_BUSY)
		pci_ep_doe_abort(drv->epc, func_no, cap_offset);
	
	mutex_unlock(&lock);

	/* Discard Write memory contents */
	writel(DOE_WR_MEMORY_CTRL_DISCARD,
	       drv->base + PF_DOE_WR_MEMORY_CTRL_REG(func_no, cap_offset));

	/* Clear status bits */
	writel((0 << DOE_STATUS_ERROR) | (0 << DOE_STATUS_READY),
	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));

	return IRQ_HANDLED;
}

====================================================================================

Aksh Garg (4):
  PCI/DOE: Move common definitions to the header file
  PCI: endpoint: Add DOE mailbox support for endpoint functions
  PCI: endpoint: Add support for DOE initialization and setup in EPC
    core
  Documentation: PCI: Add documentation for DOE endpoint support

 Documentation/PCI/endpoint/index.rst          |   1 +
 .../PCI/endpoint/pci-endpoint-doe.rst         | 352 +++++++++++
 drivers/pci/doe.c                             |  11 -
 drivers/pci/endpoint/Kconfig                  |  14 +
 drivers/pci/endpoint/Makefile                 |   1 +
 drivers/pci/endpoint/pci-ep-doe.c             | 591 ++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c           | 101 +++
 drivers/pci/pci.h                             |  51 ++
 include/linux/pci-doe.h                       |   8 +
 include/linux/pci-epc.h                       |   9 +
 10 files changed, 1128 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-doe.rst
 create mode 100644 drivers/pci/endpoint/pci-ep-doe.c

-- 
2.34.1

