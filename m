Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012048.outbound.protection.outlook.com [52.103.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F36A55C1A2;
	Tue, 22 Sep 2026 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089414; cv=fail; b=XbEYzFvCEa1huOMyAupz+AQXivvD/TQ5OZqebnI2ErvS6e6xWhR2ec2tjriJLUgxi+DWcrHodTDIc1o1B/TBjComuUITcFW0i+WfPynCX1Ae01PhTernoC3VkdIaWpiRIiVczEPjCaUsfg44mmMFvBK3/pE+0Vdvw4Z+W6wXUFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089414; c=relaxed/simple;
	bh=bq55dgaNXmcVa8ObsGENNxiZPPGXCcZZO17GotujeGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TasB7lxNFU7RRGfswQFdNaXhqrZdu1sCWFjaEKl+vbI8KjSk/QAD+2Mcod5TOk3HA+6ZXoORDBhmz0NO/ZbyV88F+InqOVLPLggOlkeZu9H9YJ/8fDYABJDcZD5d2y6PNBmXTYDc3uXdgx/7V1z+FW9h9Y7gWzkj6bpPCTplxb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=BbToBSer; arc=fail smtp.client-ip=52.103.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="BbToBSer"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+N8fDk35e70eFGPxxGGoWDzckg4mlfA1OZ6omQGYkPMmiM3rY3qtecBKnrZd24QkDVpLWx79fuM0ubfKpeUtnpaQkWzve0kX3fZgvGpcir0w3e1PWetBBcuYS03hcAKb2OXKmnbLhLZ1gfPY75BRsq52lonxz4rXkYQ8vp2kR5W+vhLYA9p6+5maBXP1Fr8BcZWlJW7IgGMorc5V3azZ2gc+2LqQR2o7wt1md6aHL+RIlfq+L+dxTSoB+reFzmmoQ3wiI4IWoy6s+e1SRfaI5JNZ4ex/CRi2OAOThzKD+grKMJEjw5hHOCUwdCVvt069NejuSuLxEeb3rmdWQ+CyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXak7RnotMEeCurkkIUUO5qb8XvPV/JUbSJ7/kEMf8I=;
 b=lan4177YPMUxrk+22wDdMQBMxTLEyhWpBhxWdZB8NM4+1NXPmXlYhkxmwcqc1ggCcz474ez/JeSH9y1kpROYAOqr6tZIEnuCznacoG9gP0qnz/YNRnt6V+ud8BSHu1A2ho6GXdJZa9yr/8NddxtM8cJEtfSHI5GF7rocovuGXOc5QTQg2R+eZxtmyGgq3um7jpAc3hI30V+gD0NfcjonZUcW7+SgTBsDYF+1ZbNuwXcqJPKfiTyxSVJtMPUvrzmvGiduKoM1D+xGWh2hQlkigcIyvv76rcbNEwRUb+LLxYMTCmoDsPOM+1RbYYu9DSyv/xMpJ/XhOX7EEn8a4E/D/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXak7RnotMEeCurkkIUUO5qb8XvPV/JUbSJ7/kEMf8I=;
 b=BbToBSerkIFLJpSJkarL0yXWsJtr+b4wVxVrHSgk58c8WXWkEXqnNIWbsy8OOeTMTHX/CjTyr2hi7xVa187bAbZW1cxlSqZPcWIxs/G6sPjNfwSuDOpjPe+cV8S9wyH4xC6mC3eRK5yj6Jr+gGi7ObidHzi0DLYVux9AZ2jyrpBq3Lf3ATv8uozFPAfykJaR8CWmHRMwAfv8vhy3EtawAou19gSz75u30w4zIvB9cB473pH5xaELKZM0oBdZsbyYAIA1zheoqcSjbiSarIlZNO1BHZBXRJsaVWz1nnB875bj0Ps1Gk2fAEvNitKgg8ZNV4fEyizqhL8zrghZ1GbHDQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by SEZPR01MB5711.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 15:03:26 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 15:03:25 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: bhelgaas@google.com,
	jgg@nvidia.com,
	jic23@kernel.org,
	error27@gmail.com,
	kwilczynski@kernel.org,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	alex@shazbot.org,
	kevin.tian@intel.com,
	manivannan.sadhasivam@oss.qualcomm.com,
	ben@cressey.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	wei.w.wang@hotmail.com
Subject: [PATCH v10 2/6] Documentation/kernel-parameters: Add multi-device config_acs example
Date: Tue, 22 Sep 2026 23:02:54 +0800
Message-ID:
 <SI2PR01MB4393E6DC55320F9EB44A9092DC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB43935D2C01946E6D8FD9EFAADC832@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0017.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::18) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <20260922150258.3087572-3-wei.w.wang@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|SEZPR01MB5711:EE_
