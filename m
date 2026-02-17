Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A068134CF;
	Tue, 17 Feb 2026 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314783; cv=fail; b=Zy1gQ0w4lu6JT5NZgSM1Ly6vkkOOVtIS/lh6iTz+/MCrwYofk0zSSArXXmu4LWzDjUt2L2AcxK/sMiRdN8FjQ+s4z6jvRwQlqHvKYaNTaqO1dKaWT61hU3uyb85CVd3tWN20rNwJxSMBvYnkDP28ce/RnS5UGBH4ACQK1UWBOYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314783; c=relaxed/simple;
	bh=hD75OBMoCj28LH44xN0LxzF/S3SNE3AdR6it35wIqV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ePW8SNC66CcVAnnilbK/mPWmRG1lvvrZnJB7NpnU/k5yCt44mV6cFmY4ihXjuYrvXDpB6b117H+ieBNuwiY9/PYJUx1bXEq7BAHM9nwGhwaPRPT0TZnyXQfkAPPRaSbmHYuML/RTbbCh+/4KMgsXGoZglpzIZUtnbJu9T0hGF3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gfuIipSj; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gfuIipSj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHRnKhlZjyXKcNLged0MgkL+CD5dkbjEqjlevtYa6J6njxJXCfd18cuyIEyjrEARifz8BdikXO+16xSehw6qNJRNc4XV/bfIU7odsn6DbeAGgTr9b8mc8SEJql8Xa066B7K1xTS+szZCk/1o5Jl1RNGXOazjBQpzeRC4T7ogjegbc1j38tVXb4/xbDNrI4egD5ZAa9VrBPPS/z/OxEZr426jHf+MUYcFn7i1tz0/kT39huP2/9J8r/Q6VCodb5HZ4N5q+UimMX225KxImBXfvx9YBDwNTv/grtpe4uC/1Yd+PRGB/XlPsNbPDhC0xuKaCs137JAUPyA7kOjrkBKR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf5e0sXfcm47aqICnW0bta0Ho9peRVXc4paMK9PcAjw=;
 b=jbECosqLtGjP7IR/3dObjkJzQ8xmmLrqwisEJmVtHAc8WAEam3SzxaRyE4Ed37zhwHNNAqQpAB02OpT6eFisfN4Y0TGDYzhUXXaQ3f6Bv9pvX2JEjqX8RbZzx533qcORaoikvWukLVehfIJpiUqTUXwtDSMhEWiZsVxij5d0NYp4M3CAJVmFOMKDmVU3TykpPEhXJaCUm1REuE4qhufO4d0dBJLPMNdEM9oip7xvRlMwoKkO6+0vVrUl8vtiW34CqAfSQ4D05wGpGvSh4ADxDnUXFHzUhuDsyt6SLTY7ziA/VAGoJM/tEDfJBQ2ZZaz3h+6Ghtg1M/MHUxyeVoSo0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf5e0sXfcm47aqICnW0bta0Ho9peRVXc4paMK9PcAjw=;
 b=gfuIipSjj13EqdtYuKKLtPLfoxP+Ko8dgpXUP5rcNRrwdafSSv5eG6+isHPfz0cTnwIiK5gmTZllCwZnFAvUK8/VFjQlXk25o4iT+vraqoc7RkQhsTCf86by7d/cxyFzfFFezc1GUMZmtsVjSQ46dHj66fCdGJpSxq+YZkW128U=
