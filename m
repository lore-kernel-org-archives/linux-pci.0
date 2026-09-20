Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012041.outbound.protection.outlook.com [52.103.32.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E32ED154
	for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789891844; cv=fail; b=b9+cabmZQL5yAxo0gtK8Vg8MQ1a+jwxAeE0M+48AcX9r7WASdEk9rK3RaGveZoQgo3niO+iHQer+kr+93y+NSJIPmXcH4SKqXzCzKfTyyWoY46D+UR0SBwWeeEwbRZHK3Vt11cMf9XVph4TXdlTK0lS9TLig2uSBrv+BktZBlJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789891844; c=relaxed/simple;
	bh=l0MItEsOcfJM6i7kFBop1x610ucHVAfOP4af7pMijkI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F4Uu+nLrLgXrEq71iDZ4nhWqsUM6ydZLOjwKPeqqjLDJ7rCD8rpNl2qlMOeFyC4h05518Xn1fLYyDusTHiT26vTbjRqMz++t29ToosAD840LL2ObzWQNnDShY9vNSy+spu4Z9RHtTfAtUFjQyKR9geKXX/ex0OinzNg736I2KPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Xk8nDQbn; arc=fail smtp.client-ip=52.103.32.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Xk8nDQbn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ae9fXFUNzVgrd48tSc/CVLlBhu8VElomj9kbZgjID5EQGyP70OyUXCrBWMaB/cmbASTkhm0QivL316AvmxP38R2y0Zlorce4Humw2oQRGMHat55qnCBp6Xd4zTGi7frEJSzV+4nWJcfH1VWIq0WE96jJh91/O4MMqVIz17vqLbWM6VmPZldLmsSYguksUWrxsClf9+UyLVBCzu6B1V2RgSz/zHF3VREMPlUjxagfKrMkc9t2c66PTMpNZxOEqcXDbZSzuOfj1Gq1i8BrxGH5B2cdS72wwfKlHQeBGPBlKHOCHZMKAgnD9yH/n1+77ZFJDg2eJ+beo8mHGki1A+qlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0MItEsOcfJM6i7kFBop1x610ucHVAfOP4af7pMijkI=;
 b=U4t9ugwi+/HgTch6CRa8KTEwJuktoGH2ESxnmll9cadDt8hLII+L3Pu5dk79EjrC6efnfuhWnjElevVBEyMNbUTrS1iXM27Ln2kzvFARAkXwRVg4+2xo+/vSdz4tMRrzZkGGIHNkjeoGYr5VPFGWDLwEe7XOfV5uU8X78vnFCKSVkYzYpR1vsn5/nzxHIimdjN6djqk53A/XaoiQNKIkUccikSmlzXoFWhtd34LBD56nrE4+pHkYoYetEJiO7cgS9InqRBHS0Ku900X+bw46zU4rXsPeUpdCV/oxs3yyaLXgmIuWN6oiXzFLot2TEZTuVQdiK4tnvFtFKSNE4qoSwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0MItEsOcfJM6i7kFBop1x610ucHVAfOP4af7pMijkI=;
 b=Xk8nDQbnz7bEkVXDzWV2TNe8GsJScbgliZtJCx9SiX9hi85QzxmmwNmCs0/BrRD3jJGYV2KlgJixFTl6K8UqDiV9o1qnKOQ4OknEhbmpRdSEQkEslz7WpeHs0k40+usadpes1vP3GkI5/lHpurHsy0dWCs9Pp/fX5aXeedOmEjWHLtOmXKo4nIv50xGukYh47RpFzB+pvY0yz82QC5UQpdAE6fhVBGz8C5SkDmPR7T5H14rGxpwngt2BLqE0VwG3Nlfk1/jus3h2A0WfxfkMyQd6jy5uH95owcXZmJ+GucZgJbW7/Qi0lkLjKhgqHIUC1A+x9eNdaU11X/fqxlJu8g==
Received: from AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:596::19)
 by DB8PR10MB3691.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 08:10:40 +0000
Received: from AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3bad:f430:c3bd:468f]) by AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3bad:f430:c3bd:468f%4]) with mapi id 15.21.0406.007; Sun, 20 Sep 2026
 08:10:40 +0000
From: blaat windows <blaaaat@hotmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Thread-Topic: linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Thread-Index: AQHdSNYXv6cDjpgnAkCd0Y0GswVEGw==
Date: Sun, 20 Sep 2026 08:10:40 +0000
Message-ID:
 <AS2PR10MB742929B57AF45A8C915A9AA7B5852@AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB7429:EE_|DB8PR10MB3691:EE_
