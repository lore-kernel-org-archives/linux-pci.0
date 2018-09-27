Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC3DC43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 05:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D722156B
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 05:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="c4KeY7t0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D722156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeI0MN4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:13:56 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:15642 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeI0MN4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Sep 2018 08:13:56 -0400
X-IronPort-AV: E=Sophos;i="5.54,309,1534834800"; 
   d="scan'208";a="21427606"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Sep 2018 22:57:24 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 26 Sep 2018 22:57:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0lZKLbISIWLPH99npWvKGkqZG732XzK0UclymUxKUQ=;
 b=c4KeY7t05YZbZv4ujRbcb++haNzmAoqn0lZsIzCggc9RLMzCRxIJ7oiBXNbpnhs/eAm3bvyZNKV7oyhWwrHJ834r9BVyRkuK2VaIKDP950bPiOlvVxqvivBPDoU1sehgrSowo5BYV6glYUr5WvXn7mLE17dvZP4I9YZXfUsxujo=
Received: from DM2PR11MB0105.namprd11.prod.outlook.com (10.160.26.155) by
 DM2PR11MB0057.namprd11.prod.outlook.com (10.160.28.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.25; Thu, 27 Sep 2018 05:57:21 +0000
Received: from DM2PR11MB0105.namprd11.prod.outlook.com
 ([fe80::cdb9:9501:ede9:23c4]) by DM2PR11MB0105.namprd11.prod.outlook.com
 ([fe80::cdb9:9501:ede9:23c4%2]) with mapi id 15.20.1164.024; Thu, 27 Sep 2018
 05:57:19 +0000
From:   <Wesley.Sheng@microchip.com>
To:     <logang@deltatee.com>, <kurt.schwemmer@microsemi.com>,
        <Kurt.Schwemmer@microchip.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Wesley.Sheng@microchip.com>, <Kelvin.Cao@microchip.com>
Subject: [PATCH 1/12 v2] switchtec: Remove immediate status check after submit
 a MRPC command
Thread-Topic: [PATCH 1/12 v2] switchtec: Remove immediate status check after
 submit a MRPC command
Thread-Index: AdRWJF1jbNxK+iTHQO26nowQGjGEMw==
Date:   Thu, 27 Sep 2018 05:57:19 +0000
Message-ID: <DM2PR11MB0105CD1B3A264290413ED1CA95140@DM2PR11MB0105.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [211.144.195.220]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR11MB0057;6:V6LkyKS30PZRGogX8UTQmJNxNlIJMt4skF4tqwlnSaVGgOua7IERlB0uFcNAkCoZb44CzxoMLAMcTTXsBMRf9lkKvab/hs9DlHItII3p3O6SacKxz0YkUhGJmHqfIdtClYqX6lTC7y4PGEf9n/Li2mFiXs01YD4j1tIg0Qz6Xxe50jgGyb00GERuxAOeYIntft5GyYVHjDA15iKFTdngb4GUgLrfqP499dz2QjG7oG9qafLZSBkQYXiD85sbryHhjRWsBBrg3hrorZPt9ns1uoRKa/H8kXS+EaZ29bMckvinnQemsf7CdqrlwPpxJvQqwHwqet1VeXTOLGJU9QKxTo63KsyrQoJbNkiThqH1Q656g+1TXQC0gVeDYQuop6tmR4JoEdmI7ToBQH8EsmxF0fJRQcAWw4NHSIRLJgcGDGwbPt4/7s+OHHjJo1HEohJ3U7tFYcWiQKSH42RvFUbvDg==;5:SqbLPfBaYtdaM5M4T7BO0vPU++XptK12bu0GByGKSADCyLFzOF3Ei1dEvuKK6kffle/XEPj4L3f04YIBo4FKBM8/31pcpg1IkneNsIEbvqwUBOUpEgs1dw/UQrQ8JO5aTPcFn0ejn7Gsg3+WvzN1c4kqX5Up7XotxvAf6cVGAME=;7:qGd9aFIV5kq0zmb5PcEJTkxlTY14V/2celbMIaIyTy7ZyC4GppDCD/SxClYmdqqaSZkukiEjrrs8KqlEg0VGqY7vsmTUpNeorkN8p2t5HPWO2W4a32EmbzvMLaIxLg/abeTZDbZdziWnpLm+T85PtpIhXcy3avdjY0LJsMDLJNhu0yCkHYIO8nFDNs2FihUHujSUQIF1roJLbzuOzBKF6b5MLD4gGlwZloDKiHSrdpS+W9dGfDABINBVapuULAJB
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(366004)(376002)(189003)(55674003)(199004)(81166006)(86362001)(2900100001)(54906003)(2906002)(110136005)(107886003)(256004)(14444005)(316002)(68736007)(25786009)(4326008)(305945005)(7736002)(478600001)(74316002)(33656002)(81156014)(6116002)(105586002)(3846002)(14454004)(106356001)(97736004)(8936002)(72206003)(8676002)(6436002)(5660300001)(476003)(55016002)(486006)(6506007)(26005)(71200400001)(102836004)(7696005)(34290500001)(66066001)(9686003)(53936002)(186003)(71190400001)(99286004)(5250100002)(2501003)(14773001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR11MB0057;H:DM2PR11MB0105.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 079a3483-0c0c-4d44-3c14-08d6243e163e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DM2PR11MB0057;
x-ms-traffictypediagnostic: DM2PR11MB0057:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Wesley.Sheng@microchip.com; 
x-microsoft-antispam-prvs: <DM2PR11MB0057958100045686C9DBD5CF95140@DM2PR11MB0057.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:DM2PR11MB0057;BCL:0;PCL:0;RULEID:;SRVR:DM2PR11MB0057;
x-forefront-prvs: 0808323E97
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5iWP6dbTzU7OOjv0bbHOx+2jH/RLDHZ2N77cSRilXhVf4GaFKeikE411sSVhLmYZKmCjKCzVt2/gQApJvLn2Zhdwgm/vrdDzPzofmS5NvA+h6+tx9y91NeKpkA4eSafCEWbYR/gXptQdpJA9sSbKOoQC3+YxbtifR9RhyNceDFGVSMA/SGkjUWWRjHluEG7Zysg4bDxUjGNe7c3nIn7HFsJ2sinJzcgG5HQsO1/v05csQovcCkCZEmSV50lRXse/SCSHZTQUdjlmc+Ks9sJpj8p6IUnoQDuHt3yAXi70cmSB9eO0wdvN6qP7NH1MVwNxBAd5wsUJZ2HexijIJbZjHw/4eB5FGqpFR/Be+e0XVX4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 079a3483-0c0c-4d44-3c14-08d6243e163e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2018 05:57:19.7534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR11MB0057
X-OriginatorOrg: microchip.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After submit a Firmware Download (Download sub-command) MRPC
command, Switchtec firmware refuses to response any management=20
EP's BAR access until current flash programming finished.
During this time, a READ TLP to the gas area in the BAR of the
management EP will complete with significant delay like more than=20
10ms.
It's a Switchtec firmware limitation that READ requests cannot get
prompt service during firmware download.
The delayed completion of READ TLP would be a problem on some system
 which is sensitive to READ timeout.
Current driver check status immediately after submit a MRPC command,
which triggers READ TLP to the gas area in the BAR of the management EP.
Also, other processes or functions, like NTB, would also trigger READ TLP b=
y
accessing the GAS.
To avoid this, the immediate check of status is removed in this patch, and
driver delays the status check to the occurrence of MSIx or MRPC timeout.
In the meantime, user must not initiate any gas access during a firmware
download.
Also, any process that issues MRPC command will be affected by the delay
in this patch.
However, this is only a software workaround to the READ issue in firmware
download. A complete fix of this should happen in firmware.

Note: For NTB function, the memory window access is handled by Switchtec
hardware. So it's not affected by this firmware limitation. But the other G=
AS
access which is handled by Switchtec firmware is are affected by this firmw=
are
limitation.

Signed-off-by: Kelvin Cao <Kelvin.Cao@microchip.com>
Signed-off-by: Wesley Sheng <Wesley.sheng@microchip.com>

---
 drivers/pci/switch/switchtec.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.=
c index 4591f15..b759228 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -142,10 +142,6 @@ static void mrpc_cmd_submit(struct switchtec_dev *stde=
v)
 		    stuser->data, stuser->data_len);
 	iowrite32(stuser->cmd, &stdev->mmio_mrpc->cmd);
=20
-	stuser->status =3D ioread32(&stdev->mmio_mrpc->status);
-	if (stuser->status !=3D SWITCHTEC_MRPC_STATUS_INPROGRESS)
-		mrpc_complete_cmd(stdev);
-
 	schedule_delayed_work(&stdev->mrpc_timeout,
 			      msecs_to_jiffies(500));
 }
--
2.7.4
