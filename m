Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA49AC282C4
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 00:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976632175B
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 00:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="g5bSxWzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfBMARo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:17:44 -0500
Received: from mail-eopbgr1320130.outbound.protection.outlook.com ([40.107.132.130]:18704
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728101AbfBMARn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Feb 2019 19:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89SPNahk8FQodxookyuytnMPdUnKfK3i148hHZdTINo=;
 b=g5bSxWztGWqOizpxcVwd4bgFW4St2F0uwOlqd15gZ0tpFtuOEX0N8mtpYlym+Hass9vUJgJcguAe1ozWmQf9KPv/EAMeQq1QP4hCDSf2bl4lqmMD0S8IEArDtuq18cCe6NMuORz0GcGsxj6epowEfK9knXAJemwrHmaTU5vGcVU=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0187.APCP153.PROD.OUTLOOK.COM (10.170.188.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.0; Wed, 13 Feb 2019 00:17:36 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1643.004; Wed, 13 Feb 2019
 00:17:36 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] PCI: hv: Add hv_pci_remove_slots() when we unload the
 driver
Thread-Topic: [PATCH] PCI: hv: Add hv_pci_remove_slots() when we unload the
 driver
Thread-Index: AdS/JKy4gHBOTZqYQrqpJy5ySOaIggDp5REAABiteEA=
Date:   Wed, 13 Feb 2019 00:17:35 +0000
Message-ID: <PU1P153MB01694FE34AEE56373DC9B86BBF660@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169F06340FC519C2802C5CFBF680@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190212121235.GA23166@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190212121235.GA23166@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-13T00:17:33.9312352Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3ea485df-64c1-4a3c-bedf-457fdbb9595d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2601:600:a280:1760:5896:cf8a:cefe:fd7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0187;6:575S9UH5ZYnDMn3W15qT55ya6cCusVvQDsmbcar2VjiZyiWGBFbgtSqMupDqLuQoC4nC4qbYMQ8kDGZlO+tQSx0cFz5LiCqjaeM8Swmcc3/T208diyf/WYsZIcoEuL+abBNp1mqbv0oLeSUIt5MPecbeBJekuqaIYcSmazzZ9sKaAhnZecYi5a8NveLPWpKF4PjUTKQC290jz558hZAdPRZrHtDM6DaDQ+LyAhxfdInwigA6xH+1TEwnm7ZpMFpmHZFjaT61uvAs/siEU9LKlBbSNKIWYQx02/QgYbJ9rNi4cjGdqCVfen0J/trLpZVbpXF1OGsDPk6BmjhtCvX9AbcW/mfZngErGWkftE5hu+36FoDaxkn+d5ioiDKigNtK42+4SeQ36g+WAncHL6/P1ZltMYHHAb2+7QojOlC5tfg99TYoD1dlofQb9vIoo6C1hRszpOVCBn9cumpUAdoXUA==;5:53vs4NqqLPXLfQRhwrAU1C+PhRuRoso88o+AXkjXdGt+Vyx0529v3cj+kjNbYo6LRRgz+7L+c0mFTrMRaNEjef+rGLJKrxPGIipKDuyvpTgOcOh1Dft/HqdMJin/1qkRv6xg1xDdHUg2+Hb/UngQw9Jzdg037ULJNIJ3AWtcsN0ZkuohFws3WUG8QjhOjjKSz8LZ72UA04oIqh2yCS61Vw==;7:FgSAcTttm5p+cAMSw3WHoFeGCHCJEhCCfuYPjzRD+X2K9sfWtFdL7wn26QlB8O6tdpm8y0YUcBDrkzbWqdgHSrwGaTJNo5ZS35xLnRMzo1QLpN1X18dxoP4QSb/Y0Ud4V5N22JBn6KYW3G87L/o90A==
x-ms-office365-filtering-correlation-id: 208057d1-5462-4b93-0bdd-08d69148a806
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600126)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:PU1P153MB0187;
x-ms-traffictypediagnostic: PU1P153MB0187:
x-microsoft-antispam-prvs: <PU1P153MB0187422957208D8A1B9FA29FBF660@PU1P153MB0187.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(2906002)(10290500003)(478600001)(10090500001)(53936002)(107886003)(6246003)(14454004)(22452003)(9686003)(55016002)(6436002)(105586002)(106356001)(229853002)(6116002)(97736004)(81156014)(81166006)(4326008)(25786009)(8936002)(68736007)(7736002)(6916009)(71190400001)(71200400001)(74316002)(86612001)(6506007)(476003)(46003)(305945005)(186003)(6346003)(8990500004)(99286004)(8676002)(11346002)(486006)(33656002)(446003)(14444005)(76176011)(256004)(102836004)(316002)(86362001)(7696005)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0187;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: af0+LXEHJ+kV3W3+CR+rNQBfzug2T9Pj3/wcU/AQlFFH5QOI6WSE2HtABzVZzfnwhxWaXRH4mb9VVPT2DdLxoaSy9VV3JiZLKT1vXWVVD0fbh4RpIF6sl4d+nuJxvQF2YZ2sDZYldDYWSjzLF4yU22U1RkDen9QkpvrbjgEqEUzstY8oehzaxsRHXPrK8Q9LcOihkl6pztlMEyuvsFe/aU91vUxptL9PjjtIZs2cKswFt4TZiMo1fGIYsY2kN4hLrVJQ/DINPuFHNzTy0D/hUM7SLdowrWuaEkRfEJkLEVqatrXEVkvsyq99P2XTSVWoCG7iZia/XDVmj5JCtPaVoolLqyOHzHA0aj9ePejFEgukjGHONerM2tWhRYOpZfGUZKKaAIv66PauuEyki2/ElKrT2vrmZL965Wiwb+gL7IY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208057d1-5462-4b93-0bdd-08d69148a806
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 00:17:35.7328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0187
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Tuesday, February 12, 2019 4:13 AM
>  ...
> This patch fixes three bugs:
>=20
> 1) set hpdev->pci_slot to NULL
> 2) move code destroying the slot inside a locked region in
>    hv_eject_device_work()
> 3) Add missing slots removal code in hv_pci_remove()
>=20
> We need three patches, not one.
>=20
> (1) and (2), I am not entirely sure we want them in stable kernels,
> since they are potential bugs, waiting for your input.
>=20
> Lorenzo

(1) is actually unnecessary, as I suppose hpdev should be freed at a later
place in the same function hv_eject_device_work -> put_pcichild() -> kfree(=
hpdev).
But today I think I found a refcount bug in the hot-remove case and the "kf=
ree(hpdev)"
is never called in the hot-remove case. I'll further dig into this and make=
 some extra
patches.

About (2), it's a race condition that can happen when the device is being h=
ot-removed
and we're unloading the pci-hyperv driver at the same time. This is not a n=
ormal usage,
so I agree it doesn't really need to go into the stables.

(3) should go into the stables.

I'll make 3 separate patches, and extra patches for the refcount issue, and=
 possible other
minor issues.

Thanks,
-- Dexuan
