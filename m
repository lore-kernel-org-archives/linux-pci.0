Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.84.68
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792743489;
	b=mPxKXjescmagZ9FCBPKmxQNdDsEfP9MipL2AsIe0uyIlEAs5d9aJqfaY6HRwfVr1Ppux
	 L2Wkwo6VdfHc8KjntAEYy2uXuXIZsYQc08jau4Kwv7YoAZ78Xxv9v/E6NPW3wtJT+E2bF
	 X2CBy3aKTDjiynwojHgd0o+LMyH3SqqGmGfWS+BRJbjATT3yzMqSdmK0Q45oS+Anx+iG3
	 G/JSx36KP3NvO8BXY5xRHasXNqfWVj0YnNX43FKjzUCg54pEiundMihQzdW10xIxmlrr0
	 9lobg8hG+zCjJ+N8R3zhuEqfkMK9hFzrvRF9mRrRNvO0OHH2vCRfGuhN/LVQEK8lgRw==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743489;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=1p1yhdxf8+T3xWyyI+10Ynlq35as0Lgqm42y1s88MFQ=;
	b=JXcDNvzGiylGHoMEwhm9GmWkCuHpsda8KDRJjNOdmXpHHmIBScECDcV1sMG6omdAXXCn
	 AjjV3KnOQnggAfBca1736c7m4EfdBbch7YafGLPnzI82WPt56qaYnWKBo5aSWGkoadnHf
	 SmRDlbd7sfcBAziCfjTCu0k8xhCSqt8iq0fZE5YpqrLD1//5ShAcqY34JPjfz/wXmucNn
	 IWiIJjhVjzXwL7R/mN+sVL15yOVWwvQbGYwJjCswbtLmHuJhxb21WX3I0tSY/6peypKM6
	 cguyRxibbvnutFT2VGmjcslC86T8/lUfly3zJk3/uBzKibhvPb+EAKIObqE2Yea6OQw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="f1AkS/b+";
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b="f1AkS/b+";
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.84.68
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD83606A31A;
	Fri, 23 Oct 2026 08:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD83606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=f1AkS/b+;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=f1AkS/b+
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=f8tgeb3FcrxFHPIYAInNIwcBOTWZJg3D5T+KxTTei+6jRis2ETciLuBsux3KdVFBBmDlVHdXJ1dLwpNy3Rm/7E96NJuJ/RZ1lrRe4roDoqE33OjCO6tWJO7dP/rGGPVZl0LwhcDsng2QAwPNXwe00JyEtvi/sZao8kHi46OhTPwLTVsr0VCGqilQQx1gmOmWyNKvXnwkXSHPBK53au7piqhxo3GQKg6IEDxRNGWzXdKDHTM6k6L8ptYuxfC6e75nViJWBmiPof4+uJa0CDPkRhTUn68ppZn+gBfv8JRz6up7CYNst/l7/A2U/PelmMXG6TdeO7kN4czuo+ald5tWVg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p1yhdxf8+T3xWyyI+10Ynlq35as0Lgqm42y1s88MFQ=;
 b=n59H2aw0HPodw3J1dN/wTLiTo3TFT9ifL8i8NHMolbu6NRHDZq2JdnuhzvHGPYj9IOow/zxPQjE17c+KQ+L+Vf2+gBxzNOs+fKpQV0B3uEZ63LZYzuF6/jGNppH5jejx8zJ9j7rz2WEf1t/84j5DcCsLwnPjboYf9wbwjhZDQZKD84EHbEz6XzqrEGXMYiIwcK4J9P/UGg16xeLkLG3n2Fy2qw25KdkbhXhl2uIbEa6HvYXGoEaJxh13QBqEMKMqYoNY3uQX9I40py4r6+jjyT5jJa3uT8HFZW3xDzo5SCECDPUEFxzugaZwxfN8XV60K3Ced6qqzH8IEKBPD/VARQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p1yhdxf8+T3xWyyI+10Ynlq35as0Lgqm42y1s88MFQ=;
 b=f1AkS/b+gFJgvv+vVKsJw9g6BfmGieyTpqovxwFY2kUSiklRNrWT7LV6/mjj/Ijg2IYGIoiCk4tP2bnQJ/Izbn6epaLOXpaCAXG9ADJJRpwllZycNSJAX9rQGmyomuQMZPnoVROKIqoW9HzFhVW8mbx1NTlkxRTR/cNRXDehcos=
