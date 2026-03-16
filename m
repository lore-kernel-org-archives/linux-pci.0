Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2101.outbound.protection.partner.outlook.cn [139.219.17.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4151927EFEE
	for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671161; cv=fail; b=Mf/ZorTcEW7YjYjbbljGCwLBm+SsysvEe6Sh+U48spsz0nHp0rI/WbPKAYBsxikd9PBK6Ad3IFGhy+fhxkVM6pmo8JXWu0m3XDfidXv3W8TkzplRKBOKzf53sA/FLsbaF1PiMuyiAQyNk/pLm4jz6tH14ZQ33+dfIh4zuCX09aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671161; c=relaxed/simple;
	bh=adnDf+vOlCMzO79QB6XaXjPMytK497A7gF5BI8AmfUk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WUPYGokUbRUtSly9req4GWwhRyFLkV4KyoM1G56RzSkFSoXaYDjbPE3b8wSxHKeSPlfmpg4wSvG+qiRM3wDaxVrauoUTvjh6SV2aa0QUa9mNVm9mQNUmgawSjN5GnVeBMjH7gMaJ8tiFOtdx1eunWRM+BH3Ug9Zk4MRW01AIRBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com; spf=pass smtp.mailfrom=lecomputing.com; arc=fail smtp.client-ip=139.219.17.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xc+sj9FDrp2UQteXojKTQL/IXZVmShh5y5S50LmRPSsJXiuzu0wftEdq4ExCQP9D5ZIWUw2geTKGRguGu3G8LuaAL0KZ+OjPLRrLgpG3v6eexTe0j/JP9E9NP1L2utHSXsHHRotVAZw/TkTFRQMb8zFSgBFyEujI2t/SS3/IcmG+wNNQW/tFH7Zg0jkzvEhMJtH2ptlG0VLKhps2P8IsgJ43wZ3GbvPPH9w0goNgRGhNmoiivkJU4/NLwB6hLvVWevGeOFP6f9v/1MYbT5uU2KraQJjaMNGFHvXOPT0V6gT+b4B9NE0aA/J0C71AGaacHfN2Ys+qTi6oGjxPISBL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FbWnJnMira3TOFOP5wcTlLJT8c7+kwS1Rvxqm4fQE8=;
 b=V7I2546wpnupiQCFVkuyJ+Q/lbCM1NHjn6trCrlzMnaKtUMJuFEr8sSPGMBfv3mkPs+LCDlG+27GOsm9cMnwzWiMiJ9iO42wUqcfjxk4LLQCO3PIC65GZMbRbtfCcKx8iYn/tupEY0OSGJSjcF3Cn6KCYR9uMYwZG5kP99wS1BSnP0EbFdlgH9FAPjBJL4ptQe+wFYEQepRk24S3dr0QF9WzzlDBpF7/RE5MCqEtST+Q6T43G2g5+aSoq3hcR033QedKNEp9jvySNDfym/aqa2I0ykdOOlYF9A98EMUEsKnNm8RkiXQ8te/Sw9LqIbaMMkpRJ60OhPugc+qPH7O5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lecomputing.com; dmarc=pass action=none
 header.from=lecomputing.com; dkim=pass header.d=lecomputing.com; arc=none
Received: from NT0PR01MB1087.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::12) by NT0PR01MB1247.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.34; Mon, 16 Mar
 2026 10:49:53 +0000
Received: from NT0PR01MB1087.CHNPR01.prod.partner.outlook.cn
 ([fe80::8182:356e:d02f:519a]) by
 NT0PR01MB1087.CHNPR01.prod.partner.outlook.cn ([fe80::8182:356e:d02f:519a%7])
 with mapi id 15.20.9678.033; Mon, 16 Mar 2026 10:49:53 +0000
From: Notics Zhang <Notics_Zhang@lecomputing.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "logang@deltatee.com" <logang@deltatee.com>
Subject: [RFC] pci-p2pdma: mmap() on allocate attribute may create cacheable
 mapping
Thread-Topic: [RFC] pci-p2pdma: mmap() on allocate attribute may create
 cacheable mapping
Thread-Index: Ady1MoMcRFilmEInSZGlbkErtsP/OA==
Date: Mon, 16 Mar 2026 10:49:52 +0000
Message-ID:
 <NT0PR01MB1087BE9B13D5358D7C9220C3E5402@NT0PR01MB1087.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1087:EE_|NT0PR01MB1247:EE_
