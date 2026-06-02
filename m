Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C53E0240;
	Tue,  2 Jun 2026 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403383; cv=fail; b=HZYFho0fqyCq6jZN61HcHKzrBcAx7ep88oPd9FyF9dRrI01fz112dbkWhNx/Lbv/3WlGvYFsAG3QTyY9X+/iZiD4sacWhGiM0HEmUc4QXGPxwk45KgSLtzdKP/0bVkM1cw8pa4Y9BCfXr4F0LUUJCeM2iBsu+CdwtYtAsh31k7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403383; c=relaxed/simple;
	bh=dv2hMuSTdJlDEkpoZi4V7unUWfqacIEu8kujrQgZQtg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BJIS44ANH1WWphV7W91QkZ1dKcTbtPo4GUCWBLOJPKHuHMhZFzh5NBdl5019icHeRHUhw4C4qLK8twp7a2rveU0+vnbIlgFW8Fif+3nE9qz+wJaSbCUhqA3hvF5xYLAJKWNG8uy+yK4Sk+fZvTGH9eO/9y6pVAvu76WBuoor8PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PlLtb5PN; arc=fail smtp.client-ip=52.101.52.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PlLtb5PN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5XoIo24pUSNpc0NJUlN+ICkGFIwYFSc/lvqLwnB3NgJdyJw2d38sgHfzyavkcYzKtz0AVd/lt4xpa0ekqHSg3H4aoY0B0gQrGAQ/khsC4UMGFM1XsdmZFLc57V7xpz2X3MaegUSUgwU9juxduYBwB3Ib2xaDQ0PJN2Uf4+O0rMKSoFoMQtlplLVhPLEtRGNpSQ5ALH++/gFMhi4zLTR6LpEsksDJEw1lKI5qrB/N4PYcf8M/Sew4+SKVPfuo54jXX3Y1kE6jEkkCvIGrUpfQ69/t2/5etvW5LcI4i+ckX8ZLo9BnKS1gdR4U26QYBmajZHxnzP8gW2lL0ITcdmU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN+XTpJkXntJSSywd1/M/e6tFwvJeJQXpUYwUBPhhcw=;
 b=OaPRefjvSNEhXG/CSlLzJOwmKb3Ij5afsjw5tnytYQo/J+3sJk3MHOplSB6wjuxDL2VQM5R1FQDUx9KHf25+46hWUvVKIc6qtLdYKpS0927EWSz7VsRTS72F16y1um/xbcZfEctXRHpKOCfKg6um1EIJ6TFoSGWgZIIM1iG0Gsd4pLIKtfl5D5RD6BXtqw4fX+ucuMT/x3lfoV2E6rD+DOoSjvUXejlTdyeLY+a6IaXK++Bbih+3pfzyX17p505+sYcAOiHplHKtG0LmYxspl3xthWEzK5yHRFG/Ig/IXRojyy6byA4aTRxRLRi7DoWGOZMqwoJCJDXqj+MHAcgigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN+XTpJkXntJSSywd1/M/e6tFwvJeJQXpUYwUBPhhcw=;
 b=PlLtb5PNLffCD0NiqML4DDLEfKSovJMwuTf6t65dS2SKCwjvUU2pGBKt7qbl+VREW2a7XDyH2us92f6WGyAno4Myb5+NEmQ00Wn8An3jCBt6JxWK79/ZmJFmdQLR811YqzBxjLTpz7wKtay4ROKVvmVygNFSNv/p1OQTKNWVyQ3ooEZkvAw+YK8DuJiWtveAhGP8ZBrRvrV5XkGEo3TB6BG0rbJrgP9OzBnc2dZjogdUwl3DJtyplVkAB/2mhioLUCN1eA4lbQGrcQTmKi4dWVz6EqfaAbkmE9uvPvKGf6wbBYj1rY/DLyY01JpHDQ7zFtD3ywdQPc2wTrextahe2A==
