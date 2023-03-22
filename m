Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F72C6FD1C
	for <linux-pci@archiver.kernel.org>; Wed, 22 Mar 2023 13:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCVNyL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 22 Mar 2023 09:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjCVNyK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 09:54:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6992EEC7C;
        Wed, 22 Mar 2023 06:54:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 605A567373; Wed, 22 Mar 2023 14:54:06 +0100 (CET)
Date:   Wed, 22 Mar 2023 14:54:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Adriaanse <jason_a69@yahoo.co.uk>
Cc:     regressions@leemhuis.info, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [regression] Bug 217218 - Trying to boot Linux version 6-2.2
 kernel with Marvell SATA controller 88SE9235
Message-ID: <20230322135406.GB16587@lst.de>
References: <a79ea7f5-6a41-a6c9-cfec-ba01aa2a3cfa@leemhuis.info> <71eb8118-035c-8a21-40dc-708b8ad511fc@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71eb8118-035c-8a21-40dc-708b8ad511fc@yahoo.co.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 22, 2023 at 05:46:09PM +0800, Jason Adriaanse wrote:
> Bonjuerno Christoph,
>
> I am the user who logged the original problem, is there anything I can do 
> to help debug the issue?
>
> I do not mind testing patches or to help in any way I can.

Hi Jason,

I'm a little unresponsive right now as I'm dealing with the fallout
of a strike tomorrow that is disrupting my travel.  So for now,
just a quick idea off my mind:

  1) is CONFIG_GART_IOMMU enabled in your kernel
  2) if so can you disable it and see if that makes the problem go away?
