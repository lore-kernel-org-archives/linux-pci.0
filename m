Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79743126B9
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098717; cv=none; b=pH1S1NBmFXhYbdc7OefaPppxfI3j9wO+DFsu3UdR/yofDHyY6o5IO4ByGUezPL98AYk0NL41pUD6OwuLXGGRDiXGO6AS2huS6vjg5DbN/QcQNbCfOi5xzQWHpob15+BsD6+uRajRLJ0Kcm4+AbLXkVTUfmERtj4qParr6JO61uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098717; c=relaxed/simple;
	bh=FMgtrQbSIr4OI5J0KtBPF4H1X9NWlmx1vJXWDttcXhU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qVLXnXuI4ROKpyzQBzx1mtwkWW/YmOkno9/z99yV2Gb6virpzuiOTKXHcMMsc6JFz1hSwvNLaepD0pN/+vbo39HkDS1eI+v85SxY+XW3sF5dCh5AXrkMkjFQ0Ch/nGy0oCV4SXowzBpm2xXYsGm5wRITuQxauiJw34ev7/FVq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sguFfaA5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sguFfaA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68790C2BCB0;
	Wed,  6 May 2026 20:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778098716;
	bh=FMgtrQbSIr4OI5J0KtBPF4H1X9NWlmx1vJXWDttcXhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sguFfaA58RYXJCfDUOwI4zY4cN4/8bxnyOrLSlyyz6kcMC7iflb7B7qXhEupO6CUF
	 L3guDQpoEPz1xq80XA1EOsBkSn2L7Uu8nZw5kZCU8A/bDSbWq6D5uOgwVB1KD5iPxU
	 Ch5cgnkJc8P0ct9gAYkxizCEwjvYtT1SlcTONaDP9IvjGbzqf2Q2hYdnfzbHaYNEn3
	 8IEGSUKe2LIA247cam1tYdIJtCa0IXxyzKd1U+X31PCIehtwdXXxIfILkOH3a92Srz
	 XW7ujkOtCgjdm8JnSTcyV9ff1G7G3WUdzMAJ1Rq5nvHIES5g2S/chMGX2QOiwtQA0r
	 PLuxc2yZ7NkHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/8] PCI: Add pcie_wait_after_link_train() helper
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260506152346.166056-2-18255117159@163.com>
References: <20260506152346.166056-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:18:35 +0000
Message-Id: <20260506201836.68790C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The header drivers/pci/pci.h fails to include <linux/delay.h> despi=
te using msleep() in a static inline function.
--

commit 3b0eb6b945c6f31bfd19dfe4708d2d2cc57ab371
Author: Hans Zhang <18255117159@163.com>

PCI: Add pcie_wait_after_link_train() helper

This commit introduces a static inline helper pcie_wait_after_link_train()
to enforce a minimum 100 ms wait after Link training completes for downstre=
am
ports supporting speeds greater than 5.0 GT/s. This allows multiple host
controller drivers to share the delay logic.

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4a14f88e543a2..a8705a2a2d852 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -60,6 +60,19 @@ struct pcie_tlp_log;
>   */
>  #define PCIE_RESET_CONFIG_WAIT_MS	100
> =20
> +/**
> + * pcie_wait_after_link_train - Wait 100 ms if link speed > 5 GT/s
> + * @max_link_speed: the maximum link speed (2 =3D 5.0 GT/s, 3 =3D 8.0 GT=
/s, ...)
> + *
> + * Must be called after Link training completes and before the first
> + * Configuration Request is sent.
> + */
> +static inline void pcie_wait_after_link_train(int max_link_speed)
> +{
> +	if (max_link_speed > 2)
> +		msleep(PCIE_RESET_CONFIG_WAIT_MS);

Does this file need to include <linux/delay.h>?

The new helper uses msleep(), but drivers/pci/pci.h does not include
<linux/delay.h>. While this might not cause immediate build failures if
callers already include the header, it could cause implicit function
declaration errors for any future C files that include pci.h without
including <linux/delay.h> first.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506152346.1660=
56-1-18255117159@163.com?part=3D1
