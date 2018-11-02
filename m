Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF93C32789
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EAC2081F
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EHiz9VTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EAC2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeKCDTR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:19:17 -0400
Received: from mail-co1nam03on0084.outbound.protection.outlook.com ([104.47.40.84]:8240
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728147AbeKCDTQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 23:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyRxT5+Ut1HFiT5hDzzpXKkNu9f9fdINR0dKlOEWchU=;
 b=EHiz9VTP4ye3Ji4P7/KfNqymObQ5NAdbBxXCVqsaZHQGoiuABywfphh9QDfxMEjV2ys7mDcaIGvgdp3hJyKMJSjgrKem4xm4dIhK9MLSTpjXxdGPH8pG44RiuVYheGF7hRax4Q1/yesnDJKy6lV4r8b0fBUwEujWWYipwx8vpQo=
Received: from CY4PR12MB1768.namprd12.prod.outlook.com (10.175.63.10) by
 CY4PR12MB1894.namprd12.prod.outlook.com (10.175.82.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.27; Fri, 2 Nov 2018 18:11:10 +0000
Received: from CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3]) by CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3%7]) with mapi id 15.20.1273.030; Fri, 2 Nov 2018
 18:11:10 +0000
From:   "Woods, Brian" <Brian.Woods@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Woods, Brian" <Brian.Woods@amd.com>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH 3/4] x86/amd_nb: add PCI device IDs for F17h M30h
Thread-Topic: [PATCH 3/4] x86/amd_nb: add PCI device IDs for F17h M30h
Thread-Index: AQHUctduPkJIQryqhkuDE4Q3WPgFfg==
Date:   Fri, 2 Nov 2018 18:11:10 +0000
Message-ID: <20181102181055.130531-4-brian.woods@amd.com>
References: <20181102181055.130531-1-brian.woods@amd.com>
In-Reply-To: <20181102181055.130531-1-brian.woods@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0038.namprd04.prod.outlook.com
 (2603:10b6:803:2a::24) To CY4PR12MB1768.namprd12.prod.outlook.com
 (2603:10b6:903:122::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Woods@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1894;20:wJhcN7BLUhp9TjegHG0zx8lWu2EzdCMPXSNbcr7DUbIP3hrlSy8hkQtZ3k9FYhtzR60Um6zzuy/NURfL8/Cemkz4OpaqLMxqbufWVw/cNW1NpMCHEs101wCUyRUEX7nN+6gDrH2cJ5yCV8AKb1JZZZSnIVn7a5BYzHfHdVtfQsWCuo0paKFUoMfwQ2gS0H25T1IGxYWAb9asyc/CzfvqPIyTpmBVMAZxQf+l73PtkbP9Y1LuNL6wUATJycs1TZnM
x-ms-office365-filtering-correlation-id: 34b7e6f7-a87a-43a3-8834-08d640ee910e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1894;
x-ms-traffictypediagnostic: CY4PR12MB1894:
x-microsoft-antispam-prvs: <CY4PR12MB18949C8726AA7363A7A32A37E5CF0@CY4PR12MB1894.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CY4PR12MB1894;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1894;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(6486002)(72206003)(6512007)(6436002)(7416002)(14444005)(2906002)(25786009)(478600001)(105586002)(99286004)(52116002)(106356001)(14454004)(2900100001)(66066001)(7736002)(305945005)(97736004)(36756003)(53936002)(8936002)(81166006)(8676002)(486006)(186003)(2501003)(476003)(110136005)(2201001)(81156014)(316002)(3846002)(86362001)(11346002)(2616005)(102836004)(1076002)(71190400001)(76176011)(71200400001)(256004)(5660300001)(386003)(26005)(68736007)(6116002)(575784001)(446003)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1894;H:CY4PR12MB1768.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ksNOVsMlZcSZb5mhLWD8RWUwF2A2jtU1C1qBL9+MvcOXWwV9DN3dQGe7Tgw+hS0kkJAN+oh617ScJNVSEQgO+cOYCRmunvrmORMjGIBFKgh/uiZOr65PFF/fI2BwYITq39bQFdnsBCUkX2OsIHRc+yAIt289UMH0AwhXgFPkUK/RThSLllRcChrSV31l3r5eh9FL01AvVG5zz+phPT2WB3OUd5T0uBwW9AxWYxMaB7asSeTgF6H+gNFbmt3gcs+o6OujXv7Dcmv6ptFSzhs+yMWHmhO8etu7RFOBBsu12wHtQ4BJ7M0t6LGc4RLUcawZiwAgcr6A8IIJc2nyHPFEIeazm4eQBzMwM0b9LH8IqRQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b7e6f7-a87a-43a3-8834-08d640ee910e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 18:11:10.4234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1894
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the PCI device IDs for family 17h model 30h, since they are needed
for accessing various registers via the data fabric/SMN interface.

Signed-off-by: Brian Woods <brian.woods@amd.com>
---
 arch/x86/kernel/amd_nb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index c0bf26aeb7c3..fd69067f6eb1 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -16,8 +16,11 @@
=20
 #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
+#define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
=20
 /* Protect the PCI config register pairs used for SMN and DF indirect acce=
ss. */
 static DEFINE_MUTEX(smn_mutex);
@@ -27,9 +30,11 @@ static u32 *flush_words;
 static const struct pci_device_id amd_root_ids[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
 	{}
 };
=20
+
 #define PCI_DEVICE_ID_AMD_CNB17H_F4     0x1704
=20
 const struct pci_device_id amd_nb_misc_ids[] =3D {
@@ -43,6 +48,7 @@ const struct pci_device_id amd_nb_misc_ids[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{}
 };
@@ -56,6 +62,7 @@ static const struct pci_device_id amd_nb_link_ids[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{}
 };
--=20
2.11.0

