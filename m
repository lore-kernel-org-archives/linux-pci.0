Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8A431A49;
	Wed, 29 Jul 2026 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317367; cv=fail; b=W8MO5c8FBjiGv8zc4qHXEvh61mvKaAOuavm7lIEpDPvILjSrO+WhnIsUvi/rhYfBf36aqEJDcFxPZX7jqgFzCskWL5CNQ2icg0YQwQnZiO9OitPPoSAVDbVgGxGNxEjjYSDIu+a1H2rA9KtkuRN4CPomFWidQ82zDRfRAWai3tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317367; c=relaxed/simple;
	bh=3oaYNw9rSLfn2KQ3u/jEG0PPpUgbELKhiwEZkFIq/Qo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gg+fcbTW6AA3f4Cc+6SToCuTYkaPGnXpm5axGA+TpSDnXkRVk06Rt1p/QYA+SRkoZcBcTXWeiEPBBWMKfoYgrIn/RskYUtbtqZvLnUSBFopmSCnJGSAzvXCab+TT5RwbWRJ/DZ20ET4M/RIYO6v9dirDTEpr6oIRCWJJCjP1WK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OqxIk+p+; arc=fail smtp.client-ip=52.101.46.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OqxIk+p+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYafX6XLB1ezn+t65An832POFBeFOLskdMlDJ3Q+LWz71sdgCYicIFIKJxNAMs7T9NVlsLtSuxbdyP1P4K9fEhHZVzVCqD6l/aJO0/Qe36XiJu4PbLD4ABnoat7pcg9VEBuATWZFcLGpldiKGlqCXWnNaMuxWoxNkxI8Elr4vb9MdUF14fk+whMNAVz2+w19QO5Z1zo7aNeixVz5tOT8fy++BrPrUIMN8iBWk9yKKnM79o5y6UNEQohDJSICYjJLpwT4MtZFw5x2lgCcriLNdizkE3OrtFyFtmART40G/LHEFL7Zv92Bu/r4l3Kqx/hauDthEC2eYsrd+IT8DEtUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUqXRKBdzWQwYmnE4SCKm+C2lB1DlfLcwB8KBull7Io=;
 b=s/A0oTayx6naTUO9Ht/IftGAbG/VucS9rwuqs72/R9l+eoXo5DwUS7NbhPE65RmjpbBvAueXxGzx0bSJaEJcvZSe01bRxr7EOaW8u0IdbXzpTppHY9eSkZpyXVQjF/x7MWe9DvIqlWyDDT06iZTZ7ThBdoaMJzt8ySxpVThiZhsd90RUygVDSG9+bIPk7/ufXUmoBPC/bvrJ07So+woPpTopmYwNULnc37IE+7qKqQD2K8lbbZMNaoDcp53cHmKX+TQoB33ckoXXIYRwH1CONnBF1z0o3j60KUxcbvUxM7Pu8oEkZsboErUO3su4i/nH5gCfgWjbXBY8eBqBzQHVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUqXRKBdzWQwYmnE4SCKm+C2lB1DlfLcwB8KBull7Io=;
 b=OqxIk+p+rkwUF7a0DGLXCK5zNIIy167z95G41EeW+ObK7Dl1IKQwzt2iIcFN5oYmkcMb1EA0iooZMeaW3D1A4Qlxw2W2/prPF7S9fE+PugOuAhnL17BaBvwxA6KXYPd/9YyoBE2aG1JFpLrhqOUmK3aUGlgB/CfbPfGjbkba68o=
Received: from IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:29:22 +0000
Received: from IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f]) by IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:29:22 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>, "Sanwal, Pranav" <Pranav.sanwal@amd.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: pci: Add CPM6 support to AMD MDB PCIe
 binding
Thread-Topic: [PATCH v2 1/2] dt-bindings: pci: Add CPM6 support to AMD MDB
 PCIe binding
Thread-Index: AQHdHs7F+BzMyBrQg0uVhd+MbYfh7LaDg5iAgAC4EzA=
Date: Wed, 29 Jul 2026 09:29:22 +0000
Message-ID:
 <IA4PR12MB98102A98BA9EE27E96D65397CDCA2@IA4PR12MB9810.namprd12.prod.outlook.com>
