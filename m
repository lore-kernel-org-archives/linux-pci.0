Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4530C343;
	Wed, 17 Jun 2026 04:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781671706; cv=fail; b=ONlKuw66vXEbFNN2zO/gzUIMUBrKGvAwuB49GZhREj22xmBRZfYZWxa2pzA/qwKoGM/JkyI7i51zfri4fQGv8HtJlbXZArsdwDMRo9UBcESlMjfctNrAycNTi63JZSaxVzQHS0/BIANhYNnnpiUR27oG/pxJ6SRsn3+wANe5ALw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781671706; c=relaxed/simple;
	bh=Ab6++Cor80KZ02TRw895q6wTL9/GJVGCCZYskZWAAOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u1mTMSSNdcVdNgoGj6Y75p2/TA2blz9FCQvd/6xUvtJoPwFSeo+ywXiYyf7C+Gwdnv4J5ZmqPm1/ja6ysZHpqo+sZ6G3MqjJAoMm3tYzjpcL2A79SeU+Q3oChF4Dx/kMZnexsJPvBugWr8Qnqxsuc/ryJvWob7YkImWUpfxRPlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=ljhF4PF3; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GCXhFQIQ; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="ljhF4PF3";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GCXhFQIQ"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65GLVEq23164744;
	Tue, 16 Jun 2026 23:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=DNA51HucHCozThPLPcmYwHq01P/1wtYSKuZorFRV/
	3E=; b=ljhF4PF3zeB6vDH8qbBr/mBP49XAoY5xa1r447eIWgS0D5veHgZRee8RA
	T8AnynhAr+xq8q3C7H2Dg4GeXOMFcZLKKTlfXYaznUgUrY3wdG8GrAu55h0qmH3/
	Vx5QA8gdyZEF3GDvMBrNaMaeXHg/YbadjhrmhwepxgDKliQreGHkBVp1uq91Du63
	V3iQ6V4KjHB8UKfSZB0w5PTslqKzemBlxGK+phgEAysR8MU3ZDMAdCtydA1rb14r
	BVNw5CZD3ZANaaOlIRUhI8J197ERhDl9Ce4zzshdXOK0CvMiWm8KVz0ybA0xukN6
	qcIatZT2myjrTR8wGhtDeEL7IotLQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010070.outbound.protection.outlook.com [52.101.61.70])
	by m0384305.ppops.net (PPS) with ESMTPS id 4eueffa8u6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 23:48:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=foaXfn3+5OVgF6L5TJ280byg88T5lyl5BFWN6kKCXAAIMNcgXEkGW4iY2UNiSbGaEGk6ovwI76+ruERY3ewPEO7XdEBFhQJvI6B1Lv3CltAzCfdolekxxjqxtSJ9CNQpdQBWqzO0wygPAvki+C7yS0nL6jgYL5Fw5WQGK4LLkuZpjFeW8/cCAauNhwy2sO0e3ImwvPtjtbgrv2DEjR35X0omc6XtprRlqsm1cF+cWXH30EfTS2KWGMDZLZCk6nrSX1Yk5QPHKDdWMG+An/26w4hVBZ23LV1A4561/eW9UACrDHZhg+1XqzuafVtWSzCS/GQRKNFT5Wv9lB5UnWKrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNA51HucHCozThPLPcmYwHq01P/1wtYSKuZorFRV/3E=;
 b=PqI2iyqQV4NlHkXEGkxJUBvVtjZ51M4i/JQ5zR1WGivlqMXTTtxCdkxX3K7TPz1X38mg5kxYouPOAoyCmsEX7i3UxQsUHIEPzai15fvoqrl7Qenifw/dH918wDrt7VFEwKB4Mztr3zUOQ6prLdznKEPiZ05P5+e0AqTQMdRUf0Bn6ZuOJHx6QXYqKoAd3Sq2GxfxFB0FFs8qDodemuMtxTvUTS7zS8tPM5UH2iwTAwXi5f1eg7cZQV0oTNrTAiXipe60nNy+a7Wb1BFW8K/+hS85yX9Y3JNnXWGrLe4M2OuZ8K27M+dYnF+p2uL5rda3FIn6OodEROhd907VVTzO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNA51HucHCozThPLPcmYwHq01P/1wtYSKuZorFRV/3E=;
 b=GCXhFQIQda/PxKw5a3PdAAFoImYE8PvCS6ieV5HDBj5Hj44IA7QDYXvZ7EtwWl3SzdXISK9tYKDengZf3+VqPI+zTAUMBww7F4To6dSvfFahn4T7m6Drh1Wfj5w4ZPzecseRY+9vQMh+y5GvA9VAPRAYJP0kbsPlatLJc4sM400=
