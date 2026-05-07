Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35B351C3D;
	Thu,  7 May 2026 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143708; cv=none; b=M89lW4eIGs5cpRa5nBTP/WRNWgcdOvvT74TenlRbsvQpKX7MYhllkH/n4tZAczxiQIXz/IKZUO6VgUMI3I7oIPpssQ1fR5slC7zlqdE4KHOHX6DA53BLtjH9kdNHwuMH6OdtEhABmuGtcRPm9dgBe8k9BM0C4WG/wejicd142Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143708; c=relaxed/simple;
	bh=1dxLIMyeH6ASIo+C1XdXDmD5C+ZI9/aOanZo36hb3U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i372+Zq7goEE567YZgsWtL61Uz569wImE3H50ZaY2MGLpHxHOdOUNy+gct1sy7uuQklr+nvNQ8INCiX/O7FUUt/Ucpg+TA/gkUClymvW1xPnySAHU11VKCJvPVMKPgRGBrs8LQnFfdnZ00fO5QCfj7U6A87U3DRFZAKYmlMDQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZfiMdCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZfiMdCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BE5C2BCB2;
	Thu,  7 May 2026 08:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778143706;
	bh=1dxLIMyeH6ASIo+C1XdXDmD5C+ZI9/aOanZo36hb3U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZfiMdCwxFX1fwzvvE6RmY9TTyrItR3XUIk2CQpoikH3Lf681+Jf+laxq7te6R8Bl
	 ieqc7ass6oH+xod4ryqzpYmONyn4f6n4VbTcRHHukqGCMDyIMyy9Fgj95MlNyw6jWM
	 9Y9o83oX36hRozySeypB+GBiuXuWyAorh6W/nNqaURGmjrneOphG66H+ONGNGHPO1o
	 RPR9kiISikxw6eclcMlNS9DCdFmOZa8WFhygpFmHdlbLkzKNzVp5N2YKE8LS2uZfwu
	 lT87HTaGq3x4vl1vWGbSZ4dEHR2PHvoNlplToKfvXrT+bowU/PFw9pN62hwmJdiN1E
	 ABqdaFKHOMBnQ==
Date: Thu, 7 May 2026 14:18:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-pci@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>, 
	Phil Elwell <phil@raspberrypi.com>, Jim Quinlan <jim2101024@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hans Zhang <18255117159@163.com>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: brcmstb: Assign pcie->gen from
 of_pci_get_max_link_speed()
Message-ID: <q3c6li5kld57rdxxpxr3dxvimzvdyr57irtj2iyryftri6cy43@3vbacremhcls>
References: <mid:20260501202438.376033-1-florian.fainelli@broadcom.com>
 <20260506164537.103196-1-florian.fainelli@broadcom.com>
 <t3u7r2ee6gdkjceula2ctvgditgxibwxcpaejc7ekbgdjog3br@c6n6ztzsbhpu>
 <83ceeae6-20e8-40a5-bc0b-6231d2118b6e@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83ceeae6-20e8-40a5-bc0b-6231d2118b6e@broadcom.com>

On Wed, May 06, 2026 at 11:15:50AM -0700, Florian Fainelli wrote:
> On 5/6/26 10:08, Manivannan Sadhasivam wrote:
> > On Wed, May 06, 2026 at 09:45:37AM -0700, Florian Fainelli wrote:
> > > After commit 03f920936977 ("PCI: controller: Validate max-link-speed"),
> > > pcie->gen stopped being assigned and as a result the established PCIe
> > > link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
> > > to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().
> > > 
> > > Whether the 'max-link-speed' property is not specified, or it exceeds
> > > Gen3, resort to the HW defaults.
> > > 
> > > Link: https://github.com/raspberrypi/linux/issues/7343
> > > Reported-by: Dom Cobley <popcornmix@gmail.com>
> > > Reported-by: Phil Elwell <phil@raspberrypi.com>
> > > Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
> > > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > 
> > Since this is a 7.1 material:
> > 
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Thanks!
> 
> > 
> > > Change-Id: Ic5431469dd7a6c8b391f84f27119dad876256880
> > 
> > This Change-Id is irrelevant to upstream.
> 
> Should I resubmit or can it be stripped while applying?

I hope Bjorn can drop it while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
