Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C4218E91;
	Sat, 14 Feb 2026 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771097631; cv=fail; b=nHOFgeWQ3kg514cONuf2x2GVJD7bD35De3FUs8PeFhNpmB11I28ybXeCzTyVjXSGhdwOSFi5b3U3EGhcVjhinKigxAs6WzJL+noAKUJleLAW2nbrTmPUE1ZtaAUJRpk6uHa/0UwO3VAA86pAX+WBo092yT+WwrqrcfPwxP5gJJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771097631; c=relaxed/simple;
	bh=y9eHghgQYCv49dOSB3sPR8PksjJ2vkFNHoOPZOb5xCE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CJ7vB3DztgjRhYhK80s8wgqr6794DDWOnkaWm/ax1Bwe5V376N6ZMWQPfm0IwJe0VJ8k8f4KMPyxzXnl/2sJuzD1Gpvo8iwlD8vuXcWMTZzVBkunJCNB+M+Ayd5uerB7DYWoQYiy0Q6bSwRMKocAnTO//nEFPuqu76cGWtIAqC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=DlFttlJ0; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="DlFttlJ0"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61EJQdMZ1036336;
	Sat, 14 Feb 2026 11:33:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Y0XH+yVsg
	Snbi7uT6ewrlGhq2SQcHnylwW8p1+hl9lM=; b=DlFttlJ0B92F8zsb/mxZx1XiP
	ZT9Xqc8XLII8eosJpg16HXT5FKQUBaufDNpeqfMC3sQf3tOr2Q3yVZPRAFLxsWnR
	oEJlF/vCTZgrMykgquUyPv5qiHruCYgL4uhct40dN0P1W0auVm5AoGgOpmemZUgA
	Irb7xk2wrxD5lERbpRScBDBCvqvPGLj7bvNfF0GLUU/X7OtXX7ADFmugwBEFvjly
	ikt0ShB+PBZcKFcJaS7tsroW94jtakqNIHztP3mJcGvfPPaPmLuJN8Zr3NF0QUmd
	f9jLb7+gBpBB1iZClMyJStPTNniOlOsjQkUZzTNQ2E+UTFhliLRGmuttWE1cw==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4casehg6js-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 14 Feb 2026 11:33:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma8RFBBNq/rPZBPxDJHndmWXUGpPlFF1mf68YoAc1xsVzLtpBBcqeWPJfgUHccEdX4Q1GRnQseH92yoiJcm3dFydne272Xq4Vi3WmNY1TZbMNuV7OMsvoQUY8LElqV175Wif35uTfJdnh9IR7giRNai4Ld+vqDMF4BO/5djIz1qJWbvTBd3fh3iIrTvzj3DPzB79tiRqLRfjNEpcmVSZ5Xdypd5NK/mWKZr+o1rnJlsnGdApHpbvOiTJB0JJ6LZo5bVhQukSweVGChxUK9E0qQOGpKGADQ/eUOxlLo2MNUYWTwRw5UJmyQQ/ORJojDfDOA8p6gfHlnsykzoRCJFRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0XH+yVsgSnbi7uT6ewrlGhq2SQcHnylwW8p1+hl9lM=;
 b=Pc4OYRGaCE/J7Nj2fg1v+MJEz9TrW3S3IdQLFPZcPCAuYZUHQNZeFRZZZLulfKCNpLjTJ4bRfUu70GcWcWAiayRu7AUcZTUAxFV+/Wngv/L0CweVSKdbJp9bmcECUtUiuVYeljw1zZoT5kKIVvgh/8CG8+KICfv6bjLzTMpg3nX459EAJBR+kJpqusXXhN1mApfWh7FBhugHsub3GMZY01o2gDxVCbr19yZLjyTQYBEX4m96Ec9VPb0hZ65wpAJRd4J8mZE6sP67rVd+acaCZLWiBEcOFqCR5FqkRe8xccSbzY3Vv6cI005YzY0tBpBbDlN8ZP5NkPux0SmyN2WURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by CO1PR11MB5044.namprd11.prod.outlook.com (2603:10b6:303:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Sat, 14 Feb
 2026 19:33:16 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9611.008; Sat, 14 Feb 2026
 19:33:15 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Sebastian Ott <sebott@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
        Ionut Nechita <sunlightlinux@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v1 0/1] PCI/IOV: Fix unprotected sriov_del_vfs() against concurrent hotplug
