Return-Path: <SRS0=+/lQ=6D=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B30C3A5A0
	for <linux-pci@archiver.kernel.org>; Sun, 19 Apr 2020 14:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F96B21974
	for <linux-pci@archiver.kernel.org>; Sun, 19 Apr 2020 14:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDSOng (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:43:36 -0400
Received: from netrider.rowland.org ([192.131.102.5]:60607 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726319AbgDSOnf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Apr 2020 10:43:35 -0400
Received: (qmail 31957 invoked by uid 500); 19 Apr 2020 10:43:34 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Apr 2020 10:43:34 -0400
Date:   Sun, 19 Apr 2020 10:43:34 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/9] PM: sleep: core: Rearrange the handling of driver
 power management flags
In-Reply-To: <5673945.BT02kTCndr@kreacher>
Message-ID: <Pine.LNX.4.44L0.2004191040400.29527-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 18 Apr 2020, Rafael J. Wysocki wrote:

> Hi,
> 
> This is an update including some fixes and extra patches based on the
> continuation of the discussion [1].

The new code in pm.h and main.c all looks good.  Please add my
Acked-by: or Suggested-by: to the portions of the patches that affect
those files.

It's nice to see that, aside from the documentation, the patches ended
up removing more lines than they added.

Alan Stern

