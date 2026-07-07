Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4C3876DE;
	Tue,  7 Jul 2026 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404769; cv=fail; b=nnsegVxMI5OvAJPQLSsTweJx1g5WQXjodQqULOiNQ2w2l5/qn9bH9FaAx8sgwBISIIVSd6O7h5P5TUUEbMAiUvpu9dKcs36VBU7vwnoJS5IyXem1srz/Rw0VBdvXPaY2AdG4dEKcp8kiNgvqhYMYZHP+LPyRUP2X+mizR8jTNrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404769; c=relaxed/simple;
	bh=q/Tkjz+Sz6bvyvdIY4acm3Bma1SCHAYTCg16tkEh+6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z/zAtrkklmT6zdL+RYsd5Img54L+qWBDCyyqXyTekXt+bTb6g2fzzN9S7CnFTCVmeStr1dDFoj070ivvBS4aFGT7bPC2GcO2tNdE8HTL6RZAjlHRvmmNVJk5f+27EwZXSliR/vXQ2v+76rE3zk299K5F3XNpMleqbH3dCO+GrdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Xkx8DWfj; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=peW3UA4r; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Xkx8DWfj";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="peW3UA4r"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66749Ys42579168;
	Tue, 7 Jul 2026 01:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=FcUjaIP/c6aO7RPeLsvLG+DQcMDuaGSU6EfvLo/YM
	WE=; b=Xkx8DWfjjUJU7jLHilhjenejcJ/Qb2hysHK6uWq3IpmlsHxNKeYYcyjNz
	xFE4NJpCvG0gJycgbz9O0sBaWnxPnHHHLPMeCjWu1elKM1beKNYLademOwEKgXnC
	3ViuvAPCbVISu7/WdAeEqOWJTg0nsBgdXTCv4NHRplgC8ypb2ADOEtnbpZJ2o8V0
	/Qmv38yzNjhALCUOGecJKFNtLUUs4qmotZ99CZ4gq2y5sc54sO2ImRzHjp71zDC/
	N4m8mlGCxI8sL/w0NB7ujXr2GCuUx2a388R+E5xCU50hdAennjkbpqK8JaGz0twX
	JjicBM/5aweY9fU/B9xmYkjIatXOg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f8bafwwjj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 01:12:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwN3Tl0V3IQos/NPGrfL5Bi4gM8IAhuNYze1XVeOzrly8b+5Gqbv14zCugfWt+WG5++Y73ePsTwEwgAcDVmYvQCcsMdOtje/pdwQO10UpThce+lM038qydosEek0iBxnWAbetm2gueBX8qWG8iU+SdkhKDqpLm2g+q+HBmJaSr66GyJwTLcWqLTMp5K12MP68EKZaKIRvMWbjQnxrHea7Rtb9IlbfTSaBK3U+KmEJ+9lhyZBm0B8DHQL1KPgdGkIPojU8YO2rZV9SxnhmQpJFZXO8bWFnnbP0h6YU2TbVDz3LSfCbClJJ9AMLH/3KmDorXWe5s1450QAQatAzNHI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcUjaIP/c6aO7RPeLsvLG+DQcMDuaGSU6EfvLo/YMWE=;
 b=OoirHPdjKgSufNQodHm3LaYHKRUvQRZgYPsG7rilpfH12OvaAuyrA48jihAwNc73mQWSElB4nqjb1IpJY+g9+yJ+eaJ0QWnCvPrXqo1U2MLOyRRhgzJ9nl0UvLcLGiulfxZ4sDWGE5MoQC/6iujL1hmbwTx0jyhxJcq6rs1PcDRK6amVccMU2krLUNFxq8RvD3OMttOAfeYHwqXtJHndYhAL0qygalUmUXAqDQPBdEHPy/xSB3F2QjD/szJ1sqrMeZw4IJeALxGkz8Jsm0WPSWJeZaics0WuiIOodnGKVJcYaaUMvTtlhzvhUzg+/iNRQ0bqm3Pzhf41cT6lgev0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcUjaIP/c6aO7RPeLsvLG+DQcMDuaGSU6EfvLo/YMWE=;
 b=peW3UA4rlKghIKov6FbrwsF7mkpVrVBjfReFAl78bJg6Y5hS2eaumxCnlbzMTKC4oWWdN/mIvvQCZ1YlWWHcI1EiQNB7WtyEZNjKk4efMhD1iVJf0V69u0SZ5Qc2LR+Y0hIIKXq/eTzDVM0buPlsS+VIYqC8dYILLACMR20M30o=
