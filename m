Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031360AbdEWVpd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 May 2017 17:45:33 -0400
Date: Tue, 23 May 2017 16:45:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Piotr Gregor <piotrek.gregor@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Piotr Gregor <piotrgregor@rsyncme.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Handle the case when PCI_COMMAND register hasn't
 changed in INTx masking test
Message-ID: <20170523214531.GB20928@bhelgaas-glaptop.roam.corp.google.com>
References: <20170510122959.4uupohiz3ukzm4c4@debian1.home>
 <20170522233820.GH19733@bhelgaas-glaptop.roam.corp.google.com>
 <20170523161929.GA24431@bhelgaas-glaptop.roam.corp.google.com>
 <20170523103904.3a20d0cc@w520.home>
 <CAO3obxb349aeDX1harujpzi_E2ZMq820wtjrODR5sYiZ=KtjwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAO3obxb349aeDX1harujpzi_E2ZMq820wtjrODR5sYiZ=KtjwQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 23, 2017 at 08:14:26PM +0100, Piotr Gregor wrote:
> Would the pci_setup_device() be a good place to move this check to?

Seems like a reasonable place.
