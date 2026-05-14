Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A33B7769;
	Thu, 14 May 2026 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746281; cv=none; b=cyZXuT0uCBN08ZBdRBG6qEcSNN95UDkALqfA8S3oBMaMzZetEap0Mit1CmKZoYsX9R+TT0+k74pnPE3bxcAzAyDnjDHg42Umu1BFdmEGXxssDNDfdd4VXJPE11N/usBcKjvk9mRyDEGIw5ZU9Av3VV1l3p+lRZFX8ED39FNHPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746281; c=relaxed/simple;
	bh=K4epJ22JZqnDmCAILYzn9q4Tz0d9iQQNA367BTrZSyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLp4dkO+jjBKZy9RtbInnWmhOe8Eywt0T8OPwi/l3CnnRzHSWZ+/ZdhU1kXNQN/AJronRZs1oUaM2f/OfoG5w6VNs+pZ0/Jf3KTIsl8OgwHmDdQfRhBWJncqYd1BTHmOqihM06Pu7noTKumyHJlVkQEgWFYp4WtN3YYRfv2ZTvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwaS+Ved; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwaS+Ved"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08FFC2BCC7;
	Thu, 14 May 2026 08:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778746281;
	bh=K4epJ22JZqnDmCAILYzn9q4Tz0d9iQQNA367BTrZSyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwaS+VedP1H6Mhp7pH/NdKJC+ccQOUh26K1TFAim2CNArA/EDLJ6so8uWMcsKRAWL
	 +kLwvbRBo5z5l2ubvqWpzATl/g7iGy+iIjhSzjhLJbOHNSYvctsomUq2HeMmKFu4CL
	 ffHu4kv5/xBmNPPY5XDwWDT9sLS+AjC6rk1nBKXFtWrj4ck4DZIA0xGnHWJhtn49y2
	 qf7aIskKm4u88XnRxFRX7iYNEwIco2krLzlPyqnAeD2s1y4s03d7wBWtPiCb416OBb
	 NcB6TORA+DE98fhJnx3R4IS3VSHtNY80zl6Aw3dRj54DKtKAW1HILCwN28XJnXjY9b
	 pJJxims2QxPxQ==
Date: Thu, 14 May 2026 13:41:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, corbet@lwn.net, kishon@kernel.org, 
	skhan@linuxfoundation.org, lukas@wunner.de, cassel@kernel.org, alistair@alistair23.me, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, s-vadapalli@ti.com, 
	danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH v3 4/4] Documentation: PCI: Add documentation for DOE
 endpoint support
Message-ID: <z3a4z3yfrkgfhxvmlkmpgbibs2iab2pm7h7jn2wdniyicwwl3m@l7znjhfxij5v>
References: <20260427051725.223704-1-a-garg7@ti.com>
 <20260427051725.223704-5-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427051725.223704-5-a-garg7@ti.com>

