Return-Path: <SRS0=wh2u=NR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3F2C32789
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 20:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE0402085B
	for <linux-pci@archiver.kernel.org>; Tue,  6 Nov 2018 20:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wCmJs6Zv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0402085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeKGFfK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:35:10 -0500
Received: from mail-eopbgr710077.outbound.protection.outlook.com ([40.107.71.77]:4676
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbeKGFfK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 00:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHHK+UHx0F3mawwvmsiJoh6Keb0Lk+c5YHuQfjAO36E=;
 b=wCmJs6ZvCkFmV4vizQ8IZHy5gtgwrIV9RBX14ZgV6qPSqtRTK4DR/kiVQkdk6oyAomZwEJPxdpuSL4EMvFvpyt4jWqJUro0xqm6O/k3jhIFX1e/PRFciLQ8/tg7XpR6QZdLSgr6FLwDCpYZviLur5dFdjnZg5hkZzUkMN2VK3nY=
Received: from BN6PR12MB1764.namprd12.prod.outlook.com (10.175.101.137) by
 BN6PR12MB1540.namprd12.prod.outlook.com (10.172.18.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 20:08:12 +0000
Received: from BN6PR12MB1764.namprd12.prod.outlook.com
 ([fe80::d455:a1d4:8ed9:7e13]) by BN6PR12MB1764.namprd12.prod.outlook.com
 ([fe80::d455:a1d4:8ed9:7e13%7]) with mapi id 15.20.1294.032; Tue, 6 Nov 2018
 20:08:11 +0000
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
Subject: [PATCH v2 0/4] Update DF/SMN access and k10temp for AMD F17h M30h
Thread-Topic: [PATCH v2 0/4] Update DF/SMN access and k10temp for AMD F17h
 M30h
Thread-Index: AQHUdgxxTwbSaqdBw0WUHLK6HNyw7g==
Date:   Tue, 6 Nov 2018 20:08:11 +0000
Message-ID: <20181106200754.60722-1-brian.woods@amd.com>
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
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1540;20:KJXyCxc+HEV3A9zX8/VMVZ5y7TwljRBm2Jv0raHf96M+e+Q0tOhvcmm/dF6ehOr52uzN/n1AynbwAmeldcOccaeBqkZWlPGSAzas+KY9w/0q9nnxWDSYOufRRHIgJix/0VfUBJizw5hB+d4Eej23TSwm0RFn+xoQ3bMvq4JqZm75dUiJjX8cmKpn6RVzKQpHU3qI/d6hJD62LpkddFiOoyHLWDpvYcqZcbMLbXq9gaEGShg871MRMQdZcVMrwZWZ
x-ms-office365-filtering-correlation-id: 0852d438-cfdb-46d4-b751-08d6442393a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1540;
x-ms-traffictypediagnostic: BN6PR12MB1540:
x-microsoft-antispam-prvs: <BN6PR12MB1540080DD0221906BA43F586E5CB0@BN6PR12MB1540.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR12MB1540;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1540;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(71190400001)(105586002)(106356001)(6506007)(36756003)(186003)(52116002)(386003)(2616005)(486006)(256004)(14444005)(7736002)(14454004)(478600001)(72206003)(26005)(305945005)(316002)(5660300001)(110136005)(8676002)(68736007)(2906002)(6486002)(53936002)(81166006)(81156014)(2501003)(476003)(8936002)(66066001)(6512007)(2201001)(99286004)(2900100001)(15650500001)(1076002)(97736004)(86362001)(575784001)(25786009)(102836004)(6116002)(6436002)(7416002)(3846002)(71200400001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1540;H:BN6PR12MB1764.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1kpCfiIp2KoVRBtkdcHNRSw23I9BC3xKmx6oMUE3WJHlg0Z/TKLnYpUL8s25ILWGpI2XLY6M11tTtiEYgQWTRm/0vCc4jSx7EFRjRDuigKW3rYTKQ53lTuJsDUL+7uwTSqf/xOY5TWCt9cc5aguuVjSNOqsCDABLI3oAwMMG8EyOM0gEgIVkiA/DIlS4VaTffOq90/Of5LvODBVnldljljJO1WZOwV1bGpk75CHC/2Tm2JleYoWFs5NqGDeXS9jBwZZTWM5AJJgS3Evr6zIJJGGkjqDq/3Te+RtIXV5/mhLJmCgGh4xNllygw/QWA9ZsIF8iE1YaU9EwaTySrps+lfxLwNn2nrI1uzF/Sa4Vpr8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0852d438-cfdb-46d4-b751-08d6442393a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 20:08:11.8927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1540
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Updates the data fabric/system management network code needed to get
k10temp working for M30h.  Since there are now processors which have
multiple roots per DF/SMN interface, there needs to some logic which
skips N-1 root complexes per DF/SMN interface.  This is because the root
complexes per interface are redundant (as far as DF/SMN goes).  These
changes shouldn't effect past processors and, for F17h M0Xh, the
mappings stay the same.

v1 -> v2:
  * patch 3 & 4: add M30_DF_F3 straight to pci_ids.h to reduce churn
  * patch 2:
    - update commit msg and comment to explain root selection further
    - move return if !misc_count under where misc_count is calculated

Brian Woods (4):
  k10temp: x86/amd_nb: consolidate shared device IDs
  x86/amd_nb: add support for newer PCI topologies
  x86/amd_nb: add PCI device IDs for F17h M30h
  hwmon: k10temp: add support for AMD F17h M30h CPUs

 arch/x86/kernel/amd_nb.c | 53 ++++++++++++++++++++++++++++++++++++++++----=
----
 drivers/hwmon/k10temp.c  | 10 ++-------
 include/linux/pci_ids.h  |  3 +++
 3 files changed, 50 insertions(+), 16 deletions(-)

--=20
2.11.0

