Return-Path: <SRS0=VYo7=45=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A77C1975A
	for <linux-pci@archiver.kernel.org>; Thu, 12 Mar 2020 21:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500C4206CD
	for <linux-pci@archiver.kernel.org>; Thu, 12 Mar 2020 21:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584046921;
	bh=/e9LLeJ5dACgdtAw3HHaj6wtWKVc0kxLbLGS8/Q25qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Y60zwNPZbmcUkOFYlKJTkjLWFOylya/fq9zoGtdUS438WfodZIxeBajAnYbelK4/3
	 BeoCJa+lGqSbB8jpz1DxJnJxFt5VRd5svk/SzXZWEHQsuaf/y7KjuFaEX8v0Wp1oqo
	 IiV7wv4BBlDh9BQh5vO3OJy1vOhCC8/YiXO7xYOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCLVCA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgCLVCA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 17:02:00 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 158B320674;
        Thu, 12 Mar 2020 21:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584046919;
        bh=/e9LLeJ5dACgdtAw3HHaj6wtWKVc0kxLbLGS8/Q25qw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EdwLzcJvSjpI3Th7mp7lKFatB+Yn47XEfNY+YgjNT3ENbyGBE0r12eGlfupHp5IcO
         TT8zsQMtI4TjFzhyJjyXL5LlLSL1a5GlHXoya30uKdsCtQVAkqrDLP566944IgMvPi
         nkoB08xDowbPCi+qj0dPDSH9lPbxsLbhzikPdbJs=
Date:   Thu, 12 Mar 2020 16:01:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     will@kernel.org, robh+dt@kernel.org, joro@8bytes.org,
        baolu.lu@linux.intel.com, sudeep.holla@arm.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        lorenzo.pieralisi@arm.com, corbet@lwn.net, mark.rutland@arm.com,
        liviu.dudau@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: Re: [PATCH v2 05/11] PCI/ATS: Gather checks into pci_ats_supported()
Message-ID: <20200312210157.GA180471@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311124506.208376-6-jean-philippe@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 11, 2020 at 01:45:00PM +0100, Jean-Philippe Brucker wrote:
> IOMMU drivers need to perform several tests when checking if a device
> supports ATS.  Move them all into a new function that returns true when
> a device and its host bridge support ATS.
> 
> Since pci_enable_ats() now calls pci_ats_supported(), the following
> new checks are now common:
> * whether a device is trusted.  Devices plugged into external-facing
>   ports such as thunderbolt are untrusted.
> * whether the host bridge supports ATS, which defaults to true unless
>   the firmware description states that ATS isn't supported by the host
>   bridge.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/ats.c       | 30 +++++++++++++++++++++++++++++-
>  include/linux/pci-ats.h |  3 +++
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 390e92f2d8d1..bbfd0d42b8b9 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -30,6 +30,34 @@ void pci_ats_init(struct pci_dev *dev)
>  	dev->ats_cap = pos;
>  }
>  
> +/**
> + * pci_ats_supported - check if the device can use ATS
> + * @dev: the PCI device
> + *
> + * Returns true if the device supports ATS and is allowed to use it, false
> + * otherwise.
> + */
> +bool pci_ats_supported(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *bridge;
> +
> +	if (!dev->ats_cap)
> +		return false;
> +
> +	if (dev->untrusted)
> +		return false;
> +
> +	bridge = pci_find_host_bridge(dev->bus);
> +	if (!bridge)
> +		return false;
> +
> +	if (!bridge->ats_supported)
> +		return false;
> +
> +	return true;

I assume this is the same as

  return bridge->ats_supported;

Only "assuming" because I'm not a C language lawyer, but I assume it
does the obvious conversion from unsigned:1 to bool.

> +}
