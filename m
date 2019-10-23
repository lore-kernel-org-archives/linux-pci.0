Return-Path: <SRS0=O4f2=YQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358CECA9EB6
	for <linux-pci@archiver.kernel.org>; Wed, 23 Oct 2019 10:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F7B2064A
	for <linux-pci@archiver.kernel.org>; Wed, 23 Oct 2019 10:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390513AbfJWKnt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:43:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:26893 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390386AbfJWKnt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 06:43:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 03:43:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="209898367"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 23 Oct 2019 03:43:46 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 23 Oct 2019 13:43:45 +0300
Date:   Wed, 23 Oct 2019 13:43:45 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH 1/1] PCI: Add hp_mmio_size and hp_mmio_pref_size
 parameters
Message-ID: <20191023104345.GY2819@lahna.fi.intel.com>
References: <PSXP216MB01833367A1A154AEB816AE4E806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
 <20191023094743.GU2819@lahna.fi.intel.com>
 <SL2P216MB0187D47276DED3EA634123BE806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191023100359.GW2819@lahna.fi.intel.com>
 <SL2P216MB0187E0B5D83583094065CA35806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB0187E0B5D83583094065CA35806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 10:33:42AM +0000, Nicholas Johnson wrote:
> On Wed, Oct 23, 2019 at 01:03:59PM +0300, mika.westerberg@linux.intel.com wrote:
> > On Wed, Oct 23, 2019 at 09:57:17AM +0000, Nicholas Johnson wrote:
> > > On Wed, Oct 23, 2019 at 12:47:43PM +0300, mika.westerberg@linux.intel.com wrote:
> > > > On Wed, Oct 23, 2019 at 08:37:48AM +0000, Nicholas Johnson wrote:
> > > > >  			} else if (!strncmp(str, "hpmemsize=", 10)) {
> > > > > -				pci_hotplug_mem_size = memparse(str + 10, &str);
> > > > > +				pci_hotplug_mmio_size =
> > > > > +					memparse(str + 10, &str);
> > > > > +				pci_hotplug_mmio_pref_size =
> > > > > +					memparse(str + 10, &str);
> > > > 
> > > > Does this actually work correctly? The first memparse(str + 10, &str)
> > > > modifies str so the next call will not start from the correct position
> > > > anymore.
> > > I have been using this for a long time now and have not had any issues.
> > > Does it modify str? I thought that was done by the loop.
> > 
> > If you add "hpmemsize=xxx" in the command line and print both
> > pci_hotplug_mmio_size and pci_hotplug_mmio_pref_size after the
> > assignment, do they have the same value? If yes, then there is no
> > problem.
> Looking at lib/cmdline.c line 125, it looks like there is no point in me 
> testing it. It looks like you are right.
> 
> What is the better fix?
> 
> pci_hotplug_mmio_size = pci_hotplug_mmio_pref_size = memparse(str + 10, &str);
> 
> ^ Could be too long, even if we are ignoring the 80-character limit.

I prefer this:

				pci_hotplug_mmio_size = memparse(str + 10, &str);
				pci_hotplug_mmio_pref_size = pci_hotplug_mmio_size;

And you can ignore the 80-char limit. The above is much more readable
IMHO.