x-ms-office365-filtering-correlation-id: c5fe8506-c228-4142-6f86-08de8349c11c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 9R/vYupssnRNQrkjoibR9+1ZZLUq1IEEAvlTYVMlAHBxfA5ZhIzyINz58+MnBUN4AB70Vdv/PVR4H8mfGEu3uXdkqVoUTfwE0uQUP/I8WWxwzkKQRZ8ImZBczQgT8Qo28n0sphVCUm35BEMQFuxcMQz4MeBPVz86E/2QWkjNpeotVKAepv1K/zzjBRd/2Fz9rDxw9YL+jSh5O9EVhED9yJjic/Thq8DoYqy2elCN1Og37iEayzgPUdmL6GuY6mGA5ryMNqKdA3Ro3oTDJ9D52tm/r9K6GFXKlCFt5joi9p7MpU2ufu7V8S7ApsX6WWKoeTe28OxLPYkGDe+colpIHU6/TP8hz4lXSEwFnQG9TE1kc4cej2H8dKEXXb9nIt+GoeACQBS/focPVF0bmLRs5KkUgO84VWqTXqHn0yDAcXPUbyMuNUyAMT+F3lPHV2HZxs668GzRB52QOMDRFULmBvDw8Hl4BRHC/sZaKPoy7wzSV9IbXo9+FoGpFjVnvCIBC2ibMFjqQNtOIjXYOSDcGQ2/Lgy9QguuKrzGhA6ATl2CbXBtlrVXO8HxCvHBQCexy+WNkayZ7Mi9j6l0qiF65mBurUJRt9tHKqb9asmQil0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1087.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A8SmlFwQI7umxih0q8n3NhORH2fsC/S2RkcR1NYh5zjCoqnz61QTW91xp+Yt?=
 =?us-ascii?Q?GWJupvvV+NYwoR4jpeUR1We6l9C7zG87z5urVKg3447/hI/XckqHQkhOx3gL?=
 =?us-ascii?Q?O/SlLCK/3ddZ5+t/gp/nPJ/8AKN8VI/9tt2itJ/3ubn64XUQUD2aQ9PUw7Cc?=
 =?us-ascii?Q?RbKBKOj0Ga9bPYZlessUU1m/2BGqBATZcJqxMA6IQ6HofrRE+hfHyCs96Vnh?=
 =?us-ascii?Q?d0jLICaFMPwXrxZUs+YsKH4fN8pVZFk7ciwtITz01cobAfZ8WzoYquvGj4sB?=
 =?us-ascii?Q?l8IFMiOqSl5Abkkc4e5Hre5Vq85C3kH3mBb5fp6MLbcsHo8Dns4yEjP1/HG+?=
 =?us-ascii?Q?TV+nm3eAOSJ06hCFKqCE+5c1rNoOZgE9Avcnbjt8j2+PWYezwSmdFEDCWPOj?=
 =?us-ascii?Q?8SVgMahfNbXIkH+VL/3Cn/CVXY4+1XAn/iVoebMvEZGxrfErLGkI3BiBrw8X?=
 =?us-ascii?Q?kxO2+awUeRql2i3pmzchViluhkHcQa8Pvz/E4Y9HiKYIoapFy4lYRUbMVy27?=
 =?us-ascii?Q?ELj8yzPJqlNUceFvq95zWw4JT3ERvI55/Nstclnr8KljCFag5srweTSbaktr?=
 =?us-ascii?Q?/rkUGe0ArGJspz27LVPDutHJNeoflYp0sNFv4cclU6354iz5kTU/Alz4BCe4?=
 =?us-ascii?Q?dgcWqIlCz1PjdRpoU9Rw64kJCzh9mOQ0v937muLRP+tjG0zHFzIks2DZSXt0?=
 =?us-ascii?Q?PA9JRSOjF3IrxAZFYLWOb/18FPZ8vYLZgWSxNrXj8r5lCflOXmz4Um8yDmuY?=
 =?us-ascii?Q?q4FIEoZN9KTrvfDUizbc+E/2rKMC4AcV6SFIA3M+HjzGCLq+3TGXGRf9EbAC?=
 =?us-ascii?Q?FwJ/RRW4dHdl8hANIrLHklL45h532D8C17C8ADVWdYicqBkK9EAMuLCk3uoI?=
 =?us-ascii?Q?8E/5lB9gtjziESfvZpBeO2Z46qIuj9TwnIhQFTLdeILbCk4iTFRSzHYsDUEY?=
 =?us-ascii?Q?mipVAQOV8b5uRP9ZBjt8FnFwZ1CSu/mkWY1u2nIggwEY7uTUB32X41xw8Y7d?=
 =?us-ascii?Q?AbLmr9vHpfpjelBeAfQHsdEGRNPgvzPGjCkYvffe7296tp0RaQHBgYS2uk8e?=
 =?us-ascii?Q?GuXLoOeDeWQIhcpTg9Ml8lp4jKyO6VQgtpbVR4aDlYYoONQD6v3L//Ie83Xo?=
 =?us-ascii?Q?eBwNwrWkaC5kkS9vxLB46jbMRk81xx+g/4mbevaTrf96MUURbLnCNEw3/OeR?=
 =?us-ascii?Q?QWNunmowChCx6MQqpTIJxMnG1tvR+x8ezquhWhWYiFUJW/4o27+Misra0hgp?=
 =?us-ascii?Q?rPuPI5wFAFqUYWp1/tViO/+PpItQ4nynm8VxIPEZDnuSiYLg9MzvdyNK+qpb?=
 =?us-ascii?Q?X36S6PSPiQv2RFygd3G8CoAWpHmCRJ8ZQyk82K/OkEkWcCQ+1nF1MfqfKXhL?=
 =?us-ascii?Q?GgDFQI+yyNtuarNQsyOYBrzkuJ0PBSqiQYHWczNMoLmXXSBLZEC+WqfVSqer?=
 =?us-ascii?Q?ir+rugy1+4O7VGaMC5uwF7mAFPsHHDmuUlZcsK7Xw9/QD2q2xpQgIfnqa2Qe?=
 =?us-ascii?Q?Knb1xOt4rkSO0lkGF3y2/4wf8DgNZMB1ZbSXwDXLuG4dNj2UaMMRXJjbRnAC?=
 =?us-ascii?Q?5CUs5rMpSes6MUfX3/c70hX37/1HpSDQP8HYRGlmsyOqVcKPBommvAIA6rcn?=
 =?us-ascii?Q?FA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1087.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fe8506-c228-4142-6f86-08de8349c11c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 10:49:52.8316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3591a018-3909-4ea2-aee8-843d5abaed8d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tt6yXdJuf4lxRqlQtHtscj2brwWMF978MB8UGKDaovQjcuSHDPXh/6VrwjTgChIfLRta/8eNTer+Lrg9bDY1vTXaM8bE0JaWn36hQ6Njw+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1247

