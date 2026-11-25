Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795594988;
	b=zwzavA2FgWZXI4tFpar/lCjFZZ50/w4bLf6QBhNVz3aWQO9RRRj+A/E2eA97AOlRnRV5
	 b/yF/zQRUkbC9V9qgVBPXFEE3lalas+SKP6OxobTAjcawkMR/O3f/NvG9ySlCrw/ehjY5
	 ZwycEGRXJi5OGlEGWQMBPd2VhR5Xnh6Wa54OX/qN4QcLxcD3kX5eBoJaefrcajUdYbprO
	 MfHPaQR1gLHarzR1hVdv0jCvyFD6m5xvVh/1HC5Ac2seshY6F5LFqLJ5xFSgC3YQDL+Jv
	 Ls4eFy8Hft87CnUF3/HQuRjNh02nm+Mjst6O7BOHQE1r0gwvwqdcR/JFeTIQY/aIsXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594988;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=uNybJMbMTjSA7ZZcWlQYQU8MlFHRVpDuABhvHlqOToo=;
	b=3E6j38j/Peo/W3u6iYeZ3sVYg1MJREdxHL/uFbSQlGdkMJckya7Pz715JTf/JiWLkQZS
	 MeDuZqsOgA6erJaYeEwiDlh5jOYBevTgtVhj8o1SvYVkM+BTXvrvXrNHKjRSHRLThATiR
	 xWNi4IBdxz2qLZw8xDPhIYrZ421H4lnJkzpV0V0R6gCEi5IWHMULq60zeYt9VEE7eI/ih
	 uw34R64IFHlYug2G0QF7fp99HWsy7cSKZ1WVEo0Y30VGkbnXtnlfC/xj1Gl6J6zg2YvgQ
	 yZi0tJO5q/+oZROiF7kpKnie7yKn5JffRwPKsN7iXDvhoH64/r4MmibCJuUR1OXJxAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Hx+CY+Md;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD7D606A32E;
	Wed, 25 Nov 2026 08:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBD7D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Hx+CY+Md
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B0B45C2BB3E;
	Wed, 25 Nov 2026 08:23:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B77A960480;
	Wed, 25 Nov 2026 08:23:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2F3A11E6929F;
	Wed, 25 Nov 2026 09:22:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795594981; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uNybJMbMTjSA7ZZcWlQYQU8MlFHRVpDuABhvHlqOToo=;
	b=Hx+CY+MdlcBHskvgsPz/EZoyN+RpIKBjjgZ1d8pt+Uzc62IQAftvqcbYZc4buUfDHHIlcb
	iLOWhlJuYSoYowQrRUwFv0od2eHHVOFj+rNLHW+1iYWk+S6tVqoFYqXiZMqexCI7NvAaCq
	kkgp5Wq2jhuQAABmvbd50+kpEQIy4ULwV/wygKSj4T35++WLTBnXXx05S9hkMH2hFYX3yg
	/yLpXIGZTENyxHO72+HdSRcC7C+MCJ9XmsRB/tqnU6lz8TeRyY5tMp+hDQGIKJJru+E0FN
	musR9Hk9FSDzVa1rPfF7hXkK+BlG1U3m+Ovc/z6r8jID84oI06p5fsmqpiTgxQ==
Date: Wed, 25 Nov 2026 09:22:40 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>, Richard Cheng
 <icheng@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Johan Hovold
 <johan@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, David Rhodes
 <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, Linus Walleij
 <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, Len
 Brown <lenb@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan
 Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Herve Codina
 <herve.codina@bootlin.com>, Lizhi Hou <lizhi.hou@amd.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v14 00/10] lan966x pci device: Add support for SFPs, PCI
 part
Message-ID: <20261125092240.43499f8f@bootlin.com>
In-Reply-To: <20261103155540.365294-1-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Bjorn, Maintainers,

Just a gentle ping on this series, as it has been three weeks since it was
posted and hasn't received any feedback yet.

Please let me know if any changes or clarifications are needed from my side,
or if it looks good to be applied.

Best regards,
Hervé


