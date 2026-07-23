Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC67423E87;
	Thu, 23 Jul 2026 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799091; cv=fail; b=NjdZ8h8E7nsVGVua1/XIYbH+zymdx8qq8/ku3kgvanvPttYRwAi9CBqkcPmUkzEudh86HtclBW69htvdFBj9gdlOZUjWqzAHDd10zpxIl8vSsv8s1imkKRHkhml6b+q6SyDcq3AiP1rTG2fSRFJ6rCYTwYxddUk2Fd1rrGFhSMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799091; c=relaxed/simple;
	bh=pcs/NyTiPRlWjY3OcwR0vnHk0mKti2e7mE9GFr1UgDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VgwUm0+8qX0nJTFSOtmocRvdQ+BHW6khjqmwPnWEooBvXkJCJzl5pckC9uzhwOBHO0i5fdgEV96xYUXmQiDHORV3qfaw9jPK6UuEVXxl4wnk5hvxILkcoiRgU6Dn/i7rzx9I/S3EOktNS0zn1IyIRJS/WQWm3Y4L3zX7F99/62Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dn1BDKFa; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dn1BDKFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784799090; x=1816335090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pcs/NyTiPRlWjY3OcwR0vnHk0mKti2e7mE9GFr1UgDE=;
  b=dn1BDKFacHQ5UmxtTIuIm4ibBR+peWpI5chpkVR29cT0grhhJsIv+L2f
   eEuUFRoe3SocPSysXca5Rv3F06mkaJFRROvpHeht5z+jiLqAslaFuoNxt
   rJO+R1CTVCf21n2IznQ9G3q4aZaYBDtSsjKVYaftVzQRpHgGZEhD7Zfdd
   qxF2ygxRylzAWkWOqiBWb+YH26iI03Glcto0dfZGvF/wE2fE9n1XbijgC
   Zr5UoTz4VQrHXAVu8OTdCAuqFUwt6CfKGZ9dF63zbTQwEQxeQvaHiLcS5
   EbDSiBn94H1i4g+dGM6TB/n3TKMHZhlG7mM0oLVd8FYY2lh7WYyzOSqO7
   A==;
