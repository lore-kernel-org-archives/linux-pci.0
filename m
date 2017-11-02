Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:43665 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755163AbdKBINA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2017 04:13:00 -0400
Date: Thu, 2 Nov 2017 09:12:40 +0100
From: Simon Horman <horms@verge.net.au>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: PCI: rcar: Use common error handling code in
 rcar_pcie_enable_msi()
Message-ID: <20171102081239.bzaunax3uotejqja@verge.net.au>
References: <c598933b-b14f-91a1-c7a3-f4a46ec98e77@users.sourceforge.net>
 <20171101081831.ssnuqp5b75lbfu5p@verge.net.au>
 <7047eb7a-cf93-6a56-08db-a5e8bedbfc57@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <7047eb7a-cf93-6a56-08db-a5e8bedbfc57@users.sourceforge.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 01, 2017 at 09:57:00AM +0100, SF Markus Elfring wrote:
> > This is fine by me
> 
> Thanks for another bit of change acceptance.
> 
> 
> > except that the change in the name of the goto label seems spurious.
> 
> I am curious if the popularity of a jump label like “err” will decrease
> (in the Linux source files) over time.

If your current patch bombing is successful then it will, at least in the
short term. But my comments relate to the current best practice,
not the one you seem to be trying to introduce.

> > But if you really want to change it then as it is an error path
> > I should suggest it describe that its an error and what unwinding
> > is done, f.e.  err_remove_domain.
> 
> * Do you get such a kind of information only when the prefix “err_”
>   is added to this identifier?

Yes, err indicates its an error path.

> 
> * Do you prefer to stress the “domain removal”
>   (or the shown error message) in the label?

I prefer to stress the unwind path as that is the most important
aspect of the error path.


I have no interest in a prelonged debate about the naming of labels.
As I pointed out its a spurious aspect of your change. If you wish me to
Ack your change then please either drop that change or update it - as I
already suggested. Else lets discontinue this sub-thread.
