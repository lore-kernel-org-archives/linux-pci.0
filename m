Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023131.outbound.protection.outlook.com [52.101.127.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9012F3620;
	Mon, 16 Mar 2026 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651018; cv=fail; b=if9AZlk50yA19fs1gTe7jPnO6hSc+BDpeJ7QwWKFz2TLQoj+Ogym8oX0qDf2P7cx+3aGzvtoRxrN09SwVJQkPkaI6FOnTNZXGqZYuvqvbkcsLyVDLQGpSZS/S7ApKPV9myd2crUY91QyZkXbjb2X79Qa/y6E93/CAsKFpPL76xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651018; c=relaxed/simple;
	bh=MCN7aBtYyVdOZ+1YyR8jrHX1VhzYqCaWjaCNdHY6mT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMNT/kKV+kNFIH9lr+jwXhq6oTE2QhAnOi86efo2Ilk4Z38Evbr78KabKF/78NWFVI3DOJXyQRIBP4aeQg8diALsdS+1+AJXG6l/f5QJTjl/He7zB8pwfve0n+tWGOCbcbxAxl/cvNausTbapSxl/TivAgX6tYYCHeNJKHAId80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/EY/Yk6vPYSm0nkTYmXo5Lu2ihCkj+81TiIzsruV2+NPBscZGA4phG0FJG63pvGHlTpT6BIxd21ypqhjIRxaSkDuzC309YFcdquU2AUee///WSC7bSPnX9kgvVBy4h/ZCsI1epvggl2VoduEhHWNKyLp6yrLJTEZ2CJe/wQSItPDQdfWH3HE5rAebJUlvgv775JN/T4UlN36P0fbnlRFNMDvzUd4vV7P8PA+l3pM5Y8AvMCkHNZFre3t4wlt20PEJ34PMBihcUKrnIDVQ0xUTrfzmNpr/6qMsFuRXmB0yOGJTXm3hJFdWTnyYy9G6pj+ryLXoebXouaoIHNN9NqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQhnU41yptmqlwpo09kIxrDFtOhy3E+Jk08YEYL9Nxc=;
 b=iR5NVUvaZ/VSpH3wX1Y6Axds11XjO7jz2vkj5pzZ/EJwUWEdBTlAVJrbo48I0qgyi18EeMXlwBsxOfIS2f8u9ipX8P4Y1yh5Gtca0Hb30AA4HTPM3dI6BdUaMfHYPuS5kQ+bpCjk+Da0kPgYiXqkbCHatGkVjSPzeUm4JUBaxxVEgOv2hD9gppZ8wcaHnXH/ZSAMeSnUtEG2Jjhvl0t2hjIrNcRkBGBlKUhE1azl+GaMaT+AsEz684eYA/Xwxu/hdMPQImlsfJwQ2GHnXPaodPVP9nMvL5PW3dcxqJAl1McNFGO22TIHF//zm3mjTJwyRLSGN1JxJeInQWjiiReaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cixtech.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP301CA0043.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:380::19)
 by TYZPR06MB7040.apcprd06.prod.outlook.com (2603:1096:405:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 08:50:13 +0000
Received: from TY2PEPF0000AB84.apcprd03.prod.outlook.com
 (2603:1096:400:380:cafe::a0) by TYCP301CA0043.outlook.office365.com
 (2603:1096:400:380::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 08:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB84.mail.protection.outlook.com (10.167.253.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 08:50:12 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 69D0F4126F80;
	Mon, 16 Mar 2026 16:50:10 +0800 (CST)
Date: Mon, 16 Mar 2026 16:50:03 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, mani@kernel.org
Cc: Gary Yang <gary.yang@cixtech.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	cix-kernel-upstream@cixtech.com
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: cix,sky1-pcie-host: Add
 power-domains
Message-ID: <abfEO6iW3NcnMyNx@nchen-desktop>
References: <20260313114914.1564115-1-gary.yang@cixtech.com>
 <20260313114914.1564115-2-gary.yang@cixtech.com>
 <20260314-maize-warthog-of-modernism-f74475@quoll>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260314-maize-warthog-of-modernism-f74475@quoll>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB84:EE_|TYZPR06MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 021b91f3-e8be-4183-f928-08de8339097b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+lrHDulAuisFnJY2M9j/JEgMgBJ/0tcdzI8j1gHny54le21kwTKxhVGwJ4TMfh+Zd3Bc3+WU47ZiC1y4sM2+vtjPpkJr50g/+UfsJXqLEfl2skHxuRTUCeWEKiYae7tLgJTopnOcsSiKxyo3zZRvqcEan/W4ozobU1JOR+cK4NdY+LDWSbJp2zjC+rDLOpIrJQE/bYtH39niOEHDQOyA4iy+wTS47iKPmzVVtHg2qI/ZAwK9ltrMB5HK/q96xzczThXfNN0T0Gfi0afwQLtZ1jY7NZHA4DncSrfDdorMVrtkp6BJkbUCNuLQDprXZ0hB5V/sVTPFwJvLkmZ5SeBrNJEBCffVMjVFumheadMKR64CoBygsvW8m18bXbOdNGl8EQwZSkyS8LBLv/A4DKfnBhToMnNTRsYvkXQpiVl9Fd/211NQkGuMELj8PYBE/A+KQKiHUehlASEN0XNCt8Zu1jkT1DgIJsUtU0rDOeNzOrWHCNZXgHnyce50jQKkl0GhZa86tAFrPTPPY5cvi4eAGO8URgjFOxsEEUD4pgjZqCMooUmYo0oxcZfcV5g/0vvLPXFqzCo+/zCU5cgdeyvEZDEXUABYVX3xEWOZknLHS2mtNOOBT3hQst/tU+ZdLMWGFNMoXg8WpiGHCn4pPr4qQ/NEgBZNDr+YfPsduPbAH7iY3CbEtAo9unpS7Q2ZIjx1JbdVY4UEu2EDgeeOZbCjhZ/0sdI5mSdV1mwCNfoJa9NW3NN78Cpq2IUNuYYoAD2UrfQ6dFmC/ruSJgXb9VGNdA==
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9dv4qSxmgIKI5MlNk58mASSy6qEoxM6071FhLyFgqdOq5crbO96yQqPXNdH/6DU6gK4GGr0HwdgcKU28Ayu65AUjBucRlGianCGhYH3isf14PkitlsEJdMhKz9/+n4ztmlbjTOL/yybg5uYa61qUltMqXt9yNuBmbCKDNav5ojGIatVoQICucxFxhMdO2/OyU127AScF6w5z/Gg6Qixa+rEYdMg7MvVAl4AVKSGM252gaP3s3+bgvicEEh2YQehBVxz2mGsUvz+Wefg/5m9nNr1xrkfRorqRrjS/PuPdOPXpmTHSRL7SJhjP/pj93BYIcSWGGo5eCKgJLXOU40clWYuuOJj6knPGS2IeRzjiP0DsKsxm5gITE8W7olhasK4U4TXUpOh79eizBJWjAK/fssMo69SN7SKbnTCfuJk7vqOoAefULCHlzXuHTCZ/xBqb
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:50:12.6477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 021b91f3-e8be-4183-f928-08de8339097b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB84.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7040

On 26-03-14 10:26:11, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On Fri, Mar 13, 2026 at 07:49:13PM +0800, Gary Yang wrote:
> > The Sky1 PCIe controller resides in a dedicated power domain managed
> > via SCMI. Add the power-domains property to the binding to allow
> > describing this dependency.
> >
> > Signed-off-by: Gary Yang <gary.yang@cixtech.com>
> > ---
> >  Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
Thank Krzysztof for kindly review it.

Mani, I assume this patch will go to PCIe tree, right?

-- 

Best regards,
Peter
