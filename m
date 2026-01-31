Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020130.outbound.protection.outlook.com [52.101.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA60D34FF5E;
	Sat, 31 Jan 2026 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866635; cv=fail; b=THuXACi/gZnQ6v8DjJb/+frvOp/tm3tkB7tsL+RaDQEeAhFgd4KR8oXdDABpamKJhNCToHrPuCbe8mf6sHpIKWaiDbSNrmGRJjLRhzmRdQHAg0ZWanlhuzVsmvG2Ak2DOmGH8TtoFzASTb9s1TPhoptyzyDuxBfw3l04b0Uo3e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866635; c=relaxed/simple;
	bh=X6O7t66gp66HCp91qg/Gvc3NQ7ArPWNWcSrcYOHOFCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BfXDxkO6zvgM8aWJQ2TRIXDpHiEbAmGtMT4hCe+wJchJ2YATpnrxpnOqeiJo81QWrS3r46j2XNPt3OsZgZ5eeed6POWGQltWSawXmbgWI0FhAlX9LFCZBY6DxtMubHb5FjqQwAyKZiwclKDzG8HmctPPLccrRMB+x5bqdIm67fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=i9g9A44B; arc=fail smtp.client-ip=52.101.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="i9g9A44B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OB2lN6RulOd9eMUVP4VoARWi9QWp8zPnvoNni3ec1a1J0PiICDO/+YTXVKQ9ADwGr825hH6Du3WY25DxqmVrQ0lNgU2WtPYK/OIx8ym68tSUvvp8q322ZdRxslipaOxxIYBJvrx/Q2sgDLJxOhgJsYT6eq3o7aq1Mz8JJGcFrkzKOHgIRe0pPwjUdDnWx5dcnTBMaqikPrYGuXDvLNGhHT+EIMmq/Iyw3uc0fje57Q8Ps7YMRYwBkUIcJIK9TMQKi6JquOTrLrHBcIitjkXx8H2Ree5XFDTQ8yIr9FxsdBjEyW3bcxemkeZxZ4QgOzYSDigUMmKtuh4422ZMJQRMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+t68dBPpDV4Bxfnnwxii4grBGD3wbam6DT3zfoyKCw=;
 b=KnfMQ4LIpJYOVl64howwKwsgNTNh5pxj1fhCdnP5RbhzvXwr4T1TOSfjZu05idA+vjIPFelSvbHZdJ0ggIMbHBgOWCEDYMKSkAbom0j+O4oqe9mge6AjvGsbUr+9Gy1hxSfq866DtfzOXocYFQnCweWsfr6KB67LxYxsmktD7C0yV21nSYG47XWMlYLhrmABVP58s4O+gc1IZJ7YJh1yRhQX0l68Z9WgS1G9hdyXNtVOZKSZdqoeGTEaB/xnvrmmH1AX237xN2rPRbRgsrO7imLbxjkSfPAC2Fp/DbEY+mjXaadB5h8y65bxl+3VWXXnsKFzPv2nCRdF/FbdmSZ8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+t68dBPpDV4Bxfnnwxii4grBGD3wbam6DT3zfoyKCw=;
 b=i9g9A44B8AYE/m0I3etI691UVm0lQzRQgRZpqeSdM0OYjP71E/wBJG+jULDKRcyiSfNWS1G/NWBIELxFGp8gBgmFqeBRL8D2vXT+zYwZfhGr0slCpfJ2NLb8YH7qprdaDPBpwnuNdLqDt7qI21Ropi4wFh8F8b/oE8zzc3oSg3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5003.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:14b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Sat, 31 Jan
 2026 13:37:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Sat, 31 Jan 2026
 13:37:04 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	cassel@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: endpoint: Document pci_epc_set_bar() caller ownership and lifetime rules
Date: Sat, 31 Jan 2026 22:36:55 +0900
Message-ID: <20260131133655.218018-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131133655.218018-1-den@valinux.co.jp>
References: <20260131133655.218018-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0133.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: 3206a32e-c831-4892-61c7-08de60cdd216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u9Xrsy7o+OCtrXWYicxK1rtWkbtzSqOeLQr9cx8/Kztp59SHifqeV3CUDn0y?=
 =?us-ascii?Q?hxbWb85NMHpAh53KwFvosu/vgTannHJCZS2N4QJZnXTkde1etQospdsQOQrf?=
 =?us-ascii?Q?Esxuue2kMmE7XvOfQ0YBlGu6RoIUJPFmr70kuI9Gyl4A3hBp185j1YbsUZYY?=
 =?us-ascii?Q?3wYhCl2aFU3KonsUZ8e8FFTz3hKK+zuccgNi8btVfkSi07QjRZHTd1t9jCJZ?=
 =?us-ascii?Q?wNm7RBbwVUS6Yy5R/0ZVvF+QDvVMyyTJhumEHupZ9eXIWUd2kpWXgNhmuNd2?=
 =?us-ascii?Q?JOvhzLt9wUALS+2iOC3dLyhBqJldPAg6OKjo7g5S/B9DjA40zCmufJDWtNwG?=
 =?us-ascii?Q?NxRUmzQx2qPLjZF9FU0LGG7b+w0lsV2bAhwwEnkvl/ZqBWOLPGpfGhEmNwCR?=
 =?us-ascii?Q?bza0B6MyO4lqhwKCI+DGVyQIfNZz1gQ5+Ov4JLitfqjy1lbuYXAovPC5kn+4?=
 =?us-ascii?Q?KpffJ+vghSI1ojptT5bsrjaGFvrkD7t8KmpknpSYQTJEh8T320MHq7Bc6RFU?=
 =?us-ascii?Q?1vwfozy7RrseWC37NlImBz3FUhopN2iAv5vSvXMDWqqPiB8kiS6bYESc7n7q?=
 =?us-ascii?Q?azNOGRHSUpY2qPLmsCWuZ3//9lOULHmSaCP5cgeKHzbdl0alYNMV5RV53p+u?=
 =?us-ascii?Q?z4ZW/dEoPbUYRzUELsxvNgD2Y8IJ3r2FAo0CSSCE4bGv3Xy/50TgWmPtDs/8?=
 =?us-ascii?Q?mPROr1eOvrPLIpM/MzSmqTzwnsIAGAR71QzQd41aQuNaRnH0Nq7aNtmH0d6p?=
 =?us-ascii?Q?wyDcwF4lR7LFdbxUHlJ5lTG8GBV8xzAEjO7pG/Q6L9zcZniH9QnAbcC3KZ6R?=
 =?us-ascii?Q?aDr0GPROz2lbarX18bjtcolnE4M6bNYBHCqsVOyyIhk4yVfPlqhqj80FZ9df?=
 =?us-ascii?Q?NYp7UAPuReL/7f7aRGfnHp834ZuQ8F9uoj45WgX5zBPBRiN4gKu2OTIZiS9f?=
 =?us-ascii?Q?lhYErlFtCmeAlUmA0aFndvwRaUa2AmdF9NjheUK+E1w8Xdps1ZZEBlj0TN4A?=
 =?us-ascii?Q?SRrFDN0clK307xjtMEWnetiOcPWyJ8PV5HhrmPxeCXs+W8LV1V7b3hG60nrr?=
 =?us-ascii?Q?4NPsPOWcrvMraE0EI64aES3EkUMtI4PWGPOTalGFKvdByUHJv3h4+ihwsSOd?=
 =?us-ascii?Q?+OkOq4lai55EQnxFKJUKwUMDsMfb9sjR4zp0gsXUfFlGcwcPKH6bWlyidG8c?=
 =?us-ascii?Q?aG0rcnrFQHldu9RMV0O6FCheNn6XWrht8SnHGFRiTp3haE9yE/7iqHgyZn2N?=
 =?us-ascii?Q?ISveK3yQXZitqsd8vsmofYQvv5SSmsd+6ZlU962SdI8e+q2WkYa6uU6OU2Lg?=
 =?us-ascii?Q?f/32PET/orfBd8gAD8TAu4ruxtdDfh1eulIv8ziKYu/02tGujIK0HhTZoeAl?=
 =?us-ascii?Q?wmVFeB3t613nlBXzv/x2PEyCTyqnQU4BY2a9zyumQysFlGrreB6kKawgAA3E?=
 =?us-ascii?Q?opDgBv0FfwgC9neRcQ1XqghrM1sFK/OknNKa6c2lhpEtuWedkDhbscbuU/iT?=
 =?us-ascii?Q?aCCI/yTfKAW5LWg1/KLmF5un2uTVwG+ZWgiLKewRZzI79h1pRw4K7TeBpj1K?=
 =?us-ascii?Q?b/bqVyKwGxtqvzxA7neMWRsQIzJ8MyZrsnUFcRSwdvs4kNzcjTOwYBMemBQZ?=
 =?us-ascii?Q?Hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Y3AVTak4q2YxAAG/oIVf2oCmMKXqkejtE7ZVFm7m3AE0xMbE/n1nx6PP5Ri?=
 =?us-ascii?Q?MKTI9io7XRqqDyZ0qvjsdr1CbdDKzGNyCvlq4m0pyVH9x37KBmMWbFc9p4Fm?=
 =?us-ascii?Q?vH2XS0GfNVInn013/bPOAQttcSuiMk0elikm8W6hsaCNciKaMk3PqO3RETKq?=
 =?us-ascii?Q?vuD9RdmUTTFUm+YoXdTJvRSXPNfTLCzXSV8+AVqwL2NegUY2XGsqfELKAbxi?=
 =?us-ascii?Q?NSfEC/cz+YYUG4OSXUEMBq7oBG1KuBqn9VE5DJ2nTGKYwBpJTXEj/kfuQ/AN?=
 =?us-ascii?Q?Vb8kPnva9npFV7mlcrbC1ahN8JbKqEgD14/8lD2JJpLPA2Km3vefsjX1F/JB?=
 =?us-ascii?Q?BCRN0vNYehEMWOuTw+1CK7ymx1BBg9EUhRnLvVB1tq1qBRdmW/RMde9VwbY3?=
 =?us-ascii?Q?Hd0KVOTHGEcHFnUx0vfcs9seKYCZEy4s1KAMhhIHXdyzAl2eyudXZwV7HS+C?=
 =?us-ascii?Q?aLyrofageXA80ZSHqJ9ylTkdX74MyP4flSCKbPmpSQoZhhuSwz2PE4gtGXEB?=
 =?us-ascii?Q?IC29NtgKChSXsRpywyzbf1qtloAviTgh7a4Xi/u/ryufPibl2/Rw/VUSWkqH?=
 =?us-ascii?Q?n7JhAv9/pUVBSViReEf+NMjVRW72el2vSmRY3DQVuiKiTw1Pbl3tMBWM36Vb?=
 =?us-ascii?Q?VerK8qwYG/ruP0TMi0nnTZva/Qdol4s6sFrlwj4lFcwTRkfZSZWLhGMROj//?=
 =?us-ascii?Q?LuAOOu9PJn8yZjdEaUGt6KaQNhqSpYscaoNHJxklexzcocs+lk5mgrEp8yFL?=
 =?us-ascii?Q?SIpn99VwI5fX5FFfDDfbUjK8eCar9a8zOXnp05XBSjKnXRkYQ6JKyHx38SC8?=
 =?us-ascii?Q?7XMbuDW0lIILyC+C8hu0s1yp63J4O9q7EoR5zFqSz4v/Kr5sKqErZu1BSfya?=
 =?us-ascii?Q?aEqTAy3CAG9+lnYGCTSFbHq60h9cWbLC1icZ0ah/P/MV8pCmSGQ4ecVbweU9?=
 =?us-ascii?Q?ZsUGChNvF5IkJsoXtaWCbbEWbfe0wQ6aD1iCIhIRMM/nEEaUeI+X30VW+NHN?=
 =?us-ascii?Q?zTveLjM0DFlRSucP3o8UKsFbanImEl7AgETkubdaCwCp2prdZu/OANsuFMFS?=
 =?us-ascii?Q?gletTES4KkEaqujzjwpT/YzTKI10kH0mPa57z7KMn56PBNRo8CFAu1u2pt+t?=
 =?us-ascii?Q?FGD7kh1mSEGv/q6Sy6TX6zpYzTYgvrHSTiAoXoldILVP/fvTh9LiJNgd3qkj?=
 =?us-ascii?Q?F5JimIGUc1vkSCwtggorqhBWxuv7u9KMCurdQ8M87Cxi7Zrfmvc0COBerZUF?=
 =?us-ascii?Q?Dryjrj5sFrqtC0pOdwMS8tLKvKf7mrdwyij4wyODE9jIU4oZynEtUs383Gf+?=
 =?us-ascii?Q?6Si49AuoQ4YyEHxD51jZJTstdLQefaIvQUpSCy4Xa3eEGuMZzxlezj8Tvn/t?=
 =?us-ascii?Q?97EZArKvehxhkcNm7QREiH0wtthCv2UlV0oMnBFG0m/2KHe/tm2TGGqZxZf6?=
 =?us-ascii?Q?i9jKWdDLO08+clhN+/4w/rhqmgCQ7qP0y8NgAb36WtIlklPtkuAwCvl5l4Cg?=
 =?us-ascii?Q?WNcCW7A2c2v+5CXUmkh5nOZEwGJ8hxT2WAnbrhxteqQl3aIvfHEzqlWGx9Sf?=
 =?us-ascii?Q?HhGZjjfZf43gh/HIQzhnd1NSXsUe7ZR3eH9HDIkwIlf4zZ8fP6fuD6f5JJen?=
 =?us-ascii?Q?DAQuQKdik3ml3lbp19+WXLvpklYqV3uBCb2j3Xixqjvv1fee8MQGKLMS7EKV?=
 =?us-ascii?Q?U+61wV4yArA5RNT1+oAvpw5DGpnAzeDw2uX3vQzeEDZSUuI4FGBsdPpfrwt1?=
 =?us-ascii?Q?VfneX0CSBSOUbpM2To0ZYaNR+G2fmG8PEa2plbd1uXHhg5BgLF5q?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3206a32e-c831-4892-61c7-08de60cdd216
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 13:37:04.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvqaOhYOpEsiCkOdMW/et074PvudrVfjoMEGSBF21hlL/Rz+R4Dz6gaiaT+QFeS45KmYp2Cub2sCgucs2PCCtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5003

pci_epc_set_bar() may be called multiple times for a BAR when an
endpoint controller supports dynamic_inbound_mapping and/or
subrange_mapping.

Some EPC drivers keep a reference to the struct pci_epf_bar passed to
pci_epc_set_bar(), but the documentation does not describe the ownership
and lifetime rules for that object (and its submap array).

Document that the EPF driver retains ownership of these objects, must
keep them valid, and must not modify them after a successful
pci_epc_set_bar(). When updating an active mapping, the EPF driver must
pass a new pci_epf_bar instance and only free the old one after the
update succeeds.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 Documentation/PCI/endpoint/pci-endpoint.rst | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 4697377adeae..b2f5ad147ed8 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -119,6 +119,28 @@ by the PCI endpoint function driver.
    BAR register or BAR decode on the endpoint while the host still expects
    the assigned BAR address to remain valid.
 
+   The struct pci_epf_bar passed to pci_epc_set_bar() (and the optional
+   pci_epf_bar.submap array) is owned by the PCI endpoint function driver.
+   An EPC driver may keep a reference to these objects after
+   pci_epc_set_bar() returns. Therefore the EPF driver must ensure that:
+
+     * Ownership of the pci_epf_bar object passed to pci_epc_set_bar()
+       remains with the caller (the EPF driver). The caller is responsible
+       for ensuring it remains valid (and freeing it when dynamically
+       allocated).
+
+     * After pci_epc_set_bar() succeeds, the caller must not modify the
+       contents of the pci_epf_bar object (or its submap array) until a
+       later successful pci_epc_set_bar() for the same BAR replaces it, or
+       until pci_epc_clear_bar() succeeds. Otherwise, it could potentially
+       lead to use-after-free or undefined behavior.
+
+     * If the caller needs to update the mapping for a BAR and calls
+       pci_epc_set_bar() again, it should use a new pci_epf_bar instance
+       (and a new submap array, if used). If the call succeeds, the old
+       instance can then be freed by the caller. If the call fails, the old
+       instance must remain valid.
+
 * pci_epc_clear_bar()
 
    The PCI endpoint function driver should use pci_epc_clear_bar() to reset
-- 
2.51.0

