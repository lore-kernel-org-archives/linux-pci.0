Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE632C2F3B8
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 13:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9347720870
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 13:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rbdXZ/Km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfAUNUO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:20:14 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50316 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfAUNUO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 08:20:14 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0LDJOqj196465;
        Mon, 21 Jan 2019 13:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6o0yPlT1lwAkGjTg/hifyvWqMRhV8PQmtYQu5qXlFt0=;
 b=rbdXZ/Km5btZOxNA/CClRvC0wTDYbgYlZeOjwDTOPwBZo7tuQu3A0BJE5fesfRbVzEji
 FVMfXN++62S2i4ZEUaGfLuyLBZNLRYG0hq9CJ6q6i9YDIWQTFTi7emiBOErElhmurhYe
 OPxFnitYtEk/OZsfJpc5N+lXf6D31fOZkSJIGuiAul7yOnyTxFg9jF8oZhTPrrpC8/tP
 IqDpX2EaL1o66RgqztOqSy9O5R/I5Q7et7o3kt3naFGcn7/6vIZi2169+/mqCFH/QMGA
 9yfHtltReBNX9u6WIezEXnXvhR4xP+GsgOOo0Eiu91EhmUIgbHrsf4u1rXeD4itVnHkv ow== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2q3sde6w3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jan 2019 13:20:06 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0LDK6qw030082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jan 2019 13:20:06 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0LDK5cD022094;
        Mon, 21 Jan 2019 13:20:05 GMT
Received: from kadam (/197.157.0.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jan 2019 05:20:04 -0800
Date:   Mon, 21 Jan 2019 16:19:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org
Subject: Re: [PATCH 1/3] PCI: hv: Allocate physically contiguous hypercall
 params buffer
Message-ID: <20190121131942.GH4482@kadam>
References: <1547758038-5255-1-git-send-email-akaher@vmware.com>
 <1547758038-5255-2-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547758038-5255-2-git-send-email-akaher@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9142 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=989
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901210105
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 18, 2019 at 02:17:16AM +0530, Ajay Kaher wrote:
> hv_do_hypercall() assumes that we pass a segment from a physically
> contiguous buffer.  A buffer allocated on the stack may not work if
> CONFIG_VMAP_STACK=y is set.
> 
> Use kmalloc() to allocate this buffer.
> 

Since you're going to need to resend this anyway, can you add in the
commit message what this looks like from a user perspective?  Presumably
it's an occasional crash?

regards,
dan carpenter

