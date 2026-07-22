Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013021.outbound.protection.outlook.com [52.101.72.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4939BFFE
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704348; cv=fail; b=dVxmPPFmXxuCohXUPRU1fr/vjSAtog069nW+Ld8tVyHu77OGLjnftkWT9GBWfxjEWW3GpLVf3TdRPf6Ec8SYbMieNzGSDFOepIighrwVVv4EvhfxMXB33GX4AO8prjGrFY/7Sr3M2yE58w2LhYVXQonKtCgSmgMBYN/YBDzUJbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704348; c=relaxed/simple;
	bh=g/Pk/JMkKsiv4+CFLLxY0GObvS7NaspWEuNlnScSL+M=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CLWs8tx/qJRKQtgjI1gSOmGICC9MVXjupT96Z/rPhuu56h4bOZ9VUmCfwK3KYFMS2y41axiQ34vw0FiW3O0iuA6C20QN17LZDKEaPAjn3QrsJGKX6kX58DNMJsl2TnPkmT+vhCx1Z4VYGzvPLH6qFBpZJ88734abRRnQYfso3Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=CGgubfLx; arc=fail smtp.client-ip=52.101.72.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="CGgubfLx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgAySJJVfKuVUaT7dZXJuF/urmqqNka3yDNWY59WxeVU5NrFRS8Q5szA0NYfj/391U8dHX/4YnA3lWdO9zTqNzMeSwoURBM38AZFazPyemSqkjFP24j9Ps924qNWxoyXdA1XR0uO5vMtgVKGFhcmwGQgPfEwLV1FT/h+Dlzy64xjAC2r1WAFd0VFQmNAg12l9z2RReKOD1it13VuSzY5J1KbjaoK6mt64RtoJh6QGp5MPBtUaDji6AhwS/W81yG3ZqWRV6rStmbLXy4rJIQpc4Tuc5oYp2V1FvtbvGOlictl6Gju6W5Tsxk972eSea5HMTS3t9/RzWqkZ3o/bRAGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/Pk/JMkKsiv4+CFLLxY0GObvS7NaspWEuNlnScSL+M=;
 b=Le9vt0JAeKByAt8bwSpSmjaZgt1hsaxlXQptYvVPjLs5Js9tGdOSNrQrCfQ54+qAScnc/Lzi8AXDfsSQZjZOF7iLxKCi3Uw5LIoMjn20kkI+T0YJWOnPksIAgKWQEZBBNd4Jt4/KyCfIC+C5O/vkL3JInCpxeRPCWiXWN58mKrswT8mKSE3NP05aEArxJcK0lfbWaFXBZi+gQdlYVYOeoFQ6rOzdBkmM5Xt9myP+4Wr1WtNs7KwmjgJMGUQIGw9A3C+Ay2QAxPBA6b2C3kUWqStWJ1gHmeUcP2bdztH5pDKLYmoltX+MYoyNStZuJgyNvVlUM600VtadrscR7FwbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/Pk/JMkKsiv4+CFLLxY0GObvS7NaspWEuNlnScSL+M=;
 b=CGgubfLxQy9fizN1UHB4ymQw/pKWPnAAvuZ4UDyJVtdSlqj8lzFFHCZjbbz/snNP667PYsSqwPGnlHFhEKkwgiochlP3ixb4Iv6tEXHbOV5zhYh1+bGJTsfRbZfTIGX79i2wehrsD4rgJESQaoOI6wJ/AwpSMgkQ7KYrt8f7alx5A9Iur2HnHD8HxUlapCOqHlqPUHrnjOqtMi8b6vA2e5XW9u5cjWklZlQS+FfCSzaC6OzaOwIHKH6pVsUp91b4ws0AAvqEpbJLfSGXTKnMYR+/2hlYriopyDPwO0hXw5lbivVguLnhL4BSecH4IwyXZ+8iltPCNqriZVAzerRxSg==
Received: from AS4PR07MB8508.eurprd07.prod.outlook.com (2603:10a6:20b:4e8::10)
 by DB9PR07MB7260.eurprd07.prod.outlook.com (2603:10a6:10:21c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 07:12:24 +0000
Received: from AS4PR07MB8508.eurprd07.prod.outlook.com
 ([fe80::b9c5:4dbe:525b:4722]) by AS4PR07MB8508.eurprd07.prod.outlook.com
 ([fe80::b9c5:4dbe:525b:4722%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 07:12:24 +0000
From: "Jozef Matejcik (Nokia)" <jozef.matejcik@nokia.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "Peter Sys (Nokia)" <peter.sys@nokia.com>
Subject: PCI driver - hotplug of multiple devices
Thread-Topic: PCI driver - hotplug of multiple devices
Thread-Index: Ad0ZqS8kL9B8s/EbRg+HUpj9A4DxGw==
Date: Wed, 22 Jul 2026 07:12:24 +0000
Message-ID:
 <AS4PR07MB85083609845930FF12F5C79593C12@AS4PR07MB8508.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8508:EE_|DB9PR07MB7260:EE_
x-ms-office365-filtering-correlation-id: 756f04ac-bbbd-42d5-f6dd-08dee7c09463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|38070700021|56012099006|11063799006|10067099003|6133799003|18002099003;
x-microsoft-antispam-message-info:
 pJ4wKSPaywjiMGnNH6kkuSrPyzNYZv3QrxJ0M7Ho2z1qLQeKB5GGq/cg9Z2vxtVuiTKi45gxB2PP7MWq8D5guptRMJYIgTwmslhM/3Q+fdlPxpd9lFzEbIlCSyYdPBjm6t7RGGDyt7vEHoJK4Clwv8/6R4RlwRrufCFXP8cTnVA+CuZMmp+g9aA4I6Q9pWoOYjSh+Uck/FLOUDxHwocP1BxUwXzGjNG2MenQ5Ogliik4Aew1GLmLbQGQ/DYekHUNXXD06sd//Vy889sU8hUSL0ijNTpeou00mXh/U5mIi9wcZplTwwIQttOfWskutQz6gAK6R+LHcHH53ZPeRbowcBHCiCdsayJoScatjUht1VzJ/7+zjRAH+RG3sCtzmecx2lv3f6QJOBOPAVtXSWVCa7OqE8xfWHBxAqRlVIXzHbCWtlat4eJWNsYk/8W38b0ebw9w/ZfIH5t2IpiU7vPzbu4aAX6XG6E2a2PmehPd1iAcIVqSkLEGJg8r//wHnDYx+Ghw3vDnDMVvnhGatHFEeABrqjkXBFgkjrPGLqNkZ7YhYp10h/7AakNMBUM9NXAMVAPXCYlJUWcqphs+57Pa0Wz7TISfRv0EJIpYr+uZjeKFtIAWn6zKrcD0AzUr5M8mpIsHLLaePhKYww1sVGJYpVpytjv1VlS95EzklhlaEd5guHVBp7OWNuYUfZthjRDmFttJqVqOy8yQ9X4hiO9RAEhVJESobWMcZanwcnKgS9c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8508.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(38070700021)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BIg8XKMK7it5JQUVQBKu8vUiT+8Ur/Q0gUPHwZ3m+HDvtup6QFXWdhW1gEcp?=
 =?us-ascii?Q?EWj46Qr2USxogbg9uYvErNrse9JuRMgS7TvKt45YVfKZ3PTrvJoRk9rfhx2b?=
 =?us-ascii?Q?B0ixREVb9jS70kyYYiC3tKOs9MMVXvbzUycCqjr1uVUdoH/D66VN2yuaoO74?=
 =?us-ascii?Q?w0bW0m7mJ2v/KEuNkAfwD7bPL7nVfwtrqhD4TIXFV/0aXwaJyQRhTLl8+zZm?=
 =?us-ascii?Q?eDziI+RXNpj0WYaLI2/o2E4azuT7IUPlfevayMM3tOoT3EQrQWhKqZY1HbqK?=
 =?us-ascii?Q?rcePHvcHionu0NFiVMVYVtuubH9KQf5NG3BoiMD3ZAIXkpjZVyim4SONzvKi?=
 =?us-ascii?Q?bV2DXJBZRvmNs9eRaNwdgoRHkgI1MwomfJhNxOteozLg1t3ov+YZJrlHmCEn?=
 =?us-ascii?Q?x3Yh+2JWES/ty7ohDDaVeBuH97R3NBuEnW8vikTvQkcfV2GcFedrULkLrxrU?=
 =?us-ascii?Q?fqZ6sASDnunBmRiSLsTHATcsI9dXOP3PYNybPAkeRqwX8GqkzcfuCVzqQgoo?=
 =?us-ascii?Q?ztp6p6wchg6hJ8sUHK8YKWbNM21+HKLbefzLjyN5DDnSsigVXOsHren/KZMc?=
 =?us-ascii?Q?K83r6D1koLyuiuG/+NHVSpiqYnUZ9rRZsybJXxlG/s0ByofAnV5H0pBipDk7?=
 =?us-ascii?Q?BHOY06jDLA7bEukpMWvT6N04pR+4+HQWPmCtg2pQaWvbv8P08+2IxXtGHTXG?=
 =?us-ascii?Q?gC/TgemPXSVeP9GdaFRfH47OU+jC7793zVYwkAlnvATaOcoHFqftRRpzbITy?=
 =?us-ascii?Q?Ne5k2MnY9umkIc4J92JUCvXhklF5VbpWUMR6jJMR3ugY4b3LJ1xFh8ljw9yo?=
 =?us-ascii?Q?iTPC+JjZ7VszotYBdFtylRYl+HASkavy7RPT64uUxSpWAehYKI6UMV+bTS2C?=
 =?us-ascii?Q?3ocTgPXft7Xor5QYXq6y94MScPzQJwmAHPF4TxIceSYe39zlJfr6JYAZatdY?=
 =?us-ascii?Q?FU7LBLlF1mDaVineqA0LGjDklR7goyLKazoJCpYYXt0m2CX6yOG+aBDSlfFK?=
 =?us-ascii?Q?ihh8VOfg/KZPimm+ZqVLhprQPACpRZxwe379aoo5T/vkt2JrDLcasr0AZxXj?=
 =?us-ascii?Q?tgR5EUZQ7ztBZKExI30h3JqGS41HtFO/cn/JSCVSJJHt8mPO/2mcz/cYNjA1?=
 =?us-ascii?Q?VqBz95eeo3JkDtVmujlP3yEo0CKsYcL9AeGc0daUmlNNKCuqbu5OvZHybp7m?=
 =?us-ascii?Q?IqFl/MiQGVBwMQqxk+pn797uGJeUhvJMQm++8+GB9ROL2BwZ8M0bpMPnycRo?=
 =?us-ascii?Q?j87fPMNBSzplKjnfc0T291G3UMj6BSVld7qYygbmW3E7bjd6+y50pzYdODu+?=
 =?us-ascii?Q?JwCVD4/l+dlnsblHO56irG7e0uOtRAiwWZrKiqdYg50sIeo6G86WuEI4FFWz?=
 =?us-ascii?Q?cjs609vwpeCDorcvMlRq6QW966iFQAKTRxnf7gkjx02ztEtMngm2K6Gkoclj?=
 =?us-ascii?Q?GdEkfnv6Z96Aw660Rf/c03MNEuVx0AjxID5dqaljgiGP27OF/yAgBz2nToi6?=
 =?us-ascii?Q?eXNI2gkj6so3wyxWHlzoyuPksbfZHdJ/pi9vYk+G6PJPtslJuMbGFCHFkmj5?=
 =?us-ascii?Q?GxIwSbXhiLIKtIwQzNcDW2vKc+Vbx67bmqebzmRoF6Vjpg0zCbZvD8shNltI?=
 =?us-ascii?Q?fkX8SrProann+UWgFvOsk/BD1IfDdunTHFB4PKqeK7fBW5edyR5tgmOFNj17?=
 =?us-ascii?Q?RACPVPULmpQi0Oh9/VG4vTyUT/JUCLmbQYOxr/PpbgmoaVM3oKqrfaKtrQm2?=
 =?us-ascii?Q?lMMUjlZrIA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8508.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756f04ac-bbbd-42d5-f6dd-08dee7c09463
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 07:12:24.1874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rON4I2IKrai40VQ8ntUbnZbeEsgbJnME7FL35ZYPLHtLg0CfUSgnOUuN3bCYw9J83au78GnUSW2F9U24SWJ42zCDBnsFkXyOF1hMYLe63Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7260

Hi,

We are facing certain issues with the driver of PCI device.

The driver is Broadcom's linux-kernel-bde.

The device is a forwarding ASIC, acting as 2 PCI devices on one die. I'd li=
ke to note it's acting as 2 separate PCI devices, not a device with 2 virtu=
al functions:

[*****@***** ~]$ lspci |grep -i broad
07:00.0 Ethernet controller: Broadcom Inc. and subsidiaries *****
08:00.0 Ethernet controller: Broadcom Inc. and subsidiaries *****

Both are managed by the driver mentioned above, linux-kernel-bde.

The issue:
 - kernel module is inserted
 - we de-assert reset of these PCI devices (previously in reset, i.e. effec=
tively powered down)
 - sometimes, very infrequently, the box freezes for 1-3 minutes and the HW=
 triggers reboot

When we removed the module before de-asserting the resets and then inserted=
 it later, the issue did not occur. So we suspect that the kernel driver is=
 accessing the device during probe too early and this is causing HW freeze.

The question:
Are PCI drivers expected to handle hotplug events of any number of their de=
vices simultaneously? Can the issue I described above be considered a bug i=
n vendor's implementation?

Please let me know if you need more information.

Thanks,
Jozef