Date: Sat, 14 Feb 2026 21:32:35 +0200
Message-ID: <20260214193235.262219-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::14) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|CO1PR11MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfcb12c-bd74-4236-c5ed-08de6bffe5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|52116014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4mZmwqAU8j4yDv82lPpieCwdRLTyWdlwuA7MebCILRKN3rHnTvImKslw831O?=
 =?us-ascii?Q?Wag+auO1rdneSif7XFLxWlVIJ0ITDIn/WobesAl/IY/HV182sufnWrnfTKil?=
 =?us-ascii?Q?rfA/WDfb5jHQCEsw19U3mFJzZzlgLyC/P+Ng1McqBBxMbR4ovBNz2ZL2HCBd?=
 =?us-ascii?Q?DLSDIJuKW8GV0Qu//L3OKlimbgvCuM3UPwEkrSj8Nn7f2w6AOwI+TW0NB6u9?=
 =?us-ascii?Q?VH9we6ME27kC4m5bYpGhqm/VH01Mq+ik2dKjlZ6vg8lR+awQnecXQ5VVafgu?=
 =?us-ascii?Q?JicceO2W6bF4YW+/zMmP09HI0H7I+Yb/fFSD9pb3UNSbcrWJDa9u7uvlV4de?=
 =?us-ascii?Q?2vG5J5fNRstfffsI0z2oyn6uRQXBirY9JUTwDXMieGsrRCce8UumhFOpGF4B?=
 =?us-ascii?Q?KCQSQodSRyAdmJIb18MuPruVUhPqhvMYuwmbcGgTHkm5BASl+Wh4GER65Q1G?=
 =?us-ascii?Q?EQGQzyITMzeeLedGocb0baIkiRSQgI05/z5HypDd3arDJSVVlv/EMlfbbuYP?=
 =?us-ascii?Q?jSzG9KYp6EPXrR8eooGPXPh6rI+5Zi3HdDS18RLGIlIPqn1V9no9qKGdl913?=
 =?us-ascii?Q?0mjPtmBNj3CPBUYYrON7E80YhmxEqXumYV6na38h+FUO57q8tiUQXGnUQHcH?=
 =?us-ascii?Q?VYCUpSFXp4UCiCmwmdyglw3SATqjSf27UhO+zfOKvEjdG6QRxGJM1H9T/0ph?=
 =?us-ascii?Q?TWCjfEDaTOlUBPTKMSUb1SiF/LysPf/1a4bstBLfj9S/wQTnmkNckEbaTbEb?=
 =?us-ascii?Q?nynL7EqDjHxsHqg3dXbPOGbvlbHZSk2SY/7hpUpLvwWCMHappdFRObsde0hy?=
 =?us-ascii?Q?ZO7zosdUg4+3vqDpW8SY8bGYvWBB1a7VhtKLeoYnELWlSEY2ewUhpQmVhwVV?=
 =?us-ascii?Q?pcFGLDCCUmw1BiL3vkkNcVf7alinHsfs0kFsKblI5I3XfslkG514YRy/BM7n?=
 =?us-ascii?Q?qCwYAOQHfXSN7iRjrluSYFC/EzjJQFqdHzMM2ZeJZbIH16fLAKG96OTMND2r?=
 =?us-ascii?Q?4ZLOLEn2fhxxTRpbZ7WDxHrPofdUR85Sp2Y5AeCKwFReW+TGtqOz71/gjxga?=
 =?us-ascii?Q?HxBUb+P6FLNKJK4dD67a2Ny5uWc9qNJeNkIW/dtgV6zu+deaPxrBAWYkqiKK?=
 =?us-ascii?Q?IIsX+7y8MT/kTIw9pKxWzcKKWVeq16LxtcVRfQHWpJfMiIx0xviQ2zTB+wBS?=
 =?us-ascii?Q?PNlaBFGMMNQAVNfcpkW/tJmSEM7UJrihzQrW71lZq0v58E2qmMR4pVDvVKza?=
 =?us-ascii?Q?Zu0LMLCbMuM6BsJOb+iQwhC0vNQVLnnhH3Fq+VVSbMpHsDYuR2dPDLxmJtj0?=
 =?us-ascii?Q?UMjXc+Xg6/unu6WmGMmwh4kOIWV2Q0y9ITZW8mKHxRtwTFaae//glPtV/i8Q?=
 =?us-ascii?Q?HJpzKDAbOd2fMcyPAJpxfglR+FVGFeIzaHB8J+KYM3uxouHD7W6nyOXdwOXe?=
 =?us-ascii?Q?WysYISD292+532d+h9unDTNBSiY0o2FTxkIv/RzcjEPDgS6c3XoEj33VjVPh?=
 =?us-ascii?Q?/H1DngFy5SovUGSuQ9JFB7ZG81wNUqDpHK7KlsjClwjjRkid1NBbc0bS7SnY?=
 =?us-ascii?Q?9D7SDMzAKBBMnYHBazs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(52116014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?glJ75mgwoBXOD/GgZJsVfaFysBRA9rzGZ1Kz544sHDuwz1b8ODz4gLjoUPFD?=
 =?us-ascii?Q?xUaCHmyWDZJySnoWgpV/IDOJpcT2e95aW6RqwhXGRF2PYtVFOrSQRMEvopsm?=
 =?us-ascii?Q?SK0J/VPP3yxXdzWwBSLqpoqnzv87aLnWp4oVGbWiurZLZsg+TkB6munRGhZC?=
 =?us-ascii?Q?0Wgwn/gmrwsys50HdQIZ7SMZvp6CuDGDGFsNgIPwN/wPWX5UIzeNjepGxwp+?=
 =?us-ascii?Q?plmMmQU2MnjVuSwLeDh4OEUfH676PmU8szpli1/1HGMBUsDB+6fjpPvEknq3?=
 =?us-ascii?Q?YIMZwIchQEsIQaHo/GAOW9fnWRLzXEuezSW2lWdvCeqCVTSwrehpFCDvgubG?=
 =?us-ascii?Q?izXIVWmNZ3dgfVFkVfHJyDK3GnRYsqm+1kfF75r4pK65T6/fngMXgIEHMLz5?=
 =?us-ascii?Q?MyWVRU/0eEjUIeZy+F8KOVa3tdOe6sy/onZgKpvBnLbU2aWJQIblKV9IXCK1?=
 =?us-ascii?Q?ZrPcGg+SfM46gcC2JF36xImL/yW9Y1DekE6Bxon3DmdT5K8xREsmeRXggiKz?=
 =?us-ascii?Q?D0OciluPTDu1cTvWZ71wV2HizdKdR3yC/jlb52UyZWJmgTtkcq4LQ0aFHha/?=
 =?us-ascii?Q?f4QFrHIggrLEiwO0CGIEgqNdyMfcN8DS8+Us+/cJBC3T488A/YGTmo29XOLE?=
 =?us-ascii?Q?vpxmlqOaINvTo4TFHQPzYPUZcnfuCu79txuCDLZV/N573nHeK4EcZN+Iv4OE?=
 =?us-ascii?Q?MTZPbbl33V8Jx0Is3tBiQ4t5yE4//OYxBJYY1DN5DJYkFLgX1uGcR9jiunDA?=
 =?us-ascii?Q?LlulbkskRZ6c2+QADoxkArrXBxwxmPvxvHOtof+cYc4Y80HmBzsFn508204W?=
 =?us-ascii?Q?X37sOYm9awrI3lN5Snw9plTph5Ur+h1lJ43gyobEXLsPi70jIGQpC7eA69Up?=
 =?us-ascii?Q?2bokxmcoQ+it7I7DPBKpPBDtvw51NhkMrnK1Z5BWQ9I/ziOfeXy/f/usag6r?=
 =?us-ascii?Q?dwYu0ctJwlue1J+mzl5AMK/kzXp6Hmht+asgn7VKtnT9i3FPS3are035Uowh?=
 =?us-ascii?Q?Xu+33zYQO3cUmBA/0RsWyPeMCXA64EwrNY1nBVlvs58eSSkChEQoCSDpHEmo?=
 =?us-ascii?Q?GwFRqxhTTJifmvQGaNdUBdiBZGkqTdk6+5Tc2Cb6C9UeFEOhF/F8HiFJNm0/?=
 =?us-ascii?Q?TpE0jEAbnYWGqJgmhMgWEL72a6gPVsw3c4QXklpGnN+Zy3d7ayryvBZoqoqg?=
 =?us-ascii?Q?8m9jSqW4gb5RqwpmjCYXs+j+BZkIEZD41rV5dZWUxbCsZaS+J2c5idxM7ncX?=
 =?us-ascii?Q?KYHSIWneN4QWzoAUt3N/mLVP6wtH3t9MMD7EUFw/7ljIsv5J6jzv3ajiJVdV?=
 =?us-ascii?Q?j0tiLBuZGMqA31W/6kimZ0Brg56VChnPqj/PaKXPjfKep3GlL2wkZ4r4nS7D?=
 =?us-ascii?Q?zi2sHM+75XUA5+LY0kSCFf1t2zxPi30HnK1B0cnIwbjP7SHFD6nQfn74Efy1?=
 =?us-ascii?Q?FnSXQEQbm1EdfVNUjoE+8L2ICgGE4EP3BpYe32w8ZMl94cUzN8RaWlc8xVrg?=
 =?us-ascii?Q?Kd0x9+6IpudXAPyX1MdvC2Es34RogZmFwomUzccsLQjBFfzSdh8EBi6TM0IV?=
 =?us-ascii?Q?2b54VwPgpBCnEb7uCtZALiFaq4ZAl0rUneL8EZvKCv9TK2x46qQzXNeZQrhC?=
 =?us-ascii?Q?dNDJqx0Y5Kkk0/aEAVi8zmZTd+n0zA6goxuIxUF4Q+gWjWBsXzllt8lRsgpt?=
 =?us-ascii?Q?K7r9WM3kVEiVRYbrt601wE/hegL7PxY0tKnr0AUrR5U/7wSQNC5Zyv4qjzWq?=
 =?us-ascii?Q?1Qcce6k31dPwWx8qTYCQ1K/drRWP3uwu1grKNcVr5M0mlzSfDlD/DHpdWAHp?=
X-MS-Exchange-AntiSpam-MessageData-1: a0izCnbHIA4nTknePqW9ucntK9jBDoRSiBg=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfcb12c-bd74-4236-c5ed-08de6bffe5b6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 19:33:15.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ByBJ8MX4N6A80qvAsTze8PL+4XioRLbwAyZq2uNS4LbGrTSvLnpemOuexASQGzGxqk60xPT3Hftj0bPe+jth65EsR7sHIB6p0fNd1dpDos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5044
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE0MDE2MyBTYWx0ZWRfXwCwE5jT4auY5
 sAvadzrffbeqrfiy66p+Ag2RE2zcsro2vEuIou7ZUROxsaVj07dRU1keYOep/rE6bfs+PD4lTbi
 jP7ryej+qmbQRnzFBRJ71XwTTUuTFyAG27FTX87jxe9U7eSo81eNaomsd1h9t2RS3UgJ8/TFSHh
 kuDI+KP4CHSJM1xCGQT81jnLTYM8Mo6Bi95XH4Iw28q4d9OLZzbabKvbltTMyRZ0EUeDML1eo8Z
 1sUXJ73SgKhPolKaIpm3wEybhGyq07enQBv9hah2X8vkAWZw/1gE0reO3/u/pDPlZjLkkmt4pAR
 IhYX2gL66802PP2IyjtKE6vmOQvYD1lgtIXpWFwNzGspRRUhM5Pu2GdGzGIXLHhOXKBUnKVM5iM
 kShF/jJMevrtNgM47Acj/nvzVZpPSoiO83InTEPlutCRijidt+F6LdrF4muEKfBJ/HigXMMDQr5
 SbXyITYtSuT/uMURFkA==
X-Proofpoint-ORIG-GUID: HBXQUoklvKEclTKSze9Um1k-N7mLFVcq
X-Proofpoint-GUID: HBXQUoklvKEclTKSze9Um1k-N7mLFVcq
X-Authority-Analysis: v=2.4 cv=Fek6BZ+6 c=1 sm=1 tr=0 ts=6990cdfe cx=c_pps
 a=iFPpiVoc/n5aJfOMV5u8/w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=t7CeM3EgAAAA:8
 a=cZ9Jp4uzYL4eHP-_sTsA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-14_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602140163

From: Ionut Nechita <ionut.nechita@windriver.com>

After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") and moving the lock to
sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
or manual unbind) that calls pci_disable_sriov() directly remains
unprotected against concurrent hotplug events. This affects any SR-IOV
capable driver that calls pci_disable_sriov() from its .remove()
callback (i40e, ice, mlx5, bnxt, etc.).

On s390, platform-generated hot-unplug events for VFs can race with
sriov_del_vfs() when a PF driver is being unloaded. The platform event
handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
leading to double removal and list corruption.

This patch introduces owner tracking for pci_rescan_remove_lock via a
new pci_lock_rescan_remove_nested() helper that avoids deadlock when
called from paths that already hold the lock, while still providing
full serialization against concurrent hotplug from other tasks.

Testing:
- Code path analysis verified for all call chains involving
  sriov_add_vfs() and sriov_del_vfs().
- The race condition with platform-generated hotplug events is
  specific to s390/s390x. Testing on s390 hardware would be
  appreciated to confirm the fix addresses the original issue.

Ionut Nechita (1):
  PCI/IOV: Add nested locking in sriov_add_vfs/sriov_del_vfs for
    complete serialization

 drivers/pci/iov.c   | 10 ++++++++++
 drivers/pci/pci.h   |  1 +
 drivers/pci/probe.c | 12 ++++++++++++
 3 files changed, 23 insertions(+)

-- 
2.53.0