Received: from MN2PR10CA0016.namprd10.prod.outlook.com (2603:10b6:208:120::29)
 by IA1PR10MB6268.namprd10.prod.outlook.com (2603:10b6:208:3a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 07:52:59 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:120:cafe::20) by MN2PR10CA0016.outlook.office365.com
 (2603:10b6:208:120::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 07:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 07:52:59 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 01:52:58 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 01:52:58 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 01:52:58 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61H7qsYK3010252;
	Tue, 17 Feb 2026 01:52:55 -0600
Message-ID: <d86a9cbf-900d-4561-836c-1c5a9fb2c4a3@ti.com>
Date: Tue, 17 Feb 2026 13:22:54 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Add PCI_RID_MASK macro
To: Marc Zyngier <maz@kernel.org>, <lukas@wunner.de>
CC: <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>
References: <20260216120600.479738-1-a-garg7@ti.com>
 <86bjhobz0f.wl-maz@kernel.org>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <86bjhobz0f.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|IA1PR10MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: f310643b-82e4-42a7-e773-08de6df991c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFlzajJYQ3M2RnUzVDNTNkpFTmJxU056b1BUNis2Y29MQ0R5b1NncTBnRHVO?=
 =?utf-8?B?U3krNis3WjJya0FhRVVpWXdqZ0VMWVlWNEFPemE1Y3FKOUxROWFoL3RIbmJn?=
 =?utf-8?B?RjJZR01QUlg4b0VuTG5TbFdqSGkySzFxdTZUTzFJdmhvV1pFaFBFaFBXWHZ3?=
 =?utf-8?B?VEdFVDFnYlkzYVhwOHgydVBORzduMlowV2JUeVlzMUh5UFo3b2ZtM2lyR1lq?=
 =?utf-8?B?VWtxbmxLSVlVRVVMWFYzZjdVZWkrTlpvQ1Z3UmZhL0U4a0x4elZqcnZEc1A3?=
 =?utf-8?B?amJReWVZRTk2bnBtaWFxWmdWSlYwRXZ2K1l0S1JkR2QzdytnbDVwOVYyU3hu?=
 =?utf-8?B?RnRoZnNqZ3RJNldkeGF0aVA5Ym9xNDR4c1dzUG9FNDNDdlJBdG1XSmd3WnhQ?=
 =?utf-8?B?RXpqSE1KamlNRHo5VHZQREZxZGJROVQzUmRlTWM3eWJIOFhZU21nQ1pzV0t5?=
 =?utf-8?B?SjVkK0llL2diWlZiVFNrR1hteG5MbXBxbml3b0JQQnVocnBRWURZZ1JXWlVO?=
 =?utf-8?B?MkpPajA2bXpyTHE4SmdheEcrMVRpRUdYSE5PSThsZkRxMS9uKzE3d2xGcTl3?=
 =?utf-8?B?WHREYXd1bG1vUFViSHpiU2ZzYlpnTmt6Mm80ejJlYlNPeldjTFR3ZHhmRndl?=
 =?utf-8?B?eGN4Z2FrUy80MUx3RFlGTmNsUis5Z1dtVDhiWFBDeFc0OXNJem5ML214dCtu?=
 =?utf-8?B?bEd0R005bXFMTHNyZ3l4T0lub0laVFhhS0hqalUvNm9KYTVVU1RKcUdaSXVy?=
 =?utf-8?B?bG4rVkQwSEpzN29wT0xqU0d0RGxDbkRWVWtwNUJnOS9WMzJpNjBIZytoTFRl?=
 =?utf-8?B?RDQ3VjljZmRieUNtVEgzQkJPaHRSV3BEbkxlS0d6OEJyRDNHc0ZaY3VGSWtJ?=
 =?utf-8?B?dzNiUWpMREtGNTVqYkU1Ri9jdGozV0xNVFo0U2tHOFBIZFE0c2ZvQWFGWHZO?=
 =?utf-8?B?NWF3LzkxMEw0dVlCcUt5VlRQVUZHSFh4Znhmelk0NW5vdTd2Rkovb0Q4OXhp?=
 =?utf-8?B?RXJJS1hlcENhS1FZdGxYdlBNSGc1UW95TjYxV1pTSE9VYmpKTXpJaDdyK0hR?=
 =?utf-8?B?ZDI1cmFhMi9ySmE1b3pMUFVJaFBkUGtBRFI0U0xpVGJtVjFVc1BPdU1ZMjN0?=
 =?utf-8?B?cTdUbTlvZm5VQVNYbnZFRHZLNFcybTk4T2xIc01OSW1wc2hWT20vbUpyVFlt?=
 =?utf-8?B?M2Z5WnFKbDVYSFFBY2JOdHZrbGF2MFl2Qi9rVWZwK0ppd2V2czdOYXFnZ0xR?=
 =?utf-8?B?S3FKVS8rQXZlM1I5RWo0MUlGdlBlNHlxQS9yeldXRDZtOXBLZTlhSUxHQzRE?=
 =?utf-8?B?NkYyTVVPNTAvZHkrT04xU3ZnSjNNTXpWRzJsaURES3hMbVdCZDNyVGFwT2Rl?=
 =?utf-8?B?LzU0VHFSaTJETi91RzVmaURENmdvTFJXNlYxYi8wakJZdkNLTWZRZkh6ek9M?=
 =?utf-8?B?aFd6Mm0yem12ZVNUbWV0L3N0NHFwbm9jSlJ3THk1NnFHd2R3ZXRVbTlFdmo1?=
 =?utf-8?B?d3ZIVnBxbGc4UUc5OXZXU0ZqWElGdlRmWTNkU0NCSXF6RklkbmdNNUttZG1U?=
 =?utf-8?B?enlkNHhLQy9pSzJHNE1DdDN3QzRPNDhHRGkva3hrWk5HVTJWQS9ESGh4ejNj?=
 =?utf-8?B?Q2ZmZDBWcEJja3dkMlBheVJ5Um9aVzBlUTJ2RG92OGR3V1draWZLaW1vbWYr?=
 =?utf-8?B?R1RjU3NBUmNzUndvalhzakpadEtIZklQUWRkRjV3RDd4RmhZN0RJY25zZEE0?=
 =?utf-8?B?aUluZDJLT2p0QmxhcUhNRzhJY0Q2c3d2SUl0LzJKMUFyQTMrR1RBWk9sNVZV?=
 =?utf-8?B?UHJuanpGSURib1FyQ0ZYVis5SkhHUnkwd3FpOFlQQm9DM2RVbTZkZjVFaldY?=
 =?utf-8?B?dHM4NUkzUUNZdm9RVHV4Z09iTDlPNUdORkk5NS8raUVjWVFLK1BRYVpiWFI2?=
 =?utf-8?B?Z2VwVUhDS211MHhpZkNzSTNKQ1NZNmZML1pUU0kxUUc2aHEwZ2lZT1BKSXlM?=
 =?utf-8?B?b1hqcVM5eFNhRnNaalNwUW9BRVc2MzZnLzR0amlUejZqNGZ6NEVzL2pybkZX?=
 =?utf-8?B?U1Q4TEZSam5RNUVma2ZCODlmRnFmenVaM25YSWowVXI4ZXFmZWlnZXIzaENV?=
 =?utf-8?B?ZjZGQ0cvUS9FOFdxQ25lT1NxSUlKZ2lWcHowbVR5d3BXbVJ2WXBKUHM3SWdo?=
 =?utf-8?B?WUdVbWhIdUtQdHNCRG5zOFl6dXlwekJicTMrR25VWEhmNGlRTkdOcUFpdzc0?=
 =?utf-8?B?REpFSHpOdEl1NWNCNUZWWENCdUF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Siv9KN2iwJTyq9OHTLdL2sauOnrWSRskxXHyMPn1IytEWoBge3SnkQdJKsPN+STu5cm5oi43iLQ92f1gYves0GMPSjN47xBIylks55J8E2ejK6Va/NkQtSrRnySSXMUVuTFzeAtrQzxw7dV0S6TOtsqs6asFls2e0xd+Zfi5j5E1qADkH9QEZYMt/3hxEpmth7JTacLKN+rT5LPSs/fQ3Y88vZgYl7bhGVpSunQ3KjSN43rq57o/JlwuE2GEDc8QR9hA05L2C3SOdj+2PiVgokGv/xI1Ut2zDWD+W06oQCZWXWOGBJmv8A+8woSYhgmkTAKRncUtZauBFDAHe8QCYxRJ3Jtt9uoRjTJM6i0LpERo6R5hLBI1T0wdW2BClvlVdhc0jrxXlllALF0SfdQ7iVfwfBxrxPOgOYzYQFd50Y/XyqCoxqj2YnpJj/8ABbWf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 07:52:59.1849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f310643b-82e4-42a7-e773-08de6df991c3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6268

Marc, Lukas,

On 16/02/26 18:56, Marc Zyngier wrote:
> On Mon, 16 Feb 2026 12:06:00 +0000,
> Aksh Garg <a-garg7@ti.com> wrote:
>>
>> Routing ID (RID) is a 16-bit value composed of bus number and devfn.
> 
> No. RID here means "Requester ID". Please lookup the PCI spec.
> 
>> Add a PCI_RID_MASK macro to eliminate the use of magic number 0xffff
>> when masking for RIDs.
> 
> I'm not convinced this is universally true. Some RIDs (or RID-like
> identifiers, such as Stream IDs and Device IDs) are larger than 16
> bit, depending on the integration.
> 
> The fact that this particular integration uses a 16bit RID without any
> extra qualifier in the upper bits doesn't make it universal.
> 
>> This provides a standard way for drivers to extract RIDs without
>> resorting to magic numbers.
>>
>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
>> ---
>>   drivers/pci/controller/pcie-apple.c | 2 +-
>>   include/linux/pci.h                 | 1 +
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
>> index 2d92fc79f6dd..6bf9fe102e2f 100644
>> --- a/drivers/pci/controller/pcie-apple.c
>> +++ b/drivers/pci/controller/pcie-apple.c
>> @@ -802,7 +802,7 @@ static void apple_pcie_disable_device(struct pci_host_bridge *bridge, struct pci
>>   		u32 val;
>>   
>>   		val = readl_relaxed(port_rid2sid_addr(port, idx));
>> -		if ((val & 0xffff) == rid) {
>> +		if ((val & PCI_RID_MASK) == rid) {
>>   			apple_pcie_rid2sid_write(port, idx, 0);
>>   			bitmap_release_region(port->sid_map, idx, 0);
>>   			dev_dbg(&pdev->dev, "Released %x (%d)\n", val, idx);
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 864775651c6f..e3d9730121c8 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -71,6 +71,7 @@
>>   #define PCI_DEVID(bus, devfn)	((((u16)(bus)) << 8) | (devfn))
>>   /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
>>   #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
>> +#define PCI_RID_MASK	0xffff
> 
> Even the naming of this macro clashes with the current nomenclature,
> where we use PCI_DEVID()/pci_dev_id() to manipulate this information.
> 

Is the below proposed macro acceptable at the same place:
#define PCI_GET_DEVID(x) ((x) & 0xffff)

Regards,
Aksh Garg

> Thanks,
> 
> 	M.
> 

