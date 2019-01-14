Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F618C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 18:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0111920651
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 18:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfANSD1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:03:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:22110 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANSD1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jan 2019 13:03:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 10:03:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,478,1539673200"; 
   d="scan'208";a="108171140"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2019 10:03:25 -0800
Date:   Mon, 14 Jan 2019 11:02:07 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     fin4478 fin4478 <fin4478@hotmail.com>,
        Dou Liyang <douliyangs@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org
Subject: Re: Please remove warnings from msi.c:1269 and blk-mq-pci.c:52 some
 day
Message-ID: <20190114180207.GC27149@localhost.localdomain>
References: <AM0PR06MB3969BE1DFD53EFF6228E1A0AA1800@AM0PR06MB3969.eurprd06.prod.outlook.com>
 <CAErSpo5B2m406Mk6SUUcnmF31OEa8vC5YQTKB0ws3z3F5y_fEw@mail.gmail.com>
 <20190114170338.GA27149@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114170338.GA27149@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+linux-nvme@lists.infradead.org]

On Mon, Jan 14, 2019 at 10:03:39AM -0700, Keith Busch wrote:
> [+Ming]
> On Mon, Jan 14, 2019 at 08:31:45AM -0600, Bjorn Helgaas wrote:
> > [+cc Dou, Jens, Thomas, Christoph, linux-pci, LKML]
> > 
> > On Sun, Jan 13, 2019 at 11:24 PM fin4478 fin4478 <fin4478@hotmail.com> wrote:
> > >
> > > Hi,
> > >
> > > A regression from the 4.20 kernel: I have the Asgard 256GB nvme drive
> > > and my custom non debug 1000Hz timer kernel 5.0 started to throw a
> > > couple of warning messages at boot. My system works ok:
> 
> I think Ming's patch here fixes this:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2019-January/021902.html

User fin4478 <fin4478@hotmail.com> informs me Ming's patch above fixes
the warnings, but responding to the mailing lists from that email account
are blocked for "security or policy reasons" and requested I forward
the successful test result.

Christoph, Jens: may we queue this up for -rc3?
