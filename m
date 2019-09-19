Return-Path: <SRS0=ZNYH=XO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1581DC49ED7
	for <linux-pci@archiver.kernel.org>; Thu, 19 Sep 2019 06:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CB821A4C
	for <linux-pci@archiver.kernel.org>; Thu, 19 Sep 2019 06:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbfISG56 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 19 Sep 2019 02:57:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:5135 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfISG55 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Sep 2019 02:57:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 23:57:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; 
   d="scan'208";a="202226818"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 18 Sep 2019 23:57:51 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 19 Sep 2019 09:57:49 +0300
Date:   Thu, 19 Sep 2019 09:57:49 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Andree <matthias.andree@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Justin Forbes <jmforbes@linuxtx.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add missing link delays required by the PCIe spec
Message-ID: <20190919065749.GD28281@lahna.fi.intel.com>
References: <20190821124519.71594-1-mika.westerberg@linux.intel.com>
 <20190824021254.GB127465@google.com>
 <20190826101726.GD19908@lahna.fi.intel.com>
 <20190826140712.GC127465@google.com>
 <20190826144242.GA2643@lahna.fi.intel.com>
 <20190826220502.GD127465@google.com>
 <20190827092542.GB3177@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827092542.GB3177@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Tue, Aug 27, 2019 at 12:25:47PM +0300, Mika Westerberg wrote:
> Here are the relevant parts from ICL. I'll send you the full dmesg as
> a separate email. The topology is such that I have 2 Titan Ridge devices
> connected in chain (each include PCIe switch + xHCI). I wait for the
> whole hierarchy to enter D3cold:

Did you had time to check the log I sent you?

Also how should we proceed with this patch? I can update it according to
comments and send a new version after v5.4-rc1 is released. Of course
unless you have better way we can fix this issue.

Thanks!
