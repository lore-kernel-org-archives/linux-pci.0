Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010065.outbound.protection.outlook.com [52.101.228.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB23D9551;
	Thu,  6 Aug 2026 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015276; cv=fail; b=JO7hHYJUNs8dyJ13fdthLEhHTrprj1hxj1PuBMsM0nHvVZCjx943g3irGLbs0FiNLOq9id5Ezym9FciEXy/NAq87daOm+SRUV9Sts/p+DLrQpQs1wwo8b9ZS/g+59FZgZDB8iKZ1j3Us/xA+QJDqJZiwg7IflqytPe0q+MXROHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015276; c=relaxed/simple;
	bh=Pt6zVZwRZA3C+Tmf7pZDy69L2/aRZ8ONR3laaOWnWLY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YVmodp3m+h0tEL9xm5fOaeH5j0Pe5E9vxbPRRgvbfRHOibh8zfvXGbTq64j3meq9CvIqraPCzTy+M8CWdGyFJ8XtPN0f6xbZpIvdkQh59gpMWJ/hzi8ocNcdrHazAl+xst401d3QmVTGELcB2ryaGkoyqKlSHngTtcgQwIZe4s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=dsIThjc+; arc=fail smtp.client-ip=52.101.228.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="dsIThjc+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6D+NbdYR62GF8Lkc81cnX8J8W3UcmPyTQeQPVXhWMEXPOv4vUEx3CSp562iVOW+Wl32RR8Mc4a9fgaAMbEeK7E2NkKmsRXkoGgJLn6eORhq8LNUKW8c9lmzRM+Ovg316z0fDl/qEoxip1/D3D8ynTNfPJWuy1zjuDxktcoYe3O1U9GlKep1dnIy/rUf99UqGSRim0T9BPfb1WXrQokWbStAYtisAEVj+kgDW3JJYoQzx3z/rbECkkjTfthA6PM5RFGpn9mU8tySXDhYjzTsZDRvWy4p7Tv1Y6E4va2P3hoBxvj2OZVol4nC+a/u/lvPmANJqzgkYXMBFJ1cV4WUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z02NiTHIaH1Q3XLPhJS9/9/CvufXMbuhH5i/A5bvMQw=;
 b=qlI4kr+IpvSprS8bW+h99gJ24Imoq1ww0LlGLJVjOU6Tn8k1hG9ax5LDwdd8fqVG5cPctkpbxnRRXlOgD2QF0eScpEhsTsVqAHoqg/TxPUYtNDnOC+aBMEUCSMyFFzie/HyxrRhLbB9je4nSVtH86aNcCVPVQj773TQe56EUkgFSuYCQW1evr44e9stfQQw8ZYF3bU0h8Z0h3obERTQuY48JwyZWfJmAIsUaRWU1r/klv7GAxPi60jsjplG/HXgXCzHOGhXgVJqsuZOmMctmPIsCUwgmjBk6N36Yn1oKDxZFLee/CkkcVW+SDlo/wTpChkaeSVeKKbUBzQ8ZBWf6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z02NiTHIaH1Q3XLPhJS9/9/CvufXMbuhH5i/A5bvMQw=;
 b=dsIThjc+QJOocRpljc2b2xGFTttTu6JMsgzOkuY2hm0lShVW/uuTQgP7AyagP4/bslb3eYhT9qNKSgDaXpds7mBwOjB/FxJ7JbRY+iBAXQqS9yacsSkMz6ac8QwQF6acOKCMVnDZShGHI7CpyVpaByiAZxEMCGJrdwIzi13W4ccKI4bDAFUjuFoQPRLOXEluxf5rj//JyVujfSYygDaz3QJiGk4Een2iTjO6IfF5BgIzXOrBRtEoIoPSrSsdrve3FXXZVGRhO3VRSzyRnAA3t7DKko+FYlyGxMGUAgLMZYE8pljNEsC0KgjoW8OQ+H41aePJaYySpCewU+MgUqByrA==
Received: from OS7PR01MB17384.jpnprd01.prod.outlook.com (2603:1096:604:43c::6)
 by TY7PR01MB15037.jpnprd01.prod.outlook.com (2603:1096:405:248::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 11:21:11 +0000
Received: from OS7PR01MB17384.jpnprd01.prod.outlook.com
 ([fe80::e19a:50c0:4d9c:1bb6]) by OS7PR01MB17384.jpnprd01.prod.outlook.com
 ([fe80::e19a:50c0:4d9c:1bb6%7]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 11:21:11 +0000
From: =?iso-2022-jp?B?S09ORE8gS0FaVU1BKBskQjZhRiMhIU9CPz8bKEIp?=
	<kazuma-kondo@nec.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ACPI: PCI: Avoid misleading _OSC messages for non-PCIe
 host bridges without _OSC
Thread-Topic: [PATCH v2] ACPI: PCI: Avoid misleading _OSC messages for
 non-PCIe host bridges without _OSC
Thread-Index: AQHdJZWvx2vyzEdBNUu/hIrr4kWloQ==
Date: Thu, 6 Aug 2026 11:21:11 +0000
Message-ID: <20260806112052.857684-1-kazuma-kondo@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB17384:EE_|TY7PR01MB15037:EE_
x-ms-office365-filtering-correlation-id: f3cdc7d6-af53-4a22-73d4-08def3acd1ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 JcJnpbM2L2HiQg/e0OHNZPm4sXE1/ZpaQOmH6DC4LK9g12bRa8DfnVJUOdR85t1cYVA3RW+85assMfJUhTJVtOyu0I+QrBpa6FlbhbAIoTmhljWNgTwO7c9cRBbdItFFRZboeIwu/CQItMcnRcclM3oZZ1W4GPiF38q0x6StgAu9Uc7NZ7E/r9gmZqkWwQpdS8faNl9ACmt+ZSjTMx4osWmywpPr5f4JcZVznArqfA9gyhNhRcps7YWaGMg3nofauhqjRy3wgFoMf2Q5vMT7FksLVEqQCDepc+O51Un5KKkT21fSoL4geCMKDPVc0J9HZUVdv7CM+kxZeog7Nv9sBpk/07zOuooXXbFzWdaHVK7BJKVFC+ykv/wZgt5TyXxFPWv0/C1owmdjJnYJIKsWwMWknrdNwduKDP79UUO6udgKB40naZKCi3oTZAoY8sYhqYY3z0LU/Vn8JvK2TOVU4d8bZS/UI9uz9qy0uBaOrIIIxr6/4IcY9gWt3bZiHcSfTAMlp/c9D0B+JVYxEOir9/jJMVBjCLjHdDsVfUVz6OJiac3a51gcoU++GBCavGx4BgQpzkv1yL9ULgUEuvYlb/Z1t/dkEv+oYKf8lglZlMamzq4viquUCYJlDDX86auK8XmnKyX/3p0cS6MrI/whggpFnFfxKaaopm0XNUYIGi8mhT2qr2yyPjiPZ6Qx0831YPoAaVsW8ZhgHDyF1FNnj2G/ePNN7JLITHNpHkK4YHI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB17384.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?QzBqcHk5ZUYwOHhBRnRJdTBpVWp6c3B6d05lODBqUDlFc2lPZkp5WktC?=
 =?iso-2022-jp?B?MEJOM0ZYQWQwWXB1SFZEa0tYMlBSSzA0R3pEaWZ2a21Md0JnYlM4TDZn?=
 =?iso-2022-jp?B?S1Y0Uzl1ZGh1WEpoeU9iemtqTTBRUy9HWlFhMkVWbHZucjR0ZXFDYVNB?=
 =?iso-2022-jp?B?QXpEWnp6VFptNSt0aEJybEJKejRSeEZhdUZwTDBJTHhqeWpSbzFZeTJj?=
 =?iso-2022-jp?B?NnppTG11SGlxa1Q4UHBwd3V5VEo3T1ZlK2hiOVBvT3JOUmRUQ0QraG0v?=
 =?iso-2022-jp?B?ZzRCV2UvSnRCUkdSZ1ZGNHhVcDM4SEJ2ZVhSUG1HdC9lSml3eUpPbDEx?=
 =?iso-2022-jp?B?cUwxWE56N0pHaTBrNEJ4YlZMVVdodUtCQ0UwcW9oakUxVnErNjBRRHBn?=
 =?iso-2022-jp?B?aVJ1QnF6REJSZWFYUk93UjY3ZTkvOTVyNWpSTTJHNEhKR0g4b3BnR3ZV?=
 =?iso-2022-jp?B?eWRLOGVqb0Zhc1NmMEM2dFlPVkUvUC9FcHdoVFdNUTFDZ3puOFFKQkJQ?=
 =?iso-2022-jp?B?cWFHdGllNDFTV3FFV0tnTlIxT2pVRlJmN295Zk8vRUhWVWhCVjh1RDRB?=
 =?iso-2022-jp?B?em03MjR2ODZKWUlKQlY2T2loTm5mOG9lalBSU3RtSXg1THJVVDhqRUpl?=
 =?iso-2022-jp?B?cVBqL2d3WUZBOTlIY2ZBTjlSemoyT3J6QmNISXY1VE9uTlBzbXVvZUd4?=
 =?iso-2022-jp?B?UHA5MVJ0TUpMSDM5RXVGY3ArcVdOQmM2ZkphVWRvYkNIQXJybjUzeXM2?=
 =?iso-2022-jp?B?d2s1UzMvZUI1bHg5Mm1ZMGFoUkxEWk9YTERzQnFmZS82TFhVdmJDTVR1?=
 =?iso-2022-jp?B?dGpjeUwzclBzbzJRR0piaXBCQVFJZlFkUUp6WUZtQUpCdXd0SHhHQUVh?=
 =?iso-2022-jp?B?TnpPUHBUa1lOalBEVXZRSCtneDJSMEgxTG9aNkhhMkd2ek90K24xVU5K?=
 =?iso-2022-jp?B?RmR0VWx3Y2NROXhNR092ZFVCRE55bW90aDlOV3k4N0UxcHJNd2duZkdL?=
 =?iso-2022-jp?B?amVxdTNQcmVsUFZmQlg4dW9aOFB4ZGpEeUM3VmYrcGJWclBjMGlnckM3?=
 =?iso-2022-jp?B?ejNBN0lpR0Y2M3g0VVFiN2Q5a016Y2l4T0J4MXcwNDYyTDgxZC95UFlT?=
 =?iso-2022-jp?B?ZytaeTEzb0FyMU5rVXBmd2NCK3M3aFRhQ2xrdjV2eW9lOGp3WXo3ZFVY?=
 =?iso-2022-jp?B?NUNYN2pwSUlCR3B6NTdPMzdFNlVjVHk5amZBWU9RZ2hobFA1bHNtNlZO?=
 =?iso-2022-jp?B?S3hZbkcyYkNsVlpzRG5HTzhlMVpmK0NIOGJ1M1o4QnVmcmZwMVF5WVFN?=
 =?iso-2022-jp?B?RzIxR0l5ZXhHVFNSdk5EU0s3dGZUTlJpZisvazAvMGhGS3dyZm9NanhC?=
 =?iso-2022-jp?B?bFVVYWp1Qm5DbHNNRXR1cHB6SzR1QVBDZUhFOFl4MUw4V2UvM0NxWExw?=
 =?iso-2022-jp?B?WEx0enZRUUFlaGRaTE50VGd5Z2wxekQ0R1lQcDR0djMwYlNORG11UmhU?=
 =?iso-2022-jp?B?ODhjQjhPZ3VqQ2FXY3NWd2ZEK3lRTGN0U2ttaHJzd1lSMWR5dm1FMVdt?=
 =?iso-2022-jp?B?MG5CdXRReDlEdk0vN2VjYnQ0NHp5V0hVd2xydlNVZlloOXRYbTYvSnhi?=
 =?iso-2022-jp?B?aTZmZVNDOTY5TlJvZ2t3MW5RU3AxWktaWU9RQTc2a2U4K01LdzZPMHpW?=
 =?iso-2022-jp?B?Ykh2UERZdVJlcmxCcFdIY2FMVnhyWXovTlIwNG1ON2ZzQnZXR0svWGlH?=
 =?iso-2022-jp?B?YmROSDB5Vm5UL2d5STk0a0pDR05xc3FnNzM4T1VDMGwrTktGUXJBVlFV?=
 =?iso-2022-jp?B?VFR1b1g0Q0ZxZzcwdnVhM0xZaXhIeUdtN3RHVVhod2V5QlFFQWhsOGxa?=
 =?iso-2022-jp?B?T1lJbTdrNjZFVlc2MWtJR3ZweG5MWGcrby9Wd0FBdnUybERrTWhZTCtn?=
 =?iso-2022-jp?B?NGhscmdMcjVrTitaN1RXbStMNlYyOGtJTCtEQUFpSHFsaS9zODFRaFN1?=
 =?iso-2022-jp?B?U0NGWTNrNXFxQkJYbWpSV01mTFJaSk5xTzE0YUpBNmhIM0JoK0Y5amsz?=
 =?iso-2022-jp?B?bkZSaThmL0EzZ1JVNDlCRy83dm9CWTlYVzdSbTdMZHZrcGhMdGQrQXBL?=
 =?iso-2022-jp?B?cHVmUjNBV0J4TXJ0TmVDVEhJNXZzOHprbU0zSktvUGd3bzV3Qm45c2Nm?=
 =?iso-2022-jp?B?TXNIQ1E4TCtacDJkdURhT2xLYXN5WWNFRG9weWl1RkJ0U1djd0UzejRM?=
 =?iso-2022-jp?B?cURuaVpDZGc1WEY3cHZ1TFI0eHpTVWlOMStvUXRTNE1aSDlrREdWVnZX?=
 =?iso-2022-jp?B?OTE4THhSZml2aTdQQU4vdlFwSlR2UFpXUDl4SXpNVTZCU3Q5dlpVV2Fl?=
 =?iso-2022-jp?B?OUwxMy9PdmI2T3JFdm81WGVTaWloMXBiOEYzY2c0YUNndkxLa0l1QnVX?=
 =?iso-2022-jp?B?Wlg2V0hIeDJNcmx3dTRPU2owWWtrNTVMTmdKS0MzTi9pTHpyYjFpbVpq?=
 =?iso-2022-jp?B?UUFGYWt1RWllcXEyUnFScGtiSXJqY1NzY0NOTE1JMUxwWDZBc0pHclBN?=
 =?iso-2022-jp?B?WFVQQTVvYz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB17384.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cdc7d6-af53-4a22-73d4-08def3acd1ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 11:21:11.0671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JHSWRHLNIsYgGjj9fE5WNQeDem5XeMCYo2dLsHR3AhaWEtqY7U9vM+QApniFOayjZGN17KLCfClreEzX7VUvEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB15037

After commit 7d703df7f4f5 ("ACPI: bus: Split _OSC evaluation out of
acpi_run_osc()"), the _OSC evaluation path now returns AE_ERROR to
negotiate_os_control() instead of propagating AE_NOT_FOUND from
acpi_evaluate_object().

This has not caused any functional issues so far, but it produces
additional misleading messages for non-PCIe host bridges without _OSC on
some Intel servers:

    kernel: ACPI: Enabled 2 GPEs in block 00 to 7F
    kernel: ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus fe])
    kernel: acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM=
 Segments MSI EDR HPX-Type3]
  + kernel: acpi PNP0A03:00: _OSC: OS requested [PCIeHotplug SHPCHotplug PM=
E AER PCIeCapability LTR DPC]
  + kernel: acpi PNP0A03:00: _OSC: platform willing to grant [PCIeHotplug S=
HPCHotplug PME AER PCIeCapability LTR DPC]
  + kernel: acpi PNP0A03:00: _OSC: platform retains control of PCIe feature=
s (AE_ERROR)
    kernel: PCI host bridge to bus 0000:fe

Previously, negotiate_os_control() silently ignored AE_NOT_FOUND for
non-PCIe host bridges without _OSC, but after the above change, it no
longer does so.

As a result, negotiate_os_control() logs messages as if the OS had
negotiated with the platform via _OSC, even though the non-PCIe host
bridge has no _OSC method and no such negotiation actually occurs.

Skip _OSC negotiation for non-PCIe host bridges that do not define an
_OSC method before attempting to evaluate it.

Fixes: 7d703df7f4f5 ("ACPI: bus: Split _OSC evaluation out of acpi_run_osc(=
)")
Link: https://lore.kernel.org/linux-acpi/d0be949d-0e21-472e-a44b-cedb1dd869=
5d@nec.com/
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Kazuma Kondo <kazuma-kondo@nec.com>
---
Changes in v2:
- Set *no_aspm to 1 when skipping _OSC negotiation.
- Updated the debug message and the comment.
- Link to v1: https://lore.kernel.org/linux-acpi/20260731090820.493064-1-ka=
zuma-kondo@nec.com/

 drivers/acpi/pci_root.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4c06c3ffd0cb..cab29a75a276 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -574,6 +574,17 @@ static void negotiate_os_control(struct acpi_pci_root =
*root, int *no_aspm)
 		return;
 	}
=20
+	if (!is_pcie(root) && !is_cxl(root) &&
+	    !acpi_has_method(handle, "_OSC")) {
+		dev_dbg(&device->dev, "_OSC: Skipping a non-PCIe host bridge without _OS=
C\n");
+
+		/*
+		 * No ASPM for non-PCIe host bridges
+		 */
+		*no_aspm =3D 1;
+		return;
+	}
+
 	support =3D calculate_support();
=20
 	decode_osc_support(root, "OS supports", support);
@@ -615,10 +626,6 @@ static void negotiate_os_control(struct acpi_pci_root =
*root, int *no_aspm)
 		 */
 		*no_aspm =3D 1;
=20
-		/* _OSC is optional for PCI host bridges */
-		if (status =3D=3D AE_NOT_FOUND && !is_pcie(root))
-			return;
-
 		if (control) {
 			decode_osc_control(root, "OS requested", requested);
 			decode_osc_control(root, "platform willing to grant", control);
--=20
2.49.0
