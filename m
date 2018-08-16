Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47089 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeHQC2Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Aug 2018 22:28:24 -0400
Message-ID: <c7b996e0856cbea16cbb94287225bf2083158f02.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sinan Kaya <okaya@kernel.org>, poza@codeaurora.org
Cc: Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org,
        Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Fri, 17 Aug 2018 09:27:03 +1000
In-Reply-To: <1d5b1157-2f78-5fab-78f0-5828892fc739@kernel.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
         <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
         <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
         <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
         <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
         <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
         <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
         <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
         <42bd39aef30fe24bfc48d378e1f5d35d@codeaurora.org>
         <54d19e0e3d44bedf247853144c6bbfed5561a125.camel@kernel.crashing.org>
         <f022581a9ecb88e5501a09bdcdc62954@codeaurora.org>
         <1d5b1157-2f78-5fab-78f0-5828892fc739@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2018-08-16 at 09:46 -0400, Sinan Kaya wrote:
> On 8/16/2018 4:22 AM, poza@codeaurora.org wrote:
> > we can catch up on webex, (Sinan is going to be there in Plumber's 
> > conference, I might not be able to join there, as we have bring-up coming)
> 
> My plumbers conference attendance is not confirmed yet. I'm trying to
> combine it with a business trip. I did not get an ACK yet from my boss.

Ok, I'll collect the names and will propose a time/date early next
week, I'm a bit caught up until monday.

Bjorn, are you available as well ?

Cheers,
Ben.
