Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D59038759D;
	Thu, 19 Mar 2026 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773886966; cv=fail; b=e0tn3Cwx6jsB4/WQLeKMGktijI+DB1R/kZJgZqYekIXME63pFYHyr4BBlR//3o/5fVxcdzbRMjSiJ0FRP5Bo0GGMQMvZA+UAN4MuGEg4Ax6LFEqMyKfWXaPWrwIwNWozTYDtKWoPpeS4hfFtxkf35KBQOMau5paLSusSYxQ1IfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773886966; c=relaxed/simple;
	bh=IDA4pV+/4wOGPn8nf9in73eD53gslQPd30x57rsCLUg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nOp5WZ7J+pVoxPdE8BZ1GvYKEPbZVIVS5WDaz7/qdKIaEIbOc9/G6XyUlTISzsYQCBsWYIupbbP+vyinws5E1zChVnGPmMQT3SKAoPqpNMD8jYkKE7D9AmYwslEV7YFg9jgl0XxW0J4/WIHl+1YH3uoJP3tJv/7l/2U/eDwvMts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWy7t1sU; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWy7t1sU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773886963; x=1805422963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IDA4pV+/4wOGPn8nf9in73eD53gslQPd30x57rsCLUg=;
  b=LWy7t1sUdgS9ba0woKr6Gvl5gn6+Fw67Ot5e7/F/1Td7gQZVhzULnVyW
   0PIx6K1yPWrvOambFK/gVxLpmZfZJkK8y5mZCQOgvaHfzfIfo5ySQVKzM
   slogDcB6qS6pFVF3FaMFqaWT6t8jusP+YXu0VX6kH4miRdds/JkZCiBK6
   x2o9qzF86401KO1Emwk/1ie9NUAJYD6OBhcw9U4OpxyW2PdjzPm/IghS7
   PY1ykXnnUsWsoRK61Z+K63VMaISWwgXnmKzcslDecZ+DXaZBU2mnuHBJu
   E+gMPT85IrnvfI0ryV3PW9F9drxrSbWfFf6YJEQa5D7L3dIMMDKBoQqbX
   g==;
