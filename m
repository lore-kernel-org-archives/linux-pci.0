Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65104C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 19:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DC220874
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 19:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545074844;
	bh=IxQGNH2zVpEsx2fey2TZS8e64ltzGTunkqa8K2lb3ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bXf02uMVYdEz95TZC7COCdWBhIMf3mnp62W3Cqn1eccgEC4byAKlN5tlZ3NKIwtlg
	 QKPqMdOv9O13dJG/6GTANKjlopvQRl0joWN+eG3NZdGe/38kJYZjQ11Ph2PCg6WKq7
	 EaZleKPsl8vxx/qWob+vyUs29WG3ZbPrpL5a/1Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbeLQT1X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:27:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbeLQT1X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 14:27:23 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56586217D9;
        Mon, 17 Dec 2018 19:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545074842;
        bh=IxQGNH2zVpEsx2fey2TZS8e64ltzGTunkqa8K2lb3ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myBMeijdcMGHWTmaOZ05RKquLnSeXLyRYEeZiPhwroVpDM3Jt33KTGPdXUz2TtTbg
         +T7EhXBZaUeX9OExisr0XteT2XQv0LW24SJK5GaO9INNXQ0uVqvZYp+pB7mDxOKPEn
         L/4uqvFZtNVMkB4PKvIbr4RxR0s0s/xNTwH9rMQg=
Date:   Mon, 17 Dec 2018 13:27:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI: Stub out read/write/raw/find functions
Message-ID: <20181217192721.GA28981@google.com>
References: <20181201204137.1786-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201204137.1786-1-okaya@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 01, 2018 at 08:41:35PM +0000, Sinan Kaya wrote:
> Need stub functions in order to be able to compile ACPI without PCI
> support.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

I can't tell where this series is since I only got the pieces that
touch PCI and the version numbers and n/n numbers don't make much
sense then, so apologies if I'm responding to an obsolete patch.

> ---
>  include/linux/pci.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 11c71c4ecf75..15407f469d41 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -682,10 +682,22 @@ struct pci_ops {
>   * ACPI needs to be able to access PCI config space before we've done a
>   * PCI bus scan and created pci_bus structures.
>   */
> +#ifdef CONFIG_PCI
>  int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
>  		 int reg, int len, u32 *val);
>  int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
>  		  int reg, int len, u32 val);
> +#else
> +static inline int raw_pci_read(unsigned int domain, unsigned int bus,
> +			       unsigned int devfn, int reg, int len, u32 *val)
> +{
> +	*val = 0;
> +	return -EINVAL;

Why do you return 0 here?  If a PCI config access fails, you usually
get ~0.

> +}
> +static inline int raw_pci_write(unsigned int domain, unsigned int bus,
> +				unsigned int devfn, int reg, int len, u32 val)
> +{ return -EINVAL; }
> +#endif
>  
>  #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>  typedef u64 pci_bus_addr_t;
> @@ -1599,7 +1611,27 @@ pci_release_mem_regions(struct pci_dev *pdev)
>  }
>  
>  #else /* CONFIG_PCI is not enabled */
> +static inline int pci_bus_read_config_byte(struct pci_bus *bus,
> +		unsigned int devfn, int where, u8 *val)
> +{ return -EINVAL; }

Should these set *val as well?  To ~0 (or 0) to match above, I assume?

> +static inline int pci_bus_read_config_word(struct pci_bus *bus,
> +		unsigned int devfn, int where, u16 *val)
> +{ return -EINVAL; }
> +static inline int pci_bus_read_config_dword(struct pci_bus *bus,
> +		unsigned int devfn, int where, u32 *val)
> +{ return -EINVAL; }
> +static inline int pci_bus_write_config_byte(struct pci_bus *bus,
> +		unsigned int devfn, int where, u8 val)
> +{ return -EINVAL; }
> +static inline int pci_bus_write_config_word(struct pci_bus *bus,
> +		unsigned int devfn, int where, u16 val)
> +{ return -EINVAL; }
> +static inline int pci_bus_write_config_dword(struct pci_bus *bus,
> +		unsigned int devfn, int where, u32 val)
> +{ return -EINVAL; }
> +static inline struct pci_bus *pci_find_bus(int domain, int busnr)
> +{ return NULL; }
>  static inline void pci_set_flags(int flags) { }
>  static inline void pci_add_flags(int flags) { }
>  static inline void pci_clear_flags(int flags) { }
> -- 
> 2.19.0
> 
