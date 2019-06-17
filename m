Return-Path: <SRS0=+Ccl=UQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D213CC31E5B
	for <linux-pci@archiver.kernel.org>; Mon, 17 Jun 2019 18:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97060208C4
	for <linux-pci@archiver.kernel.org>; Mon, 17 Jun 2019 18:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560795736;
	bh=qbxCbs3GDp/CMv5cX9wG11BqOooaSzc5OufFPBK83JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o3NWpFo6i4wQEWcQpkj69MX31uwfhDxohyOg9d/Dq1Jsg/PVI34oSGsSw9Ta5w8xa
	 TP0fc1CHWJ8vYYL5atH1CS7G1gstIkhfUa0HOhLuCHD5n8XSjNoBW0B8XVv/fy+n13
	 OjC5t9++uljWQiq+l/mhCuLGkQDPvs80IwM0gJ78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfFQSWQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfFQSWQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 14:22:16 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A5692084D;
        Mon, 17 Jun 2019 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560795734;
        bh=qbxCbs3GDp/CMv5cX9wG11BqOooaSzc5OufFPBK83JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=epfD/pHewbrtU7RIq8hZ9DZ2Oqv+jnjcHpsCMxoLWFWCsMHaPv6B3bu9h3RPkfmAa
         wN0PIZ9fDKy8XxycJmkxlglCRWJ7Qh/zE6RqJatltbO11YW85KguMSnaEcdTZNh7Ci
         AGZZ89mlLlB2Wxn7SqSoEGpe2BYRLYERjg436COE=
Date:   Mon, 17 Jun 2019 13:22:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v6 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <20190617182213.GB13533@google.com>
References: <20190522222928.2964-1-nicholas.johnson-opensource@outlook.com.au>
 <PS2P216MB0642C7A485649D2D787A1C6F80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
 <20190617093513.GN2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617093513.GN2640@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 12:35:13PM +0300, mika.westerberg@linux.intel.com wrote:
> On Wed, May 22, 2019 at 02:30:44PM +0000, Nicholas Johnson wrote:
> > Rewrite pci_bus_distribute_available_resources to better handle bridges
> > with different resource alignment requirements. Pass more details
> > arguments recursively to track the resource start and end addresses
> > relative to the initial hotplug bridge. This is especially useful for
> > Thunderbolt with native PCI enumeration, enabling external graphics
> > cards and other devices with bridge alignment higher than 0x100000
>  
> Instead of 0x100000 you could say 1MB here.

And of course, 1MB is the minimum bridge window alignment.  I *guess*
this is actually talking about endpoints with BARs larger than 1MB,
which have to be aligned on their size.  This doesn't actually impose
any requirement on the bridge window alignment, as long as the bridge
window contains the endpoint BARs.

> > bytes.

> >  	for_each_pci_bridge(dev, bus) {
> > -		const struct resource *res;
> > +		struct resource *res;
> > +		resource_size_t used_size;
> 
> Here order these in "reverse christmas tree" like:
> 
> 		resource_size_t used_size;
> 		struct resource *res;

I actually don't enforce "reverse christmas tree", and when I write
code, I order the declarations in order of their use in the code
below, as Nicholas has done.  But either way is fine.

Bjorn
