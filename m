Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C637B011
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 02:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072079; cv=none; b=Wk7lbtoBI9J7EHHVzxzN1I5pfL/YdKqJ3wbD5PiVsq4XytA1ZXUQnI8ediG+1u5F4YM0xzJWU5MjI504Cs8/4Ytlc7w9zEZmt7LXQPbFGFvnzJNxSidOzuThkVi13jascxiCzmDl4yue9ajYGnM1jq/wCXHnkBRqY7R2SmH8FXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072079; c=relaxed/simple;
	bh=rUoDRklZyyDtzH6iX9MrLKmdTkxULbI3Dch4duabLj8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E+9JGzOK0RyqWcSIJgZu/H/Oz9YA3Yuq/1Dcl4BhzGehPvtnreQSpkHZx8F+u/f9WwkJTZx98j5NXyiuBL12H2DM4KvGwQdCAHtcIOGDVk8znXq+0JSIHGat0AUGzjXwNc3tdD2vKayOrjtsP4KyzYv5Rafma4X13BnWDGWsGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7QIEriC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7QIEriC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9613C2BCB0;
	Mon, 18 May 2026 02:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779072078;
	bh=rUoDRklZyyDtzH6iX9MrLKmdTkxULbI3Dch4duabLj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=O7QIEriCIVY0ZpXeLBV6oLgkITCiWvb2nKc51nyx4HnHy6DP8VcOHsPtmUI+fTg0U
	 cBOta5BGJKBFZMFenDWVWQE+3hBNZosO4jKT8x8HaVLpsC9jpiRCSeml+ktQLD1Jfq
	 q0l0mhtcxxaZ3snjlZw7XAcI21n30osDR9EGIzISCtFDTwpjOzHwXHdshRWvShPYk7
	 hBwGoGJpjho72LFGq+9jtGFNNnqabRD9BD58hAWY4CTbtXBEiKk1OtP90c9Y8+7GNd
	 DFi+IuF6Hwyjtf4Oku46RYXhEWz6066ynLzeRBG2607RjqrKIfPCH5uUd5UnycEt2a
	 bdg60UbZQ7Fxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] PCI: rzg3s-host: Use common
 pci_host_common_link_train_delay() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260518004246.1384532-8-18255117159@163.com>
References: <20260518004246.1384532-8-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 02:41:18 +0000
Message-Id: <20260518024118.A9613C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The mandatory PCIe link training delay is skipped when the 'max-li=
nk-speed' device tree property is omitted.
--

commit 66a7457779d07490b3340e0c36c8ac63f1f0a84f
Author: Hans Zhang <18255117159@163.com>

PCI: rzg3s-host: Use common pci_host_common_link_train_delay() helper

This commit replaces an unconditional 100ms msleep with the
pci_host_common_link_train_delay() helper. The delay is now only applied
when max_link_speed is greater than 2.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
[ ... ]
> @@ -1663,7 +1664,7 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
>  	if (ret)
>  		dev_info(dev, "Failed to set max link speed\n");
> =20
> -	msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +	pci_host_common_link_train_delay(host->max_link_speed);

Could this regression skip the mandatory link training delay if the
max-link-speed device tree property is omitted?

If the property is missing, of_pci_get_max_link_speed() returns a negative
error code like -EINVAL, which gets stored in host->max_link_speed.

When rzg3s_pcie_set_max_link_speed() runs, it ignores negative values and
uses the hardware's native capability to configure the link, which could be
Gen3 or Gen4. However, host->max_link_speed is not updated to reflect this
actual link speed.

Because pci_host_common_link_train_delay() takes an int, passing the
negative error code causes the condition to evaluate to false:

drivers/pci/controller/pci-host-common.h:pci_host_common_link_train_delay()=
 {
        if (max_link_speed > 2)
                msleep(PCIE_RESET_CONFIG_WAIT_MS);
}

This skips the 100ms delay even for Gen3+ links, which could cause
enumeration failures for downstream devices.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518004246.1384=
532-1-18255117159@163.com?part=3D7
