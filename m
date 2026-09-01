Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013010.outbound.protection.outlook.com [52.103.33.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A1335555
	for <linux-pci@vger.kernel.org>; Tue,  1 Sep 2026 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256374; cv=fail; b=Z16Ft9xJa5S+AVwo1PCac8mQFajq12iEbacLfSwVmOJlvjkp3/XsyHN4lUB6rN1jDbLxXtrpLi0WIJEsjVXHp4lSJAaIgPa5htJnBz24fSQqsvRV5P/L8zyxK1NcR4BktjhY8sYJytNsxfCWJBntvAp1/GOIvtBz+i5yaSsJrg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256374; c=relaxed/simple;
	bh=c3QjoMoo9f/jPebO77yySjVjUujK3O92TrN6MCACBEk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vq4Ir79tkLGv8PI52Gs+qvdDnI4OfdOGn2BiuL8kQgo4qif+ErwtraKkTCWvUTjNa2dECXWxHtCz3l82FkWfHS35SrgsQJTEpqRmSr5olBkKmN5U7nPVw69frK6ec+ReO7+PtIwYLPu+Z/Xo8sN+EYu3oHarn3w1mQOqIryPgvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gHXNZG9A; arc=fail smtp.client-ip=52.103.33.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gHXNZG9A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lW60H/VE2Uj4rERPtBYy2a6EDDZCkoJE8Qv10nFaH8DeB+esiHnjvQWJH8ZUhOu4m/a6dTA3VIMVSOIRzseV0xY8IcarFZbgO6ZzwdpfcOFYgwR0n4jMzgriqLWie4EjfTuJxUfHGh9y0OjGWm0hkIkGNqX2lFgpZePzvrcRhIIlCvXS3LGO8p1u5ofZz5eXjxV+jiwdNhawYg+SLd3FMU8qkiQKZx0ge6vrhgwTEiaKHj2XpEEVZEKp72pgZ8J/lTFYlVXpciyt8EpTUO0hHAzW6ShHx9ZGmO/PT+OtHI6WyC6qIzRxUDeJxH9dB9yi84HVTA/3Qysho9/Y4cJLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3QjoMoo9f/jPebO77yySjVjUujK3O92TrN6MCACBEk=;
 b=Muqz6ilC+rk1X2FBbVCdPJ5CM02cPLFnSMDv0ULArMtL94Uu0iCRapCjgqiaXbRu0yUSt6kO8zp1liplyNwhhz2zpoTWLoRCLWVYnqWrnxLRAQFtPaadD/z44ef1HtUcNIDoIndIRGamZP6V3Ux+vPDzeTQvOZzr6YWf3dKLrD7ixnVMaago+vqOHfqItrqyvmYOURdzKHDTRt1r5OVw4iIATLVpvQSkVAPg2MfHSRkNJ6uT1NTWZpn22bFcgNhSfOtjhxYWy8ROf9RnxsYPFz3jr/vGq0MxNbLT+j0yBvtFM2soWK6PnMtwYIN4lAEHHqOaLc8yH/dBA+2swRp9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3QjoMoo9f/jPebO77yySjVjUujK3O92TrN6MCACBEk=;
 b=gHXNZG9AUUGFMKXe5iChAEzdstFjgEghtn19K/Dyc/e6yDOC/J6Zl1BKRWOvzAdUTDoJ/WtP0AnvfpkXmMifFKT4BF9zP6RyrsNyDiv+KFiiGELlJQEoSNUa1bmlDOJv4QqywH8pFhzJ6JT5R4neLprxXiAEzBWp7S4y6Rm4WeconGN9K8OWLWUeD7uTDCBOhHQIuOYdf7h5xFPU460CYCOfMYeqwCkEqoj5tPwUwUkEUs9Pv3BVXOJiuff9uaRCFkcG2aIXp7mgtJOgPK1Dq5ZPEpjfpQ+mqzWSLGwIJj8eSzkHHoBUM50jbN8ilsVpvYmVXD/pDgngjiWN/w6MWQ==
Received: from DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::aa2)
 by VI0P189MB3151.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:52:49 +0000
