Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EBF279792
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 00:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041091; cv=none; b=ckIwd2Cb+gSzK0eEmx2qial/bnepi51ztnVg2i1KiCL5PwVT0f1ompT9kEI8I6fjsSRKl3D5YYW/wuew7Jzn1d9jjZMXJapYFASjBYHP60XAi0bzDwEw3DP0TldUDF4oqVpjD/dGG6F8VIS/qwHZ+hHorzb0mxMi9Aww6vVWtMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041091; c=relaxed/simple;
	bh=RvY3CWGtgvRFdFn9FaPl6TtsowWqn9t9vFU9KNYnNn8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IUvJA8rRizniWJGvwnzcj0+/32hbfe/6K/JNfipZknRoE/zVs3qcm6/Ad/HT5SdI6Q6ZzzTsGwVRDqhnVlivSVzR6fX258ybf2s4FMi16QIbPi/36tdej5AweUz52LLowGj1Ovk9uH80r83oj9J+6nef/lbZ3rzoXTx/SkmAeHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uu++wl3t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uu++wl3t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84DAC4CEF1;
	Thu, 22 Jan 2026 00:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769041091;
	bh=RvY3CWGtgvRFdFn9FaPl6TtsowWqn9t9vFU9KNYnNn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uu++wl3tpTckZsn6eKA5id3lgKVUJnQaFgcjB7BKA4BugqXLEaM/WUI5Esl5S5z7G
	 SJvcz/QNoQaxcA8L+G6tzsqnyCQGzChlrAKEzDCXa5QI8orNiJA9QvdXtZ8K3h4WQ6
	 nAKDwgRQfcWnUh9HCeGZmjkt8Eel3ItMI5b+YfgRiGuWYy/s6zkwPsnoapI7BROwKZ
	 pMyBr+Q5Y9pDo9krkLJaHuWCo/kg6laiffuOt1ufgIqeABK70z20/53kHcKRUkDxSI
	 lGDwedM7Z3abeG4OkubzqM0UxSNDHKj8LH231we0+BsRbXWOU01HXm6+MerMiZmfM0
	 GmgphrBXRCD3A==
Date: Wed, 21 Jan 2026 18:18:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?SsO2cmc=?= Wedekind <joerg@wedekind.de>
Cc: linux-pci@vger.kernel.org, aradford@gmail.com
Subject: Re: PCI: Mark 3ware-9650SA Root Port Extended Tags as broken
Message-ID: <20260122001809.GA1225722@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119143114.21948-1-joerg@wedekind.de>

On Mon, Jan 19, 2026 at 03:31:10PM +0100, Jörg Wedekind wrote:
> Per PCIe r6.1, sec 2.2.6.2 and 7.5.3.4, a Requester may not use 8-bit Tags
> unless its Extended Tag Field Enable is set, but all Receivers/Completers
> must handle 8-bit Tags correctly regardless of their Extended Tag Field
> Enable.
> 
> Some devices do not handle 8-bit Tags as Completers, so add a quirk for
> them.  If we find such a device, we disable Extended Tags for the entire
> hierarchy to make peer-to-peer DMA possible.
> 
> The 3ware 9650SA seems to have issues with handling 8-bit tags. Mark it as
> broken.
> 
> This fixes PCI Parity Errors like :
> 
>   3w-9xxx: scsi0: ERROR: (0x06:0x000C): PCI Parity Error: clearing.
>   3w-9xxx: scsi0: ERROR: (0x06:0x000D): PCI Abort: clearing.
>   3w-9xxx: scsi0: ERROR: (0x06:0x000E): Controller Queue Error: clearing.
>   3w-9xxx: scsi0: ERROR: (0x06:0x0010): Microcontroller Error: clearing.
> 
> Link: https://lore.kernel.org/r/20240219132811.8351-1-joerg@wedekind.de
> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=202425
> Signed-off-by: Jörg Wedekind <joerg@wedekind.de>

Applied to pci/enumeration for v6.20, thanks!

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 280cd50d693b..211b7f72d103 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5581,6 +5581,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
>  	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1004, quirk_no_ext_tags);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1005, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
