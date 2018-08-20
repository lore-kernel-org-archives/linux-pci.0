Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54630 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTIsy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Aug 2018 04:48:54 -0400
Message-ID: <542cf76d6cea3c86d0a5540b23dec95f89abcd14.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: poza@codeaurora.org, Thomas Tai <thomas.tai@oracle.com>,
        bhelgaas@google.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
        Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Mon, 20 Aug 2018 14:37:46 +1000
In-Reply-To: <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
         <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
         <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
         <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
         <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
         <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
         <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
         <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
         <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2018-08-18 at 21:19 -0500, Bjorn Helgaas wrote:
> 
> > Ugh... I just saw the changes you did to Documentation/PCI/pci-error-
> > recovery.txt and I would very much like to revert those !
> > 
> > Bjorn, you shouldn't let changes to the PCI error handling through
> > without acks from us, it looks like we didn't notice (we can't possibly
> > monitor all lists).
> 
> Sorry, they were certainly very visible on linux-pci, but I should
> have added you to cc if you weren't there already.  Please update
> MAINTAINERS if it's incomplete or out of date (I can't possibly know
> who might be interested in every change).

Right but we designed the error handling (we = powerpc). Due to churn
with people I think nobody's been actively monitoring linux-pci and I
was myself caught up with a bunch of other things.

> > Bjorn, please revert all of those changes.
> 
> Please send the appropriate patches and we'll go from there.
