Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D5C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7CC217D9
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 11:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YZQUiSzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbeLRLDN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:03:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56166 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeLRLDM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Dec 2018 06:03:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBIAnOPg187667;
        Tue, 18 Dec 2018 11:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=F8lqsMrDytiaH/ZEVRUBEd+G6Pm0T/HUYVD2Frwil+k=;
 b=YZQUiSzg/B/FewIVD3d94xh/khPuv3XmCIsMVtGBd84+PcE9t/VxmvN7UemE26U8eioi
 /kvWc636OMjC1LK6Iba0r+hSdZKLQAkQLwJZR+MfuNpP40aQP4bUX7Au3VWyyrrQ69+l
 Ep7lJsHMTytciWh+fXk7Vy2eY96oRwVlmmVmjnz9hGgV3J3JatRaqVTVKnVN0B7B9mMl
 584oa4Y/51hR5eSPblhDurXCRP4Edn68eIKolweethPK6aboPORII+9Rl/wv9HdU0LU3
 sLr2BKQDvPW6TxfCxKHDELpPqHvjlst4EXH8Iiam8XWGbe/cnrsQvR3h+7XJ4JiUxZHz OQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2pct8qthet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 11:02:41 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBIB2epN003762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 11:02:40 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBIB2eEl030373;
        Tue, 18 Dec 2018 11:02:40 GMT
Received: from kadam (/10.175.34.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 03:02:40 -0800
Date:   Tue, 18 Dec 2018 14:02:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] PCI: imx: Fix an IS_ERR() vs NULL bug
Message-ID: <20181218110245.GH19692@kadam>
References: <20181218082329.GB440@kadam>
 <9ba5927dd322732b73f1fa0852ec20fdf918ba7b.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba5927dd322732b73f1fa0852ec20fdf918ba7b.camel@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9110 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180097
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 08:54:36AM +0000, Leonard Crestez wrote:
> On Tue, 2018-12-18 at 11:23 +0300, Dan Carpenter wrote:
> > The device_link_add() function doesn't return error pointers, it returns
> > NULL if there is an error.
> > 
> > Fixes: 7a6991159bcd ("PCI: imx: Add multi-pd support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
> 
> I assume this was found with a static checker?

It's an unpublished Smatch check...  It complains about running IS_ERR()
on things which aren't an error pointer.  The problem is that that
happens all the time intentionally so i haven't published it.  I should
probably make a version which only complains if it is an assignment from
a function that returns NULL.

(Even then it's problematic because it can depend on the .config)

regards,
dan carpenter
