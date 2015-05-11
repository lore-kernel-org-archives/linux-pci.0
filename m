Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:59207 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbbEKPNX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 May 2015 11:13:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org
Cc: Tina Ruchandani <ruchandani.tina@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-pci@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	xen-devel@lists.xenproject.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Y2038] [PATCH] xen/pcifront: Remove usage of struct timeval
Date: Mon, 11 May 2015 17:13:08 +0200
Message-ID: <2563996.ZdytTnlWmN@wuerfel>
In-Reply-To: <20150511024448.GA2836@tinar>
References: <20150511024448.GA2836@tinar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 11 May 2015 08:14:48 Tina Ruchandani wrote:
> struct timeval uses a 32-bit field for representing seconds,
> which will overflow in the year 2038 and beyond. This patch replaces
> struct timeval with 64-bit ktime_t which is 2038 safe.
> The patch is part of a larger effort to remove instances of
> 32-bit timekeeping variables (timeval, time_t and timespec)
> from the kernel.

The patch looks correct to me, just two minor points:

> +       tv = ktime_get_real();
> +       ns_timeout = ktime_to_ns(tv) + 2 * (s64)NSEC_PER_SEC;

* We have a macro for doing this in one line, so you can just use

	ns_timeout = ktime_get_real_ns() + 2 * (s64)NSEC_PER_SEC;

* As the time is not stored anywhere and only used in a local function,
  using monotonic time instead of real time would slightly more appropriate,
  the only difference being the handling of a concurrent settimeofday()
  system call. That means calling ktime_get_ns() instead of ktime_get_real_ns().

	Arnd
