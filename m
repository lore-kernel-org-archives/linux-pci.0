Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADA3ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA79214C3
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V8OF3VFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA79214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeJQQke (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:40:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55684 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbeJQQkd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 12:40:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9H8i018099754;
        Wed, 17 Oct 2018 08:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=p1ZH1FzQOD9KGrRoQ7Ypniu1T5clRu635OJnee/nSRY=;
 b=V8OF3VFfJQ6zbdz2U0bJKtZyshsp+qH7tcRGablssHHk9Kvr276+2s1sirJnjl9jIVXg
 f3dwjV2lVURBDx2u4rdoeJ/9jAM+5+Fl4Al5GLNiJw6NTnFT1R/Ul/elWqq5HVjmDhlG
 qwQlTJf1tUTDyUcSQmQVMa4A6BCRzVwKs2P8jMr9Ov3Ikw04LjLxHadq1kj7PUI115I3
 JgDR2xLrr8jscvKMPxKZBRbynV6DwjIsAJRanjlzN6O5eQ0Ms7mhxrLwbEtUcwjmg2ym
 TBUTEAxaK8EVW/KYHQheplGk4ID13jgQ7DBmPUZOu9AK5ngoBA8kXEQqPv2kSi8mqVdy PQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n384u5pr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 08:45:47 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9H8jjWo030214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 08:45:46 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9H8jjAl006087;
        Wed, 17 Oct 2018 08:45:45 GMT
Received: from kili.mountain (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Oct 2018 01:45:44 -0700
Date:   Wed, 17 Oct 2018 11:45:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     logang@deltatee.com
Cc:     linux-pci@vger.kernel.org
Subject: [bug report] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20181017084529.hizjk6bdxsgpuvn5@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=449
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810170079
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Logan Gunthorpe,

This is a semi-automatic email about new static checker warnings.

The patch 31fd98513249: "PCI/P2PDMA: Support peer-to-peer memory" 
from Oct 4, 2018, leads to the following Smatch complaint:

    drivers/pci/p2pdma.c:684 pci_p2pmem_publish()
     error: we previously assumed 'pdev->p2pdma' could be null (see line 681)

drivers/pci/p2pdma.c
   680	{
   681		if (publish && !pdev->p2pdma)
                    ^^^^^^^^^^^^^^^^^^^^^^^^

It feels like this should just be:

		if (!pdev->p2pdma)

In other words, I don't understand why we are testing "publish"...

   682			return;
   683	
   684		pdev->p2pdma->p2pmem_published = publish;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   685	}
   686	EXPORT_SYMBOL_GPL(pci_p2pmem_publish);

regards,
dan carpenter