References: <20260728202044.1785986-2-sai.krishna.musham@amd.com>
 <20260728222951.GA1407610@bhelgaas>
In-Reply-To: <20260728222951.GA1407610@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-29T09:28:41.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9810:EE_|PH8PR12MB6913:EE_
x-ms-office365-filtering-correlation-id: 9a08750f-81ab-4d91-db90-08deed53dfa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Gb22yNCGx41kl84JY3HCFXo9ksgla8bWSkyMMpWN4bFLiJ3B0npDe1f0cPbrW63cVyW4LEzQqSlJxya2vTcggg8vnon1e0ZaZTDchHcFJAA0pOe7tKj2s4XmwmRGSikVwBEfeBdM62EXPmqqZBOX1kcyOgoq5u5DmokgQws6My0wGpuXi9vxGDSvnRK89OJquZYbY/QIxxi69qwcgqF1emSguKmAYa4ftqR+MNqC6Q7o5MYsxP96rN3FGlHnFnuIpMrQJCfOJsnyYpvDVdF6KIn1zHyGA+v7fbWOYHCvz3QauECRI0WP5EPFjzJ0TbcQdXIYmIHZY+zlXFpVb7rPXHAl3OY1HE/iz0Pge+wOdcO5EHQcteKDK91x9Y+MuKNaUCS6q1naE1akg57m7+nk3dXkc+t5Rx9ugoZ+rpc268lmzWIgm0nrCR2ktmYfXeHLGoGKH3Ww8HWASARGqQgNUX4Zv8CiQb9l/Jd6ekklcpZD/G9E3V+cj7qsP6kabDzy1Wgbl0vpkB1pcCWFhCNR/wNuJyUtmKyv+k5UcMZD8kCbGkA2Bo91I/vHNUxCiYzGBROvK+sylzI8m+7uBewAsEAPbUDijo/4C9EXhnrX+OYTg5NZFLHoaCiVa4koDWfpTccC9UFzBvunQiqpA3nkUHPCN/h/2kZJW32OGwr+pc1pl7GMb/GWqWQnm/lq61V8OApLGw/q5Pvz8IgbexlEQbE1LH8Uv/kTz9IpA4ivSOw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB9810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zuyt48Jrcn/neSEEviZ61Rjuw4e+UfWt8AsxBshv9jHEHKS+0adh5b6Uwplg?=
 =?us-ascii?Q?QAxXDH3vRRqqj4Chd4GJPv9R00bP0uhwHA5/5OTSL4ARVxiKH7/RSBYSVJhE?=
 =?us-ascii?Q?RE+QBjORbbsz7XTBHqeKOyPzr464LbyLovYAKfXOHS9rR2y7WOqU5+FhoA8t?=
 =?us-ascii?Q?RN1LPi3Nh8fTBA/EabMnjObcwEWd1f6MIiW1CZaL3flsnG3XMBb+DPzHvmhG?=
 =?us-ascii?Q?EwpoZkJAReDOO9uDbGpREZ/90Q1BUVOoCPEZGsz8ix6dZmf0IW7Y//+ZxO1F?=
 =?us-ascii?Q?KdjKbef8/P+OdQCxDFvVTifUl9VCBqkO7sybqSBZvPtbFXdX+yowGtTvh+S9?=
 =?us-ascii?Q?QdAwRVfYNNGB4Tv4sn4JsfpGTgQcYbVPAFImQ9Tkvk+xq4E0VzDYWlvQp0S6?=
 =?us-ascii?Q?OTmx3JpcKA7jaF1FeCrE2pBBfyiq4f/U9hOeyk/+V1nQCYlfj/QS/LzoxFHo?=
 =?us-ascii?Q?lyH7XXUPpKvawpj5JYNcSpEMrg0m3gWsIK8Hms/+NRzI4KvEHvt5vLdbZ4g/?=
 =?us-ascii?Q?9KIFIiO9ymKQ9ogb0TU3WBR+i+J2bdkv5pKIqpklZ+eQpRcAhQsw1cfNAVgJ?=
 =?us-ascii?Q?7ywZkt6QZDKBFVOBDe9LCWrNds9nDbeRJ46rTY/plK+FS6m+nG/NQ/C3smcc?=
 =?us-ascii?Q?wABToDF7P/h4zwrcpkpWHI09qfxdrFnDn3mJvKHxwJ89kMBJhrdVN/cTrf0b?=
 =?us-ascii?Q?0nXO3iHQYHPIfKulpgGmNM8T8wz3LaRi5k9WsEpDtjfB/Ee5SCoqnVbmnv/+?=
 =?us-ascii?Q?73p75+g2GxzKrOgEjqPz/obi6JN6QSooBvBmcWC1/OaogqET73f7zJUuyHGK?=
 =?us-ascii?Q?AajHkWZtfbLsA2oxZPigfgiCwzQKWjXd/RCMhFwqOhLN+45Q2AB1GylVptmt?=
 =?us-ascii?Q?DORcbkA13Wx2bDOf2KpJ2WC29Knw3MTR8sMYfSl2pMlJYBg3gQnh4dvuVyQX?=
 =?us-ascii?Q?0T7t3U2w0p71yC7YTYxWWWTOblIE5P6aEhiph2QQ4iTLxti1apNWik3VSbtw?=
 =?us-ascii?Q?CNdzAUgFLd1Kc36JQ9Pq4JjDv6GnZnPxWAlHzOdgxrWUltaU3I+REu0l+VTa?=
 =?us-ascii?Q?iwC3n0mPf/Ty40xPFkTwRyMut7lvfk3ukcCelC+XOJLHzkYNh2WLbCxGPFAa?=
 =?us-ascii?Q?+PLPReh547gTzMAPuujmOyFV0TDur8ctaJMLYfKq/dF3zTDkypfpHuTDGJeF?=
 =?us-ascii?Q?XiXt4GWPNBxfwQa1Cuc99oy5QJyoI7P9knsZa6HTcul7fTMkOxD/k5WHkGLh?=
 =?us-ascii?Q?XmJMKmmhHwwWanW7G2r/1h7ECseZI8rpMsk7fKKOqKlfHxhYr31W5oCB7g/J?=
 =?us-ascii?Q?PZkxyzAhTmc1sTMTXOVCXxCwgEbGe9H8vV3SFXiRfNzNiGxlckgh3Pyd4fKp?=
 =?us-ascii?Q?BtoTubvz2jGX1eJbpEppgjMcKocagTP7qFTBBsyW5fo17SxlJ6Rhzx8/25p8?=
 =?us-ascii?Q?fwySYG2WbkYv6kHGp61/c+qNy+qm6bqhcqZj+dSS/ELhFI31cuS8DkLSar1U?=
 =?us-ascii?Q?n+udSq2HS6LpNznaKw5YuSpbK2sQy1JBu3stek+FWt8fTfC7jThFePLjdLmN?=
 =?us-ascii?Q?Nh8XsTiQxpRq8pnKchiB8jTKaY3KqUSGjx72N3q23vdN9DKNnpBrEvX08vnR?=
 =?us-ascii?Q?Z8sXmZ6NsY8kc5nUta5+b5sucGjnm8/mQwZjfam6r9IcFwBylbXNoM+tDKRZ?=
 =?us-ascii?Q?yy3aZpCymrtWgE3zEx9XeaqvXXwhrVDX1U/ObNDqU2rEyQ+s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a08750f-81ab-4d91-db90-08deed53dfa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 09:29:22.3223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVSf/JTtBC7uNlFIIsDsyu88m1t/W258f7Ui+zX/QLjPZfrneZQ0SdoahWQbq8ZtKWs86hZ8XMs8eJywwTerOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913

AMD General

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, July 29, 2026 4:00 AM
> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> mani@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; cassel@kernel.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>; Sanwal, Pranav
> <Pranav.sanwal@amd.com>
> Subject: Re: [PATCH v2 1/2] dt-bindings: pci: Add CPM6 support to AMD MDB
> PCIe binding
>
> Replace subject:
>
>   dt-bindings: PCI: amd-mdb: Add CPM6 support
>
> to match history.  The prefix already tells us the "AMD MDB" part and
> the "binding" part, so no need to repeat them.
>

Thanks for the review, sure I will update this in the next patch.

> On Wed, Jul 29, 2026 at 01:50:43AM +0530, Sai Krishna Musham wrote:
> > The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe
> IP.
> > Add "intr" to snps,dw-pcie.yaml vendor-specific reg-names for the
> > per-controller interrupt register region used by CPM6.
