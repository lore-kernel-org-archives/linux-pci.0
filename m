Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2BDC677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C284C20645
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 16:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="olCMmp5G";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ir069EYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C284C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbeJKXoC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:44:02 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34718 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbeJKXoC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Oct 2018 19:44:02 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9BGDg7s005455;
        Thu, 11 Oct 2018 09:15:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=PJhYcJ/ddHYKnYRVJ+q7hPi/qb4fVDn8zbgDl04xfQc=;
 b=olCMmp5GOTdqva9lOGHwbyNDLyM+nXOz0m40hMhUsDG2UpC4FpJX52YC5dxzYPpTY3eK
 ThULILkY+Tks74AU6dIbsrpYaNgeUTKpuY/GF3HwNIYB94+SyNtw/Y6gy1jWzRG3EKZ9
 GzFUcgbJQY6PAvkydV3jQeUCf+MMftOjH0iyKTKNQrWSizbLC20OSOLb/TocOK3L+6WX
 DVbAqZhQmapOhFTwhsJvOHASPfnusrDM6pTqjbhq8zsxs/lOLbXN5ZJJXfRHVOSbtYob
 7NMMRG4mqvWoTeTG0FOntrw6h2CXypxHnbc8j6j7gXzXcItmLvkOwN9CSsZ15+vsVTkA Gw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp0083.outbound.protection.outlook.com [216.32.180.83])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2mxuwx7qhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 11 Oct 2018 09:15:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJhYcJ/ddHYKnYRVJ+q7hPi/qb4fVDn8zbgDl04xfQc=;
 b=ir069EYE9ClrpMW2o51Wmon0SptCodhKDc3IgAOF8B8GoJ1c7uweIyfR4hqeF5V/QYEMgy6nwz+HdFnTuoVwUTEkSbudo5bOYPUA1/x5QGH8UmF3QEYPCXaBUv5865fB6+cszNpAUwl2g6xZ5vjtXwVw8JvuOxwQ148a/wacrgU=
