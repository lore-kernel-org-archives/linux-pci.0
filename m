Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972E31E85B;
	Thu, 13 Aug 2026 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602507; cv=none; b=W0TuqYSHf2J2pqzRwGhYFf8D80Wev5rSu1rblgRH8EnKIv3wDGRrnq54F6SL0GwwmppAlInAo3gLhPOsge7Hpm0sDdUD45vIBbPSaCbcRqkD8FekSGMTFOQn7JGpFvyX5OTsMi7eOJFf6gO+h4LKLFn/Ugu5qZEjobTFD2nn628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602507; c=relaxed/simple;
	bh=6Hwm7P4l8Z1WH7Ocay+xORJ2xHNmnu32QzG4+Xq8hQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHY5aknVYzaqNZgbgJNf4WGRy0xKOmCIotfLIkJqCdA9gUJhH2lkXlPPOCPKKhb0xNB6ukDKwCtgquvEHwmEtAkwt1PZ/0jCzxYj9a/u4goBVqRZh8K1CsDmMXduAKdS3y/wKR2f33ehj3txmEp1q3dFF5JoZks1g3VasNXMF/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmzBUgJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmzBUgJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F911F000E9;
	Thu, 13 Aug 2026 06:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786602506;
	bh=fZplp1Wn161lujFYQm2X+2cJfPSiCPrRfF7u2+BkILs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gmzBUgJ/Dgk1sfbesPOdtk3+8CwmpQGADItPiRgPd0nxXVsUrK4wewGQbDY79nm+K
	 Fm3nvE4kGAnVYS6hOT5GER83FGoW4svj6w1wqw9uT42KfSQ0tcM5om7SN4NJV+5jVt
	 GDgr97Mfsv7Xeb1u9sfy6P/dOJUyfjlHGsED7KpQm/1ifrvR6xmQ4AZHshlZGW0mim
	 N1tcg4FZYOPyvgbR1w6kifmp/+gVafH2Z2LCQ9TkudsJafO8e71kxYVpj1ukVv+6b6
	 yPg99H+wXTQOcwqJ2OiJFHKOAq1iM8qD7C6i2PwSeNk1oGsgja7JTlir/7JzFCoDXv
	 JeLi4PaZP7RKg==
Date: Thu, 13 Aug 2026 08:28:18 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Cc: bhelgaas@google.com, alex@shazbot.org, skhan@linuxfoundation.org, 
	jkoolstra@xs4all.nl, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fix 32-bit config write in Intel RP MPC ACS quirk
Message-ID: <eph6rxwk6iyjze2vfzlqxsiisknc7baoq5f5hljpxbvixf6sah@zdi47j7zt3zy>
References: <20260723171203.4892-1-raizudeen.kerneldev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Cc: stable@vger.kernel.org
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
