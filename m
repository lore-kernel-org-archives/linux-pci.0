Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:34691 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933265AbcLSRH1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Dec 2016 12:07:27 -0500
To: Keith Busch <keith.busch@intel.com>
References: <1481994562-9283-1-git-send-email-logang@deltatee.com>
 <1481994562-9283-2-git-send-email-logang@deltatee.com>
 <20161219170201.GA1043@localhost.localdomain>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Stephen Bates <stephen.bates@microsemi.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8e4b1c0b-04aa-b2ba-21ba-72377913588f@deltatee.com>
Date: Mon, 19 Dec 2016 10:07:19 -0700
MIME-Version: 1.0
In-Reply-To: <20161219170201.GA1043@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC 1/1] MicroSemi Switchtec management interface driver
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 19/12/16 10:02 AM, Keith Busch wrote:
> Some of this would be simplified if you use the managed device API's:
> devm_request_irq, pcim_enable_device, pcim_iomap, etc...

Thanks Keith, I'll look into using those.

Logan

