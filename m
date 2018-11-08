Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C22C43441
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 22:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7981B20857
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 22:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7981B20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeKIIOS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:14:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:61932 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbeKIIOS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Nov 2018 03:14:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 14:36:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,481,1534834800"; 
   d="scan'208";a="279543465"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 08 Nov 2018 14:36:37 -0800
Date:   Thu, 8 Nov 2018 15:32:58 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-pci@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        linux-kernel@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
Message-ID: <20181108223258.GD2932@localhost.localdomain>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com>
 <20181108200855.GE41183@google.com>
 <20181108220117.GA11466@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108220117.GA11466@kroah.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 08, 2018 at 02:01:17PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Nov 08, 2018 at 02:09:17PM -0600, Bjorn Helgaas wrote:
> > I'm having second thoughts about this.  One thing I'm uncomfortable
> > with is that sprinkling pci_dev_is_disconnected() around feels ad hoc
> > instead of systematic, in the sense that I don't know how we convince
> > ourselves that this (and only this) is the correct place to put it.
> 
> I think my stance always has been that this call is not good at all
> because once you call it you never really know if it is still true as
> the device could have been removed right afterward.
> 
> So almost any code that relies on it is broken, there is no locking and
> it can and will race and you will loose.

AIUI, we're not trying to create code to rely on this. This more about
reducing reliance on hardware. If the software misses the race once and
accesses disconnected device memory, that's usually not a big deal to
let hardware sort it out, but the point is not to push our luck.

Surprise hot remove is empirically more reliable the less we interact
with hardware and firmware. That shouldn't be necessary, but is just an
unfortunate reality.
