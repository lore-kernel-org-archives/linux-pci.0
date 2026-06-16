Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA43195FC;
	Tue, 16 Jun 2026 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616460; cv=none; b=Zz/1j6BYYkzji9PVwdlI5Zc4uFISu9t7MoZj425NwJIdrKs6IVQY5dhNQuEv6MjlBSL6dJL0bfEFX5ues4XrhUFUiBEeKmXlflJJNZdHEblAc9yA/+Il622vg6O2Ji9BXto0S7vVr8r94t6yFg+6iuBgv8ChrMOWJwA3/4VYzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616460; c=relaxed/simple;
	bh=ZCcHnqXHRh533SakRQ7A1Zu/e0yFLmUGOSCOmQ2l6Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjkCuZV3Ao3jOqxuw3NwzYdfkGsAAwUAyrWBAfeJmr/SioCpvjO1dM9jnNxAGvFVobyFU0oxS8XTWdgtx4vMWNxqdpKZOl3EmjFpS+s3VcTq0BSK/YG6XC73bf9Z3sfry2hwdxL+spJdPjZUAtCHucEeP352VTYiOlKtKPICCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/xEKhr6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/xEKhr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738E21F00A3F;
	Tue, 16 Jun 2026 13:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781616459;
	bh=0rOX7oqrz4F1I9mioWQ4LncFjgANd9LJdCpcf1wQ7Cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C/xEKhr6oWET9seuL8P3ngot9UC7LJZUGuWDq0dOYRoM9Z5oJx0TQT1f9Z4XAWC+h
	 mLFLn0K3AAttFwjv2ikkGfc4bK8xkHTevit9ISBT/OF4nc/ZC6f5y5LBGGnXzAwtq7
	 hJjZk2GG2rqZtGPxkOM0tSpwwmdWuBhV8IzIZxQwH77B4ynLK4YFB06AFsmdBFA/tT
	 6bQdgwN+1uL+Kb0iIkZ0fKvFK0GWL+kN+OhxZXZwvYosjOiei0ZilTNoLxSttV9J/a
	 TZtPxrm87GtI67Ts7LDGVlRZm2Uk8RB3V+hc4QtPl+7w03KSPorKIkAKx8/5wKGWNP
	 KfKQ2zdnKge8w==
Date: Tue, 16 Jun 2026 14:27:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 1/8] hw/pci: Refactor flitmode from PCIESlot to PCIEPort.
Message-ID: <20260616142730.7fb0a465@jic23-huawei>
In-Reply-To: <20260609105836.3702787-2-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<CGME20260609104503epcas5p12628cd89d0ef9210c856d2518dc790cb@epcas5p1.samsung.com>
	<20260609105836.3702787-2-shrihari.s@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jun 2026 16:28:29 +0530
Shrihari E S <shrihari.s@samsung.com> wrote:

> Move the 'flitmode' property from PCIESlot to PCIEPort. This change
> allows all the derived ports (PCIe ports or CXL ports) to use this
> property.
> 
> This is a structural refactor only. There is no functional change in
> existing behavior.
> 
> Note: This property was added from Davidlohr's BI patch series[1].
> 
> [1]: https://lore.kernel.org/all/20251103195209.1319917-2-dave@stgolabs.net/
> 
> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
This seems fine to me other than one small thing below.

Given the main changes are in PCIe code though it'll need review from
appropriate maintainers.

> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> index 0ee18ef5c3..df69c5200f 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c

>  static void cxl_rp_dvsec_write_config(PCIDevice *dev, uint32_t addr,
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 1de0b1e4fd..d452199d85 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -217,7 +217,7 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
>          /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
>      }
>  
> -    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->flitmode);
> +    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->parent_obj.flitmode);

I think we should use a cast to the parent object type rather than going directly
into s->parent_obj.  PCIE_PORT(s)->flitmode.

>  }

