Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD8737FF75
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140808; cv=none; b=f8dvWvQzABpZV3oJ/QyK2WLGDUj8Lw8d9omIaXxC082d7pka1L9QfDJdsaiisD5AqXcKsIyDlqsrPM9J+IR6lD8QJunRHN5yl4Wa4MxD8pw4yC3CbxyJ2rIv8bBxZELhRMAzwXPUShaYl1nDml5Ad5YLj/31x91t2JJfFgr6by0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140808; c=relaxed/simple;
	bh=SR+fxGIHJLXN0ZRLCE64I6D0TckINCeme4AEx6Z9tQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N+FeRG/SQNwZ1bDG+FBSZteHItoMU7umLeQsGRLCnIf+YkVrn3vWAb3RiXN0/yXhnUNo8Vv7ecDbNgNFe3jzVdPd0SnjtygoYwyCwrJ2L4uLb0eTLZtwNNNiOQFwgaYK1zJHLuHSgVtNMTJZyHjvFvvWf+aF8wfgcwJuf4+SaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sclFAZLM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sclFAZLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21207C2BCC7;
	Thu,  7 May 2026 08:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140806;
	bh=SR+fxGIHJLXN0ZRLCE64I6D0TckINCeme4AEx6Z9tQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sclFAZLMdJmPn0r0LOflXrf/g9poZTebU80JibCfkSebrdPhZWjPHIMix58+ju+Ex
	 3lDdNRsKOjN9EhiezbGVer05iTquiiMI5QUQM1AO+h23AiRW5V791vo7YEVm1bEahp
	 PuvV/hyllyRjmLkpfQNSR37qyDGKLpnLTrKoEoMRxIbsz7SM7bpemUS8Nc/0GXthfj
	 sBxRGPyC+5/PM5M2iRv8p5hx3mX7S+gYujP4SEQz/IpcOYPk+LFccmApivJ0H8YdPY
	 LWQBmBSgq2vnbsO6mcldP/lch4pKM4OF5J/vnCsZiC0hg23DvvDncSqO+WvN3OAUPV
	 xL2pUsuZHRSCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 21/31] drm/rockchip: dsi: include PHY
 provider header
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260505100523.1922388-22-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-22-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 08:00:05 +0000
Message-Id: <20260507080006.21207C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch includes a private header from another subsystem using a =
relative path (`../../../phy/phy-provider.h`), breaking subsystem isolation=
 boundaries.
--

commit 82e5f2c2c18bd726ffe8bde8959c86cab426ad1e
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

drm/rockchip: dsi: include PHY provider header

This commit updates the Rockchip DSI controller driver to include the PHY
provider header using a relative path. The driver acts as both a PHY consum=
er
and provider, which requires access to the provider APIs.

> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi-rockchip.c
> index 3547d91b25d31..c0aaa51e02375 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> @@ -27,6 +27,7 @@
>  #include <drm/drm_print.h>
>  #include <drm/drm_simple_kms_helper.h>
> =20
> +#include "../../../phy/phy-provider.h" /* FIXME */

This isn't a bug, but does including a private header from another subsystem
using a deep relative path create brittle coupling across the source tree?

While the commit message notes this is discouraged but difficult to address
without moving the driver, bypassing the generic PHY framework's isolation
boundaries this way could cause compilation issues if the phy directory
structure changes in the future.

>  #include "rockchip_drm_drv.h"
> =20
>  #define DSI_PHY_RSTZ			0xa0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D21
