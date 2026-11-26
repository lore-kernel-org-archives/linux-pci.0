Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795685191;
	b=Pc+TiMeSEUwfqJP1BoAv0k5zpQEv7oYOTWvU926Z4XOXDIsxBYTw95l96itACiRjYHwq
	 AAm3FM6Fe56ueih/MNbjVVXXoZJuAZ8D14gVcbPeScyFtG1YJHNUTEpMB/FwQa9nHH6HO
	 K1Z4YrbuuTKU7ZivZsnbXy/qaIi6GVaOtMm8oM001bdK6Ab+zmLN+fH5T9OVgCgz8I8y/
	 CgfvXymP4A+jyV5MEBFIRBvacR855dUnKUBNyiDQSNcV1Z2V94FWMdjFtfifWJkpznfOi
	 c/ppEDMvWQPU/0S91it/AvFOtl+vqVuOxBSvDzSTbaMsRCv/BiNoPFlTwhly7And2OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685191;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ACMltB1aI/o7cnM1qONfeOTnY+xGtSFDzNhxi8OmrAI=;
	b=Qf8fENYcZyTM2EgfPTppQip/5abu6Zx276YSOCwmaL8vQ/HAOTbvtbJaQ1KBPE9CsZc9
	 v32myrFuK02pQ+EfsXD6NYquDBiNJzp44tnFRUDSKB7M6Zo9ZACnts7nSNbhk2TmC1SQC
	 AKLle9rDBqUuF4aWAE8js5EBEjo+WwCrjOJqZtRo+xeDgY4G0ToQxWCHzRHlC5e0aYWpL
	 mwq60RrleRyGwStj6NL9SRLwrJs3Kj/6NsIvkBkzh2DSeItZ7b1uM+pNdMSHNSPqQwnAI
	 wlhn9h2lpcxjvda9auE8cEc6A2rltjks1LsTOyGXs+J9J1YK5IoWV60QHkoRSWLPpgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Mc5YWahc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.36
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012036.outbound.protection.outlook.com [40.107.200.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5BC606A31E;
	Thu, 26 Nov 2026 09:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C5BC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Mc5YWahc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MP42E3t8yCOmgJDqCShG2TQ93tFIDm6KmkQzY4qQ8lzouNOgxfjO/8CKxOosAEJ+5r+LwtCNnqYBOmuG4fDj4Mc9b06PywROZGY1DZWguyiq4uLUmbHxUhzEiyBdiQ+gZp6h1elAb/Ni0KsX8uOwgjrUHHI9xSKu8EJqsdS8LlbAvSIW1+xFj9T+SCWsrdhMPO3TNxmEU8rv4Y/RAL25cUAAEik0oeZxiqLxEOsOtBPeMqw0im4mY3XzQU3eK+Bscmn6WOzyN06h4oG82+aiZV1b+qDI19yBiZtW/eEvGPu7iBYCnZgZ6yNa5XdyVbheVk3hF2HvYqEuX6ffBC8Glw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACMltB1aI/o7cnM1qONfeOTnY+xGtSFDzNhxi8OmrAI=;
 b=BP/rH2o+L+kYcxoNknlhuTlsV/ZVU1uSQImu5UFgu2rIATCZPAy0W9UvuKe7jM0JMxSs3EqHEzoh8tRqmivNW3TW5bGFhr5ILpg1e6g+rGQAQl0zTnQflwU61gw1vnMrKA7Dcg/CLQWb5UzBUbh9wPuG+zPSfy6vK8+52DGHUYPuEjksuTSvz18QPcZwFqt3PwnM0/DENJj3ce9Xdujjx4+X/6/EDfI3a+3jyuQvQwwU8EA6FdR2RSF8FusiHXTnEmK1K+cepLu75VaoKlTM6j4HCtzoIh0/HIk0tFV1BnB3FLElozqC+JUFFVLwWekbVshzN+nQFSRJ+WFpOfX+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACMltB1aI/o7cnM1qONfeOTnY+xGtSFDzNhxi8OmrAI=;
 b=Mc5YWahcXQM6Rsd9/sXVAxO3PLQ+DuAnDi9uANO+6XyJWEz+8I+Ehh2f0tl1C0f5zIzR5hUjclVXCQLljBRr0xgXtp43nEU8UwbOT45DYjKWQJ/XDbTO4YDaxeMqIGAWckIlOIQj6UfNfwrSEftDwQ46F522gQAnxeI2cBhOqyU4VCRgDj08m/TmcgwAEyoDnGzKWxvpLBudAfuUkcR0ABbuF96hV7azONlIhi2s+QfSQ9QWNEJkdTrEvjqnZcr0Co4q+G/tOXKck0sNJpH7fS2Y08B36qG6r58q6hWjTcPia+4AbzR9yS0CefXa6Now4irmb/5v6JNyJMpZGKfhNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB903269.namprd12.prod.outlook.com
 (2603:10b6:408:40f::22) by DS2PR12MB759364.namprd12.prod.outlook.com
 (2603:10b6:8:403::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 09:26:26 +0000
Received: from LV2PR12MB903269.namprd12.prod.outlook.com
 ([fe80::29c8:652e:e2b0:4dd1]) by LV2PR12MB903269.namprd12.prod.outlook.com
 ([fe80::29c8:652e:e2b0:4dd1%4]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 09:26:26 +0000
Date: Thu, 26 Nov 2026 17:26:21 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, helgaas@google.com, iweiny@kernel.org, 
	ming.li@zohomail.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, tglx@kernel.org, wangruikang@iscas.ac.cn, alifm@linux.ibm.com, 
	shawn.lin@rock-chips.com, lihaoxiang@isrc.iscas.ac.cn, 18255117159@163.com, 
	xiangzao@linux.alibaba.com, vidyas@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, 
	newtonl@nvidia.com, kristinc@nvidia.com, 
	Benjamin Cheatham <benjamin.cheatham@amd.com>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH v3 1/2] PCI/MSI: Skip MSI/MSI-X restoration when config
 space is inaccessible
Message-ID: <awf0UPnO7jHwNydQ@MWDK4CY14F>
References: <awQJGfWYyqYCmL09@MWDK4CY14F>
 <20261125004709.GA1202732@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125004709.GA1202732@bhelgaas>
X-ClientProxiedBy: TP0P295CA0016.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::20) To LV2PR12MB903269.namprd12.prod.outlook.com
 (2603:10b6:408:40f::22)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB903269:EE_|DS2PR12MB759364:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d84a7a1-17da-4027-bed2-08df4b9f5841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|261026140227099003|261022105027099003|261022113327099003|10067099003|261026121527099003|261022075727099003|261102130727099003|261021123027099003|261102123227099003|261028144727099003|261021121427099003|261009223027099003|3023799007|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	u3ldEX7RpYAQZl71lwCNUnNwzlnIAtKRrVtzROlfg/Q07Nhy74F82+v9IwB8hb4Ez4gs8C5Z122DUWcaHMoBu/PxotzBgUlGmNayhuSZXUz0OOGGwkSwyPoHgMZt+ojk1lbN3k2WnkDeQT92D9PaGD5687cg+IfYAStKPJ+WbX04/vHd95683xW9YTdChmEcktKfG4yJf3rRlZ7JJwwIaCaiaWLLE+JTT5WvhFSQYZQlQVtW6R2v9PUnTB4KhO30PlnaXUXjUl6wP8A1/hah4vRCDMaE5Vwh4vMf1enipTBSsdFcWFJTZn+g0g/ScNmbleJMwaFzI6yjrCftnKGBhFTUZ7VeU770WF1/C+p3NLCCFCTMJtGUPmcZCISj8oRijz+Pu6kKfbaERT1Np5lA3hgumsM3GXs16AkcjF4YIIBQsjWKdBe6ndgjLNdIzxDYzX39JFwuhzYDc4nZ8s1a6jvMgg0toNH7asQ8zK1rOem8Lh26AHtWqjCTU70FL54eVOce+lw7j9TC604cqOHnzAtJd/g2DT1lyoL63GsnWepCzHjUtOnnewR4VmGas84GzrJPY6qEu6Km5585eXzjihsglVcGzatuJVR6BE/qHkR9vzUvwu4BP8M/2sxrD9biKXV72F+Zh9haKvo1fAa8t0VKkzOvl9ZptzG3ZpL7a8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB903269.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(261026140227099003)(261022105027099003)(261022113327099003)(10067099003)(261026121527099003)(261022075727099003)(261102130727099003)(261021123027099003)(261102123227099003)(261028144727099003)(261021121427099003)(261009223027099003)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ut88WUNSMXDK1hVtxni0VaCmO16Rqgk614FdgNzVa30zikryCNlXaWvttsI9?=
 =?us-ascii?Q?qrREmZFllH1EzVt4GXzp7ke7p1PhuFgXsi/oDykkeUXHOVyPiLd+Za7x9csb?=
 =?us-ascii?Q?dn88djgpXsdIbIXgXpr+9yOnvGk3mtIlMU9Q0z6z0pUa0P3B+UnA6YvY3J5K?=
 =?us-ascii?Q?8WxRkvmsjEReoazqnGv/jzL6MDvZvCzFMcnDyzUy4vtxZpKy+4oW1855MMK9?=
 =?us-ascii?Q?ZKw7mWu3jfH7YUHmXQfnNUzUxGTnGNoL3+CzXdVY1hpP5E7wJCS41qYxmgeD?=
 =?us-ascii?Q?C9HQYbuIuvtZBPMIQfT2buOZjazYIrOhi5GSw3R85kt5yn2D51rkZ10oDGRh?=
 =?us-ascii?Q?qbRg2a53WNStaMrVfA3zAPo1e9aKrjBahYN6NU0A19wi3t5tgKKBSxgIs6Q7?=
 =?us-ascii?Q?unzp4CaJ51Riltsfob0ORwgZkLEdFeiErfyYLh8ppaK3YS5nF01vQOcMC+H4?=
 =?us-ascii?Q?MpzIyav3lotg3IvotTmJ80AZP/oN8myeTTsmeh8n1UgGlkni3W09C9WHrrrv?=
 =?us-ascii?Q?CZVGI3jUVNmToomfohf71bdXTrlNXecCu5xsm+pPA+AlZoBtk/5+BuUdvQDd?=
 =?us-ascii?Q?q3VML+24QkDPTRzlb36e72SFoOaoJwFuSm1UArtrgi/9A6ePIGJbe0nQVQIQ?=
 =?us-ascii?Q?5uAq0kmuBDADPwvQjSVntl3oyAkaUyHB676WFGTBz7eG+Z+mdbczw0uNcy8R?=
 =?us-ascii?Q?SAEMZCnFr2dtliRiAf+k+bN/Tq20Uw4nlQF7Gth4fkineki6ttQ4JsBpaseh?=
 =?us-ascii?Q?JNlW/zln4ZGPhbf/M593IWf5+y4Hq0LCDmBNwbGweDWfnJ1wM1od7JjdGkT6?=
 =?us-ascii?Q?FluBhA4j9+gsrBGsXS9IGUzncS1LhkMzTTU8SJUrdvTbhVcyhCd6LEwnAyN4?=
 =?us-ascii?Q?8CLhVCyt+iLDZwRa/6MfD/JoLeKLFYiR9TpglBQoPjRSdA8tBdB9q8BP9fhB?=
 =?us-ascii?Q?wEMFgw95cPl+kw8n8+YD2Hwo3rRHECejlobGMrEHBjNa2jtd6W+zd/UsmQRA?=
 =?us-ascii?Q?FdkezYgrYsorwqnZKCVeVKrIsxla0EwhSCmd9Oa4XUltilGJVheycV1ZXXYM?=
 =?us-ascii?Q?7oo5bxYrS3trr/+R/wajLucNRgHETGwDkJDWnuXDhnGETrrMqbIZ5cWCvrT5?=
 =?us-ascii?Q?yTVhiHtP0ZOYWxsDMSeobv9rgzgNhOPr8IF0AuaxsNqc2clR5JDH/3EqBqU9?=
 =?us-ascii?Q?QOes7x3EnSZNl3OGJzR3BqSL8jgzjnGSMm2k7zBsqSShSo8vpixbxKBE0jmz?=
 =?us-ascii?Q?fMo0sTNj12JmJHggJo3c2VOwI96TdAW7rUtyRm1XrCOnUVB6LpzlPr3pbeT8?=
 =?us-ascii?Q?tJLORuM9c1I5o8WBaoQV6qqucjWNjwIbGo6aDjHBJRaEGZSf3D1yiZChv8X/?=
 =?us-ascii?Q?gw408W+brt2XkQIiINHlXKj6i3DXKBHgvw+DCItHHvFCknGhOJGlPyQy5yQG?=
 =?us-ascii?Q?9Z/SYKpLT5QGK39yrJkwCp7t6ilZR6fhyjYExCJTH8GkepPGlPM5JF5l/XQq?=
 =?us-ascii?Q?d1pIz4Rd5i2ZyEyyjIT0I4vXangU1WdqabG/FQ/3bgoWts9Nm/7UgOlstZkn?=
 =?us-ascii?Q?LTy36WgZm/Ci50mB+FCvfHNItYYYuRMnfLUafBrKxdjcUTVveg+Ag8M0rBpn?=
 =?us-ascii?Q?+Vfw+roFjGkGj+DH0fwavHet/tzQNHqhttSxwuSHWP0/h3wRJgBvEO0IXwuf?=
 =?us-ascii?Q?iDshDPBHe2QirVrwlwlHxIGV3eYCN8cDLMPdle6hGocENO7S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d84a7a1-17da-4027-bed2-08df4b9f5841
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB903269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:26:26.5269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFo6c2bhfPSAkoQbFLF7800pFCMUhuSMVA0f4fF9WYr01UkSZQLkZA3kVWuO7rmX+PAV3Rb2vfjCQVUxfBVZ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB759364

On Tue, Nov 24, 2026 at 06:47:09PM +0800, Bjorn Helgaas wrote:
> On Mon, Nov 23, 2026 at 05:52:25PM +0800, Richard Cheng wrote:
> > On Fri, Nov 20, 2026 at 10:39:09AM +0800, Bjorn Helgaas wrote:
> > > [+cc Ben, Alex]
> > > 
> > > On Fri, Nov 20, 2026 at 04:09:13PM +0800, Richard Cheng wrote:
> > > > On Mon, Nov 16, 2026 at 01:09:39PM +0800, Bjorn Helgaas wrote:
> > > > > On Mon, Nov 16, 2026 at 02:52:28PM +0800, Richard Cheng wrote:
> > > > > > PCI state restoration runs even when a reset fails. If the device's
> > > > > > config space remains inaccessible, MSI-X restoration still writes the
> > > > > > MSI-X table. The table lives in device memory space, and these MMIO
> > > > > > accesses can trigger additional errors, including DPC.
> > > > > > 
> > > > > > MSI is programmed entirely through config space, so it doesn't issue
> > > > > > such MMIO accesses. Restoring it is still pointless when config space is
> > > > > > inaccessible: reads return all ones and the restore path writes back
> > > > > > values derived from them.
> > > > > > 
> > > > > > Check whether config space of pci device is accessible or not at the
> > > > > > start of both MSI and MSI-X path, after msi_enabled/msix_enabled test
> > > > > > and before any config access, and skip the restoration if the device is
> > > > > > inaccessible.
> > > > > > Make the helper non-static and declare it in pci.h so the MSI code can
> > > > > > use it, too.
> > > > > > 
> > > > > > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > > > > > ---
> > > > > > Changelog:
> > > > > > 
> > > > > > v2 -> v3:
> > > > > > - Cover MSI restoration path as well (Farhan)
> > > > > > - Use pci_dev_config_accessible() instead of open-coding the check, and
> > > > > >   make it non-static (Farhan)
> > > > > > - Move the check before any config space access in the restore
> > > > > >   functions (Farhan)
> > > > > > - The return value of the PCI Command read is no longer checked, since
> > > > > >   the helper only tests for an all-ones value.
> > > > > > - Update the subject and commit message accordingly
> > > > > > ---
> > > > > >  drivers/pci/msi/msi.c | 6 ++++++
> > > > > >  drivers/pci/pci.c     | 2 +-
> > > > > >  drivers/pci/pci.h     | 1 +
> > > > > >  3 files changed, 8 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > > > > > index 8a0133a6a286..2865f73f5ead 100644
> > > > > > --- a/drivers/pci/msi/msi.c
> > > > > > +++ b/drivers/pci/msi/msi.c
> > > > > > @@ -524,6 +524,9 @@ void __pci_restore_msi_state(struct pci_dev *dev)
> > > > > >  	if (!dev->msi_enabled)
> > > > > >  		return;
> > > > > >  
> > > > > > +	if (!pci_dev_config_accessible(dev, "restore MSI state"))
> > > > > > +		return;
> > > > > 
> > > > > Sigh.  I hate the fact that pci_dev_config_accessible() is
> > > > > proliferating even though it's obviously racy.  Maybe it's the best we
> > > > > can do, but I just feel like we're digging this hole deeper.
> > > > >
> > > > Hmm I agree this is racy even though we're holding the device lock
> > > > throughout the reset/restore process.
> > > > 
> > > > I assume you mean something like a separate sources DPC happened and
> > > > make the device inaccessible , some scenario like that ?
> > > 
> > > Yes.  A PCI device can stop responding at any time, e.g., it got
> > > physically removed from a slot, a cable was removed, its internal
> > > firmware crashed, power failed, etc.
> > > 
> > > > > Also, this is called in the pci_restore_state() path, which is full of
> > > > > other things that also write to config space and will also fail in
> > > > > this situation.
> > > > 
> > > > Actually I was trying to cover the whole pci_restore_state() in v1 [1],
> > > > and Benjamin raise the concern about the drivers may depen on PCI state
> > > > having been restored by the time reset_done() runs.
> > > 
> > > I think you're referring specifically to Ben's comment [2] that driver
> > > .reset_done() handlers expect that pci_restore_state() has already
> > > been completed, and your "[PATCH 3/4] PCI: Skip state restoration when
> > > configuration is inaccessible" patch calls .reset_done() without any
> > > restoration if the device was inaccessible:
> > > 
> > >   static void pci_dev_restore(struct pci_dev *dev)
> > >   {
> > >         const struct pci_error_handlers *err_handler =
> > >                         dev->driver ? dev->driver->err_handler : NULL;
> > > 
> > >  -      pci_restore_state(dev);
> > >  +      /* MSI-X restoration may access device MMIO. */
> > >  +      if (pci_dev_config_accessible(dev, "restore state"))
> > >  +              pci_restore_state(dev);
> > > 
> > >         /*
> > >          * dev->driver->err_handler->reset_done() is protected against
> > >          * races with ->remove() by the device lock, which must be held by
> > >          * the caller.
> > >          */
> > >         if (err_handler && err_handler->reset_done)
> > >                 err_handler->reset_done(dev);
> > > 
> > > I think Ben is absolutely right that .reset_done() handlers expect the
> > > device to be accessible and config state to have been restored, and I
> > > don't think it's reasonable to expect every driver's .reset_done() to
> > > handle that generic problem.
> > > 
> > > I think pci_restore_state() needs to return failure and callers need
> > > to figure out how to deal with that.  There are a lot of callers, so
> > > it's messy, but we should recognize that it can fail.
> > 
> > Hi Bjorn,
> > 
> > Thanks for the suggestion, that makes sense.
> > I'm thinking the following for v4 since I got a clearer picture now.
> > 
> > - Drop MSI/MSI-X specific check and make pci_restore_state() return errno,
> >   check whether the device is accessible at the top so we can cover all
> >   capabilities
> 
> Well, pci_dev_config_accessible() is *always* racy no matter where you
> call it, because the device may stop responding at the next
> instruction after pci_dev_config_accessible() returns "true".
> 
> Checking at the beginning and the end of pci_restore_state() would
> cover most cases.
>

Ok, thanks for the suggestion, will include this in v4.
 
> > - Keep calling .reset_done(), and return the restore failure from
> >   pci_reset_function(), etc. Driver that touch the device in .reset_done()
> >   need their own check
> 
> If pci_restore_state() fails, I'm not sure we should call
> .reset_done().  What would that mean?  If the device isn't accessible
> after a reset, I don't know what else we can do.  Maybe we just unbind
> the driver and software-remove the device?
> 

Let's skip it then.
In fact .reset_done() is quite confusing IMHO. It's called within
pci_dev_restore() after __pci_reset_function_locked() is done.
It has an implicit assumption that the reset is successfully finished
and access to the device is restored, so I agree with you that we shouldn't
keep .reset_done() if pci_restore_state() fails.

And for the removal part, I agree we should remove the device since the
core can't tell a device fault from a driver fault or device fault here.
Though I don't think we should do the removal here, 2 reason
1. if the device isn't accessible, remove the driver will cause DPC
2. if the device is accessible but something went wrong with the driver,
   the device lock is still holded, so we shouldn't and couldn't remove it
   there.

My thoughts would be mark it with pci_dev_set_disconnected() first, so
later access fail fast without reaching the device.
After the device lock is dropped, we can remove the device, don't just touch
the driver since we don't know whether the root cause is from device or driver.

Does this make sense to you ?

Btw, pci_dev_restore() has the "device lock must be held" comment but no
device_lock_assert(), unlike pci_dev_save_and_disable().
I can add that in a separate patch in the serie.

Best regards,
Richard Cheng.



> > I am thinking about for .reset_done(), since the core can't just skip it,
> > like you said the drivers part can be messy, maybe changing signature to
> > 
> > void (*reset_done)(struct pci_dev *dev, int status);
> > 
> > Passing the status from driver side to PCI core and let the core handle it
> > generically will be more elegant ?
> > 
> > Once we decide the approach I can send v4.
> > 
> > Best regards,
> > Richard Cheng.
> > 
> >  
> > > > What my bug actually hit was MSI-X table write triggered DPC, I can't
> > > > justify for all kinds of driver, so I limited the scope.
> > > > 
> > > > If you think a broader check in pci_dev_restore() is a better place to
> > > > handle this, I'm happy to give a deeper research and revisit it.
> > > > 
> > > > Best regards,
> > > > Richard Cheng.
> > > > 
> > > > [1]: https://lore.kernel.org/all/20260929020405.9724-1-icheng@nvidia.com/
> > > 
> > > [2] https://lore.kernel.org/all/8a19d63c-db9a-40ab-a811-5d761252638f@amd.com/
> > > 
> > > > > >  	entry = irq_get_msi_desc(dev->irq);
> > > > > >  
> > > > > >  	pci_intx_for_msi(dev, 0);
> > > > > > @@ -877,6 +880,9 @@ void __pci_restore_msix_state(struct pci_dev *dev)
> > > > > >  	if (!dev->msix_enabled)
> > > > > >  		return;
> > > > > >  
> > > > > > +	if (!pci_dev_config_accessible(dev, "restore MSI-X state"))
> > > > > > +		return;
> > > > > > +
> > > > > >  	/* route the table */
> > > > > >  	pci_intx_for_msi(dev, 0);
> > > > > >  	pci_msix_clear_and_set_ctrl(dev, 0,
> > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > > index 7c6f2aba8144..671ffe4da1c8 100644
> > > > > > --- a/drivers/pci/pci.c
> > > > > > +++ b/drivers/pci/pci.c
> > > > > > @@ -714,7 +714,7 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> > > > > >  
> > > > > > -static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
> > > > > > +bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
> > > > > >  {
> > > > > >  	u32 val;
> > > > > >  
> > > > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > > > index 77efa4c5c960..98dd3dbd5edb 100644
> > > > > > --- a/drivers/pci/pci.h
> > > > > > +++ b/drivers/pci/pci.h
> > > > > > @@ -240,6 +240,7 @@ enum pci_mmap_api {
> > > > > >  int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
> > > > > >  		  enum pci_mmap_api mmap_api);
> > > > > >  
> > > > > > +bool pci_dev_config_accessible(struct pci_dev *dev, char *msg);
> > > > > >  bool pci_reset_supported(struct pci_dev *dev);
> > > > > >  void pci_init_reset_methods(struct pci_dev *dev);
> > > > > >  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
> > > > > > -- 
> > > > > > 2.43.0
> > > > > > 
> > > > > 
