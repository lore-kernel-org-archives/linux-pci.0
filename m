Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941F51D6BB;
	Thu, 11 Jun 2026 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205181; cv=none; b=CM6GWh65fju9KPDZSluFtxL5FlJD3m03LuGeBfcyijvopf2o7sEUr0UBxh3wcGf16l8Xzi/7zRhIn84GWeKRzSF1aJwEugMJZcp46qa7LcBMOFSxDHVHrx2vzDLyaGITUsi2MzrUSqvWmBGNvWMt1/SxJ+9wmPxgQcRu1QkagFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205181; c=relaxed/simple;
	bh=NUV+Wy0xwk7uW67evgRfbeyRWQAKhfUBfFHswstTCBE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aKSeiwJMIxNqVZWAbXwCpHdl2ZmewRRrw/X5yVoEcYguOKtVQJiV3/8fytQ5k+SbKLSeOdzcdwMQSHfnZSo68/0Jc8sleW2UKe4K+SC9ZM3rt9nzDhmxjoc6/CHUcANBiA6vq5u7W4y6pm84QpFF1+jDRg8inoHcNUdgbhgwcp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPN7fDQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPN7fDQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122791F000E9;
	Thu, 11 Jun 2026 19:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781205179;
	bh=FLlDXpMBOgXcLrZZAA8X9n7Ll6VFvUiEPBI4SzA/Hy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=kPN7fDQ3uxZmaXnZw2DfKXDsJ0S3q/HpYvucPrvQt38LYssg5egdWc3/30IuE/5wT
	 th85sgYQHeRKV1mToYfjfrM5lFXS6r950HmVk1jeZX8P3RBSIYCS4fLq4slfQDG16e
	 /sTiQE0epzPsB1EV/JYBIxo9UxQkalMXRmyZrnSttEriRc+vOvbCD3HsI4Cp/zyp++
	 sUHUZQfds/mnJnBlQKCQXNNtckrtgcdiH9TpGYQECqhFp9xCOKsCBWanbcFKdjIGd+
	 bcefYHfI9EnmlfEaC6c94De/ArqMEG1FYBVEqrTdcN3QRGAvf/3QmVpfoTZQf9yt0+
	 UgDoOoRJjixEw==
Date: Thu, 11 Jun 2026 14:12:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, corbet@lwn.net,
	kishon@kernel.org, skhan@linuxfoundation.org, lukas@wunner.de,
	cassel@kernel.org, alistair@alistair23.me,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com, srk@ti.com
Subject: Re: [PATCH v5 4/4] Documentation: PCI: Add documentation for DOE
 endpoint support
Message-ID: <20260611191258.GA501391@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610100256.1889111-5-a-garg7@ti.com>

On Wed, Jun 10, 2026 at 03:32:56PM +0530, Aksh Garg wrote:
> Document the architecture and implementation details for the Data Object
> Exchange (DOE) framework for PCIe Endpoint devices.
> 
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---
> 
> Changes from v4 to v5:
> - Updated the DOE Abort handling setion.
> 
> Changes from v3 to v4:
> - Updated the maximum size of the DOE object from 256KB to 1MB,
>   as per PCIe spec.
> - Updated the DOE setup and cleanup sections.
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
> v4: https://lore.kernel.org/all/20260522052434.802034-5-a-garg7@ti.com/
> v3: https://lore.kernel.org/all/20260427051725.223704-5-a-garg7@ti.com/
> v2: https://lore.kernel.org/all/20260401073022.215805-5-a-garg7@ti.com/
> v1: [1] https://lore.kernel.org/all/20260213123603.420941-2-a-garg7@ti.com/
>     [2] https://lore.kernel.org/all/20260213123603.420941-5-a-garg7@ti.com/
> 
>  Documentation/PCI/endpoint/index.rst          |   1 +
>  .../PCI/endpoint/pci-endpoint-doe.rst         | 333 ++++++++++++++++++
>  2 files changed, 334 insertions(+)
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
> index 000000000000..679844e36493
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/pci-endpoint-doe.rst
> @@ -0,0 +1,333 @@
> +.. SPDX-License-Identifier: GPL-2.0-only OR MIT
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

Cite spec r7.0 as you do below, not ECN.

Wrap all to fit in 75-78 columns.

> +mechanism for system firmware/software running on root complex (host) to perform
> +:ref:`data object <data-object-term>` exchanges with an endpoint function. Each
> +data object is uniquely identified by the Vendor ID of the vendor publishing the

s/vendor ID/Vendor ID/ throughout, for consistency here and to match spec.

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

s/type/Type/
s/payload/Payload/ to match usage below and to indicate that these are
termed defined by the PCIe spec.

> +   endpoint function's config space and sets the GO bit in the DOE Control register

