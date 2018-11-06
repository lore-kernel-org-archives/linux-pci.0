Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E775AC32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 20:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80D72085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 20:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lb1tfLFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80D72085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeKGFfp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:35:45 -0500
Received: from mail-eopbgr710077.outbound.protection.outlook.com ([40.107.71.77]:4676
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbeKGFf1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 00:35:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76CMTP5KtuyE0cpQ/R0lyCw3M5nAhw9AtFd/7P7vEFU=;
 b=lb1tfLFXSQ/Y35M7ZEHSUHJ3klcXluuCagHQ+18LDmCnXchWAqomi/jfwHP93QWh15FsQj24h2DjqJXWI8rWE97yIvvnB1eTYLbpJk+wQKSK6Sh1FQbMVzNQq3U32yvFB3mc/6DUAkcvVhJqDAIIKe6CdP7+t/njTot22Ywx830=
Received: from BN6PR12MB1764.namprd12.prod.outlook.com (10.175.101.137) by
 BN6PR12MB1540.namprd12.prod.outlook.com (10.172.18.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 20:08:18 +0000
Received: from BN6PR12MB1764.namprd12.prod.outlook.com
 ([fe80::d455:a1d4:8ed9:7e13]) by BN6PR12MB1764.namprd12.prod.outlook.com
 ([fe80::d455:a1d4:8ed9:7e13%7]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 20:08:18 +0000
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
Subject: [PATCH v2 3/4] x86/amd_nb: add PCI device IDs for F17h M30h
Thread-Topic: [PATCH v2 3/4] x86/amd_nb: add PCI device IDs for F17h M30h
Thread-Index: AQHUdgx1LXJESy1eNUy2uWtociULCQ==
Date:   Tue, 6 Nov 2018 20:08:18 +0000
Message-ID: <20181106200754.60722-4-brian.woods@amd.com>
References: <20181106200754.60722-1-brian.woods@amd.com>
In-Reply-To: <20181106200754.60722-1-brian.woods@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0002.namprd02.prod.outlook.com
 (2603:10b6:803:2b::12) To BN6PR12MB1764.namprd12.prod.outlook.com
 (2603:10b6:404:107::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Woods@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1540;20:/QRG32aQ5rnakunOXi2dCLgGTM//t3LFQtBKHkWMBgnyLb6/ANNMbd9QlLBNigIWDcx1X7dIZHL+ZFHaitq6Ytidtmxr2RcS66qpcVvP65AMoFnPDvbpkvD13b2CPSLRA/TXuRFBXWir/7Dg3LDIqOkJWXJgdhqixl58S3plILu6sjge55KBjFrlBWTKBcqBzkrZM57C6OnCD2A0sQL4Q/Bfhg9mEpnfSEGUyxbTRgrJ1cnhfKuzB/BlKRyblN34
x-ms-office365-filtering-correlation-id: 429af7d2-9f02-4147-3f75-08d6442397f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1540;
x-ms-traffictypediagnostic: BN6PR12MB1540:
x-microsoft-antispam-prvs: <BN6PR12MB1540D7B5BFDC4F4F9947A8B4E5CB0@BN6PR12MB1540.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1540;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1540;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(71190400001)(105586002)(106356001)(6506007)(36756003)(76176011)(186003)(52116002)(386003)(2616005)(486006)(11346002)(256004)(14444005)(446003)(7736002)(14454004)(478600001)(72206003)(26005)(305945005)(316002)(5660300001)(110136005)(8676002)(68736007)(2906002)(6486002)(53936002)(81166006)(81156014)(2501003)(476003)(8936002)(66066001)(6512007)(2201001)(99286004)(2900100001)(1076002)(97736004)(86362001)(575784001)(25786009)(102836004)(6116002)(6436002)(7416002)(3846002)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1540;H:BN6PR12MB1764.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6gAmrudlVhHTZfa3l0xTraRrQ6ROirZOCmK+6JmadSv/EPND18RzIxAv/O3/blPFr8b9SkSr7GfkJ158K9muNxer5oMEAk69SzyXRv/PDAxBKjeogOCLMLdtTTFrIbzudwcPiJFEPkcISVSTMQGTfZcgs67atqqiSY7NwyLs51I3i8Npv/t1krWCRfNCEKgq9sOhpTAfXsjVYncCY9WiX6L704JaGpXhsHNjf3TfT2SryQPENCPYkGayfEjDqgL+33sEZYBFc1gQtxcB/KI9QqFFonsmRFkGBedjB7kY8anTLeL9FDj3nXXhA+xjvGg08/3FUJM42ktPaaomBfzLoPMMjzRryNpMa1/q7lJNm/I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429af7d2-9f02-4147-3f75-08d6442397f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 20:08:18.7074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1540
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the PCI device IDs for family 17h model 30h, since they are needed
for accessing various registers via the data fabric/SMN interface.

Signed-off-by: Brian Woods <brian.woods@amd.com>
---
 arch/x86/kernel/amd_nb.c | 6 ++++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index cc34266e3c62..cc51275c8759 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -16,8 +16,10 @@
=20
 #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
+#define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
=20
 /* Protect the PCI config register pairs used for SMN and DF indirect acce=
ss. */
 static DEFINE_MUTEX(smn_mutex);
@@ -27,9 +29,11 @@ static u32 *flush_words;
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
@@ -43,6 +47,7 @@ const struct pci_device_id amd_nb_misc_ids[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{}
 };
@@ -56,6 +61,7 @@ static const struct pci_device_id amd_nb_link_ids[] =3D {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 78d5cd29778a..349276fbd269 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -547,6 +547,7 @@
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 0x1584
 #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
+#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
--=20
2.11.0

