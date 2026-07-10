Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224D39E6EB;
	Fri, 10 Jul 2026 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783715414; cv=none; b=pQLss9JiXUBmV7hDpFcLekgD2mVHhU0/kFUX7O3tSGmLrn7FDlry+rtM1fiKPkogPPXow/+ysCOX6LMdx6JcFeycoD8czyAcecv8DeJeBNl4OUro0IFpY312Eyy3YVOcGPS2xO+UlN63qaJgJqGwWUum1dN9koJ7XL6KOXAagCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783715414; c=relaxed/simple;
	bh=KLokmVHl+qqPx2V14fPr84YQjVtsWw0WL+0t4KHv1ow=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Tpw/D2PGL3ruAf4ZeDrxkMZl3nzHIk+zL5zMdk4mAR9jlDvqqWElPGXT/rgfP2EQes3gcP2qKLAq74klLSp3oKeVl5JFtRq4nEYvHmvihCAErgtnDQwPxZs9Io7wHoSlGIduK0p0CWgknuawDp7G1pWPiwMsI5TKXDIGyQ36YEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0R/Ipa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0R/Ipa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A0E1F00A3A;
	Fri, 10 Jul 2026 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783715413;
	bh=d5wmz6I89qt6DHc2/1zZynvOo+7Kak8Nyqd8X1/cvpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=L0R/Ipa9Rck5uGhpO7PLl3hRS6zi/10G7v3838oZn7e7wxNzD/oCeaa6MTmm1COKx
	 ryZcpJlF1N97BWIkyWRS7rtHvgmu5CdjkeAt+v8AyO+kQEoIyLAKOPMwhDOMLIKkVD
	 XTILkrJwYUbsAzK0wssm9i8MVfoWasQGBBAEwuTnz46jRgprzwohezo/XBIgk7jg2F
	 A8czZEeJMAzU29RqB7p83M1hxXCWlreguQmOfuxHh48m+ho6Bgg0+sX8ZRQhSfv1mk
	 IAeQctN6bmqHywvxJFS4UWvUkdYxC3TfK/aiQyybL/QDWjbQY5GBLo/LcYrIAUIKTN
	 +ubr71cx18AKg==
Date: Fri, 10 Jul 2026 15:30:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] PCI: acpiphp_ibm: Do not use uninitialized
 device_class
Message-ID: <20260710203012.GA992878@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8730724.T7Z3S40VBb@rafael.j.wysocki>

On Mon, Jul 06, 2026 at 02:40:22PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Passing an uninitialized pnp.device_class string to
> acpi_bus_generate_netlink_event() is effectively equivalent
> to passing an empty string literal to it.
> 
> Accordingly, make the driver do the latter instead of doing the
> former.
> 
> No intentional functional impact.
> 
> This will facilitate the removal of device_class from struct
> acpi_device_pnp in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied to pci/hotplug for v7.3, thanks!

> ---
>  drivers/pci/hotplug/acpiphp_ibm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
> index f8016ed24523..7337bd1ac6df 100644
> --- a/drivers/pci/hotplug/acpiphp_ibm.c
> +++ b/drivers/pci/hotplug/acpiphp_ibm.c
> @@ -258,8 +258,7 @@ static void ibm_handle_events(acpi_handle handle, u32 event, void *context)
>  
>  	if (subevent == 0x80) {
>  		pr_debug("%s: generating bus event\n", __func__);
> -		acpi_bus_generate_netlink_event(note->device->pnp.device_class,
> -						  dev_name(&note->device->dev),
> +		acpi_bus_generate_netlink_event("", dev_name(&note->device->dev),
>  						  note->event, detail);
>  	} else
>  		note->event = event;
> -- 
> 2.51.0
> 
> 
> 
> 
