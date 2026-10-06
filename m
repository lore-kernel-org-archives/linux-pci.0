Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882DA3DBD51;
	Tue,  6 Oct 2026 10:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791280911; cv=fail; b=rXqBotqsjJb1WaYYd1P+IDNc1Xg3bIYoCQdMqqMpHqW9UMs5rbuP95r1ONvlIaKjBA2eeN5dngOFWmSdH3DoO26AmzuAu6/iIF1baA7YqKX4wbi7YTbCHN0CJa5wgeS/DvtjwnzG2WBhT0XRZmgZSP0kPMF54ufJUsPRU8HKo4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791280911; c=relaxed/simple;
	bh=C/oDcs7ybgylxFkEf+8EonFn8lGCdFSOQG02UTYucrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ND7+LewnGTmUTEr4uDJkod24ZFAnds2wKQUzwtxpmbIGy7RCFa4y0Un17ZRjToFbIE47qeK3JOKXfRGsRfnlYUu2uTZXj7OevsPNvq1B1O1wBN001nRV+5BDX5BQW7T5sKX2PQnbhP9GvOfFHqfVbSUEI38L9gSQtDFgBEc4sik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4hoakLv7; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4hoakLv7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hctFFB97RFtTv51LuBQEbXCqfShemcbkHCRBuLDsRM6i8UckVRqmdYnQuylaJjIiRh4WdkNfPAblrDuD4tfPWyuHs03REz9TQQSlnQg3HeSTLL2siYWLEq1U9QcwJNXHyLgit8XwgOuOWSzDk85nsZQs4gF84zqgovzFHYGy6Y/v24ETtFyhvRZMBhDtKft7ixivJzesTt9P4qYZC3yddzKRCAteH1dH3OosX0LDHFgFvnB2q4Z+0NhBWCcwM78wler34m2q0I4Yxx92Els55jHi3gUfSlJh5mtn8mRpMwMClPy6SCn9/8F9eLYvv/5rGDv9pkGJonqhSxsLu3a5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/oDcs7ybgylxFkEf+8EonFn8lGCdFSOQG02UTYucrg=;
 b=Vrsu29ce/UXqN+xaa6OZUVuuN27G9esFKRaiOjGw90YTiIb4QqKZqyUk+DsILsrfqyK0jDbbEgS70nbMUNHdZy+zkoR7GlAZo81yGCYGwDyDwwXw2UfhZCinT+hkmNu+CwKhHPEGesitoCA/Kd4EBJ4Fb7vWpe5q7oezb4nrE0xsckZsOaaPXzkqaV/iRc4G6hAyJ+sK6IIuI6l67SWblbAxTuJlipmDq2bfFeAiFLtzEU+P3fBDHe80X7d6h54/ih38m7gRIBR07uB2LrUqSj1tXOv6zQfgXlwKUJPKT2BqQz8p4wgl2zc8t1JGhS5ulGGS8fAuSEQnAiFFfTgsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/oDcs7ybgylxFkEf+8EonFn8lGCdFSOQG02UTYucrg=;
 b=4hoakLv726WxmpKn5IgSn7IUV1NmtQMKqZDQIiIgZl+HzADjo6l9kUCdvhM0wKAqBNWSG1vJbMA0DX/kdf8AwL/CAD4rQRHOd9j6rNRGm3blmaPa+L+E1iFtQ5L90BATm2mvTCv4QU6FhgLGtQ3Yk/nT0BqGHIDuD48zkgW3Cdg=
Received: from IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 6 Oct
 2026 10:01:32 +0000
