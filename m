Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A47ECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 15:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E8E20833
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 15:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gM+6TsEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E8E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbeITVM0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:12:26 -0400
Received: from mail-eopbgr50052.outbound.protection.outlook.com ([40.107.5.52]:41232
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732555AbeITVM0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 17:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lTudLZbkVMajJvMhyPz1cB0NpoeVyxveh8++JUyKRg=;
 b=gM+6TsEGMBTC+lXYZ61YZ4H/mgw321xmMn0pSUJpZJsTc3+BDsQmOmXnoLNdzpUWVUTkFSdaeA9SKC3AhgBf2K0ZTOKj8IS6sz3BvIQjU4NtKqoQxy9tOVL9aTHAM6HMsQ67NV8jAc9CRnk3tioUFpAwOWEsZynzq1iHfdDht7c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Lorenzo.Pieralisi@arm.com; 
Received: from e107981-ln.cambridge.arm.com (217.140.106.50) by
 AM4PR0802MB2179.eurprd08.prod.outlook.com (2603:10a6:200:5d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Thu, 20 Sep
 2018 15:28:21 +0000
Date:   Thu, 20 Sep 2018 16:28:19 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Fix return value check in hv_pci_assign_slots()
Message-ID: <20180920152819.GF838@e107981-ln.cambridge.arm.com>
References: <1537425631-28460-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537425631-28460-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.106.50]
X-ClientProxiedBy: CWLP265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::34) To AM4PR0802MB2179.eurprd08.prod.outlook.com
 (2603:10a6:200:5d::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf79494b-33d2-4b6a-67b6-08d61f0db319
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0802MB2179;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0802MB2179;3:5qj6zlijIeoP1dtKK8YszgZ02+bWZ5162gQweeBnP2EfSTuXdlwcstVd+JvLmcG/alkIYVJNhDwG3hQDtsXxrePBuzVdJHDGG7zYYi4Ho2QsrmEghZpDJTMWiZ2O8xn2DfMaAR9/isHH+yDYKpPmg+Rg10deEKTMKN6uD5R1SI4WDNOWKrw698eOWYYYKh07Y2FWZY63MbmvTBRZ03NpsbIkfVVRdK41xNCTt6Kzvn067yfHXZCj5RHX0k7Loq95;25:39qvZimhqA/sdVuCR9DUFG0DRTQoxldIJfgknr92DipCmlkXUjV776mahFzbw1GTWd3fZo0ULVMPH7v0IMHoOQSY/Dg4D4KXtERPrTJ17nZ/vUt9+ZPshOA/ApzUBbWSc3EM574rhEk5iD1spjTstjHAUTmYfoDm3M2XgWSB/HYbQyHgEIynqygVYte1J3LhEyb7xOosYBf/XEoQ5W2ylSiDAv04gTdA0OWT79MSosEqInZAENU0QaLOv2vJuAwPrBB3GHGQS5yvITFvdhAnx1ax6/XmtZVjjTBOY+6drDmzeUTNbprX4izjnYbuBwF5S7WAav1ijdc/+oiIUTbzzw==;31:+z6AoiDdm/GuCxxfPjXAiLDpO3amqTcKewVQBZZMX54mgQdbx/MS0cASVPj3pXlKJ8GmZZSpJk2kCKos5rJ+8ZSk7hfCwhjgwSdDyS9Wgi+OPhuFa2oYFFmpX7E+mJyx/+3HGNZAUIY/PmoXMR4YfsxVUClqEGpdAHeo45lb4WziZCk6JlP/Ch0FgtKGPNSZR3EG8eR4hkZNbWgZfzMie1+YNO0qnQfHEi+Mnka2veE=
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2179:
Content-Transfer-Encoding: quoted-printable
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0802MB2179;20:PkBsjmr8EL+mxSCSqleFL7ri9dEXMUXI6wjVSrQgCubsNTz6/pHxMsQO2tTfCRJbUvdUMbdLx8aRiPPPmztLWF6cgxPNHhK9nXSMyehwftbRCJjjQq24Lm8+t9Gm4khRulRoWTgLX++PjrFmdKae90fwSFqMcftVs81i+q23+InOdga9+5xl6sSDFd/1B93xeJnVwvd3TTaJQ8aeYUXsFkiU7i6ostgX4Dwh/iKrkr5xqWqTcZJPazYzdzXH0VunYrUvQ5JM+IieW9MSKKFneYctYYwC88/qlbG25P1gsOzadfIgou2ho1K63atp9p/aix97PopbKafKEo9YjOln/9qWTseW6i5QDx67Z6zMQ3K1jV1WPH7oVabvI294eBpBAHYyWHo6+1sSdu0z/bvUzEbYK5Popaj0a8umpHXDT2FFkrIhIecgY4fiaUIc81t6gzwEWSS6sYtdcthD3j7Jy7Sp1FmE3CHdfj8gPzeurS12qN/xo2lMtYVKFipRTQaZ;4:BSP7KWdD8rYjNFImiArHKGQwlT12pQkiLF6U9OTQG+yTG5+ucldI0j3UMwP9GXcb95ghG1wmHQc7lJrl3CAxDSSkvM8lxNvRxSZtwl6PhI5ZctZ9sBm3nFjSfn+njoUmBP8n52tHwbGnLCHPtMELSbgiRxzyL/bRgkAHEuV++0J96XkmuL9BwtUJDDPh2bTXVhXacJ0mMg+krKuKD3KZyZFSVnMsCVDd+RWyxdLuFFO45X0QSU56fBhlKIkiTIE+XikZ0kSt49MAvfbEvkwbp9XKX6cu0xLSCok8K9fhEzJCOvUj4qBImZCW8S/qdtrSqV0pEASp60xICiG/qquDFRabalNxoT0dtOPTMA2B2AI=
X-Microsoft-Antispam-PRVS: <AM4PR0802MB2179301D627DE9B01CA8995CFA130@AM4PR0802MB2179.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:AM4PR0802MB2179;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0802MB2179;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(39860400002)(376002)(199004)(189003)(40224003)(69234005)(40434004)(3846002)(7736002)(16526019)(26005)(44832011)(72206003)(68736007)(33656002)(54906003)(186003)(81166006)(7416002)(58126008)(66066001)(6116002)(305945005)(8676002)(8936002)(476003)(8746002)(956004)(106356001)(11346002)(50466002)(478600001)(486006)(6246003)(23726003)(446003)(105586002)(81156014)(5024004)(6916009)(1076002)(97736004)(14444005)(2906002)(5660300001)(229853002)(55016002)(316002)(386003)(76176011)(7696005)(86362001)(53936002)(52116002)(47776003)(4326008)(25786009)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2179;H:e107981-ln.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0802MB2179;23:/bjarGmIPhLJTxus0jeLXHurhmxT5wuR8X3e80B?=
 =?us-ascii?Q?6E9LgMoZkV0vwzrmxjp3BKSf8mOAl3xSYtMcZs9DoNB+nRWBxgiaF8HDc7aZ?=
 =?us-ascii?Q?pwJwqKU1D9MfsC7/tBXGHj5aWovFQKk49NGHfkYe/EaVDmWWfp3J+JGMnKku?=
 =?us-ascii?Q?lkpE6dyjeBhvzwYLfukgS6AR31mJypb4WA6TzKQBC1P1mccETuK0RcthjTMX?=
 =?us-ascii?Q?WJIZltkyvfCtXPo9eES9zf+rAHqwFm+er2XoCrJZ/Y0HMjIle8QHbUkTRNHD?=
 =?us-ascii?Q?eBHkyPgpBC225Id9wFNo/BQS+05uqZ2HPMZVYEfAuLl05ARuRC6h2lLtBwMa?=
 =?us-ascii?Q?vVP/qs5xKBm5BeKU+SYNaFfk3IO8cylG/3KNVe53g5vXZTvunNcfWGdsqGr+?=
 =?us-ascii?Q?ZwZW9SaP/UDsQMnfYhRTVCstSnlSyv07vYfmCJMe8DoFsDIrmFvooBm98DkX?=
 =?us-ascii?Q?8ZbJmb8t+auDRpWOTLCNY6N52YCR+n33ZohU+tJ3L4FGXNX2J6OF8b84qgzr?=
 =?us-ascii?Q?JUa6Q5j3qru0mgHooyurmqL+lEe9DpFf33ECWvL6QyPUtFOF7QWVuLIDoSom?=
 =?us-ascii?Q?qndLAiYYxNU5XFXE1izSCpO19kAXgiZLcWh4Q+Yi1xe1APfdM9dMtvQhGBng?=
 =?us-ascii?Q?5edRekafSrsZ8hVDI1WvMdXUe3nJExzvmIype/fg7zwVoyyaim2cNT4WF96F?=
 =?us-ascii?Q?UardOcHAQMUp95aeIPxMeMjOR4zfScbpGILqdEX4nSM1FjZCMglj/p8WunJl?=
 =?us-ascii?Q?UFzarxKLPvXH/qNwDscTPEgXOI4E8JsNSL892/Pp0ss8Ln0OF2HFbTHtyktT?=
 =?us-ascii?Q?FDOJk6plAXRsjpU1izPUp+Z7r+iTPsylighOkZVcu41l+csXw09tICVCPdJu?=
 =?us-ascii?Q?o45oyb0OWdXtguRbrKsJ0sR1bV5pox2vC3prIKWg22EiQBeWCrQPjBsHbC9H?=
 =?us-ascii?Q?9hVXDtKRWA+aFrxLC9OwcHjoMk+tul5QjJB7KjCttFkKCPBRUZW/vfT85Ogd?=
 =?us-ascii?Q?N3Rigw+1Q4EaHPb8s8DCzQJ9Waoh/kTpFdEQ/Qtnlire3Y5M0hWZ32eGBSN4?=
 =?us-ascii?Q?9tG0zbRw8+SKLG6ZAuzafcqy/VNZwXD4/CkfgERo3jKFS2nqu45i+IgUa+K7?=
 =?us-ascii?Q?c2jxubT0Lj0xEfAfhj6g3JbRsfl5Wfsrh87OOZ4GjjgdSbkb9LrkBWhbifmU?=
 =?us-ascii?Q?HTd6RoEN9P0iISh42Z1JbWm0gYmgbtm8ypQfL7OiY/3jRWz1DQhJbgiWwYil?=
 =?us-ascii?Q?CVGfj+g/zxfg2kuQuG8J4MsBCZjuexH39xlhAxyv5nH8aZ9KFqZOJL3mNZXh?=
 =?us-ascii?Q?R6tT5hXwK9qnP5tUulIF5OAJeZ8MzafsuzHu67aZmveoxXfJA6osWyGjFj8L?=
 =?us-ascii?Q?3LY60GA=3D=3D?=
X-Microsoft-Antispam-Message-Info: ZiqFCtWPmDhM3UxBhCgBZf3VZ88HiOj7oFQsuhJj++FAIB5BM6TzXeVlHWthziReAFShfSNc7qnLd4B0IY4Mjrv439M6t1E1zToRH1HrJQSSmGWlueZTqlRmLLQc9Q81sMND6OLkEeuSfNZp0Sqai1FvcUlnfN9Ywu8d5QVoaFtOHd6tnZjoOR4dn7RSMCTq3EHRIURDx7cJcu4FEqP8LONjRwiP/0V24KnxCw3ANRMvG1zSFDr6kH89symx8UCG5x32VabxOnIIjRjUiQdIezTO8K3cXS5p5cOFxxI64LLkbRbAvcGNwyKCxnlDmMwHCpSn8gchWKonpwp3A2Xg8ii6iyAXV53p5iB0/LPKOGY=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0802MB2179;6:z8LLhaqn9DfVaOc7s8hdGLkdXmshbhAzS5mYxz1Iu2cdhYPP76vYzRHzrtC/bBXMvzpoomPOrR8EwHJ1ol7n5glKaPhBJTQ2YO3ilzf6BFJ6+/wU3OspIvfQIpJM1dJX1t18kb2wrgaX1w6dnwByFpL02fV0N2wbTpxUvkqn+AIQe1cc3NValDSAzyezj7K67Mokjmqtuo+MKvCDkZtyCZrN7oUuEGQCKIOjDRMyzHOSDpS2qhATT+GDUlnznI4Hlo5yHmI95O0gnDVXGmcNdvdnL+IdOlLb+gdX4ywfXLxPb8b5FHvHL8wZ1OajXwfRS/jz3pWP9C3WM55Z2F5GJVEVm6bhuwUIOjdnifpnnEqLS/FbY/+7SGytgoKThSqcAhOAc7QRsz/jQg+twiJGnP0C74kGpQmDpO6p7enlhW8qtSahKmHrH2JY4h1OQTsrQfmbNSwBZ15Ke1TF4U1DpQ==;5:3U3SvA2M8Ie3dXrDzk8g8qcfNj7hTRcPDqYI84y71Drel7+iYsutCtbVr93z7v9Clh8M6MGM6U0Tbj6tjYnuZl/72plijZ4WSFHqBIfiS+rNW4AULycDdndgWxaBq4qcqWqQM5QoPFxEBwMMD5pG+6WG8moBJMHzj2IVQGYucxw=;7:jfIw0WhrIk2S6nohemA7rDZnKv3WlwvzxEkYObo35r8TnnrjLCD3BbFCzMYcwWjRTui5w5TP7fMXdQ4sbbxo/IMVWTIAlMfUpeWuZn+80RjclJRrqCU4ynbfnejPK64Vb/kgBBuHhjYHEKI13r43DxbZKwtj4a/lNLPe0vYotMOFkJI5WuqH3GZs58hVTZmw2hPLPeDLrtOPNix8qI6WLN37VhstltUTUaSY4IGyHeydmDD6+UJxfkWHPjx2TOVr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 15:28:21.6826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf79494b-33d2-4b6a-67b6-08d61f0db319
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2179
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+DaveM, netdev]

On Thu, Sep 20, 2018 at 06:40:31AM +0000, Wei Yongjun wrote:
> In case of error, the function pci_create_slot() returns ERR_PTR() and
> never returns NULL. The NULL test in the return value check should be
> replaced with IS_ERR().
>
> Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot in=
formation")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index ee80e79..9ba4d12 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1484,8 +1484,10 @@ static void hv_pci_assign_slots(struct hv_pcibus_d=
evice *hbus)
>               snprintf(name, SLOT_NAME_SIZE, "%u", hpdev->desc.ser);
>               hpdev->pci_slot =3D pci_create_slot(hbus->pci_bus, slot_nr,
>                                         name, NULL);
> -             if (!hpdev->pci_slot)
> +             if (IS_ERR(hpdev->pci_slot)) {
>                       pr_warn("pci_create slot %s failed\n", name);
> +                     hpdev->pci_slot =3D NULL;
> +             }
>       }
>  }
>

FYI

I am dropping this patch from the PCI queue since the original series
is now queued in net-next.

Lorenzo
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
