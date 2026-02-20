Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2503338586;
	Fri, 20 Feb 2026 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582477; cv=fail; b=Ma2TylBPt3FdURNl0ulmh4LvI7Rku7iS+P20SoKsslD1HYNYpl3TQUio1mowJNCBBe3KAvVifuyBFg/+RLo//I2zftoVEue39hdlI7LSM3Gm8fs+XRKQ+Z3VAIqN+4kGZBFb2gN14IK8ixDpoGIxUST35tEqmSmrTV+5z04BaIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582477; c=relaxed/simple;
	bh=LCvWWMz+Kz9Lghmo52P8dz53pSDJ/a74l+Ijlzvxu+8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmJW3hv4yKDxEUdGKuutJ8SzPDP0LygnBOtj0lj2CLRD6itDOmVVLuRDxfoOe5Iq06eU3lg3AQGJ1sCxa7/Mths51XnmkicJIphmKAqO9wS1oBNumO4pzlfYlT7DPx7ucRw51LqqtsjuUrXnpY5lyJT99rRpQ04QL+37n9CIJbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n64m4qBm; arc=fail smtp.client-ip=52.101.43.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n64m4qBm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhhtr5mCj2ph7ny4w/jAE52owjpBp5yhfQVr/SYGk1iBMaHjHJuBWvCE7r3Sn0oTCugk/9NINJzy4/2yr18+wrfucCB14kY7HJF6suXb0zpFUH1QyGRBBBwmAy/Dy6/viUrtol+EHpm0KrRbv0GnhJ/IKtSF4F5IIva+1XIAL5AHpfz8ex6UllkqTfM6QMh3u/DFG8UQpAHJdbpCa8sjfaYYHyrT9NTM1oeiaRlpG0OmCNHND81/n2kFy5JUcO2BEFZeNoU9XGN2kEdqaMbKUi/V78x/wXvJOuBVGESkR+DBWHy9CL8YrrTNoIS+NhV9FFgmeEMsJHh9oDnmGtQwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCvWWMz+Kz9Lghmo52P8dz53pSDJ/a74l+Ijlzvxu+8=;
 b=hVE8JtO7/of5cwfLx5Iij/Rk8k9t7isqrtQYXhO6YzcHWh+KTy24IsGdDwRb7FL3ClU0aQ4/g8jZJD7P1qXrPr6JSRHF84splbaV8BTksjJoYmySjE6foAnwvnzx/jn0T9K1wtL9q2fPpFFpF6MLQ76qId3wgFqvJuZY1aRAB1+AFykA7NMgXwKE7B0T+pAoH8fDzVeM4uIwPJpzYQe4dCr1Uq2Re66Dq+XzTXMrem2xAoIJ5iRsNb72hyOExQySKFW+SAPO17Cj1MsaNbBWMc7CXtKBfZV4ohu84+JuwjaZ40UB9Enbav56DyzH147bRixGi79FQdP4tKbuLc2k6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCvWWMz+Kz9Lghmo52P8dz53pSDJ/a74l+Ijlzvxu+8=;
 b=n64m4qBmxwDkWizOIwrm1fp/jpngLPtpD2yhtKKiu+EBhOGWFhQvFh+gIBmZyWYWIIk1oP6hIbmjH5z12sZp1IsHkX232pFkNrqLOtFHwAcFVmeln0CQ3q+Ropye59QhHZc3+n3yvv31LVbaNbjihm4t6jdryeS4EFRXcpGIBIw=
