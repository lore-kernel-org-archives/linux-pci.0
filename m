Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787EB332637
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 05:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476349; cv=none; b=AAB5nKHzzOwIypMOoMmyqYSb8BFeI3AudSEHvRvxWwlFKBq4xLOQAfWQKAqVIQJY1YI1b/HuvuYWZjTi5rRXluAlD0w4F/KVPCPuyljxiPJ4yx3uHfAiGRkoZk0l09FK9/EfWekiJPbPF/H96RWUe1tSiURCuyroZzVvEAbecCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476349; c=relaxed/simple;
	bh=c+ysudPdDxuMNZnO+7IMAqzOqN8bgyj1HTXBPCwDtrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgEVxj3oaUZJ1yGqg87vd9eBwP8B3Pb8vEN6fx/eEUMY8nEmfD+wUPVfiQRzmfZIlYoy1jQ1HdwvyAMFtO5b5tNatDValdKu6G75S71n2OvORSl3xYazW/PEWYywzeGnqeTq8m8J3iKQPlKX+eznn8aJ08EnEfKKcJQH2ruRzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFgVoIEp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFgVoIEp"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c999f162c9aso372244a12.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 22:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785476348; x=1786081148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/QvE4xoVh84rpMFWIzK/7q8o1VN2R2RVoeFGxLDnBmE=;
        b=RFgVoIEpURyp4ftvijMI45qyElZ9kkjwYV3zllOb8zskv8gSYXB6WYMkJmedYMMVfY
         DG0XPkIKwlYZZePOirZC6dlKNEYbv5Kb6vfnMZdXiyr/f1s9/d4M7LQnjQprx/Ckkz39
         pByXnSophmPft/4Gwnl/48UmcHPWzP37joIvoVxzCfi5SdWd3kWGLjBzIc2xBpHRLbU9
         XOI7VykbtXNPw2sKXtGFQisvq2ZLJYlAqyBbvsxegl8UXgfr89QqXbtj/n1oVwwm8yhr
         piIAHzvlkalWOQxh16fmPrSj4Merxav5jkUwK6w2VLsFq1nv3aDO1sovSV9z350df8e7
         5HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476348; x=1786081148;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/QvE4xoVh84rpMFWIzK/7q8o1VN2R2RVoeFGxLDnBmE=;
        b=iO/c4lX2v+X5+iMRSl7Vojo1j3eaXIcXOpkfjIqMR5UVFUAXO9HeU0GN+8h3EZdqqy
         ElMYKvqdukYMzwSjRvpMhY1XAyc0pHflKfAe7S3SVqKBQAfoQ0nLmHrDGKD2/RFtxO7l
         UZh7WYaJeCRoIq1s36OXlP/OK7AB1Z9MjtyiTmw6busVCAQ4mOZT+k16JihKqP2+ESMD
         VRpnRU4jZuJJnbBWm+zDlOM722buqyJGr8MoTIsxxg76AMGqiMbDwdrtR1SsxvM1rA8p
         +68kOOsy8WRHHDdRWcLOXLggRLnCEdAl9md7/B3jMG5GKbPFa4NF1EhmTGc5E9jKyPZO
         2AmA==
X-Forwarded-Encrypted: i=1; AHgh+RoDCYDGozrO8GbogM2D4AkVzJ9YwDliM0FN67aZNZoZlZNaap6lMQM5sL16H5Xx7HVuznkqljBOzbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVgcJEg1XddUx141/hpv/hqev7/2tNMlteL6dAXSnMzSPrXhz/
	JoiVnbxhh3RPue0W8eETkJ7v1T/wuOrJhEXeXmaNAetv3NODwjQX/v5u
X-Gm-Gg: AR+sD11H9RyUykFE1gmCGNTItCN+cpGA6bNmCCNMuoob+jnJ7jVpAaGLELwHGN9gYkT
	x1m438AJlU0i10cA6eGpDy03B6cv9JKm8LMZ+eYgCI9odhG7P57nIIAWdQK5mkvU1B4QNEuzcgh
	CPFDmsZ+Pr7IfnHPAShul6UQFSQTpsNZrr60LLJnXoQ9KdzuHIG4Mm5S0rJz8zC/oQma/enFuP7
	fojH3K/9r/PKjhexoqpJ98j8LI9OMMOlQU0szYHoKZfJsyYjfOcx7t+9rr/LRcwShwM5kOQZo1Z
	ayoAc6tBNjQQJXTe9ZExEGZyTYD8a/fhwS8EEJX8yy7ID9L+4RRF5CbuU2NVLWhc2Lno3bs8Sf2
	4BjDULevizsXx90UU1m1WeBArn1WPXFy8WrPOHCXAYRR1Ht5w8qZT6cfiChNCvaLn4jaaottuMt
	LS0FSQWSubQKPesiWuFyaMvT1wnh8m56EDBVYdVOSIJKx8sttb33KEXAhxtTXNDuRGy8k5BXsib
	Qlz7Q==
X-Received: by 2002:a05:6a20:7f88:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3c91b0a9b0cmr630307637.8.1785476347663;
        Thu, 30 Jul 2026 22:39:07 -0700 (PDT)
Received: from kernel ([45.251.35.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e0700e8sm1252501eec.24.2026.07.30.22.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 22:39:07 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:09:01 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: bhelgaas@google.com
Cc: alex@shazbot.org, skhan@linuxfoundation.org, jkoolstra@xs4all.nl,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fix 32-bit config write in Intel RP MPC ACS quirk
Message-ID: <amw09fxdlgtGv35w@kernel>
References: <20260723171203.4892-1-raizudeen.kerneldev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723171203.4892-1-raizudeen.kerneldev@gmail.com>

On Thu, Jul 23, 2026 at 10:42:03PM +0530, Mohamad Raizudeen wrote:
> The pci_quirk_enable_intel_rp_mpc_acs() reads a 32 bit DWORD from the
> MPC register, sets bit 26 (INTEL_MPC_REG_IRBNCE), but it writes it back
> using pci_write_config_word().
> 
> Because bit 26 resides in the upper 16 bits of the 32 bit register, a 16
> bit write to offset 0xd8 completely drops the newly set bit. The quirk
> logs that it is enabling IRBNCE, but the hardware never actually
> receives the command.
> 
> Fix this by using pci_write_config_dword() to ensure the full 32 bit
> value is written back to the hardware.
> 
> Fixes: d99321b63b1f ("PCI: Enable quirks for PCIe ACS on Intel PCH root ports")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> ---
> Changes in v2:
> - Added "Fixes:" tag and CC'd Alex Williamson as requested by Bjorn Helgaas.
> 
> Link to v1: https://lore.kernel.org/linux-pci/20260723160641.GC836122@bhelgaas/T/#t
> 
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846f..0d0cf6f86173 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5361,7 +5361,7 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
>  	if (!(mpc & INTEL_MPC_REG_IRBNCE)) {
>  		pci_info(dev, "Enabling MPC IRBNCE\n");
>  		mpc |= INTEL_MPC_REG_IRBNCE;
> -		pci_write_config_word(dev, INTEL_MPC_REG, mpc);
> +		pci_write_config_dword(dev, INTEL_MPC_REG, mpc);
>  	}
>  }
>  
> -- 
> 2.53.0
>

Hi Bjorn,

Just following up on this v2 patch. Please let me know if you have any
feedback or if further changes are needed.

Thanks & regards,
Mohamad Raizudeen
