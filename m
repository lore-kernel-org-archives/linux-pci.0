Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:40902 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbbFHKSy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jun 2015 06:18:54 -0400
Message-ID: <55756C0A.8030709@citrix.com>
Date: Mon, 8 Jun 2015 11:18:50 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Tina Ruchandani <ruchandani.tina@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
CC: <y2038@lists.linaro.org>, <linux-pci@vger.kernel.org>,
	David Vrabel <david.vrabel@citrix.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	<xen-devel@lists.xenproject.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH v2] xen/pcifront: Remove usage of struct timeval
References: <20150519060809.GA27777@tinar>
In-Reply-To: <20150519060809.GA27777@tinar>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 19/05/15 07:08, Tina Ruchandani wrote:
> struct timeval uses a 32-bit field for representing seconds,
> which will overflow in the year 2038 and beyond. This patch replaces
> struct timeval with 64-bit ktime_t which is 2038 safe.
> The patch is part of a larger effort to remove instances of
> 32-bit timekeeping variables (timeval, time_t and timespec)
> from the kernel.

Applied to for-linus-4.2, thanks.

"This patch" is a bit redundant in a commit message so I tweaked it to read:

    struct timeval uses a 32-bit field for representing seconds, which
    will overflow in the year 2038 and beyond. Replace struct timeval
    with 64-bit ktime_t which is 2038 safe.  This is part of a larger
    effort to remove instances of 32-bit timekeeping variables
    (timeval, time_t and timespec) from the kernel.

> Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> --

Use 3 hyphens as a separator here.

> Changes in v2:

David
