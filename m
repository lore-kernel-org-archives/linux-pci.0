Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE776C2F3BE
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 13:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE082085A
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 13:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pE1RYGpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfAUNg7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:36:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56854 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfAUNg6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 08:36:58 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0LDSwbE023703;
        Mon, 21 Jan 2019 13:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=VeapZkuR0cIdLclyZaeUTkTP3ZAnzxD9j4NtyBXQXWI=;
 b=pE1RYGpYMJf6wr7Ley2UOIFQJsSLmk+bHdodQMPIlR7mLEQrEAq2tUyFN3j7hnftHiMt
 lJTY67R8iYsJrFO+Hcq8mvJTzi8SUJXoU53nhBym19AxWZ45P0T6KYXCalSDwZkTlq4y
 uSobxWtkY6wbLMMyBdnOQXRXwMmhuurR6DMOQP65po2VpfOOPlOvvQhkyZrBurNK0UJA
 3X1k7fDmJnUQdWQi0KxEXU62tzVPrMi55EBViIbj7Wj4cdcrs7RBEihs1jGnShl2Y27Z
 wplnb9G8fXTeyfSOSSfLKNjYuS1BY0TrPOrwhaPyBBiG8FOwRnFYB9V/9yjjxTJlIZSu xw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2q3vhrep9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jan 2019 13:36:51 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0LDaoHE011808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jan 2019 13:36:50 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0LDanmL022836;
        Mon, 21 Jan 2019 13:36:50 GMT
Received: from kadam (/197.157.34.164)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jan 2019 05:36:49 -0800
Date:   Mon, 21 Jan 2019 16:36:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     linux-pci@vger.kernel.org, haiyangz@microsoft.com,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org
Subject: Re: [PATCH 1/3] PCI: hv: Allocate physically contiguous hypercall
 params buffer
Message-ID: <20190121133628.GI4482@kadam>
References: <1547758038-5255-1-git-send-email-akaher@vmware.com>
 <1547758038-5255-2-git-send-email-akaher@vmware.com>
 <20190121131942.GH4482@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121131942.GH4482@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9142 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=963
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901210107
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 21, 2019 at 04:19:42PM +0300, Dan Carpenter wrote:
> On Fri, Jan 18, 2019 at 02:17:16AM +0530, Ajay Kaher wrote:
> > hv_do_hypercall() assumes that we pass a segment from a physically
> > contiguous buffer.  A buffer allocated on the stack may not work if
> > CONFIG_VMAP_STACK=y is set.
> > 
> > Use kmalloc() to allocate this buffer.
> > 
> 
> Since you're going to need to resend this anyway, can you add in the
> commit message what this looks like from a user perspective?  Presumably
> it's an occasional crash?
> 

Never mind.  I didn't realize this was a two year old patch.

regards,
dan carpenter