Received: from BYAPR07CA0007.namprd07.prod.outlook.com (2603:10b6:a02:bc::20)
 by CO2PR07MB697.namprd07.prod.outlook.com (2a01:111:e400:141f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Thu, 11 Oct
 2018 16:15:51 +0000
Received: from CO1NAM05FT044.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::204) by BYAPR07CA0007.outlook.office365.com
 (2603:10b6:a02:bc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Thu, 11 Oct 2018 16:15:51 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT044.mail.protection.outlook.com (10.152.96.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1250.2 via Frontend Transport; Thu, 11 Oct 2018 16:15:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w9BGFmPC028960
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 11 Oct 2018 09:15:49 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 11 Oct 2018 18:15:54 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 11 Oct 2018 18:15:54 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w9BGFlnb032082;
        Thu, 11 Oct 2018 17:15:47 +0100
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w9BGFl08032081;
        Thu, 11 Oct 2018 17:15:47 +0100
From:   Alan Douglas <adouglas@cadence.com>
To:     <lorenzo.pieralisi@arm.com>
CC:     <kishon@ti.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <gustavo.pimentel@synopsys.com>,
        <cyrille.pitchen@bootlin.com>, Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v4 1/4] PCI: cadence: Use AXI region 0 to signal interrupts from EP
Date:   Thu, 11 Oct 2018 17:15:43 +0100
Message-ID: <1539274543-31946-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(2980300002)(36092001)(199004)(189003)(4326008)(7636002)(5660300001)(246002)(478600001)(87636003)(26826003)(14444005)(186003)(6916009)(486006)(336012)(36756003)(54906003)(26005)(47776003)(2906002)(2616005)(86362001)(50226002)(126002)(476003)(426003)(8676002)(51416003)(8936002)(50466002)(42186006)(48376002)(356004)(6666004)(107886003)(305945005)(105596002)(106466001)(2351001)(316002)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR07MB697;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT044;1:V7rCiQGNkcpUQeaIQxUegFfod4Xz2/U+Pz7//V+E+S83Mixb43mQfo8Y92bueGBdQzBq5FBGAPbs2t1kWtg9MzZbtD5ozczAu5qaFTFzpr+DWPyIMHjWTB0i+MOTMXQT
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a85bed70-4d70-42b4-2709-08d62f94d005
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:CO2PR07MB697;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB697;3:qYqtGLneLykHJTFko6BGto8OdvrPILgAQBSSKboYvvWwOg9074WoDTuUwdaNUnYzrECASgWboHncBQipWk8WPu7QGXJ3zoIE7dWRdpRrYu0n8aLQRafvEijtJ8eVW5g0JAk3bTA53DrubA8fmOeNx+qFzwsSPMiem96w3Xhk6tZnF746BdKAEhDq/Z6HIh2S/S45QaIbJ3jhRIc91nxFnyTxRgNrvc+yPpQsVaUg5x6VY7M8+VLJ3GUyjsAUNJM/LfkrePEdteGkNnRAiALOOQTw+QBGkzW1ovBqvPOh61O+Btgos6ESJoDXF87dzrRvO/NsRg4GWvSdDY+XgPlI6yBD8qdo9REjzMal2E7LW/g=;25:jLKq8MSXGMD8gEqP9B6Jb7M1J3RVrUAMqMzxySQwlgF7MHAudhxpJm6HDH0mOhZR/k5yNfxKBpGqxIkRmpOeKqXnscNKe6RDI32gVWty9Kq4+l7i1V0LNKJK5Or7ckA+Z7sp9UVs5Gb8Ga69u65JkA4idwgioE7VuIsPrDuy1eJuNjsWv/RMgtYG9T7Z+Hy2PSusxO8UQH5JGGWt6e3k4fgQRRauZKV4Mwzif1mmFgdevg9OdEBKJ5b+U3PSlecH1OS3D8o3eQrISqkpxW4DqxyEplSd1OGdTstt2RCL1taEcbPcbReAQsa+HaPRFQOut9tD0Q1OzBCzfkjIIMeoZPKS1qMYKZIIsBNIhjiPZ6g=
X-MS-TrafficTypeDiagnostic: CO2PR07MB697:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB697;31:XHOUGc02gTEQCbtferLKPY3BRtjs6wZFkuuQV4D/tIar5tcWkYTX41zCDUSQ1BPRa2hIwU+G7Pxos889zo9Cnp1SI0sOb3tFyMemHwDzILZNJ3+Z57CTH6PGTgfkun3psLglfFFO9ST/711Ez13Nrs+u4xtcDl4EIOWoRGRpOYcGuUJsDmwWe+C/QPTiIzWoNMtVUr3p1qOgk1X9ZHySitkjSInj+Q+YBoFqlqf0NkY=;20:MdgGEWJhTuVFDPGxjYgib5lvQ7z6ouSQ05vdo57rwCgzDQ9WMZbIAbk0sfr+9x3hj2dzTMXuKf9J4SmmtQJX7TqezHFAqqP9AdIxHnGx8tvq0+H3txyeemc5+xXcV+izXzKT+xiQ2aFHv4W4f8rjrzYa4U7gEF+6Z4CxF5pFBtlNqMxJdmFsUgo/w0wvlTqMo90f2pIx3kgOi1w+4ZVNRBnET68fRad7NFhmEY8EcvcReDXKH8KV+o3ke8zsYIPsokN9QyKM/KEnDetIiIXIYUiW3V90o93XgQ4pR5haKmL/ZgNmzgJXYAU1v273P4AC1S4h8KobcZ1qtOsaqJvmNWZODlOMzBZO9j0OCgCp9btuiHa+RPmFGDoQ5MR4SdTVZFlYZJ5vgiiq03RQbXrTCP2kse3iPGe6fXDYuyBj3dGbG876vnxxW5XBd2XwvtBmqXmhCVAKW8H1hmNQevl5G6hOCJv1ZpKefB/c6aJi3+xbPy25Y64XCBbN6A8AbttV
X-Microsoft-Antispam-PRVS: <CO2PR07MB697188A26BBDD040066CA88D8E10@CO2PR07MB697.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:CO2PR07MB697;BCL:0;PCL:0;RULEID:;SRVR:CO2PR07MB697;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB697;4:7jIIbanCT3AF+LG1dX9Rn4OvFV+kKkRjUlQzC4I5CFBUpZlwipXU6kBWvb0WWFGUnmceXzU0N4mN/MLa4DwaAZjTjL9aC4B2Yxy9TxcnvloIU7Vjee0X+JVTQm8uRyp+EUsn0MANLb5fzUzQxbbyuheqH45/ToAEY0C3FxK1zRx2LWMT8HUmkvpDwgZOrlr0BJIOVJjy2bcyd9zLmAqj230h0Fv8Thj8JsXIaD8b0ibol0oBexfgBjeFGCdvv1g+FBkg2iFQm0fTiqdjfrWUtJYlX2Dte+XCbmFx72qCVnHQScYjc8lm03VG0lLDZcON
X-Forefront-PRVS: 08220FA8D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO2PR07MB697;23:6YJ5BDxUH3nUtOwsUiRn+jiMbAkWD1nwNhfRb5glsx?=
 =?us-ascii?Q?2uYYJPfyh6oNtQsMdbESWOKiDwgMVtCo9zXNctOeOjWqdGgg88XyIsr50vCE?=
 =?us-ascii?Q?MItJtCrflKdPzMJsWEtNM7KZZ38CJB44l728TNA9zyOVznoBN9VEMHVcGC36?=
 =?us-ascii?Q?oS+CNX12ItCoxRBsIUNzc83eK8lZUOBn/mV3l+smEZTl9xL4/2/Ar1G47HY6?=
 =?us-ascii?Q?1+AAVybF4mFtzhFL/kOwb78SM0n/uqEyMrWUC0IOY3Pt4UIX3f/g0NYFsWfH?=
 =?us-ascii?Q?nWOMoRNWLQ27huqYos/ZpzvJLMlNTdIJZ6UWDPllD+vkp4dXT6US6ZRr1gPE?=
 =?us-ascii?Q?5loqYPmdebd6KAvjaMHqxtIoSpOIp3goE0YBze/aAwA+8B8ecyI6iihvdePx?=
 =?us-ascii?Q?s0TWSeyqEibct/dsuWBR99P2w27jRq21b0ZTVf713eMMrDKfwZLK14+rKukC?=
 =?us-ascii?Q?627MsoQb/tbCVLBzK6fpdoISQJYtij06cEvedyoOVawcuS2lnChDks0DEzJ4?=
 =?us-ascii?Q?bW33yctisB3py9fHbJnCvhV1KIvDFk7QwUH/g+NelrGX/TJY23peptem8Jdl?=
 =?us-ascii?Q?hUaO8d3gsRJlp6W+uH6K+yHaIQ3eL7J4fRO9vRwpHovF0QDIotM/pfV6/F9z?=
 =?us-ascii?Q?VD+MuospW7GkAwga82KZrwidFnElxzo79MhfbdVRmd7cKTY/rh4ZvLZqRMum?=
 =?us-ascii?Q?liceroQ5NJc/Ql6XdMorAhk0kUfGvhYSEAUekMNyYokz1RXpU2oAjYemWdnS?=
 =?us-ascii?Q?3D9eo56Qale/GDBXaMkzt5fWd8A5ABnFxDj/dBbfZ3Ho5C225BK7yJLi0c81?=
 =?us-ascii?Q?EY7uNcw7zy8VAlUZ2ly5XdYXPhmrUS4c1t6u+RqrbiClSbYD96ER/iqrhspA?=
 =?us-ascii?Q?61XlvhOfLc7POshvqYWpwMve/+ZXEaB+secgx9KV153uDgXv1y2wmw0JZwQj?=
 =?us-ascii?Q?5ByYxsW4oqRF0s1tz/g6TbL5h5fIvM5QPWi0giBynLSPndSTh27eBvt2u1F9?=
 =?us-ascii?Q?uSjHAzAVL9BWJyY1irKna+vy1L4P/oo7S/lms4xa14sxmWHgwYUH73DLrS18?=
 =?us-ascii?Q?c/00Q=3D?=
X-Microsoft-Antispam-Message-Info: fSen4zO0QR9I60G6Ucko3yF1z9W5EY8dCh5gu5bzfrKuIxzsneiTidlhNDH+wDrqjIHMGFkgiAWSZY+vU9u5ru+ESAfA/UqMKqDfruQmQyHEbLEXZWXdffJXTbqHNSaN2pZNnFDWW88bIN2WdAXfTGjDI9hSh6cwKPYL62zJAXyZM8wbBazGfHh5pJjyFZPGy/oKOI2eQswxDqtR5YnyRKlax56pX61zwgu+zuchckNt5Mvi5KB+TTC4A2JfZffTemziFhjaytRUi6H2KQLXeRxjFFV6Iu8TSHqx2WoPrIPKseGEKUqh5CPvF7DP9hkPhh7WZmNCObghJELHd/vOYQQrbe4TGjcWulypQEb52cunVse2hTRXdEpKkBQQgUA5AqvXneguN8mpIeET9sOXqg==
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB697;6:kCdLUVEbmda8waRICkVxC38iToRmFjOfgWS61AL+QX0JBPlx9tJrNEtxrXi4in52oiMDZVp6xOLGdKromDlWPKh7O0rz0ErPiZ1ak4MgQ0l5qgmikoQGcPVbRQzC7in3YrerFaQXlw8D3Uo2PziEWAhVLwtUEvX1xXJzUGuhBF8QN8lz9eesze17gvg4Xg2JZbpUG3ZzzTv8ieZFxRCCbv2ybocyjB0KaQgV3qfR11vwftEPGz2E7/RkZHSM8WuUwFuTI76ZE3NrUOW8ZEB818N7c9i/Z0DTGwcylN5bqqFCiLwYqgE54PQS7IcQIhV8VlocxLqo26RFU2tCte7mKyQYPkVkQkvgDXr2wSuD/Wx14JOJpIOWv8bVU726LCoRlA9T4QPCejMBBqJ634tZld633eSNJCy1qFGNicL/pa/wRzJN9syZ7fu79E3E4xgZaPv+JKgO1dVK5ISQDtrKRA==;5:3nj4DlvU48fvEyxUuwZWoeCtsEEiWTg4z0KLJ6OOysmQddJ1/CG+Xh2MaH0eiXbgeArlCh8WX5lWKjtkkddtYlEcSIbrb91zIxxZjgZ5oRP3fLfCpQp5w9DuuVrkMdWYMRbZd0Lhn0Hi2FgFdbCz6GaQygdrJD+WctkYjfIYxRA=;7:PLRFgqSl/HOrKH8DP4MPdZNZ5/BBE+6VgOVVHnO7AjnsBJGKeP9naL94S3YZS9a+NWPPg6svye2prvgJDvTkA0+g9qMOyusEDtyzYYTzggOGcwMKuSngzuRAWXCumcLOhzQhmmUT35GtG6x8xdQ82i2PYu2d5Ql8r2TJfTvXg0X0bhGPcV9qcSQyQXxIAxmxajClqsUadC6MqwBJpI5fWz5VRSnN0O3a1vIszH+UlzNXJYDEY8Wec4g8el4E/n5Q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR07MB697;20:1xY6EzBnfbvznMXPTZ0lQ68B2ngNiNb4gfFWnpO+ycgR9vMcuQmwqLt0xNtSnSTVj16k6qqdq34KMVHCcQg+jvd5DFl9/F4+Bq3bqZWxLz9yMHw+PHfLKht4MsFY7bmMGO/HpSVGilI7J8U26cckqSo3+2kS+XYUrexmtRMPGCn08a4oprEBqQDGOb1zTyHw+cdr8qOyMjceOfzSVj7zxWPTRuuew7+RG+BnzozZaUGyhB90PNS6J5oAmiQ3IoEQ
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2018 16:15:50.8980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a85bed70-4d70-42b4-2709-08d62f94d005
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB697
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=659 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110156
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The IRQ physical address is allocated from region 0, rather than
the highest region.  Update the driver to reserve this region in
the bitmap, and to use region 0 for all types of interrupt.

This corrects a problem which prevents the interrupt being
signalled correctly if using the first address in the AXI region,
since an offset of zero will always be mapped to region 0.

Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/pci/controller/pcie-cadence-ep.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 9e87dd7..6692654 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -258,7 +258,6 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 				     u8 intx, bool is_asserted)
 {
 	struct cdns_pcie *pcie = &ep->pcie;
-	u32 r = ep->max_regions - 1;
 	u32 offset;
 	u16 status;
 	u8 msg_code;
@@ -268,8 +267,8 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
 	/* Set the outbound region if needed. */
 	if (unlikely(ep->irq_pci_addr != CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY ||
 		     ep->irq_pci_fn != fn)) {
-		/* Last region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region_for_normal_msg(pcie, fn, r,
+		/* First region was reserved for IRQ writes. */
+		cdns_pcie_set_outbound_region_for_normal_msg(pcie, fn, 0,
 							     ep->irq_phys_addr);
 		ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY;
 		ep->irq_pci_fn = fn;
@@ -347,8 +346,8 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 	/* Set the outbound region if needed. */
 	if (unlikely(ep->irq_pci_addr != (pci_addr & ~pci_addr_mask) ||
 		     ep->irq_pci_fn != fn)) {
-		/* Last region was reserved for IRQ writes. */
-		cdns_pcie_set_outbound_region(pcie, fn, ep->max_regions - 1,
+		/* First region was reserved for IRQ writes. */
+		cdns_pcie_set_outbound_region(pcie, fn, 0,
 					      false,
 					      ep->irq_phys_addr,
 					      pci_addr & ~pci_addr_mask,
@@ -517,6 +516,8 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 		goto free_epc_mem;
 	}
 	ep->irq_pci_addr = CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE;
+	/* Reserve region 0 for IRQs */
+	set_bit(0, &ep->ob_region_map);
 
 	return 0;
 
-- 
1.9.0

