Return-Path: <SRS0=Bif1=BA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C9AC433E1
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jul 2020 12:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CC52073A
	for <linux-pci@archiver.kernel.org>; Tue, 21 Jul 2020 12:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGUMWw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:22:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:13460 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgGUMWw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 08:22:52 -0400
IronPort-SDR: /c8enrNmOKbbW9rA96IbrAmTpKI2J0TcwEynLZ18hngTj6aJm8YfF1cESdCEojHgXLytCmyR5c
 jnJIPXaNXfkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="211662394"
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="211662394"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 05:22:51 -0700
IronPort-SDR: QRKBuOX3wimM7whHx8OuUjSdcYgNzpo16Eb3ifaPARH/EpOURaCxowV/BZ+z3RNd281xrN4eSQ
 ZJF6b0Kq8vAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="392335007"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 21 Jul 2020 05:22:47 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 21 Jul 2020 15:22:47 +0300
Date:   Tue, 21 Jul 2020 15:22:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Patrick Volkerding <volkerdi@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
Message-ID: <20200721122247.GI5180@lahna.fi.intel.com>
References: <CACO55tuA+XMgv=GREf178NzTLTHri4kyD5mJjKuDpKxExauvVg@mail.gmail.com>
 <20200716235440.GA675421@bjorn-Precision-5520>
 <CACO55tuVJHjEbsW657ToczN++_iehXA8pimPAkzc=NOnx4Ztnw@mail.gmail.com>
 <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tso5SVipAR=AZfqhp6GGkKO9angv6f+nd61wvgAJtrOKg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[Sorry for the delay, I was on vacation]

On Fri, Jul 17, 2020 at 01:32:10PM +0200, Karol Herbst wrote:
> Filed at https://bugzilla.kernel.org/show_bug.cgi?id=208597

Thanks for reporting.

I'll check your logs and try to figure if there is something we can do
to make both nouveau and TBT working at the same time.

> oddly enough I wasn't able to reproduce it on my XPS 9560, will ping
> once something breaks.