Received: from CYZPR11CA0001.namprd11.prod.outlook.com (2603:10b6:930:8d::28)
 by SJ0PR10MB4416.namprd10.prod.outlook.com (2603:10b6:a03:2ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 06:12:35 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:8d:cafe::16) by CYZPR11CA0001.outlook.office365.com
 (2603:10b6:930:8d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 06:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 06:12:35 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 01:12:30 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 01:12:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 7 Jul 2026 01:12:30 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6676CRbR3148616;
	Tue, 7 Jul 2026 01:12:27 -0500
Message-ID: <31f98081-6509-4037-8dd3-930a66bdf38b@ti.com>
Date: Tue, 7 Jul 2026 11:42:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: add missing MODULE_DEVICE_TABLE()
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260704122835.14277-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260704122835.14277-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SJ0PR10MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ba2699-3920-4925-2764-08dedbeebd54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rD1Frm4qeiOKBi6LHaZQufN3/3l0vtS58MNesg1O729oJpWPoiz8lexAoOfUj35G+UlmsOY5ksq1kzRv67Jo1/BIgdZNBxiY+c4ADcuPGdOPKDQZONuQ+PrfgBgOpChr1+dxXcFQPOSEPL5ws1ZqCJ/wHNvUu2NIR6vc8iJP8mSIG5bzu62BPRdrWfNK21NB+fsQDRFlz2yuJa3T1UQ97rtPNmKbqRGWLzawhRKJPCvjTSlI/8iYnuskeu2ayD3IeJKfORh0uAAiOjlcTO6qA/j54P5JMAbkzUkcWgiiQCL5seW1jgdpgj4/K8hWlMG9tqzfF1wKrmZdZ02QqnC3jdgGDcgKIr/NT3CDxOex5xbhcQwUmcNyBMy7YPwUjQ1Qvi8oAFeVImBB2Djo8Ah3JZdoHuoJB91z4WTkvnSTMMsVwLL57NuwKbv5yJYArb6IuL61s7bZnlBNohdeOdYRtsmp/ukjDaJybQTagME7ZIifTPDdFNDIhfl0AWJWijgddNPufEODNKFzrxkOoJdm6KqNCqZN6X7jCQz+z8ns4WdwMZxsKbIzbtMqw0Ciygm5Yg0UYis+VgQAOP6aAs+8UINWYLsEu6PeOE7N0rWXyWuIfgttgdqHdEklrHyiEzgWzhhlZ05QCX4Pz+nc5FucLL64JXQvL1N0kHJ+1CdAlQCaDu/W8sP95/dRHtUg8sbk5myj5IZeH2i0JWJ24T/iXQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GhclUOk8FZq8x6I+atw6CXUqacs1HpbPdYN7DPpqLz8IlnQD6tJ+WjAPMnZsKL3A7/YdCz4J4iMLlOO3RwqwJYLJiugMxmybEzf9x2FU8gC7okn5HfmuIlBQYSxnJl0++6m11t6TJlpT1iX3fMvaRSZys/gWN2GevgYgwys50FoKqUTgeNalmojuJW3qgSOG4+ERCRR5AfQ8DvocIYH6+pojy2VWZz5s9zp1giPSUO+0+CgjUIlWzjEnlOXxycYk+wDiiXp9XoWZEtMfwG7+6y+Z/V6H6osLSnj5gynu2hGydy+ZPDGoodXVhQQEldJU/C4qP0Pn0S0VRSOyeAD2ECrzhtyBSDA0p/zThIMon9z1NHarIWvbCO4wvnrSUfofTkpw6ZwgkrWZW8thOPfwshmlr+1oUXrMbRQt3uHM9hPGVd+JpF+R0Gzhp9AbYZlw
X-Exchange-RoutingPolicyChecked:
	fzbPaXsXOERMsD3A3ybKqyrr/Q38MIawB3FFDm8obWJsS2ZDWajXqslazuDOoBneTKSdAuGkZIAK3XaUbsCuMP1hpYYk4c1jB4BzJ1uECuOUv/GTa5lZZZ3xumjNvx8NxJurty7gfZrRA9qP6M4YiQaYfctsD7kI5KvMFcYbXKwALdCTrk0t2euwXGQP0VKE/v4xhdRlLEYXWDBZTJkZrXu0tMlSRlJVEOsdZcR1ogGRmMITpZfn2QTOKGrN/67Xs6NLb33ZK1VPgt/c6XVahTDl/S0Txm+US/5B719EAS7b0p6JdY4MHwXQbhEskjA9mbssQCcI9sXjJDr1Db79FA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:12:35.7416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ba2699-3920-4925-2764-08dedbeebd54
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4416
X-Authority-Analysis: v=2.4 cv=Edf4hvmC c=1 sm=1 tr=0 ts=6a4c98d7 cx=c_pps
 a=Lazl6XkH4A3N9SONPos2PQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8
 a=j17FDbUlo9NHgeXuVDYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LL8TSUdpGDVFfXreEi_wEG7Q211wklDD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX6AyKOs2v34kK
 Ok/8hYEuD/RnMCaFzhV6TMRtZHBofpt155+RiwTDv3jVuPpFFgJPgk/fY4g91mICar3QrIxa/b8
 a71/tNOl4vjWifw76xXaoDTmXlyZT7BtDcEvhLDVYGY0rB8FDrD2+9cvuY8paWU+tKz+UXsAVsl
 N0aLAIz0Wpm00JpHvG2wlnedMe+tpjG1b7NgU7mAMv4s0I0NZ+NN3rWHGwkhC5OO95tp7lV4uQ4
 yXysTn+ddO3khmSY1zNB/TEmNLMC2NWDoyhDT32l3ie9KVjz3weZnqP2JduDsJn9x67PwTF2hi4
 /vwt1xEb9eveVk6Ejxcv9v4JdW/P63H6XcHeG77PzpXNZSMe9C6Z1VjJrFkuVVywis3fasESPHj
 YsD+ZrEXsDZ7PG/JDU8JoknNo4jYRNOoBckhFOGzBlPzz6m8Tq0atfv8pi3JW6GJ4hXfQdoan1C
 KdZI/mVziI8uD1yWq/Q==
X-Proofpoint-ORIG-GUID: LL8TSUdpGDVFfXreEi_wEG7Q211wklDD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX0mUVBuFKsn1w
 E/Ujrp2XYnTiwYIrPzH+4rQ9wxnb5NW+fVQcRg4HlEXx9K9lb/vqcOzcU51TccNBm6vNT+r1wlR
 H5NMuaexYBzX2jzw/ocMr3PQOoN5FVE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070056



On 04/07/26 17:58, Pengpeng Hou wrote:
> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Aksh Garg <a-garg7@ti.com>

Regards,
Aksh Garg

> ---
>   drivers/pci/controller/cadence/pcie-cadence-plat.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index b067a3296dd3..a1ea24fc3b63 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -163,6 +163,7 @@ static const struct of_device_id cdns_plat_pcie_of_match[] = {
>   	},
>   	{},
>   };
> +MODULE_DEVICE_TABLE(of, cdns_plat_pcie_of_match);
>   
>   static struct platform_driver cdns_plat_pcie_driver = {
>   	.driver = {
> 

