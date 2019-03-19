Return-Path: <SRS0=xwy5=RW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE20C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 05:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C29220854
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 05:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="kkrIYIuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfCSFgj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Mar 2019 01:36:39 -0400
Received: from mail-eopbgr820077.outbound.protection.outlook.com ([40.107.82.77]:61168
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725913AbfCSFgj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Mar 2019 01:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOxQgY00I4i1lRYj8TODCU6nTBYbA5CwEBNODAp6rfY=;
 b=kkrIYIuMQUKPWr8ha5dUByKGxIP71sYnzO/8lSdo4Vzv5PiB2zfnLNLXqp8IyvR1EaJHSxQa1fEw6iyjroFJDzcSNyjgOcmf0kLTTspJDjbVorQkj9CWdQTRUhnbr4ePbIaI0HviPrn/MHAb00XlhJUzS2fRX/CnElno+Jz/hf8=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4165.namprd03.prod.outlook.com (20.177.184.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 05:36:36 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::1a8:1bc4:174b:472b%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 05:36:36 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Aditya Pakki <pakki001@umn.edu>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "kjlu@umn.edu" <kjlu@umn.edu>, Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] PCI: Fix to avoid potential NULL pointer dereference
Thread-Topic: [PATCH] PCI: Fix to avoid potential NULL pointer dereference
Thread-Index: AQHU3epy9pCekv5IX063Y/R/DHluBaYSbYWA
Date:   Tue, 19 Mar 2019 05:36:36 +0000
Message-ID: <20190319132909.7d37b6cf@xhacker.debian>
References: <20190319002630.12485-1-pakki001@umn.edu>
In-Reply-To: <20190319002630.12485-1-pakki001@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.33.119.15]
x-clientproxiedby: TY2PR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:404:a::31) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 553b4c4c-6d83-4d56-c6fe-08d6ac2cda2e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR03MB4165;
x-ms-traffictypediagnostic: BYAPR03MB4165:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR03MB4165D8BC3F92FB05771EAB75ED400@BYAPR03MB4165.namprd03.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(39860400002)(346002)(199004)(189003)(6116002)(14454004)(8936002)(3846002)(316002)(52116002)(53936002)(99286004)(54906003)(2906002)(66066001)(26005)(6436002)(6486002)(97736004)(50226002)(76176011)(102836004)(8676002)(486006)(105586002)(386003)(9686003)(6506007)(106356001)(71200400001)(966005)(478600001)(6512007)(6306002)(256004)(229853002)(81156014)(86362001)(71190400001)(14444005)(72206003)(81166006)(11346002)(6246003)(476003)(5660300002)(305945005)(7736002)(6916009)(4326008)(186003)(446003)(1076003)(68736007)(2171002)(25786009)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4165;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EPgw4PqSiMHCpwdjLAx3XxMOmauIWbhiQnAP4xLQ2GmThilGZ8Pik0V73iSg66qZZraZUEVysR5XZUvI7aVp3Tk7h7hAc9HT1TTd09qMCfhUA6RZAmaMVIpDm7gxv51XMcImH+LExZ0x9Pw39GeqmFt9B87Svdpa0Fybi5s9MWX7dJHA6JjprTlU97MAfGe/Jw7gIJy7Io2Ic2fbXxu9NFB5izrYhbAsrv6Krw7Euc3mBDI/qAcyQnY8cQIpcn9n+j23ylBKDft2oKwsdg+orX1A9vY85T1durrQe1IYUdM9MzD46E9ZX2x+ZtB76j78mRF5tp0LghdU3J9ycfC8OivmUlVdLwaYXwT1sSmfOyYzOrttZ5aV5Bl59RXEYiDvPhDfVkaBoMtRbY1q2ISAeGeD0qC2cCl98BVwTA6CDWk=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC02BC5B156F2643A04B7B68F26A302A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553b4c4c-6d83-4d56-c6fe-08d6ac2cda2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 05:36:36.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4165
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 18 Mar 2019 19:26:30 -0500 Aditya Pakki wrote:

>=20
> In gen_pci_probe, of_match_node can return a NULL pointer in case of

This could not happen. If the probe is called, it means OF registered a
device with a valid compatible string, so of_match_node cannot be NULL.

> failure. The patch avoids a NULL pointer dereference in such a scenario.
>=20
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/pci/controller/pci-host-generic.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/cont=
roller/pci-host-generic.c
> index dea3ec7592a2..85f473f50e96 100644
> --- a/drivers/pci/controller/pci-host-generic.c
> +++ b/drivers/pci/controller/pci-host-generic.c
> @@ -83,6 +83,8 @@ static int gen_pci_probe(struct platform_device *pdev)
>         struct pci_ecam_ops *ops;
>=20
>         of_id =3D of_match_node(gen_pci_of_match, pdev->dev.of_node);
> +       if (!of_id)
> +               return -ENXIO;
>         ops =3D (struct pci_ecam_ops *)of_id->data;
>=20
>         return pci_host_common_probe(pdev, ops);
> --
> 2.17.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.org=
_mailman_listinfo_linux-2Darm-2Dkernel&d=3DDwICAg&c=3D7dfBJ8cXbWjhc0BhImu8w=
Q&r=3DwlaKTGoVCDxOzHc2QUzpzGEf9oY3eidXlAe3OF1omvo&m=3DAaw3ijENR3L1GJbf1JjDl=
Pa-S8-6UwqqXN40ECdoisk&s=3DByG7jEMATcZVHKP-JW7j4efNcV-iAfJDFTEzC8Ba7oc&e=3D

