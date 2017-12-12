Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.182]:64561 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdLLOde (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Dec 2017 09:33:34 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: 'Niklas Cassel' <niklas.cassel@axis.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "kishon@ti.com" <kishon@ti.com>, Niklas Cassel <niklass@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/3] Fix find_first_zero_bit() usage
Date: Tue, 12 Dec 2017 14:33:52 +0000
Message-ID: <5a6a30994101482c94f16203e3c8ba7d@AcuMS.aculab.com>
References: <20171212141634.5985-1-niklas.cassel@axis.com>
In-Reply-To: <20171212141634.5985-1-niklas.cassel@axis.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Niklas Cassel
> find_first_zero_bit()'s parameter 'size' is defined in bits,
> not in bytes.
> 
> Calling find_first_zero_bit() with the wrong size unit
> will lead to insidious bugs.
> 
> Fix all uses of find_first_zero_bit() called with
> sizeof() as size argument in drivers/pci.
...

Isn't all this code just using the wrong function.
Shouldn't they be using ffz() (or whatever it is called)
to find the first zero in a numeric argument rather that
find_first_zero_bit() which is intended for large bitmaps.

Perhaps the type for 'large bitmaps' should be:
struct {
	unsigned long bitmap_bits[0];
} bitmap;
rather than unsigned long[].

	David