Received: from CY5PR14CA0028.namprd14.prod.outlook.com (2603:10b6:930:2::29)
 by SA1PR10MB5866.namprd10.prod.outlook.com (2603:10b6:806:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 04:48:04 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:2:cafe::1) by CY5PR14CA0028.outlook.office365.com
 (2603:10b6:930:2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 04:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 04:48:04 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 23:48:04 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 23:48:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 16 Jun 2026 23:48:03 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65H4lw0L1535168;
	Tue, 16 Jun 2026 23:47:59 -0500
Message-ID: <fa3c59fa-cfa0-49ed-b656-2e9aaf45e440@ti.com>
Date: Wed, 17 Jun 2026 10:17:58 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] PCI: endpoint: Add support for DOE initialization
 and setup in EPC core
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <kwilczynski@kernel.org>,
        <bhelgaas@google.com>, <corbet@lwn.net>, <kishon@kernel.org>,
        <skhan@linuxfoundation.org>, <lukas@wunner.de>, <cassel@kernel.org>,
        <alistair@alistair23.me>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
References: <20260611191252.GA499821@bhelgaas>
 <0216a528-3737-4714-b9d1-5d28008e0ec8@ti.com>
 <grfjlghqd3k3i3uxll2jksrh7pgi2mtxifbq2vymsdgbzijsnq@dvgu2qp2hza3>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <grfjlghqd3k3i3uxll2jksrh7pgi2mtxifbq2vymsdgbzijsnq@dvgu2qp2hza3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SA1PR10MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: f2eac8d5-42ef-454b-6ccc-08decc2b9e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|7416014|82310400026|23010399003|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Tim3ppKXli+dt4pYmERZl6Onzb3OaWSznvtDcehbWgNZayuRDPq2Ewg+yC+nKcb8/c8d7fGd13J5kH3UYZ0v98G/z/dcE2eFQ0u+gmza0kTLumqbwCERzB4VpGUJOG348m9msQMm5gXq9W9NBtP0VmP1EimxHpYO3BuOfdN/JLmG4fyzEqRcngycOmG7yttoNnPCoSOiZNPP/zRPy8j/mREp0rrv3pVNG3XZsm1BLOuSBRF6PjiMoCFJyGdPa6dt76m4bk/nrqU0VGb840+R0h4scQoGeWVYCX1klmmcHmNKtUdCCSvX8NLcOi3VXtZF+SsrCrmA5Q7VtkwtLglEQqi/SyjMvI1mI4M0MTZnebUCSNPmzoNPHrYq2BjIAcgiFuA+Dc9sXL6RwpRfmx6HBjwc3AgAU4Wy+AzDauBR2vaCfBjKlCOeM0qb+Z3QY0vtjVYjI05jdpSFDoM4Mz+U0g9tet4xhF1d3WODlSTc7LtzHeHY00cV+Wlg312U1Luvx57DOhha9AUlpV6IB2DCVoReSzxji4HOcV1NbPli7k8td1a2rohbcZaZy+u/u/4fmIY44hGv9dX4RrSHg5wJeW1pmT087Ojm6xUdieDnzZ0sdx6JkgTvVnlKANXwd6QIUzojDh7Cj5OhYYxfJct53j2AMavMuTl5WS3hqoRondrNQkIRdTKro3NzBmbO7WYqc2GlChzevNWYj5A2mDjAfLnwg2/ozORNtB7K3ZCi968=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(7416014)(82310400026)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7kqspf8GDoc1tmpCvjABRfolhzujN0T4IbnX8rkrmA2PjmCueG9elQpV2rdQmVLGf7vL7NJbZN9uyI3cVqrfphpJNBhx0I2Qgn+wZJFIOE9kGJY/UDCaZhx2lE4JhUf5BpWcQ7q+vaLVBYCDjMpa2Zh221uJCm5jltIh61kxlDmh32prsRGUGNG7v4JYLHQkU4Dvx3HjmMjKl4g5hv8mJgvm8v8HHkQslFSbCSdNkLoSoX1oVDF4DOZIbR9+5wg9jpOQbOOdpqgLYDVCVFDxXt0+ptYAmumhWPK33/6378E1yk7JNsb4t5BCQtnyURaCICumbAoA5LVIh3RZPapHXYhXnsILP1VsIUoxY3HUnVk+RpZR+yOwdncgbWaGJxkRCDGOtIDn+jBkeXFYX1cwMzigIsg2AqS8MKgRieU5euBPj6/ftEPqqMl/0FmDLNp9