Received: from MN2PR08CA0016.namprd08.prod.outlook.com (2603:10b6:208:239::21)
 by DM6PR10MB4282.namprd10.prod.outlook.com (2603:10b6:5:222::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 10:14:32 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::2f) by MN2PR08CA0016.outlook.office365.com
 (2603:10b6:208:239::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 10:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 10:14:32 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 04:14:31 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Feb
 2026 04:14:31 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 20 Feb 2026 04:14:31 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61KAERQc3693545;
	Fri, 20 Feb 2026 04:14:27 -0600
Message-ID: <67ead554b375f563c8225b989819e5f7ee7a07f9.camel@ti.com>
Subject: Re: [PATCH] PCI: cadence: j721e: Add support for PCI NTB
 functionality
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Aksh Garg <a-garg7@ti.com>
CC: <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <arnd@arndb.de>, <mpillai@cadence.com>,
	<hans.zhang@cixtech.com>, <unicorn_wang@outlook.com>, <kishon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <danishanwar@ti.com>, <s-vadapalli@ti.com>
Date: Fri, 20 Feb 2026 15:45:56 +0530
In-Reply-To: <20260220101030.852423-1-a-garg7@ti.com>
References: <20260220101030.852423-1-a-garg7@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|DM6PR10MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d60439a-bf9d-4232-c0e2-08de7068d73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|32650700017|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTNmY2VOYVVBODdDZHpPQ1VoRHBFNG1iWC8xWWUzVHhRRXl0L2tPalVVV1FM?=
 =?utf-8?B?RjhoWlpyVXpVK2x5TmNIUDNRQnhLRHRhYzMvc2FYcTNza0VrV2ZnTHVCQmxt?=
 =?utf-8?B?Tzg3M2V5LzBnZmFndkhGMEtFS0ZZMjRlNGVUajRlcEZjZTZLT01KZE1MRzJ5?=
 =?utf-8?B?Z2lPcWxnWTN3MWRMMVVsdEM2Z3RwNU1QRlF2VXRaRitTbzNKYTRuZU5PaGFn?=
 =?utf-8?B?N3hVMUVCUXhOYUlyNlE3TkJORzhaaDJSTUJIZTUxUGM5UnY2UnByUWVCa3ly?=
 =?utf-8?B?ZnJwYXU5WE5ockd3R1JMemtrZUtCUlZ0SWJqOEI4TGU2TnNXUGdmaWtTZFJh?=
 =?utf-8?B?UGxDRXR1VndRWHpTZXpXcWdialF4UkFOWkg0UnBSMlh2S3RScUtRaUEzYTRv?=
 =?utf-8?B?N2IvdkdxbVlUZnhhYzFPeUkvaDdxMTBZeHgxdzkwekkwWk56NWVGMS8rZ2do?=
 =?utf-8?B?M1pWY1UxeHd1MTdQV1I2SnRJRWlGU2hjNFpZZi9qUG1TZGlEdm05MWhUU0w4?=
 =?utf-8?B?b2M5Mm1SUE9tMmFNUnVMS2N6SWFPMitDUURzQ1N6TjlPVzNTTTVha0JjZWZB?=
 =?utf-8?B?aDVVUTRrd0ozVk1jRGV1R0pPV0hnTHArTHB2UXphdys2VXRmMGZwVXZtbmxE?=
 =?utf-8?B?aFFNRjVoYlMzV25FSkkzRVpLVzVGdE9CY1p3dkFQbURJNDV2NXEwNnk0SlE4?=
 =?utf-8?B?SG5UWXlQcXplc1RrUEtVbmxXUjRRNS9tNEQ1QmcrbWR2Q29xZ3hXL2VzdG5i?=
 =?utf-8?B?eDFjU0N3bERqMlhNNCtUaHBKMFRVWGYzZVhUZm5tUlhhRVhqQmtObS9HZmlo?=
 =?utf-8?B?VVFxT1d0Z1MvNGhGb2JOZFY4czMyWFk5U2VxNzExS09CcmQrS0N5aUxRVlZK?=
 =?utf-8?B?L0ltSUkrSlhWN2RTcXRGLytvNC9sN3NGRktJVGRod2V4WGNWcW9YSEpQTWdi?=
 =?utf-8?B?TzZ2bHcyYllGZ0dabVVscnZ0QzduUjFjSjRBSHFTekFRNnBVcHg2MzRTUkFv?=
 =?utf-8?B?R2pKbzc1Tnc1Q2xzUEpxUkFkaWVZVXNUMHZGSEZha3hBRmdaSEpMbWZyS1pD?=
 =?utf-8?B?ZUtGdTNrT2FZM0VCTmY5dFVQY1NoOW41QlREYTVwelRtbS9aMk0xUGNsWnl1?=
 =?utf-8?B?bndUNHR3ZUk5NWZaQU9Yb1V3YTBQM0tPZnZHRjR3bzRSbzhjOTVxb2htY3A3?=
 =?utf-8?B?RnE3VFN5YTJLMjRhWGpLY0VXSlJ3WVBVT2Fia01MQlY4M0YwLzRQbHkrL3kr?=
 =?utf-8?B?VUtKemZQeGtDWFVUTE5lQWMrSTJrNEhwUFM3Z05nT1pVNUNFeXdlOU92cmdS?=
 =?utf-8?B?b3RaYlVqU1lNeHNscGlFSTBjTnhJa09INXgwQkxrRXYvVmJFbS9QZmdBUCtF?=
 =?utf-8?B?NldndWtkUFdkOXB3dnFOQ3cvbVVQQkpBT08xQnp3aDArOXpORHRzT1NaMW1t?=
 =?utf-8?B?WWdYOHlSTXdVN3BvL3VLdFRBVHBRNnkwRWZtMlc3b3Z4RXBEQU1vTTl1K1Nq?=
 =?utf-8?B?ZDZ5R2tPR3hNTTBHbFFJY09TRHIyNmtnTkozb3lNNzJCNEZEbzNUV1ppUjdN?=
 =?utf-8?B?bTduSFAwYU1PUGFVZnpiZ216elZKSUlBRHpoeTBUWHExMUl0Ni9nT3V6a2li?=
 =?utf-8?B?cHlHT0o2NkRoSWVoZTBWUkVUYmRMZHJzQ0NTTzJkWVRJanJJU2Vaa1FxZnoz?=
 =?utf-8?B?VTJrR0pVT1VnanlGRHZJZllnY2xjaDRRNEVIdkRkZjh2V083aVJqR29jMGY0?=
 =?utf-8?B?K2VKN0R1R3RScHdFVytaMksvOEZWOVBxZ0FLbUpJRm5JRGs1bks2aElVYjFn?=
 =?utf-8?B?NE9zUGlLOUMvMmp5R3piSzZHeGZXMGltV1hKK0FnNDRCRjBUTWtSelU3UGZu?=
 =?utf-8?B?TGFHdzE4WVI0NXM0ejZUL2xnaUZkYTFkemlXby9jVWhTZUdUZ25FWUZXaEtP?=
 =?utf-8?B?S0t5U0orSGxCS3RIVkljaFRKNjlZcnFtMEZWL2Zyay9BM3lCVC9iR2ZLSWw4?=
 =?utf-8?B?NGJVWjIvdzVOQWhqU2hVVm1aL1l6eHJxb1VlcERLcFQ3TEF0amFhdVBIaS9s?=
 =?utf-8?B?K21hRzVxYnJQdi9hSDN4WHVqVDdtV2prSlBIVDNGUTNJeTRQTmExbDhuWWxX?=
 =?utf-8?B?N3ErczRTa3ViaXZyZC8yVU1PK0w0Y2t1Z21JQUlzQStkcEFZQjRYVGV5Nzlj?=
 =?utf-8?B?RGxnbjRqQTNyRWtZOCswQjZXMVJLZUwwL1ZmWU11Q3ZoYWlEdDVNTVpXN2tv?=
 =?utf-8?B?WVpZRnhlOE4xbHVVajRPM0MzS21RPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(32650700017)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uBI542jwN8DJJxX8Fqi1G/YuYeaqbLeQ7GUg+Hk9TMAOFGNwVNuNnQvfFzobhmEsn0FzF9keaIkh/UXjde1tuqhMVIt1kbj7TcT4PFw/JsWplrXZFulwLBrydPNAxWuQ1zORN0MYCNIL1wRHHT1Y7wiwFd1gCxTyUPQrnQ4qPUosnGVrYxO3fnz7u0F+E+m5fatYxI8FXNVf0TEueZjvdmrpE6IBd+cgWqZsIPzlljwzxrHWQ24WwUOpAWNRFNcl7VDTEncCjQTlYZ3PnwW2oeQT8QuI9zlHlS7x/eie5eaFD19YKjDpWZ5qYMA+CZGKkV8NdRbRrKcAcVOUXojmU+xdHlzJ7aLFKqk6/gfRgYh7ntHbq2Rrab0brs7dWjMduRuTrXIJ/9gR7vzYiqiFFaIRKukoUhNQ44Rq/yLD0+W38n46KDVSvNK8HspI1+XR
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 10:14:32.1912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d60439a-bf9d-4232-c0e2-08de7068d73a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4282

On Fri, 2026-02-20 at 15:40 +0530, Aksh Garg wrote:
> Configure Non-Transparent Bridge (NTB) components to build along with
> J721E PCIe controller driver to add support for PCI NTB functionality
> in TI SoCs.
>=20
> NTB_NETDEV allows to setup a virtual ethernet interface over the
> NTB Transport layer, enabling connected systems to communicate with
> each other using standard network protocols and transfer data as
> ethernet traffic over the link.
>=20
> Signed-off-by: Aksh Garg <a-garg7@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
