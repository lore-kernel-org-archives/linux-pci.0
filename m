Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751728AbdLKOqA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Dec 2017 09:46:00 -0500
Date: Mon, 11 Dec 2017 08:45:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rudolf Marek <r.marek@assembler.cz>
Cc: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org,
        RayeR <rayer@seznam.cz>
Subject: Re: [PATCH] lspci: Decode "VGA 16-bit decode" in bridge control
 register
Message-ID: <20171211144559.GA16032@bhelgaas-glaptop.roam.corp.google.com>
References: <20171208212410.30418.94419.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <ef7e0e6a-404a-c54e-de99-cfebe2ff20cf@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ef7e0e6a-404a-c54e-de99-cfebe2ff20cf@assembler.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 09, 2017 at 12:08:00PM +0100, Rudolf Marek wrote:
> Hi Bjorn,
> 
> Thanks for the patch. It works as expected on my system.
> I tried to swap the bit and see if lspci sees that.
> 
> The patch does not apply cleanly on git or on 3.5.6, but maybe my mail client did something to it.

I saved the email message and applied it successfully to e4d209fdc067
("README: kernel.org does not speak FTP any longer"), which I think is the
current head of git://git.kernel.org/pub/scm/utils/pciutils/pciutils.git

So I suspect maybe your mail client corrupted it.

Bjorn
