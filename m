Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF413AF2;
	Mon,  2 Mar 2026 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492985; cv=none; b=olho/Gln65Q3MalO3UtoiyiL11TGtRCihLWY1iepK4Bz4tc/0TSMjJ5wGZbs8XT78WmxHu7X9TbmrG+AuMCZPB3/ni3UbvrRm13Jqok8P3/ZKHyu55suTRrsh+MQNDsyKqhkC1s2s9G0hjSzJd8jTZjC+RxVoHqii5Gsdw3gkTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492985; c=relaxed/simple;
	bh=h3EoEjANlxG+igkhbEWcQ2Kl1vd8TKi1qjCxBGbBQxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PTMedXqTDCBItq+8V+xrH9+I4GUC53BPsIANZAE6DO5NanLQDWJNfV2g0rKZVWMbLZ/kSE2WPGZWbJE3Y9MeRMMSJuCSH+kALBJejkXUfEXx1a2DmFxozmZSa1lZZXiu5IhIxZZcNJOcGG3L6+f08SS2fkyDYJpXVbXavCkGl4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT3kBz6s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT3kBz6s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADBBC19423;
	Mon,  2 Mar 2026 23:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772492985;
	bh=h3EoEjANlxG+igkhbEWcQ2Kl1vd8TKi1qjCxBGbBQxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sT3kBz6srFawPge5i6N/SFYN7uLLIq1d8gENgRP5jfz8UD/nHjoZhieUL8vhHJqFa
	 5rSy0VcVAzrK4lBNAVveXegzooNfRjivZiX69cfmOpUAAM3/ZKd1KBUCtv5e6Z0ZuF
	 iF0u4SF2T/6IDpItCnbh34kWXScy7XV6ZLVzUzMqE6JuUHDmiln8B0iQmE+pEJZxZC
	 eMY6pXGRpQ+GD71r45y93+dNeyS8stGOTW/qqZ11CtVj0h9MtdwIHfoIilD5iCF+9F
	 03jQuULfyS2WW1cv9ChF4hjl+yFECW3fSLA9sk2gWaLXTJ4Fq4N2n07DLPntd/zTpv
	 8KwIG3c/EyVPw==
Date: Mon, 2 Mar 2026 17:09:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] PCI: Avoid FLR for AMD NPU device
Message-ID: <20260302230943.GA4035763@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226182545.3057330-1-lizhi.hou@amd.com>

On Thu, Feb 26, 2026 at 10:25:45AM -0800, Lizhi Hou wrote:
> The AMD NPU device (PCI device IDs 0x1502 and 0x17f0) advertises FLR
> support. However, triggering an FLR causes the device to hang.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

Applied to pci/virtualization for v7.1, thanks!

> ---
>  drivers/pci/quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 48946cca4be7..757a296eae41 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5603,6 +5603,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>   * AMD Starship/Matisse HD Audio Controller 0x1487
>   * AMD Starship USB 3.0 Host Controller 0x148c
>   * AMD Matisse USB 3.0 Host Controller 0x149c
> + * AMD Neural Processing Unit 0x1502 0x17f0
>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
>   * Intel 82579V Gigabit Ethernet Controller 0x1503
>   * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
> @@ -5615,6 +5616,8 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1487, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x148c, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x149c, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x7901, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1502, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x17f0, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
> -- 
> 2.34.1
> 
