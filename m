Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51137 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750949AbdGLXqu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2017 19:46:50 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: "Solanki, Naresh" <naresh.solanki@intel.com>
Cc: "Rao Pv, Sadashiva" <sadashiva.rao.pv@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI / PM: Fix native PME handling during system suspend/resume
Date: Thu, 13 Jul 2017 01:39:06 +0200
Message-ID: <2061263.Fyvozl4yyQ@aspire.rjw.lan>
In-Reply-To: <2516f96e-bc32-46ac-acc9-8a5e16c44245@email.android.com>
References: <2516f96e-bc32-46ac-acc9-8a5e16c44245@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, July 12, 2017 11:32:17 PM Solanki, Naresh wrote:
> Hi Rafael,
> 
> We tested the patch and completed ~400cycles of s3 and s0ix. No regression observed.

Awesome, thanks!
