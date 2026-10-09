Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094EC44E037;
	Fri,  9 Oct 2026 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526482; cv=fail; b=GIumj4onOsBObGC2y6HfEUhcicQZEDA3RFe+tjig86Fm6a5hKQ28pdG8uwOwKLdTckXv10iQP9D//koVnXrCstUxvPRbMZZZc2yetdH+qzzpkAmFoUjlv6yUVfHvz+5z21ruAEABUpE7rphlO4vwoAXDAxR7bw4KMxZQ1dlgERc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526482; c=relaxed/simple;
	bh=BNcjoR5ErloMZIou5xiKPfaRIsnEQd2SOIB2xRpJUng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PdX03UKjMK5j8zO5iCjVKLKo7l7RT9nrqAmGafaGrz7HFLLJ/YBoaH0GyQFTDUhoK+MPFbhUF9nHg3u3ECKMTBQo/ixHOquibmr0bFnOwP6eFkV5OVy95KpxP4/PcNpNNOA6LtQQGo9CRpMWkj/HmjRzeUwG69/J8/6Yan78BCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bi4u+3q3; arc=fail smtp.client-ip=40.107.209.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bi4u+3q3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7gf3rSHH7LkOanEXXtpY1tJhHSfbH9YebEClKBS10NHPNinh+mzVUK957Mr9ZsYuOuvTc0BANVdG1WeYULyDvnolwSX6G7rW2eW/6aHQ1ihCjBOxrJJoLhWf1ASNWbJX5Qd6cDIUE+r5hTtAWsyfdT+YzE7DIWx2+iKBOBZmlXRfLIjlfjFvVqhlD/1d5xuoXkchJbjlgVYXAzrK9DTWCvWC/wTVPx/kIcDjFcHDeJ9uRyX0cVbpqGOHhcLSthRA3Kv7W62KQe0ZV4fbgPTua27oMOIZyGHS9wXYUW0NjNu6aqypf2TKCxFragcfBFZdP7SZ+98dV8qa4vY43v8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69Mt8z03/0zAgzBg3VxWQlNeZwBza4aNlJ0gNk4wBvE=;
 b=ufwd+iYuwORYP1jFZMbTrrnRNptYRiVLgkVidvJ8jWa/UkiCg68lTvoMB6BLkqGVmsgzBwWN/pjHV2rzBqbFaPCdQNE829d2CWVD+uv/jSiZvSHO8vIxQ3xzj0J8kGpdK3Vi+ql60gspaf61lwUy/xIJwHGq/lrS/vkIOee2S/bYc1lW36Hn+R2LdF4bP779mqjng0oYo4npu0eOXaN2qWJ0FUcEJ7DszeGsQ+wLePm6kxKPPCWbkEgYY9qwrghPEJodHhqw/JA4+Rd63HKsJRETdGHof46imYGoD7xkHv24ymAwLjOteKEYvWFtQRxr0qhnVSEhb3zb2umN75tWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69Mt8z03/0zAgzBg3VxWQlNeZwBza4aNlJ0gNk4wBvE=;
 b=Bi4u+3q3eB2V9DDoxbhcdKJqnh8NResF3Gz9d2jK+Vb5DXS9o4pz8FWALZRzTSKU6J2VyNZRNlAViE9kJi5ZU8fBSo4ieaSEJuGtDUWfPtPVZGQ1xbWUm4FTpmZ1TstThfBfhpJC1V/zrQdqPd0iWQ2khl3Doa8xYruAA/ThaRAFD831kYr35paKsz9t+z2R5UC43gdlEIrI97lvsrxVVBa870PoSMbd8RMebTA6jcBaWVJHtjI/zh9zD9vnMWBEeS4PAi4qPtKf4xUcfX2GctkcSR4E6+RuHpHU585l8I0Fx0UvTnIuIvyb9q61Q7b4thGGaSJOu8OPfSKFsAzJOA==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:14:34 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 06:14:34 +0000
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
Subject: RE: [PATCH v5 16/27] vfio/cxl: Create the CXL memdev and set media
 ready at bind
Thread-Topic: [PATCH v5 16/27] vfio/cxl: Create the CXL memdev and set media
 ready at bind
Thread-Index: AQHdRgqreMlvx76ncEy3JzzSnFJZCLbZ5BYAgBrr+YA=
Date: Fri, 9 Oct 2026 06:14:34 +0000
Message-ID:
 <IA1PR12MB9030A11BF48DD19D6E5035EABD922@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-17-mhonap@nvidia.com>
 <20260921201424.23fdd140@shazbot.org>
