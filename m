Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD841DEDA
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433464; cv=fail; b=Xmq2HyGaa/A/2PZD1+ttgie0Yq3VhQw6iQ+NeG6gDYAkoVkSuSP3mxsLAAO/k2FQ5a5yvWvRiomG6XutmPjZ7ArRc0pVQ6mj0gSm41/ompmYml/5aMfxGEY+pfoo1ArsW+jzeSM1lfRO2x1YuyWmV6NnWVUxRaR+n2AIZ6Tv6VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433464; c=relaxed/simple;
	bh=+HqFoxkBFsRs0mqC7Yk6o/E7MBL+bkHqToGENa+PTqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BgUMaYDR1LQqtJ8Niz/XL5isfNogHw9CLsY6u9EUQqQGHQKPGQC7UYuOUp365evbgzbtTDqkK/Ba7LG5fo5UcnsSgl+4eUcnr4dkylkSY1P+le4ULjQUdcOqn5sOfGfDDFGs+Bi6YbrKolguBLZI1XsehU6ndpgDR3d+dD1w/sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ssuw6Zv1; arc=fail smtp.client-ip=40.93.196.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ssuw6Zv1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wmr3qW5gh3z+JKT30UpPb8akKc//luKW93wtBiDofW8two+2tWrJJ1PpbjrFt5vLoncHS0UZ6sWltY6EQYcyane7HYwD6CEfWjIMAJx80GDhhLZsLHfoYe1f+AekUSSol8Uwq+RY7M1Bk8dEi4I6x29cuVkEB4htABrNLDpyev05qmI3yjg0DYLpmztwESRvmuCmqHfEygEik7lUW3Ow20+Tk6IR4/PRhMTS2HGMrhoArnE0PxYrBPDQgtcYqF2YxUP5zXOJgJVZDURPtl5nTDrEzDJA/exkIN3DvoxtmHhaHPMcVhI48yo6s08mfspa8NwrYoGIIW+w5V//UVUMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HqFoxkBFsRs0mqC7Yk6o/E7MBL+bkHqToGENa+PTqA=;
 b=s/9FTtPdmEPJoeBWMl5Sl9hgiUsZO4QBaBf2n/WvHCiRN4nzurGnP9/B6hh9BF+HDO7iw4s0ilDquiKKUWoksms6hO6YptE9LA13Q6T7G3hf0qVLsjcwxDRxu6kwAPEhK/69Ar7iehkAfgkV20T1yg6/TsIeZtOgVLCoykNGK4HDYCWusNnZVeztBAHzLNmHTw7IcL431QGVQy1OQ6rky6Frsd+TZA2csNSFCSs9ADsvAKVI3sFzTmnMw6fVNscT3CKz3X9Hw0xS6+xnPVR38P79MGsqcQkDZNHKnEh9o2/j2rlbz4JkIztsS4SIU1W+qV1M43yX8ba8/XJjtcXtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HqFoxkBFsRs0mqC7Yk6o/E7MBL+bkHqToGENa+PTqA=;
 b=ssuw6Zv1l4YEXDNV+tBPhlrOcJ7vcjFUZjUAGODqhpnRwqDGCCLXds6GutCQGDv1rmvuj538Gjj59CbaYAwkccYZ5ZO/HyvI8iRp6iVHczNuU7po1YiIc8CgX9dDwzOK/LyAnCR8RgYvcNTbvWkVZpHQYGtL9kT/KT5F90bpwpmXQH3qPiuCaTZ5JrgW2L5jwabkGPynTp4poTsZLNniMoQ+emKveAtFFriZsJjngNPvTNjCc2vFb/exA6T+rXbZiAFGb/YCyoZ4YIZZ9WRNm6FsrImhGx45DcSAy9CewysHJ88zdhPATVQ4wkvECyIS2tXoiMaEyd2hJOT5Fl3xag==
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 (2603:10b6:806:55f::17) by DM6PR12MB4105.namprd12.prod.outlook.com
 (2603:10b6:5:217::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 11:04:15 +0000
Received: from SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9]) by SAWPR12MB999267.namprd12.prod.outlook.com
 ([fe80::fe35:8a00:d9eb:40f9%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 11:04:15 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>
CC: Xu Yilun <yilun.xu@linux.intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>, Aaron Tomlin <atomlin@atomlin.com>, Alistair
 Francis <alistair.francis@wdc.com>, "Aneesh Kumar K.V"
	<aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas
	<bhelgaas@google.com>, Daniel Gomez <da.gomez@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Dexuan Cui <decui@microsoft.com>, Donald Hunter
	<donald.hunter@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Lukas
 Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sami
 Tolvanen <samitolvanen@google.com>, Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>, Will Deacon <will@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "yilun.xu@intel.com" <yilun.xu@intel.com>, Jiri
 Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security Protocol
 (TDISP)
Thread-Topic: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Thread-Index:
 AQHdDMrOwfwmCkkN7EeGRZV1a3LRYbaCujkAgAD+F4CACZTNAIABg4qAgCwWtACAAAJogIAA1ICAgAFKU/g=
Date: Thu, 3 Sep 2026 11:04:15 +0000
Message-ID:
 <SAWPR12MB999267C6FBF531A0DCA843600BB0B62@SAWPR12MB999267.namprd12.prod.outlook.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com> <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050> <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
 <20260902150125.GD2890729@ziepe.ca>
In-Reply-To: <20260902150125.GD2890729@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SAWPR12MB999267:EE_|DM6PR12MB4105:EE_
x-ms-office365-filtering-correlation-id: 241f9116-a231-4a02-7f93-08df09ab1808
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|38070700021|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Pb9s+0ARL6sH2gxoOTwkA8fSL2nt07yGSCgyS4662f8LRuVNw3LRsYUneBJ91LmB8pt1Q4W45bcdx35LyvK/I+I037qHPjx8c5HbuDvCoXKm/aG3CmWmdO3vPkOTRXukLcLaB88In8L4yS+BSHhj93KhpXHltuLR6UnEVlzjvSVBYeO+y1tKzPIvOE66edHammKQ/GH/5ryZh/bMQsFKA5FQqEYlulhOifQ19bM45dCBstxDvoWQZGsTHYJChtnCukniypI9odEDTSzRnCEc5abRcB3gfyHVdCXztZSSH5o8K5XcPws086DnMZ0epSCVCIo5kYLvliLEdYDmCK4Bc9zIVtLkwOg645tfzubRJJhZEsIWvXRZdp+CDtlcN2H5G/Z4Gz6Ov5UzAh9yv4CI+Sbk1vPGw0WBQ42Hs+LE/cO1O9KiRVFwMh3N3wAXYKFBPOp20r7UwSQQVEEEiVgRQaOZKhq/gX8t03uKPX4NWL4SxE7r/bkg66GGoV7I4MEaY42X+QxQbYWwVGYFhFRTzudFySbjQ9hv0qcl3ji77C1P8yiBG6G/mr/lhHvo0SMovC8eLkelDZwuIFjZKTzoW8ZY9JnVaebMnDkF1PphqdSmBdO2u3nqhzGPtB02IB0vw3YHPNlrYgMD4lp3NHXyHAMX25xZMCQ8zPznuuufAlANQZ3lcW6tMH1EFZPi7TZpL84FyVgKMxifzSE85g2/zzVGRRxEN+6U3ar1J7Prgz8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SAWPR12MB999267.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?oXKKCQPGNYLrx6cyHrCNX97AM3di4hrx10+cBfxrEeZndVesSUq3OFch0h?=
 =?iso-8859-1?Q?MO67eIyvwhAhOtsFfXsdXYJEPdw1oYPAzcaGQm7inDnkpysn5bhT/gMdkj?=
 =?iso-8859-1?Q?9HXRO9D3X0kdxMy+xYYW9RX6MhGgdqdWUsGwALbJhKsF0hdWIly1lp0xOS?=
 =?iso-8859-1?Q?uAymzch97J3fzz4zVhIhMOIk9Z7+q2taVGhxva50EqEebSn8dqYvjeRFnt?=
 =?iso-8859-1?Q?eagK2ttl41BrvAdVOJeGcNfT8e+vnhP1MauTODbebPi1EpzKlMivgN/pI9?=
 =?iso-8859-1?Q?1lknJxjtM7xnjilBKA/e9dTyp7lmKD+HyOwX4PBOBmiNOiIyiXt18WxGTd?=
 =?iso-8859-1?Q?w9epQGOrPoIntfMPMbsRSMMHux8ceyrXTjgGHZSv3MO/r0+ne+cKXf2jIJ?=
 =?iso-8859-1?Q?OXoBPbMk3sjBUErJDjB5nAd4cGCes9VdTNsU5WIFh6Z4W7AteahRRM7N+V?=
 =?iso-8859-1?Q?0gR40IQfvAF5AFvHEahamS/em5UlnjbCSYWkv6WohAy4QxnvP+CWdK0evJ?=
 =?iso-8859-1?Q?PJfjYWN9Ly5+ICLuw0zcM4RSXiUydo/Ptz9aP9WQgls5hOXbHBNyJhIeAe?=
 =?iso-8859-1?Q?VpdDEHudmU+pZ0MsxYCsKVeTWm+xYToyMVpHPZqzlvBXN3XFzFiYHBFwK/?=
 =?iso-8859-1?Q?AFoiNbg/An8Gqka7eVSlVJUNPWxXgEsUFQTMZBDNfTWkiIhaFsndmQUHHt?=
 =?iso-8859-1?Q?5MzP+K8OVvk5kxhOQsGEyHS1iLyZaYAZ8NvMQAcQmpruimTmHcSx9O8x3I?=
 =?iso-8859-1?Q?9uRxJfXmUNt78f6No2MZrCHQnLURUTRiHaRSYm0A8Im8jMo2uXI3V72SM9?=
 =?iso-8859-1?Q?dRVGSBSiecb+iqllUNpaTOOMWLdy/fGLtJiEYd7IUJkxVAdY4sYXWOacSJ?=
 =?iso-8859-1?Q?irCdW2E/V7geVZPIm8QBnB5Wdl0k9jv1FrsWwsiKJEnmStNRbvkEb/eX4b?=
 =?iso-8859-1?Q?kohlKwzGHDS+g9mExyc/ZCVyDZdYKq9ui7EsontJLnxB5XAREFuKXotcRv?=
 =?iso-8859-1?Q?T5IEIo+vQifJpdf5+aqhQX6AZ7FjPEgMlhdhzN3uDCDiokPQp4/OmFSJOT?=
 =?iso-8859-1?Q?SPJ14slenuWzKUD0yzrUIBRnEuqYQlutlWWy3oI2/oJrheCgO3xbm6YUgv?=
 =?iso-8859-1?Q?gZglpziNFwJx140O/KrhI6DjRrptcXyuxyKG2nezbFZQBVq/rAXOY/6zqg?=
 =?iso-8859-1?Q?WhHYvnFL2PiCUsGt8Tu2VDJ1O4tasVmq2I31mvJ/hrmzIuUF/aSBK7kUld?=
 =?iso-8859-1?Q?gYyEL5BZbVoLup70WXas/G8xQuBGgMaBb/SDHlnV6e6WAwHUjJ8rOHgCEA?=
 =?iso-8859-1?Q?cMklalqkWrpSw+FZxAZcH+xsfxJFzcWYgig8qPhHiNIgZtDeG0qMuOMJGH?=
 =?iso-8859-1?Q?yQS0QWh9V1EQJxi0POzJ3vT8RZF44FWkn3EbzYps48jpcuH7ZAR4/EkbSS?=
 =?iso-8859-1?Q?50UMA3oazMSwjL5YM3MGLVR75+cpXJdQnjbhxqgWZg42YBWwY2lYdA4Lb2?=
 =?iso-8859-1?Q?I2W9Y8Qw3DABb6FBih6HiNrGTfdJMv48ZoLD+PPUYVIPiM8XTIG5jTpEVm?=
 =?iso-8859-1?Q?0JL+oDbukZw2bhP0bk7QNUUQ0PUCEVWb1vzii+5/i3uQPEaW63KmKjSFj1?=
 =?iso-8859-1?Q?k+fN7E158g9s9lCglLvI0p2/uGI/+O6P5QpMwii9QpF8xPfjDwrdUgIa0j?=
 =?iso-8859-1?Q?E1skPfxwejoUKs67Ug9xrnrS9DEohdyg+YTm8SRDYDuBWi0Lp4N9oFNrGH?=
 =?iso-8859-1?Q?b1UP/JskrUy8xpsh1nhysXiVfZlz5jnZLAlQPyhLDvv9gN?=
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
X-MS-Exchange-CrossTenant-AuthSource: SAWPR12MB999267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241f9116-a231-4a02-7f93-08df09ab1808
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 11:04:15.6575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIB8S2OH2/yIBjvDPamx3OrpT0IF9lgyBR4lVGp8lAOl+hRwEfQyCsowpb80S002+p2rfqNdQ4j3F4KdLoVDow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

> I can say that several people from NVIDIA are working on the ideas in=0A=
> this patch series. Ankit is setting up a team to focus on upstream=0A=
> patches for all of CC inside NVIDIA. I've asked Jiri Pirko to work on=0A=
> the PCI evidence uAPI based on his deep netlink experience, and Leon=0A=
> Romanovsky to work on the binding problem/adversarial/trust level=0A=
> driver core idea. They will share their approaches for solving these=0A=
> problems as seperate proposals.=0A=
=0A=
I can volunteer for updating and refreshing the TDISP state machine=0A=
part of this patch series based on the Jiri's uAPI.=