x-ms-office365-filtering-correlation-id: 56f5342f-0f4f-4593-7fec-08df16eea8f1
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|8060799015|8062599012|31061999003|5040399003|51005399006|24021099003|15080799012|15030799006|40105399003|2607281247196008|3430499035|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?eFxuhRO4URnCZGqFu8sYfRAHPLpHBUS+b31j+urZVYRazYEpyNKwwNhTWR?=
 =?iso-8859-1?Q?qSmCC6EDwI11nVEpADux+jyLgT6JO77sIu6TXfmPN7RO/Hyb/C1+f4qmAt?=
 =?iso-8859-1?Q?D5I5DfoDQIPvftZNiucCQvFRo1qNOEjId5i1NVsap9RhF3d/i/zFpy5fUm?=
 =?iso-8859-1?Q?x3bcNrVXjhsaRbiRo7RrS82gvxg2xDNb6KKZaJIOQDdUjEbNjv+r26Pcd2?=
 =?iso-8859-1?Q?LC/2TvEq+VHaNJV/Imu3DEcNVj4Fxq083VLb0VZYoCDDtCSBeMoRaU6k6L?=
 =?iso-8859-1?Q?THMS6op8MVYO+3nspY4F3T6yayPuYLYrKZ85wIWKAeJm8PL1DkR1BPx1Gt?=
 =?iso-8859-1?Q?gwqocPySdWb0qqGxsBDD+OWzb5NBXKs97FZiP1EooTpzD+ZhFmIBMpw5C/?=
 =?iso-8859-1?Q?7T27/L4fKAwyNCvCv+U9DZOAVEHs7i5gD4AULVbcxilCH7SXGrpHy1P55Z?=
 =?iso-8859-1?Q?59LlexYqsxZNgoLZ4y0AgCypxN7OyEl6sQ0dKsHbe0EEtxdQ7/lIf/Cy8s?=
 =?iso-8859-1?Q?NGwT8ekuQUPTvcOeFAM1Uz6jRJZsDfBtXOfLZli+p0VcRUhZVyjQI+f+6V?=
 =?iso-8859-1?Q?a1w3o4HcWTKF+3r5dnkONPSqER5XxFH7nb8bpbwHz/H3y04e4iQCvFBD70?=
 =?iso-8859-1?Q?bcCn3lFYj+6JyHFZZJ6vozdTZhx1J8HZL6U8hlzic+aNAvCLkicRPnOgl1?=
 =?iso-8859-1?Q?lh2rvO1qtmO+NwHfzxM7jVKotYMvoH73rEDBEseKoPdFqXJiMIfmOJGkjV?=
 =?iso-8859-1?Q?/juV2uXovqrllbVyjPUdnHILeB9Wfy1+57GqSNzBbI+hGgxMJyMg6JDCON?=
 =?iso-8859-1?Q?UEcul+1ghDWmTJ5mgVt25U7QTBhemBVqHcCqXPEfy14w18snstXspjnlTM?=
 =?iso-8859-1?Q?p7+AxnQ5oqVKePL2TPaFV1k03Ziq5w0dErgtd3N1XhgW+DMlDf8V0ZgetO?=
 =?iso-8859-1?Q?tOjm1L7+VhtNxuNFBQfavjnL6Xrl4frUMGhtkEYZrr8aG9G3djkRlYuESf?=
 =?iso-8859-1?Q?FgbxAtCtjPSUh4SEU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?divJKwaRdzgi23tomLv4x3zG2JlKwm//uW/r+eovnUo0p1lGP0Xb9VBRsQ?=
 =?iso-8859-1?Q?cYw/ar18BvmPrCsmJ3v0NjpMLYT8WV+TePCdveosLEV4ir/tivUuwpnhsD?=
 =?iso-8859-1?Q?otD4HCAnUwiNGXfocAigU1O0WJxXYbAhbtFcgFLO19XRRhQQwb1iQwOXc5?=
 =?iso-8859-1?Q?rd7ZhJtCThcgclmBukEL6YLDXGEfyK0v6Ah1D/eaYcZGUpkXHOELBzANCm?=
 =?iso-8859-1?Q?vVPofITlw3RYrE+wnzRRwIbK2y0+uEe7RFaP06G4m7ODDW21yCQrijUSjZ?=
 =?iso-8859-1?Q?JtNzIkoI6mXPHgdiRQoQyf8ydWjxHkcJ0MikiFEPLBLupBqc7vU9O8BF4m?=
 =?iso-8859-1?Q?laAOISkJO4j9mjHRt5O2rVf5F4Ha0lC1qSOOon2iAjd1LDyNJNeg4nTT+F?=
 =?iso-8859-1?Q?2NyqxXHkLM0VtC+NJtVTf2xyUTn4nEFZqbQ9FO3/NM7aMPhEOaJsleaLIK?=
 =?iso-8859-1?Q?6WQGUE9iTl87xG8Y+OcR124fbfMRhI2F2PnhHOH9z/s8UcZrddZxaXCGbS?=
 =?iso-8859-1?Q?E8YPjKBkmItGoRG0VhiMDNGCTCh7LjZnCct2DDxk4RTXKBlV3Q7etaA5BZ?=
 =?iso-8859-1?Q?5LLOOyGfS7JdZNjx1fy1poRp6uEjIS1LZVP5oYaMKhC42QBpHd2Vp26LXn?=
 =?iso-8859-1?Q?+V+temQP22d/FNvMU6028KElvgKodmE7XmeNrCNBJTJz0gcFaVei57le7A?=
 =?iso-8859-1?Q?B+PmPZY14+6ijRjyuQjuHkqzdTf0Ajl/thnk/Gkbz4cYCqzpKquQEfkdq3?=
 =?iso-8859-1?Q?J8KQQhB2eDeBgY3gmG+PmIjA/OSox/V8UxbNM7Up5OMbbpraPY5FWMp/f9?=
 =?iso-8859-1?Q?Vyopofd3HG/JC7IX3WeQ3PTQGqmvH8uBqXvL3HNdhH80nT/xF7TINtuzuo?=
 =?iso-8859-1?Q?8sH3GYhf8TqV/t5kJeR+r4EbhcTVAdlrvJV4wsKwGnH7ryUv+BTC+jTY7y?=
 =?iso-8859-1?Q?eET+6rzmmdJgM17VpNaIXsNkKCVS/qHg02sIutWk7q3n4i7tcM9vbVP7YJ?=
 =?iso-8859-1?Q?x/bnvjytmfxFYfNZi+SrvonLJ2KMtiwMJijPykQYhM7+M9V34t17VBXh6Y?=
 =?iso-8859-1?Q?PI/Oaw7GAw9V1PhN5IgtwySLUh5A6s14pwgOUXz78XR93R3tuq9Z1BfsJ/?=
 =?iso-8859-1?Q?c/0aPL1ABNvwhcdD8c+L//PfpR3Ks5XGxpijmHtPU9VjIUFn3mtK1xJ06U?=
 =?iso-8859-1?Q?WC0QoWV+HpAqEi02j3tVM2PoBujjeRWDdTp1pqX655E8YDeoEyDdrJHTX9?=
 =?iso-8859-1?Q?RiMrslk1DH/KhtZV1MlI+Cux54YoJ3Rpq4zRBjM6eiyivLJxUgkAZW7YLO?=
 =?iso-8859-1?Q?8SjsGkTq1BajkQUFRSpHTF3Uzi2cztdqQuOYRcYKtHr76V1YPRkiHUfUnE?=
 =?iso-8859-1?Q?spxtF8oUWeO7YqkJXTfkEZmLEiRknhraNDwdly9jiP4z8U4CF90kk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-d3deb.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7429.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f5342f-0f4f-4593-7fec-08df16eea8f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2026 08:10:40.2164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3691

