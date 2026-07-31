Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011061.outbound.protection.outlook.com [40.107.74.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB948357D0B;
	Fri, 31 Jul 2026 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488951; cv=fail; b=A118zKju1IDPRV75HDoh9EOlGFIMziIMtmZnY/Kan5Dr7g6pRg1MmbYM06YCyuVk/XZsOz04KE3fywBjSQ4O6JSFKA2qXPASyStQkSpcduOYGfLagn7cnJ7+lpMnaLiRxwh+oHeDolP+KCSXMc0makZhhRKeG50RPGgAc6EmRjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488951; c=relaxed/simple;
	bh=0/LvfOkpnk3Ro0EWzcPbNfq6KEZiKm+FxUdrg+qZZCc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H1lRmUcZHDisCf7lWY1W4MIwTgToK6J0/FQ1GzLi3zjELq7FLkoAe8SRVQNT9yagsa7eXlTZ49sqNsQX7bAMciLj1PkpFqmalipsYdx94SdCOcHLgSrKAF6zmtq63BvMH2NqSrjVYMsOsB8dR+VlA1gd2RlBlEiFXisH2NRWPyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=YJAYDTLL; arc=fail smtp.client-ip=40.107.74.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="YJAYDTLL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7rotFPrpSV0Twpa12jun7y+9sphNTcVhEos3WJpO7zGVd6q5MOf3jiFkAsSNbwbbE1ROzTvbglHZXkza0fSzuZzghNPQzIyUL0K2AuSEn9scnp8BSl5ltSI2XZaJbHov6L4w0waR4SgjeNPS0XY4eRmoA3XK1LpAugRmGZaKXHNxiLgi5YGOt4OOVAs3LDROtuqRJJR96CpBud2cmk9poc7Xd0TGVbvqp5YVD2m9I6uQN3QebleWoq/ct3oQDogwrQtq916UBaDmiDi8L+ZhhceK2xTUvA9c3eoTalWUNggV7f4FgpzyC+cealfFP+9A536cEpDXWSc9/SG5a4ItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55VCftQuw7CTRvz9wb0kucdI6nlmqIELxOFLWzyzJHs=;
 b=HfEq/hAZsetZYyXM0QI9y+3bbJ2aCY0OeWRT0ADOzoPmiRQNDpD+Nv54UnV6v/RSjMCNc9NfHoMURHbKAk/gJ2VMhW3CXx1gYw7MI+6LppEVLLpSgXYN6XX8SDkrg0suagU1rYMi/dmZkM33iUjkSqQXEieXkCqfQSn98hgVHM7JkPvaOrRO9ITxqmxj36v7mC+4EAm+SiEwBMseoxmHwjzetrR5L/bdrghqEGkNVCf7z9bYUjf4zy0BOBXfY/G7Pq+hg1eKI6I337M9aK7Ivs/LeJmARhdWIcESDNW+hrlGQ5SjxmDkOl+FW4wcdVhaYAbebuX80JiYSzQLWOIV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55VCftQuw7CTRvz9wb0kucdI6nlmqIELxOFLWzyzJHs=;
 b=YJAYDTLLSk+KuzYJ3X2zkQCQiJK5tz/sEwnjIxNrJ49wpy9zole8LVOPYEIcFxk+dVubGD94NJVur6dYZldrO0Y8LqLoKc7qhf5083vwrVkoYBaIx8LuQH1DwcrjAZljVlYd3s06LOgtnAvSC8BVWfCyqlPZHiQpZspu9W0D96tztqN0h0tQMClSc0ZlhU3YdyUSnsA1V39GgRdu7QOH5iSmsocj3bQXScOdvfIErHv0erbrE9BMJtz/KHEOMAYAvmrjfvCtTO1EHbLAVP/nQu7WCwRz9uj7izHWVZ+dU6mJTEMJThigPRlNubPp6eUkSj8QUecel1k1cFIFryQFLg==
Received: from TY6PR01MB17394.jpnprd01.prod.outlook.com (2603:1096:405:362::9)
 by OSCPR01MB12754.jpnprd01.prod.outlook.com (2603:1096:604:33a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 09:09:06 +0000
Received: from TY6PR01MB17394.jpnprd01.prod.outlook.com
 ([fe80::4c13:be46:256e:c1d5]) by TY6PR01MB17394.jpnprd01.prod.outlook.com
 ([fe80::4c13:be46:256e:c1d5%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 09:09:06 +0000
From: =?iso-2022-jp?B?S09ORE8gS0FaVU1BKBskQjZhRiMhIU9CPz8bKEIp?=
	<kazuma-kondo@nec.com>
To: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: PCI: Avoid misleading _OSC messages for non-PCIe host
 bridges without _OSC
Thread-Topic: [PATCH] ACPI: PCI: Avoid misleading _OSC messages for non-PCIe
 host bridges without _OSC
Thread-Index: AQHdIMw9rF/Py4ZE00CoCPvRVB+Hjw==
Date: Fri, 31 Jul 2026 09:09:06 +0000
Message-ID: <20260731090820.493064-1-kazuma-kondo@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17394:EE_|OSCPR01MB12754:EE_
x-ms-office365-filtering-correlation-id: a54b315c-c9bd-4b96-2e6f-08deeee35fc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|11063799006|56012099006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 ZjFerhQr36bDONHMLgames051+3lNdxIyvnNL4KWaDXcMrvREi1xEESNFVXHY+iPYcCOHAVbBlldJ6JABnWdgsDolyi6VgynjznjIw72mC4fcSQFqBms7y58Ag1c9dGi6LndT8FGQcWDIVRQ0OR2jiLDA7D7VbLs5QJNdzRKP/6I6Df29gbDlNMYormX/aoLwgv7aOOOBNur/OOqTDAGxr2mbOaemOluxbZSVp3vFm+p0iEhMdA6RpsPwXiKAW70nG1Yl+H4tHjHJIujWBnZ/5a9OJM5P0fSb/rWbgSGpU6P/bdaIN75kk3DOCnsKghh5hP8l7rtaETlkBAA8h36Vyg1T5k3iVrwdzSXljL01coTgmQ0wxxQPNp7Lx6aC3PNDPPMJ0vio9OYRMNCicTdhFT+Do3+XxwT7xEOnNK9pdlhBSuRSFMsA3HMM5ua4d6G2k0N3Ab/FoYxDScIyi2SE9zc6QlD3TSECri3wdMqOa7AeV0gV584kL6/gPJZ4JcIfL+zf60NEss/d5dUdl34WX329EcHtDhTpdiCzEHpR8wqh2bKYLFmw+2UI8Uo46+uSbqhokygB1HxaYjfiikX+T7hjfueAr2nuNjKcO4lroXQoWDvlehujnt/453C951WCCdZHu5rO/qaxyoQaJn+jZBT1/T4FlMMGo/cOjbnWE/lv0IqenzBMikqco7C1EORYGT//MP5TDAtdddkvWePdl7v1EtdzGfBuow1kId7QAE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17394.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?dkNPRTQ4clNqOXk3ZTNVaU5neUVKUURyQk90VjQ1N2hSdnV5LzlQV3Rv?=
 =?iso-2022-jp?B?N0lvckZJREdxMDJHTitsQ2ppb3JzMHgxYzVvYTNJMVZQdFdnZGlFMnNj?=
 =?iso-2022-jp?B?SG1Ha2w1MVh4K0EwalR0RDNUay91QWdnV1NGMTV5Q1hUZ3FERDNJOGhQ?=
 =?iso-2022-jp?B?anFxbytjQU1jWC8wMUJPOTlGRGlOR2d1bG1wWWQzTmVIVU5UZ3BudHhP?=
 =?iso-2022-jp?B?eGpsRmQrMWZ4ZWlNSVQ1MnpzN2FxU2h5WlBySHRib0piZlJ6dUpxM0Ex?=
 =?iso-2022-jp?B?anF6dUpKUHpZSlo5aW1UdE82eVJjaVRJcFlWeWpGaU1UNkxiWmRDYmwy?=
 =?iso-2022-jp?B?RjFMbkYzUGZZTmZyeVpISWJjc2lqTUlUMjRLUnM0MnRqNDF0TGhjZjRX?=
 =?iso-2022-jp?B?L2FNREVoVS9CQXYrT2REb0JxeWd4UFZsYVluWEFRM0xZNTdHdGZXKzFC?=
 =?iso-2022-jp?B?cmFyY1V5M0FCTXBvV0ZTTXdRZGtMOUFONVhhVFdsdFRYZlI4UTB6K0Z3?=
 =?iso-2022-jp?B?bUpFN3BwMnRZTnhFbDVDdnFqSWJMdENzdTBGeWNZdmIrL09sM0JDZkNQ?=
 =?iso-2022-jp?B?em9taVd6NXFSQWFRa2pLZ2N1RXNUMUlQekdHSEhmTVFMaUJZdEZ4aUNK?=
 =?iso-2022-jp?B?NW53dTk5YWdYYjRxMDhEUUJYT09iZkxJOS9IK0VDZmliWHE5OEp4ejVP?=
 =?iso-2022-jp?B?OER4T2x1c3Uxb0diRlZ5Qmd4bk1BVitZL2JUOGIrOXFmMTRTcW5CVFcz?=
 =?iso-2022-jp?B?VEREMk5LSzllZllhVWdYa0pZTk9mc2pZRlVtM29HM1lkQXZ3U05vMDcr?=
 =?iso-2022-jp?B?TExVbFJQRWJZcDZGMWU4b3VnbURybkh2Ny9CcXpqSmRnaVN3V2FjMXhu?=
 =?iso-2022-jp?B?b01ZQU1BcWFuSXlYSm1aZ00vdGxjNHdpU1MxajliMGtHWm1lRUg1TzQr?=
 =?iso-2022-jp?B?TkZKdmVlT3dlSmJzWVVvaXo5N2pYV3ZGWnd2NGN0dTdweGx3cy9ta2tS?=
 =?iso-2022-jp?B?WU8rd00zbC9VQlRLU0ZjS2tpZUdkM0ZJSzhvZXkyNHFzTkdXbSszSURS?=
 =?iso-2022-jp?B?Z2RkdVQrdnBjakZISlJJZGtpakR4Z2lxVWwxSlpqaU9ocy9wUXBCQkJy?=
 =?iso-2022-jp?B?dDUrVjdSaEJBQzlmcUFZNkJxQk9jbEFjNUpHWXFkQVhqS3FQdEhqSXQv?=
 =?iso-2022-jp?B?SVh2SHIyRFlzbU1MTjNlVS84T3ZKa3J1emJDbmNnNG9QN05qMmRXWlBx?=
 =?iso-2022-jp?B?OC9yVHFIVEtDTzUxTUhhMEFVRXMrVTZSb3pFbjFTMGdqdWl5cGE3RUZj?=
 =?iso-2022-jp?B?eWVwTWdCUXJBa2tNeFdzMXUyc2tvVXRYZDdHYmtpdFJobzVJbHJUQ3Jo?=
 =?iso-2022-jp?B?OHl5ZEtlaUVMdjRLR0FvTnU5c29wdXlKeDJjZVVyQUFWVkYwbHl0bnRo?=
 =?iso-2022-jp?B?S2syU1NNdnJyejJvN1lZWUlYQjdLbXBGeGtEVTNRNmx1eE9RV2M1b1E5?=
 =?iso-2022-jp?B?OHZpYVlnZWF3TUpOdXk3ZlVzbGRCMVhaSlRzQSt5NW13dllVcHFSdExR?=
 =?iso-2022-jp?B?dWNaVUhneW9NTytMYS9QVDdoREozWnNxd3pKNDh0VTREMVFOUGJmMmxq?=
 =?iso-2022-jp?B?VkVlNllRN2Q4MjBxUk1RWG1FLzh6a3hGR3pFTjlacjdnR282RzE1eUd0?=
 =?iso-2022-jp?B?THozdEdubEMveDUweEJzZ1AyVzhzeUNsQUt3S2U5LzNFMGJOb0dnYXd3?=
 =?iso-2022-jp?B?L29qOW9sSDQ2S09EK1BYUHBacFFrYVlEWlF2WnBGbitITFBQanJiUU9j?=
 =?iso-2022-jp?B?QVpLMGIxRVZaOFMycGxhOGhHYU5nUml1L2s1cEVJTGdrQnkyM1J5WWx0?=
 =?iso-2022-jp?B?OFVIclhsRUNmaWhCVENzK1N1UndRNldvVk5vUjJNeXhCN3RRTUV6YkRr?=
 =?iso-2022-jp?B?MEZsYmtKRFRqaGxTQ3IyUDdQNTU4RVQxTFV5Z3VSL0hLUXRjbUJHZXRR?=
 =?iso-2022-jp?B?NTMwZ0p3amw5Q0RqWGtkQzFKcDNvM3AxTEZOOXR1RkRqdnFSRzdCL0t5?=
 =?iso-2022-jp?B?Um1wL2Z5anhvUUt1L0ZXMks5cHJjR3NneGdUU0NUdWdXUjQ2RGowZTdZ?=
 =?iso-2022-jp?B?TDIvOXNjZ2ZicDFkVC9QdmxFa2RxWnVIZzJsajZmT1J2VzJlTmJmQnhI?=
 =?iso-2022-jp?B?bG5CVE5zYWk4Nkd5cGtuNUhJdWo3STQ3cWNkZFZXam5pZ3pRbG5mSmxy?=
 =?iso-2022-jp?B?SGFvbmtOaE5aL3RCaytUQ2s3U1lJTWV0d3B5aHRCY3crRHBrQzNtWUgw?=
 =?iso-2022-jp?B?Q2hRLzZ1aHQrTUM1QkU1N1BxZ1BkdUxKaG53VmcvK1N5bzVLL0pobjQr?=
 =?iso-2022-jp?B?anhlYlRYMEdlRCtLNU1wb2cvNnMxaVNIZGJmb3VsOUpiMVdrS1ZIK1cy?=
 =?iso-2022-jp?B?emxvK2ppK1h3Q1lGTXBOVjlkdGJ6MWdNMEVYd2xlOXh5SFVac2l3YzZl?=
 =?iso-2022-jp?B?VzhZOG8xTlptOUJUSCs1bFJPbk8zdWcrWnZkUT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17394.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54b315c-c9bd-4b96-2e6f-08deeee35fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 09:09:06.4348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9XrAryloIHU+U+/iEvnLHOlng1S6SL/E7MV2KjbcdZ0Ir89e3rytNRLFXT3fH1nqhLpt9ax22dbutQlyoq4VwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12754

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
 drivers/acpi/pci_root.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 4c06c3ffd0cb..3a24d018436b 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -574,6 +574,12 @@ static void negotiate_os_control(struct acpi_pci_root =
*root, int *no_aspm)
 		return;
 	}
=20
+	/* _OSC is optional for PCI host bridges */
+	if (!is_pcie(root) && !acpi_has_method(handle, "_OSC")) {
+		dev_dbg(&device->dev, "_OSC: negotiation skipped (method not present for=
 non-PCIe host bridge)\n");
+		return;
+	}
+
 	support =3D calculate_support();
=20
 	decode_osc_support(root, "OS supports", support);
@@ -615,10 +621,6 @@ static void negotiate_os_control(struct acpi_pci_root =
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
