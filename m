Return-Path: <SRS0=TaNj=YL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE64CA9EA0
	for <linux-pci@archiver.kernel.org>; Fri, 18 Oct 2019 10:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97B0205F4
	for <linux-pci@archiver.kernel.org>; Fri, 18 Oct 2019 10:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405341AbfJRK0X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:26:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63590 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404321AbfJRK0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2019 06:26:23 -0400
Received: from 79.184.255.51.ipv4.supernova.orange.pl (79.184.255.51) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 678a9a468f647381; Fri, 18 Oct 2019 12:26:20 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI/PM: Use dev_printk() when possible
Date:   Fri, 18 Oct 2019 12:26:20 +0200
Message-ID: <2088720.TElhCYhjX6@kreacher>
In-Reply-To: <20191017212851.54237-1-helgaas@kernel.org>
References: <20191017212851.54237-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday, October 17, 2019 11:28:49 PM CEST Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Some PM messages, e.g., "PCI PM: Device state not saved by %pS\n", had no
> indication of what device was affected.  Add pci_WARN() and use it.
> 
> Bjorn Helgaas (2):
>   PCI/PM: Use PCI dev_printk() wrappers for consistency
>   PCI/PM: Use pci_WARN() to include device information
> 
>  drivers/pci/pci-driver.c | 45 ++++++++++++++++++++--------------------
>  include/linux/pci.h      |  8 +++++++
>  2 files changed, 31 insertions(+), 22 deletions(-)
> 
> 

Good cleanups!

For both

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>




