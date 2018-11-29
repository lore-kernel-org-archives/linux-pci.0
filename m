Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF180C43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 12:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8F1205C9
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 12:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U6Cja+0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8F1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeK2X0x (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 18:26:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35112 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeK2X0x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 18:26:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATCIxkM162052;
        Thu, 29 Nov 2018 12:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=AFjw7fba25Nf7rHkCrrAVTagUz0zXPAeYPiGn97bCqU=;
 b=U6Cja+0X/Z5vZaB/ktSssT9xgMwAAA+rYOBywkAFObE2VMeY3cuZnYfCEgwaWADx0Nkz
 EdX9mulsDOe8agxv5s8J9AIOjYFddrWNQqeOx6JanyQ5lD8LNIFJLnncp5LC3Y9Hxr1K
 6mAG6t8MC+s/H0rVAY7mlAyOZaV1GhznIyLmn/Xth24JpuNqpdd+ZSXiwuZ6mfuzDn52
 wIWkjo+V/9qeeTnKpIJRVlkPUJqMh+ch7f/k6LDfce035bxPiROL3elf0H3t1B4J/gpe
 EKQLiP7puD5W/aILEhMmPGZRYfHZ7cDCXQhAp3dej2iHP/njr2tR6IQVjhsHwBUeT/nz Aw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nxx2ufwb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 12:20:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wATCKtm7013370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 12:20:55 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wATCKpuC002202;
        Thu, 29 Nov 2018 12:20:51 GMT
Received: from unbuntlaptop (/197.157.34.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 04:20:51 -0800
Date:   Thu, 29 Nov 2018 15:20:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hanjie Lin <hanjie.lin@amlogic.com>
Cc:     kbuild@01.org, kbuild-all@01.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@amlogic.com>,
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
Message-ID: <20181129122032.GS3073@unbuntlaptop>
References: <20181129090340.GO3073@unbuntlaptop>
 <6da0ecdc-47e6-960e-c84e-2eb30632c317@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6da0ecdc-47e6-960e-c84e-2eb30632c317@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9091 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=740
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290106
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 29, 2018 at 08:08:57PM +0800, Hanjie Lin wrote:
> Yes, it's really a silly mistake. 

No one gets annoyed about typos.  We're all human and we make mistakes.

(This was going to an uplifting email, but then I had to mention that
what does make people annoyed is OS abstraction layers.  People try to
use the same driver on both linux and windows.  Absolute madness!)

regards,
dan carpenter

