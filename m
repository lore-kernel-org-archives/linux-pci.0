Return-Path: <SRS0=3dpc=PQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94099C43387
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 12:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F89C21019
	for <linux-pci@archiver.kernel.org>; Tue,  8 Jan 2019 12:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfAHMqE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:46:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:30225 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbfAHMqE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jan 2019 07:46:04 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 04:46:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,454,1539673200"; 
   d="scan'208";a="136369891"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 08 Jan 2019 04:46:00 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Jan 2019 14:45:59 +0200
Date:   Tue, 8 Jan 2019 14:45:59 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Peter Wu <peter@lekensteyn.nl>
Cc:     Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Block power management of certain ports with
 slot implemented bit set
Message-ID: <20190108124559.GZ2469@lahna.fi.intel.com>
References: <20190107130152.83350-1-mika.westerberg@linux.intel.com>
 <CAJZ5v0iJfUK6FDQ=W6=2+wEG2GHKDT5r_aoRapUn4Qi0FTjaGg@mail.gmail.com>
 <20190108093507.GX2469@lahna.fi.intel.com>
 <20190108101600.5qbeks5ux6wgpbpy@wunner.de>
 <20190108105824.GC23218@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108105824.GC23218@al>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 08, 2019 at 11:58:24AM +0100, Peter Wu wrote:
> > Would this patch:
> > 
> >     https://patchwork.ozlabs.org/patch/1021317/
> > 
> > break runtime D3cold for the discrete GPU on Optimus laptops such as
> > your Clevo P651RA?  Specifically, is the Root Port above the GPU
> > marked "(Slot+)" in lspci -vv?  (There doesn't seem to be raw lspci
> > output in https://github.com/Lekensteyn/acpi-stuff)
> 
> Thanks for bringing this into my attention. There are a couple of full
> lspci dumps, for example for the Dell XPS 9560.
> https://github.com/Lekensteyn/acpi-stuff/blob/master/d3test/XPS9560/lspci-bare-metal.txt
> This has upstream port 00:01.0 attached to GPU 01:00.0
> 
>     00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 05) (prog-if 00 [Normal decode])
>         ...
>         Capabilities: [a0] Express (v2) Root Port (Slot+), MSI 00
> 
> and would indeed be negatively affected by this patch. I can observe the
> same for the Clevo P651RA (for which I can also send the full lspci dump
> if you need).

Thanks both.

I guess that leaves us the blacklist. I can re-send it rebased on top of
v5.0-rc1 if there are no objections.
