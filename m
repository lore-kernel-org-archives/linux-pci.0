Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7BBC65C22
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61D52081F
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FUYqyKCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61D52081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeKCDTL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:19:11 -0400
Received: from mail-eopbgr700066.outbound.protection.outlook.com ([40.107.70.66]:51469
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726700AbeKCDTL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 23:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xplz2xb40fRxhyTMIJzBed1Axyo8cX5rku9Q0s3T45k=;
 b=FUYqyKCTZRqPSDe/A+njdTo4M694Tid5L5WJfGiLEzuaGlIrXUPsxJlTaghJqYGRH66mA8LJR/TMe2Jt68sxKp7Qcj09QkiYRWUmikrblpv/C14hMAhHezSb8VufaIXYtTwHN+IivELB2OBkInUqtRaM376Oz7atwFUk+dCk4T4=
Received: from CY4PR12MB1768.namprd12.prod.outlook.com (10.175.63.10) by
 CY4PR12MB1206.namprd12.prod.outlook.com (10.168.166.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 2 Nov 2018 18:11:05 +0000
Received: from CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3]) by CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3%7]) with mapi id 15.20.1273.030; Fri, 2 Nov 2018
 18:11:05 +0000
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
Subject: [PATCH 1/4] k10temp: x86/amd_nb: consolidate shared device IDs
Thread-Topic: [PATCH 1/4] k10temp: x86/amd_nb: consolidate shared device IDs
Thread-Index: AQHUctdrYU+Nz/5370upCwoxAigLkg==
Date:   Fri, 2 Nov 2018 18:11:04 +0000
Message-ID: <20181102181055.130531-2-brian.woods@amd.com>
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
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1206;20:cNuJfhfHO23lkE7ng8Cp0d7uulO9S/hMo9nIEIzsftEpuQdXLyLfNymCe1eXwoC6GiNRdFspLvFmA5s8M2p+0f49ZeyCyDXRaKcmCXkLFOJlzkE0hHozbSYEG/m3qXzBHywoZZrIxBclMdHxnnh+6pDH1Afr1gxykpwQpcjfzjzj9ra9QznbhMm1y63+pHcpbKKfQBndQW9PrzpG3e26XNku+/UDPqxBVceoJEW/TnHgjIIgoifeBmfQvuDSX2HS
x-ms-office365-filtering-correlation-id: d4b24866-d349-4739-fd77-08d640ee8d99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1206;
x-ms-traffictypediagnostic: CY4PR12MB1206:
x-microsoft-antispam-prvs: <CY4PR12MB12062FB976E2E586D4C72998E5CF0@CY4PR12MB1206.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR12MB1206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1206;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(7736002)(11346002)(2900100001)(478600001)(36756003)(6116002)(1076002)(316002)(3846002)(105586002)(106356001)(2906002)(25786009)(486006)(97736004)(71190400001)(6512007)(71200400001)(14444005)(110136005)(256004)(6486002)(6436002)(99286004)(7416002)(386003)(53936002)(26005)(66066001)(6506007)(186003)(8936002)(5660300001)(86362001)(575784001)(72206003)(81166006)(81156014)(102836004)(305945005)(476003)(446003)(2616005)(68736007)(2501003)(14454004)(2201001)(8676002)(52116002)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1206;H:CY4PR12MB1768.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VTQDVgOopunR8sEc1sZJ3dshHeeE2pV7iC3Arh1qEOoPPPC6gW1pa6Ab355k+ubPe4Too3x4RUobDtrCLEf3m9gMBVn0aKkB9cFq1HIg6tbAbQIxN0eRR+2+dQ1T9Ar2AL/xoEgX80UpZ8/RJp5/+cQBBgabXdwjqqQLPYEu4XzJO2zfeDGMhF9oy7bziFgTs0hemnwqR2T1cs99KYvVwjtXs6yRElt/g+xtSpVdO7uQerj7QsOh1ywAacP/zxVImzt0r2B/Hc9VdU7/k6AlhYsYO6H4KBdpZySMwg8MjocA4qIa+c/zzyzPvUKewxVS4XjyVLL1VEkdHSbQK3sexRtrzK4H3OQCLPf82WwZ/Bk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b24866-d349-4739-fd77-08d640ee8d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 18:11:05.1889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1206
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Consolidate shared PCI_DEVICE_IDs that were scattered through k10temp
and amd_nb, and move them into pci_ids.

Signed-off-by: Brian Woods <brian.woods@amd.com>
---
 arch/x86/kernel/amd_nb.c | 3 +--
 drivers/hwmon/k10temp.c  | 9 +--------
 include/linux/pci_ids.h  | 2 ++
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index a6eca647bc76..19d489ee2b1e 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -11,13 +11,12 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
+#include <linux/pci_ids.h>
 #include <asm/amd_nb.h>
=20
 #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
-#define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
=20
 /* Protect the PCI config register pairs used for SMN and DF indirect acce=
ss. */
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 2cef0c37ff6f..bc6871c8dd4e 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci_ids.h>
 #include <asm/amd_nb.h>
 #include <asm/processor.h>
=20
@@ -41,14 +42,6 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define PCI_DEVICE_ID_AMD_15H_M70H_NB_F3	0x15b3
 #endif
=20
-#ifndef PCI_DEVICE_ID_AMD_17H_DF_F3
-#define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
-#endif
-
-#ifndef PCI_DEVICE_ID_AMD_17H_M10H_DF_F3
-#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3	0x15eb
-#endif
-
 /* CPUID function 0x80000001, ebx */
 #define CPUID_PKGTYPE_MASK	0xf0000000
 #define CPUID_PKGTYPE_F		0x00000000
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 69f0abe1ba1a..78d5cd29778a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -545,6 +545,8 @@
 #define PCI_DEVICE_ID_AMD_16H_NB_F4	0x1534
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F3 0x1583
 #define PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 0x1584
+#define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
+#define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
--=20
2.11.0

