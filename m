Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FC36167E
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 22:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106487; cv=none; b=CJgp6J0V7KMegNnqHI4zyCXDK7OCjShrAHO3zuqyENn10drJWAlDJOKmcZwy+xq6o7IsBregKHJZ8ga84DemCvx8RZRuiRDhwrIi6gx8qmrsTPRmWElsxWCS9rm6hYe7ZFpQdqIdke/TZ2HGZfK904p0t0THnUJg6j2YQCj7PRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106487; c=relaxed/simple;
	bh=KUFXNGNKDMy6CxU00ZAK22Cgbkx1GwmK22jzq8AB7Wc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l+XwXDrTJi6abAznBqKjMvGofoRzLRKXOLF/q8n4zOXmJmPwBBhaFvgzOiXJ0pf1bTk6xnN60LqHy1F2cyPGQajjgo2/rI9IVS7/e1CqWBbx99vQHDZEwgLqEubP5I2xqaG5SAW+Q7qciKMF7rae/XSME9ckJuc7egfjU+0wi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGKPQ2OZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGKPQ2OZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28525C2BCB0;
	Wed,  6 May 2026 22:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778106487;
	bh=KUFXNGNKDMy6CxU00ZAK22Cgbkx1GwmK22jzq8AB7Wc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZGKPQ2OZ4uCh5zVHh5JMbuLjL/ZLt4HTBXry4JSphREHMvZer8hjLesPSwQyfoo+d
	 KDT+sKvrMmV+xEWqdwoZXbtJsjoyZXDdNWzaCFD7zSb55KIsIOgPAojhoYLghsiday
	 90fTFqJGzkc6uYAFHnn5L5znNLWdTNFjfIROdB/xLosqYNXXb4miYLwqub1jctb2uq
	 NsusqoiVc1mmFvih251AfEY4r9zK3QAWxLI3qnwkn5GqBrhXQn6dYphtD7VqDUzmpT
	 lg7UQrd7rjvrarZwpGH8mgT5Sl7UOe4ijWXY0A70BKJeD2mHm78sfKUomtW7yCN/yL
	 DJMpOpCcMsYZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] PCI: rzg3s-host: Add 100 ms delay after link
 training
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260506152346.166056-9-18255117159@163.com>
References: <20260506152346.166056-9-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 22:28:06 +0000
Message-Id: <20260506222807.28525C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The added link training delay is redundantly misplaced and silen=
tly fails to apply when the Device Tree property is absent.
--

commit 54b605149567b07684ca19210d899f1f515af48d
Author: Hans Zhang <18255117159@163.com>

PCI: rzg3s-host: Add 100 ms delay after link training

This commit attempts to enforce a 100 ms delay after link training completes
for speeds above 5.0 GT/s. It adds a call to pcie_wait_after_link_train()
at the end of rzg3s_pcie_host_init().

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index d86e7516dcc29..6ab59c5464cfa 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1390,6 +1390,8 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_h=
ost *host)
>  	val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
>  	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
> =20
> +	pcie_wait_after_link_train(host->max_link_speed);

If the max-link-speed Device Tree property is omitted, host->max_link_speed
is populated with -EINVAL.

When -EINVAL is passed to pcie_wait_after_link_train(), the max_link_speed =
> 2
check evaluates to false. Will this cause the delay to be skipped entirely,
even if the actual link speed is above 5.0 GT/s?

Additionally, is this added delay redundant?

Looking at rzg3s_pcie_host_setup(), it already unconditionally sleeps for
100ms before returning:

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_host_setup() {
...
	ret =3D rzg3s_pcie_host_init(host);
	if (ret) {
...
	}

	ret =3D rzg3s_pcie_set_max_link_speed(host);
	if (ret)
		dev_info(dev, "Failed to set max link speed\n");

	msleep(PCIE_RESET_CONFIG_WAIT_MS);

	return 0;
}

Since rzg3s_pcie_set_max_link_speed() can trigger link retraining, should
the wait occur after that final link training completes rather than here
in rzg3s_pcie_host_init()?

> +
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506152346.1660=
56-1-18255117159@163.com?part=3D8
