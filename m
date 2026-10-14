Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED49527583;
	Wed, 14 Oct 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984872; cv=none; b=Meh6n5MtyPcmqKaAbBLfeviaD0WZSHqvp8wlEZ/3aRI3uxsG+pCI9FxfzFhUr385YfvIfgdcYDF+ujCwLtWWX4/sGP0vDSahfba82byW/la92LuDHGpa/KQijypUPcab7LiGjqoVxCtvnF/QRyeP9BZP2enXLg0ggKDAHgrO4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984872; c=relaxed/simple;
	bh=lEKCRx7hK7j5m6NDEekE2ZI2bUyezmm8XOYLEPhICR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oGyrHV94eFtSVKpXL8UCyyrfSGHSTSwJFxfZW8vIHBKDbB6nXEEYJzsb5oXmHND3yxbU5c1H7kdiTJcwZAGDr9wwzXAGigSlKJAGEAJTGwVxbFFlsxbLsTmDPUSEUa5IMI3PuMHxlaxrf/8ZU3yMhUFMtR2vEXl1g61+j0HtEFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6NqJWrb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6NqJWrb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A6F1F0089C;
	Wed, 14 Oct 2026 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984864;
	bh=XZV9wpLaB7GSx4PtVOFkB/b4sfjtm/46M63tFH45CRE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=H6NqJWrbi7Q7UOF7JBoq4heJwKmi5w7AjaTmDd58ZIIUNVtOrN2VWklG92FxN2PQV
	 KYFvWpkK3ajLvCvw92WLcZQE5vZW+auWA1y3ysCoZPeODAXuQod/WKSAa9c0UpXDeY
	 3/gR/kXCiLH3pP0H1EUhaFk/jTJeipIPiIMl2B6ple+GGz1cH7XfoJ41iNwpQEKboh
	 ZVzSa2ul5RtabFmxnPDHmBCbEY+NKGutX0l99DzpzhT90o8pDCevIjnitpvrVPptiP
	 IWIuxJYV+CeYsopFayTEvpgGpAjnW0rzNSBKX55JYZjc+s6mM2RNKuS/QINWvefxCp
	 Wz19rT3phBcYQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Semih Baskan <strst.gs@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Arnd Bergmann <arnd@arndb.de>, Rosen Penev <rosenp@gmail.com>, 
 Rani Hod <rani.hod@gmail.com>, bcm-kernel-feedback-list@broadcom.com, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20261013220421.1588051-1-bhelgaas@google.com>
References: <20261013220421.1588051-1-bhelgaas@google.com>
Subject: Re: [PATCH v4 0/2] PCI: iproc-bcma: Use EROM instead of devicetree
Message-Id: <179198485820.77319.12457284951144723062.b4-ty@b4>
Date: Wed, 14 Oct 2026 19:04:18 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Tue, 13 Oct 2026 17:04:19 -0500, Bjorn Helgaas wrote:
> This is a combination of these two patches:
> 
>   [PATCH v3] PCI: iproc: Use the EROM outbound window on BCMA
>   https://lore.kernel.org/all/20260807160526.379-1-strst.gs@gmail.com
> 
>   [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
>   https://lore.kernel.org/all/20260912043626.437-1-strst.gs@gmail.com
> 
> [...]

Applied, thanks!

[1/2] PCI: Expose devm_pci_alloc_host_bridge_release()
      commit: 4e93e052afad91ad28e8343d3777c1e5ab8c24d2
[2/2] PCI: iproc: Use the EROM outbound window on BCMA
      commit: 694a9f52a937f272d8aa6e845765e37118c10e17

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