Received: from DU2PR04CA0323.eurprd04.prod.outlook.com (2603:10a6:10:2b5::28)
 by MMZPR08MB820058.eurprd08.prod.outlook.com (2603:10a6:190:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 08:18:01 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::28) by DU2PR04CA0323.outlook.office365.com
 (2603:10a6:10:2b5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 08:18:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Fri, 23 Oct 2026 08:18:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAUhRuO6HB88zms8h2L969Kp2hBOyOt/Wmyzg3dOyNMXvR8GDD8WFm7ACmTNQp6diQuuVsJqEZtC9nXpiH4uWCgdtfXQHUEHRDZpxvPjV9skGDPDKVdOEWqCJ6+oRsLFY2h2DUvE3lZLxpSubf4gjTEOecHDGXHh1uJhi83I7APq6cU6EEIPr5e29I5/WifPcpPutjASuJnQr8n/AB7E/kTjFXtVxwKEkqfNaeIsF/5dgZfNGaU87HGTVnyKGNv50mBG8SHGOjA+tExBv7dkqWS8Q6AGaATsll/q3GO7t9PVaulNsY5eZ033kuQEJzwK9vX6u/OoEfkKTfbIi/VA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p1yhdxf8+T3xWyyI+10Ynlq35as0Lgqm42y1s88MFQ=;
 b=Aq7De/yqWycp59V/70dtWphw9I74YoZnDBUIHANwREjGdu4B2m5WPCMybcqDhw5ctWwOVv++kfhFYXL1I3aBatkOEjhUn0ZS4EPCZLEpnprtu5doVOtPPPxwD+izLUwk5Z3XmvKnHOBzoUUmCJEyA0+HMaocjhq0qmXizLZ1GCPsQzFCSUmiC0kSNOSAKyWTn9MSPb88VpY7puoZQTW2miwNvxb4ihRgYOkCS7Y24h26XlDCTQvxr7e3PC1pbClvvPrm3X6iZE0WvJRWs2HMeghxq6sQY3Vv3g4qkUkyj/ZRJMZvODRdBBtOL8Gy+SFot8jO/WqKGkqu3c1lz6Yj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p1yhdxf8+T3xWyyI+10Ynlq35as0Lgqm42y1s88MFQ=;
 b=f1AkS/b+gFJgvv+vVKsJw9g6BfmGieyTpqovxwFY2kUSiklRNrWT7LV6/mjj/Ijg2IYGIoiCk4tP2bnQJ/Izbn6epaLOXpaCAXG9ADJJRpwllZycNSJAX9rQGmyomuQMZPnoVROKIqoW9HzFhVW8mbx1NTlkxRTR/cNRXDehcos=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11) by AS8PR08MB6680.eurprd08.prod.outlook.com
 (2603:10a6:20b:397::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 08:17:28 +0000
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375]) by GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375%4]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 08:17:28 +0000
Message-ID: <0fe0d909-a01b-4f4f-9faa-c533b8925f25@arm.com>
Date: Fri, 23 Oct 2026 09:17:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Mostafa Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Daniel Mentz <danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
 Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <20260929034510.2023173-12-praan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::22) To GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10691:EE_|AS8PR08MB6680:EE_|DU2PEPF00028D11:EE_|MMZPR08MB820058:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d04594-b95e-400c-8c27-08df30de27bb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|4143699003|56012099006|11063799006|261021135927099003|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original:
 m+trFHgf+W8A16Jccpu/uaU4Brf3G7KTtopSdsSxYSA9YwFN9nVnNZ1XfXxJ+klMSJY6DGx+EuSR54PoH418wDR5M8W1yc5//5qitPurpNaT6M6N35TEN7gQAoUypLdyA0g9nDwZhZd8sFgfJ2uGYRZ4uCXhgKGJibStzLBfUNUjLg2e4mK/0TmLW0oQIX8aOm1jKhpp9UNjFs/TaSV/CBGJC8U77EkSgkBzPNK9FKeP4j87uaO9UXF8cOvcXwkWM11ZGhx8ahprY0JmilDnmgU9Ula3rWmlbts8A7an5nGUsSb/H3SAOki9cW8yK+MxpiuJwLWNFmYIhHJENftt12x4DVZciY88bVQaeLNmpglO5BKsUWUCGdOaqfq8IQPyzYHLUsOAHDRe/uCiFnwuBKIK5rdrkYmxVMXpWGnGdmqPW+guCGajJzQ7d4T5JY/kdj4l9OBUR/FJYiPRzL8nJ+ntdMi0j6AEbC3NTrwSeHEInTTnJLGNy7DsvrTFau5BTa8tzeQGjkR6xe2aXIHqXPF+sd2dX8A7hMAqdVaEYXQUNfvtoRbZU0TH15XIb18N6fT2QU1yVPbStz02uFKJ8DYPpAFwWjE9d2mt4ze3fYXyI1TLXZ/jYFfAQtpEOD99Aus9xLT6zyR+t/xILVwWxe2iIHlyQHqgYwDx5ZJX0+s=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10691.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(4143699003)(56012099006)(11063799006)(261021135927099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 iLI9sYPu5f9tKIDRV3V4Fhyk7NVMlcQqDMim9+2cjrxZGDmnvoI4s+DooLNlekOW2HfiUF+Oi1EJWqetges4pQ2Ee3dxkdwQIGmGZSQsmOhwMLDYAYIZ81vQ0aOZNiNdZh4ItjJtRGlJNzvOQJzBsG1hZkSVHgVeSE7aFC+NlRpUTnHKjs7tj1N9OK5YIXYrsnaaHWa4HRTVU57Xcog9I/wfANnigA6g8IXTJdKfJWIC6DqUB9hdB6UTc6cbUisawQH2p08SAqCu8J73bEoCUFbJ9AHTGwg02iiJY5C8Io2i8YUIHnCy1MirZlQ6323XvVq6U2K6iJh38zo6HUQUpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6680
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eeb24acd-396c-4dfd-feed-08df30de1399
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|30052699003|14060799003|1800799024|23010399003|35042699022|376014|36860700016|56012099006|261021123027099003|261022105027099003|261022075727099003|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|261021135927099003|3023799007|261021121427099003|261022113327099003;
X-Microsoft-Antispam-Message-Info:
	G58v4mjizVmwSCBY1PcljPgGQrzb4LJpkMXG1/YpEi8nlUd/BYQw5lJl1o53wG1X75D+QXL0lQzKm+CWT/F5HQ3Rn3DtwFnxQ+MCNGsgKbUahyU9AOgLJKbsJ2KC4WSSgrrwzOD1V0l/M4WqKtx7Dek6mZrT0lqn9oXGY2lMMr0aArCskOtxzplXci2HiFrAatYU+fGk7pduSrAn98Ogp4c5E8wnFGGyOKMgIKhwl02VRjUSEU5+A+wx66jGl5kiClzvFgluYuug8ohNRkSEi9HeXRjXETExYeoTaFfukrFFQ+C4spoD45BXYZprDKMbyn/+Uef0wm79JHAyomt1rBEWzC5xQ3J/w5+QIXgXtMNGnKN4JWq/sACxTm67WBRz02PzWv2iLTYdMt0q/0nIAN7EtlSp/AFLi4CQiL7SjKl9MK10Ms56ZZbffy72WfJBNmVpI4ZbcoE9trIpAMN1u3Sga1HXIPAr69iMzfQKybTufVPCgT2xbxRSi7BVqzIJQaRIPYuFe2BHPkLEqijy0O1T/Ja75bxJQqEdQD0LDcwcoE1mgG71UhcwfbUd+asBojTt24GF5+VDvxmeEOUg0ycg+YVXaL1EOSnfDLtL8/OZHkVFZNpIlKa6P75afBsUxAQxnwJZ2rOM7ft5/AeiDz/opN9EIdTeb0YUtBw+pd9cr7aLqBK491qsCKKhAbWmd/PzeOeyZCjEf6CxbsNZDQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(30052699003)(14060799003)(1800799024)(23010399003)(35042699022)(376014)(36860700016)(56012099006)(261021123027099003)(261022105027099003)(261022075727099003)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(261021135927099003)(3023799007)(261021121427099003)(261022113327099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oxdkon62CA+2FaZpyrz2flVon7xMRMWmfRtUCF2CtS3wdpSZOE21R15FhxeeuUjMWpzRgMdcNPLgpfit+8kJJG4xqR0RlR1BsXjnHoz6une4hw9AWGncROS7LF7tJeyeH+Tc+oyRNgy1h05NFqKrTM0JivRteQL3GVOiJA/ZppiZvhX7PrpfUcvVarys3qoboDB93MpP8RYR1TZ3I+gvF8syNNvfyXPrhpdOwB9m8RFTtboOLN8eqi7Dg6CpxWiy1RicLbXakMWzcV35tooQGP91U8ks6dMuvcGpbJO39qN7pq7YYNX7zEM2olZ4dxn3YIz5Y9IAccvgoercm37ngvS84qxFrphXCxfB59NGOp9b6Ou2+Wn198CsBy9tflU/oe71j94UxApKXTi4pjQCW+TLIiW11lrgjxwCKAC4bwFZ0teqWlLUDDtlZDgEDmfa
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:18:01.6199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d04594-b95e-400c-8c27-08df30de27bb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR08MB820058

On 9/29/26 04:45, Pranjal Shrivastava wrote:
> Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
> queue's producer index to safely gate command submissions during device
> suspension.
> 
> The flag embeds the suspend state directly into the existing global state
> The flag is checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
> which acts as a Point of Commitment, ensuring that no indices are
> reserved or committed once the SMMU begins suspending.
> 
> This prevents a situation of "abandoned batches" where indices are
> incremented but commands are never written, which would otherwise
> lead to timeout during the drain poll.
> 
> Update queue_inc_prod_n() to preserve this flag during index
> calculations, ensuring that any in-flight commands that successfully
> passed the point of commitment can proceed to completion while the
> flag remains set.
> 
> Suggested-by: Daniel Mentz <danielmentz@google.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 35 +++++++++++++++++++--
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 +++
>   2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a123810fac57..7f89e2306942 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -218,7 +218,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
>   static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
>   {
>   	u32 prod = Q_POS(q, q->prod) + n;
> -	return Q_OVF(q->prod) | Q_POS(q, prod);
> +
> +	return Q_OVF(q->prod) | Q_STOP(q->prod) | Q_POS(q, prod);
>   }
>   
>   static void queue_poll_init(struct arm_smmu_device *smmu,
> @@ -726,13 +727,42 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   	do {
>   		u64 old;
>   
> +		/*
> +		 * If the SMMU is suspended/suspending, any new CMDs are elided.
> +		 * This loop is the Point of Commitment. If we haven't cmpxchg'd
> +		 * our new indices yet, we can safely bail. Once the indices are
> +		 * committed, we MUST write valid commands to those slots to
> +		 * avoid indefinite polling in the drain function.
> +		 */
> +		if (Q_STOP(llq.prod)) {

I know that there has already been other comments on this "stop" flag 
and whether to use it in this way... but, if CONFIG_PM is unset, could 
Q_STOP() ever return true?

And it would be nice to not add extra logic in this loop. It is very 
timing sensitive, and adding extra checks can increase the chance that 
the cmpxchg fails (bad for performance).

> +			local_irq_restore(flags);
> +			return 0;
> +		}
> +
>   		while (!queue_has_space(&llq, n + sync)) {
>   			local_irq_restore(flags);
> +
> +			/* Avoid waiting for space if the SMMU is suspending */
> +			if (Q_STOP(READ_ONCE(cmdq->q.llq.prod)))
> +				return 0;
> +
>   			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
>   				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
>   			local_irq_save(flags);
>   		}
>   
> +		/*
> +		 * If we exited the polling loop because the queue finally
> +		 * has space, but the STOP_FLAG was set during the poll,
> +		 * we must abort immediately. If we proceed, we will
> +		 * commit new commands beyond the Point of Commitment while
> +		 * the SMMU is suspending.
> +		 */
> +		if (Q_STOP(llq.prod)) {
> +			local_irq_restore(flags);
> +			return 0;
> +		}
> +
>   		head.cons = llq.cons;
>   		head.prod = queue_inc_prod_n(&llq, n + sync) |
>   					     CMDQ_PROD_OWNED_FLAG;
> @@ -779,7 +809,8 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>   		/* b. Stop gathering work by clearing the owned flag */
>   		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
>   						   &cmdq->q.llq.atomic.prod);
> -		prod &= ~CMDQ_PROD_OWNED_FLAG;
> +		/* Strip all metadata flags */
> +		prod &= CMDQ_PROD_IDX_MASK;
>   
>   		/*
>   		 * c. Wait for any gathered work to be written to the queue.
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index deefb17e31eb..794b258550dd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -394,6 +394,11 @@ static inline unsigned int arm_smmu_cdtab_l2_idx(unsigned int ssid)
>   #define CMDQ_ERR_CERROR_ATC_INV_IDX	3
>   
>   #define CMDQ_PROD_OWNED_FLAG		Q_OVERFLOW_FLAG
> +#define CMDQ_PROD_STOP_FLAG		(1U << 30)
> +#define Q_STOP(p)			((p) & CMDQ_PROD_STOP_FLAG)
> +
> +/* Mask out software-only metadata flags to get the pure queue index/wrap bits */
> +#define CMDQ_PROD_IDX_MASK		~(CMDQ_PROD_STOP_FLAG | CMDQ_PROD_OWNED_FLAG)
>   
>   struct arm_smmu_cmd {
>   	u64 data[CMDQ_ENT_DWORDS];

