Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8E3B7753
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213028; cv=none; b=TkG6pmsEs60nVwIipFxSrDBPudVdk4ECZhLX7gqCy6NFOAit3BfXZkTJZ6zhh3p1bDbakNHomwgcNI9Q8RxymUjjBTSvfFR9NLEYYFm0SDmb/+575VbOcREkjH7wNP6mITkGsfaM8kp6+IaZ/mAZOAVKfYnORYG/gX7/OmUjFAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213028; c=relaxed/simple;
	bh=CahpD7cyrRer+BuhTpATMBmSpR1qu9d6vPKJwLr9lTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAobMBXBz0GHyEQooxc9rXubhTjyhnKBrsQrsux8LTX9XZ/OzZ4jzc5ptKsxYPu9KUvY1lCqUaOoBF9NmND5EmwtfvO8c3z0ZKYiERfxHVUMfLeATtMZd6yPzJShuzuyhL5P+PVIvaIu0zdufPIjRNmSnMKzWadm9XsB8tUmoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmRezhm2; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmRezhm2"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66771ded50aso9452870d50.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784213019; x=1784817819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vp6Bjp2wzhtrtLJqG7J8nPwf3VRW15hJCwHjUU/I7Wg=;
        b=nmRezhm2GM8785K9s3l15zERzg90WbyHGv6o/n2RKBoYRzB6z6FGxgeqOtojWpT6FT
         NJyph2+OknQ43jFIh3BB9i8ipP3d5JbEGQu0D5miVfBSnGWTEE0aoB93mKILuJlKkd/h
         hhfmNUJo36jNoSKdRG2JMeWtW1JoMBDIxFlhcNKU+1N5nXJ5T2iiE54qK5eTtMjfFtSa
         a1dv2d6O4wt9Lhpottrq/tFBpG6/VDhMPVJX16lpkTqNYaVh2lPNK6ARzGISE3UKcFez
         ONr6E4Mg65EiXOmAzSNYKYCHO6Wd1v7ZOxjCTysaCPK+CfPvKbPRarvEfPpZYSiH3uH/
         00Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784213019; x=1784817819;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vp6Bjp2wzhtrtLJqG7J8nPwf3VRW15hJCwHjUU/I7Wg=;
        b=AL0OuBKLs5Q5Tifoojxri+dfZagfdEGY8xRk4Ro0Des/aLpNayBLEKKXhORLbsJq8f
         AoPlFOkhsDweI+Zt+WxzENZueagsl5Fuv555D1Xqp7PdZ/0Oa1qodgVloK7uwqavl4ms
         CY1NQed/8SJKzD7F+7px11XU4cDbJNXALD2xF12RejNyMl42DhrZi6tWK5qea4DZKxSF
         1ei3HFPZniGl5Qar4ZZdlYEcGXE8lTMmpRhRG3WpWWHPbbt5VhUNvSeeElN7HNjkdT5+
         w4PbPAarYG8i/LX7GKzG1AFql4TQvqcqLS1RzDORb9P55f6ZFqMXiIFNDYMB/kAS8kwj
         cIMg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9rGlDp/r+tI4YDUVIdzDbf+jdeoKfYGzeCnYmFRqilkU8+u+Z0+HiX03LagN5DI00VStlC1AtndE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Gi36lfK36QvYDZcqCpnj7axp9i5RqRebvM87H5dWadr5GnlB
	vFfZSMoSPGD4tQM5teJ7LfjUsJgu4IZwYZChmrLZsSkGkBX++wa/mlYU
X-Gm-Gg: AfdE7clRqd8kjTVLW8b/iqWjdMReCgB9sC8KoXjE39fIoOAjBXfv3BDVegFrHa/FGkn
	79WXm3QUHb9sh2khF/N2PuUFX4i2hGETp6mY7hKEVsyB4rJd9Z84++yHGzeMMoZi+LKvsGN8x57
	Ww18i4ymhxsDbjEFrT47PGjAcQFnLERMs3zSLgvFbqNkbQsrPOpi6Fh/trULknZZefzfNA2sxnO
	OCs3v5aaaCo34I9YeGooYAbsBlB+Ac04Qg62XHETA9MCMuEee1YSooJY+GViZ9NTiBNBv9X2Noz
	KRDTNDFqd2bkJROnXuzToQ1ivkw8CT1jvX0NK0nOYw3smwS/8FYA0aLJiepdmBUykI1u6YlNYgX
	NnlcrnEt6dfiFv/ub9BknQ6gMlL5QQaB2u8C+TubZ6TQTRnl7Apw4RQzeVDumBZfyBxSueJD2g+
	x3kKYP2fbROfU91EyknRxNv9DWcWlyxeuU3TI5erdBfxnJrR2D8JMqVbGQ/EzqTOOqI3TEqg==
X-Received: by 2002:a05:690e:16e5:b0:667:9f79:35cb with SMTP id 956f58d0204a3-66813436773mr4282441d50.53.1784213018782;
        Thu, 16 Jul 2026 07:43:38 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6681fe46cd8sm3509707d50.15.2026.07.16.07.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:43:38 -0700 (PDT)
Date: Thu, 16 Jul 2026 11:43:31 -0300
From: Leonardo Costa <leoreis.costa@gmail.com>
To: hongxing.zhu@oss.nxp.com
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>, leonardo.costa@toradex.com
Subject: Re: [PATCH v2] PCI: imx6: Fix i.MX6Q/DL boot hang by separating PHY
 power and reference clock control
Message-ID: <blkjlbskmfiyprh6wlbfilwlgjw3zkbslh6fpogcc5vcfu5dvn@hcrojgleuxob>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708035928.580236-2-hongxing.zhu@oss.nxp.com>

On Wed, Jul 08, 2026 at 11:59:27AM +0800, hongxing.zhu@oss.nxp.com wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Commit 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> introduced a boot hang on i.MX6Q/DL variants by changing the initialization
> sequence.
> 
> The issue stems from coupling PHY power (TEST_PD) and reference clock
> (REF_CLK_EN) control in imx6q_pcie_enable_ref_clk(). When these are
> managed together, the timing between PHY power-up and reference clock
> enablement cannot be properly controlled, leading to initialization
> failures.
> 
> Fix this by separating the two concerns:
> 
> - Move PHY power control (TEST_PD) to imx6q_pcie_core_reset() where it
>   logically belongs with reset operations. This ensures PHY power state
>   is managed as part of the core reset sequence.
> 
> - Update imx6qp_pcie_core_reset() to call imx6q_pcie_core_reset() for
>   shared PHY power management, avoiding code duplication.
> 
> - Make imx6q_pcie_enable_ref_clk() responsible only for reference clock
>   (REF_CLK_EN) control, simplifying its purpose.
> 
> - Remove the 10us delay workaround from imx6q_pcie_enable_ref_clk() as
>   proper sequencing is now handled by the core_reset functions.
> 
> This refactoring ensures PHY power is controlled during reset
> operations, fixing the boot hang while improving code maintainability.
> 
> Fixes: 610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

Tested-by: Leonardo Costa <leonardo.costa@toradex.com>
