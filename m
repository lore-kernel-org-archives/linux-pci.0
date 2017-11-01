Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: PCI: rcar: Use common error handling code in
 rcar_pcie_enable_msi()
To: Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <c598933b-b14f-91a1-c7a3-f4a46ec98e77@users.sourceforge.net>
 <20171101081831.ssnuqp5b75lbfu5p@verge.net.au>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <7047eb7a-cf93-6a56-08db-a5e8bedbfc57@users.sourceforge.net>
Date: Wed, 1 Nov 2017 09:57:00 +0100
MIME-Version: 1.0
In-Reply-To: <20171101081831.ssnuqp5b75lbfu5p@verge.net.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> This is fine by me

Thanks for another bit of change acceptance.


> except that the change in the name of the goto label seems spurious.

I am curious if the popularity of a jump label like “err” will decrease
(in the Linux source files) over time.


> But if you really want to change it then as it is an error path
> I should suggest it describe that its an error and what unwinding
> is done, f.e.  err_remove_domain.

* Do you get such a kind of information only when the prefix “err_”
  is added to this identifier?

* Do you prefer to stress the “domain removal”
  (or the shown error message) in the label?

Regards,
Markus
