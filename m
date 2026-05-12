Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC418249EB
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778547651; cv=none; b=moUiM769AW6Raru2Rk5LWnpxAS4vhrAU3f2V6mCpkhm3VSFs+t2exXzlNdnpnEV7lXlMWldR5rTkW7NkHvd9mcgI8CigFi4Le1TULv0ite9mHCry4xQLBwTQ1E7wKA5B2VPmWgDmIG1/WcoMTMSjSRL+flWy2dOkek67Plty1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778547651; c=relaxed/simple;
	bh=nuMwTgOABxqPnCXGso1w7annGScEFuylOlb8TG109nI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OHKrwWgW8H/R7agyp3UO2UYXE3hc9ZHJ1+LdVv1KdcwhpsmDzQfoRxsdjcZpQkhY9F0y5R29G6DaS03OEtcFjZNFV+11Sm99NI54m0+CI8Jbkcme6iVIW33oudCn0OjNTyIwWs/6DNKFOvGwNCgt4WmG02UTXAQOX0FZurVTlQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYq6z6VH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYq6z6VH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE52C2BCB0;
	Tue, 12 May 2026 01:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778547651;
	bh=nuMwTgOABxqPnCXGso1w7annGScEFuylOlb8TG109nI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CYq6z6VHSCrAxEfgVsBUtfFjbTv5uMjvYghY9L5WGaLpQq0cBgOonangUhOXkZ4Ig
	 hpT4nvXLxGC+0V1fNIMoTfsF1H71M3UyGe44dnPaQAg4piitkEeMgQZgTDdKi+2nHL
	 05APLDPdTh5kjSvnBUfiWfkEjVluu+UejOqOc8lCEzPzs2/9Tww6ZIrCP4oB8qWTXa
	 e7IPifSGYsKXNanx3U/+LnzCasHne3Lp9uVjKAKEbosPrej4uIx0nIIxvbJW9uudOE
	 quG1tbRYWXS6pnSZRf6vAIh6BLV9f6KXCCVVPvAXkc0921HS9E0hjbnSbe4BROlBui
	 XYLDN6mqzJ4uA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] PCI: dwc: Use common
 pci_host_common_link_train_delay() helper
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260511055923.37117-5-18255117159@163.com>
References: <20260511055923.37117-5-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 01:00:50 +0000
Message-Id: <20260512010051.2AE52C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Improper cross-controller coupling by including `../pci-host-common=
.h` in the DesignWare core.
--

commit f5801e5d9e35ace16e87610771ef7a5939957245
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: Use common pci_host_common_link_train_delay() helper

This commit replaces the open-coded 100 ms PCIe spec delay in the
DesignWare driver with the pci_host_common_link_train_delay() helper
to reduce code duplication.

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index c11cf61b8319e..7021d21bb6011 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -22,6 +22,7 @@
>  #include <linux/sizes.h>
>  #include <linux/types.h>
> =20
> +#include "../pci-host-common.h"

Does including this header create an architectural entanglement between the
DesignWare library and the generic PCI ECAM host controller library?

Since the delay implements a generic PCIe specification requirement (PCIe r=
6.0
sec 6.6.1) applicable to all Downstream Ports > 5.0 GT/s, should this helper
be placed in a shared subsystem-wide header (like drivers/pci/pci.h or
include/linux/pci.h) with a generic name, rather than relying on another
controller's header?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511055923.3711=
7-1-18255117159@163.com?part=3D4
