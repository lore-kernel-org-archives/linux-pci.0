Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:23021 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbdFHRSf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jun 2017 13:18:35 -0400
Date: Thu, 8 Jun 2017 10:18:33 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        Stefan Assmann <sassmann@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Add Intel XXV710 to broken INTx masking quirk
Message-ID: <20170608101833.0000163f@intel.com>
In-Reply-To: <20170607190027.22611.92564.stgit@gimli.home>
References: <20170607190027.22611.92564.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 7 Jun 2017 13:00:48 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> Just like the other XL710 and X710 variants, the XXV710 device IDs
> appear to have the same hardware bug, the status register doesn't
> report pending interrupts resulting in "irq xx: nobody cared..."
> errors from the spurious interrupt handler when we try to use it
> with device assignment.

Thanks for doing this Alex,

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