Another reproducible case of the active-link failure described in this thre=
ad.=0A=
=0A=
Hardware:=0A=
Intel 4th-gen/9-series platform=0A=
Intel 82571EB quad-port NIC=0A=
Microsemi/PMC/IDT PES12N3A PCIe switch=0A=
Root port 00:1c.4, LnkCap 5GT/s x4=0A=
Working negotiated link: 2.5GT/s x4=0A=
=0A=
Kernel results:=0A=
7.2-rc1 fail=0A=
7.1-rc7 succes=0A=
=0A=
On failing kernels, the PES12N3A hierarchy does not enumerate and all four =
downstream 82571EB ports disappear.=0A=
=0A=
I traced this to pcie_failed_link_retrain() and specifically the new generi=
c clamp-removal code introduced by 72780f7964684939d7d2f69c348876213b184484=
 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining").=
=0A=
=0A=
I tested 7.3.0-rc3+ with only this block commented out:=0A=
=0A=
=A0 =A0 pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);=0A=
=A0 =A0 if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) =3D=3D PCI_EXP_LNKCTL2_TLS_2_5G=
T) {=0A=
=A0 =A0 =A0 =A0 =A0 =A0 pci_info(dev, "removing 2.5GT/s downstream link spe=
ed restriction\n");=0A=
=A0 =A0 =A0 =A0 =A0 =A0 ret =3D pcie_set_target_speed(dev, speed_cap, false=
);=0A=
=A0 =A0 =A0 =A0 =A0 =A0 if (ret)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;=0A=
=A0 =A0 }=0A=
=0A=
With that block disabled, 7.3.0-rc3+ boots normally, having all four NIC po=
rts enumerate:=0A=
=0A=
07:00.0 82571EB=0A=
07:00.1 82571EB=0A=
08:00.0 82571EB=0A=
08:00.1 82571EB=0A=
=0A=
The important result is that the initial 2.5GT/s recovery is fine. Leaving =
the link at 2.5GT/s works. It is the subsequent:=0A=
=0A=
=A0 =A0 pcie_set_target_speed(dev, speed_cap, false);=0A=
=0A=
which breaks this PES12N3A/82571EB link.=0A=
=0A=
So this appears to be the same active-link failure mode, but with a PES12N3=
A switch rather than a direct 82571EB connection.=0A=
=0A=
This was tested against vanilla 7.3.0-rc3+ with only the above local change=
.=0A=
=0A=
I can provide full dmesg/lspci output and test a proposed fix if useful.=
