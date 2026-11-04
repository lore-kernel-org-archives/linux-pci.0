Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793799699;
	b=ogby6e+yI2kWNYjwZn/hAwsY3soLNSYLlcjS7kLAuuoIdAzQ4+CjiBs1hOAbtTweYimk
	 NyWInCrrYq2rozl/V2UA4yEOzXzvkdKRmYptQzAMiTswoqXpObSJZQjrSbPV5iNRgVBpM
	 Zv6REKw7Wr7nrwxzH+eTopFIWtIFO2UxEAxEbF5BYz61L2ggWSAYC0aW9dtnIvAQBx9+G
	 sCs+Ogaqn27/6M2NiDMtYIcyYcvLrI5FY7Yep3gJsu6Tx2t6craLRHV6uK/WmgeJVFpfC
	 61mmL+WMSpYD/kkVKJ7fs5mRkSt92lkpD2KIY4F6cuNJ5hmV+IPYeSr5Gdaq5mhGOyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799699;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=I4MrJ0us0cyVl7cuFGdkMVaNQnyIC3GHJZjZ2WZ4bC8=;
	b=K34p6SZQq50AdZbcS6U3r/daN57GYitBIIxmC+TTSf90ypO1ey/xd7t9WSWXn7fTFs9k
	 X6DYEnYGV2P8gxqYmuI5V7J9tJ60CxVwsqSQGaW/hoGtqpxTv4t5beUoWUTleZqPsWqFO
	 +PZ2Q1jYB6sk0z3BNWMf1msI01YPAlsV9Ey/f5auofk3b+OSkrP2+fKZlmKVBM5ZH0Eb0
	 n5WDvcJ1Jxs240j/II4CF2oU0nCyehFOLz+mfOZ3CrAACc/yJ9ePnqeyprgHQJ+T2HLIb
	 xMsnsXlDe6k/Uodg78pJVyrMVxmzyJSHyC0QZYTduYC8Zmw3tdMGneiNQVHPRMaCgRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jannau.net;
	spf=pass smtp.mailfrom=jannau.net;
	dkim=pass header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=D+HmIwUw;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vCvhrDvr;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E656606A329
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 13:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E656606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=D+HmIwUw;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vCvhrDvr
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3F517A0160
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 08:41:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 04 Nov 2026 08:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793799695; x=1793886095; bh=I4MrJ0us0c
	yVl7cuFGdkMVaNQnyIC3GHJZjZ2WZ4bC8=; b=D+HmIwUwPxSkAgYq97euIVpaVk
	pb85DgJrUPm3owN2cUP7z7hAqlWWIiMMFAAeW91CrZ2nDI5hvzn1PXQ56JVpjA/X
	V2G15tzcNrUK1Olupqm6n9+g0MCUsHh1G14wC1il9Zgi8HBGJSRn2ttJI8hqLYPt
	WIlPQsyfDkQfhaBrPsNhA43ozhs2wR93JcDmg1r6RYuS8259//nNrLpTyK4Esve4
	huiywvAPrz+Tn150hsJH9S0XOnVYJCsoUxIxi2fAgjxO0xz4ExLP2p7VfiRikUsN
	YDjiEZvjSsDRmI/GQerdEohfeOV62iNdg9ahB0ToDYtfg01sPMjvD1KiEe6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793799695; x=1793886095; bh=I4MrJ0us0cyVl7cuFGdkMVaNQnyIC3GHJZj
	Z2WZ4bC8=; b=vCvhrDvrELQ9UKx0dx7NpVOUb0B0UVL0n2JbKguTUtYYxk/8UrU
	h5P3fZRGgz8jQaWyWkt9co88K9dnejZwA4AIVmbThDKPZew/d8cGCPPdT14BC7D/
	WWm1OyPk5MMu6KCG1TgFhxsPLIk1Nzu3yksu/sN+ZpgDDFsi3fEDZfTcLCUdZrtL
	/JMpP3Ej63+gdcLmgwFs0rSZPf2gpS+X+DLiYyptx3SxPuZaohUeoybqxxjxOXOS
	v+ae2GjtfDH4n5GtRh1HYOTsN6BoYvALX1uXlV0FEVN6n+68p8XTF+Ujk+TQ034T
	BfETYGD2041wzm8eZqlVUd6Mi/a0r/uLLQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793799695; d=jannau.net;
	mf=PGpAamFubmF1Lm5ldD4=;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:rjBRhdFuGspznT53mR7eI4RqxnpXoHPiEIR85ad0ttPovgL
	0zjtDremQJqThzLrfsWYUV+hgAt1G+C1EXIb6QMIhgiXPOjjA0mto/202/RKqTZ7
	a8ckWm8aWlp2SpeodcS3Gw05Tw/uN04OszGij51DA6BvQfl/HhOckkPdWEyazRVT
	potTAyYvBOwlNQ4FrvB5a+/TtoCFUvGmxBUvZe6AohFq3XYrZDYoL8GhfaE7UEDN
	hY5TausCypS37ynvJSG0A0N3BelOeB2yTJSDR6iV21u3twIgc9kyLxxQEzjzbI/l
	3Tr8RZNFgLk98QFTVHvRJib3RZU79a8aszgRUAw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:EN7Cd8aiweMGl5lHrs2+4ANErcvjvC2KutppetHvMv0=:S98jBY3/ksFURwsVuG+I1Wx0g75J28yvU2mCrNKvD+0=;
