Return-Path: <SRS0=pA/b=QC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1648C282C5
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 04:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C72F21902
	for <linux-pci@archiver.kernel.org>; Sat, 26 Jan 2019 04:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="hMr7BdKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfAZEgx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 23:36:53 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36540 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbfAZEgx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 23:36:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CADE08EE27B;
        Fri, 25 Jan 2019 20:36:52 -0800 (PST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3xT74a7aivqd; Fri, 25 Jan 2019 20:36:52 -0800 (PST)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 146768EE22B;
        Fri, 25 Jan 2019 20:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1548477412;
        bh=4ashVPD3JxNZ9J9kqobt3EhzqZ+zUrpnnUK6Bn82FRY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hMr7BdKOz6KvvE7CH/m0hq4758NWIhx8JPyFEqbih2vG7vtVxG7fv+iQmTF7GYt6j
         5EsGpzPwVhiITEjckxXp84Cj0L6ZFwdcVt8FCcdS561jNWA0+QORzDhW/o0IquiJGL
         aAdljOuAnURk9eKtJGVg2sUH0rPlpkW5YLZmXB5E=
Message-ID: <1548477410.3212.45.camel@HansenPartnership.com>
Subject: Re: [Bug 201609] sysfs duplicate filename on driver loading Adaptec
 AIC-9410W
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     bugzilla-daemon@bugzilla.kernel.org, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     pablo.ruiz@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        Emil Velikov <emil.velikov@collabora.com>
Date:   Fri, 25 Jan 2019 20:36:50 -0800
In-Reply-To: <bug-201609-11613-QuH6JgZlE8@https.bugzilla.kernel.org/>
References: <bug-201609-11613@https.bugzilla.kernel.org/>
         <bug-201609-11613-QuH6JgZlE8@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2019-01-26 at 03:13 +0000, bugzilla-daemon@bugzilla.kernel.org
wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=201609
> 
> Pablo Ruiz García (pablo.ruiz@gmail.com) changed:
> 
>            What    |Removed                     |Added
> -------------------------------------------------------------------
> ---------
>                  CC|                            |pablo.ruiz@gmail.com
> 
> --- Comment #2 from Pablo Ruiz García (pablo.ruiz@gmail.com) ---
> Hi,
> 
> I've stumbled upon this very same issue, and have created a github
> repo with a
> fix for the actual issue (see git commit's description for bug
> details).
> 
> https://github.com/pruiz/aic94xx-hotfix
> https://github.com/pruiz/aic94xx-hotfix/commit/01898ea7dff8eb52f43773
> ea3b59ab41ef2482c8
> 
> Hope it helps someone.

I think the correct fix is to rename the ai94xx revision file (say to
aic94x_revision). However I've got to say that commit

commit 702ed3be1b1bf4dea05954168321741c0910c645
Author: Emil Velikov <emil.velikov@collabora.com>
Date:   Mon Nov 21 16:24:49 2016 -0600

    PCI: Create revision file in sysfs
  
Was a blatently silly thing to do without trying to namespace the added
file (say calling it something less generic like pci_revision).  I
assume we're lucky and nothing in userspace depends on the 'revision'
sysfs file of the aic driver, but technically I should request
reversion of this patch on the grounds that it's broken our ABI (since
that's what exported sysfs files are).

James