X-CSE-ConnectionGUID: V7Vm1RtwTe+SItirbumhEg==
X-CSE-MsgGUID: wFuRIaSLRFOFDT9Haxv3zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75033684"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="75033684"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 19:22:42 -0700
X-CSE-ConnectionGUID: kkODUaqsTEuPE42CaSDF6A==
X-CSE-MsgGUID: 0lvrsIJHTO22HAQUESYq6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="253311096"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 19:22:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 19:22:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 19:22:43 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.65) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 19:22:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBlQ3tV+q6OnUsYsT0KZj0EDn+cBaBK4nljPBiYw1S5jGQTk+bs2s1Uegl3zc8H27zTrDNCGypK/hXwi7JDGqh+LsLbTrhEsBk8aiJpgy35uZfjZy0VHu+9Bl/Fhfsv6aAm/07Uus1+ombkylJCgHPTrbZ+vdoL4VNTkTN9Lsrxilm8H29JrnjJo7CbxdSmiT7ri/E0PEI6mnZB+cbWSXKvgQ4QaIiPn6WHLi6X6OuANRVi/SaLnmgrUHA55iPiqu5247DaT1HlqBYJxANXi/O4er0i9vDA7vDpGMCRiSWxnifEES4VdD4q+fPEMmL5G/sRk3NC2jPwAOAKph3hQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFWRyGYQDYkjQ8crUn1h8NwJz6Y8hfncW3saUbCVqMA=;
 b=GRsl7dQ4NhYffjU4zlNIlEfTskGkAAWctkqKJxhAh7ur9O2qZ5fnGEo6Iwv4/d6XeynWk95UwocZZroLkk0Ut/c4c2qiX5QKszZEvWF3Et8uGXOI3ufcDDDDQHCg/L8KU/eGo7cc8Bz8vMLD1q4oGIKY9qvyo961hDJlsaOP7qCAZ1zUEcnWxBOomfVxVHagatppdibaDNn9Cz8BPp+5jxBVhvm0q4wOWCOFDkIYI6nfy8w6nxSknUTv54C/QUFTfXnnvYPveSd59oDNWGsl8L5/5ZO8Q2ds3UWtVdhD17Da/avSAUAUicvUX5yp8WHN8AvuwwaCx7ZU+jZjGdX1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH3PPF7708D4D9D.namprd11.prod.outlook.com (2603:10b6:518:1::d31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Thu, 19 Mar
 2026 02:22:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 02:22:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>
CC: "joerg.roedel@amd.com" <joerg.roedel@amd.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: RE: [PATCH rc] PCI: Fix nested pci_dev_reset_iommu_prepare/done()
Thread-Topic: [PATCH rc] PCI: Fix nested pci_dev_reset_iommu_prepare/done()
Thread-Index: AQHctyLLyEh9aH29q0aVa9nUVwPgKrW1G2tQ
Date: Thu, 19 Mar 2026 02:22:39 +0000
Message-ID: <BN9PR11MB527657D79BF5B16943BCEC258C4FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260318220028.1146905-1-nicolinc@nvidia.com>
In-Reply-To: <20260318220028.1146905-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH3PPF7708D4D9D:EE_
x-ms-office365-filtering-correlation-id: 18aade16-685a-476d-ca75-08de855e64cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|83080400003|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: D4DyTqeoPbxaA36PCV41Y/lwD4/C7nQszKO66qhADqSxXAWEPGwzRPsQ4dXjJqgZG/dLh7PqSCWw/LORg3Z9WfKVDQk4Uy0lPdUu1glPseP9tUo8pjFP7n7Xz9o0cy93+6QzPyiXkA+dWQXbdFbFtaRxQpsJD/IdU+HQQoAhV/7LB5lWs4WPNTDPYmFzJTlzx8Keipl6JSeBApFqoAnE3ZMTvbxmo8NlDU0DLkQkJagfl5jzp/TB+hllFBlDJyhH70tZOrhHUi/VV0G8Vc19sTglHYxljKj08bI07ccoEpfLHzcuABQ4yhDSiwbDgkMTz/gUwaK0b5w+5Qkzf7SiNcHSRT7BB23BbzvhlYj4APav7QPNt7M4ESPM0yY15ZvqrWmrrtLNT9M0Z3BSdGFEJY6k2G5IYedNqkjNdbvGUMBTJjY+2DQbPwHErVb4p9ndJAK7PospPZoV3P2es+joTDqnVvOHBbmezRlL+oGJsaIekIXXIW0rgzMnAeZaUKjq5Z8/1Tm/19AUXoIy6cl/MCrLeGSXXINUbStTSCfllYwmzn8Sg1KWDyhSnhsxNWy1P2PHURima8y1UQLehZId1I+b4xJlvKA88TiBeGwXHouRyImtw7jkgwLLsx6Y5CHUl3nrPqxAkLjnkNQTAAD6rz23rr0W5D3G1vmJ1L6almr/pTnYmnolqgqDDaY1M7EnKT3uVQppEL9H6151s3srsHvKBMi3NFOI0TdP2Rvd7kBF3c3xN9Gb5dmCveMzab9Hd9PmQxSDBqnoCzHwYYdu6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(83080400003)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UHf0QewNYpLsCkLKPLK8MoV3BTHU8VIBonOXW+AEWunvAkY47a/q9p5395S4?=
 =?us-ascii?Q?zuX22MFczqcaryOMVY2fz0GSBych4TRXdO0lJXu7Jg95GBXYVucD8QEb4ed4?=
 =?us-ascii?Q?65/qXPbSrpjBzTa6RqvzNurijl8mfSIUAIWi8QXCZsYdZlwVEjBx9igsPhjH?=
 =?us-ascii?Q?iJKJhr5mozPoNfdYe32KZBdP5yGz2gWYfIH6p7NMxdwgOL8iIicjM6M/egM4?=
 =?us-ascii?Q?x2h3/0/fyB/EzrGDvZsxx/3y8JfsLuT0v7uqzDth8Uq8cij3vwbecdcT3uyh?=
 =?us-ascii?Q?HFxVc5rUOvfHBy2/7AsCdBEABletOkRMGJigifp5r9Er4W4zZbZVciS3Zyyq?=
 =?us-ascii?Q?drn8nAZ8dkl+Qlg6vQnKsxphu099Xd0HBqRTZ76XhTxz8GAD4u0XkwBlFpPv?=
 =?us-ascii?Q?dFjt97YGf+SD9GEHc26xvsyoW2qkYczdIaYcDsEqJ9stZye+6Jnf0kuYPcrQ?=
 =?us-ascii?Q?GiSL8rV49Bmmty0kH+4ZUK+kwvOMyzCnVn0MYRE549C68mViN0AzI8LndaOA?=
 =?us-ascii?Q?VavyoJWh3KZjY8yLjeriFe3TyjtrDKbpt9sKbnccpdBCWGgt/Qu7uy8K1rPj?=
 =?us-ascii?Q?EWqhp5bCKvVEgrFMU32qSgVuTqt1HDGP+ak+ANLDGlJlEMejmVpSzopSRElN?=
 =?us-ascii?Q?+/ftsaFx7/WtFE2KpMXiwNzTL3LrH/bm/KsYGr6K/RqpWmnx+TT0ToQPYnY/?=
 =?us-ascii?Q?lUyFnrSOc8vV1ZedgucSIvgTp6od6gzrnKazBd94lmrGkLwy6RIBesTm5Iqd?=
 =?us-ascii?Q?VUmhiT7K/F1LVwDKG7RUd6q3OAzAdCGUITZMA9vvMrUhrHxz0VcCCnPlM47g?=
 =?us-ascii?Q?AGpNjgn8lipe7+UpDw7SR7FQjhDe7rhYYJnwi01KWHEkczAMwAJxhEMNGoUO?=
 =?us-ascii?Q?jVWZINR6djakjJLDGLjvW9kdPC+L3ZQyKv582B8UCTCHycxqC9ZKQaqkCbTT?=
 =?us-ascii?Q?tTPoHKiC2dbWC/8PoQbQ1Q+rcFimvxmKf1ZAIKO+RlE7JQr43BBXMgLWon/y?=
 =?us-ascii?Q?8LOyoKiJzuzE0fbDjIqklCTSj4Tk7V8N7/Av6qzbWT0E9/6cYJ48Mx9ZNsNT?=
 =?us-ascii?Q?r6vlbiy9hdaiQBQQRy9CGz6xq8+5r8Izui5E9Rc8QB96RM+kQvm/EcYDv/KB?=
 =?us-ascii?Q?4nCPCTQCYtoOHV5OXJWbWE2foy83Rjrohhxo3oOgsJEuHSRooduJ1LPaRtbD?=
 =?us-ascii?Q?OHuhWuqovcM7hjTqOHK6WWZzmwAENtUveY+FYiuT65lQ+VfyDLY4mQk9cSGg?=
 =?us-ascii?Q?V5HIwcrKlFb+8USk1GT+6ARTtC4WEw5Ki8lGRAVUtNZt1rJV2PbnRei4Mhg6?=
 =?us-ascii?Q?W/OA3PVZJbhBlQxj6V8CeSnLMlHW/3SZaTZBrrRmTUzC3ib8YfkdW/S2VJAj?=
 =?us-ascii?Q?T6lnsXcgfDD47HrnFzdMxGc0L7hZRU+Cbi8UDHRNjZW6hhdpr7VQIXaYxWkd?=
 =?us-ascii?Q?oVpJdXLoV3sjTPe6inmCJUP4gtoxeWV+mWxGZsjj47Hi6lmRCn2P69wUk+c2?=
 =?us-ascii?Q?bUbC4+LP040xOxwi012OSWt0yagoVU4l5UV2B05QMlxRGMwrDOmEo2mcvILz?=
 =?us-ascii?Q?kXamIgRn2/GJ5u8LS6eem8LYAKTIMCeM5HCMEBIVVwObhKtTyB5U4FSoWXaf?=
 =?us-ascii?Q?Y8DNd/v9ok0MEL6W9ynVQcpYVknr1YWkb3x0Wj+8Oh6+tfEcLWN6glxJShAz?=
 =?us-ascii?Q?VFkPBFClhfWZMHcU+emMtBBZFu8iE1UYD4FI4V2pay6EdRaFajW3vF1g9C3+?=
 =?us-ascii?Q?Nb8d8YrOqw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: US+NSerVdZr5lBFLXTq9sWpJKCUavGrJwi2T+OSuhtTAQ+1Y6xq0ml+l39rVSEMgeX/JeNP1qJnY1jXhGrQtGJ5Ljrl/wzvz8qD9FGzJDIoeJ4c8uofS/j2T6MW0cXiTd6vqlz4OetaSCRrqe3azkE+QQJe3Igqyed3SYckebkXR3Tpaa11A+fRliz2gS4VcSvt2QWaP2sfTYJ0aA4AC9Ch6CEKIc55qQv5Uu2VPOCxUaU2hMI7u1ad9Lsye4D5HQkDJlUyDwxM2mKtO56iGv5Ruu/T1MWzxhpHNDWTndWabvbO6xkTb2+pTlYo0JzgkkZ7zhmQsfgOEizkRU6cQ6g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18aade16-685a-476d-ca75-08de855e64cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 02:22:39.6775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t14Votq9QDj+ketS50Tij/cv+RBR8KcBmLNsHZcXxplpO280YioM09CE229aZHo2YDHHWBwXAdxyFNqndC1GYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7708D4D9D
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, March 19, 2026 6:00 AM
>=20
> Shuai found that cxl_reset_bus_function() calls pci_reset_bus_function()
> internally while both are calling pci_dev_reset_iommu_prepare/done().
>=20
> This results in a nested pci_dev_reset_iommu_prepare/done() call:
>     cxl_reset_bus_function():
>         pci_dev_reset_iommu_prepare(); // outer
>         pci_reset_bus_function():
>             pci_dev_reset_iommu_prepare(); // inner (re-entry)
>             ...
>             pci_dev_reset_iommu_done(); // inner
>         pci_dev_reset_iommu_done(); // outer
>=20
> However, pci_dev_reset_iommu_prepare() doesn't allow a re-entry for now.
>=20
> Digging further, I found that most functions in pci_dev_specific_reset()
> except reset_ivb_igd() are calling pcie_flr() that has nested those two
> functions as well.
>=20
> Drop the outer callbacks in:
>  - cxl_reset_bus_function()
>  - pci_dev_specific_reset()
>=20
> Replace with adding the callbacks in:
>  + reset_ivb_igd()
>=20

I wonder whether it's cleaner to just make pci_dev_reset_iommu_prepare()
reentrant here.

what this patch does requires additional attention on specific reset functi=
ons.

e.g. reset_hinic_vf_dev() has a special logic waiting for firmware reset
done after calling pcie_flr(). With this patch the _done() notification wil=
l
be triggered earlier than expectation.

the original way is more maintainable with prepare/done equipped in
the highest level reset helpers in pci_reset_fn_methods[].

btw the AI review tool gave a comment:

https://sashiko.dev/#/patchset/20260318220028.1146905-1-nicolinc%40nvidia.c=
om

it won't hold if my proposal is agreed. But it still applies to your quaran=
tine
series which relies on accurate report of success reset.
