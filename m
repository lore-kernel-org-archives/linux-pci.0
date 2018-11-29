Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE381C43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 09:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828C9205C9
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 09:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jFX9I/Bn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828C9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeK2UJo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:09:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34956 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeK2UJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 15:09:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAT8xNBb000836;
        Thu, 29 Nov 2018 09:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2018-07-02; bh=BSuLx5LjNSkayjfJEBeeB4vpBjbY2AdbwGMwOUrmzYs=;
 b=jFX9I/BnCp3eaT3w+4cN6eRkcAGnxnE/pnKOadWXCwSJ4HiAN79BJizXtRfukm+qxatn
 yOUg1st9P3zYXyorO6ONPQtCq5TkHZMF0F8xygC/lLqMU8bUV5+LS389WkhiZz8swFXm
 Kjj9/rIXY1b8Rk2edXS8Q33qvnX4jeVi2dAbEdrJ5N3V+WkzQYHSBjzWgTHcEpa7fwOk
 hu8ZdjT3TJaxl6rPNp6ae67YexY+x8qM2jcx0eRMSr87akIK1HOgqeXDnO5/xyypLHST
 3IjoZDIGQBNOrlTbLvG+iodPN5WJMqKSFbr04LlGyE9ShXKiAamGgnNSuJnG+PkAAQS9 mA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nxx2ueyap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 09:04:02 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAT93x8a010078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 09:04:00 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAT93uL3003235;
        Thu, 29 Nov 2018 09:03:56 GMT
Received: from unbuntlaptop (/197.157.34.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 01:03:55 -0800
Date:   Thu, 29 Nov 2018 12:03:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Hanjie Lin <hanjie.lin@amlogic.com>
Cc:     kbuild-all@01.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>
Subject: Re: [PATCH v6 2/2] PCI: amlogic: Add the Amlogic Meson PCIe
 controller driver
Message-ID: <20181129090340.GO3073@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542876836-191355-3-git-send-email-hanjie.lin@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290079
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yue,

url:    https://github.com/0day-ci/linux/commits/Hanjie-Lin/dt-bindings-PCI-meson-add-DT-bindings-for-Amlogic-Meson-PCIe-controller/20181122-225955
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next

smatch warnings:
drivers/pci/controller/dwc/pci-meson.c:171 meson_pcie_get_mem_shared() error: passing non negative 6 to ERR_PTR

# https://github.com/0day-ci/linux/commit/c882cdc75e49b6de65cd3d95ebf688272af6b5f9
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout c882cdc75e49b6de65cd3d95ebf688272af6b5f9
vim +171 drivers/pci/controller/dwc/pci-meson.c

c882cdc75 Yue Wang 2018-11-22  160  
c882cdc75 Yue Wang 2018-11-22  161  static void __iomem *meson_pcie_get_mem_shared(struct platform_device *pdev,
c882cdc75 Yue Wang 2018-11-22  162  					       struct meson_pcie *mp,
c882cdc75 Yue Wang 2018-11-22  163  					       const char *id)
c882cdc75 Yue Wang 2018-11-22  164  {
c882cdc75 Yue Wang 2018-11-22  165  	struct device *dev = mp->pci.dev;
c882cdc75 Yue Wang 2018-11-22  166  	struct resource *res;
c882cdc75 Yue Wang 2018-11-22  167  
c882cdc75 Yue Wang 2018-11-22  168  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, id);
c882cdc75 Yue Wang 2018-11-22  169  	if (!res) {
c882cdc75 Yue Wang 2018-11-22  170  		dev_err(dev, "No REG resource %s\n", id);
c882cdc75 Yue Wang 2018-11-22 @171  		return ERR_PTR(ENXIO);
                                                               ^^^^^
                                                               -ENXIO

c882cdc75 Yue Wang 2018-11-22  172  	}
c882cdc75 Yue Wang 2018-11-22  173  
c882cdc75 Yue Wang 2018-11-22  174  	return devm_ioremap(dev, res->start, resource_size(res));
c882cdc75 Yue Wang 2018-11-22  175  }
c882cdc75 Yue Wang 2018-11-22  176  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
