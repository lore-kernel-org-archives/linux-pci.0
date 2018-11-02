Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901E0C65C22
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 539F920831
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jaKERVh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539F920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeKCDTU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:19:20 -0400
Received: from mail-co1nam03on0048.outbound.protection.outlook.com ([104.47.40.48]:30688
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728253AbeKCDTT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 23:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohxu2yfwSMB+os+T+W3jYLSPB5+qao+L+b5lC5dUpio=;
 b=jaKERVh7Csb037b3/7uVZ3GUjxwO4el1xkYtX18LrlxDXXQBYEYZiktW69LBdCQfuSCt1VF6Au4Er1PF/zsYbmEXKb0pP5HTE1w2gGu5Kf9G3m1wJ7VrYmGAHKHe1uCqCDI3ulJdTI/cxU2EES/uvHUF1hjnQiAetnWzdoxDf+I=
Received: from CY4PR12MB1768.namprd12.prod.outlook.com (10.175.63.10) by
 CY4PR12MB1894.namprd12.prod.outlook.com (10.175.82.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.27; Fri, 2 Nov 2018 18:11:12 +0000
Received: from CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3]) by CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3%7]) with mapi id 15.20.1273.030; Fri, 2 Nov 2018
 18:11:12 +0000
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
Subject: [PATCH 4/4] hwmon: k10temp: add support for AMD F17h M30h CPUs
Thread-Topic: [PATCH 4/4] hwmon: k10temp: add support for AMD F17h M30h CPUs
Thread-Index: AQHUctdwXDpFliQJEEaw32IEma1Zcw==
Date:   Fri, 2 Nov 2018 18:11:12 +0000
Message-ID: <20181102181055.130531-5-brian.woods@amd.com>
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
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1894;20:nJcTEaLyMmCrvxie/6viLqMx/CaEkbwfxJxSE0Qvyy6KlZ3YfT6qZX+5lPVEaAJDc2x38AGlbNp0C3kCEHIQkQJ40IOYM09XR051NgPCQrGG26QNA0v/hSr3lKht7OdE1uPJbm8JN6NgJJn6zhu87HlYwc4xuFOqh35eTolOMJKcs6TKKvxk9B4a6RWlUpbrevyvCaFEm5OKzBXJWOYoUDCmFW5Edh/RrLkl+93qfZjo2hyqQPP96sEXZCfFAdeg
x-ms-office365-filtering-correlation-id: b24bdf98-62cd-499e-c75e-08d640ee9271
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1894;
x-ms-traffictypediagnostic: CY4PR12MB1894:
x-microsoft-antispam-prvs: <CY4PR12MB18941DA33CC2939339724B58E5CF0@CY4PR12MB1894.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CY4PR12MB1894;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1894;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(6486002)(72206003)(6512007)(6436002)(7416002)(14444005)(2906002)(25786009)(478600001)(105586002)(99286004)(52116002)(106356001)(14454004)(2900100001)(66066001)(7736002)(305945005)(97736004)(36756003)(53936002)(8936002)(81166006)(8676002)(486006)(186003)(2501003)(476003)(110136005)(2201001)(81156014)(316002)(3846002)(86362001)(11346002)(2616005)(102836004)(1076002)(71190400001)(76176011)(71200400001)(256004)(5660300001)(386003)(26005)(68736007)(6116002)(575784001)(446003)(6506007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1894;H:CY4PR12MB1768.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: KIxEYM4YzjPEC7jU66Doaza0jm4eKDyns7IvsBsHwRK2fPtG2EftE6dFrnJYSXKmSOiAXGOp1eq5uECvYAhJcs3aBLXKbLEMPaie5V/b8C2Y0aMC4OOIDBm/fJWvWyFGoFlPNUEzjycCNZC87CVd0Agr/tqVugS9BIzBNs3JnrvlsaY1t2RrKWAUmz8SqjBChGeuEGU4+G+ZiOuo3BxQaYE3euup0WlHtds+gJvqbFGxaHBIJW31zoowwRt0RpRlXMixfXvXadPkCDN/NWjXQU6pjkBPAQpicGyIrwhSYq/HGiOi/CdOAI4A/vGyWBB/QdTH8ha13dAYnXS/+uNxFC2FZBuCjlMcTG4uz+odrT0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24bdf98-62cd-499e-c75e-08d640ee9271
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 18:11:12.8140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1894
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for AMD family 17h model 30h processors for k10temp.  Model
30h is functionally the same as model 01h processors (as far as k10temp
is concerned), just the PCI device IDs need to be updated.

Signed-off-by: Brian Woods <brian.woods@amd.com>
---
 arch/x86/kernel/amd_nb.c | 1 -
 drivers/hwmon/k10temp.c  | 1 +
 include/linux/pci_ids.h  | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index fd69067f6eb1..e491aa4a1970 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -17,7 +17,6 @@
 #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
 #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
 #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
-#define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index bc6871c8dd4e..9790f1f5eb98 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -360,6 +360,7 @@ static const struct pci_device_id k10temp_id_table[] =
=3D {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_16H_M30H_NB_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, k10temp_id_table);
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

