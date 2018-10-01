Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641D0C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 20:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F6982089A
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 20:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p62NqU/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6982089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJBDgV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:36:21 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:43648
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeJBDgU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 23:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT1w3qVAWK1IiPIQgnoR2UogdxeNNuDJdr7aQb1f//k=;
 b=p62NqU/oUjkppj0tIv9GX7j+Fds50s2QzAyt3+Ht8zr9v9WF6mgeuWQmhNn8xlLglEwfeIPcbSA4M34JNZfJdhzOql8zC60d/fJrod1Rgc6tdI77RTYAqQF0TecxSeO4exeE2AqG7RMBcyM4FpRsqrJNiWHetuEBiPO6HKPK4Ew=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Mon, 1 Oct 2018 20:56:34 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH 0/3] ARM: dts: imx6sx: Add DISPLAY power domain support
Date:   Mon,  1 Oct 2018 23:56:15 +0300
Message-Id: <cover.1538426534.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0058.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::47)
 To VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dae2a30-6572-4fe0-9dea-08d627e06005
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4303;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;3:hBfdAAdV8k0moKe3CybbzZfc9n3WtduVKaGyRD5vipJOKoGJG0WEixfWRRSTwdRvwmYkxB2HIqSdgNeEx0xQYPhVSsMqBCIbMHJMOrVGbFCR74BppzcUsJi4FK6V/wKZZJV6uMlZzwl88pVF42PXSoFSGOdHXxtEr7WT49KxiyjYGp/rATG4z9+SJ9qoB0zOQ40t0EVu62flfv68118iahS/iyexCAiUgdPAkxcafY/j0bo738mAzfO+sndL6W53;25:r0xNyCreB4Li5VqHhQVlKESEyb+/T+ebrSFKRcPiBjnV2PcpNfURVg2RVQPQxKYvPUWM1VFjp/7MkLLpQIEBW/Pr1dYddIWBpYNDfx2v7Ncma5gyRQxkbNAq+aVEa+n01HQ73q/VwzIIvmQSsGO2mshJDUn3DZFygfTtE1ocYcDqtW9oW++cvIFFd2ybYdGg95/LR/9j+H4Lj3G35BmfLtpJtbJg/lDHtpPzw0eFGPQ5jWRLP61BaK3U4H9nb6UeY6yXcLrKVrYgvRH76RFpKLWPWTQy+esyvG1PtbQYZj5lbx7FQ2xocqknPXiYtK6k4t08iHRezqDzdvRGslZcrQ==;31:h7fsQ3AbWi9ZT1P05IAEhkbhogK2ZJapdOfmpxSoKmae5VGAQMReOSmrNm6Z1YFcnOTarr3I+Hnqn5nY9rnF8Swa9T8lX5hl1uS6hUjhSze6TgPlBfpgdrpOw1fb1MmZDU65le0dnTddEjnAGYMVZBfOrh6h5clcCmGTyYyqs1botedRqwc6cuamHsMkRvc11Gv6/Dli+OFuhdTqYKxIgU0m6VwhjmUo09SRuY5Tcsc=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4303:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;20:XeR/D/ggVcMRdrrVZNbTgVlZpsuqm1dBlCiDsiMUHl4WVNldbf/dC3jaTiJlIsqkHBvlQlfcudy/M/HtRwu8mPDAHsvFT3KR1lKh7H00A5N5FWA4sssE2xQtEKoLtX7d+EfT65uGYfq353EETzRJ5xDjjt8AOY2Z55UyFi6Af0g9cAqL5IpCWeWbHVCS/nFqgj7d0GDd68Eb9u1LzPlDCNogIDD+AuGxuJ7hKB9xSoi5rXhZ+hwoOh2m6p5ckiOTdpDvXBXx7XcgV1LydfZGAVCMmmIgveCPEaTc27ZGVTdMjYzjcfbNoKOMljtN8T2Bc4QMw6XYo7SkO04DKtqC2BmEBUyCbyHR7c2Ti/UxG/1WkkCTIZrWAuQjYWRNqhMRHiKZC8YtrVZVQ4NfJ0MBIzivHrIhvNfibQZqBoM8wRtV+ou9mpaQjJP4tG1XT6J0s6jpCa6TVZwXeGDgCN08CBLdDSjPCUxe0/FnEog4b6oyecYI+2ry81mmiPkekDfX;4:LCGfwM0xekxjAjnc017/iDmZz+SVpzzPgClvRiqDcFsOm93wLtuDFk0/j98qsqLWdFiZ8fPwT+oWmMeINZ85Ji+M3aaKLvO25j6blQhqluw2mSZ+IyQ2JSOyB/v/FukuEzVWV3kaiHIaI1ebcTjXQ5CMtFEuYCFHF83fMDZYNH8MgHrXBZJrNp2Mu6ZSbVU3tUK2Gbwo9VFQf5HRgMkfC5Kyfney4PwOz2vyTeVv0MgdK39+yjLAC3ubV8l2WtVUi5qmnJ3v6XPnxsHdwGTdbsCqG1eqy464KyqOlYpuHpM/+LAjcnkJu7Y/60OAGSD2B4+gW6kZVVIt+NzcqRSnfQHmSaxtgQWNYaUle7UUa4o=
X-Microsoft-Antispam-PRVS: <VI1PR04MB430393C835C475EBAC33EB61EEEF0@VI1PR04MB4303.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(269456686620040)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB4303;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4303;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(136003)(366004)(376002)(346002)(396003)(199004)(189003)(5660300001)(6506007)(386003)(316002)(3846002)(16586007)(6512007)(36756003)(6116002)(53936002)(54906003)(110136005)(86362001)(52116002)(51416003)(6486002)(44832011)(476003)(2616005)(6666003)(956004)(2906002)(50226002)(68736007)(8936002)(81156014)(81166006)(8676002)(486006)(97736004)(105586002)(106356001)(478600001)(25786009)(966005)(48376002)(4326008)(16526019)(186003)(69590400006)(26005)(7416002)(305945005)(6306002)(14444005)(7736002)(47776003)(50466002)(66066001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4303;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4303;23:OE3CRILcCC5XDNTQbAWGBE3xSZrJSeiNdFbcF1WqZ?=
 =?us-ascii?Q?GADm3SBDFR1WhawLjp+eJND1M9D2DSVg0iBQaP6vg5zRCXVQjz5xkJmEjDyp?=
 =?us-ascii?Q?5qDds4T6F95xZbTle46WqMQOtqKL7VekNfoAinm958B7NTuXIBFYlRadijev?=
 =?us-ascii?Q?yihAqsdHUZYhCFi7aiM4UUOGsqSyejpqwW33MDy7Uyt5aEs6c810alhxxBqs?=
 =?us-ascii?Q?MwyUkEMBK4qOZZrJ+HqrlvUaVGYqcX/GpAHWo2xyxLJCZSbsaRxxxHL6IlKA?=
 =?us-ascii?Q?b1rj3nyDvh77ktAc+jh8rj+mUMUxfVw/XKzgVAJY7VUJV7Xrp70F6qCufwQt?=
 =?us-ascii?Q?bOsBhjWZEUW908ly3kJW31MAyrrKSZ4U/PuAG6CAzgdrAo1TL9JSx5jRz3ij?=
 =?us-ascii?Q?PLFZXjt33A2CvAFEZ8zPyn0dAUqIbgJ80C4TNDiUx24wNbnoH0kw+4iVOTtP?=
 =?us-ascii?Q?c13BfrKEdRhVrmb3jalYm037lt6743u7YtA1WETChWo1awokU6q2H1IXUY0V?=
 =?us-ascii?Q?XaHtfp9fU0HH6tP63ZeL4TbAGndR+8B8z/MOfZ7D0XzjHyF022L32G4Uf1Wl?=
 =?us-ascii?Q?mCLwozC/SDUcNpMTdo/S9nlJQ/nkYNhi7IyNYsz5vfHOrOrHGzecFmLiKe4I?=
 =?us-ascii?Q?uV6Kpx6RijNFhEV30lQ3D/ac4AVzrFaULE9LUI+Y9K+rV4dAmXgb4QH3qSL/?=
 =?us-ascii?Q?7z0FcVnVj234ccyVSExshv343Aznk/klFw6p8WPeuGiup7j1lf3NIi0L4Dq3?=
 =?us-ascii?Q?9sB95BzYrGX/eY+eXRpW6qe0+4Wtjz7rsx/F/aVLJEjFsJT0xHz6jn69eNty?=
 =?us-ascii?Q?vQGZKBlhmtWE35Kr7cJCGNQm2mKX4BYoeggZHtDLHJmiROr7GEnTgIlaaGLT?=
 =?us-ascii?Q?TOmuywio8grfzm0H362Cri8vpaJdBOjYi1js7tvkF121Kdo9iX2snkOQWeok?=
 =?us-ascii?Q?GRT3EmLvTkEUWSsXdE+JgVr/amJkLR5KM2GdjfkmsOhSompWXxH+LeR89KRv?=
 =?us-ascii?Q?wr690UUm1I982nLezHRjPjPvGLjfH2nFzwNRToYEfaSjBSMFVyfEAgKWJJtr?=
 =?us-ascii?Q?1oJjH2aDWJaMANB2FbF1tEfRWOntl56BDjHKQyGEzrypwab8ftZWJH9Y/LdZ?=
 =?us-ascii?Q?Mb8SG8OrUYyXBdK0eMioj2z/vB27PSxwFhFEKu5XcYKiXDcVmkdP27EXvDOI?=
 =?us-ascii?Q?dgyW6Ndhbn6dsJXLZDFapQKUIFPYAh5vZVGGTl9TuKwg4b5AziJDv+ES4qhT?=
 =?us-ascii?Q?t+V6kUXrg9SfOrhOuemJwJcUFKjBtq6ykqDFfI6+OYPQoBMnPe7PCCT6fcDH?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: Js4nItrQXkNh9Zm+hxbdXv5xc98L4l3WTMmfZj8velXCKqbYH+O1YZOTHG1GhnKpAD9qVwQMc8irNf6U44e0sClyyg7WitD6IVaT3/aEy5M9dTHuYGWuBhB8TG+sMURNAtI3GVdpltUlj08Kam8FIQQ0Ej9bk+1OItlexVeFru77ui0CPHkoo9QODfOjO00nok3rNPtRfn+wsxzGu0C9z0y6j/2xnmbtE58N7rYNn18iEpnqVAc4eOSVenEeOp9m2VqDtzwKKg7tSu4Krw2l3Ib0ZisvNpD4hP6PzYcHAu7TNnfUCrG80IEAIKmkJLfltpLZVFVjBSfGZwi4/1GZw+0WlBxSbdK7XKK7dY2tg5s=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4303;6:arSNZyi+rDeCfsw/mkKGAI9VuARUeCqtx8cKLeRKICSfD201MPdP8iIbVz6d0ClUP22icNKoCh32lF9imXAlf1mgncvJeY5Z5672tDYB5Cfv0mPTEWq0w11gQNJ7Cq/s+6HnQqGQQl1hOWJN0sdwXul11rubwP9H3EJBUIaav+cIdWJsVJ9tR8ErbksJDwCwitJXztRFc1Wq3lOiBcHR2LWaMowpq5dSkA/9MMpdD3AX5xD+INbRmwdWKTSwtBHjf/h0s+6l02sknsBJtK/y8VrpK/82mk/IYHeq/HqY2c4aPwF1quMZ+6AGj0GIshHNOkH3Ch/G3YReryg7fTK4CPpCOOqzjj93UEumzrSD8CAVsJhEKzew/JCqMO183hWmhN8+GoMZyc+OP5f0XdmQls64EHMMtURu0utWuwDgY8VWx2kuYd/eBajtyqyUPLjmGpS4WxhW8wiC5FEuYIbbtQ==;5:2tIhCoBurzROA24ioeuENgKIzztS3j92gzxdl9naRb8QSc5HEKylLDFGPAPLJkoqr3Z8l1pF16wVXEDfKoXXcDvuq2+Ty7YmsUgOqnjEpBQZLJzEYSLK5GmVq6/7ctrvqBXewaynTxLwaPDJ1Pza0yBAENKfoOEhG7lK1OPPV+A=;7:vgNM3wwRP01USf8tTvqOo5TrlAMLsdzCCS/dwHq4CeOaw0pP1Gpt4yfYRS2JcnxnwJgX329Id6UFJ5G2o1Bykv5QaTR1r6PpPoDEbiEmBjtLolbEc3jjr9u7KKR4zXk/FMu7HXyR4BbN1g5SYo4x253C5DHHoWk4gIinNCA4tCsvcSIO60aGUUeDwFIUzeG48iMUNpp1njxCjbHyKdwTC5w0iH/VaI/52STQXVZULJK45VSJo7B6KE9ziaMPVNHa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 20:56:34.1173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dae2a30-6572-4fe0-9dea-08d627e06005
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4303
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that mxsfb has functional runtime_pm support we can enable power
gating for the DISPLAY power domain on imx6sx.

Since pci-imx doesn't support runtime power gating this is still
always-on unless PCI is disabled/unused. But it's reasonable for an imx
board to not have PCI.

The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
actually inside the DISPLAY domain. This is handled by adding the pcie
node in both power domains, using multi-pd support.

Series is against linux-next. The last patch needs runtime PM in all
drivers or it will cause hangs. This means Shawn should hold back on it
until the PCI and mxsfb dependencies get merged (both might take a long
time). So you can just review that patch and I will resend it later,
perhaps in another cycle.

Link to mxsfb thread: https://lkml.org/lkml/2018/9/26/1185

Leonard Crestez (3):
  soc: imx: gpc: Increase GPC_CLK_MAX to 7
  PCI: imx: Add multi-pd support
  ARM: dts: imx6sx: Add DISPLAY power domain support

 arch/arm/boot/dts/imx6sx.dtsi         | 19 ++++++++++-
 drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++++++++++++++++
 drivers/soc/imx/gpc.c                 |  2 +-
 3 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.17.1

