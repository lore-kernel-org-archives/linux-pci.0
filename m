Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31A9C10F14
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 16:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE7420850
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 16:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfDLQQ1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:16:27 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:41465 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726624AbfDLQQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 12:16:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 4B9251801922E;
        Fri, 12 Apr 2019 16:16:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sugar26_71814fc27bc2a
X-Filterd-Recvd-Size: 1525
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 12 Apr 2019 16:16:19 +0000 (UTC)
Message-ID: <08ef1432f9c1906234132abc9ab449f7f08b6cd8.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update remaining @linux.vnet.ibm.com
 addresses
From:   Joe Perches <joe@perches.com>
To:     paulmck@linux.ibm.com
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Josh Boyer <jwboyer@kernel.org>
Date:   Fri, 12 Apr 2019 09:16:18 -0700
In-Reply-To: <20190411131222.GW14111@linux.ibm.com>
References: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
         <0702bc9a10703d53a46f27468b2c9ef2463e1c0b.camel@perches.com>
         <87k1g0vj7f.fsf@concordia.ellerman.id.au>
         <921408ed6a19d9c6fed18182f03a6dac5ea42aae.camel@perches.com>
         <20190411131222.GW14111@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2019-04-11 at 06:12 -0700, Paul E. McKenney wrote:
> If my email address were
> to change again, I would instead go with the "(IBM)" approach and let
> the git log and MAINTAINERS file keep the contact information.  Not that
> we get to update the git log, of course.  ;-)

Add entries to .mailmap works too.


