Return-Path: <SRS0=MCOJ=OA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E57AC43441
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 13:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C607B21479
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 13:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fy7Kmwv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C607B21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeKVAVj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:21:39 -0500
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:33312
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbeKVAVj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 19:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S07YmeH5k23GVnIQl9LCeMP1E2fzaFJR9bhlPRJC6ek=;
 b=fy7Kmwv0SkJbKuitz64dEd9Bhq8UxIzowFy2iNR+i+Uv+ZAdmIaHKATfOl5kmwopRDhEyEi5WYoyn4EZubkj7hYzFdZ3Mp1YT4DPGX1/9cuvh4jaQ4WaBlp9SugJL+uPCMWEXYhvn5pW+BRwvE6AIZRMISf9A/PK4aowvsbQI6E=
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com (20.178.122.159) by
 VI1PR04MB5328.eurprd04.prod.outlook.com (20.177.52.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Wed, 21 Nov 2018 13:47:05 +0000
Received: from VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547]) by VI1PR04MB5533.eurprd04.prod.outlook.com
 ([fe80::8484:31d3:d034:a547%5]) with mapi id 15.20.1361.015; Wed, 21 Nov 2018
 13:47:05 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Thread-Topic: [PATCH v3 2/2] PCI: imx6: limit DBI register length
Thread-Index: AQHUgPIBCDcLlZpcCkW2XhKPKNSgDg==
Date:   Wed, 21 Nov 2018 13:47:05 +0000
Message-ID: <VI1PR04MB5533BBC2B45752ED84E4D037EEDA0@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <20181120165626.26424-1-stefan@agner.ch>
 <20181120165626.26424-2-stefan@agner.ch>
 <581b9548043d5276f6685f534386180fd0673a9a.camel@nxp.com>
 <1542741198.30311.608.camel@impinj.com>
 <268e109e1c6b309454bd5a313078894c@agner.ch>
 <1542749302.30311.624.camel@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5328;6:lTZSZL0cAu9xzs8AwACkbdPtN2AXnqb3cED6YGCb0wHss0Xkk8ajqqJA3m942U45JurWFcQcKL5mm9oUCudYdjsFCeBtXIw4bxbc8rDWx/QxwW+2VgQWXvaDbQgRg0/5aQMp+PgeYUErrwlb54pFS2o2VvmJfWDKj+uRCkYgzYFy83L5ZGtPvHWDjt1jsUN/2z5iNU36172OtJlZHFqVZeSkNwVeC+d7v7KuDT8MoCy81YYmcnvfzOd2w9qOzPzbp9S9ybgScojwOn3kw2XtEp5vFH5VEN4aeuocTJm3Fd9XNZITjGflKCbtsZRBM4s23yLr76yuFbIVUJ+qvDOVGqhvtX4V1MIMfa8T49D6WOFGNk/wHLqXlGznDEnhKmQA3yQvJ4ZnBVyJ3fijAPSckU3JLkWeFNMH1KBmEWJ0wovGT0EaTQ5jgeTmaMLqv1ALtuHea902v8VzAq90WxuksA==;5:C9QDNZDlMGfAmRaoI1PFqUhkM1rYwfkfHF2D/8xeW8nXaQtW9XGo/kUBppurnveEgPAkXrxSTmvgv1vJ3G8lao9kJWRDrUmarGsAC03QH13WgU9AH/z5wy68Gz9LSqm6gigdZbpzW5I3lKqeWM/FynbNNmglV1qgHnJtXi80AbA=;7:UjLCz4LqVUu+4tweWMJdPRUc6LOabGAXaCZBMFr9cKuHO999tHkAq7c969ce9peSv8avcemfUb6zmZcLB8ARYlUTdSC5sl5CrsMNQOQ3CViyuQ8YfL0r9HdNepAqD/7tb+TY82tIRSE/j6bOrZ0BKQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7d2cb854-d352-4aed-2571-08d64fb7d2fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5328;
x-ms-traffictypediagnostic: VI1PR04MB5328:
x-microsoft-antispam-prvs: <VI1PR04MB5328692FD2A0A1419CF4B818EEDA0@VI1PR04MB5328.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5328;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5328;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(366004)(39860400002)(199004)(189003)(6506007)(2900100001)(7696005)(6436002)(76176011)(105586002)(66066001)(26005)(186003)(4001150100001)(2501003)(39060400002)(3846002)(6116002)(54906003)(6246003)(110136005)(305945005)(74316002)(53546011)(229853002)(9686003)(4326008)(68736007)(5660300001)(7416002)(106356001)(14454004)(33656002)(7736002)(316002)(446003)(8676002)(81166006)(81156014)(2906002)(25786009)(6306002)(478600001)(55016002)(86362001)(44832011)(102836004)(97736004)(486006)(476003)(71200400001)(966005)(53936002)(8936002)(14444005)(71190400001)(93886005)(256004)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5328;H:VI1PR04MB5533.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6n5i8ecVZmdiFTKpdZRAOIR19zIR6b2+7+XtjrWFdmno+fzwzHkQ0gEt8dfDLH9uWTKEn7V0gthp+dS6zmUeGebc+DK5l949AlKVyA/35BnHAh0Hh68CArKv3AkNhTVoTYltMllrW3kyTnkvmPqtg52ns+QkwcWyIOiGwa4VGpNIsZtjw0axp9t6Wz4SOA8IvhPzQicorCxaLEWxOvmh8KYN3kVUeJFanNtgjJadZQTkmpdZnOT1DAEW3EDzQnc6yYSZjMoiwldcqwb47gxr7/5/iYD1AFnG//1D4fV17uYXB/p+2cjlaGS79GceC8WrHyfquZ+svUu+8ZmzEMMHfE3Gr7j32aCO1sb2PuEHeQc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2cb854-d352-4aed-2571-08d64fb7d2fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 13:47:05.5823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5328
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/20/2018 11:28 PM, Trent Piepho wrote:=0A=
> On Tue, 2018-11-20 at 21:42 +0100, Stefan Agner wrote:=0A=
>> On 20.11.2018 20:13, Trent Piepho wrote:=0A=
=0A=
>>> It also seems to me that this doesn't need to be in the internal pci=0A=
>>> config access functions.  The driver shouldn't be reading registers=0A=
>>> that don't exist anyway.  It's really about trying to fix sysfs access=
=0A=
>>> to registers that don't exist.  So maybe it should be done there.=0A=
>>=0A=
>> That was my first approach, see:=0A=
> =0A=
> Yes, but that just used the pci device id which applies to every IMX=0A=
> design.=0A=
> =0A=
> It's also not totally correct, as it seems real registers after 0x200=0A=
> do work on imx6, and that would prevent access to them.=0A=
=0A=
I see that Lorenzo already accepted the patch in pci/dwc:=0A=
=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?=
h=3Dpci/dwc&id=3Df14eaec153aaebbe940ddd21e4198cc2abc927c2=0A=
=0A=
My tests show that this series breaks pci cards on 6qdl and I think it =0A=
should be reverted until a fix is found. Are you OK with this?=0A=
=0A=
Fixing might require an entirely different approach.=0A=