Received: from SAVPR12MB999121.namprd12.prod.outlook.com
 (2603:10b6:806:4e7::18) by CY8PR12MB9036.namprd12.prod.outlook.com
 (2603:10b6:930:78::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 12:29:37 +0000
Received: from SAVPR12MB999121.namprd12.prod.outlook.com
 ([fe80::93ef:92fe:74d1:380f]) by SAVPR12MB999121.namprd12.prod.outlook.com
 ([fe80::93ef:92fe:74d1:380f%6]) with mapi id 15.20.9913.009; Tue, 2 Jun 2026
 12:29:37 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: "alex@shazbot.org" <alex@shazbot.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, Shameer
 Kolothum Thodi <skolothumtho@nvidia.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"clg@redhat.com" <clg@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v8 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
Thread-Topic: [PATCH v8 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Thread-Index: AQHc8llUjn8y6mjsCU2e97g2INaIobYrLzkP
Date: Tue, 2 Jun 2026 12:29:37 +0000
Message-ID:
 <SAVPR12MB99912160844F6B16D7AB2E570EB0122@SAVPR12MB999121.namprd12.prod.outlook.com>
References: <20260602063015.3915-1-ankita@nvidia.com>
In-Reply-To: <20260602063015.3915-1-ankita@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAVPR12MB999121:EE_|CY8PR12MB9036:EE_
x-ms-office365-filtering-correlation-id: 82c1bda7-1b30-4408-d60c-08dec0a29c47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 wLu1yUN0Tv3cz+p3sq0X7FTK8/yg6noWVBLEoGY/NFwJlO0rXWx68yTcJYIRkaA5DO2KZ1jhcmyjRNcFoXNF8EcyHA3Zj4AR2y2JVRY75fkZi9CoZ6hpQ99Bw0h3cfW2+BCGfvaLmAJZb2FVbX+qWhqSjypqggksor3/X3mAixbpSWPcWYxExdHOgGW5p5XcypCKjIrrSqkSISZII8zLOL2mqG1FuzISjMGXkPAuBbXZctHHl0jZkC+CK63o+SjBMmb0BvkIOuucghfh9YD+5yGCnOF8m2SDt3o+UMNPOQrYcxm0IYTORPgaxacUP/rEAnnSzbkm2v7Uq6EvfHNLKbqd+1yJ7f7K3TnnKqmvjZRXC1jjsSGbekhI4JzYpvXOYiV5kdRvoNXjy6g+WO6cNS1HIPKJ5QAGSYZIDWdoMOsw75Sie2IrcXkPSRkRx/D41DbOLI8GgWUnMCy4d7cMmiP8s9FFmJZxMeSX5L7fBF/vQvvH90tUlQpAfZ4hLtyYgNBIVuM5Aqo2Fki4SR5PsJg0bwVIcoPGwfMpROTFUGRq+nPcOOjwXjELUlBxWLD97NuyxY3u0smaLsPBW3oDSKsDAdu8IJwakkKfpZBZVqryo9H4ksD4sjRwXxg4EFh7RnMgVRUENeffdwMEbX7OBzM4npJu+UjE/AInnjwrmuTUyG7h43+N/pZrqaxlYok1DLxWIOOw1OjsVkVCjhP4lKT+qb6BfZs3xvb0NYLUEaVGUE8joQZ31pQxrrZbx63Q
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAVPR12MB999121.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LVSxLxnE8UOINAWV0Q5gwC8ZEj126WftnpFbXnJnHtEfyTWP8DmAk1OY5B?=
 =?iso-8859-1?Q?mR9oovvHiLMDv+CjWIMkT1eNr1K3OzGb1C5mUyJct4KiK99iw+1OP5H+C8?=
 =?iso-8859-1?Q?Gu+8/90/RgoF8MF4CinC0+xOPuh4UXTDMpMtI1H5yyuIf0O2IDbNhInq2H?=
 =?iso-8859-1?Q?jSLATRXBsumx6ALdTu0zTwWvTDjsIEOLiRgriIHYi7uNk302kLtPZ3rTIZ?=
 =?iso-8859-1?Q?iiO/IDQ6oNc0AzVPy4UK29yuuvNwTBTyO3YgTRuc1HxcKJ7ntJ8SCRK0Wf?=
 =?iso-8859-1?Q?iJ7+mXqgVcIA4Bsc+khCFNHyp8muj1jQds6tNDAPo2uhdnXbCI5A2iwIUd?=
 =?iso-8859-1?Q?llhFpVjw94YdKqBA7vLllgAH7CngEJTNKUl2Rfhc6hkBRb2dMAioMsYTgg?=
 =?iso-8859-1?Q?AYUfoJB0ov11ra4gyAAcnIev8kSAOpNxP7C26CSM48wD1v3F2wsJoRVHHJ?=
 =?iso-8859-1?Q?Qmuu0RxDhecZkPDhXNK1tjYmUEmFFg6xbzxTAr+QMOJDMYXRFBoWrGU4u7?=
 =?iso-8859-1?Q?vHsB9TWvpiFzx2RvgXpg/jnhR/1VTFVZR+ddm+780SR1lXVtMYMTJpHJHT?=
 =?iso-8859-1?Q?Xti586R7hc4nRcHo2imVgwor6/fvzVOt0Kj5Nomx0wgRLrw3Sjs4kv+f4k?=
 =?iso-8859-1?Q?eFnEgWArtB5ODTkmzs1GfQfP4M8fY8Lnuvhih2NQ+nOQNcK9acF80touGc?=
 =?iso-8859-1?Q?rIMXUeEo9t3pqfoyuti0FkX4PLAHzAQa9XEzQOmBYmnP/14u1wdDUmHgXp?=
 =?iso-8859-1?Q?6p5Mc9oYDLid9fpL08TEHGTlnyBrgvl+imZdSvskUO+JzkWvPLgOx/dAvK?=
 =?iso-8859-1?Q?ebHpY/WziUrrUODHD17EPYOa+H/wvDBsDxtunY7vOKvGyOZHrnf9UAVheb?=
 =?iso-8859-1?Q?C9J+AsqYd09W55eaIZDeesNMt0V7DcZDj6AJYkLPIoOLWDmLRENicEUOwH?=
 =?iso-8859-1?Q?bhEbBTNJrEafBErk9Ab8ByygzoY0GnKSalYPvqd1TZWwhWxIIuzKSy6Y3q?=
 =?iso-8859-1?Q?MOVcyEEZtfCndSF8BPy+3fCQo5rWNBaafyamSWFSkoS9D8Hqaov4y2xo/A?=
 =?iso-8859-1?Q?qllSHrnjKDFK6qmozk7//cNjys6UElmEDBhIQpjMhzAEWysVSpXcNr+afp?=
 =?iso-8859-1?Q?u535LACdWlUefF6E87rv6nw+ik+Af/TIRQwhWIGU6NxJ3HPY/30HDxyHc5?=
 =?iso-8859-1?Q?iQgmHtZjaJ8DHup6HxXg35hZfT+eNDCU3f6pCFawU+vM8SUOsew0rmBfxZ?=
 =?iso-8859-1?Q?3r8Y6vhR0StIEYvPa2K+d9O3pORBrQRmefpWu4VBu72zNOXW0oJ+UM3BUu?=
 =?iso-8859-1?Q?+BaxAhErL9KlrSgiGDyFWbwDLjQcRM3OSIaZt8StB+Y2Rs53Frx3pHP2K0?=
 =?iso-8859-1?Q?1TM20QtamL4laEmCWb5E8AKir4AbAFWZ807CA5vx2NIc6BKbg8c8atj6p4?=
 =?iso-8859-1?Q?LT5BImDZlEiSnOlFOdxx90IVh31B671qWPDhaq5hdhW7kEqqZ1l5Dj3yhj?=
 =?iso-8859-1?Q?MNTYvfYdx1DmmhTQRzcKEPO6KSc/tHeX3kZnASxPcBcQ0XkLY/G5uUFUA1?=
 =?iso-8859-1?Q?N19llBQeYwUkojvqmhdjNYNBg2YDSIlk75FapszyevGhoUG0STfEhoDG2r?=
 =?iso-8859-1?Q?V1HiCltmtvxwLQ4k9qAhrD2OW3sUhGbAAEUWKk5MHWQyd8kllz6xsI/nOw?=
 =?iso-8859-1?Q?Dr/Nxiv3V8+Uovf/isYdKpj52T2++8ef+0sCsr1ghvMd/8dyh4BlxlszTQ?=
 =?iso-8859-1?Q?Le63ypljAe2AVzpN48ZY3kswRQRe2M1NlrAxw7gxNqmuto?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SAVPR12MB999121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c1bda7-1b30-4408-d60c-08dec0a29c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 12:29:37.2144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cyOifxAhFlWCAOw/sgvfjlO2NnJb1YxCk9wc2RtrCTH+O6rsBWs7/4uqpgQ1Kb30hPzZzhlIBfobQTgogXNDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036

Got the below review comments from Sashiko [1].=0A=
=0A=
> > @@ -712,6 +825,12 @@ nvgrace_gpu_read_mem(struct nvgrace_gpu_pci_core_d=
evice *nvdev,=0A=
> >   else=0A=
> >           mem_count =3D min(count, memregion->memlength - (size_t)offse=
t);=0A=
> >=0A=
> > + if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done)) {=0A=
> > +         ret =3D nvgrace_gpu_wait_device_ready_cxl(nvdev);=0A=
> > +         if (ret)=0A=
> > +                 return ret;=0A=
> > + }=0A=
> > +=0A=
> >   scoped_guard(rwsem_read, &vdev->memory_lock) {=0A=
> >           ret =3D nvgrace_gpu_check_device_ready(nvdev);=0A=
> >           if (ret)=0A=
>=0A=
> [Severity: High]=0A=
> If a reset races between the lockless wait and the in-lock check, could t=
his=0A=
> code return -EAGAIN to userspace?=0A=
> [...]=0A=
> Should nvgrace_gpu_read_mem() include the same retry loop around the wait=
=0A=
> and lock acquisition as the fault handler?=0A=
>=0A=
> > @@ -846,6 +965,12 @@ nvgrace_gpu_write_mem(struct nvgrace_gpu_pci_core_=
device *nvdev,=0A=
> > + if (nvdev->cxl_dvsec && READ_ONCE(nvdev->reset_done)) {=0A=
> > +         ret =3D nvgrace_gpu_wait_device_ready_cxl(nvdev);=0A=
> > +         if (ret)=0A=
> > +                 return ret;=0A=
> > + }=0A=
> > +=0A=
> >   scoped_guard(rwsem_read, &vdev->memory_lock) {=0A=
> >           ret =3D nvgrace_gpu_check_device_ready(nvdev);=0A=
> >           if (ret)=0A=
>=0A=
> [Severity: High]=0A=
> Does nvgrace_gpu_write_mem() have the same missing retry logic?=0A=
>=0A=
> Similar to the read path, a racing reset could cause this to return a=0A=
> spurious -EAGAIN to userspace.=0A=
=0A=
This is the same point Alex addressed on v7 [2].=0A=
=0A=
"Note that the read/write paths also have this gap where we can wait for=0A=
the device to be ready, but the check under memory_lock returns=0A=
-EAGAIN.  The difference is that userspace will already automatically=0A=
handle the -EAGAIN vs the SIGBUS could be fatal."=0A=
=0A=
So I'll skip this.=0A=
=0A=
[1] https://lore.kernel.org/all/20260528115613.63f1b178@shazbot.org/=0A=
[2] https://lore.kernel.org/all/20260602065100.48B2D1F00893@smtp.kernel.org=
/=0A=