In-Reply-To: <20260921201424.23fdd140@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH3PR12MB8912:EE_
x-ms-office365-filtering-correlation-id: 1fc163f5-2567-4aeb-53fb-08df25cc9708
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|18002099003|22082099003|10067099003|38070700021|11063799006|4143699003|5023799004|56012099006;
x-microsoft-antispam-message-info:
 +XOS19Jde7FK9AW1GjCgsXC9GzxBhPWO/CTynHSrgWoq5uVoWgdKK5cOSXMmm8Nhqz+iXSxe0wENHJ/IJNxKK3ixG1Mo9Nivgh/vJ/MkG5Ckgvg/KqKdNPHLA/6bS+3sSgaWs2Pr4htDf6JDT9mCdT6DE1SwFGWi45Rv/w9DdVBnTOQJvETJ/c01MOlcaAzv697hz1J0c+gMpSRIk9nMZ9JPXi+1vCazXZw3SXKayC6b0VGOYBSnvj2O6+AiYE66q8ce7vvZAwzD8GTnOE2UNgbIpQhaO/z3/TjXrwu37iREKsA1UQAXhy6hYe9Pwm6dGyXtkBfOSV/rLbTm66KqwaYXNX7NTLywktTwYobcbkyIOZNImsmEpR8FPctL+4W2hOgwnMB57Q1p/Ofy4VQycO71lCDxDycejO08pq4I62OvASAJJ+IYK9z6Ef/mZmDlZa2HNh6E4vYSzwwpQ03K4Yd70P4UQNzYKlZN1vnZLE8pCBeqCSDc1Z3DcFhbsVypbbRv40HydfbIf3JuYoE3hlB1YLGaEpd9ZvFZrtKjSBfuJ2GdsqHEu884Lw4CGLYQPNCE0pdJ78WiVISCAbas1gh84ycl21hv4w2E7sgx+UJQgv69WUnzaf7Gq25FwgtJq3Yceg7WlVft9tKoi12XJwps1g0hCJ+FO9i0qH4iMV4YRLt69Ow8CARvhazFwyJ5sWl8JgIiYH4qlgvfTh5hu+6bSSH58FbYkLCwJAXFfGE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(38070700021)(11063799006)(4143699003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0NcwT2drN+rKN1Y9wobil+rCRAN9FaH+aEPehImAf2eanCO/TEiMS+ttZyG0?=
 =?us-ascii?Q?Ynchio98qN2dvpLM+56GvsN/sA+v4J2An4tyDkomRbIQ3DpyRwGry9NQJgYG?=
 =?us-ascii?Q?sRUcdNuLHrFMYxoTopvOzKFvoHhE41VC7+yVtoS6FD5EK4t5FpScUGR+8PBc?=
 =?us-ascii?Q?RDvCuW/aD2tenwMNgTNtCmGcKwkgESFpa2wcZJ+nujWxKPrcjm8UzJ83vDiP?=
 =?us-ascii?Q?zJT8RTy0+sb9A3wl/CfY4758/bzgsPFl9MQZdJT56B26tWexpFo/RGrOPzDW?=
 =?us-ascii?Q?YvhslaAvYxS9bXBLXGca/QeqR4MI1BfuiewO7e8mR0L9UqCSLV3CEso8gpnc?=
 =?us-ascii?Q?gfwwAlitr2ZK0E1rqEbGc195Wk/nrW1Cx4EKZ6zt/50hjOPEtLUsCpFsU+e7?=
 =?us-ascii?Q?pn6EqGNhv6C3xDI0+ROragrVTgAyZQwKA+iu4AIBwqg7O+A8nEQFJC5tauGI?=
 =?us-ascii?Q?xdLEygjOT1fwQhRazfNck0WixYgyFz2AVoVGKnMUTOosLpGHLaodW7iTo2Iz?=
 =?us-ascii?Q?BygAGu1B1v0hy9sXTsUFo54+Yjt9GfnGY5DMv7cHoeMELp3r3k/h4UNqEmXa?=
 =?us-ascii?Q?/nUHhpi6AodXYzogG1Q55mljnJDcPFI/puR20zeH5VjHlsVRtAKXzSz9yhD2?=
 =?us-ascii?Q?j/B6KFdzQcIuQiXXAxRY2bUEbhS8n+Ccgxu5zxYDP1uIHPqc/pLYWZlff5Nd?=
 =?us-ascii?Q?OF2HvidathnuNyzrbSgMKJWNXopzGR167mL74h+qDe4UnlkVwlnr4ZnGAvm7?=
 =?us-ascii?Q?Osxl1fsD/uZ3dBunAKD7EF5wXOe6z9f1aeX0bcQ5BKitBGIhgRIHIjT8AdB0?=
 =?us-ascii?Q?yFz+cBki+4q2Z8zFGn8qVL203aShHwhvnRKU7qLvz3NtMVWLmvm1OcHOhM10?=
 =?us-ascii?Q?STl2wGl9flqo8MgEsLO84+5eXKqRafH5EGgj9gxhfvuPk28hsmiuhRWYuMu+?=
 =?us-ascii?Q?uwdwNr1Kn28Dkjao4U/zDGZiVtLBQ3eq76n8n9pEIo5NcwvGoUaoEzDL8aEj?=
 =?us-ascii?Q?MZHOFLlysqwWb63zgmjI1bWHe3KWjevT9U/iuzbJvTJ3/PS8XKfTHxMMsPNR?=
 =?us-ascii?Q?RSc1kQy8JV8N7G5uCXHF7NkU3Y+MumkHnXb/0VuCBV9xRBcn/n0LQzAe1nMZ?=
 =?us-ascii?Q?l0XdzXViqkoacOFZ1qcv+EETWngZhclZ5wbGoqnAv3lSwq4vfuUH05LaG5+a?=
 =?us-ascii?Q?eCDLC76w8vBYm3O+RB691wYqrC5PtSXEKHRVsZ+PXC2sG1jP1b/KW/BY1vG8?=
 =?us-ascii?Q?GxG/tXy7UnXmjT2XDVhmFws/SpcdjEMm80Havpw40vjZ2eXJz8RmgZx2jHWz?=
 =?us-ascii?Q?DNta3R9n8D/iOgPdPtK+JDL7Tklocg5I7GODKywqR8SQq0ItbNLoR3gJmpyz?=
 =?us-ascii?Q?3ah9KTR/XbKD3/qWzWnUIFwbX+2NT3BVOnQoqm1g/9l7PqRqi26m2P0z0XUa?=
 =?us-ascii?Q?BZv6bEEUGNHMa/XsK3wL3weHMngnlIHLkh+uzGXbgPwkX3XdCWX2QGRJv4Xr?=
 =?us-ascii?Q?TgB1ZGXtMGb3W1KHIhYLTIyoH+sDCLx5qXqYBEJU9XLGaUmniglhINZU0mwx?=
 =?us-ascii?Q?/6Bc/cTs+02hOw+hbuEeTgfDVXlrRWk9+0y7p1GsOubI8v0gdf0uZhPY1Wla?=
 =?us-ascii?Q?ME71jAzyJpwaXzdlIfXR73R4Nhn+FLrExeEkzwJfOqNCOGPLulOpUk5jCxHs?=
 =?us-ascii?Q?9jhACptYIQDTYaLbld8Y8egoJXW3V0RWofI63FABSKdacN7Z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc163f5-2567-4aeb-53fb-08df25cc9708
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 06:14:34.6723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUQW7SmFbFY7pZmx+iZf9WmEoxY37XIO3T+Q5S0vOwGNI08ONJvCp34QkCiAPFQjWad8pW6gFy6LjYj2/qS+VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912


> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: Tuesday, September 22, 2026 7:44 AM
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
> Subject: Re: [PATCH v5 16/27] vfio/cxl: Create the CXL memdev and set med=
ia
> ready at bind
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:05:29 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > At bind, build the CXL memory device for the passed-through Type-2
> > accelerator so it joins the CXL topology and its HDM region resolves
> > to a host physical range. A Type-2 device has no mailbox, so there is
> > no media-ready register to poll: set media ready directly once the
> > component registers validate (mirroring
> > drivers/net/ethernet/sfc/efx_cxl.c)
> >
> > As per current vfio-cxl support, reject a device with:
> > - more than one HDM decoder
> > - interleaving enabled
> > - whose reset the host cannot service
> >
> > The CXL-core allocations are grouped with devres so a failed bind
> > unwinds
> > them: init failure falls back to plain vfio-pci with the device still
> > bound, so devm would otherwise hold them until unbind.
> >
> > A low-power transition would reset the CXL Type-2 function and lose
> > its CXL.mem contents, so keep it in D0 while it is assigned.
>=20
> Is it the configuration or the mem contents?  Isn't it the user's problem=
 if they
> put the device in low power state and lose their own data?  If it's our p=
roblem,
> what are we protecting?  It's not clear to me how we can save and restore=
 the
> HDM state around reset, but can't allow low power.
>=20
> This also undercuts your patch 12 justification for the open/close hooks =
under
> the rationale that we cannot sample the hardware while it might be in a l=
ow
> power state.
>=20
> If we do block the low power features (less desirable), it should also be=
 at the
> probe and dispatch level (-ENOTTY) rather than failing the SET operation =
with -
> EINVAL while reporting the feature available via PROBE.  Thanks,

On giving this another thought, I agree, nothing stops us from restoring HD=
M state
after low power either.
In v6 I will drop disable_idle_d3, the D0 clamp in vfio_pci_set_power_state=
() and
the LOW_POWER_ENTRY refusal, and handle low power the way reset works:

- On entry to D3hot or runtime low power, vfio-cxl revokes the HDM
   mapping and its dma-buf and closes the HDM access gate.
- On return to D0, after vfio-pci-core has restored config space
   (the existing needs_pm_restore path), vfio-cxl restores the decoder
   with the same cxl-core helper the reset path uses and reopens the
   gate.

With low power supported, for patch 12, the device can sit in low power
between bind and open. vfio-cxl will sample the live registers at open.

>=20
> Alex
