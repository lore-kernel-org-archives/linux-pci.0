Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0B3C43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E33520989
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U/jfybyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E33520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeKTV3L (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:29:11 -0500
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:58496
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbeKTV3L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 16:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mjh+m0YM54hYN6DUKKyr7B/8KWsHA1eAXJJ7JDpdIog=;
 b=U/jfybytwa0qsHW/d7IiESNDDAaKSQ6Tt+RPkr/9+lcJ9OEeek48nIAGTf31+7MCxsl+jgPQXwP/G64eo94Gop8tBpGHHdOS/HiTlNWzW7cztp6ZSqOHyjVfTWU8SE32qfkMVEXggD6k9DQp69D4/9cBTGJ0jW67s0f9nPwtTbs=
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com (10.168.32.20) by
 HE1PR0401MB2475.eurprd04.prod.outlook.com (10.168.147.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Tue, 20 Nov 2018 10:59:53 +0000
Received: from HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2]) by HE1PR0401MB2235.eurprd04.prod.outlook.com
 ([fe80::60ff:1b2a:d0fd:5bd2%8]) with mapi id 15.20.1339.027; Tue, 20 Nov 2018
 10:59:52 +0000
From:   "M.h. Lian" <minghuan.lian@nxp.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv2 08/25] PCI: mobiveil: use the 1st inbound window for MEM
 inbound transactions
Thread-Topic: [PATCHv2 08/25] PCI: mobiveil: use the 1st inbound window for
 MEM inbound transactions
Thread-Index: AQHUgLMckyHiIOAy006LOvMZk0UtK6VYfuZg
Date:   Tue, 20 Nov 2018 10:59:52 +0000
Message-ID: <HE1PR0401MB223585D8755A5B5DF6EBC22AE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-9-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181120092615.11680-9-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0401MB2475;6:z8seyuvEU0dsyZs213lInY+j0GdpHoGXrGbOZPA1sQs5z6R7zLJfFu9vo5JFoVnygVNO821PDqpv+LtmQJBcU+t810bTx6e0Uri0RbUUU93BA4HIiydZ06QeNOtPAr6CL6g7bskgnN8V2TayfId7euGec1noWPtC0C5DBVuw5LNA36U5pHF0gaCXF11PTN8HVQse5w60EKDkkVbkHt9C1O7Nu6RZQPxit2JHGeizrc7KpnOv/d34JtdD20XaF0fwc6Wzd8+phC0DyiAeHv8JX5uPVeKWT6W3OozTI6O2XuLrFTeSyYkVanM1+IavM+WLP90DMDoP1PNJdLt6MK1+1+6j5ZqZ1qumqTD5+dFX64TLjAiaRWn4muGoKwKORQXaYdy1gI9aseeAtBFd8KWVt9xfyFALSDjmRSmwDWwYAifDY9Hi8N92+SItv5A3ZFm/V91ax9zOeznrFnoHF68VYw==;5:2O4sJGKLBRI1ul3nnyK79O+jO8iKzlvwXICv+Z3KMB+SOcy1gQ6wJsVOkSJPCHGt42EYwWBOub+Yxk4ZhKXnDHZa5PQMOkC8cvzaeyS57kHj45/9Ufkq4TP6tMVHSxUfCsA0pdvo4QYKf1SxkOeH/MQ3so3CUL45JE+sWLJuBJE=;7:O+xFHlWYAp5qDfQXZP6gW6BFbqAb2k94ZvsklP28wFVv2/puz2niGW8ORXxXhfZ1+K3NPZ4bZdCdT3UpaHA1cXEeG1zDo+SM1xtkoiRCnueAhcJRIV+kz/lkld/iG0I77JWH6dbTuw6SgvUDRHlJZg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a6f9f8b1-c2b1-4ff9-2dfd-08d64ed74c88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR0401MB2475;
x-ms-traffictypediagnostic: HE1PR0401MB2475:
x-microsoft-antispam-prvs: <HE1PR0401MB24753D4AFBD09823EFEA70E2E8D90@HE1PR0401MB2475.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR0401MB2475;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2475;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(136003)(13464003)(199004)(189003)(6436002)(71190400001)(256004)(14444005)(8936002)(71200400001)(7416002)(54906003)(2501003)(110136005)(97736004)(81166006)(81156014)(8676002)(7696005)(4326008)(486006)(3846002)(305945005)(7736002)(476003)(76176011)(106356001)(2900100001)(74316002)(86362001)(99286004)(2201001)(105586002)(26005)(68736007)(33656002)(14454004)(6246003)(11346002)(446003)(6346003)(102836004)(6506007)(186003)(55016002)(53546011)(25786009)(2906002)(316002)(229853002)(6116002)(5660300001)(53936002)(66066001)(478600001)(9686003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2475;H:HE1PR0401MB2235.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=minghuan.lian@nxp.com; 
x-microsoft-antispam-message-info: iAqyPW+yI5EoSL267D0VmKsgO0FdbuUZHy80WUeHGCKkZpxypNPb3iv3qYYMLl0l5ONmygiKrOI7dYPO5/RXzEL2PUnMElcLcPeb0mSQyYYXbz1OKJMBp2uW/IrlRVQ2gMmahpsbDIWvt7tFTXi0N2AKUcAjM/qh8z8g/izSbfIiyxOyC4d9o31kuNXbOVcx6iazBF5YQauYrv4P+dHHzYVTNLwXwSDJxYRU5RStbmO4cwrskePK0MGUaTei1tF/1aRddepp3NRuL45TuU6NvJwAxCxlrMGhPQH5ldXK3h4sDFDoOwMxETHtWLec+9gb+77HjoPXoL7n/h41z27WhBnhLyzW2CVPItRmnntCEwg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f9f8b1-c2b1-4ff9-2dfd-08d64ed74c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 10:59:52.6557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2475
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:26 PM
> To: linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com;
> l.subrahmanya@mobiveil.co.in; shawnguo@kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com;
> catalin.marinas@arm.com; will.deacon@arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 08/25] PCI: mobiveil: use the 1st inbound window for
> MEM inbound transactions
>=20
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>=20
> The inbound windows have different register set with outbound windows.
> This patch change the MEM inbound window to the first one.
>=20
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
>=20
>  drivers/pci/controller/pcie-mobiveil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index df71c11b4810..e88afc792a5c 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -616,7 +616,7 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  			   CFG_WINDOW_TYPE, resource_size(pcie-
> >ob_io_res));
>=20
>  	/* memory inbound translation window */
> -	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE,
> IB_WIN_SIZE);
> +	program_ib_windows(pcie, WIN_NUM_0, 0, MEM_WINDOW_TYPE,
> IB_WIN_SIZE);
>=20
>  	/* Get the I/O and memory ranges from DT */
>  	resource_list_for_each_entry(win, &pcie->resources) {
> --
> 2.17.1

