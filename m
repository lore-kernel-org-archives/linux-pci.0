Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95CCC43387
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 15:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C2020828
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546269482;
	bh=aGavy5WzFL5M1jO/Zckw7BlftWg8uAqgooDww8t93U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BWG+GwsQUPssDP77/u0x4kW8iZol/VsyVt5fMbcdENMq6WxUFbahOIfaFabMxH/ms
	 jyz14T4TRzDHr6g6qK2gQ3zImvirx9jt6DLM++HUvAeoxRNXdhq2tchzyn72CDf1wf
	 8auraMkyS1R7TIta7cods67zHh2zZNqdDVt6cqD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbeLaPSB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:18:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbeLaPSB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Dec 2018 10:18:01 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2076720828;
        Mon, 31 Dec 2018 15:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546269480;
        bh=aGavy5WzFL5M1jO/Zckw7BlftWg8uAqgooDww8t93U0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wxnWEUPVqO11Gu7TAPYvr3DCjoZzQ9cvVYRbvFpmFreQaURyGwywR9r7zOEWQ+gxc
         K+MHSvM4GezaINzK+rak9Ux9DaIqhvYJwcgHo5P/P06j4knK2noBLeKmv04Ri0mH+d
         DTbKWkhtdKX4TRczY0V+uuOV/3SLc3WtaBP2+tgo=
Date:   Mon, 31 Dec 2018 09:17:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lftan.linux@gmail.com
Subject: Re: [PATCH v2 1/2] pci: altera: Add Stratix10 PCIe support
Message-ID: <20181231151730.GD159477@google.com>
References: <1546244693-34633-1-git-send-email-ley.foon.tan@intel.com>
 <1546244693-34633-2-git-send-email-ley.foon.tan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546244693-34633-2-git-send-email-ley.foon.tan@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Run "git log --oneline --follow drivers/pci/controller/pcie-altera.c" and
make your subject line match in style, phrasing, and capitalization.

Hint:

  ............ pci: altera: Add Stratix10 PCIe support
  ef75369a5b9a PCI: altera: Fix platform_get_irq() error handling
  bfdbbf0e3c2a PCI: altera: Use size=4 IRQ domain for legacy INTx
  6ab380957838 PCI: altera: Drop pci_fixup_irqs()
  9815791319a0 PCI: altera: Convert PCI scan API to pci_scan_root_bus_bridge()
  2a7275a3d867 PCI: altera: Fix TLP_CFG_DW0 for TLP write

One of these is not like the others.

On Mon, Dec 31, 2018 at 04:24:52PM +0800, Ley Foon Tan wrote:
...
> +struct altera_pcie_data {
> +	int (*tlp_read_pkt)(struct altera_pcie *pcie, u32 *value);
> +	void (*tlp_write_pkt)(struct altera_pcie *pcie, u32 *headers,
> +			      u32 data, bool align);
> +	bool (*get_link_status)(struct altera_pcie *pcie);
> +	int (*rp_read_cfg)(struct altera_pcie *pcie, int where,
> +			   int size, u32 *value);
> +	int (*rp_write_cfg)(struct altera_pcie *pcie, u8 bus, int where,
> +			    int size, u32 value);
> +	bool s10_flag;		/* Stratix 10 */

This is OK if you only ever have two programming models (the original
and Stratix 10).  But if there's a possibility of more, an int model
type that can be tested with a switch is more extensible.

Personally I prefer bitfields over bool in structures, but ultimately
Lorenzo will take this and I don't know whether he has a preference.

https://lkml.kernel.org/r/CA+55aFxnePDimkVKVtv3gNmRGcwc8KQ5mHYvUxY8sAQg6yvVYg@mail.gmail.com
https://lkml.kernel.org/r/CA+55aFzKQ6Pj18TB8p4Yr0M4t+S+BsiHH=BJNmn=76-NcjTj-g@mail.gmail.com

Bjorn
