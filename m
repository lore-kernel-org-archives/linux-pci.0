Return-Path: <SRS0=bIb/=5D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C34C5ACD6
	for <linux-pci@archiver.kernel.org>; Wed, 18 Mar 2020 11:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F5C205ED
	for <linux-pci@archiver.kernel.org>; Wed, 18 Mar 2020 11:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgCRLts (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:49:48 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:42331 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRLtr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Mar 2020 07:49:47 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id B77F4100DA1A7;
        Wed, 18 Mar 2020 12:49:45 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 54D2212F3; Wed, 18 Mar 2020 12:49:45 +0100 (CET)
Date:   Wed, 18 Mar 2020 12:49:45 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Hoyer, David" <David.Hoyer@netapp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: Kernel hangs when powering up/down drive using sysfs
Message-ID: <20200318114945.uqnexcmltfin3mvc@wunner.de>
References: <DM5PR06MB313235E97731D97AB813F65D92FB0@DM5PR06MB3132.namprd06.prod.outlook.com>
 <20200316181959.wpzi4hkoyzpghwpw@wunner.de>
 <DM5PR06MB31328A7B4E1A95A8C5E5E3E092F90@DM5PR06MB3132.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR06MB31328A7B4E1A95A8C5E5E3E092F90@DM5PR06MB3132.namprd06.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 16, 2020 at 06:25:53PM +0000, Hoyer, David wrote:
> I am not as familiar with submitting a "proper patch" and ask that you
> do it if you would be so kind.

I've just submitted a patch to address this issue.  Does it work for you?

The term "proper patch" is just kernel slang for a patch which can be
applied with "git am" by the PCI maintainer, Bjorn Helgaas.

Such a patch can be generated with "git format-patch" and sent out
with "msmtp" or "git send-email".

There are some formal requirements which the patch needs to satisfy,
they are listed here:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html
https://www.kernel.org/doc/html/latest/process/development-process.html
https://marc.info/?l=linux-pci&m=150905742808166

Never mind all these details if you do not intend to submit patches
yourself.  In this case, I introduced this embarrassing mistake, so
it's my job to provide a solution if you don't want to.

Thanks for all the debugging work you have done and once again sorry
for the breakage.

Lukas
