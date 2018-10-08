Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F39CC6787D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6B220841
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 03:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vkg8J2U/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6B220841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeJHKY6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 06:24:58 -0400
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:4512
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725760AbeJHKY6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 06:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNQXXsxivm5jb1Pgky5dOWVI7CUloCCxgekmVYeeiOg=;
 b=Vkg8J2U/fNTyD99kL3PP/S86aNkDT2SnX26ENCY7TiZ9ULlhD3n8IQhrHqXZTpe8OB/rQa6MLwzHD54E8hrl3pxayehBvb24kAbo4950KGqGWqtNIc3nop+VK5phFKWUnKBgZ2A3lNJPiN84x6rKwvkIx1vTxvwouRSYk2p+ans=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from mega.ap.freescale.net (119.31.174.73) by
 AM3PR04MB1220.eurprd04.prod.outlook.com (2a01:111:e400:586d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.28; Mon, 8 Oct
 2018 03:15:18 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, leoyang.li@nxp.com, shawnguo@kernel.org,
        mark.rutland@arm.com, bhelgaas@google.com, Mingkai.Hu@nxp.com,
        Minghuan.Lian@nxp.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 0/4] dts/layerscape-pci: removed unsuitable compatible string
Date:   Mon,  8 Oct 2018 11:14:24 +0800
Message-Id: <20181008031428.25293-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HK0PR03CA0085.apcprd03.prod.outlook.com
 (2603:1096:203:72::25) To AM3PR04MB1220.eurprd04.prod.outlook.com
 (2a01:111:e400:586d::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca09c294-20ca-43fd-9a06-08d62ccc48cc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1220;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;3:Bb6ktmZqdE2R/+YqMtdvAlcpkgv9u6YBxM1iZIm80f3dhCx1dk1IiBWS5T4ciltft3QrEHQUZ/kw9eB6e9l+aFbcJJ1yywHn5ths7Uwqj1YsZJcqfRKT39Zja0TxdDjyQT015LBOvRo/KzLoQKKv8NQSzTaQh3MCkMQyAleTu+zi7c/2/H4jbWKY2LdneRChkdG02o+HSNHuKTWet77Dpxtm2ZJ/k1SDsStImuhMotoYDvp/QE0awm/oENEk/frK;25:7icfhwF1g2e8e5PqtvDtymjzvWzUi3QZtuXT9gLJHuNT56Dwbf+0nTWE3eBSMksAK6QGo9s0oFLHKz9vuSri8r0fPfsIwX8NbmVKyg/VZsuXQDeCOWpZDuwTEMThS/NVOrOxCXAYdkm9KXRBBCQmeS/xF7CuqdeZsjijN741pSc8Ybs898HmPo00sBOprMfkAhpp7VdwCZPH0NGznvWiCCtM4v1WF4o9G5Km0fs04Pxq9G+PpPrOq/zDIo0Fq2iS2YYIYMn5FcSgnq3821inF01RUOPCredbxOPXSnAlLMcGxVz3TmJxXnA36OWXqq23MPectuuI2Y6mALCZHobgpg==;31:502cSAq9Y/29BEFhYW2PT6a1x95wrCUa39IGbd/JtsVRZ0wITYAxbErPr3IhVDfjqLPWzFA/dqIzVd2LUb0MQStgoX5yEHr2C6nwyPC+iP8zW+NSZQ0sW5xeH9AkProfMM0G7CJtAfP7kW5Wr/dzebygMCR2YuV5/38pFBLXgOGejZMsgPL5XlgQszE84QTmJwN8hmUd8eNgEvDw0Di/5GuPRKLG7iwERPZJryQifnM=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1220:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;20:UBa2ht+09wXU+9RVu/LPlr7sV4l+uozhC47V79fvz3Z/Rt8dDFcwa1MZ4WDoVyQPzt/4azYfshcwmJSduP6vr5GEIBE9diPp4R60qZvQTQ67fYiiq9L3+Iv5oYx7zJNMvNB9EvcNAV3b6qIFsaSwHgmsVl7JszBsfSEw18fjJMjhwbhNtpUHko3tzhxAT5CRdl+I+wsNuRQVtlwXkxPdyHtqJbKmH+hdbTXUwLeepbuexZPhOs3d3Qaf7MFL2gzhUyqfzt0COd1RGSUyCf0DS1WEgqN1bb4mu33nx9Z/t7atbx68SmyuQCSe9LnJT41UlYryEt+Az9HpfkeRclGQOFh4/osf5K5CRG5WBdtj5k4MfXH558Gt2OFern0ZgyYXhYc6XISQtqXdPGd8r4V19Om5WmAyVkFyW5DI8qPTnZoLtKooggikzlhwOV5zDA/zGf/BRzjhTTcVcqVXgFg+TM58tAgnrKFTSEMvC6pPeulAUQk9DcOMPg0LxRqOkFE8;4:rMtLEJgKlPOvsZZ0n2cP3C5mG/QeOF0L/VxRW6BLXs7cEzN5HvJLghZpNWAOugl5u7lZq7e+iZ4G41gIKKsfhCHuRm9FMl2UaE2KJi9ZV6+897oJmlaaRLDyLyRWcS3odJuYNdz4BolV5uoJgtMi88jq3LhGPEY6X9T2CWK8e9YYyggWUFQrHoSXU85AJ833ZHakZHj5wSHMDJYIFJ+hjjBTrlB5D96jD0/qdhAUa3DbDzt+mTsG+Pr/gOOZNuWeVbyBUaQQh3JFUMEzdaQxMHlqrtlkogdVKAZRUKYaobTQgPj0oZi81Z4D3U+M0Pw3
X-Microsoft-Antispam-PRVS: <AM3PR04MB122021C4C221554EA6B97C3084E60@AM3PR04MB1220.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:AM3PR04MB1220;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1220;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(25786009)(16586007)(4326008)(316002)(2616005)(956004)(52116002)(51416003)(476003)(86362001)(48376002)(53936002)(6512007)(486006)(2906002)(68736007)(1076002)(305945005)(7736002)(50466002)(5660300001)(6506007)(36756003)(386003)(50226002)(3846002)(6116002)(97736004)(14444005)(8936002)(478600001)(66066001)(186003)(6486002)(6666003)(16526019)(6636002)(81156014)(106356001)(81166006)(105586002)(8676002)(47776003)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1220;H:mega.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1220;23:Bm7yiV50+QVTyfOXYUAeDZF4gnfDzBpqTD1DCbjYD?=
 =?us-ascii?Q?kv64UQpp8EGa/oxFqKig4W5gEyucLwODIoyS/EF0P3PqlgJpa8RW2+Odw4mB?=
 =?us-ascii?Q?gax2E0HHOLhds/SLj1hXzKnH/+w9UvIMyGEkUFssu18TN+qGMWwfW4A9eXNB?=
 =?us-ascii?Q?DXrVoZ6FCUVBJKiK52s6tsuYe/XwRce0eitcR64MoqrAC1pWgPLjSRrOLbvz?=
 =?us-ascii?Q?ePPiu4dvKRtjTI11VWuRtxNFnKWfUZzTBn0ifuGHoa2CGgb/2yIKvBVANyf8?=
 =?us-ascii?Q?YSPiJbjm0JieozjxOrGdSHqevbtEeBRk0rd1P3l/KaYWBwYZeuZu9tyXgKDi?=
 =?us-ascii?Q?MKY1jJTVO6KIaC/j+wIkXMTf7LH6sR145dgu/jqppxRrxsAJA+YR7FT2AJur?=
 =?us-ascii?Q?e6BayDZwBY/aeTog59GkGEf4I3ohrCjW5p9xvDBljOQb/HOr/gylhORUrT7B?=
 =?us-ascii?Q?c8KvtaBKDlyIJAKyP0sViK7gj2/lVzIa2SccitpQ8wo4kdW8m2MBltYnEGbq?=
 =?us-ascii?Q?IkbY/mI/n92KZjzjoMcpJ/uy41fvkQ1n39Z09kcKUyqLTFjmdUSINJCirDLz?=
 =?us-ascii?Q?zpvisVGt0sNqlFnJAnYuRg+jAImnM+STyzK0C3QLMQxR87fIiThxeUgiX3Zq?=
 =?us-ascii?Q?3v7lo/uA8Ib+nQZA1ZWB9m398kfs0OVze2FUI7l+mYK4oU6IRZSSnnV4YksZ?=
 =?us-ascii?Q?UWvMaU0h994x/cmfWnqwwFfEJLy/XoR+laXgPqQ5joZONiXQSPuudVOqZB+Z?=
 =?us-ascii?Q?zXPZqhaIQbAC8x5XswOB1JLZ+ZDs3NOP9aLvw2+8D6wvfxFY26HlrKtTmQOK?=
 =?us-ascii?Q?Jc5u9kpRcUhhb5QxGzvsWR4Ml2KuXg13fzVrnbQZ3Y1w15GQbJqsVPL0+MIE?=
 =?us-ascii?Q?3nq5pZYT3gEEi1YyMs2WYTlKJNcj1T91qzh9DdzfEiXCISXOt9+4kEUdQSCQ?=
 =?us-ascii?Q?ajBhsElciVx7IdnxpfqFCWIHf+POl918DHQEAf4Wd0MAmdhvxs85AyOa+TJn?=
 =?us-ascii?Q?6n6K1KvWaZiThfs3qXc592r7ddo+bMc972+12Pn5nGkpzZj1zxHG1LDofE3M?=
 =?us-ascii?Q?Jd5G723Gwo/q4sASa0pp3mpjk4DJplobbjWY4+z9nJC9D39H/bGxFIlbLAcg?=
 =?us-ascii?Q?bwOzlz1f/1Q6/mnSC+nLQAXEojefq3/TW/6xcBkleGikXi7b7AUmuTmvcETG?=
 =?us-ascii?Q?XNSER2kK8Nq53w=3D?=
X-Microsoft-Antispam-Message-Info: YPgwO/2zU/q9sq6/NY3xetn65Dc8QRJk6Fuy0rFyW1N5o0u7bu1zF7pmiuF8xkbNJvQfnGpVhUyHLjrneNg8C+Gy+ZNwjegj1Ufkl6e69iiciqY3XZus9WIFDkq6EB9ewPSXJEY7pOfjHBFmx4fvx95rw2Nx6sZki2dKg3xzeDfPmS6vzzG6h7q80rzUeTNTxIZBxB/ww2htl9SghpYn6jTvUTezAfInJGvk0FoBiXpr8g+guhIi0OkziSxxocB9bHE0pklPG/gO+hW7AUxoY8aWZptaSE9hdKs30uYT2TbWAnduRNh5sxB/MeBsDzxAhShEVTwofSlRG/STgtSf9CiZZ67AsLaX6a/xjrHWLd8=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1220;6:B7yqWMZHNKhXMIELMe3eGTjLduLpwGmHPicMbC+cnOHjb5OofIRH9j5k8JVmrn6jzv6MmFmdpyada0SXB+iG08BRT8+anTaJSvryLT8H4/LKzBSOYnn4ANW2SMZ4cw92kWazuo53X+fhAalHYW5+OBryvkdCoRZjlOTmGfqxQZS6Ydxu53QCq+9MDhNM6i+88Mle5OZLYg4JK6FGp3z/QnJVnH07qjoy8vWL0KRb37IjrSit1tXqNN67yUxp3K3HhNqNHJDvU05s/4n6hc87RIouHVFvweHP3vhC/3fRaI5LeBhnVbOJHUDtc73nX4ZHH+w2y2qTe9xf6BB8paUbFsun8l8cylhwc7jm7HTVFJvwkIE/zbPw6UWe6lCkM0oRE9c1h9J5NdLGYlgqLANmkyRDzCq+Q8Riotc9oENXbbFeTLwk2hJ4q5rppTcGoE8/teMs8vIsigmr9Pa5iurjDw==;5:Oevh0Uj22L3ubGwLbEcwCgYRMwrxd9IvokBYsVrfF1WI9FQjg4CiIvDh0uSBQUPy0fBnm8vszPQXC7Ns4tjoQf8ew/htA9rlWlTjr2kfktXrzAKvMl2yK+Xu9cxs1LXffUWvk4QjReOulNSjxWNI/88bIvCaHFVBioYmQNyMkBc=;7:0jE5OHcg1U29CHe24DDkdXf2D3xBk2YxBvJ8AlPzKEzY/tNzBV5WhulljO6sicR3Qxyf74op9uuQasVNrlSLIi2kEN/YU+oe446R2ihqD15z18B6Wj7WbI+zaB2AoZLpvB/4oShp2++CuxlAOSaHjSWcdLN3SlJQmL9G3MlIMKTMiY7vEsm8hHp7ZCvkd59rfbTgh30hwPBfNxMRLpnXllG32MI00eKHnofnQZTNFb6LEfT5kSJeshgOZgdxjlm8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 03:15:18.7421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca09c294-20ca-43fd-9a06-08d62ccc48cc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1220
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Removed the compatible string "snps,dw-pcie" from FSL layerscape-pci compatible
string list.

Hou Zhiqiang (4):
  doc/layerscape-pci: update the PCIe compatible strings
  doc/layerscape-pci: removed unsuitable compatible string
  dts/arm/ls1021a: Clean PCIe controller compatible strings
  dts/arm64/layerscape: Clean PCIe controller compatible strings

 .../devicetree/bindings/pci/layerscape-pci.txt       |  7 ++++---
 arch/arm/boot/dts/ls1021a.dtsi                       |  4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi       |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi       |  6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi       |  8 ++++----
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi       | 12 ++++--------
 8 files changed, 24 insertions(+), 27 deletions(-)

-- 
2.17.1

