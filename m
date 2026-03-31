Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013072.outbound.protection.outlook.com [52.103.43.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806BC28641E;
	Tue, 31 Mar 2026 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774930263; cv=fail; b=mvWEEQgaQpyMKJpz8YHsx2yLDOipJxmyeCnAWTt9/qO4RaIvwZQDjcrHrino1xEW244zUNGxEQDD3Cit1oCxXqFFfkTj017Xw0FR956Y9c1CaGH0FDos2qi+5O3pXVRZuqXrXAhhMM/WbVA+PWXOkXJAgeAX6flCCAX9mdFZkOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774930263; c=relaxed/simple;
	bh=2MBxDTnTwFR+mluAHXJ6SLNp0/XDwjyzexrvYsNlkh8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QdAiV1yoFLKWWbVP7GNlAM6Pio/vHCBYLQ/VKWb2SuzkBxrrS0XsY1W81B+sh6NFZDc56Y4AHeOzXPZc1PsKqpo00y5qoJJe7B3dEQjtJivrfdtYl6jFbwhCz8BPb/EpB8rKqZZr1kQ2RuoNTJBoBHhxPEWsjgn7UGSVbVL5btU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fA4QlJOb; arc=fail smtp.client-ip=52.103.43.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fA4QlJOb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q36aUH0DSH0BeEihdkiDkIQEFySPu1HBB04TVG/ikoVcbocdyqOSvyUI1eBfs0fYLCW+XSbOaTe7swomjLJbImSA64CKLKTSPG/BmDpuQJYwRmf0km64XWJFWb7PwvlEXWIP5k/+SMKfpPwuT6Vv/lZaUeE6WshQlrIbkrqHNTe5MzebdHdGiy/3GHbHMLU37jakwfohNws6pZA8GUsFo81jFEP6KuOzOH3UoCnVjhxK/PxiXnBH/BAhgTmqHe65nAUBHz1QYxSj8U+yvF3bA39vFhHVE9T6kmlI1ao/ILmuUXLQoFHRIGH62Nbg8z1mhSaGRheOh6Jt6M0UQeYz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZP+EM36P1QV7HYBYfr03+wefF3nl0Tp0cFOn8Hb8yU=;
 b=rUSL7G19SRHV2AeWO5NI24u6SZjxPcIlAVkuEdSRBoK6w4FkKRroI8bcjtNZcysEnX3OduaJxcReOTSeUlDLbHczHAVaJvChTbTJ1a5zC9o3r8oLJWJpsN1HWRnfN8sobX+5apJ/wDpj98qNcfM4aT/b0UettLGtCUjo7F8HbylNdpyTrQrqvWl+Ciqh2y8YS6I/f5KlWhAmaqlONdoP5yPpfs/Q2ry8VV6NRWVnYVh05Y+b5qwczEMr1FoLOq+Nt96773YHShPaAlQTA1Uy98U+XukdDmbJ0+oy5DhS55nwfwRh9Dcxb3D6+3tmrhkBF8gizUNElXtngF9HsdK+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZP+EM36P1QV7HYBYfr03+wefF3nl0Tp0cFOn8Hb8yU=;
 b=fA4QlJOblUszwpfGH12D9XeBJsvsi+7e82wBQRGrpw+PJw9C4NHhMNUtFElgrfaA3lxKY3b0kO4mtdKWXeYwO6nJ1P32D5iCaWSHxl9x0IJ3KGysn3bK6w4uIo5ESLpSojiGa5atshQVBqTrFvLgcPUgfWm2HuM5NDNXW1dqZ3yWyZc2yPW40sQiEfsOMzuruep1p6s9YMkRA45LpRHQPM7ETCdehgK7X9SqjoVDGEB92k9e6F1jLhUQ3NljKttk/6yC1NDXmL9okVRb0aSUZKJDqQGDmy8/V/gwqro/xE/PmeX0lLLb6bh11fuqlVpNooAgKmRa3qjkLOWUhoFvtA==
Received: from SEZPR01MB5389.apcprd01.prod.exchangelabs.com
 (2603:1096:101:ed::12) by TY0PR0101MB4094.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1ae::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 04:10:57 +0000
Received: from SEZPR01MB5389.apcprd01.prod.exchangelabs.com
 ([fe80::f662:8171:9c56:c854]) by SEZPR01MB5389.apcprd01.prod.exchangelabs.com
 ([fe80::f662:8171:9c56:c854%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 04:10:56 +0000
From: Devilliv Kelly <kelly.devilliv@outlook.com>
To: linux-pci <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, myron.stowe
	<myron.stowe@redhat.com>, keith.busch <keith.busch@intel.com>, linux-kernel
	<linux-kernel@vger.kernel.org>
Subject: [RESEND] Handle MPS mismatch for Switch Downstream Ports
Thread-Topic: [RESEND] Handle MPS mismatch for Switch Downstream Ports
Thread-Index: AdzAxFzbDFveRKBHTcyymHPDK9IS2A==
Date: Tue, 31 Mar 2026 04:10:56 +0000
Message-ID:
 <SEZPR01MB538982EC382C61697D0986E08453A@SEZPR01MB5389.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR01MB5389:EE_|TY0PR0101MB4094:EE_
x-ms-office365-filtering-correlation-id: 7208989c-5129-45fa-7179-08de8edb820c
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd8VPwDsmXmpSwyPl9aRR8R+CKlAoplRnpSTGYDA9hVwxo1KjGM3TUOTA3yfRXNWbYuu4FCAE0KvP6TmtWSU1sVwJn8FQl7hX95pq1SCoE1GrzbOrs5DcXNSHvhHXzizCEAMBRTngPzfjdyG8jbqogjW20huRj3rleug72pvoRI7dVe46dgqcWwUH/4+hh8OxZP8jnpi9/Dx4lhz0/CFHibZvSXoCzYsLO+DEsp0HppUzOOS6/1a4T+Pncb4jYo1es1CYsG3JtuZfXyIxBeUtR4Q0nPivDyLG+QiFdYIIW5V2HsX/o0p4d2CnPQ9nT818X7an7/tXFlwzH1To0XsL+zjDp4yapC2vSuE8BkpkwjCf/mDXMKlFSrxZvC5FZXKGIyGc0mhkDNd5jfUyCwIsbGeOu5vxFy3o7QZg2y4WRQw61gMP2aM3hphKiJYui5oRRA2fcy2pKGcfS+mBsH/RQAlDNQBkP2aYsnpWK4r69QjQuypfQCwBIeoEx1f0W/I8LB79zAjhuYknvUiEYUMVxGa1Vv/B7fmuacorEJAkbUFoodMfJ49EgX60qYmboTxp5nj5afuCaZLkswZRxUs7rRhlfP8h5Sy2YzbVy6ukjQTH+RCgGOmQBoW1/LmGR6+fuiGDJc2po0vK9j408e06d67LQ4oPOdccbDkztGJmrTH/cVnCfrzk1oo/OVbCQqO5jJTswBs296dzeTvTGAwWrgmfzRph8/YaEXPkIhU5UmgjvBI5lOBq7K7cjE5danU+L0I9x/tp0rkmRhgnzh+nIOPfqEu6F6BFFnHvZrsowsALw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|24121999003|15080799012|24071999003|461199028|13091999003|22091999003|19110799012|8062599012|8060799015|20031999003|55001999003|39105399006|31061999003|10035399007|3412199025|4302099013|440099028|18061999006|102099032|3430499032|56899033|1602099012|40105399003;
x-microsoft-antispam-message-info:
 =?koi8-r?Q?jfI715w7OOhvNtX9y7I77bUG8vuipuT4iNcplOH0dDBQIAqfeHFdq8wrW7H4uM?=
 =?koi8-r?Q?WH83rcatJFUzxGFLM9QYOgk52Lt889ruyG3l/dYp9pJU5bbojACDrceD6muwBm?=
 =?koi8-r?Q?shoaXU0N1U2yHidhKqrcAijzINSUbw7W0gFHOLBorxWq+hDffeuveDY2hgxm0/?=
 =?koi8-r?Q?jHCGlGQOmE7IPZqzYbEz0A8nJ2674fI8iLyCACy/NHJLE4M4tZDkp7VCky9K7V?=
 =?koi8-r?Q?BZYHU3vJYPya9R0fM/Bl6xrBF9bkChpDigYx6wndrqJX5kx0xrROgeV1cvRbhP?=
 =?koi8-r?Q?ZGzVBcOTkUgwXeMgXYc8QZ0Wcpmwd7kuSp/V0ugU4B83BbCNBQXgCo7FPF/Usz?=
 =?koi8-r?Q?m3jcqigAmcgmEy/YshhBFcItbD3Ml2S5jAS2RlhCAPC09Cm6VV1kAxRvfLTXbx?=
 =?koi8-r?Q?Lo42+C5MVZdopgMlz8knhQEOCeStj2m/WgFeV/XcYgmWn56/M+Pz1M8SIZFcb7?=
 =?koi8-r?Q?07EvmWgjyr3EykU6Tk5F4n/V5Sw5CwTdO73KFG3SZf/BKMMk8cSiOJX/8Aiyiq?=
 =?koi8-r?Q?fQE0uQcxwL+qucTMKpRRxqk2Gdvq73nYjztwnLc/nq7NmKoupQtcjG4RjVDtF3?=
 =?koi8-r?Q?10fVNb9OQStjgzJNkjbOHuqxQkUUV9Eaf/0bRhRS8ZbalFfvR+a8THEmLVXhW7?=
 =?koi8-r?Q?ZWyL4oMww2r2NmfasSN+3iFOBJa31hbe/daNdMhFHYNRIvcPZ1EF+GPdz4ZEt7?=
 =?koi8-r?Q?vBtUN0leWyBeMw0kosCV4Gx5yGk0xIx/G+zdoJ/r0souFsh+8EVFWVhCNCt/vS?=
 =?koi8-r?Q?vASQ0LVc61JTXkhU025JRJdAd8OhaOMBnjEQBAMBaqDbm+LhunVsN1XGYxoxHF?=
 =?koi8-r?Q?2SL9KQf5cXmcYknnSFs7Fm3T4h+jdzAUU1P95WEP3neykFSwDIDi2GxAF70lTJ?=
 =?koi8-r?Q?HgjTwKDaaYcYhytGVu1VoNY4SWXE1pMFjFJNeV0S9UlkhQ2GtiN1pXjm61d8Zw?=
 =?koi8-r?Q?VkqLsUbSnUX6FnqZugF2BLD/qVxloJhlqbHxNQTtyniBFuIrFLpbfZTx/pPT3Q?=
 =?koi8-r?Q?swWKg2S9sMH3LH3soVcJlSniJwkFmJoVHIkm8WXJvqj0tdOYaSOa+roY2/afSL?=
 =?koi8-r?Q?LajJiXxzsmOj/KJ6MALZ1ZwZyOr6a8VBJjyUARDberqGgB+eaADN9Q4Rr/fx3s?=
 =?koi8-r?Q?Sztsw+YiEDcekK928Api32xoDR+Ay4xL78lbgcZEno5wTnZR3aOHm/PFA+DnJw?=
 =?koi8-r?Q?ev6bz9jRqeS72ojHt2WTOoYdsexRCVzOemicv45P?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?koi8-r?Q?33UD4BWK1IS7OSKlpcFct26VOgo/XiqUZ67ea36a6HkF/TClf7xDUQeLwr33ey?=
 =?koi8-r?Q?O3qYR+hrybbVyhXLYQztu7hkkpMr7Jx8P8wNH9R+cea6AE9rZGBn9sS7ppDk0E?=
 =?koi8-r?Q?61pX72uRvGm56Y385lsvG4d0zzS1VT6R9TkCUP4UMVXJTqrCq0J0h1agtCg7Q3?=
 =?koi8-r?Q?J3E2tNCE++TgY7NhGuV3BBWd6fNmjYzRJqgnD3i3XRp+vUVsdqiRndf/g55LPY?=
 =?koi8-r?Q?7tCaL3F2L/NEn8ecmF38qaKGa9TkDwUgd+Lo5c70eguorOQUrArSfun0lKzaEg?=
 =?koi8-r?Q?XatVQ/5MKw1DfiI4eKZRKZVOlUoBU3JQxpB7Br3dtQwJ+6A3J3M6f+l+iBNEW1?=
 =?koi8-r?Q?WXrMyJ8qgwAP+ciBiI1DYWBNwfvtfV2qbsrEreOtNCtFWp2mjP4bm56a3BAUGT?=
 =?koi8-r?Q?kMeknC8duvDoXq/I4LJXHcp3H2pu4nutP+qf6oE/YRpPRv2Hrm7K0GfYaMegoZ?=
 =?koi8-r?Q?uTwDcHO6Wg3z6frPmDhWDCeY11jZd9ZuzHAFlDP/72ljHw1vp5cchlTfmW7TgN?=
 =?koi8-r?Q?h/BUhfSPYQ67hRv9OoBR5KYCabgEUh7L+fgidqNFPfChIlfUFz1slYtjNuEc01?=
 =?koi8-r?Q?gXAWueQlRndNQ17dOHgODErg0KzIMKHmVytJFBhHtsVTLrorVBO3FSFO3cPtE9?=
 =?koi8-r?Q?FIpEDUr8WT5mcZ7S1O299Usxx1T2A+NSILbthD5bATKMUqpkgu2nL5lM4N35iK?=
 =?koi8-r?Q?tNJwoPIHIhFGmDzrZmNr9/5kPegflgwAQKg8W98VcrqpA6waM4HticDXZ3b6Pc?=
 =?koi8-r?Q?G2haPJvLjJxOUh9JBbeQFKfn1ODYO24+u21pAVaH/pYgqaLVfK61fCeu3P0ntb?=
 =?koi8-r?Q?KlHclLF4g4zaLxhNA9ISYCg3Xidp8UKoxQGwkN6rgPXLQ/XC+P7zPXMwW00X6L?=
 =?koi8-r?Q?pVWjAbfAxHVolTj5GbVF6J/dohy0UfTO2Vd1hymQ9bog6kDTkhCnkInqIpUMD/?=
 =?koi8-r?Q?aW3a6IpCa3KoP67GRm3ZYS4Hfs/RZmhMza32BO30qGZ8kyTzUbFQ9ytAE1Hlt6?=
 =?koi8-r?Q?42BpSKidqo3g53+e89XSjHCeZjoxPQsIHfnZX2Txnyh3jsAnWGq0j3/vvOdwb2?=
 =?koi8-r?Q?G7s7mlkic0jd89FXQ/2hQJw78CRX4j3KPNlbTiMjQTDDRvZrd17KRqZ8apOrNl?=
 =?koi8-r?Q?Shz0wns1idK7CTxPg3B5sWDA8xcj+XrPMMxbrMkoER6dvSWbj0mR/EJ2J76WWl?=
 =?koi8-r?Q?FQBiVkk2GHQPJhaILzIKAtwx7i0KM32JVb9EYYrP8cNaVQ5T8gN1slFEZg/7yA?=
 =?koi8-r?Q?6MMEag6dNZSmai1DxD+31egkdxj6/m8ptjkChdTHvLZ2W6NGEMz8IgScFjHdzf?=
 =?koi8-r?Q?jI5CHc60Y3+0LZiOPjEcY1LuZ5GHA8GhjYlFpEdw/d7n8iPTGjyy7eZih+OVbb?=
 =?koi8-r?Q?bPs9RiintS9fpw+RbjRtr5JnK14GN8neVxMClmcxV6mJ3v?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB5389.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7208989c-5129-45fa-7179-08de8edb820c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 04:10:56.3056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4094

Background
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Commit 9f0e89359775 ("PCI: Match Root Port's MPS to endpoint's MPSS as
necessary") added logic to reduce a Root Port's MPS when an endpoint's
MPSS is smaller than the Root Port's current MPS setting. This ensures
hot-added devices can work correctly.

However, this logic only applies to ROOT_PORT type bridges:

    mpss =3D 128 << dev->pcie_mpss;
    if (mpss < p_mps && pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_ROOT_PORT=
) {
        pcie_set_mps(bridge, mpss);
        ...
    }

This leaves Switch Downstream Ports unhandled, which can cause issues
when the Switch reports an incorrect or unexpected MPS value after
secondary bus reset.

Problem Description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
We encountered a scenario where a PCIe Switch Downstream Port reports
an MPS value larger than what the endpoint can support:

  Topology:
  16:00.0 - Switch Upstream Port (MPS =3D 512 bytes, correct)
    =84=80=80 17:00.0 - Switch Downstream Port (MPS =3D 2048 bytes after se=
condary bus reset)
            =84=80=80 18:00.0 - Endpoint device (DevCap MaxPayload =3D 512 =
bytes)

After a secondary bus reset, the Switch Downstream Port's MPS unexpectedly
became 2048 bytes. When the kernel enumerates the endpoint device (18:00.0)=
,
it attempts to set the endpoint's MPS to 2048 to match the upstream bridge,
but this fails because the endpoint only supports a maximum of 512 bytes.

Kernel log shows:
  pci 0000:18:00.0: can't set Max Payload Size to 2048; if necessary,
  use "pci=3Dpcie_bus_safe" and report a bug

This results in NMI errors when the endpoint attempts DMA transactions:
  Uhhuh. NMI received for unknown reason 2c on CPU 0.
  Dazed and confused, but trying to continue

Root Cause
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The pci_configure_mps() function only adjusts the upstream bridge's MPS
when the bridge is a ROOT_PORT. For DOWNSTREAM_PORT types (Switch ports),
the kernel attempts to set the endpoint's MPS to the bridge's value
without checking if the endpoint can support it.

While the Switch firmware should ideally configure correct MPS values,
the kernel should be robust enough to handle such cases and ensure
proper MPS configuration for reliable operation.

Current Behavior
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Endpoint's MPSS < Bridge's MPS
2. Bridge is DOWNSTREAM_PORT (not ROOT_PORT)
3. Kernel skips bridge MPS adjustment
4. pcie_set_mps(dev, p_mps) fails because p_mps > dev's capability
5. Device may not function correctly

Workaround
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The issue can be worked around by using the kernel parameter:
  pci=3Dpcie_bus_safe

However, this affects the entire system and may reduce performance
for other devices.

Questions for Discussion
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Was there a specific reason for restricting this logic to ROOT_PORT
   only? The commit message mentions avoiding impact on "other unrelated
   sub-topologies," but Switch Downstream Ports typically only have one
   endpoint below them.

2. Should we also consider propagating MPS changes up through multiple
   Switch levels in the hierarchy?

References
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
- Commit 9f0e89359775: PCI: Match Root Port's MPS to endpoint's MPSS as nec=
essary
- Commit 27d868b5e6cf: PCI: Set MPS to match upstream bridge
- https://bugzilla.kernel.org/show_bug.cgi?id=3D200527 (original ROOT_PORT =
fix)

Kelly Devilliv