On Tue,  3 Nov 2026 16:55:06 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi,
> 
> Previously, I sent a big picture series adding support for SFP ports
> available on the LAN966x PCI device [0].
> 
> In this series patches touch several parts and sub-system in the kernel.
> Reviews have be done and it makes sense to split the series and send
> parts separately.
> 
> This current series is the extraction of patches related to issues in
> the PCI subsystem. It has to be seen as a continuation of the big
> picture series but related to this specific core part.
> 
> Patches 1 to 6 introduce and use fw_devlink_set_device() in already
> existing code. No functional change but the introduction of the
> fw_devlink_set_device() wrapper.
> 
> Patch 7 avoids a dangling pointer.
> 
> Patches 8 and 9 fix fw_devlink issues specific to PCI and the
> device-tree nodes created during enumeration.
> 
> Patch 10 avoids the usage of np->data and adds guards to prevent
> incorrect nodes removal.
> 
> [0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/
> 
> Best regards,
> Hervé
> 
> Changes:
> 
> v13 -> v14
>   v13: https://lore.kernel.org/all/20261012142826.159178-1-herve.codina@bootlin.com/
> 
>   Rebase on top of v7.4-rc1
> 
>   - Patches 1, 2, 6, 8, 9
>     Add 'Tested-by: Abdurrahman Hussain'
> 
>   - Patch 10:
>     Add 'Acked-by: Bjorn Helgaas'
> 
>   - Other patches:
>     No changes
> 
> v12 -> v13
>   v12: https://lore.kernel.org/all/20261001142815.277550-1-herve.codina@bootlin.com/
> 
>   - Patches 1 to 9
>     No changes
> 
>   - Patch 10
>     Split a test condition into two distinct checks as suggested by
>     Andy. No functional change but readability improvement. Split done
>     in both of_pci_remove_node() and of_pci_remove_host_bridge_node().
> 
> v11 -> v12
>   v11: https://lore.kernel.org/all/20260909080114.591938-1-herve.codina@bootlin.com/
> 
>   - Patches 1 to 7
>     Add 'Reviewed-by: Bartosz Golaszewski'
> 
>   - Patches 8 and 9
>     No changes
> 
>   - Patch 10
>     Add a NULL check for the retrieved OF node in removal functions to
>     avoid any NULL pointer dereferences.
>     Robustify the guard setting cset to NULL after freeing it.
>     Those issues have been reported by Shashiko:
>     https://lore.kernel.org/all/20260909081755.444E91F00A3A@smtp.kernel.org/
> 
> v10 -> v11
>   v10: https://lore.kernel.org/all/20260717145147.823749-1-herve.codina@bootlin.com/
> 
>   Rebase on top of v7.3-rc1
> 
>   - Patches 1 to 5
>     Add 'Reviewed-by: Richard Cheng'
> 
>   - Patches 6, 7 and 8
>     Add 'Reviewed-by: Richard Cheng'
>     Add 'Acked-by: Manivannan Sadhasivam'
> 
>   - Patch 9
>     Add 'Reviewed-by: Richard Cheng'
> 
>   - Patch 10
>     Rework removing np->data usage in the PCI devicetree node creation
>     and removal.
> 
> v9 -> v10
>   v9: https://lore.kernel.org/all/20260708100302.517792-1-herve.codina@bootlin.com/
> 
>   - Patches 1 to 6
>     No changes
> 
>   - Patch 7
>     Clear fwnode->dev also on error path.
> 
>   - Patch 8
>     Clear fwnode->dev also on error path.
> 
>   - Patch 9
>     No changes
> 
>   - Patch 10 (New patch in v10)
>     Guard against node removal with incorrect np->data.
> 
> v8 -> v9
>   v8: https://lore.kernel.org/all/20260630102804.413563-1-herve.codina@bootlin.com/
> 
>   - Patch 7 (new patch in v9)
>     Clear fwnode->dev during root bridge node removal (avoid a dangling
>     pointer).
> 
>   - Patch 8 (patch 7 in v8)
>     Clear fwnode->dev during PCI device node removal.
> 
> v7 -> v8
>   v7: https://lore.kernel.org/all/20260511155930.34604-1-herve.codina@bootlin.com/
> 
>   Rebase on top of v7.2-rc1
> 
>   - patches 4 and 5
>     Add 'Reviewed-by: Andy Shevchenko'
> 
>   - Other Patches
>     No other changes
> 
> v6 -> v7
> 
>   Rebase on top of v7.1-rc1
> 
>   - Patch 1
>      Add Cc stable. Needed for patches 11 and 12
> 
>   - Patches 2 to 5
>     No changes
> 
>   - Patch 6
>      Add Cc stable. Needed for patch 13
>      Add 'Acked-by: Bjorn Helgaas'
> 
>   - Patch 7
>      Fix a typo in commit log
>      Add Fixes tag + Cc stable
>      Add 'Acked-by: Bjorn Helgaas'
> 
>   - Patch 8
>      Add Fixes tag + Cc stable
>      Add 'Acked-by: Bjorn Helgaas'
> Older iterations:
>   Patches 6 to 13 in the big picture series
>   https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/
> 
> Herve Codina (10):
>   driver core: fw_devlink: Introduce fw_devlink_set_device()
>   drivers: core: Use fw_devlink_set_device()
>   pinctrl: cs42l43: Use fw_devlink_set_device()
>   cxl/test: Use device_set_node()
>   cxl/test: Use fw_devlink_set_device()
>   PCI: of: Use fw_devlink_set_device()
>   PCI: of: Clear fwnode->dev during root bridge node removal and error
>     path
>   PCI: of: Set fwnode device of newly created PCI device nodes
>   PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge
>     node
>   PCI: of: Avoid np->data usage for the node changeset
> 
>  drivers/base/core.c                      |  4 +-
>  drivers/pci/of.c                         | 52 ++++++++++++++++--------
>  drivers/pinctrl/cirrus/pinctrl-cs42l43.c |  2 +-
>  include/linux/fwnode.h                   |  6 +++
>  include/linux/pci.h                      | 11 +++++
>  tools/testing/cxl/test/cxl.c             |  4 +-
>  6 files changed, 58 insertions(+), 21 deletions(-)
> 



-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
