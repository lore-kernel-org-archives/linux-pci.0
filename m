Return-Path: <SRS0=fcTa=YO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B5CCA9EAF
	for <linux-pci@archiver.kernel.org>; Mon, 21 Oct 2019 13:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7DC2173B
	for <linux-pci@archiver.kernel.org>; Mon, 21 Oct 2019 13:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfJUNVR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:21:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:61100 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728753AbfJUNVR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 09:21:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 06:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="209442881"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 21 Oct 2019 06:21:12 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Oct 2019 16:21:12 +0300
Date:   Mon, 21 Oct 2019 16:21:12 +0300
From:   Mika Westerberg <mika.westerberg@intel.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
Subject: Re: [PATCH v3] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20191021132112.GH2819@lahna.fi.intel.com>
References: <20191016144449.24646-1-kherbst@redhat.com>
 <20191021114017.GY2819@lahna.fi.intel.com>
 <CACO55tt2iGcySugTAb1khEYpiGoq6Os3upG5fGq+0PbE2gyyeQ@mail.gmail.com>
 <20191021120611.GB2819@lahna.fi.intel.com>
 <CACO55tvYEvPHwFLDmLOQ_BCiNw7ZRA7dun9P=KdLb4bvYTtrcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tvYEvPHwFLDmLOQ_BCiNw7ZRA7dun9P=KdLb4bvYTtrcg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 03:02:23PM +0200, Karol Herbst wrote:
> > No, just block runtime PM from the device in nouveau driver.
> 
> but that's not what the patch does. It only skips the PCI PM reg
> write, but still let the ACPI method be invoked to put the device into
> D3cold

Oh, indeed it does. I did not realize that.

Which makes me wonder whether ACPI _OFF() expects the device to be in D0
for some reason.
