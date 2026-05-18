Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CFF18EFD1
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779069000; cv=none; b=iYxrUAj3uqVNv8ldFsCv/axIBOkwQRJrgVRotZlo0Vo2WuNOMDMB7vsG6PXKicEDfNduAzIPXcX366Wfm39vDj0RqduyPErP0Pe8lnjX/iLMleuumiv7BcHAGT3tInjPcYyeN2B0SnKhGNk9n/I1hP926RekBBMTgbToWGxOQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779069000; c=relaxed/simple;
	bh=WzWTn9tl1g4sOPS+EMsTorbk+sC0UjeGSJFHPEwEGpQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o8neWVqgWmz074k3aKvws4Ml7XJ7s+lDzihF7apNt4rUYdMGKjIOTFcdXv/HD3cf5vReEkhb8h5K3JsM+k7A5ufTjwyeawGjoNgHk/8UH5zTzpLmsMeqAoDTFOtx6/B+NII4aidlkYxCudc6txBN9Gon3Skze3/wFPnUDqtZwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/k/hP1d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/k/hP1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B6CC2BCB0;
	Mon, 18 May 2026 01:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779068999;
	bh=WzWTn9tl1g4sOPS+EMsTorbk+sC0UjeGSJFHPEwEGpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=J/k/hP1dthe5njbGTd+DmD90MC70kyE9oo68MBfcKV+EhSOcohTB9d2OslCgz10kN
	 N1G0TdfMJBu4dhkqlAquXom1ea7WE2NynCdPbbHyIZ9NHudihaSJ6iCjbSrDl2We7e
	 eCUrPm2ZG3ad7XZydc3gGYlFaXEPS13qZlJ3vizodwI55cWwIWrxDl6PE+TWOXsYqM
	 ogsIgQlN63DU4bWFZffOEU2pl+uzwoAjUfl2ElVBmOgRSXMotgZGOk8m0KKXu35De6
	 MVAz0Jgk9DA3TgIuv83Z1rlIJ0rDDj8bhr0whmU+l94heuBVvUD6Bis8UxultPB9cq
	 tyc4WeuXhRRag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] PCI: dwc: Use common
 pci_host_common_link_train_delay() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260518004246.1384532-5-18255117159@163.com>
References: <20260518004246.1384532-5-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 01:49:59 +0000
Message-Id: <20260518014959.C7B6CC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Including the private header of the `pci-host-common` framework int=
o the DesignWare Core (DWC) framework introduces an inappropriate cross-dri=
ver dependency.
--

commit 826f6ff69b866addd978e8c94219d9a3f4ffea60
Author: Hans Zhang <18255117159@163.com>

PCI: dwc: Use common pci_host_common_link_train_delay() helper

This commit replaces an open-coded 100ms link training delay in the
DesignWare Core (DWC) driver with the pci_host_common_link_train_delay()
helper. It adds a relative path include to access the helper from the
generic host framework.

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
>  #include "../../pci.h"
>  #include "pcie-designware.h"

This isn't a bug, but does including a sibling framework's private header
using a relative path violate component isolation?

Since pci-host-common.h is specific to the generic ECAM host controller
architecture, and DWC is a completely separate controller architecture,
reusing this helper directly introduces a cross-driver dependency.

Because the 100 ms link training delay is a generic PCIe specification
requirement (PCIe r6.0 sec 6.6.1), should this helper be relocated to a
shared PCI core header such as drivers/pci/pci.h instead of remaining in
the pci-host-common framework?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518004246.1384=
532-1-18255117159@163.com?part=3D4