Hi all,

I'm writing to discuss a potential issue in the pci-p2pdma driver's mmap
implementation for the "allocate" binary attribute.

Background:
When userspace mmap()s the "allocate" file (e.g.
/sys/bus/pci/devices/.../p2pmem/allocate) with PROT_READ|PROT_WRITE and
MAP_SHARED, the kernel's generic mmap code (do_mmap) initializes the VMA's
page protection (vma->vm_page_prot) to a cacheable setting (PAGE_SHARED on
most architectures, including arm64). This is the usual default for shared
writable memory.

The p2pdma driver's mmap callback (p2pmem_alloc_mmap) currently does not
modify vma->vm_page_prot before inserting pages via vm_insert_page().
As a result, the final user mapping ends up with cacheable attributes.

Problem:
Peer-to-Peer DMA memory (such as CMB or other P2P regions) must be mapped
as non-cacheable (device memory) to ensure coherence, because data is
transferred directly between PCIe devices without CPU involvement. A
cacheable mapping can lead to data corruption due to cache incoherency.

The driver already uses vm_insert_page() which respects the VMA's
protection; the missing piece is setting the correct pgprot.

Proposed fix:
In p2pmem_alloc_mmap(), before the loop that inserts pages, add:

    vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);

(or pgprot_writecombine() if write-combining is desired, though for P2P
non-cacheable is typically required.)

I have tested this change on an arm64 system with NVMe CMB and it resolves
the data inconsistency seen during P2P transfers. However, I would like to
confirm whether this is indeed a bug or an intentional design, and if the
proposed fix is acceptable.

I'd appreciate any feedback or suggestions.

Thanks,
notics
