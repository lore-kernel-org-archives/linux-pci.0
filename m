Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5143F1643;
	Fri,  9 Oct 2026 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526508; cv=fail; b=Lx+NhJ1IkGrWvIdXKort5aSAgHc6ROYc3bCkS/JkvODLQGVtJOcMcFS/Hl6sR5thS+/+zq0wsjhyZyE/qDjQcDhfkP5gJ0LOBKloXrHZ18Gn1gWKLczaZ1Wc8vyR05Q7hBQzbYNyynOB8EwjN4H3birLx6hRiQRLJNCVZUShRzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526508; c=relaxed/simple;
	bh=2e33M44c1Ej36WMz11jaXNzac/GfwDSkXPnfh6O0kvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+jse6vs7UjImOJXGAOVZ9YDgPCurUSb0zP7SWoj/vkzh151ZLJo4sXkGyc9N9RvQQJLk54fANHvHnq9MLycrOfCXUauRJzXBTLkozMq1GKhgmwv/paa2vxocDRxyT7attv2UXB5aTPBAESG/cwJTCZY0Vs9U4HOm7caTm09qLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tvY6P483; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvY6P483"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsLDkfkWIXxy36+k92eKrU18jKyffgs3D2ILqRKmS1o5OnEsqjHm/J5fLEy9uNWVanJ1XMCL/6bzST+tVgrwqEFl/l2CsgiwFeGC9lNe3CbIPENOagbKMTZGHnc7vlHul1RcQsEbNqAyYc7+TNY4RqvcwP92mWcPZSqIK5IbNjZCUiXr3Ny/HHm1EBww9mEbllbT3poX89DmQIXsnU+1rJYGqu/kvnxQOyxd72rITDo8leLM/g7WEnW52sFqeG4wnJLAnOaPTzTL8RLEPvcJL4ypiLLYC9S88+/uwM2U7uet5u9tRb8V68q76TKsA30SYi7tIuiADi8Rfk/tdk+gXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfic7m7DoopMTetAYw77IUBzCxvRY3mNt5WaCbT07gI=;
 b=RWHHgn1mvSyNuKq/dCBESkgDigXLGl5pn1scAuJFop0kJAlsivmJzwrW7jAJipqGr9fHLDiU2tS1i6ovO+VU0oVGS2kY0XWqX9Wa/X+Y1uSbSXrlJKBdknPjBqT9e33D6cgBBTRDL4hbEtVVjzDGpBeHgp2GxR+AhVAeolL7sFlToI/7FV7OYYZuKts3Hgngiy70Pf3xlzP2hF03rQ+uJvlEPkAFdaAiafsy7c0DspV6A/u3XY+S34h/qBRyB1wMwWmA1Tt4aN/3dYEkJXQ2bw8OL9a8lQWSebVRCR8vSLsR5KMxmcN8Ll78zTaMfVdiqVvkN1Cnf5Qx4famOnQHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfic7m7DoopMTetAYw77IUBzCxvRY3mNt5WaCbT07gI=;
 b=tvY6P483CcoOj4kIXKrKSfJVSXTW5JiioD/ZNKhdNFlQubyhUkyMzEzhdj5PLOUKrsIspTd2/mjScpHRUKJT0gPDOXutR83sb545WG/fDexxGRdsXOgbbAF8I6xg0rOEgoFtQLZGg6iOFvXPMTSJWhe2CtDevVGa0cPMamigi/5r6XpYHoX2z3ZyV1LGI/M2K/cv8nA+9CThQgbFxng2l1t05eXie4M/GEofHWdcgItcrsb3mqBs+NmtPwpVgNyO1artqyUuU1IywpBtt9A2Ezt6MAkalASom2kQLY5vVvAbSBlgiClEGB7eh+7yIhXsrouNNfzcKs+MNrGcuGA2Tw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:59 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:59 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "iweiny@kernel.org"
	<iweiny@kernel.org>, "ming.li@zohomail.com" <ming.li@zohomail.com>, Yishai
 Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "dmatlack@google.com" <dmatlack@google.com>,
	"kees@kernel.org" <kees@kernel.org>, "gustavoars@kernel.org"
	<gustavoars@kernel.org>, Neo Jia <cjia@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v5 11/27] vfio/pci: Virtualize the CXL DVSEC in
 vfio_pci_config.c
Thread-Topic: [PATCH v5 11/27] vfio/pci: Virtualize the CXL DVSEC in
 vfio_pci_config.c
Thread-Index: AQHdRgqNmrGQcovvtU6hjipjYSD3FbbZ5C2AgBr4ViA=
Date: Fri, 9 Oct 2026 06:14:58 +0000
Message-ID:
 <IA1PR12MB90301BE0E6C8FE16FBE34E4BBD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-12-mhonap@nvidia.com>
 <20260921201443.04eade30@shazbot.org>