s/GO/DOE Go/ throughout to match spec.

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
> +DOE specification supports data objects of size up to 1MB (2\ :sup:`18` dwords).
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
> +    | |  (pci-ep-doe.c)  |     |     Discovery      |   |                    |  |
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
> +The EPC core automatically initializes and sets up DOE mailboxes through the
> +``pci_epc_init_capabilities()`` internal function, which is invoked during
> +``pci_epc_init_notify()`` when the controller driver calls this API.
> +Controller drivers do not need to explicitly handle DOE initialization,
> +rather the EPC core manages this transparently.
> +
> +DOE initialization only occurs when the EPC driver reports DOE capability
> +through the ``doe_capable`` flag in its ``pci_epc_features``.
> +
> +This internal function performs the following steps:
> +
> +1. Calls ``pci_ep_doe_init(epc)`` to initialize the xarray data structure
> +   (a resizable array data structure defined in linux) named ``doe_mbs`` that
> +   stores metadata of DOE mailboxes for the controller in ``struct pci_epc``.
> +2. Calls ``pci_epc_doe_setup(epc)`` to discover all DOE capabilities in the
> +   endpoint function's configuration space for each function. For each
> +   discovered DOE capability, calls ``pci_ep_doe_add_mailbox(epc, func_no,
> +   cap_offset)`` to register the mailbox.
> +
> +Each DOE mailbox structure created by ``pci_ep_doe_add_mailbox()`` gets an
> +ordered workqueue allocated for processing DOE requests sequentially for that
> +mailbox, enabling concurrent request handling across different mailboxes. Each
> +mailbox is uniquely identified by the combination of physical function number
> +and capability offset for that controller.
> +
> +**Cleanup**
> +
> +The EPC core automatically cleans up DOE mailboxes through the
> +``pci_epc_deinit_capabilities()`` internal function, which is invoked during
> +``pci_epc_deinit_notify()`` when the controller driver calls this API.
> +Controller drivers do not need to explicitly handle DOE cleanup, rather
> +the EPC core manages this transparently.
> +
> +DOE cleanup only occurs when the EPC device reported DOE capability
> +through the ``doe_capable`` flag in its ``pci_epc_features``.
> +
> +This internal function calls ``pci_ep_doe_destroy(epc)``, which destroys all
> +registered mailboxes, cancels any pending tasks, flushes and destroys the
> +workqueues, and frees all memory allocated to the mailboxes.
> +
> +Protocol Handler Support
> +------------------------
> +
> +Protocol implementations (such as CMA, SPDM, or vendor-specific protocols) are
> +supported through a static array of protocol handlers.
> +
> +When a new DOE protocol library is introduced, its handler function is added to
> +the static ``pci_doe_protocols`` array in ``drivers/pci/endpoint/pci-ep-doe.c``.
> +The discovery protocol (VID = 0x0001 (PCI-SIG vendor ID), Type = 0x00 (discovery
> +protocol)) is included in this static array and handled internally by the
> +DOE EP core.
> +
> +Request Handling
> +----------------
> +
> +The complete flow of a DOE request from the root complex to the response:
> +
> +**Step 1: Root Complex → EP Controller Driver**
> +
> +The root complex writes a DOE request (Vendor ID, Type, and Payload) to the
> +DOE write mailbox register in the endpoint function's configuration space and sets

s/write mailbox register/Write Data Mailbox Register/ to match spec.

Specifically, "in the endpoint function's DOE Capability".

> +the GO bit in the DOE Control register, indicating that the request is ready for
> +processing.
> +
> +**Step 2: EP Controller Driver → DOE EP Core**
> +
> +The controller driver reads the request header to determine the data object
> +length. Based on this length field, it allocates a request buffer in memory
> +(DDR) of the appropriate size. The driver then reads the complete request
> +payload from the DOE write mailbox register and converts the data from
> +little-endian format (the format followed in the PCIe transactions over the
> +link) to CPU-native format using ``le32_to_cpu()``. The driver defines a
> +completion callback function with signature ``void (*complete)(struct pci_epc *epc,
> +u8 func_no, u16 cap_offset, int status, u16 vendor, u8 type, void *response_pl,
> +size_t response_pl_sz)`` to be invoked when the request processing completes.
> +The driver then calls ``pci_ep_doe_process_request(epc, func_no, cap_offset,
> +vendor, type, request, request_sz, complete)`` to hand off the request to the
> +DOE EP core. This function returns immediately after queuing the work
> +(without blocking), and the driver sets the BUSY bit in the DOE Status register.
> +
> +**Step 3: DOE EP Core Processing**
> +
> +The DOE EP core creates a task structure and submits it to the mailbox's ordered
> +workqueue. This ensures that requests for each mailbox are processed
> +sequentially, one at a time, as required by the DOE specification. It looks up
> +the protocol handler based on the Vendor ID and Type from the request header,
> +and executes the handler function.
> +
> +**Step 4: Protocol Handler Execution**
> +
> +The workqueue executes the task by calling the registered protocol handler:
> +``handler(request, request_sz, &response, &response_sz)``. The handler processes
> +the request, allocates a response buffer in memory (DDR), builds the response
> +data, and returns the response pointer and size. For the discovery protocol,
> +the DOE EP core handles this directly without invoking an external handler.
> +
> +**Step 5: DOE EP Core → EP Controller Driver**
> +
> +After the protocol handler completes, the DOE EP core frees the request buffer,
> +and invokes the completion callback provided by the controller driver asynchronously.
> +The callback receives the struct pci_epc, function number, capability offset (to
> +identify the mailbox), status code indicating the result of request processing,
> +vendor ID and type of the data object, the response buffer, and its size.
> +
> +**Step 6: EP Controller Driver → Root Complex**
> +
> +The controller driver converts the response from CPU-native format to
> +little-endian format using ``cpu_to_le32()``, writes the response to DOE read
> +mailbox register, and sets the READY bit in the DOE Status register. The root
> +complex then reads the response from the read mailbox register. Finally, the controller
> +driver frees the response buffer (which the handler allocated).

