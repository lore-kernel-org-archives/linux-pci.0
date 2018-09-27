Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0702C43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 06:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7D32156D
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 06:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="aRKX/Vmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7D32156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeI0MxI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:53:08 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:62984 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0MxH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Sep 2018 08:53:07 -0400
X-IronPort-AV: E=Sophos;i="5.54,309,1534834800"; 
   d="scan'208";a="21429516"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Sep 2018 23:36:28 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 26 Sep 2018 23:36:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98SNDhmupDQKZqMfYNf9aDCiuVQXCfsuHTzoyTvh0wo=;
 b=aRKX/VmwS5EosGlqSgaYuPgntWkibm2Rd84GZpOe8liVufepjKxV1PWHGKbvKcx3AY7jMzxKiNkI/XrUgzs3hpEgI/nnRJzBa/yeR/9876XEhJoMdxZ+oA0auraqhBvxtrW/ipGw4Z8zDukBtMu33OpxOYU1Wr1a7AoFibl8iTA=
Received: from DM2PR11MB0105.namprd11.prod.outlook.com (10.160.26.155) by
 DM2PR11MB0141.namprd11.prod.outlook.com (10.160.132.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Thu, 27 Sep 2018 06:36:24 +0000
Received: from DM2PR11MB0105.namprd11.prod.outlook.com
 ([fe80::cdb9:9501:ede9:23c4]) by DM2PR11MB0105.namprd11.prod.outlook.com
 ([fe80::cdb9:9501:ede9:23c4%2]) with mapi id 15.20.1164.024; Thu, 27 Sep 2018
 06:36:22 +0000
From:   <Wesley.Sheng@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <bhelgaas@google.com>, <corbet@lwn.net>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Wesley.Sheng@microchip.com>,
        <linux-ntb@googlegroups.com>, <linux-ntb@googlegroups.com>
Subject: [PATCH v2] NTB: switchtec_ntb: Update switchtec documentation with
 pre-requisites for NTB
Thread-Topic: [PATCH v2] NTB: switchtec_ntb: Update switchtec documentation
 with pre-requisites for NTB
Thread-Index: AdRWJ6ahEsH1t+pmS2mkegcrvKmh4A==
Date:   Thu, 27 Sep 2018 06:36:22 +0000
Message-ID: <DM2PR11MB010585C1D5584683B31CCF5495140@DM2PR11MB0105.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Wesley.Sheng@microchip.com; 
x-originating-ip: [211.144.195.220]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR11MB0141;6:VOqbjtAzQJLIyCecUc6sHbD3vdinFLv5HwOvQ9fKRlDfiBycpx8pnrat03eGHrRqr/EDzetKibNWwk8paEW8Z4S6jpGq4JU1cyZxZZXy3Sci/0VDtA2cPuyEQcqfsBzVoji39RO2br2npYarhA4Ub/EVx+eNu9rAGRGw8T32KrX6ov3Jnn5dSuD506frNsJOHnovlKAleqspxCaZEKEeg1qzZpHB9nMflDwj6DPNYzijTjQRYG32pXBBqfFJOOREHUG5C6UEJs/En4hZAzS12rbl3xAxhQ+71rpNDer2D3+Ce9+exYoKIO3Za2YUQKgdZp2a1Wc/r1Ix0K6td7HkwMnvpdHwMG41/reRPJedg7hyl6ocGEfh3pyYEBfSJoLBF5uXaCxkMxLiQMc8zHLYN5OGdAOf5t/PXgSoZbNw8jPj+PxDYL1vbU7Lf9aRoXXZMhL0gaE29f/Iye9tsH22DQ==;5:w3W3D/joy1zRGgS171hSgSDzcLTpneRQUjNNyX/N9WQOs92NvB+oCMC3SZntOrE5WHLrImxQkrFCyQjvozYI6JNsijmkK9+xOMNo5CT2HDFGJDz0ZOAxLhkPY27LMAKwBcYAhb6JU7g9kKnyn/Ah+dbvHzpce2E31IvhFzmx++M=;7:HkhDL73+/rO7vU9XJuDwz34clctF9JjiSFdVTL5dmxyoRApLtcLtAHl6Z5tHajzG/SW/BSWFayOOOsqCF+z/NwCgZpzwjFlx9Dn9rN057XpDMXp7Ez9LH159I15/Ftd7If/beAlazxkHY2LetaaQrZBZAhPSoVsFd+Bhdyeoung5iSyZxZ1RghEPY5KFySKS74HGTBr4tmX6VNvIarFgKXBddzN9o+QJoOVX5K/lcgLJNXUEVA4sXFReoMfLsyjq
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(396003)(39860400002)(376002)(189003)(199004)(9686003)(6116002)(7736002)(25786009)(53936002)(72206003)(15650500001)(478600001)(4326008)(6436002)(256004)(3846002)(14444005)(2900100001)(2906002)(34290500001)(14454004)(305945005)(5660300001)(55016002)(316002)(6506007)(54906003)(5250100002)(186003)(110136005)(68736007)(2501003)(99286004)(81156014)(71190400001)(71200400001)(2201001)(476003)(102836004)(26005)(486006)(86362001)(8936002)(105586002)(8676002)(74316002)(106356001)(33656002)(81166006)(97736004)(66066001)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR11MB0141;H:DM2PR11MB0105.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: e07c3e21-1109-4a8f-09f6-08d624438ac9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM2PR11MB0141;
x-ms-traffictypediagnostic: DM2PR11MB0141:
x-microsoft-antispam-prvs: <DM2PR11MB014125142AD295A3BED0B67895140@DM2PR11MB0141.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:DM2PR11MB0141;BCL:0;PCL:0;RULEID:;SRVR:DM2PR11MB0141;
x-forefront-prvs: 0808323E97
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: K65X6QlruNl21i65ZQ7gSNdgWHqze3Krd2nfe/aMJ4ODNMlcB6zX5dseQb3JkvN9b+Tth+hwkT6PJqZq+RyOOssVFkPu/13tjAa3iJ5fZ324iOZtTDnRzh1HPeQxI7CdsUrvkxjQRw8GTCuTMHOHaIn5wG4C1oVJY2l+h1fipyshheM6io5IkwEcAKBTkns2QJ1+HOhc7VL2NV4tMUm3Uy0bz0tHM5Xa0KBDZfItNpiLaYkRJHvnEfk7bIcPsh6HdVODRfsp101mEMDzEMc9MjLaBmAY87DQ+FP3JvxDSBQ5zNXf+F867lL5YUr/iUxlOO42XmgUSnZu82z6yYjZKIwgHDnzivGS+4nTnR1WNnc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e07c3e21-1109-4a8f-09f6-08d624438ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 06:36:22.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR11MB0141
X-OriginatorOrg: microchip.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update switchtec documentation
1.add pre-requisites for NTB driver
2.misc updates
 change NTB hardware driver name to ntb_hw_switchtec
 update the description of 2 partitions limit
 add reference to Linux Documentation/ntb.txt
 add use of term 'Command ID'
 add use of term 'Command Return Value'
 add a missing ')'

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Wesley Yung <Wesley.Yung@microchip.com>
Signed-off-by: Wesley Sheng <Wesley.sheng@microchip.com>

---
 Documentation/switchtec.txt | 30 ++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/switchtec.txt b/Documentation/switchtec.txt inde=
x f788264..40e839d 100644
--- a/Documentation/switchtec.txt
+++ b/Documentation/switchtec.txt
@@ -23,7 +23,7 @@ The primary means of communicating with the Switchtec man=
agement firmware is
 through the Memory-mapped Remote Procedure Call (MRPC) interface.
 Commands are submitted to the interface with a 4-byte command
 identifier and up to 1KB of command specific data. The firmware will=20
-respond with a 4 bytes return code and up to 1KB of command specific
+respond with a 4-byte return code and up to 1KB of command specific
 data. The interface only processes a single command at a time.
=20
=20
@@ -36,8 +36,8 @@ device: /dev/switchtec#, one for each management endpoint=
 in the system.
 The char device has the following semantics:
=20
 * A write must consist of at least 4 bytes and no more than 1028 bytes.
-  The first four bytes will be interpreted as the command to run and
-  the remainder will be used as the input data. A write will send the
+  The first 4 bytes will be interpreted as the Command ID and the =20
+ remainder will be used as the input data. A write will send the
   command to the firmware to begin processing.
=20
 * Each write must be followed by exactly one read. Any double write will
 @@ -45,9 +45,9 @@ The char device has the following semantics:
   produce an error.
=20
 * A read will block until the firmware completes the command and return
-  the four bytes of status plus up to 1024 bytes of output data. (The
-  length will be specified by the size parameter of the read call --
-  reading less than 4 bytes will produce an error.
+  the 4-byte Command Return Value plus up to 1024 bytes of output =20
+ data. (The length will be specified by the size parameter of the read =20
+ call -- reading less than 4 bytes will produce an error.)
=20
 * The poll call will also be supported for userspace applications that
   need to do other things while waiting for the command to complete.
@@ -83,10 +83,20 @@ The following IOCTLs are also supported by the device:
 Non-Transparent Bridge (NTB) Driver
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-An NTB driver is provided for the switchtec hardware in switchtec_ntb.
-Currently, it only supports switches configured with exactly 2=20
-partitions. It also requires the following configuration settings:
+An NTB hardware driver is provided for the Switchtec hardware in=20
+ntb_hw_switchtec. Currently, it only supports switches configured with=20
+exactly 2 NT partitions and zero or more non-NT partitions. It also=20
+requires the following configuration settings:
=20
-* Both partitions must be able to access each other's GAS spaces.
+* Both NT partitions must be able to access each other's GAS spaces.
   Thus, the bits in the GAS Access Vector under Management Settings
   must be set to support this.
+* Kernel configuration MUST include support for NTB (CONFIG_NTB needs
+  to be set)
+
+NT EP BAR 2 will be dynamically configured as a Direct Window, and the=20
+configuration file does not need to configure it explicitly.
+
+Please refer to Documentation/ntb.txt in Linux source tree for an=20
+overall understanding of the Linux NTB stack. ntb_hw_switchtec works as=20
+an NTB Hardware Driver in this stack.
