Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60952ECDE46
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240E82082E
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 09:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xNymYihf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240E82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbeJYRy1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:54:27 -0400
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:1482
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbeJYRy0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 13:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwd3K6WMOcO73yfkwA39VWaUEX0iV/0GCLM+OWl/HfI=;
 b=xNymYihfuwgXTE4i7wdgsHWf2hA9mv2PWi+41KlD1sOB6xB5U4/5ldVwVJOVug2QYelYF1DNVPWFtKdlEHTZoA1PeVSDnj36fDzmlxZ+CTSBzU5+bC0xtkdjo1JuxdBZ1lE6JyDzYSk/zEkQ1ORnxVMbTXlGU6QXzdHxPJ3JDCY=
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com (10.162.155.27) by
 DB5PR04MB0952.eurprd04.prod.outlook.com (10.161.195.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 09:22:31 +0000
Received: from DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb]) by DB5PR04MB1221.eurprd04.prod.outlook.com
 ([fe80::6c36:f4cb:26c2:e8cb%2]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 09:22:31 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCH 0/4] PCI/dwc: Add more than 4GiB range support
Thread-Topic: [PATCH 0/4] PCI/dwc: Add more than 4GiB range support
Thread-Index: AQHUbERBcfDCQJ8TeE+5pSF8sPwRMA==
Date:   Thu, 25 Oct 2018 09:22:31 +0000
Message-ID: <20181025092229.28413-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::22) To DB5PR04MB1221.eurprd04.prod.outlook.com
 (2a01:111:e400:51c2::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB5PR04MB0952;6:GM7eAqLjdbltSovstMtOh+N69pEcxjGCejvCxvRX923nl9FvoLtM8tQH5o4wd00L+4wduwgDJdcXonFVHSuKzmmJxKTdJMToX038eAGNUBJ8ftErs6FyqtCFQd5ijA2XHR6d19loHO+ufAgJ/EbgNTxK947NqGiIyyzlddUvh29GPkElT4vIgIDF4DhpyB2OcPkRJpXm8DcysEsU1Ug9jpN8lMerYR7WsRSIrwubFb3bu9NWLa/1HHDxTwjxVwHwXgWk5Im7sY/E5ZT3Q4S+Bspj8hOwUlc0LHpKQCGg4wrfQwKpA/+0jniav4vwRssNoWs94PobGPjLfAEzsCylhj8VoHuyzLZ2R1ZsfL1W1gd/7Sfc+aSF4kROq3NcZJc9oa1VEVsJWrMzx9HPwzerJ/c1ZSZJl9XmgfLhvCooul5QaK2FHXkETofmOWcALkcHjy/9EUqaGyMlkPyaQ3/+nw==;5:LmU18EaBlRVrs3tAdMZQMAnVI7HZg46mNDgtDM94nrrkbD94Y+JGzZLsv3aQ84yP5aGWf3q0PawOSKbZkkb0asJNaVAPIqGIHxIQvG8dBsOp8Woj/lV0G+AbDIo6gxqGcbwrz7XwgQDhs0SapN4V+K6yGdUjjOBJ+TDGycFXF7U=;7:82RRDNdDNNVi9/t3nMIyqidrSulA13lEz+Dj1acklJddG2dtxAndrjpmuntdp/1U5CMqnALtMCUmVjwKzYcCF9oQLghtGUjZLB8JfB65ZQ99XkdctFLQeWtm3oAF8DbqNbvWlARCXwRcS8npXxtT0M6mQILq2pi+BTTmzMgYcS8e0EZuLzeWx1ZiyqdoZTZOTY6P5FmztIGM3CIoRLj9Q93R7ijc2/enqwckzPcFHrTwcdcX7dw4hRSu1Us4JS22
x-ms-office365-filtering-correlation-id: c358a77c-4c89-40df-ece6-08d63a5b6383
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB0952;
x-ms-traffictypediagnostic: DB5PR04MB0952:
x-microsoft-antispam-prvs: <DB5PR04MB095285F8D9EF5855DA8675FD84F70@DB5PR04MB0952.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DB5PR04MB0952;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB0952;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(6512007)(6436002)(97736004)(6486002)(39060400002)(99286004)(81166006)(4326008)(81156014)(53936002)(106356001)(25786009)(105586002)(2900100001)(102836004)(7736002)(8936002)(2616005)(256004)(305945005)(476003)(186003)(478600001)(86362001)(8676002)(26005)(68736007)(2201001)(6346003)(486006)(6116002)(3846002)(386003)(6506007)(66066001)(2906002)(5660300001)(36756003)(1076002)(14454004)(316002)(54906003)(110136005)(71200400001)(71190400001)(52116002)(2501003)(5250100002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB0952;H:DB5PR04MB1221.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-microsoft-antispam-message-info: y71K7HYyi52R6RO4N7u4UNk4mBto55Dvi2s/Bjuq24F31fVjZKk31DjQVWeUvnx5nFEdD++UVvoRspxDggeGuSkxpySffXtBdbtt4EJFo4i/izYkuPbfz8TrYlMLFgAsLU3kcOXODLTNeuEqhwff38QSvA2AaH+N9yg2CmwKqG2+8EDm1FSO2xwtI7HB0F/FL01PcsYa3L81HlVMIEn4yh1EiV4wFdvBmREBmDcMLa/JVGa+bBEUjGHUwI6O8amrll2oT8ItxOCiJzTNIGlHQBGcYLa5XlUO2I3SWqOmuWRSyAmoJgoLDqwZ9utajpwFmtvUbrBusSE03e1BpTZS6AGEVDK60fOL2P7UyLuJw8M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c358a77c-4c89-40df-ece6-08d63a5b6383
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 09:22:31.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB0952
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch set is to add greater than 4GiB range support, patch 4/4.
Patch 3/4 is to initialize the number of viewport.
BTW, fix 2 bugs, see patch 1/4 and 2/4.

Hou Zhiqiang (4):
  PCI/dwc: fix potential memory leak
  PCI/dwc: Fix the 4GiB outbound window size truncated to zero issue
  PCI/layerscape: initialize the number of viewport
  PCI/dwc: Add more than 4GiB range support

 drivers/pci/controller/dwc/pci-layerscape.c   |  3 +
 .../pci/controller/dwc/pcie-designware-host.c | 83 +++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c  |  4 +-
 drivers/pci/controller/dwc/pcie-designware.h  |  7 +-
 4 files changed, 79 insertions(+), 18 deletions(-)

--=20
2.17.1