On Mon, Apr 27, 2026 at 10:47:25AM +0530, Aksh Garg wrote:
> Document the architecture and implementation details for the Data Object
> Exchange (DOE) framework for PCIe Endpoint devices.
> 
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
> 
> Changes from v2 to v3:
> - Rebased on 7.1-rc1.
> 
> Changes since v1:
> - Squashed the patches [1] and [2], and moved the documentation file
>   to Documentation/PCI/endpoint/pci-endpoint-doe.rst to match the existing
>   naming scheme, as suggested by Niklas Cassel
> - Updated the documentation as per the design and implementaion changes
>   made to previous patches in this series:
>   * Updated for static protocol array instead of dynamic registration
>   * Documented asynchronous callback model
>   * Updated request/response flow with new callback signature
>   * Updated memory ownership: DOE core frees request, driver frees response
>   * Updated initialization and cleanup sections for new APIs
> 
> v2: https://lore.kernel.org/all/20260401073022.215805-5-a-garg7@ti.com/
> v1: [1] https://lore.kernel.org/all/20260213123603.420941-2-a-garg7@ti.com/
>     [2] https://lore.kernel.org/all/20260213123603.420941-5-a-garg7@ti.com/
> 
>  Documentation/PCI/endpoint/index.rst          |   1 +
>  .../PCI/endpoint/pci-endpoint-doe.rst         | 318 ++++++++++++++++++
>  2 files changed, 319 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-doe.rst
> 
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index dd1f62e731c9..7c03d5abd2ef 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -9,6 +9,7 @@ PCI Endpoint Framework
>  
>     pci-endpoint
>     pci-endpoint-cfs
> +   pci-endpoint-doe
>     pci-test-function
>     pci-test-howto
>     pci-ntb-function
> diff --git a/Documentation/PCI/endpoint/pci-endpoint-doe.rst b/Documentation/PCI/endpoint/pci-endpoint-doe.rst
> new file mode 100644
> index 000000000000..03b7a69516f3
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/pci-endpoint-doe.rst
> @@ -0,0 +1,318 @@
> +.. SPDX-License-Identifier: GPL-2.0-only or MIT
> +
> +.. include:: <isonum.txt>
> +
> +=============================================
> +Data Object Exchange (DOE) for PCIe Endpoint
> +=============================================
> +
> +:Copyright: |copy| 2026 Texas Instruments Incorporated
> +:Author: Aksh Garg <a-garg7@ti.com>
> +:Co-Author: Siddharth Vadapalli <s-vadapalli@ti.com>
> +
> +Overview
> +========
> +
> +DOE (Data Object Exchange) is a standard PCIe extended capability feature
> +introduced in the Data Object Exchange (DOE) ECN for PCIe r5.0. It is an optional
> +mechanism for system firmware/software running on root complex (host) to perform
> +:ref:`data object <data-object-term>` exchanges with an endpoint function. Each
> +data object is uniquely identified by the Vendor ID of the vendor publishing the
> +data object definition and a Data Object Type value assigned by that vendor.
> +
> +Think of DOE as a sophisticated mailbox system built into PCIe. The root complex
> +can send structured requests to the endpoint device through DOE mailboxes, and
> +the endpoint device responds with appropriate data. DOE mailboxes are implemented
> +as PCIe Extended Capabilities in endpoint devices, allowing multiple mailboxes
> +per function, each potentially supporting different data object protocols.
> +
> +The DOE support for root complex devices has already been implemented in
> +``drivers/pci/doe.c``.
> +
> +How DOE Works
> +=============
> +
> +The DOE mailbox operates through a simple request-response model:
> +
> +1. **Host sends request**: The root complex writes a data object (vendor ID, type,
> +   and payload) to the DOE write mailbox register (one DWORD at a time) of the
> +   endpoint function's config space and sets the GO bit in the DOE Status register
> +   to indicate that a request is ready for processing.
> +2. **Endpoint processes**: The endpoint function reads the request from DOE write
> +   mailbox register, sets the BUSY bit in the DOE Status register, identifies the
> +   protocol of the data object, and executes the appropriate handler.
> +3. **Endpoint responds**: The endpoint function writes the response data object to the
> +   DOE read mailbox register (one DWORD at a time), and sets the READY bit in the DOE
> +   Status register to indicate that the response is ready. If an error occurs during
> +   request processing (such as unsupported protocol or handler failure), the endpoint
> +   sets the ERROR bit in the DOE Status register instead of the READY bit.
> +4. **Host reads response**: The root complex retrieves the response data from the DOE read
> +   mailbox register once the READY bit is set in the DOE Status register, and then writes
> +   any value to this register to indicate a successful read. If the ERROR bit was set,
> +   the root complex discards the response and performs error handling as needed.
> +
> +Each mailbox operates independently and can handle one transaction at a time. The
> +DOE specification supports data objects of size up to 256KB (2\ :sup:`18` dwords).
> +
> +For complete DOE capability details, refer to `PCI Express Base Specification Revision 7.0,
> +Section 6.30 - Data Object Exchange (DOE)`.
> +
> +Key Terminologies
> +=================
> +
> +.. _data-object-term:
> +
> +**Data Object**
> +  A structured, vendor-defined, or standard-defined message exchanged between
> +  root complex and endpoint function via DOE capability registers in configuration
> +  space of the function.
> +
> +**Mailbox**
> +  A DOE capability on the endpoint device, where each physical function can have
> +  multiple mailboxes.
> +
> +**Protocol**
> +  A specific type of DOE communication data object identified by a Vendor ID and Type.
> +
> +**Handler**
> +  A function that processes DOE requests of a specific protocol and generates responses.
> +
> +Architecture of DOE Implementation for Endpoint
> +===============================================
> +
> +.. code-block:: text
> +
> +       +------------------+
> +       |                  |
> +       |   Root Complex   |
> +       |                  |
> +       +--------^---------+
> +                |
> +                | Config space access
> +                |   over PCIe link
> +                |
> +     +----------v-----------+
> +     |                      |
> +     |    PCIe Controller   |
> +     |      as Endpoint     |
> +     |                      |
> +     |  +-----------------+ |
> +     |  |   DOE Mailbox   | |
> +     |  +-------^---------+ |
> +     +----------|-----------+
> +    +-----------|---------------------------------------------------------------+
> +    |           |                                       +--------------------+  |
> +    | +---------v--------+           Allocate           |  +--------------+  |  |
> +    | |                  |-------------------------------->|   Request    |  |  |
> +    | |   EP Controller  |                            +--->|    Buffer    |  |  |
> +    | |      Driver      |             Free           | |  +--------------+  |  |
> +    | |                  |--------------------------+ | |                    |  |
> +    | +--------^---------+                          | | |                    |  |
> +    |          |                                    | | |                    |  |
> +    |          |                                    | | |                    |  |
> +    |          | pci_ep_doe_process_request()       | | |                    |  |
> +    |          |                                    | | |                    |  |
> +    | +--------v---------+             Free         | | |                    |  |
> +    | |                  |----------------------------+ |         DDR        |  |
> +    | |    DOE EP Core   |<----+                    |   |                    |  |
> +    | |    (doe-ep.c)    |     |     Discovery      |   |                    |  |
> +    | |                  |-----+  Protocol Handler  |   |                    |  |
> +    | +--------^---------+                          |   |                    |  |
> +    |          |                                    |   |                    |  |
> +    |          | protocol_handler()                 |   |                    |  |
> +    |          |                                    |   |                    |  |
> +    | +--------v---------+                          |   |                    |  |
> +    | |                  |                          |   |  +--------------+  |  |
> +    | | Protocol Handler |                          +----->|   Response   |  |  |
> +    | |      Module      |-------------------------------->|    Buffer    |  |  |
> +    | | (CMA/SPDM/Other) |           Allocate           |  +--------------+  |  |
> +    | |                  |                              |                    |  |
> +    | +------------------+                              |                    |  |
> +    |                                                   +--------------------+  |
> +    +---------------------------------------------------------------------------+
> +
> +Initialization and Cleanup
> +--------------------------
> +
> +**Framework Initialization and DOE Setup**
> +
> +The EPC core provides the ``pci_epc_doe_setup(epc)`` API for centralized DOE
> +mailbox discovery and registration. The controller driver calls this API during
> +its probe sequence if DOE is supported.
> +
> +This API performs the following steps:
> +
> +1. Calls ``pci_ep_doe_init(epc)``, which initializes the xarray data structure
> +   (a resizable array data structure defined in linux) named ``doe_mbs`` that
> +   stores metadata of DOE mailboxes for the controller in ``struct pci_epc``.
> +2. Discovers all DOE capabilities in the endpoint function's configuration space
> +   for each function. For each discovered DOE capability, calls
> +   ``pci_ep_doe_add_mailbox(epc, func_no, cap_offset)`` to register the mailbox.
> +
> +Each DOE mailbox structure created by ``pci_ep_doe_add_mailbox()`` gets an
> +ordered workqueue allocated for processing DOE requests sequentially for that
> +mailbox, enabling concurrent request handling across different mailboxes. Each
> +mailbox is uniquely identified by the combination of physical function number
> +and capability offset for that controller.
> +
> +**Cleanup**
> +
> +The EPC core provides the ``pci_epc_doe_destroy(epc)`` API for centralized DOE
> +cleanup. The controller driver calls this API during its remove sequence
> +if DOE is supported.
> +
> +This API calls ``pci_ep_doe_destroy(epc)``, which destroys all registered
> +mailboxes, cancels any pending tasks, flushes and destroys the workqueues,
> +and frees all memory allocated to the mailboxes.
> +

As I mentioned in patch 3, we should call these APIs within the EPC core and not
sprinkle throughout the EPC drivers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