X-ME-Sender: <xms:DzbraqRb1u2fUxgk9OWwD8uhHCHE-69W2wt2oLhE5ulelmT9Ct1Iog>
    <xme:DzbrarsbD9fPMSbYH4KvBp6q6Y8l6UlnJQczxVxs9rBGu32ZXvZFyyqUFD-64dYz4
    h7_WK4o8Q9ggxjwQ_W3UD3Ov65Nq1LaOv56FGZAFgYqVavgp8SRmj4A>
X-ME-Received: <xmr:Dzbrat9snqEtjp_T7CU1W4h0-amHAD8sv05_FEestw-mG8YpvHKUTvguZpzjzRNjawCAyE1HRNTbHjrRImzccP-tWzz5hLbhPvI>
X-ME-Proxy-Cause: dmFkZTGfAP7AcWTt7GSuE9cecOERqrNYgIUKwhLeSq+w+fwSyelYEqmcbQvAwFer7F/mE1
    PEpvxOME6dPfjCLp8Qigws1yULz0Wwf2BWE3Vvd7RsEIfU52IeZ9O9eEWHI/FJJlm/63Vr
    Q078hKiAl8k8Dc/19fKH+O2MKTgaX2GHpSclPxdmHaoCWfF+tjJOc7H4spAMAresvHH1nL
    Jz4T/QHWPL7ZtzAVf7SCpdBye4DhZLMBZmLQU+hGR0IpZYHQJxo1S0CLTr4jOG6DBLmAJE
    sR8O5nm4cb6ZIeuWQHOEpFf5R7CT6vFUMHgunron6jQaPRGVriUzoUC0U+LGnfzo7UL1LV
    lfhjvQdBNIXLYe2T1kVM9kJ7XfHozMyaD/rinhqZG/tsRPIPyO4CwUaBbleQ6EZoua00dc
    WVHRRQ1AnEZJk7AocDB8+w6K2nKIN+CuNFmuwGFaG7HKqwRvXmFHRFKpHR20yvolyLacal
    HmgE/KXswW3bf1h5+AzuvlYRrHgPyEvM+O50CGWE8bmmgg3zaR4+qTwj3WCoe/d7pY6Bgz
    QDerj1Dhk7jkuDGzypho+lNkQRzudP7J5vBMco0NJuq4XWSBaZT8pALwfU9kWSmeoAxOO8
    vCZWI/MuSOXohmvPUh8HFfzXmrHjQeT8qvvV9Kjl/M/YhpZ3ZMdcvCszukkA
