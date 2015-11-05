Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35491 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363AbbKEB4n (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2015 20:56:43 -0500
MIME-Version: 1.0
In-Reply-To: <20151104133936.GI20966@mwanda>
References: <20151104133936.GI20966@mwanda>
Date: Thu, 5 Nov 2015 09:56:41 +0800
Message-ID: <CAFiDJ5_P6zcMuJOqC9mwiQY6c95SueG68TQbYe+BUsta-AMEig@mail.gmail.com>
Subject: Re: [patch] PCI: altera: fix loop in tlp_read_packet()
From: Ley Foon Tan <lftan@altera.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rocketboard Maillist <rfi@lists.rocketboards.org>,
	linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 4, 2015 at 9:39 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> The problem is that TLP_LOOP is 500 and the "loop" variable was a u8 so
> "loop < TLP_LOOP" is always true.  We only need this condition to work
> if there is a problem so it would have been easy to miss this in
> testing.  Anyway, lets just make it a normal for loop with "int i"
> instead of over thinking things and making it complicated.
>
> Fixes: 6bb4dd154ae8 ('PCI: altera: Add Altera PCIe host controller driver')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
Acked-by: Ley Foon Tan <lftan@altera.com>

Thanks for the fix.

Regards
Ley Foon
