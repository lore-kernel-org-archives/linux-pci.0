Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD11C43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 10:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865982172C
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 10:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="HEZinX2x";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Es0b7eOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865982172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbeI1RPs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:15:48 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:41304 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729181AbeI1RPr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Sep 2018 13:15:47 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8SApaiC031565;
        Fri, 28 Sep 2018 03:52:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=k4dvLVY5avaeGNqJKopTPHTESxRRJxcK4AxUP35QGpk=;
 b=HEZinX2xuHenEHhwCo5Kr/xPmXahMZxoruH9gXFWqYvSKaIJBtkjqv1Zxk/Zr6EoOb8C
 g1u7UBOGlUGR6x+1wLii43aRY3FHgSEuf7foW4QcKqTqB2RsSABEOJ6bd7w5R3hG2qOf
 ky0AqqfB6J7fBcFv9vdtN4AQTx0cVlpxCXjg8sRB1qnD17Fa5jn1bHQfeyyqADJKbm3m
 AGm8phHP54M3D99DBulSO5bcLwTgv03aA0W2Wju1S/pevMWHiDX44Lu7wWt2bvlCMjIZ
 p9t70ZHDbZGC1M4BjXqqBSRDoAPa5jmok/E8uLrEgoFhtfwzW6kEsMdyyO+fOenN8Ubh Hw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp0242.outbound.protection.outlook.com [216.32.181.242])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2msa861y3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 28 Sep 2018 03:52:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4dvLVY5avaeGNqJKopTPHTESxRRJxcK4AxUP35QGpk=;
 b=Es0b7eOUtW3OVg9G1T/yddJo1HcikNE8X7Iabpehj2P1+MIDPgitaHpWtCe70sD1x4CcQQLYrCtWbDGcly4lLuBt05tY4eFhlU/vPIspWdJwFdbCk36h3+p8E6JgJkXf7C2t3U5SpSaXnPL9X/yX6BEzaywSUQvgbJTFOcexTq4=
