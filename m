Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36091 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753361AbdIFBv0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Sep 2017 21:51:26 -0400
Message-ID: <1504662680.13106.1.camel@russell.cc>
Subject: Re: [PATCH 1/2] PCI: Remove reset argument from
 pci_iov_{add,remove}_virtfn()
From: Russell Currey <ruscur@russell.cc>
To: "Jan H." =?ISO-8859-1?Q?Sch=F6nherr?= <jschoenh@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 06 Sep 2017 11:51:20 +1000
In-Reply-To: <1504653683-11543-1-git-send-email-jschoenh@amazon.de>
References: <1504653683-11543-1-git-send-email-jschoenh@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-09-06 at 01:21 +0200, Jan H. Schönherr wrote:
> The reset argument passed to pci_iov_add_virtfn() and
> pci_iov_remove_virtfn() is always zero since commit 46cb7b1bd86fc227a
> ("PCI: Remove unused SR-IOV VF Migration support").
> 
> Remove the argument together with the associated code.
> 
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>

Acked-by: Russell Currey <ruscur@russell.cc>
