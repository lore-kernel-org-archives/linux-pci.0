Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC4CC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 11:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8AC2133D
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 11:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDKLpM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:45:12 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:50248 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726137AbfDKLpM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 07:45:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0DA4A2C88;
        Thu, 11 Apr 2019 11:45:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: story26_ff98d97b5d1c
X-Filterd-Recvd-Size: 1457
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Apr 2019 11:45:09 +0000 (UTC)
Message-ID: <0702bc9a10703d53a46f27468b2c9ef2463e1c0b.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update remaining @linux.vnet.ibm.com
 addresses
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 11 Apr 2019 04:45:08 -0700
In-Reply-To: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
References: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-04-11 at 06:27 +0200, Lukas Bulwahn wrote:
> Paul McKenney attempted to update all email addresses @linux.vnet.ibm.com
> to @linux.ibm.com in commit 1dfddcdb95c4
> ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com"), but
> some still remained.
> 
> We update the remaining email addresses in MAINTAINERS, hopefully finally
> catching all cases for good.

Perhaps update all the similar addresses in other files too

$ git grep --name-only 'linux\.vnet\.ibm\.com' | wc -l
315