X-Exchange-RoutingPolicyChecked:
	qOjb4EM/nLP6cBY0WC+F4+ZkIkJp2QmLblA1tthnLELD9kDU+FwoKg3uaY1OO+2P6rWry8unLyQxLUFNvb+DjqbjOJBl1Hbrk2sJPYJdb3TdxA8KmeY3sA0riRhGY9mayytNDLu+2Q0m3ycFV8JEfWC9PQ4SEbHNUSHAx1W/F3nBGbhmQtKOM/ieJtWK0Vei13KOu8VoUsgzxSzKl518KMspSQRUGb5H0V2cj02k80w2gtaB2BLvuQFALd1QvFsZBZz6eW5eb0tS+iVrt/kov4+QjHF/mPuF1gL1rMaVtiJJIFn4agTFk0lwlBvZi2g35IG35GnUl04Xgc354Cj6Wg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 04:48:04.5451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2eac8d5-42ef-454b-6ccc-08decc2b9e65
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5866
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA0MSBTYWx0ZWRfX4sJ/SS7y2HSi
 7+mZiPolWfPb7MHepvaGdOGPnNMvSR6GwJ5liMED8okGGI0SmBBa71qQqURA0ERNlVryCbCe6eC
 mzwkIPZ4/PvQUMhIkgJgWsaWmghFtUc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA0MSBTYWx0ZWRfXzoBCdm+UXJan
 kMTauHAHz4w78Si16v4tFIFDHRH61gwufvFt0AlHCH01E1pGIDXX33FimCvK/0sGJjA8QNfW6Sb
 BuOZSxEVPh+F7yC3fXZhuRQ9M2b2RTZlGBRQDBURsPDbd6BGKp2UoJpKOxa13JZTvWY79Gp3+U5
 o3xhUrOZds0GaxxKldwDwVGaZpq1f0lce0m/RJd/++xvucJChZsEhPxxi4SwrDZtawcIVPbUu0i
 zJCPcMFi7cZj1fFHWa3MLWjfKhryMkQNEYEu/f+g5O2mpa6Fi5EpkHGctuTjITLj7gXPQD+j43g
 0ejK4wfS3JcC2J/IaDbuY7NfX/6CadyRurhlYYOo/1OMK2hmskR9xbhzCXbhSGVuRJe3iE+JFv1
 6wenIa7nPmvbIOgCXBBPMxraXPEnJ2hZ1b/uF/Bz2lGzMt/djFNYxol0HqQGbdmBmyleGPiVze+
 e62TS8n5QqWGONulwIg==
X-Proofpoint-ORIG-GUID: 6iLRwXEwE3OVb1QBvEqU9bh83zz-kkQp
X-Proofpoint-GUID: 6iLRwXEwE3OVb1QBvEqU9bh83zz-kkQp
X-Authority-Analysis: v=2.4 cv=KKdqylFo c=1 sm=1 tr=0 ts=6a322708 cx=c_pps
 a=xHwt0NLWInP9jDJIu2hPAg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=5fRpags1hDoxmymHdesA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170041



On 16/06/26 11:52, Manivannan Sadhasivam wrote:
> On Fri, Jun 12, 2026 at 01:54:13PM +0530, Aksh Garg wrote:
>>
>>
>> On 12/06/26 00:42, Bjorn Helgaas wrote:
>>> On Wed, Jun 10, 2026 at 03:32:55PM +0530, Aksh Garg wrote:
>>>> Add pci_epc_init_capabilities() in EPC core driver to initialize and
>>>> setup the capabilities supported by the EPC driver. This calls
>>>> pci_epc_doe_setup() to setup the DOE framework for an endpoint controller,
>>>> which discovers the DOE capabilities (extended capability ID 0x2E), and
>>>> registers each discovered DOE mailbox for all the functions in the
>>>> endpoint controller.
>>>>
>>>> Add pci_epc_deinit_capabilities() in EPC core driver for cleanup of the
>>>> resources used by the capabilities of the EPC driver. This calls
>>>> pci_ep_doe_destroy() to destroy all DOE mailboxes and free associated
>>>> resources.
>>>>
>>>> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
>>>> ---
>>>> +/**
>>>> + * pci_epc_doe_setup() - Discover and setup DOE mailboxes for all functions
>>>> + * @epc: the EPC device on which DOE mailboxes has to be setup
>>>> + *
>>>> + * Discover DOE (Data Object Exchange) capabilities for all physical functions
>>>> + * in the endpoint controller and register DOE mailboxes.
>>>> + *
>>>> + * Returns: 0 on success, -errno on failure
>>>> + */
>>>> +static int pci_epc_doe_setup(struct pci_epc *epc)
>>>> +{
>>>> +	u8 func_no, vfunc_no = 0;
>>>> +	u16 cap_offset;
>>>> +	int ret;
>>>> +
>>>> +	if (!epc->ops || !epc->ops->find_ext_capability)
>>>> +		return -EINVAL;
>>>
>>
>> Hi Bjorn,
>>
>> Thank you for your feedback comments. I will work on them and post v6
>> series incorporating the changes.
>>
>>> I don't see anything that sets pci_epc_ops.find_ext_capability in this
>>> series, so this looks currently unused and untestable, so likely not
>>> mergeable as-is.  What's the plan for users of this?
>>>
>>
>> Currently there is no EPC driver upstream which supports DOE yet. However, I
>> am working on a platform which supports DOE (support for
>> which would be added soon). Mani pointed out that if EPC driver support
>> for the same is guaranteed to be added soon, the APIs can be merged
>> first.
>>
>> For the demonstration purpose, he asked to show how an EPC driver is
>> expected to use the API as a snippet in the cover letter itself.
>>
> 
> I retract my previous comment here. Let's not introduce dead code in the kernel.
> We can review the series now, but cannot merge it until the EPC driver gets
> submitted.

Hi Mani,

Sure, I would prefer the series to be reviewed and gather Reviewed-by
tags by the time the EPC driver gets submitted, which would help
expedite the merge of this series later.

> 
> - Mani
> 