X-MS-Office365-Filtering-Correlation-Id: 0451abc6-7c77-4ba0-8481-08df18baa69e
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmrTkIzDOCxR6E7nJ4I/6XZ7ZgtliWojagIXGl/swxQkOG5ulmVhdY8edFhl5xvhfP+IN5Y1pk78UYLCs0NC7SoWwCcrivgTxLAmwijt3A/qWpvMvA+RilIZpK24sCw0sCMs5vksafyQ0JZgcs0cAM51wIrqealdrQgRUW2IRA6SBmLs/kHxIewujGOSAwjCYZiumELgRUAdt7OAFxjTtnIqZ3GGh9XJnPOnoEdqbiiesgEuD0NyDEaSqzFkoK6HC9pTj4H7mWGtwca7WJobybIehHV1DO0Pr7jpzVpOon0I8JxuXJisp7eOz470FOiTVHEHP8hQGD71yyGarEN8md1NMa8CTq5WaXgPYqKpNNKqvgU703ZWMDB0N8tBW8d/Yr1tThuKVJfKTYgw+aQhxPhz4q9qF35cDLJtcEApx7vrldbJz6u4o8BQaAX34H9AQoTgOyQg0cHB94Tit3HnxAdGYRk22WKZnpL72LqZDUyxyhooTMOlZHE4SESLiozuZV82sfgn2UOQIh1vDrSKzVhEdIj+jO0/o4eI2cqM3FKq3RR55JPVcC84UpwOMyu51soph9vUIb/KDmnDHn3fVvjkJAAm/Tk/ibBuzixvDGQ56SARCjMqWoYwpRtBlu2zOTqij3+jNscotMLUyVbteOyDsmaLK9sBtUC5CYj+IgKo1GaxBZciXQ8wmwYxGXvxB2OhsrS2I8gPPhjYOs2LXDumMimoaOLGAgnmT5QMTnyy3nGOqxRIHiE38Od8fJBhvrI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|45011099003|19110799012|8060799015|5072599009|51005399006|7042599007|37011999003|15080799012|25010399006|23021999003|3412199025|440099028|40105399003|2607281247196008|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GMHY+NX9WK1ldt2M3M+N35TeqYlEKy2yxYcuNZSNStYCFKnF5jJMdW0xRUso?=
 =?us-ascii?Q?dqFvTkycm5sm4+CwaLxqYXZRnmHJLkb987H+CC8bq1TD2+ILH4dy8wafaFk7?=
 =?us-ascii?Q?4VL/QgZ3yQfqtpZdIU6baA2d+Wf9fMCWc+gVizyYzgbEV+DUth8aqUHWUIr0?=
 =?us-ascii?Q?Y3R9BJXeS2Tea/zQcbbOPyCktxa9xo0JALhwnh5r/ZKLs0SkbykkfD/AHvD5?=
 =?us-ascii?Q?5AoF1ATjv8OfqsMX/mXGjAPi3XadH1dAi7x6ubrKaHHzQ9rt5C8sc3wUx9Mm?=
 =?us-ascii?Q?awWm1BgJznyMUhxf7iHRvMS2ZJ5VvJl1Mwbryespn0jqMpnm2bB2CvMh/4Qd?=
 =?us-ascii?Q?Q0Y5X4uajBvC0sHTUovNLovEQi3JxFEqsz1TyuS5k/wuEdSA0oKE9iWVRIq5?=
 =?us-ascii?Q?sT70TOk3EJ9mAE88TmeORorH7gnNUANfF/F/btavfoLJVqE2YAYIqB6LQDn0?=
 =?us-ascii?Q?MfDBVvWBtIv8Lh1NPHoUx9SxSj5bjVe93bFeVT8KILBOOF1iMr8aCt2y1eh6?=
 =?us-ascii?Q?n7hRDCoE6N+eVuz76YwAaeaSC0cmQfUM0bAzua/yPzxPF6C8UOktKWsSpwvb?=
 =?us-ascii?Q?GYe7gJenCZMuvQhGKj1MmSJe6XOUXcxqlTXnZY7d9DrV1KR2/l67MQeMaGjK?=
 =?us-ascii?Q?wIohfG0ZSvB1FKzUXXrOb1xBQb4P/GYBaf51kI4yhlOh1fJzfZLRHIbtfH9r?=
 =?us-ascii?Q?zVOF6bx9jxIyfHnN8eWaCcFXWdWy8XKXC2RaFXezHRHWyC1nuAJfF89IgSv0?=
 =?us-ascii?Q?HSeD2RL+wHbrqYr7bxqfAhj0+sMLeXyef6gNzZPogmtJ5jISPdgIRSu9nWH3?=
 =?us-ascii?Q?unuYnCzv1B5VW41Zb3yxvrFiHbTu70VR53xuDKsFBQh5+U12Y6zIwwHBNAoc?=
 =?us-ascii?Q?IQxcC71lG04dl0ktVeMRBlxt74j0Q9fm83vxg1Fc84qIxjCdqCTEfh+BvFoa?=
 =?us-ascii?Q?wT7eerNXNLWxWLdlx5qydQD1KO2ZlUlBAywOxwTqHe5nnbdYlPa8bqiFPmav?=
 =?us-ascii?Q?ax+eHOafuu3DSC1J5hKIpTMZ3g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ryNh3tSSgfobk3Wa8xsbyP2DY3fYGCj+mY0WPlhJBlIgX7sFsCRF7EHT+wG?=
 =?us-ascii?Q?s5PqtUFO7n5zQdsfnIhKT0V9S20pYO6SCdjrorOft7PuBNy4lV8JFTX+9cR/?=
 =?us-ascii?Q?1gEStX1UPa51/JdkMLtdxk4/Hzs6l5RlwyeYgC6403gSQ8qXOFPd4Dzh/7sn?=
 =?us-ascii?Q?QmgfxMtKUNFOszBtgt+jEwjmaA1SEnkhU5OugScnR4XGl7uzhUL1ya29ri1r?=
 =?us-ascii?Q?HxGOKg+VQWBj/UsW0+vwBrmlMXH5vky+faIFbKZjXYoKsDsB8VeS/MdTbDTP?=
 =?us-ascii?Q?m6RCAjFUP9Pwvu8OsuQ6RJOTEEZG9Ut3i+b2JiFmLys8phScGhawmYvyX6YO?=
 =?us-ascii?Q?nISMNYPWDYRaV7mXGbeNAqYb2ElQIMAarUtBBQTJFGxUA2l6RcLs6BHLbuo2?=
 =?us-ascii?Q?LVrVj5k1qUrLyCIWVL0HOwX00wjkyCyr19PqFIqeMD7ua7e3jelsoRgl9QEl?=
 =?us-ascii?Q?18mNUmA6yqfzUZv0sUyU2MCDhq3DtPUytcONWUemeHPrKv6FZnsKGopoIxZp?=
 =?us-ascii?Q?n10Q1kW/M2NAkH9oBy+v0t87XMvZPZfWJrcLukNreji78CjrWufsAyD+eD6v?=
 =?us-ascii?Q?G80U292e1EDmZTHLeMopWDBIfXGP/tobYVRIeu45wYVCA2LmITo2fcbu2wtu?=
 =?us-ascii?Q?TiBIkqd3ELPLh9k2UdluxnlBCVR0ecZayaxUQL9Q9CfZ99JGgJvJE4tpo4vE?=
 =?us-ascii?Q?mMNL4IAJI7eupMIYnsC1wr5yTc0PUT/KacASvhRu1v6XJhPGPVm4amZ32vJ/?=
 =?us-ascii?Q?FW9cLBiTEfWMyZM6uTNG/gfb4Vzfc+rAMAw40mUcWppyNfLwmZYE+RLu7bQY?=
 =?us-ascii?Q?UG14MPHmpxyxmjF1mI1coCpM65zJu9cTS/4+28SNrtSCc5CU76xyjPaAl8iz?=
 =?us-ascii?Q?XA8JGfK05Ww0BcHjRnBzfycL+bcqIcuYJCgUJJXFpZbemDFQHkoRJYRyyh9y?=
 =?us-ascii?Q?7NEueNZYyacwvHqBgIxbLJXZ64tKQDXJMqg7M87iEgwK6bPxLCCuEo+5N2pN?=
 =?us-ascii?Q?cZaii5x9FI3v6fUuhscEI4ABVVBapRRhLxWSXjSggatLxW5vqCVO8eDhAVaZ?=
 =?us-ascii?Q?Fvl6Oz+bXNKkJ4bSaiIi5kMmTJi+usRySyh4PnJwmorNLUQmwqcNq9TpOqCE?=
 =?us-ascii?Q?0x64LRhV9tdjg0fRBpJnYQriJKVnXY2oCyvQ377tCtkcnZVKu34xprAXJVbn?=
 =?us-ascii?Q?MZHKVj5bSdlSWslFfD9tH8BySnHMOlJGgfgRmTpvoql/YSTSuaOXY9Z6K/wM?=
 =?us-ascii?Q?ka+DNUegpOZHmpnV6N0ytOx5gfP4rvzHGVd+RDbJuAhDPbwhUI144LUHd6AJ?=
 =?us-ascii?Q?wz4aDTtZaHOegu7lQs2uWGUkqrv9wTH6/JAotKP7mLdBoBcNKD0wPEIcEoHy?=
 =?us-ascii?Q?rlrLD15KDSNxVM9o0rUCMsr+G3ZT?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0451abc6-7c77-4ba0-8481-08df18baa69e
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:03:25.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5711

The config_acs parameter allows configuring ACS settings for multiple PCI
devices by separating entries with semicolons. The current documentation
only illustrates applying one configuration pattern to all devices, but
does not show how to specify multiple devices with different ACS settings
in a single parameter. Add an example demonstrating multi-device usage
with distinct ACS configurations.

Some bootloaders interpret ';' as a command separator, which can cause
the parameter to be split as multiple commands. Document that the entire
parameter may need to be quoted to avoid bootloader parsing issues. This
avoids confusing bootloader errors such as "can't find command <BDF>"
when passing multiple device entries.

Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2041dd9a8f18..8c4d3aa6fc67 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5352,6 +5352,13 @@ Kernel parameters
 
 				Note: this may remove isolation between devices
 				and may put more devices in an IOMMU group.
+
+				  "pci=config_acs=10x@0000:04:00.0;1x101@0000:84:00.0"
+				configures two devices with different ACS settings.
+				Note: Some bootloaders interpret ';' as a command
+				separator. If so, quote the entire parameter to
+				ensure it is passed to the kernel unchanged.
+
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
-- 
2.51.0