X-ME-Proxy: <xmx:DzbrasaNfgg67RAEW2UdHxG47kEXZMeIcjjBGAw7L4hxV_hCZX8cMA>
    <xmx:Dzbrahr0icTSs6q48i0QnExe8xnr42Ba9ov0tCi9Z2kt6vt43TeGPw>
    <xmx:DzbrasbmLNHmVCwx9csVrrADHwO94ACgwJVUNKVQuGblCliSdoYhxA>
    <xmx:Dzbras5FmyRhNjiPVQSXxvGi_nNNiw8NGtveszWYfZfItfuttzglMA>
    <xmx:DzbraonyxuFy2n_wEuUZAN3vMDT6N5NfA8DvoI37hPilvs6CmCtHltiF>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 08:41:35 -0500 (EST)
Date: Wed, 4 Nov 2026 14:41:33 +0100
From: Janne Grunau <j@jannau.net>
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] PCI: apple: Integrate pwrctrl API
Message-ID: <20261104134133.GA756133@robin.jannau.net>
References: <20261104-apple-pcie-pwren-v2-0-216a4066965f@cyberchaos.dev>
 <20261104-apple-pcie-pwren-v2-2-216a4066965f@cyberchaos.dev>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104-apple-pcie-pwren-v2-2-216a4066965f@cyberchaos.dev>

On Wed, Nov 04, 2026 at 12:40:30PM +0100, Yureka Lilian wrote:
> Integrate the PCI pwrctrl framework into the Apple PCIe host driver to
> provide standardized power management for PCI devices.
> 
> Notably, this allows enabling powering on the WiFi, SD card reader on
> various Macs by means of the pwrctrl framework before probing the ports.
> 
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> ---
>  drivers/pci/controller/Kconfig      |  1 +
>  drivers/pci/controller/pcie-apple.c | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index d246bbe37948..791892a6c0c6 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -46,6 +46,7 @@ config PCIE_APPLE
>  	depends on OF
>  	depends on PCI_MSI
>  	select PCI_HOST_COMMON
> +	select PCI_PWRCTRL_GENERIC
>  	select IRQ_MSI_LIB
>  	help
>  	  Say Y here if you want to enable PCIe controller support on Apple
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index c2cffc0659f4..2d32092e2122 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -30,6 +30,7 @@
>  #include <linux/msi.h>
>  #include <linux/of_irq.h>
>  #include <linux/pci-ecam.h>
> +#include <linux/pci-pwrctrl.h>
>  
>  #include "pci-host-common.h"
>  
> @@ -825,6 +826,28 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>  	if (WARN_ON(!pcie))
>  		return -ENOENT;
>  
> +	// Ensure all ports can be powered on before attempting initialization
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		ret = pci_pwrctrl_create_device(of_port, pcie->dev);
> +		if (ret) {
> +			dev_err(pcie->dev, "Failed to create pwrctrl device: %pe\n", ERR_PTR(ret));

This should power down devices it already powered up and destroy the
created devices. As far as I can see -EINVAL is the only possible error
so the platform devices should be cleaned up

> +			return ret;
> +		}
> +
> +		ret = pci_pwrctrl_power_on_device(of_port);
> +		if (ret) {
> +			if (ret != -EPROBE_DEFER) {

-EPROBE_DEFER can be persistent, devices should be powered and
destroyed here as well.

> +				dev_err(pcie->dev,
> +					"Failed to power on device: %pe\n",
> +					ERR_PTR(ret));
> +				for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +					pci_pwrctrl_destroy_device(of_port);

this misses to power down already powered up devices.

One way to avoid the need to power down devices after
pci_pwrctrl_create_device() failures would be to split the loop into
two.

The power handling is now done on a per port basis as asked in v1 but it
is more or less a re-implementation of pci_pwrctrl_create_devices(),
pci_pwrctrl_destroy_devices() and pci_pwrctrl_power_on_devices().
For pcie-apple those are essentially loops over the the available ports
with error handling.

One annoying side effect of this change. I a single device fails to
power-on we will break ethernet on desktop Macs although it does not
need power control. So maybe ignoring errors except -EPROBE_DEFER would
be the better implementation. -EPROBE_DEFER itself is still a problem as
the power control for some ports are a optional dependency for other
ports.

Janne
