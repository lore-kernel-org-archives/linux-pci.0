Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51696 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917AbaBRNrW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 08:47:22 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, jgunthorpe@obsidianresearch.com
Subject: Re: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host controller
Date: Tue, 18 Feb 2014 14:46:44 +0100
Message-ID: <2340480.VAU4NNbBD8@wuerfel>
In-Reply-To: <1392726043-31088-4-git-send-email-will.deacon@arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com> <1392726043-31088-4-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 18 February 2014 12:20:43 Will Deacon wrote:

> +static int gen_pci_alloc_io_offset(u32 sz, resource_size_t *offset)
> +{
> +	static DECLARE_BITMAP(io_map, (IO_SPACE_LIMIT + 1) / SZ_64K);
> +	int idx, num_wins;
> +
> +	if (sz > SZ_64K)
> +		return -ENOSPC;
> +
> +	num_wins = (IO_SPACE_LIMIT + 1) / SZ_64K;
> +	idx = 0;
> +	do {
> +		idx = find_next_zero_bit(io_map, num_wins, idx);
> +		if (idx == num_wins)
> +			return -ENOSPC;
> +	} while (test_and_set_bit(idx, io_map));
> +
> +	*offset = idx * SZ_64K;
> +	return 0;
> +}

Sicne you're always starting the search at 0 and you never free
the map, this is essentially the same as remembering the last number
that was used and using the next one, right?

You should also pass the rang->pci_addr here to calculate the
offset in case the pci_addr is not zero.

> +	/* Register our I/O and Memory resources */
> +	res_valid = 0;
> +	list_for_each_entry(win, &pci->host.windows, list) {
> +		struct resource *parent;
> +
> +		if (resource_type(win->res) == IORESOURCE_IO) {
> +			parent = &ioport_resource;
> +			err = pci_ioremap_io(win->offset, win->res->start);

and consequently pass the pci_addr rather than the offset here. How about
moving the pci_ioremap_io() call into gen_pci_alloc_io_offset()?

	Arnd
