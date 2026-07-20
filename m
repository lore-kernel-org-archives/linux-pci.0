Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818463876D6
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587668; cv=none; b=VfwbsPPzzDwH8fcdCgJkub0Bi/qfoFNbRQ7IhOkSECnKbSrisVDPGBmIwtv1PDtnZEjdAoAFUcMz1b1TCSVGUVmce4yy/ZyzN0PELgBuqCjTFD9OFBpV8AUmrzpap8vnL3+d3wqB8m8RJCJEADs/ZycxUJe+0sfSi15O4hc1kDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587668; c=relaxed/simple;
	bh=nivYYtdDnqgTDdxE09XVkh9HaI9W6CWTqpz620z3J7s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iMZG+Ucx78ol+fLcrCSyUK0H3X2hdcT1EZ9j+RwquCdsTuZM7ThUM2iMflWkWDDy9MNse+icuIa4SVD74KOwMW/ygZyncgKyPOJymcgiB+sHCHGi9mGy4dyX5X1lsEdNuv0Od1GtyqZgreOvCnIwpaVSYTuJfE38z8+rGfAdIfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCW4/3ra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCW4/3ra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E011F000E9;
	Mon, 20 Jul 2026 22:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784587667;
	bh=VRKmJcC0eFl6gUcxqChZNn5CNqOc2MUFfoDarc/bBVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MCW4/3rawhxCRWqBRJRwXork9ocEf80B6TaQltrXORngjcGOyiQwzxu5eUehCUMG/
	 WitZmEd7h+mL0GB+5ICD5GFWB0a4NWp4gDnSE0J6EOZMyCGI5XzLNN0sv6I7aAKj1s
	 B4vzkQTFbFsec4Jb237qPvitBq91JsJMUgDHbHSYbCUwm3IZC0YQFu5rh3jx/Od506
	 kLtN/gsQ8SujGq4rZAFHIyzFuIT7Hx1rthis8UfbasE3awFNdS2GVQ9LeFKUKidPqu
	 l+ll0tq/0rQGnXEQPRRTnXYXDUTexZcKKzjGbFt/3UiYsOpw+0oSM306aAKYlDaZrh
	 vXOZpxYLvXmAA==
Date: Mon, 20 Jul 2026 17:47:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
	nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org
Subject: Re: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Message-ID: <20260720224745.GA435004@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628143450.92492-1-ali.alaei.tabatabaei@gmail.com>

On Sun, Jun 28, 2026 at 04:34:50PM +0200, Ali Alaei wrote:
> On Intel Arrow Lake-HX systems (e.g. Core Ultra 9 275HX on Acer Predator
> PH16-73), the VMD controller reports BUS_RESTRICT_CFG = 3 in the VMCONFIG
> register. The existing switch statement only handled values 0, 1, and 2,
> causing vmd_get_bus_number_start() to return -ENODEV and aborting the
> entire VMD probe. This leaves NVMe drives behind the VMD controller
> invisible to the kernel.
> 
> Hardware registers (VMCAP/VMCONFIG at offsets 0x40/0x44):
>   VMD 0000:00:0e.0 (8086:ad0b): VMCAP=0x000f, VMCONFIG=0x03b8
>   BUS_RESTRICT_CFG(0x03b8) = (0x03b8 >> 8) & 0x3 = 3
> 
> Add cfg=3 as a fallthrough to cfg=2, setting busn_start=224, which is
> the correct bus number base for this hardware.
> 
> Also add a PCI_POSSIBLE_ERROR() guard after reading VMCONFIG: a failed
> config space read returns 0xFFFF, and BUS_RESTRICT_CFG(0xFFFF) = 3,
> so without this guard a removed or errored device would falsely match
> the new case 3 instead of being caught as an error.

I suppose this should fix
https://bugzilla.kernel.org/show_bug.cgi?id=221136, which is a problem
on an Arrow-Lake-S system?  I bcc'd the reporter, and we could add a
Reported-by: and/or Closes: tag if appropriate.

That report mentions a 8086:09ab VMD device, and it looks like this
patch addresses a 8086:ad0b device.  I suppose there are lots of VMD
devices IDs that appear in lots of systems and implement this feature,
which the bugzilla suggests is called "Dynamic Bus Offset".

Given that this is apparently a new VMD mode, AFAIK there is no public
hardware spec for this, and the patch doesn't add any new code (and I
would expect a new feature to require some new code), it would really
be nice to have the Intel VMD maintainers chime in here.

> Signed-off-by: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
> ---
> Changes in v3:
>  - Move changelog to after '---' (was incorrectly in commit message body)
>  - Add missing VMD maintainers to CC (Nirmal Patel, Jonathan Derrick)
> 
> Changes in v2:
>  - Add PCI_POSSIBLE_ERROR() guard after VMCONFIG read to prevent a
>    failed config read (0xFFFF) from falsely matching case 3
> 
>  drivers/pci/controller/vmd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index xxxxxxx..yyyyyyy 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -640,6 +640,8 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
>  	pci_read_config_word(dev, PCI_REG_VMCAP, &reg);
>  	if (BUS_RESTRICT_CAP(reg)) {
>  		pci_read_config_word(dev, PCI_REG_VMCONFIG, &reg);
> +		if (PCI_POSSIBLE_ERROR(reg))
> +			return -ENODEV;
> 
>  		switch (BUS_RESTRICT_CFG(reg)) {
>  		case 0:
> @@ -651,6 +653,7 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
>  		case 1:
>  			vmd->busn_start = 128;
>  			break;
> +		case 3:
>  		case 2:
>  			vmd->busn_start = 224;
>  			break;
> --
> 2.49.0
