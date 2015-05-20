Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:63637 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbbETMWA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 08:22:00 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org
Cc: Tina Ruchandani <ruchandani.tina@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-pci@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	xen-devel@lists.xenproject.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Y2038] [PATCH v2] xen/pcifront: Remove usage of struct timeval
Date: Wed, 20 May 2015 14:21:50 +0200
Message-ID: <3083587.uSon9UE2TV@wuerfel>
In-Reply-To: <20150519060809.GA27777@tinar>
References: <20150519060809.GA27777@tinar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 19 May 2015 11:38:09 Tina Ruchandani wrote:
> struct timeval uses a 32-bit field for representing seconds,
> which will overflow in the year 2038 and beyond. This patch replaces
> struct timeval with 64-bit ktime_t which is 2038 safe.
> The patch is part of a larger effort to remove instances of
> 32-bit timekeeping variables (timeval, time_t and timespec)
> from the kernel.
> 
> Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
