Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D198C64EB1
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BE8208E7
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544128493;
	bh=KZ6s2fJ1WWeh277p0EeDsjnOxayRM6gWMrFD0LbLPqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uocFEJjV72wn3ZnQeHd0TxtQNuAwCEK/N6+qWpqIdX2VbCXE6vOyi6jGxsV6lFMRZ
	 YZ4VQ++/laoQiLhK1OG1Rw+2ZLudD969EcEuPN/+k8WGw2SYCf3nCsH41iHPZr8mqU
	 oaupvJRlngLqfWRl0fonzIwUy7fQKeVlq9ELBTWs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BE8208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbeLFUew (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:34:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeLFUew (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Dec 2018 15:34:52 -0500
Received: from localhost (unknown [66.115.192.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D9C20892;
        Thu,  6 Dec 2018 20:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544128490;
        bh=KZ6s2fJ1WWeh277p0EeDsjnOxayRM6gWMrFD0LbLPqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FPVPdInLPH04jolZuycavZJteuK+BQhCtF8tENnzlbzsQchQeE189pGCwk2DEnNSy
         S3bgjmoqOaOVspCXJSvo9KlSXqbuBrkqbzmHkoxKq9Ns3YnLA2kQRLjaWYc3y40BOU
         3uGu6FEix0e9Y2Avk+39Yr1vsDrmmAPsp87diHjs=
Date:   Thu, 6 Dec 2018 14:34:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] pci: p2pdma: clean up documentation and kernel-doc
Message-ID: <20181206203449.GA247703@google.com>
References: <9f17c653-07dd-bf00-a4a2-fccbd9470603@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f17c653-07dd-bf00-a4a2-fccbd9470603@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 01, 2018 at 09:31:34AM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix typos, spellos, and grammar in p2pdma.rst and p2pdma.c.
> 
> Fix return value(s) in function pci_p2pmem_alloc_sgl().
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-pci@vger.kernel.org
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Logan Gunthorpe <logang@deltatee.com>

Applied with Logan's ack to pci/peer-to-peer for v4.21, thanks!

> ---
>  Documentation/driver-api/pci/p2pdma.rst |    4 ++--
>  drivers/pci/p2pdma.c                    |   14 +++++++-------
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> --- lnx-420-rc4.orig/Documentation/driver-api/pci/p2pdma.rst
> +++ lnx-420-rc4/Documentation/driver-api/pci/p2pdma.rst
> @@ -49,7 +49,7 @@ For example, in the NVMe Target Copy Off
>    in that it exposes any CMB (Controller Memory Buffer) as a P2P memory
>    resource (provider), it accepts P2P memory pages as buffers in requests
>    to be used directly (client) and it can also make use of the CMB as
> -  submission queue entries (orchastrator).
> +  submission queue entries (orchestrator).
>  * The RDMA driver is a client in this arrangement so that an RNIC
>    can DMA directly to the memory exposed by the NVMe device.
>  * The NVMe Target driver (nvmet) can orchestrate the data from the RNIC
> @@ -111,7 +111,7 @@ that's compatible with all clients using
>  If more than one provider is supported, the one nearest to all the clients will
>  be chosen first. If more than one provider is an equal distance away, the
>  one returned will be chosen at random (it is not an arbitrary but
> -truely random). This function returns the PCI device to use for the provider
> +truly random). This function returns the PCI device to use for the provider
>  with a reference taken and therefore when it's no longer needed it should be
>  returned with pci_dev_put().
>  
> --- lnx-420-rc4.orig/drivers/pci/p2pdma.c
> +++ lnx-420-rc4/drivers/pci/p2pdma.c
> @@ -422,7 +422,7 @@ static int upstream_bridge_distance_warn
>   *
>   * Returns -1 if any of the clients are not compatible (behind the same
>   * root port as the provider), otherwise returns a positive number where
> - * a lower number is the preferrable choice. (If there's one client
> + * a lower number is the preferable choice. (If there's one client
>   * that's the same as the provider it will return 0, which is best choice).
>   *
>   * For now, "compatible" means the provider and the clients are all behind
> @@ -493,7 +493,7 @@ EXPORT_SYMBOL_GPL(pci_has_p2pmem);
>   * @num_clients: number of client devices in the list
>   *
>   * If multiple devices are behind the same switch, the one "closest" to the
> - * client devices in use will be chosen first. (So if one of the providers are
> + * client devices in use will be chosen first. (So if one of the providers is
>   * the same as one of the clients, that provider will be used ahead of any
>   * other providers that are unrelated). If multiple providers are an equal
>   * distance away, one will be chosen at random.
> @@ -580,7 +580,7 @@ EXPORT_SYMBOL_GPL(pci_alloc_p2pmem);
>   * pci_free_p2pmem - free peer-to-peer DMA memory
>   * @pdev: the device the memory was allocated from
>   * @addr: address of the memory that was allocated
> - * @size: number of bytes that was allocated
> + * @size: number of bytes that were allocated
>   */
>  void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size)
>  {
> @@ -617,7 +617,7 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_virt_to_bus
>   * @nents: the number of SG entries in the list
>   * @length: number of bytes to allocate
>   *
> - * Returns 0 on success
> + * Return: %NULL on error or &struct scatterlist pointer and @nents on success
>   */
>  struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
>  					 unsigned int *nents, u32 length)
> @@ -673,7 +673,7 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_free_sgl);
>   *
>   * Published memory can be used by other PCI device drivers for
>   * peer-2-peer DMA operations. Non-published memory is reserved for
> - * exlusive use of the device driver that registers the peer-to-peer
> + * exclusive use of the device driver that registers the peer-to-peer
>   * memory.
>   */
>  void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
> @@ -733,7 +733,7 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg);
>   * @use_p2pdma: returns whether to enable p2pdma or not
>   *
>   * Parses an attribute value to decide whether to enable p2pdma.
> - * The value can select a PCI device (using it's full BDF device
> + * The value can select a PCI device (using its full BDF device
>   * name) or a boolean (in any format strtobool() accepts). A false
>   * value disables p2pdma, a true value expects the caller
>   * to automatically find a compatible device and specifying a PCI device
> @@ -784,7 +784,7 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_enable_stor
>   *		whether p2pdma is enabled
>   * @page: contents of the stored value
>   * @p2p_dev: the selected p2p device (NULL if no device is selected)
> - * @use_p2pdma: whether p2pdme has been enabled
> + * @use_p2pdma: whether p2pdma has been enabled
>   *
>   * Attributes that use pci_p2pdma_enable_store() should use this function
>   * to show the value of the attribute.
> 
> 