Received: from DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM
 ([fe80::41cd:e1d2:211a:16e0]) by DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM
 ([fe80::41cd:e1d2:211a:16e0%8]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:52:49 +0000
From: M M <restafvalendergelijke@outlook.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "andiwild@gmail.com" <andiwild@gmail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "macro@orcam.me.uk" <macro@orcam.me.uk>
Subject: Re: [PATCH v3] PCI: Bail out of failed link retraining when the
 Target Link Speed is already clamped
Thread-Topic: [PATCH v3] PCI: Bail out of failed link retraining when the
 Target Link Speed is already clamped
Thread-Index: AQHdOfdZ890lwOfPz0aKFnVs84fTzA==
Date: Tue, 1 Sep 2026 09:52:49 +0000
Message-ID:
 <DU2PPFBE35756D1899C6C3A534F909D7840ABA82@DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PPFBE35756D1:EE_|VI0P189MB3151:EE_
x-ms-office365-filtering-correlation-id: b9594a7d-c6e1-4109-e90a-08df080ec829
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|37011999003|7071999006|4140399003|25010399006|24021099003|19110799012|8060799015|8062599012|31061999003|15030799006|15080799012|20031999006|39105399006|4295299021|3412199025|4302099013|440099028|102099032|1602099012|40105399003|23121099006|30101999006|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xsC55AYu0lDuzKitwfRAo9wOkLzjZ3Z1r8xRurYvMufbgCHeXYDN/4XWDK?=
 =?iso-8859-1?Q?hhWkQ11YMz1gZ3J6R5zGxXHdtetnrrGcs26RwoTkXXu7o+04cBY+KDxhvS?=
 =?iso-8859-1?Q?6OArTN0qB4hYJvB3EhuAtM1zPbfbvHKsbu6g7xNaLoB08u9tQrM58ZL1ic?=
 =?iso-8859-1?Q?+T9HRLpLGqyrNDJFOOOsoz31bat1Vb6kwgenbNY4Oeum2K33VHeAsHRpHJ?=
 =?iso-8859-1?Q?qpC4g+7h57YcBiQv48sOMpviPNYsSoMuNZ9yG5COX1JTgq+cR3ff/wrc5D?=
 =?iso-8859-1?Q?znYQRg/AQWNzj5QEqLIWhRED3CkHO/7MUvJkqgV4setIiPhB4SFR76zMLw?=
 =?iso-8859-1?Q?52p41nbXi1xVsROsCsaxeSLeWHNH/HznOpiGrn4UHaiPrBIuPaWdlr7VPF?=
 =?iso-8859-1?Q?RdkNEaI8a5o4VPbjLXY3nQApKQL2ehZJUdTlCpe9eW+93JQI1/lZhCqEOw?=
 =?iso-8859-1?Q?6CCzkNOF9DIkmiZUNlgQQjMUKfAG+XjzVhBm9dJRTH9ykAZ+ubFLvW/56/?=
 =?iso-8859-1?Q?rVjz8Pb2kk2KQ+l15ACLI98zZbniwwdFKO+knbPhOpm8WJQLX51Np9YHkU?=
 =?iso-8859-1?Q?YFySZZTErUn8qBXJUq1XfLPkU12pyez92vM0ysDLqfZPH1emAopq0Bqux8?=
 =?iso-8859-1?Q?TxDlGrMW1MKSkQSmj3a1GklgYrIms84NFIPpdgzHovP85Dgpskii2SyAth?=
 =?iso-8859-1?Q?ZUQPy97ESoESUncyJhZwjRuu+wHokQhayrxTA6v61aqXFNw6uLJ2syBzI3?=
 =?iso-8859-1?Q?/cfmVh4Sn6vvtBl88EGo0+Swv46uwiraGGn6EuHKM27Ow1VON3F0eeACIA?=
 =?iso-8859-1?Q?GiVgFZmHcHzOZjVw2Acx94hh4lNyaIDK9UqEznJnLs43DBYtsDrAa8jy01?=
 =?iso-8859-1?Q?GYUQG+hsVFESE5ZBTOvBXlnXoWnbKezumELdZxPcmtGakARQRb5bo0GHq8?=
 =?iso-8859-1?Q?v0bebrZ7Yun+rDaQ9019QBksINWNW/aN8WPszB2NjtlWnVQ3mrD2RCp1sO?=
 =?iso-8859-1?Q?3nyEoONngiCXnO4+ha3v74LVjPl5aaYHKxhhdDAqwv1vr3cQSQLU4XHrcP?=
 =?iso-8859-1?Q?/VnW1lkNtylZa2lrHr23xJzvSURIO49rrOjl3Z63/ZSa9OV7Gbqex4LAiq?=
 =?iso-8859-1?Q?g9folt0AqKGzVGf4Ltq2Pv4Q1i5k+itix7I/dTFWXVen0aKvZ9cGjy+bYq?=
 =?iso-8859-1?Q?mhd+jbfM65V3oCCkhl3RHYjoz1OvLIA+dAiUGyhnvG8Pqam8076KVmQSrs?=
 =?iso-8859-1?Q?RH7Ja+7DTO5KYdFMyy8w=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CeaJUGGqNuwMR+baLBoOFidGtF9fO1cDB76mvOJm94eXoPEO1GUKvPvAuP?=
 =?iso-8859-1?Q?h+d/AIdoSLdSrojIVkJgJmQygUJCDVV+2xOOEObq3Bn6ses9YVDfJ3lPt8?=
 =?iso-8859-1?Q?bG3pAPsrJn7Db0Am98wnMnpN8pd+2GHrdjNaj9c0wX4vdtfhTW6HfC2XCR?=
 =?iso-8859-1?Q?d2kbf1VaHCOOlYcLPuVF5n7oP19k3x8xe1uQe2b2lFJhmDojDYPNTCDwHt?=
 =?iso-8859-1?Q?vpwGd7Gf1UYXjGEbkqQaqHrDHv995sh/VNytaQPY0pJGyF0Pi4Jmw3oStn?=
 =?iso-8859-1?Q?0NL5f3Ji66dlOt5iCnIBCkkMAVUmUmpxW19F75f44xZBbB5UEPrr7OxS7d?=
 =?iso-8859-1?Q?mgsux1sahq0XIxzJJiEj0opXyw4z3TdGh4Qi1FvapCIVz9XSXdDxF4dow5?=
 =?iso-8859-1?Q?M1GyVlBpWVThUXIqzFbmSIDBsTSgQU4BN0C4pedqID2buzC2X9pVTQgI0L?=
 =?iso-8859-1?Q?+Z64lZ8H+12MSjUfeadBYyskeEvA8jA1YRx7s3DL97FfUd4KCwNGhqbQ0J?=
 =?iso-8859-1?Q?KT1vbna7jqlQHwN6lA1ISyXlzDPGCuO/iudI/Z5MmfnukqXy0wbjSchHNq?=
 =?iso-8859-1?Q?TBJZ57wvktS9gH74jWOMLLwrnw33zLmNKVJkr9Gpl07RELg71NuiS+C+mI?=
 =?iso-8859-1?Q?hM1yhW2KQsvFYP6QFvpvIT55RVC87+yEabe1fOcI9OS1bqbNeCMbWvgIY/?=
 =?iso-8859-1?Q?I4qYJ3JFC7yWJjVC6I5v43KM1UWbEx88JhtVhWoDKC6SimehYld9krGe92?=
 =?iso-8859-1?Q?WN6r7+0ZG17axFTd2wOxo+aGyMmX9nZp8sQRXSF+0kDNPcdCC+QpmqMVGw?=
 =?iso-8859-1?Q?aZtHzQvrx45Ib6f2Jhc+Mk1jvtlh+jc87Ww+3UdA/ZD5RawuBM62ehXczr?=
 =?iso-8859-1?Q?sO8yhhEo5b4lsbVVSvJfNkw0Wk7VtBjvFR8i87rvmDS2KlvFKeqKtq+3TY?=
 =?iso-8859-1?Q?kicoUmOr8u7++iVH4VxB11B7s4NGB4Tq+MqVO4YH0Kj4+fAjW6gNnrq9W2?=
 =?iso-8859-1?Q?nlAVDlEyocubU2ilyHC1zLIihmMzqvSoXzAdhWOj6yf3OKNrWYzlwZKl5H?=
 =?iso-8859-1?Q?qfyPF2XCaYIPeC4ONBRBFWv6N1krLXPtCEj1qvRHVG3dGdZ8qMd6b1AW/K?=
 =?iso-8859-1?Q?EM4f8u2a9y6Y6f0btmi6QwjB57INSroDYoVR0a9wu/WcgbGuLfgbf+V/5Q?=
 =?iso-8859-1?Q?7J8xA92VFdIIeIPZOOUK8R09BPUWMdDkYLJxEgHQRRfTzRNwTMX80XqwUd?=
 =?iso-8859-1?Q?M/+mvC0LwOh66tcXs8vp1yYAI4hMzLdG0VpLl314d0Xn7CBjJziTm3wS8S?=
 =?iso-8859-1?Q?qY+IXmlSWPou+bgDs6+HY+488XVuOeHnUcGWEjrTm1rGNU/wNfLLYopUDn?=
 =?iso-8859-1?Q?32rbZJX+lfzJJtR7atmHOOtoMpYaJnZ+jGNQA7raPfFv1L09djymX8lBoj?=
 =?iso-8859-1?Q?iN4xorToCqDm1arSInvV3oBAFIoUIAXHYxVdSc0VusNahWIiHj67pAUqKn?=
 =?iso-8859-1?Q?axnWx+S60gOgcRrvIe0zkwvnBfkUC2/9c8FVOykKWOFg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PPFBE35756D1.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b9594a7d-c6e1-4109-e90a-08df080ec829
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 09:52:49.0493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB3151

Hi!=0A=
=0A=
I'm reporting field data on this issue from two production machines, in cas=
e=0A=
it's useful for the patch.=0A=
=0A=
Both run an Intel 82571EB quad-port NIC [8086:10bc] on an Intel 5520 chipse=
t,=0A=
and both lose the card entirely on kernel 7.0.14-14-pve (Proxmox, Ubuntu=0A=
base). 7.0.14-5-pve works.=0A=
=0A=
-=A0 Dell PowerEdge R610, BIOS 6.4.0 and 6.6.0=0A=
-=A0 HP ProLiant DL360 G7, BIOS P68 (2015-08-16)=0A=
=0A=
Different vendors, different BIOS versions, same failure - so this is not a=
=0A=
vendor-specific firmware quirk.=0A=
=0A=
One observation that may matter for the v3 approach:=0A=
=0A=
On the R610 the affected root ports were EMPTY (LnkSta Width x0, DLActive-)=
,=0A=
which the v3 check covers.=0A=
=0A=
On the HP, one affected port had an ACTIVE link with the NIC behind it:=0A=
=0A=
=A0 00:08.0 =A0before: LnkCap 5GT/s x4, LnkSta 2.5GT/s Width x4, DLActive+=
=0A=
=A0 =A0 =A0 =A0 =A0 =A0after : LnkSta 2.5GT/s Width x0, bus 04 empty, NIC g=
one from lspci=0A=
=0A=
Since DLLLA was set, I believe pcie_failed_link_retrain() takes the first=
=0A=
branch of the v3 patch and still falls through to the clamp-removal block.=
=0A=
If that reading is right, v3 covers the empty-port case but not this one.=
=0A=
I'm reporting observed behaviour, not claiming to read the patch as an expe=
rt.=0A=
=0A=
Full trace on the HP - the quirk walks every root port, one second each:=0A=
=0A=
=A0 [ 1.883010] pci 0000:00:02.0: removing 2.5GT/s downstream link speed re=
striction=0A=
=A0 [ 2.882097] pci 0000:00:02.0: retraining failed=0A=
=A0 [ 2.882422] pci 0000:00:03.0: removing 2.5GT/s downstream link speed re=
striction=0A=
=A0 [ 3.882097] pci 0000:00:03.0: retraining failed=0A=
=A0 ... (00:04.0, 00:05.0, 00:06.0, 00:07.0, 00:08.0, 00:09.0, 00:0a.0)=0A=
=A0 [ 7.906501] NMI: IOCK error (debug interrupt?) for reason 61 on CPU 0.=
=0A=
=A0 [ 8.882097] pci 0000:00:0a.0: retraining failed=0A=
=0A=
Note 00:07.0 gets the same treatment but is not reported as failed - the=0A=
onboard BCM5709 behind it survives at Width x4. So in the same boot, on the=
=0A=
same machine, one device survives the retrain and another does not.=0A=
=0A=
Both platforms clamp every 5GT/s-capable root port to 2.5GT/s, occupied or=
=0A=
not, so moving the card to another slot is not a workaround.=0A=
=0A=
Filed with full diagnostics at:=0A=
=A0 https://bugzilla.kernel.org/show_bug.cgi?id=3D221919=0A=
=A0 https://bugzilla.proxmox.com/show_bug.cgi?id=3D7969=0A=
=0A=