X-CSE-ConnectionGUID: gYjduUfMTA2Qy84PEqNXbA==
X-CSE-MsgGUID: YILTCuL3TWqKCLYhZ+XI2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85395079"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="85395079"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:31:29 -0700
X-CSE-ConnectionGUID: 1y1/MdycQTK5CLLpf1p9Hg==
X-CSE-MsgGUID: 5/QsnuxWRwGoRV8r/J6CJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="262136448"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:31:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:31:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:31:28 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:31:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLZrW9z3NyYjPfH6670KFSbnR9Zg7h4dDcs5/ywsSe9GbnHf5oWdJuOfYjuuyzwrvtKe5puMHaZTLv7KPk0PXQRQ/rZs8y4lHxqbNGc9pR0Ftp4gjC7gLVaU7gmZO1E2PcaU/uSgMlwf36PMaMWSQireVfUAH1nL3QbeZlHNB4aCFBtl9khEQ5QFmFxZmMXE1ri+d+h8XBVGRKKO9wCHNb2TQl9Ivw98h7trHiEa7Q6qeps3D//CRPBIZsTsERnw9EI4HTNyZvO9xJLgH4sdm3yX+iYNARS4tb96VZQBHVNBArtl+5Po18DumOQARQejLJKvwssSRMyNc85X91eIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zHQSkAVvmKpPXQ2xi1GG5gms8CbMKhgbGgrTZX8UWk=;
 b=BxR9Wu1DDJMiYBT4MKAao2VSpBRC4JmvhDzlZ1/APqdeD2JcrfFKI2yRm/NwtDucpd7nRKRk9hhlBfUP7Zc3PozzfzNd3xNAy0Df078IXzdixdHSspHHAxQaiA13yl1o06j0dLxZgCCTa72+Gn314OYT2qFEwkJ/58xk97IKtNctu6sVw+apE7PERSYaYCC45hRwR1Nmi1iu4m1wQ3wjrIxj57a7FyrN/IIIbxDOxeKWew3yxShRHJ4kUgiDS4Inw8GH9uX0hZumfBosjrqoi9ADadPps9SjGksFviYsMhm0E9ETpT8HdTMFfyha8H8iDh++HTUHLsZexmYv8OX4+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9016.namprd11.prod.outlook.com (2603:10b6:208:582::17)
 by LV8PR11MB8463.namprd11.prod.outlook.com (2603:10b6:408:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:31:26 +0000
Received: from IA3PR11MB9016.namprd11.prod.outlook.com
 ([fe80::bb82:7df8:d6c5:5ce0]) by IA3PR11MB9016.namprd11.prod.outlook.com
 ([fe80::bb82:7df8:d6c5:5ce0%3]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:31:25 +0000
From: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "Srivatsa, Ravishankar"
	<ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>, "K, Kiran" <kiran.k@intel.com>, "Alex
 Williamson" <alex@shazbot.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v4] Bluetooth: btintel_pcie: Add vendor_rst PCI sysfs for
 PLDR
Thread-Topic: [PATCH v4] Bluetooth: btintel_pcie: Add vendor_rst PCI sysfs for
 PLDR
Thread-Index: AQHdGXihxqU0ksAjt0msAl36AAcd3bZ6HUsAgAC56nA=
Date: Thu, 23 Jul 2026 09:31:25 +0000
Message-ID: <IA3PR11MB90166865DEC5332EB1ABA891FCC02@IA3PR11MB9016.namprd11.prod.outlook.com>
References: <20260722012158.813793-1-chandrashekar.devegowda@intel.com>
 <20260722221910.GA753179@bhelgaas>
In-Reply-To: <20260722221910.GA753179@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9016:EE_|LV8PR11MB8463:EE_
x-ms-office365-filtering-correlation-id: 4bd65f98-f297-42aa-f678-08dee89d2abe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|4143699003|10067099003|6133799003|7136999003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: tTznQjc7luRFmos/h6UkMNqwpz8tapfUoDe5WLfY/nmq5qCavLY6XRG0f7rCjYbdaIe3GcL76g4D0MOo41YL7WM7NJVqmGlIgd6SqweKfK3qdeE0oAqfokjc1oqYa5SjFfyxdbMX5o6Vvzp6PXBHMULQbNo5D1Jxi8WO+VcoW3VNzJ4qtd/GTpHVWdAKVsWAIY1S+ONIoxHJdWjwo8K7rJa3zBg/Oono8wL9BZ+lXM0Cy21KX8en+CA9UfNUlyQTpdxTBo9cbud5/vmHtztfiBGKPXOfMhr2oWTXOJzlwjBSBA7eNrdZ02Pbovzz0QWx5VPSt7g9XeIiNXQ/4aLylTvg7xDaLNKI4iDFspSHTpPY3Ka9WJTp/eZg5yDQ7VKyd0DpbDx0TH8tnlVlmZ/bC+5E0NrTgPEMm5OUABkfiaDlugXbCecatiQzeIBqOBGHzgGajIZqpW8fMFIV3NCMid+inDFAIGYtoUuSEMy/Gc5QLa7lj+5ElsFUh0cpxKXmFXhRXcRSn5BeZHRyOhSfrxTXcRjqtHBtBX6+gxzW3kZl6RhFfKgpSHoIupTqjw+ahH4/18AzLwh+KBNmj6Hc2VfF7lKf5DKa3T5TvvHCpcOmm1/oy1dz+wngPlwu0ffeNx0yXNbpk6qlZ9vm/L6hJztMudW1a/euJUprBLFaViu9QC8qZf7rpeh1ww+E2jbeU2LSlqUwci4qCFWFm2piodhGEVNB7KNyU6lUYY19SK8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9016.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(7136999003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PUGsbko+CVxFVhQ/nAc19iy1Lf8vuMagP4t+L+X0/otq/wnsettgs1QeKASU?=
 =?us-ascii?Q?mqxTRbOuGpKHuvJ9e/JYvnTd5VxVay7swsasPZ0cq/v/ePnch2tyrZFCW/Sm?=
 =?us-ascii?Q?8RBG7/XdbABHmVh/MaqpjWNOID9ZEpn8SXwlpfqaIS5p67G8MaKbRUWO5lOl?=
 =?us-ascii?Q?h3lFx+EmwbgtrP/PcAk1Qe0ZJttnbowHSoR164aRuyAEwGFoUgu5cZLuhdF5?=
 =?us-ascii?Q?ENv6Z6ReGImR28NfDadPH6TGQCPUIEmNWQIm7WjJyF6XEgCFgnLlEqPZiBvN?=
 =?us-ascii?Q?eePyKNNQASih05yEvXK8J3Gv3w9SSB0wDBWWI6ZKkIIB++/Ou2TeyFPVB0/t?=
 =?us-ascii?Q?LJumyJlfYYb6lb3E+saYoA4BdOAUfAUeBA4n8HDh4Kta2a1QIaM3kSBQFNFC?=
 =?us-ascii?Q?UPpj1zcGJAAOKbyQQGXVzpzRkaDKln3TiCURAm5uYVfJKdb3w5kEOuNcB/Il?=
 =?us-ascii?Q?EwJ3pvIronfb2dTRUV4dogtRXYgI28+6crZW6NKZGswFp6yDoOB8io0jyJdZ?=
 =?us-ascii?Q?T4QcnkxkKLbFFxCH95HfBsW/vWYvwIv1utmciyNtfQQ1BekxSFJ87hzV4HhG?=
 =?us-ascii?Q?0LUkXb9Jjq+SvpYbtonmu6sG86Y3qdpNBQwM4i4XVCcw98pEmi4GKX5by4H+?=
 =?us-ascii?Q?S1BlgZAkd81dGlrW7t0uUUW1N6O8bOoIvLKDx/TPprHP4Ji4KvzHCMIbx9c6?=
 =?us-ascii?Q?jclkZzdsytTdOEQRe/Flj9jWW90cj7s97nielKA5cy7s6MlqCOC9lXgLeDYA?=
 =?us-ascii?Q?3wmJws6xSDh9e4wdrr8QXgCpEnhzmZBFKOtBLeQqGcLcLA8GZ8Kk7CroYw33?=
 =?us-ascii?Q?jafkquSYOHbWUh2cFPREAw8DAT/gLbC7UkK3Sq0qoLHvspF83JiNZQ+fiBFP?=
 =?us-ascii?Q?sKUg5t/sZ3rZduYLAYiIMxqlYw2a6gnkK8Ehgo+Mm+0q6q8AWS3Y/3FcOCDZ?=
 =?us-ascii?Q?Pe0uwoQlQhcfjTAbISLTdIRgQuD4uTOCjDOU6rilFJF5GY7gtEWVo3wIhWxI?=
 =?us-ascii?Q?VTQvdbUt77Jzvl67uHlHtcNHC5E0owx4sAXW0meXZlymVCQsTsH2TFiyXteW?=
 =?us-ascii?Q?8xocCrineaIGQzr+tAR9eR2F914t24PJnHbPx/5psPTMLgb+O79wafBuvvT2?=
 =?us-ascii?Q?MiZuZ0aibzKMOExpj2S8C+PH9xPSFULaZLB8jSkLdjl8asJtYIvDl+Wx+scW?=
 =?us-ascii?Q?vPnJeJt+qOs6/6kjQSMJ4NibHYlViO2+5jTANdDWkMm5J+CngpflK5Agt/Lf?=
 =?us-ascii?Q?UsjxZes53G8tmfAvyKJZ2IR15sKDRhvZDhXJTIVkpPpmQmPfDBAZ2ioouTh4?=
 =?us-ascii?Q?J8VSqOru9TPHAyHq2Jky7WWcf8RKZMrMnkJuZfTMPaCASH6NbmiauE8iHwR7?=
 =?us-ascii?Q?tjciIA9Ojk1zh009g9nUuUMzmX1wG/ushGJpTVeRRA/+TaSRTabBuf+20+LU?=
 =?us-ascii?Q?7A2RMwNJxqvFFc1GwFm6mh05sH8KYFR5/EgGmNsqz+fVZ2GPIafORZdNPZkq?=
 =?us-ascii?Q?hyxx2II+wmeL4oBtzIBTQxA98ejgo3E1ZDNHAGaAZcRFOrbhW4C56+pCiaES?=
 =?us-ascii?Q?UJxqbQnltmBp8olFzNJM9jv+yOyHbDJMDAoDGmrxA7el0Gn/Ou5b+2QdY2ro?=
 =?us-ascii?Q?psZ8d4JEoF/TsP4F6xrqlEDFYW20unAFE8fdxeRIFwKrhDd4ZmRRePploVnv?=
 =?us-ascii?Q?1MmAs2hn/0i2rH67D7n87ZQhHRCcIalYrvT7cmKH1WTYZRdTfCXfXsHZQ3OE?=
 =?us-ascii?Q?iCCSy/D9S0KX/ADgeG3UMOBsTiX920Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bRHUMPQlZiE5705LRGglxXwbESzqPnH8GH9jDR7hO3YxgwyfCy88hIOnSEp93HMa0YjEvUgBCI7UTeFuAowU3Nw0iO5jrH2gYnHcIfZWlW3QowwpU/a9ELOCRWfgVCk9kSPhgXLW2HzS6Yq/bDJA/4CrjXs0gxzN71Ofo4IcPT3DuKdsxmN3FgGY4ev6UK2as1JuZZVsT84+EzhugU7DtjgUrt1K9bX4a5LPdE++CmkXBjywx4VtXKYWOWm2NFO6KTVlZmKrLnbRa6o4lCK/ySAe8a07mZdq8A86Xj1LZvIldVX9yTr8IkgC22H2DZVZNPfO5ggo9jCCuB2siorkmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9016.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd65f98-f297-42aa-f678-08dee89d2abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:31:25.7743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Te2bE7y6fl/8vpON0JbyEtyQHbiXNmLMlguAM8cJ0bYn5eOPVGmaN4T0Aem7gwvOs4h4DhkdR9nbHur+a16FSiGkUlKpkaa7hZ8b7M9cak975F+fyYBXksL9DxGJ5RPj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8463
X-OriginatorOrg: intel.com

Hi Bjorn,
     Thanks for the comments

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, July 23, 2026 3:49 AM
> To: Devegowda, Chandrashekar <chandrashekar.devegowda@intel.com>
> Cc: linux-bluetooth@vger.kernel.org; luiz.dentz@gmail.com;
> bhelgaas@google.com; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>; K, Kiran <kiran.k@intel.com>; Alex
> Williamson <alex@shazbot.org>; linux-pci@vger.kernel.org
> Subject: Re: [PATCH v4] Bluetooth: btintel_pcie: Add vendor_rst PCI sysfs=
 for
> PLDR
>=20
> [+cc Alex, linux-pci]
>=20
> On Wed, Jul 22, 2026 at 06:51:57AM +0530, Chandrashekar Devegowda
> wrote:
> > Add a read-write sysfs entry at /sys/bus/pci/devices/<BDF>/vendor_rst
> > to allow userspace to trigger PLDR (Product Level Device Reset).
>=20
> IMO there's no need to abbreviate "reset" as "rst".  I'd rather spell it =
out as
> "vendor_reset".
>=20

Ack, will update in v5

> Several other drivers that add files in /sys/bus/pci/devices/ have
> documentation in Documentation/ABI/testing/sysfs-bus-pci-drivers-*.
>=20
> It seems important to mention the fact that IIUC, this PLDR will release =
any
> driver attached to the wifi device that shares hardware with this bluetoo=
th
> device, do the reset, and reprobe the wifi.
>=20

Ack, will update the documentation and mention the impact on wifi.

> I guess this can't be integrated into the generic pci_reset_function() re=
achable
> via the sysfs 'reset' attribute because of the fact that it affects both =
the BT and
> the wifi device, which are different PCI functions.  But I cc'd Alex anyw=
ay since
> he's the real guru on resets.
>=20
> FWIW, I learned a lot about the idiosyncrasies of these connected BT and =
wifi
> devices in this old conversation:
> https://lore.kernel.org/all/20250314101613.3682010-1-
> chandrashekar.devegowda@intel.com
>=20
> > Reading the attribute displays supported reset types. Writing integer
> > 0 triggers PLDR. Any other input is rejected with -EINVAL and a
> > warning log.
> >
> > Signed-off-by: Chandrashekar Devegowda
> > <chandrashekar.devegowda@intel.com>
> > ---
> > Changes in v4:
> >   - Rebased on latest bluetooth-next (6f55ad8fb0ac) to fix
> >     CI apply failure
>=20
> v4: https://lore.kernel.org/all/20260722012158.813793-1-
> chandrashekar.devegowda@intel.com/
>=20
> > Changes in v3:
> >   - Dropped reset_type parameter approach from hdev->reset()
> >   - Directly call btintel_pcie_request_reset() instead of manual
> >     flag manipulation and schedule_work()
> >   - Accept only integer 0 for PLDR trigger
> >   - Handle schedule_work() failure: release pci_dev_get refcount
> >     and clear RECOVERY_IN_PROGRESS flag
> >   - Fix remove ordering: device_remove_file before disable_work_sync
>=20
> v3: https://lore.kernel.org/all/20260722001434.804931-1-
> chandrashekar.devegowda@intel.com/
>=20
> > Changes in v2:
> >   - Added reset_type parameter to hdev->reset() callback (1/2)
> >   - vendor_rst sysfs used reset_type to select PLDR (2/2)
>=20
> v2: https://lore.kernel.org/all/20260618085016.9173-1-
> chandrashekar.devegowda@intel.com/
>=20
> > Changes in v1:
> >   - Initial vendor_rst PCI sysfs implementation
> > drivers/bluetooth/btintel_pcie.c | 42
> +++++++++++++++++++++++++++++++-
>=20
> v1: https://lore.kernel.org/all/20260612012832.2395034-1-
> chandrashekar.devegowda@intel.com/
>=20
> >  1 file changed, 41 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btintel_pcie.c
> > b/drivers/bluetooth/btintel_pcie.c
> > index 2e28847263ab..a412ca7ff3ad 100644
> > --- a/drivers/bluetooth/btintel_pcie.c
> > +++ b/drivers/bluetooth/btintel_pcie.c
> > @@ -2781,7 +2781,10 @@ static void btintel_pcie_request_reset(struct
> btintel_pcie_data *data,
> >  	data->reset_type =3D type;
> >
> >  	pci_dev_get(data->pdev);
> > -	schedule_work(&data->reset_work);
> > +	if (!schedule_work(&data->reset_work)) {
> > +		pci_dev_put(data->pdev);
> > +		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data-
> >flags);
> > +	}
> >  }
> >
> >  static void btintel_pcie_hci_reset(struct hci_dev *hdev) @@ -2791,6
> > +2794,36 @@ static void btintel_pcie_hci_reset(struct hci_dev *hdev)
> >  	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);  }
> >
> > +static ssize_t vendor_rst_store(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf, size_t count)
> > +{
> > +	unsigned int val;
> > +	struct pci_dev *pdev =3D to_pci_dev(dev);
> > +	struct btintel_pcie_data *data =3D pci_get_drvdata(pdev);
> > +
> > +	if (!data || !data->hdev)
> > +		return -ENODEV;
> > +
> > +	if (kstrtouint(buf, 10, &val) || val !=3D 0) {
> > +		bt_dev_warn(data->hdev, "PLDR rejected: invalid input");
> > +		return -EINVAL;
> > +	}
> > +
> > +	bt_dev_info(data->hdev, "PLDR triggered via sysfs");
> > +	btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_PLDR);
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t vendor_rst_show(struct device *dev,
> > +			       struct device_attribute *attr, char *buf) {
> > +	return sysfs_emit(buf, "0 - PLDR\n"); }
> > +
> > +static DEVICE_ATTR_RW(vendor_rst);
> > +
> >  static void btintel_pcie_hw_error(struct hci_dev *hdev, u8 code)  {
> >  	struct btintel_pcie_dev_recovery *rec; @@ -3010,6 +3043,11 @@
> static
> > int btintel_pcie_probe(struct pci_dev *pdev,
> >  	if (err)
> >  		goto exit_error;
> >
> > +	err =3D device_create_file(&pdev->dev, &dev_attr_vendor_rst);
>=20
> Can you avoid the manual device_create_file() by taking advantage of
> 23b6904442d0 ("driver core: add dev_groups to all drivers") and setting
> .dev_groups in your struct driver?
>=20
> If you can, I think it would avoid a race between the device becoming vis=
ible in
> sysfs (and the uevent announcing that) and the addition of this sysfs att=
ribute.
>=20

Ack, will change to dev_groups in v5

> > +	if (err)
> > +		bt_dev_warn(data->hdev, "Failed to create vendor_rst sysfs
> (%d)",
> > +			    err);
> > +
> >  	bt_dev_dbg(data->hdev, "cnvi: 0x%8.8x cnvr: 0x%8.8x", data->cnvi,
> >  		   data->cnvr);
> >  	return 0;
> > @@ -3046,6 +3084,8 @@ static void btintel_pcie_remove(struct pci_dev
> *pdev)
> >  	disable_work_sync(&data->hwexp_work);
> >  	disable_work_sync(&data->fwtrigger_work);
> >
> > +	device_remove_file(&pdev->dev, &dev_attr_vendor_rst);
> > +
> >  	/* Cancel pending reset work. Skip only when remove() is called from
> >  	 * within the reset work itself (PLDR device_reprobe path) to avoid
> >  	 * deadlock. current_work() returns the work_struct of the caller if
> > --
> > 2.43.0
> >
