Return-Path: <SRS0=A2IS=PN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	TVD_SPACE_RATIO autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFE1C43387
	for <linux-pci@archiver.kernel.org>; Sat,  5 Jan 2019 00:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6546C21872
	for <linux-pci@archiver.kernel.org>; Sat,  5 Jan 2019 00:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="F1Jbt2mU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfAEAnH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 19:43:07 -0500
Received: from mail-eopbgr680137.outbound.protection.outlook.com ([40.107.68.137]:20832
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfAEAnH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 19:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTmBLALdRePkUM9WRtm7VzkGBLjhoQC2rgeq89sUXZE=;
 b=F1Jbt2mUef0tth0/7hnSiR6iAJmEkOM9QYf2GvzNyUv6SupiGIxa1Y14i2ibSQk4B8tGHeEX0jZVlthPgd7ku55ywvSKNHabkJW7CUDI8sMqDbDaEbJNAYHcsad6X1z0MUlxWtkG0pi8HQ/ithXJwuGJ5nbN7EjfreUTcOWRdk8=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3593.namprd06.prod.outlook.com (10.167.173.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Sat, 5 Jan 2019 00:43:03 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c067:6414:a064:fa37]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::c067:6414:a064:fa37%4]) with mapi id 15.20.1495.005; Sat, 5 Jan 2019
 00:43:03 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: unsubsribe
Thread-Topic: unsubsribe
Thread-Index: AQHUpI+deSKGQs0SdUGU4LQqmzMPYQ==
Date:   Sat, 5 Jan 2019 00:43:03 +0000
Message-ID: <1546648982.14247.30.camel@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3593;6:7anSDigB25lydh+AQF0P3JpRqChvrH2wa1gfq0DjeFz9a5RQakApgZnUnX9tb/mRnQ1njdaFrXB9tCg9njqozodkLAGfNCWRxIRgRB8o0B2x34nDTRpdjyWmu9Xw89HuVB1xTUjAFSrs3odgefVuvQ8Scg1YXg+u1t+21cUaruarxtMI7VoddpUHDvqVVop82evZqYeGymHi3Nt6nnQ239GEf2D99ggxBJcITqDOcJds3nPRm5niNhjHCTcVElHf+/eLcbMeGFqjbYGZpvdhXdrd2k0PxhvoYnwp0YakUf6PjqwsHNN846iHkAAmHi+zd4ojrR5LeOIg9b0KJj82aBKvxMvcj+iJN6NAzFqm6/Ra4h2fklFkMyFSnmm2x2vJ/SWfzGaYD/W3PQmuzbiQ0ZHKqphbv8tjrF8W/qbV1nTxp3TauWGHaQGKfNCv3Ulp+gd5iQ4XyW3KA/0NWVGdaA==;5:pFsokkTD4Lk8CNxQH1ngRZKO7RSztJw4PR7BqYttv45lHq2a/zO5UgbkXlGyaEP6YN/a8sajJ949ChM/t5bEzyZU6fs3COJr4FSxVpczAbijLFRrOVL7NwpuTfVauyW8NX0ZoUy2lJUKzXRNXSyjppryPPyLaPVTs0u/OQujtnfbo6+hBOWCK4WSqJ2Jk9BoW7bWTGoVep4s/3BKLIRn8Q==;7:6VL5oVz/OMyOhb7cKl+tCRVCkmhWeDnsrDcC0eTm907Kr+7n0aP+z4enhOIX3yhOW9EnlcAPslAzFz0nUTcGxIA9mPwhLcgntL7gIOFy5oglBs+65Mz7sjyxZo5l/2H5oz6MvcA+tbC1Uo9WMaYhyQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: fe984ded-4cba-443a-8bdf-08d672a6c059
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3593;
x-ms-traffictypediagnostic: MWHPR0601MB3593:
x-microsoft-antispam-prvs: <MWHPR0601MB359321AEFE3114444F27D4EED38F0@MWHPR0601MB3593.namprd06.prod.outlook.com>
x-forefront-prvs: 09086FB5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39840400004)(366004)(376002)(189003)(199004)(3846002)(6116002)(486006)(86362001)(6486002)(26005)(6506007)(19618925003)(102836004)(97736004)(8676002)(81166006)(8936002)(81156014)(316002)(6436002)(305945005)(478600001)(558084003)(2616005)(476003)(7736002)(6916009)(5640700003)(14454004)(4270600006)(25786009)(2906002)(221733001)(68736007)(2351001)(66066001)(53936002)(6512007)(3480700005)(106356001)(2501003)(256004)(71190400001)(71200400001)(5660300001)(7116003)(186003)(36756003)(99286004)(105586002)(103116003)(166393002)(220243001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3593;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IL+fk8S6RqTyIvFV5T76EajLBRe0Bj+3fmiqsgzppypxavEgY5lBGLZf8kx0LNNrQX3l23ME5CX0+RhkiGwKWt1Pep1X9Z9FQcF7XrnAR9ZoBBKWCrfadz39bn6N/uN6az/Bh/bQcxEQ6FOhM6EuN0u3IDlGZ8mKGVKynUoZwVFLIgGCMSoOs6NhAuQHueckjIv3YWo48IMJBYITgz+DWspSRbBkTdLHCTAYnQxXL8t4esTgTgwhoacZSUgSrqIkYk1stxk2uBI30jrdbGI10RJKfjBARLXfjT+exT3ZnWWRqFnKIw3EQY7UmZIeEeUe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe984ded-4cba-443a-8bdf-08d672a6c059
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2019 00:43:03.6110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3593
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

unsubscribe linux-pci=
