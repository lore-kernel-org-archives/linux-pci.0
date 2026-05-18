Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB517DFE7
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779066116; cv=none; b=cIDEK8JdDQcZoEpeZVoAoa9u7Cxb3kzULRxY+Dbv6bn184P5IP90AOn/NereA6mEQzL+IT+6Swemp9xUHVn0f9XkgWCT5y3rA/lQrBOar69drlftJ5N2l+ZZr8U1fYVpURbRhXQQLhDnEio/iDjqJsA82hSVUIk21UPGUBWH4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779066116; c=relaxed/simple;
	bh=lD9bExASPWiTxcQGbKDTW26Ckn858tWb9CIx1duY08c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OPw1DuzdAdkNZ6t20WX12RI56D8wzNRuBF8ISBcpdY4UbYuT1BsjI5vWIjAjyF0WFLJKzOKyjOI1UA8CdWyZUWbNdzQ8imA83dlDkuplEFSsX8r9/hE/i3ZhQVSGVCfnTOev5K7Sm9p+SA9whv28Iwf0/rr2V0HOkr+gW2RcJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKLH+l+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKLH+l+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED99C2BCB0;
	Mon, 18 May 2026 01:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779066116;
	bh=lD9bExASPWiTxcQGbKDTW26Ckn858tWb9CIx1duY08c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CKLH+l+K2Q4taLGyZ9cw+ZzV7FvLJ7f9z1Q2gps7mSNLixLCJj3HTmnCDJDaTB9JY
	 u73JnOpen/HeIVXD1/AfeXUkv1LoQERcZRhHr9szvP8KfH7kU5B63RzimXPzCq/ZyM
	 GGge0Vi9xq4EOxszgFM7EVeYz/VaRKBspJR3iAWdGsbJ1G+elVUJQyQqS93+pJHU14
	 GJ8soPUUzdwv/9yNprtDbVzfRBWXwMXLIrpRv01lrKQyTx7c9NvcR+gvOMdg/W2Qa1
	 pwQOixgwqqz9EtoBPoncSyQ8VhPZ2cRrDfI8LvpzUaFlqmG92/DUnpR31Y2HVkFtqV
	 0DjItOR+cblQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/7] PCI: Add pci_host_common_link_train_delay()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260518004246.1384532-2-18255117159@163.com>
References: <20260518004246.1384532-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 01:01:55 +0000
Message-Id: <20260518010156.2ED99C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Generic PCIe link training logic is incorrectly scoped to a fram=
ework-specific header, causing unnecessary coupling.
- [Medium] Including `../pci.h` inside a shared header file breaks subsyste=
m encapsulation.
--

commit e409ebd1e8d25418f5cc0346099d7e22ffac79dd
Author: Hans Zhang <18255117159@163.com>

PCI: Add pci_host_common_link_train_delay() helper

This commit introduces a static inline helper to wait 100 ms after link
training if the link speed is greater than 5.0 GT/s, in accordance with
PCIe r6.0 sec 6.6.1. The helper is placed in pci-host-common.h to allow
multiple host controller drivers to share the logic.

> diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/contr=
oller/pci-host-common.h
> index b5075d4bd7eb3..d709f7e3e11a3 100644
> --- a/drivers/pci/controller/pci-host-common.h
> +++ b/drivers/pci/controller/pci-host-common.h
> @@ -10,6 +10,9 @@
>  #ifndef _PCI_HOST_COMMON_H
>  #define _PCI_HOST_COMMON_H
> =20
> +#include <linux/delay.h>
> +#include "../pci.h"

Does including ../pci.h inside a shared header file create a regression
in subsystem encapsulation?=20

drivers/pci/pci.h is a private header meant exclusively for internal PCI
core subsystem definitions. Exposing it in this shared header could pollute
the namespace of any driver that includes it. Moving the helper directly
into drivers/pci/pci.h might resolve this regression without requiring
additional includes.

[ ... ]

> @@ -20,4 +23,18 @@ void pci_host_common_remove(struct platform_device *pd=
ev);
> =20
>  struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
>  	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
> +
> +/**
> + * pci_host_common_link_train_delay - Wait 100 ms if link speed > 5 GT/s
> + * @max_link_speed: the maximum link speed (2 =3D 5.0 GT/s, 3 =3D 8.0 GT=
/s, ...)
> + *
> + * Must be called after Link training completes and before the first
> + * Configuration Request is sent.
> + */
> +static inline void pci_host_common_link_train_delay(int max_link_speed)

Since the 100 ms delay requirement for downstream ports supporting > 5.0 GT=
/s
is a universal PCIe specification rule (PCIe r6.0 sec 6.6.1), does placing
this helper in the ECAM-specific pci-host-common.h introduce an
architectural regression?

Placing it here forces non-ECAM host controllers to include an unrelated
ECAM header just to use it. Could this be named generically and placed in
a central location like drivers/pci/pci.h instead?

> +{
> +	if (max_link_speed > 2)
> +		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +}
> +
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518004246.1384=
532-1-18255117159@163.com?part=3D1