s/READY/Data Object Read/ to match spec

s/read mailbox/DOE Read Data Mailbox/ throughout to match spec

> +Asynchronous Request Processing
> +-------------------------------
> +
> +The DOE-EP framework implements asynchronous request processing because an
> +endpoint function can have multiple instances of DOE mailboxes, and requests may
> +be interleaved across these mailboxes. Request processing of one mailbox should
> +not result in blocking request processing of other mailboxes. Hence, requests
> +on each mailbox need to be handled in parallel for optimization.
> +
> +For the EP controller driver to handle requests on multiple mailboxes in
> +parallel, ``pci_ep_doe_process_request()`` must be asynchronous. The function
> +returns immediately after submitting the request to the mailbox's workqueue,
> +without waiting for the request to complete. A completion callback provided by
> +the controller driver is invoked asynchronously when request processing
> +finishes. This asynchronous design enables concurrent processing of requests
> +across different mailboxes.
> +
> +Abort Handling
> +--------------
> +
> +The DOE specification allows the root complex to abort ongoing DOE operations
> +by setting the ABORT bit in the DOE Control register.

Use spec name for ABORT

> +**Trigger**
> +
> +When the root complex sets the ABORT bit, the EP controller driver detects this
> +condition (typically in an interrupt handler or register polling routine). The
> +action taken depends on the timing of the abort:
> +
> +- **ABORT before request transfer**: If the ABORT bit is set before the root complex
> +  transfers the request to the mailbox registers, the controller driver should not
> +  call ``pci_ep_doe_abort()`` API.
> +
> +- **ABORT during request transfer**: If the ABORT bit is set while the root complex
> +  is still transferring the request to the mailbox registers, the controller driver
> +  should discard the request, and should not call ``pci_ep_doe_abort()`` and
> +  ``pci_ep_doe_process_request()`` APIs in the respective IRQ handlers.
> +
> +- **ABORT after request submission**: If the ABORT bit is set after the request
> +  has been fully received and submitted to the DOE EP core via
> +  ``pci_ep_doe_process_request()``, the controller driver must call
> +  ``pci_ep_doe_abort(epc, func_no, cap_offset)`` for the affected mailbox to
> +  perform abort sequence in the DOE EP core.
> +
> +**Abort Sequence**
> +
> +The abort function sets the CANCEL flag on the mailbox to prevent queued requests
> +from starting. Instead of waiting for the workqueue to flush, it returns immediately.
> +
> +The CANCEL flag gets cleared after invoking the completion callback, allowing the
> +mailbox to accept new requests.

I guess "CANCEL" is a software thing.  Using the spec names for the
hardware bits will help distinguish CANCEL, ABORT, ERROR, BUSY, etc.

> +Queued requests that have not started execution will be aborted with an error
> +status. The currently executing request will complete normally, and the controller
> +will reject the response if it arrives after the abort sequence has been triggered.
> +
> +.. note::
> +   Independent of when the ABORT bit is triggered, the controller driver must
> +   clear the ERROR, BUSY, and READY bits in the DOE Status register after
> +   completing the abort operation to reset the mailbox to an idle state.
> +
> +Error Handling
> +--------------
> +
> +Errors can occur during DOE request processing for various reasons, such as
> +unsupported protocols, handler failures, or memory allocation failures.
> +
> +**Error Detection**
> +
> +When an error occurs during DOE request processing, the DOE EP core propagates this error
> +back to the controller driver either through the ``pci_ep_doe_process_request()`` return value,
> +or the status code passed to the completion callback.
> +
> +**Error Response**
> +
> +When the controller driver receives an error code, it sets the ERROR bit in the DOE Status
> +register instead of writing a response to the read mailbox register, and frees the buffers.
> +
> +API Reference
> +=============
> +
> +.. kernel-doc:: drivers/pci/endpoint/pci-ep-doe.c
> +   :export:
> -- 
> 2.34.1
> 
