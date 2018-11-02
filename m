Return-Path: <SRS0=VxNY=NN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DFCC65C22
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63702082E
	for <linux-pci@archiver.kernel.org>; Fri,  2 Nov 2018 18:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c0F10zVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63702082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeKCDTx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:19:53 -0400
Received: from mail-eopbgr700058.outbound.protection.outlook.com ([40.107.70.58]:45306
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726700AbeKCDTx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Nov 2018 23:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8KSgUj3RZEGAo3s4qpZEgCQxc2isj3LSqvTvBxnIJ4=;
 b=c0F10zVIAq0CKaCA7o3w1LX3q3kZNy2Y6ICnATEI6yfgRbY8x8bc2RdeciHCB6yoWwG3zltveDw9KSddvlTm4itNa6Z8y+ReaZam9A8HRiZE+nhJsUfrK43LGxfwHogxls4wV9uUEkRM6tWrM0yWMEPv6UdIlsAv5QwYYB0C3Xs=
Received: from CY4PR12MB1768.namprd12.prod.outlook.com (10.175.63.10) by
 CY4PR12MB1206.namprd12.prod.outlook.com (10.168.166.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 2 Nov 2018 18:11:08 +0000
Received: from CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3]) by CY4PR12MB1768.namprd12.prod.outlook.com
 ([fe80::82f:4b8a:fd43:aab3%7]) with mapi id 15.20.1273.030; Fri, 2 Nov 2018
 18:11:08 +0000
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
Subject: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Thread-Topic: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Thread-Index: AQHUctdtTs18UoG4rUKlKIFT94W0kg==
Date:   Fri, 2 Nov 2018 18:11:07 +0000
Message-ID: <20181102181055.130531-3-brian.woods@amd.com>
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
x-microsoft-exchange-diagnostics: 1;CY4PR12MB1206;20:th85HpMH72oODDGkTeNSz6RWR3Ndn43S22dWNHausqAMP0NCpblX2nqsf7fg+uheHM8nHwg4j+lUAZJKSXNLLe+U2dx7R/BOJ1c04llKC3vqrbgcxAQnS42OssBVOsq0krdvxwnRANwnEcz+mdXgxN8HbQIEB/gv+Ef/9utKu68aPfj+UbW4UH2y3CcFza74RZdh+bpd8GHe3oXzZbmAfQx1fkRNaUUQHFhbEpgzULVYuBXkG9aTJg/Ie+XCsh1S
x-ms-office365-filtering-correlation-id: c335a382-1385-42d8-21c3-08d640ee8fa4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1206;
x-ms-traffictypediagnostic: CY4PR12MB1206:
x-microsoft-antispam-prvs: <CY4PR12MB120699D3721338B30F392639E5CF0@CY4PR12MB1206.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:CY4PR12MB1206;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1206;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(136003)(189003)(199004)(7736002)(11346002)(2900100001)(478600001)(36756003)(6116002)(1076002)(316002)(3846002)(105586002)(106356001)(2906002)(25786009)(486006)(97736004)(71190400001)(6512007)(71200400001)(110136005)(256004)(6486002)(6436002)(99286004)(7416002)(386003)(53936002)(26005)(66066001)(6506007)(186003)(8936002)(5660300001)(86362001)(575784001)(72206003)(81166006)(81156014)(102836004)(305945005)(476003)(446003)(2616005)(68736007)(2501003)(14454004)(2201001)(8676002)(52116002)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1206;H:CY4PR12MB1768.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yI8yxhHEO9O1mXF99OMMDn8d66EEjQ4cTAhBtamMhwtKJj5iq28QzPqs3cNPvAqJHQoUH9YwnsvIR5QmvEYvNDgePfXdR7BCFYP+pZEe1yAPiuoCHwTwl5s/FPvrnRJUx17fRHdFT1bWrYJshdlKjs+XXN78wCi33VTuhVZ/cBRLzLtsLaUzicFmLshGvgYL4bRhdzlRx+polthOwc3jg/hAblEDbZyIqpHViz5PiZUa07rrqiaowpt0aELrEgACBzwC1lDqDSprQ8MdEQaEelHBb6Gqk3momhLrqXmRP/T7Vr3pVmOLwE/qy74KkXwrbcrAmDsVPIyo5IJcGfuFaM+4wxjhti7ntQMeB0uFBPY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c335a382-1385-42d8-21c3-08d640ee8fa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 18:11:07.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1206
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for new processors which have multiple PCI root complexes
per data fabric/SMN interface.  The interfaces per root complex are
redundant and should be skipped.  This makes sure the DF/SMN interfaces
get accessed via the correct root complex.

Ex:
DF/SMN 0 -> 60
	    40
	    20
	    00
DF/SMN 1 -> e0
	    c0
	    a0
	    80

Signed-off-by: Brian Woods <brian.woods@amd.com>
---
 arch/x86/kernel/amd_nb.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 19d489ee2b1e..c0bf26aeb7c3 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -213,7 +213,10 @@ int amd_cache_northbridges(void)
 	const struct pci_device_id *root_ids =3D amd_root_ids;
 	struct pci_dev *root, *misc, *link;
 	struct amd_northbridge *nb;
-	u16 i =3D 0;
+	u16 roots_per_misc =3D 0;
+	u16 misc_count =3D 0;
+	u16 root_count =3D 0;
+	u16 i, j;
=20
 	if (amd_northbridges.num)
 		return 0;
@@ -226,26 +229,52 @@ int amd_cache_northbridges(void)
=20
 	misc =3D NULL;
 	while ((misc =3D next_northbridge(misc, misc_ids)) !=3D NULL)
-		i++;
+		misc_count++;
=20
-	if (!i)
+	root =3D NULL;
+	while ((root =3D next_northbridge(root, root_ids)) !=3D NULL)
+		root_count++;
+
+	if (!misc_count)
 		return -ENODEV;
=20
-	nb =3D kcalloc(i, sizeof(struct amd_northbridge), GFP_KERNEL);
+	if (root_count) {
+		roots_per_misc =3D root_count / misc_count;
+
+		/*
+		 * There should be _exactly_ N roots for each DF/SMN
+		 * interface.
+		 */
+		if (!roots_per_misc || (root_count % roots_per_misc)) {
+			pr_info("Unsupported AMD DF/PCI configuration found\n");
+			return -ENODEV;
+		}
+	}
+
+	nb =3D kcalloc(misc_count, sizeof(struct amd_northbridge), GFP_KERNEL);
 	if (!nb)
 		return -ENOMEM;
=20
 	amd_northbridges.nb =3D nb;
-	amd_northbridges.num =3D i;
+	amd_northbridges.num =3D misc_count;
=20
 	link =3D misc =3D root =3D NULL;
-	for (i =3D 0; i !=3D amd_northbridges.num; i++) {
+	for (i =3D 0; i < amd_northbridges.num; i++) {
 		node_to_amd_nb(i)->root =3D root =3D
 			next_northbridge(root, root_ids);
 		node_to_amd_nb(i)->misc =3D misc =3D
 			next_northbridge(misc, misc_ids);
 		node_to_amd_nb(i)->link =3D link =3D
 			next_northbridge(link, link_ids);
+
+		/*
+		 * If there are more root devices than data fabric/SMN,
+		 * interfaces, then the root devices per DF/SMN
+		 * interface are redundant and N-1 should be skipped so
+		 * they aren't mapped incorrectly.
+		 */
+		for (j =3D 1; j < roots_per_misc; j++)
+			root =3D next_northbridge(root, root_ids);
 	}
=20
 	if (amd_gart_present())
--=20
2.11.0