Received: from IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f]) by IA4PR12MB9810.namprd12.prod.outlook.com
 ([fe80::2d21:ba94:fd95:5b0f%3]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 10:01:31 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Rob Herring <robh@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cassel@kernel.org"
	<cassel@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>, "Sanwal, Pranav" <Pranav.sanwal@amd.com>
Subject: RE: [PATCH v7 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Thread-Topic: [PATCH v7 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
Thread-Index: AQHdMrTvqo5o8LbSa0mOVXC/Q8D+A7bTTx6AgB0+LfA=
Date: Tue, 6 Oct 2026 10:01:31 +0000
Message-ID:
 <IA4PR12MB9810F0345A3E7A7D3F28ADCDCD952@IA4PR12MB9810.namprd12.prod.outlook.com>
References: <20260823040715.204096-1-sai.krishna.musham@amd.com>
 <20260823040715.204096-2-sai.krishna.musham@amd.com>
 <20260917192515.GA3283677-robh@kernel.org>
In-Reply-To: <20260917192515.GA3283677-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-06T09:59:18.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR12MB9810:EE_|IA1PR12MB9524:EE_
x-ms-office365-filtering-correlation-id: 50511413-64f5-4f57-e98a-08df2390cc35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|7416014|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Rg49t7fv+WJAWUk2YVQ5HfpuH3Bd1ylagHJBROn/soUsyc+eGvJVnO8sU4MZlVDuOh1w8DXDjtOetEz5UUtXBiPRyqe7oWxMSIUQh1YJWlkHtNh5LobI3YhtpRJFUIVfF7Kb1M4L95iy70W2poF7vfVoyJoX8ga19og76q1t9O5V0IGafztDTNJjwHn/4HGYlvdezSyZciJJkBFi1Yz+F90qBQsR9c+pm80wxczoSs0Iut4WBKcqFsb4Nr0ctNVsmHQPQLqILM3SECZsNoFRGM7B5W0n2/st1DYuErvMQsscLgu0LlQxjtAv95+6wV9V6CpaNGrKCAGQ1JhOaGRetrocYU7HLGv3ctd+N5uOzROYGvhkY3HstGhRtik8e3C1bE9yGAWGLlGF6x4oGnV9ZuNQPoAgK2VpZ86YtylUPqn+eN+YUnKCc/OlukMboAqxUiDxpcSa/NTjlu6lr/2M36BJxYQ0bKYziLx9thwWzlSg82Y/3fCjLZTe4DUICNP60sWYSAqbcqXP7w032QB1M0lLmXLSQEZc1WiNtamK3BEg8P44tksz+7AeKm8j6SAAlNJiGxy6lej/4unTxHWEu1bSRmp55r3LPQnbFtMSfJyuYgzlSGDLRuF4deFCjlbZICV5b3/HF8tK97RXR8ieO32b+VbprtzyIeUmWW/9AqxI/hcu9mqCHNhMGGjFhaKbG/MUzgG3OuIomNiXsiBtMmBSTQaixvfGo9bgOXkOYjc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR12MB9810.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(7416014)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?by4tCdp01mPpgHI///IrzcAWaIAqo0BqKjymVCwqW9q2m9ja/9AVcya0zbeq?=
 =?us-ascii?Q?T71KKxFDobc0DG8uwUvoY8gaqEnbK5P0GxYwpEWJgvNo15lUcK7vCJqUSb0h?=
 =?us-ascii?Q?cNXCz0+LV06fuQcuSsBhLuNZMgkGTC0ufqcB4dD7m+lIn5iiZEtq0+jqmbS2?=
 =?us-ascii?Q?iYpqTHmyC/sRR7fTg4NJJNE7JX6FJycyqCFPaB+6QKCLDSdbFhuXtO4WVXlW?=
 =?us-ascii?Q?iDXY90yWmdRTqMK6NrNhuNF+s349LfGSgq7FPgP6aIl+4miqb+S+Vx73HOn2?=
 =?us-ascii?Q?++qbdWcYiQ4SnwL6+R7LmkYQTBytMSs1G8rLKPFhR0QV0WMY3uEt1zvhHuBO?=
 =?us-ascii?Q?J/TwzQ+/w3Q1fyt1QmQLVedmadsZd4LTEO1h/dTChOhuV6PBL6dRRYiPhglz?=
 =?us-ascii?Q?Dz32a/WeqNmnzY1h5LKcSG66YAYwVdzOGENppu+9yDdMOlm5dkYLtBynj3G0?=
 =?us-ascii?Q?nWC51W/pYoxPDpEbJhcplfBPEQ4MVpp6D5LSGm2VlcdH5wBPdTyWeTGcmJSJ?=
 =?us-ascii?Q?TEnMGUOUyxIceTjtzaWBeKi0xASJvNzjshM3zPCGHMacM+NC6cj/G2Rem7h1?=
 =?us-ascii?Q?DQUc5UOY/T5MRQKbtbvacJ58kZtTA7yXxbnlqz0vHmM4dxSu3fmd31ewfIk7?=
 =?us-ascii?Q?WBwZJX+bT4EftsxLu/oFrL0CggXLT3Gsp4wbS+dYSqCehscw+HHh0VRT6jAt?=
 =?us-ascii?Q?RVsLA15gyHqX3tj9LuIWJFcWn1I4u3PotEOOzB5fcLAWZ0aya5GHIRDnzbiF?=
 =?us-ascii?Q?VQBhHovb+kwHZJSC1qnlaExo7ptgqRuz9UZzCDgb+xK4bJrIqu46rMqAK2ZX?=
 =?us-ascii?Q?ngxwJ6iYYk8XvOkfEazDH/y4YUK7cE3ZF12ITvb4QZWMOXz35cB8GzqYzMVe?=
 =?us-ascii?Q?vId5hzR4A4nMdfRVxjQ1gtXm6zQeHrDUXYxyqmTAUJgA8Z0ekUkFbJ9dyoxF?=
 =?us-ascii?Q?zR+4SvQa1Nv9hv+bU+QanZZjzIfW3w55f2eYaUfEaaSBWLYM0ZtWtdQ9gkfl?=
 =?us-ascii?Q?pCGwLF5A/uiPVBwl7rnyhfqaFmwTcRl0DD1TWRcNtZK+9h0EpCJQNkEb5Sgd?=
 =?us-ascii?Q?UBupCV1i8dfIT7i0FD+t5tYwcA7zPf/Xfx+T4AzNdRhP9xvEyazk6qXYDYRE?=
 =?us-ascii?Q?fpibAVtUK9NHl3724lDXImmvoc6KR/mtg0ZAe1d0yv1FMaBbG/N45XgaQDWV?=
 =?us-ascii?Q?26JzPW0c1IRQxgDDvLN1QN+tP5Tit6MsfYSTQlFizoZN2u12+jTI6btDj9tU?=
 =?us-ascii?Q?+yPxpVuXyoOF1GBp2cO2aZ3zod/ZEJJVOpze6mpDHj2QLq/npq6wPciM/wzS?=
 =?us-ascii?Q?bnifGencDw+A1vVg35rMNqU251jcXUIpKJndLgymOTp20el0gGylx9+SAY0C?=
 =?us-ascii?Q?UfDW9H8uctFCV7sC81wJdfpK3x0bBefEzC2f0dEnNzHoH3EuLqpGVFIbKSFT?=
 =?us-ascii?Q?bbvSZKrMA6e31iv6+eNnBpsajXDX2ZrMor8mHsjd4YaHPkOMfEVI7gx02Gyc?=
 =?us-ascii?Q?XObmumJFpara1flvEyx/D110/NVRNjhKuJ5swqrxYqNCLycC9y5r0NsjDB6z?=
 =?us-ascii?Q?bEWK017xMnm8+dvf8s7TcGI/2aNK9jf159GW5HKuwpOA+tfmQ9rD2OJvgx27?=
 =?us-ascii?Q?LkU+0aYUuoggOfewNI5t+/Tpcw2JmYVSDkg45Nz7fm+JjEibH6YC8rPIzSTo?=
 =?us-ascii?Q?KHZ+4zmyEAvqtMbIPWXQSpGMYg5sYueQomNkm62Roysn1vz4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 50511413-64f5-4f57-e98a-08df2390cc35
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2026 10:01:31.8128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eC6KdJm28B0dQFP6h+pcgV1NuoMIQ3FJ0tC4GVuXc93MuDkhGtKOx/FD5OvGWV2DYSfJ73W1DYrZjz7r1ce2vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524

AMD General

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, September 18, 2026 12:55 AM
> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> mani@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> cassel@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>;
> Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>; Havalige,
> Thippeswamy <thippeswamy.havalige@amd.com>; Sanwal, Pranav
> <Pranav.sanwal@amd.com>
> Subject: Re: [PATCH v7 1/2] dt-bindings: PCI: amd-mdb: Add CPM6 support
>
> On Sun, Aug 23, 2026 at 09:37:14AM +0530, Sai Krishna Musham wrote:
> > The AMD CPM6 PCIe controller is based on the Synopsys DesignWare PCIe
> > IP and integrates two PCIe host controller instances. Add the
> > "amd,versal2-cpm6-host" and "amd,versal2-cpm6-host1" compatible strings
> > to describe the HOST0 and HOST1 controller instances.
>
> That is clear from the diff. What's not clear in this patch, and I
> probably already asked, what is the difference between host0 and host1?
> Usually instances are not different compatibles...
>

Thanks for reviewing, there is no functional difference between HOST0 and
HOST1. They are two instances of the same CPM6 PCIe controller and support
the same feature set.

The underlying hardware and driver behavior are identical between the
two instances. The only differences are instance-specific resources,
such as register regions and controller-specific interrupt status bits.

I understand your point that instances are typically not represented by
different compatible strings. Given that the driver needs to distinguish
between the two controller instances for these instance-specific
resources, could you please suggest the preferred DT representation for
this case?

Thanks,
Sai Krishna

> Rob
