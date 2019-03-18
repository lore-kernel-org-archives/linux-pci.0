Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE7AC43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 10:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A20C20854
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 10:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="eXnaVSZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCRKA1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:00:27 -0400
Received: from mail-eopbgr760079.outbound.protection.outlook.com ([40.107.76.79]:47046
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726860AbfCRKA1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Mar 2019 06:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjoSqIP1CtU4lxwBQJ0Op6CC+IBs+IhYeYppT978cBo=;
 b=eXnaVSZZb9g1IgV7mzdVUlZRQTvxIw+WaVIjbLUpfp7i6i6qqi2adsrQkLSKbe7tCgP2+vyXa/2UgCa4ppwePZMlobGXdKgztJHivgTEzlvOGV5gdRIaRAWPDcyOk2SKEqbS80w/tFaPjUkq/Rc+nd1p4k0Z3rUV+w20p1BE/og=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4504.namprd03.prod.outlook.com (20.178.49.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 10:00:23 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 10:00:23 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: PCI: dwc: Free MSI in the error code path of dw_pcie_host_init()
Thread-Topic: PCI: dwc: Free MSI in the error code path of dw_pcie_host_init()
Thread-Index: AQHU3XCp70Ofv04SvUCvua7axGcIOKYRJdoA
Date:   Mon, 18 Mar 2019 10:00:22 +0000
Message-ID: <20190318175258.5a327c7b@xhacker.debian>
References: <20190318174415.74fd25a5@xhacker.debian>
        <20190318174749.44b8f7fc@xhacker.debian>
In-Reply-To: <20190318174749.44b8f7fc@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:404:56::18) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 071c30ee-6e86-42f8-9f69-08d6ab888931
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4504;
x-ms-traffictypediagnostic: BYAPR03MB4504:
x-microsoft-antispam-prvs: <BYAPR03MB4504B3D6F6798F6C050A4DC7ED470@BYAPR03MB4504.namprd03.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(136003)(39860400002)(189003)(199004)(71190400001)(71200400001)(8676002)(99286004)(52116002)(76176011)(86362001)(102836004)(6506007)(386003)(186003)(6246003)(26005)(1076003)(3846002)(81156014)(68736007)(256004)(81166006)(14454004)(5660300002)(6116002)(478600001)(97736004)(72206003)(4326008)(6436002)(486006)(6486002)(7736002)(558084003)(229853002)(305945005)(105586002)(106356001)(66066001)(53936002)(8936002)(2906002)(316002)(110136005)(54906003)(9686003)(446003)(6512007)(11346002)(50226002)(25786009)(476003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4504;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xZHROFVisDDDFw4VyFFuySXE9xajfwOcoRYvJV5znpVQbwGtZ75Xmtg37UOp9rOMiF9L1G04eY74vYxO1OOuzyhFHcKMJ+7vwA9iKGdPr/rt1zMx8L5Y+gsdZy4xIzRjBQfikmLZD2YRvtTuvQ+IzawfiQ+Rplbi4vYTmV0BrKWq6Wp9WZMlJ3PeVZYgQRCLqZKo+H1tcQdQ+alQdT+BmCjPrsjR7FfG3cAD5LTx7QlzDH75wol+8ngf1vWiHG5hOL7mpVZ88OSpiUHlF1LaPXJZ9SK05qoxE2Dfxi0t9vr+JT0uoosrq1Bwa4lLGLnW+tevJub4dmfzdrpmNGCUctdTjNqB7G/VtTKBpuvggpx+2aqU1ZUavf//WNBvzVUFpAu6nTYOV3b9qA967uaA95njYYeltNgg0zhr0Klz0eE=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E16D8686F03104E9AEC34F691335AB6@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071c30ee-6e86-42f8-9f69-08d6ab888931
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 10:00:22.7938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4504
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 18 Mar 2019 17:47:49 +0800 Jisheng Zhang wrote:

> If we ever did some msi related initializations, we need to call
> dw_pcie_free_msi() in the error code path.

Sorry, "PATCH" is missing in the email title, please ignore this one

