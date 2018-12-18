Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C76C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF9C217D9
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k1/3UXpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeLRLDf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:03:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56538 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeLRLDe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Dec 2018 06:03:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBIAnlop032860;
        Tue, 18 Dec 2018 11:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=iuKgje2izKWVKyE6dQp0OCoIPTIieF5lfaeJkZPbkuw=;
 b=k1/3UXpwC6vsYUEc8bzG6uKF6jlL0KM6WvqVGteUk15DUJjJWxU7ZSfp7H7ks/WHczWf
 /L9FbSCCjh92/6JAzqfOGpjY92/qG+2Mi6WYGOGN/YDbxm354naukAGf/Y1nc+nVOQHp
 8zq7uxsbvEP6SimPS8dLtHU5xrWWaMcmSECr/b5r/wnJlkiLDpMlxfDWGA2z2XFH5ufG
 72rD4e5toyf/KNFhNfZc1o8Eo1/tdzcSjsUAoX/+kvWp05UMuQ0YM177ApK9qi9gHf+J
 xXY8vwn1v/Glivazo2grKH4iJ52fJHLMwzCTOIu9mlANScK69St+YAyM//KGQFr+/nLG Kg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2pcs1tjn4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 11:03:04 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBIB3308024713
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 11:03:03 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBIB32Su011331;
        Tue, 18 Dec 2018 11:03:02 GMT
Received: from kadam (/10.175.34.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 03:03:02 -0800
Date:   Tue, 18 Dec 2018 14:03:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: imx: Fix an IS_ERR() vs NULL bug
Message-ID: <20181218110308.GI19692@kadam>
References: <20181218082329.GB440@kadam>
 <20181218105742.GA22156@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218105742.GA22156@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=842
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180097
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 10:57:42AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Dec 18, 2018 at 11:23:29AM +0300, Dan Carpenter wrote:
> > The device_link_add() function doesn't return error pointers, it returns
> > NULL if there is an error.
> > 
> > Fixes: 7a6991159bcd ("PCI: imx: Add multi-pd support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Thanks Dan, if you do not mind I will squash this in the initial
> commit given that it is not upstream yet.
> 

I don't mind at all.  Thanks.

regards,
dan carpenter

