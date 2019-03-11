Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DE3C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 17:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906C12075C
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552326808;
	bh=3HtbBAbth7rTgOIbquCMmCeXipwT4tpWjq06KBV4IVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sQmf00O+Fr6VaalM7pytIvE+aXWq9nOmY2cP+IJAN8rySNqrXVVJmUBADhQsy5Y11
	 z1AmB9ZAkpq+SF3cQswOJbULt4du6m8quwS1/CwyWacR1leuQHU5npMPHVJtTiQ+Nz
	 zbTUvn+d7ckyv2x3rFG+GxVgA8hCUzRzuH6+vIeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCKRx2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfCKRx1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 13:53:27 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D177E20643;
        Mon, 11 Mar 2019 17:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552326807;
        bh=3HtbBAbth7rTgOIbquCMmCeXipwT4tpWjq06KBV4IVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkasg9/YOFNLP0umaMHJl2kx4EujkCMpaWKxVNc586XDNRKEL8OUlksN4Y4lPaqus
         Fk1xralszK3pIXRxcWqdxHCZKAoSZdZqG1zYr1M/aidUaSOZnFOCAB+o4ioEpzo5fj
         gdsJXo/UeLmdxcIKxWnETU8QQDaRsHBo69Me5hTc=
Date:   Mon, 11 Mar 2019 12:53:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v2 0/4] PCI: Patch series to support Thunderbolt without
 any BIOS support
Message-ID: <20190311175325.GI214730@google.com>
References: <PS2P216MB0642DA40B66B36581A238EF580480@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB0642DA40B66B36581A238EF580480@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 04:22:47PM +0000, Nicholas Johnson wrote:
> 
> If possible, please try to include this in the upcoming release. I have 
> been slow in getting PATCH v2 out but overall, it should not be too much 
> to do.

Quick primer on the Linux development model: Major releases, e.g.,
v5.0, happen about every 9-10 weeks.  Subsystem maintainers typically
review and merge patches into their -next branches for about eight
weeks before the major release.

The first two weeks after a release are the merge window, during which
subsystem maintainers ask Linus to merge those -next branches into the
mainline.

Between the closing of the merge window and the next major release,
subsystem maintainers (1) ask Linus to merge fixes for regressions or
problems introduced during the merge window, and (2) accumulate
patches on their -next branches for the *next* merge window.

v5.0 was released a week ago, which means the v5.1 merge window is
half over.  Linus merged the PCI changes for v5.1 over the weekend, so
by default, PCI changes that weren't included in that merge will be
aiming for the v5.2 merge window.  Small fixes for regressions and
things we broke during the merge window can be merged any time, but we
have to be able to defend them as being critical enough to merge
outside the merge window.

See Documentation/process/2.Process.rst for more details.

Bjorn