In-Reply-To: <20260921201443.04eade30@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: d5f83746-6f70-4440-903d-08df25cca57e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|22082099003|18002099003|10067099003|38070700021|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 PJrGK+zliZxs0v+OhAqz3rJT9C0+HIWFVB1khfG3+GPwR9GgtflVZ11OGYQe5nEpgm8aM+M3EOIRjJstOBGxvYK+VEmDoVNysaLw779XABNb+CY684OBYhfkvnedt5rv6U6jQpY1A6VGfVFakxZm4rk6DQoFo9WAR6N2SPF0eEApIWitM7W+EYallwqGmR554qgDeCvFv/3m5yNsQS7zu9RTmCIMpU8K7mJ2nmAq6e68djXKvlJdAeSbASApoDOe3lrk562dztxhZ/Uxm5P/V/fCCKFmtdQZ9hLxk2Z9CeiCsTlgzSBe9Jzh22ShfO/CGHs5FT7UUz2pvcxKA+tB7cWF/5qXjc7NCsXbFEbO/Qy1rnBsjmMPVHtOO5kKw8Rszcv0Z1MreMQlgFvGDsw9pdumBLABtrMVSDdpfliSo5TCK/UXwKVhJIn4erzSk7lO1LND7b3JPwD+ljvo8+JvE/1/nJJqCvrWVQ90+UGemoeUtn6bVcqawmIlVxn530AuYq80k24n0G7ekqAQEdLaRks/YKz3hKUH93XD8sQJ61EdI2UiYSTjW1pehk42XPZaspKbVtTDpaoL4ncJB5gFP5HrRPqwLrpCuNudxiQ15T4UpAttws/QSRwKA7XvAnj6cg9H2kOdVTQ4UDPIEFWNvkK2B+MV4YHU9DH1Kdz0K+A3ORtXs4gdtTi1aYwS4lQAX1OpGVCU+4UI8ZP/V0CR/RJA/p7YPGxF8d+6lRsl0Ao=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?T7HD/RwV/zIm68dIKlP7huqORsatdPP5P960MSreW40U8n2CIQ3BpnlRxV8d?=
 =?us-ascii?Q?Yb9sBiSeGGjOsQzhioliFelKF07ha4p4R6VEzmRttdeOzsHWPi+3iYTrMjYR?=
 =?us-ascii?Q?6igPFibaa7qqG6iOwtvK3nBzmia9LmjfGalNgNhpiX+HvxLF/HT/OXQafUOy?=
 =?us-ascii?Q?ny1oNApCYjBsieqKd4pPGlDKutK+Ml/oNLD1WkqYBSWJUMASaFJZJOE81KVc?=
 =?us-ascii?Q?2vgBB9sTGwIHkA24I+iWGRr23SNdAOQ/Cn9V1mWyrYUnN8PmIRn3BFpAX9EH?=
 =?us-ascii?Q?qpnOlwFx9bdu/D2kdTUK9VoaAHI4L5quVHlXd4jbCY07WS42iN7386RroggI?=
 =?us-ascii?Q?ZVtnvdZiLP2Lzxz/EoBBEYsXIKvtUWMcJ70BbL1YFSnah6iR/v1GFcl7KiMf?=
 =?us-ascii?Q?C/Z3KpEH2jdBoOIxAO3ZRQoQzPJkVIOF02RS7Tr2KPhii0/VVgkY6VSPS1CW?=
 =?us-ascii?Q?oijnNAsf7dyzgVFyq5nCkWOC2baCP7Aiaf/dr/Ij1u8zv3LAx4ENgE3ErQKT?=
 =?us-ascii?Q?wCa2UGPljBE57D3Ya7tLL37XTB/Dhex/L+J6Lcd2HrrXLXFgAK5JanGuUxal?=
 =?us-ascii?Q?+JhV1JKuqZfwOlJjUA/JtfCCEwHE+KCEO97AkaKDaamB06Lmto+mVtXPsqNM?=
 =?us-ascii?Q?aTFN4rmE6+ZQanagsQKIIttdyT2obri6Nz8GKbgO5HSDrPfx3zaKOUkT/am/?=
 =?us-ascii?Q?86qAM1peLNIoydSMCzRA9h/Ax9jpdJBsvPg5bOVxqlQRNz/69VxbvW676baU?=
 =?us-ascii?Q?KVTl92bzoptzL6wSYik0dHHl3tXVnhOFObzqsANLQuumiaL3Dto2vFwYxrGc?=
 =?us-ascii?Q?Tei7a3s2O+BqHr07biLNM6gELWpPi3QXzRMRX+WmT8KiSiwQrKQGU5K/cjJB?=
 =?us-ascii?Q?M8TnKJmuq/LeQW9Ukvpdr959o7ZKRHk9X9ZXSz+1jCcxvxwMNovepnv3TPgy?=
 =?us-ascii?Q?uJ50Pzt38qP5ThQuktuiV9ZeE62VZBqYK/OSfLsdZIodxVqr41QOl4+rxklF?=
 =?us-ascii?Q?ZVmpIifPpvrOaB50ZwxTwwuyn4eX8Wgs+s+D04dELF2WGlsvO2V5CuiPDhoB?=
 =?us-ascii?Q?1CJGjvsqtxRyZNErPuzllWg4vZUhaMCU1fp7OF3swZrmiQEYgzChooBW+fJk?=
 =?us-ascii?Q?FLbRiLU5HHspkWXW4b0faEJOzMNXzSveROchPF9kY7+i8mGZcH0+u6VJAtVP?=
 =?us-ascii?Q?8SnFj4LS4Plw46dpnO1JLy5ysuqKd5zbxubLBbJt6ZfuQzCkEa0rFlWuQhkN?=
 =?us-ascii?Q?p3V1oExHGtswKcqDgPT64s9LrAktdwHGfS8Xi/+x8iDHxihuR84xz1DaVKrU?=
 =?us-ascii?Q?mOflE5q2NO5kHTI63Ho2cws9GlqU3NLD/6oGKJzEi+7Lj+bzoLECNtGBmN4O?=
 =?us-ascii?Q?+wNJTd0IfkudozG1GBiVic3FedUqLDKJZvNHy77ck0BpzN1hodkZvN0G+MLx?=
 =?us-ascii?Q?gI2khkzimZQwvWENfZTQT/lspnyTQ14haTY/dByaS9neutWhUDsd5UYL3PbL?=
 =?us-ascii?Q?Pt8775uSSYCrIDDGjlldTJnAgvyGVG4Tq5E7xY3DnqgxT0d9L2lODYekpGMy?=
 =?us-ascii?Q?R+zUth9MzGuOCMBSBPTCeKjmIRXMiAHWDpT61UjF6EHfYl5THfr4E68xwEQ4?=
 =?us-ascii?Q?ln3/bNKbPUzqTDTbzCiKpOYBlkSqEhLQKgg3UdDPsF2nxXbBAy/Hg61RcdKZ?=
 =?us-ascii?Q?2M2jT1iXYl4k6E/cEMCurg8GueaFNMCxo92nY7ZeojIJnxkv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f83746-6f70-4440-903d-08df25cca57e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:58.9636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2eueVZzBm1msUIwQ6LXW5cmn/HwHoBzETfHFWz8TXN2YcGbcVCgJ0R9ZshxkEYgj1CzKHQ7YH9VU0FD+N+YWXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912


> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Tuesday, September 22, 2026 7:45 AM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: jgg@ziepe.ca; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan
> Madhavan <smadhavan@nvidia.com>; corbet@lwn.net;
> skhan@linuxfoundation.org; dave@stgolabs.net; alison.schofield@intel.com;
> vishal.l.verma@intel.com; iweiny@kernel.org; ming.li@zohomail.com; Yishai
> Hadas <yishaih@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; kevin.tian@intel.com; bhelgaas@google.com;
> dmatlack@google.com; kees@kernel.org; gustavoars@kernel.org; Neo Jia
> <cjia@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kselftest@vger.kernel.org; linux-hardening@vger.kernel.org; alex@shazbot.=
org
> Subject: Re: [PATCH v5 11/27] vfio/pci: Virtualize the CXL DVSEC in
> vfio_pci_config.c
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:24 +0530
> <mhonap@nvidia.com> wrote:
> > +/* Virtualize the CXL DVSEC so a guest cannot reprogram the device
> > +through it. */ static int vfio_cxl_dvsec_init(struct
> > +vfio_pci_core_device *vdev) {
> > +     struct pci_dev *pdev =3D vdev->pdev;
> > +     u32 dword;
> > +     u16 dvsec;
> > +     int len, ret;
> > +
> > +     dvsec =3D pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> > +                                       PCI_DVSEC_CXL_DEVICE);
> > +     if (!dvsec)
> > +             return 0;
> > +
> > +     ret =3D pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1,
> &dword);
> > +     if (ret)
> > +             return pcibios_err_to_errno(ret);
> > +     len =3D PCI_DVSEC_HEADER1_LEN(dword);
> > +
> > +     /*
> > +      * The virtualization writes fixed DVSEC offsets up to Status2 (t=
he reset
> > +      * doorbell stamps it). A device that reports a shorter DVSEC is =
not a
> > +      * usable Type-2 function; leave it as plain vfio-pci rather than=
 index the
> > +      * device-length-sized perm allocation past its end.
> > +      */
> > +     if (len < PCI_DVSEC_CXL_STATUS2 + 2)
> > +             return 0;
> > +
> > +     vdev->cxl_perm =3D kmalloc_obj(struct perm_bits,
> GFP_KERNEL_ACCOUNT);
> > +     if (!vdev->cxl_perm)
> > +             return -ENOMEM;
> > +
> > +     ret =3D init_cxl_dvsec_perm(vdev->cxl_perm, len);
> > +     if (ret) {
> > +             kfree(vdev->cxl_perm);
> > +             vdev->cxl_perm =3D NULL;
> > +             return ret;
> > +     }
> > +
> > +     vdev->cxl_dvsec =3D dvsec;
> > +     vdev->cxl_dvsec_len =3D len;
>=20
> cxl_dvsec_len is never used here or elsewhere in the series.  Thanks,

Yes, I will remove this in v6.

>=20
> Alex
>=20
> > +
> > +     return 0;
> > +}
> > +