Received: from BYAPR07CA0070.namprd07.prod.outlook.com (2603:10b6:a03:60::47)
 by CY1PR07MB2167.namprd07.prod.outlook.com (2a01:111:e400:59d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Fri, 28 Sep
 2018 10:52:21 +0000
Received: from CO1NAM05FT055.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::208) by BYAPR07CA0070.outlook.office365.com
 (2603:10b6:a03:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.22 via Frontend
 Transport; Fri, 28 Sep 2018 10:52:21 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT055.mail.protection.outlook.com (10.152.96.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.5 via Frontend Transport; Fri, 28 Sep 2018 10:52:20 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w8SAqHg0021783
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 28 Sep 2018 03:52:18 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 28 Sep 2018 12:52:03 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 28 Sep 2018 12:52:03 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w8SAptFj009288;
        Fri, 28 Sep 2018 11:51:55 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w8SApqVH009227;
        Fri, 28 Sep 2018 11:51:52 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <lorenzo.pieralisi@arm.com>
CC:     <kishon@ti.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <cyrille.pitchen@bootlin.com>,
        <colin.king@canonical.com>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v2] PCI: cadence: Correct probe behaviour when failing to get PHY
Date:   Fri, 28 Sep 2018 11:51:18 +0100
Message-ID: <1538131878-8305-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39850400004)(2980300002)(36092001)(189003)(199004)(2906002)(107886003)(48376002)(2351001)(8676002)(54906003)(50226002)(34290500001)(50466002)(478600001)(87636003)(5660300001)(26826003)(8936002)(26005)(47776003)(186003)(126002)(4326008)(16586007)(476003)(51416003)(105596002)(486006)(336012)(316002)(426003)(42186006)(2616005)(6916009)(86362001)(305945005)(356003)(36756003)(6666003)(106466001)(7636002)(246002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2167;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT055;1:lFi7Xnc/AR/U4zWFh5eTt7g6TOD8Q1Y+TdWeohHJ9ewQfTUYA2DmKlmrzUqJb7vt76zup6I8RkxFiAJOFlDmGtfNKE68xSLH4nG0mDfN+xRLVU7+es3rMYiLxH9Bydg2
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa97708c-3619-4c69-36a9-08d625307736
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:CY1PR07MB2167;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;3:WaQpK3EKgnBQ4ZIo2xGNUNynT7cj5X1Js6uYAb8riHNbzvqhbXTNBdkQxw9fv2w7SoL+pv8bFCRjkPV7qArAcCWAvIQ1PdmLmXxHZg2qtwNW9KTETkHZQbTpfgK8TFho/XAAK0iOrqNfBgBvXdxQvaWvY01j7E19SRFgi3OTaHsQA+HyOijTRp7vw1HwT3MWqfbVkRiCFRsLGy7pMkBUiZvj80iA1NZNlUavSD5+R63TqqIeJhl5SzCxbG8Hc2lnyd/irDWxiW84Pudevp8pVVx0rIc/Jiad3stYHjfry4yeZQuMCi5beuNdlWh+UFYK2Bfu7/LXqAQ/levbZOa9kTDzGRdtCa/EIuM33LltoEk=;25:uomGnlJZEoLIVvFTD4yQtRk8U1fTufcHiT28VQQwTMdxURao4noimj+Z/C00NoOhpBEsZTv1+rslIvNOm90PnQdV+PKftSZSCpsSxrwDyiCPPoFPA3wuIQs/CxVcvVjoYAGQFhLBB97QKCFGFFcXcvO8699fdowA3FfHcfuISutDj44ESK5wpUyemPppSusKuku+fYZUKnD4B/RNQu8GlSZskhrZom73NaxqoUQ7NH3uZ37Vb4so61R+ey8GFPmEqppy/ioJGoZs1BpdxcnQjv3eU9WEnV6CnyacCEcRluHfx0kGOgGbHr78kOIIR1NQfaPMJxZEs4S3fK/pXcOaruy06xXc3x7Xcy6E5d1ZRdE=
X-MS-TrafficTypeDiagnostic: CY1PR07MB2167:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;31:fMeDR/TfiqR9ltmwjQsECvV7cmX8NIhS/95TgySUWzO1pPZqQBDrnWnK8lTTyRX7k1hDBk9fgdQjtXonM/pxxehX7RKxyymFwXqxcHUdZ3SdgITeRqbismY2Q+TWUI29GlQCXgXBktnTv45iBXvDriXP9mHCiJhqpmtIE6h19yF2OMXFfn+737Roj1JezC8R1HcDqf+Tc6G4lc4z+lohntxqdlYmVAP2MBxBPCY6hro=;20:d+B/85Bn2v2glS47ElIDtw5yzaQAibdfSBLXLxboSzA4Gs/FtR3a1J4b0MHFxEl2hszR8N0SKX9JBqBaQCpyMMCzXqkzf0TEyiSaaIgmoXBNOyZ7jHJnKe4Zc/75rlPnpiw+5+ynzn++uk6j3ei7DRh0OVs5yfh+ni4sWSmTxo8pQQG6OUYpxttOL3cbtYTSZnCU3tXAjNAwqWg7OKD/EYOVsPh23WXiJuYQ4VPz0la6mTxfKguD24CscXSReBsrV67wrqHE0wEidy3bVMAJw3/5ExEB6mvc3oPILFkeK9W9omQR8DobCzhvJ5mYG6IxnVTuxs+CSgnsBsYFH7bl6BHiEUvJ3zugH5ByinOCaT0pROHT/v9pJ0Pum+oxrDJ0xkpPthebJGZx5ZZf73of5+ATRclqwwktCnZkKEEyUSMCVj7dnshpOq+q06oztl/URNetj6RvFNuTM/nAaBy0cSY6sW48fGwzeW7BFPXyaWF0+3/Hcj0nqOzsgNrGSUIo
X-Microsoft-Antispam-PRVS: <CY1PR07MB21677B9D9C1451F075FCB32FD8EC0@CY1PR07MB2167.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93003095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:CY1PR07MB2167;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2167;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;4:cpIhuaPVMW9H+TxDlmihutpWgMTo59XFLpNpMGVQvOOdza5JVle3mgQQg8PE7DBWGI+lDyNmQroHyDJh+FplS1rnPkd1v1u4EqeT2M5raq0hE9zTwnxOYM+Izov/72Rp5olN2139/YVVwUQlyNi62j6YbDY+8VFjdhuK33iRJXm2Z216yRLu7FU9QPDkzgNdxSEmZX7OvXBXevCsS23gbCkaeOStp3j9ytBqzVwFqRIpHb55ixz67LUVhrW/SmYl04V5tEu/yWs34LZpUy1QjVc42nN+EcvQvgVfGkgfHW028J+CJolUP9kXBWeWywVe
X-Forefront-PRVS: 0809C12563
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2167;23:hFoK/jBu3379T5xkZvs8KZzSHA/ELtAWTKHTs85Up?=
 =?us-ascii?Q?9ZpZjobmBZihdTkIiZYgJuQcC3Uroi5+VYX1dIMy1bNaNVBcvxsMdqN7jX0q?=
 =?us-ascii?Q?h5YRSTl03yf+KTSie5wy2Me7chqF5yvwLIK9Dl+sMm7G6ntQb3Vpz5ePEFyY?=
 =?us-ascii?Q?9cg8AuOb9RdcBgZ13I+6OwgjrZ3Br48LhN401E+UjT5wAMd3Fzp7N/GhWGFK?=
 =?us-ascii?Q?IgHc4gMZ3qTT35rkUQpt5aBa/ClXeyBr3VELgMHS7JJmVwkZG7iq4dZAQMMS?=
 =?us-ascii?Q?7SwzKWKZWVQCcjz/6rK8olqM3UAr06najDL+AR48Equ1I0StxpdQTI7EcTiT?=
 =?us-ascii?Q?UoW82NV5QfouKC7iS/YN1NrORZlD3E70N8J9lyZy0XinL4ToGznICrHZ9cKu?=
 =?us-ascii?Q?d9o5Yt1ff+73MapxGyydF46wUXsVssetCPeNQYHgwFFe4A8Z9elFVsoH8sOb?=
 =?us-ascii?Q?eE9J/AyYnbOk8eGH1hRgtfyEXpmfTnbCEJ8qAN6Uls+uM/WLXhX8Td7wgYAv?=
 =?us-ascii?Q?yinJKPhWLYXoa0SiFuMEzVNttJdK1EZEdBZsoUHR2dwmxyk61nhq+MqQiI4i?=
 =?us-ascii?Q?REbm50zci8EWvOUGUSci0WG0Issf35b2338Qf3ly8+fFfkN/4ajtLmWc8ptB?=
 =?us-ascii?Q?jSiOVkCTEtaW0gmSpC9VkRqsuPEt3s7+pkAO2tJM1E9xlU2Pvw38584GC0BF?=
 =?us-ascii?Q?v3gKyjFcHzpUE1g1nyxRPwQ3SSDuYRb+kS/xf5kzeYigYaTBrMNPhI5ydfbK?=
 =?us-ascii?Q?OAWyVWtFcGAj4xuBaiNzTFlugSlKmVPHJ9Z0c4QC96410QnemClC4G08QGez?=
 =?us-ascii?Q?Q3ZIh2dxNy+KV1C4Cnk3vYDe8jXS1BDYDswIIhGlTB2qq1a+6wY0WTuTN/oL?=
 =?us-ascii?Q?JFs3jMNRpxzP8eYa3nTSPhQTggKaz+Evnrd+qOj04ZMKtoNl9Ag21VztVWkn?=
 =?us-ascii?Q?C3+HBfYU/owwTpJ58+wcvnql9Juj6Pyx8E3Zbo7a0oon7HwLIeYkZZ1lgcSj?=
 =?us-ascii?Q?4JSs/DC5rClauL+b97QkQUDM5WTKAaAqPQsgPObCL8L+Lkq+sxJ90BSu/VqW?=
 =?us-ascii?Q?b3qlFwIgarV+M2xEOS7yWTneue9?=
X-Microsoft-Antispam-Message-Info: Q+aQDxZR0cOaIq+fK4aFG4zKBtRfdnbzvPCrfIhMaDF/Pc3mu/501mtwOo2dI6OOGmwBnPMaPWyxFP2hnXnjelFQ/Q4YiuGwF53TEuGm0T/GIHOGWFfjFMZqXazYgCab7EZ8cnLvIwzziewhcmhR4a9xkywRnSWQBPy8XFSqPjTQMznY3xN4nRoCv3qSqpZE6SqrXKrSD8g18X/KdDJgFuxLSw0WlbtJvmI8UBblD63dTWNowF5OlS7p6is+W2CArXqTZrWcYHJyLZuuN9d1dw2yzxTlfDbWSUP77sX45fxlonSH4iq0Ce2/Njn3xO+yuS6nRl03DnUCT204jbYkriW4u6VYsyycm5QM6SCaMDjyBkHVfCZzyosRoUkpVNG5IQz4xCNBTziEvWeqx6duHw==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;6:tB9Pr9LDWI87G49myu6fSnIoW0Xd9ehQkyXp9tIBI2keym10AOho/dpZZBJtaJNtdJoNa0SZW7HaUe9jJU7DjPvdSysh5qsvsVc/eY3FPsxqaRF5idIvtF+m5dhknuXN5osYXvaCrLAndhiWsm7cZ5r4LFtTc1GJ4SbhswGOLL0h6iqkl+NGZL5VetXSsy0HMiKWPs9YgK3/mQqlmYEv1xrzBZWCtsLutVZejGgM4MQGRG8CHWYhpuHngnBAWHALam+0DXpU2ACvtZU/WpRa4GmFJaWhAayKVKoP3guWBPgvpyQQAdt8yW2quzYdNeVu872fel8VF89jSGU+lncCJ92wJM+rU/arpPn764Vb2IWXRorTpg0RKsHva/KbvySvkwYwyQi2gYs44sXH6TqUBiLolQ5V/gBekS8q96vWHnWCztavRqE9Vx4KREvRbgJpeTVr+DLgtWsKYSo/jztjEw==;5:KH29XFe7GUJp/Lb/U36Bo+Dpq3avZXG6x3Eds6CLJWVq2oIJGEBzOe8b4ZBO4oXdnoe+ZDvLNqLGyi+iCNkHBLByq2D7iEntAUXNonf9jQlYki7gTPDMLWGm1UsBT+mC0juZEci9POiqaIAK2vYvc3XuzzWqnaIQE/zsLNFKwc8=;7:SWJnvBkQsEjdNPci4/LvHZ8c6r1LPkHDizuY0H6eqIPIBaEz/R82/SsavD7cB+vnM6HP2/bKYWAE2Tu2hrYmRZM1u5nIG2eukTTErbvDcVQBgrjuojMjf+n6sn+h/D+NQYfcQHoQ55UGRdlCAl7FZxOC3JTrxK80cElhT+mmQg4wUCt/PRfB2D1b2VWspFtDDngm+RJglYftNx03YMdd1Nvbk22smVQOtafTHO7ZUOqVISE+5Xmo1FcB+OZXQpzF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2167;20:oLgyXmHUM24vXoFv0dvK1Us16KMk2OuiITWliWo34LyjASv7WfVKNLlJTHlx4qC0U9m+YdrajLMlmbC4vY0HPbgdfui8vrylS19fLkgIBRLs9EbvcgYS8D4aYeO3C8DoVmksyTi3j7UqYFioAYq6VyOPnQWXwuQ+X4yOAczdp9cUhqAJvNR8xWQR6o5rudjNiuhVm0HGZRUJoaMrBsow3aAl0gOC0pjtXVA+M5Nlv3+CgSBwXbSq8ZZaCbVlIQkf
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 10:52:20.6015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa97708c-3619-4c69-36a9-08d625307736
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2167
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=894 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809280111
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Test the correct value to see whether the PHY get failed.

Use devm_phy_get() instead of devm_phy_optional_get(), since it is
only called if phy name is given in devicetree and so should exist.
If failure when getting or linking PHY, put any PHYs which were
already got and unlink them.

Fixes: dfb80534692ddc5b ("PCI: cadence: Add generic PHY support to host and EP drivers")
Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
changes since v1:
   - Correct error in while loop pointed out by Colin King

 drivers/pci/controller/pcie-cadence.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence.c b/drivers/pci/controller/pcie-cadence.c
index 86f1b00..5865512 100644
--- a/drivers/pci/controller/pcie-cadence.c
+++ b/drivers/pci/controller/pcie-cadence.c
@@ -190,14 +190,16 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 
 	for (i = 0; i < phy_count; i++) {
 		of_property_read_string_index(np, "phy-names", i, &name);
-		phy[i] = devm_phy_optional_get(dev, name);
-		if (IS_ERR(phy))
-			return PTR_ERR(phy);
-
+		phy[i] = devm_phy_get(dev, name);
+		if (IS_ERR(phy[i])) {
+			ret = PTR_ERR(phy[i]);
+			goto err_phy;
+		}
 		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
 		if (!link[i]) {
+			devm_phy_put(dev, phy[i]);
 			ret = -EINVAL;
-			goto err_link;
+			goto err_phy;
 		}
 	}
 
@@ -207,13 +209,15 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
 
 	ret =  cdns_pcie_enable_phy(pcie);
 	if (ret)
-		goto err_link;
+		goto err_phy;
 
 	return 0;
 
-err_link:
-	while (--i >= 0)
+err_phy:
+	while (--i >= 0) {
 		device_link_del(link[i]);
+		devm_phy_put(dev, phy[i]);
+	}
 
 	return ret;
 }
-- 
1.9.0

