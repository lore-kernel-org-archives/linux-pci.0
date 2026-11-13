Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794569452;
	b=NGNPiWYWGA8cXi/Eau6qC4VN6KKKwRLbi99iLGyAwFhKF4uXofKqBdxpWtzkF0erPwb0
	 wMNUReoX3M0PyKYVCK7WIuzipNIua6pAMtm+78auYEjh2wEDLf+tdFOhFdAaw2n0e7Zty
	 iw67dtiBxfeb4agEMax0xrtN3ZSZ8G20HXZXWhp4hE0igTh5lpfgVdUHRsbnAVDEX9YSz
	 GJyktNd65xTfhrgLDVJQGozjZHo4A3qk8UkJZK4NyPjQ9n42hkDRcACXfiLhQMf4ud9C+
	 vcRE9c4I0IvwZwgRcY4bO8KqCa0bovRNSn89UUlXJGIqvPHO8vcUpO3LnRfHKomOP+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569452;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PnqFm2jYeAVrycuwwVcWm5rqzekmC81/znw1H31yK8Y=;
	b=5EPr571jaYOUbG23oi13znBTFB9URUnwiV7+QpLlZB8xWZFzeFtTJfrYtyGjurn2tEEH
	 m54RLwhjWtT6//1ijwW4dn+iStRyPmfPFizza0L3JMOJENtOYJ4GBqP3wJnjoHZpVZun2
	 PTcJ7iOxtwJYExbQ3+cf5R6b4FxEdK+3nD2DkU8v+BHPMJyYW2JPKnKa3/5tDdSZBQeA+
	 fs+hN0wz1gWCmpAmELCs1Pw45Ve1UpS5JBqeIuBQyydvmQCrIGXsvugDFP0mv1ziOLPQX
	 tI8T+NPVqhbQ+B9pOnblyDOSPa4fjhm80oDTuH9XKzbebpC0e2toZMGdDbC7lxPQigA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ozlabs.ru;
	spf=pass smtp.mailfrom=ozlabs.ru;
	dkim=pass header.d=ozlabs.ru header.i=@ozlabs.ru header.a=rsa-sha256 header.s=fm2 header.b=meyXLT19;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z5KwZaQH;
	arc=none smtp.remote-ip=202.12.124.136
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84AB606A89F
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 11:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D84AB606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ozlabs.ru header.i=@ozlabs.ru header.a=rsa-sha256 header.s=fm2 header.b=meyXLT19;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=z5KwZaQH
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id B80B9130327D
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 06:30:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 13 Nov 2026 06:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.ru; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794569443;
	 x=1794576643; bh=PnqFm2jYeAVrycuwwVcWm5rqzekmC81/znw1H31yK8Y=; b=
	meyXLT19M5tP7DpYkCarFfEvAZ98dGNdhyj5+9QpEzKxvNaClUxy6dTnbD0Rpd/n
	zWdv/EQHbNzX/lkVmrCGaUCDm2V0L0gg7WR9CMXWT7D2AtrkYFblMEydDYmEqHc5
	T5/8mp8dv4ddaRmHBiM20By/5mThMboMBfRh+bl2seBgnftCq7zNz+WFc9qU3txx
	y1zsoVUdjuvjSybxPHt6io16q/yhVkejW3o7KJexkFMPO5TmRy640ENV93bFDWvF
	tmctKNQdFOPtT1yBDFpvNYcaEBnbBkSpqtbQl6BflVVdiVPuwRbu42yUoE605UjK
	fp8mJRtNsA5XpYQWstw9Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794569443; x=
	1794576643; bh=PnqFm2jYeAVrycuwwVcWm5rqzekmC81/znw1H31yK8Y=; b=z
	5KwZaQHi47wioxVdckkyfexJXNh1yWLwJd+lk0ReeNehcKro10LwL9bD7bs9WnIM
	Z7Qbk65gvREhLj6tSfZnPDhsDd5sIdcyFc8iV/LJd9AujjpHob9yGLMjdmFusZtz
	iuqunZzSnWkrrH4E0+JKZEuVHPcFRnsBerwvqxCcA3847KTmMB8MGogcQC8/F6VG
	34TvkYXJNzfWW4IM6wDxxxqmcBZTs1zN08liBDYh0SyKU6yMl4v9ij91WMgWodoJ
	87fXCfvyIe9ikwPHuYplmB6nfdWyhz7vWP3PgQMW9QGF9WEZyoWbAKNijHxnuiJb
	QttyeCAKCpVJhWKkTn5LQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ozlabs.ru a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794569443; d=ozlabs.ru;
	mf=PGFpa0BvemxhYnMucnU+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DsNPL2oBZdFq9HuUHucR7COJF0YQYdJDyrSJuCyC2wag4jS
	nSqjx7Flg/b2oXv9Qt6/zu8ZDi7sh+MqRh4gh7AqW54qVqBVPgAvjFR5MQANMiv4
	lzgxPUU+XU5xIjV3M8QFtB6ZENY6VRA/Ntl/zPGt1tmDkamJlIwpSk7n8+VMoijp
	21+VosD++GGJtBsUWevjErDu08QF3WWwyiGUyF3gnel3KIqta/E/yeYUKxflyylz
	xm7leBVPwOW0aON17oPR9EzrBqr4gOv++pPG+VurbwoH0WfW1bDUYLDPZvGndpu1
	Ni9xHscJ4POzROl1my2vzH1fffX994Rlk8XAwzw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:iFx97hTcJ8Y1HUPfOfFECH232yfXw3++rBlsuYz0mF0=:tlT8VnyioQvKXETdlI95QOP3NKRxuzvpY7TOEGpmLWA=;
X-ME-Sender: <xms:4vT2aukLJNhXIlf5PCN5DDG_DUPVgFMdT3W3STgPD6GZFqVfRZBunA>
    <xme:4vT2ath-eWWok9eJRVsMbzX26Zs67vK0HG9xuIiXoCBdNCyp9uux2qSyB8cLCnQPa
    AfjZbjzKaY_I9ndGZiEb_sQz63W9zRN7re10r9-47dGWxL2N0KOBmsYVw>
X-ME-Received: <xmr:4vT2au0hf_49BkaVpZVERbm7WPN01EaKpUsTyIQ_u13aDA3gmVmP2541xH8vYpLuJCY>
X-ME-Proxy-Cause: dmFkZTGaq2+9qYRP465S1d+h0vXe/GuuDBYKns8z2mjhl4Mh0Tz8Jm1Q5IM59n2D+nYg00
    adwvLbeR/yRRkZP0bvBiD3E+0a7ovEe1XqkgRvybXznyODhw8beoxifL9k20sY2YwzmQoj
    R6l5ikRhfWRx3WaGBbFDyppVKKBZw9G6WIBDHCtAMj/mkNi/iCMOhe/08YcdFgBcef6tj6
    VyPIRk+TFJ26QQnBWIPmk6f6yldoBEuKiueQEwzUJ3kUyoOWpE4fIwDfLkEJPNsGEcG9Dw
    qEzByjb+To7cJv6CAJ36oyif6gyFz8GxU55MM1bSRgezL7B1iLqWnUYZIEVeORWHwTMrEo
    DQWU963CHbyGdksWrG9aZenHkDnTlUf2FX4V+ez7VangjG+/vZbYZjKk2CKp8Tjpyt8pno
    Gjhv01vgSNvg/pblIP/pWZyjUB5WQwo0Sf9n2/iLH1XZLgSg+6DeZMTVo1H3MDMECQXmvB
    tx1bJgI8JpCUVsYAwLxCDaAsC4hNzvwNedUqA+IzVOJ9uTOfhG4njJ2KYmNMS8q5I24owj
    seD77vt2pgtfFxHHNzvGEjwbCxL0I0kNXFyNrXCuL3dQDQ1CJ/w1/oKl4lNWUt2nPZOYLR
    N8iDMJOHzKj4RNhR3wnB9RHeT4TgPYv1JEIHhK7NpSBn3GDTDjJtBLmifAVw
X-ME-Proxy: <xmx:4vT2ahTlwSkZzQRCNTy4e4IM1jjgnsiV6UQQe5LtT3yhoLT7lAnbUA>
    <xmx:4vT2agbrba6_sGmOV8yoWpigfnLXrNHVxahQV1rGxnC3A4QpIpBM0w>
    <xmx:4vT2au4qVBkej9Xwa24yw8dsyUBpBsGuInNz8qBD8STYHJGZ2R1oBA>
    <xmx:4vT2ahv2H635BgSHqh-pUX_ge_nlp_d02QRTAzGWj151IJlG3YtULw>
    <xmx:4_T2ajypviWSmq8MjGemjX20HXWfonfrDF0zuQLuAQ4YiMzffTrauvgd>
Feedback-ID: i6e394913:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 06:30:29 -0500 (EST)
Message-ID: <de5772b3-c340-4822-a49a-1434ece1b144@ozlabs.ru>
Date: Fri, 13 Nov 2026 22:30:23 +1100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/19] driver core: Introduce a generic device trust
 level
To: Leon Romanovsky <leon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-11-3b12d9a9f861@nvidia.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Content-Language: en-US
In-Reply-To: <20261109-device-trust-core-v2-11-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/11/26 18:33, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Device setup needs a common operating policy before driver probing or DMA
> configuration. Userspace must be able to hold devices disabled until it
> authorizes them.
> 
> Add generic trust admission with an immutable global boot policy. Restrict
> the compatibility attachment API to explicit global full policy and full
> operation, checking admission before probe. Keep the operating level
> stable until teardown and retain normal locked admission for other callers.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

this got many CCs except the one where I was (eagerly) looking for it: linux-coco@lists.linux.dev :)


> ---
>   Documentation/admin-guide/kernel-parameters.txt |   8 ++
>   drivers/base/Makefile                           |   2 +-
>   drivers/base/base.h                             |  16 +++
>   drivers/base/core.c                             |   3 +
>   drivers/base/dd.c                               |  38 ++++++-
>   drivers/base/trust.c                            | 132 ++++++++++++++++++++++++
>   include/linux/device.h                          |   8 ++
>   include/linux/device/bus.h                      |  10 ++
>   include/linux/device/trust.h                    |  44 ++++++++
>   9 files changed, 258 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0b3c140babd94..81a936dca9476 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1259,6 +1259,14 @@ Kernel parameters
>   	dell_smm_hwmon.fan_max=
>   			[HW] Maximum configurable fan speed.
>   
> +	device_trust.default=
> +			[KNL] Set the initial trust policy for all devices.
> +			Format: { default | disabled | adversary | full }
> +			If omitted or set to default, preserve bus policy.
> +			Other values replace bus policy. The last valid value wins.
> +			Full-only manual driver attachment requires full; other
> +			global policies reject it before the probe callback.
> +
>   	dfltcc=		[HW,S390]
>   			Format: { on | off | def_only | inf_only | always }
>   			on:       s390 zlib hardware support for compression on
> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 435710f643a5c..cb3bd5fa2287a 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -3,7 +3,7 @@
>   
>   obj-y			:= component.o core.o bus.o dd.o syscore.o \
>   			   driver.o class.o platform.o \
> -			   cpu.o firmware.o init.o map.o devres.o \
> +			   cpu.o firmware.o init.o map.o devres.o trust.o \
>   			   attribute_container.o transport_class.o \
>   			   topology.o container.o property.o cacheinfo.o \
>   			   swnode.o faux.o
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 866b2beb6baa2..ba8b5b3c51a65 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -10,6 +10,7 @@
>    * shared outside of the drivers/base/ directory.
>    *
>    */
> +#include <linux/device/trust.h>
>   #include <linux/notifier.h>
>   
>   /**
> @@ -88,6 +89,13 @@ struct driver_private {
>   };
>   #define to_driver(obj) container_of(obj, struct driver_private, kobj)
>   
> +enum device_trust_state {
> +	DEVICE_TRUST_SELECTABLE,
> +	DEVICE_TRUST_WAITING,

What is the exact difference between these? "Waiting" is waiting for what?

> +	DEVICE_TRUST_AUTHORIZED,
> +	DEVICE_TRUST_COMMITTED,

And exact difference between these two? Some documentation would be great.

dev->trust_policy is how we want the device to operate.
dev->p->trust_state is where the device is on its way to that final policy.

right?


> +};
> +
>   /**
>    * struct device_private - structure to hold the private to the driver core
>    *			   portions of the device structure.
> @@ -105,6 +113,7 @@ struct driver_private {
>    *			   dev_err_probe() for later retrieval via debugfs
>    * @device: pointer back to the struct device that this structure is
>    *	    associated with.
> + * @trust_state: policy admission state
>    * @dead: This device is currently either in the process of or has been
>    *	  removed from the system. Any asynchronous events scheduled for this
>    *	  device should exit without taking any action.
> @@ -121,6 +130,7 @@ struct device_private {
>   	const struct device_driver *async_driver;
>   	char *deferred_probe_reason;
>   	struct device *device;
> +	enum device_trust_state trust_state;
>   	u8 dead:1;
>   };
>   #define to_device_private_parent(obj)	\
> @@ -166,6 +176,12 @@ void bus_remove_driver(struct device_driver *drv);
>   void device_release_driver_internal(struct device *dev, const struct device_driver *drv,
>   				    struct device *parent);
>   
> +/* Full-only manual attachment uses the caller's subsystem serialization. */
> +void device_trust_init_state(struct device *dev);
> +int device_trust_prepare(struct device *dev, const struct device_driver *drv);
> +int device_trust_prepare_full(struct device *dev, const struct device_driver *drv);
> +void device_trust_clear(struct device *dev);
> +
>   void driver_detach(const struct device_driver *drv);
>   void driver_deferred_probe_del(struct device *dev);
>   void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf);
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index cbe05197d4a0b..6b94a163cda8d 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3681,6 +3681,9 @@ int device_add(struct device *dev)
>   	if (error)
>   		goto name_error;
>   
> +	device_trust_init(dev);
> +	device_trust_init_state(dev);
> +
>   	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
>   
>   	parent = get_device(dev->parent);
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 0f56c3d825731..449986f741009 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -558,12 +558,24 @@ static int __device_bind_driver(struct device *dev)
>    */
>   int device_bind_driver(struct device *dev)
>   {
> -	return __device_bind_driver(dev);
> +	int ret;
> +
> +	if (dev->bus && dev->bus->trust_resolve)
> +		return -EOPNOTSUPP;
> +
> +	ret = device_trust_prepare(dev, dev->driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = __device_bind_driver(dev);
> +	if (ret)
> +		device_trust_clear(dev);
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(device_bind_driver);
>   
>   /**
> - * device_driver_attach_full - attach a driver using subsystem serialization
> + * device_driver_attach_full - attach a driver under the global full policy
>    * @drv: driver to attach
>    * @dev: device to attach it to
>    *
> @@ -576,6 +588,12 @@ EXPORT_SYMBOL_GPL(device_bind_driver);
>    * It calls the bus or driver probe callback and publishes the binding without
>    * performing the normal driver-core DMA, pinctrl or power-domain setup.
>    *
> + * Requires device_trust.default=full and a full operating level. Runtime
> + * policy writes are disabled in this mode; boot policy exceptions still
> + * apply. When driver boot rules exist, an explicit device boot rule must
> + * exclude them for @dev. Buses with a trust resolver must use
> + * device_driver_attach().
> + *
>    * Return: 0 on success, or a negative error before binding.
>    */
>   int device_driver_attach_full(const struct device_driver *drv, struct device *dev)
> @@ -587,6 +605,10 @@ int device_driver_attach_full(const struct device_driver *drv, struct device *de
>   	if (dev->driver)
>   		return -EBUSY;
>   
> +	ret = device_trust_prepare_full(dev, drv);
> +	if (ret)
> +		return ret;
> +
>   	device_set_driver(dev, drv);
>   	if (dev->bus->probe)
>   		ret = dev->bus->probe(dev);
> @@ -610,6 +632,7 @@ int device_driver_attach_full(const struct device_driver *drv, struct device *de
>   	devres_release_all(dev);
>   	device_set_driver(dev, NULL);
>   	dev_set_drvdata(dev, NULL);
> +	WRITE_ONCE(dev->trust_level, DEVICE_TRUST_DISABLED);
>   	if (ret == -EPROBE_DEFER)
>   		return -EAGAIN;
>   	return ret;
> @@ -739,6 +762,14 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
>   	}
>   
>   re_probe:
> +	ret = device_trust_prepare(dev, drv);
> +	if (ret) {
> +		device_links_no_driver(dev);
> +		/* Report it like a probe error so a scan tries the next driver. */
> +		ret = -ret;
> +		goto done;
> +	}
> +
>   	device_set_driver(dev, drv);
>   
>   	/* If using pinctrl, bind pins now before probing */
> @@ -805,6 +836,7 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
>   		if (dev->bus && dev->bus->dma_cleanup)
>   			dev->bus->dma_cleanup(dev);
>   		device_unbind_cleanup(dev);
> +		device_trust_clear(dev);
>   
>   		goto re_probe;
>   	}
> @@ -831,6 +863,7 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
>   pinctrl_bind_failed:
>   	device_links_no_driver(dev);
>   	device_unbind_cleanup(dev);
> +	device_trust_clear(dev);
>   done:
>   	return ret;
>   }
> @@ -1420,6 +1453,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>   			dev->bus->dma_cleanup(dev);
>   
>   		device_unbind_cleanup(dev);
> +		device_trust_clear(dev);
>   		device_links_driver_cleanup(dev);
>   
>   		klist_remove(&dev->p->knode_driver);
> diff --git a/drivers/base/trust.c b/drivers/base/trust.c
> new file mode 100644
> index 0000000000000..6a71abf10b3bb
> --- /dev/null
> +++ b/drivers/base/trust.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <kunit/visibility.h>
> +
> +#include "base.h"
> +
> +static enum device_trust_policy device_trust_default_policy __ro_after_init;
> +
> +void device_trust_init_state(struct device *dev)
> +{
> +	dev->p->trust_state = dev->trust_policy == DEVICE_TRUST_POLICY_DISABLED ?
> +		DEVICE_TRUST_WAITING : DEVICE_TRUST_SELECTABLE;
> +}
> +
> +static int __device_trust_prepare(struct device *dev,
> +				  const struct device_driver *drv, bool full_only)
> +{
> +	enum device_trust_policy policy;
> +	enum device_trust_level level;
> +	int ret;
> +
> +	policy = dev->trust_policy;
> +
> +	if (policy == DEVICE_TRUST_POLICY_DISABLED)
> +		return -EPERM;
> +	if (dev->bus && dev->bus->trust_resolve) {
> +		ret = dev->bus->trust_resolve(dev, drv, policy, &level);
> +		if (ret)
> +			return ret;
> +	} else {
> +		level = policy == DEVICE_TRUST_POLICY_ADVERSARY ?
> +			DEVICE_TRUST_ADVERSARY : DEVICE_TRUST_FULL;
> +	}
> +	if (level == DEVICE_TRUST_DISABLED)
> +		return -EPERM;

This check can go right after trust_resolve() above. Thanks,


> +	if (full_only && level != DEVICE_TRUST_FULL)
> +		return -EPERM;
> +	if (dev->p->trust_state == DEVICE_TRUST_COMMITTED &&
> +	    dev->trust_committed_level != level)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(dev->trust_committed_level, level);
> +	dev->p->trust_state = DEVICE_TRUST_COMMITTED;
> +	WRITE_ONCE(dev->trust_level, level);
> +	return 0;
> +}
> +
> +int device_trust_prepare(struct device *dev, const struct device_driver *drv)
> +{
> +	device_lock_assert(dev);
> +	return __device_trust_prepare(dev, drv, false);
> +}
> +
> +int device_trust_prepare_full(struct device *dev, const struct device_driver *drv)
> +{
> +	if (device_trust_default_policy != DEVICE_TRUST_POLICY_FULL)
> +		return -EPERM;
> +
> +	return __device_trust_prepare(dev, drv, true);
> +}
> +
> +void device_trust_clear(struct device *dev)
> +{
> +	device_lock_assert(dev);
> +	WRITE_ONCE(dev->trust_level, DEVICE_TRUST_DISABLED);
> +}
> +
> +/**
> + * device_get_trust_level - Return a device's active trust level
> + * @dev: device to inspect
> + *
> + * The value is stable from the start of DMA configuration through the end of
> + * DMA cleanup. An unbound device has %DEVICE_TRUST_DISABLED as its active
> + * trust level.
> + *
> + * Return: The active trust level for the current bind transaction.
> + */
> +enum device_trust_level device_get_trust_level(const struct device *dev)
> +{
> +	return READ_ONCE(dev->trust_level);
> +}
> +EXPORT_SYMBOL_GPL(device_get_trust_level);
> +
> +/**
> + * device_is_adversarial - Test whether a device is operated as an adversary
> + * @dev: device to inspect
> + *
> + * Return: True when the active trust level is %DEVICE_TRUST_ADVERSARY.
> + */
> +bool device_is_adversarial(const struct device *dev)
> +{
> +	return device_get_trust_level(dev) == DEVICE_TRUST_ADVERSARY;
> +}
> +EXPORT_SYMBOL_GPL(device_is_adversarial);
> +
> +static const char * const device_trust_policy_names[] = {
> +	[DEVICE_TRUST_POLICY_DEFAULT] = "default",
> +	[DEVICE_TRUST_POLICY_DISABLED] = "disabled",
> +	[DEVICE_TRUST_POLICY_ADVERSARY] = "adversary",
> +	[DEVICE_TRUST_POLICY_FULL] = "full",
> +};
> +
> +static int __init device_trust_default_setup(char *str)
> +{
> +	int policy = match_string(device_trust_policy_names,
> +				  ARRAY_SIZE(device_trust_policy_names), str);
> +
> +	if (policy < 0) {
> +		pr_warn("device_trust: ignoring invalid default policy '%s'\n", str);
> +		return 1;
> +	}
> +
> +	device_trust_default_policy = policy;
> +	return 1;
> +}
> +__setup("device_trust.default=", device_trust_default_setup);
> +
> +/**
> + * device_trust_init - Apply global boot policy before registration
> + * @dev: unregistered device with its initial policy set
> + */
> +void device_trust_init(struct device *dev)
> +{
> +	if (device_trust_default_policy != DEVICE_TRUST_POLICY_DEFAULT)
> +		dev->trust_policy = device_trust_default_policy;
> +}
> +EXPORT_SYMBOL_GPL(device_trust_init);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 42e966ebaa2d3..57d2e1b0d98ad 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -30,6 +30,7 @@
>   #include <linux/device/class.h>
>   #include <linux/device/devres.h>
>   #include <linux/device/driver.h>
> +#include <linux/device/trust.h>
>   #include <linux/cleanup.h>
>   #include <asm/device.h>
>   
> @@ -695,6 +696,10 @@ enum struct_device_flags {
>    * @removable:  Whether the device can be removed from the system. This
>    *              should be set by the subsystem / bus driver that discovered
>    *              the device.
> + * @trust_policy: Requested operating policy, resolved before driver probe.
> + * @trust_level: Active trust level while a driver is bound, see
> + *		device_get_trust_level().
> + * @trust_committed_level: Operating level retained across bind transactions.
>    * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
>    *
>    * At the lowest level, every device in a Linux system is represented by an
> @@ -798,6 +803,9 @@ struct device {
>   	struct device_physical_location *physical_location;
>   
>   	enum device_removable	removable;
> +	enum device_trust_policy trust_policy;
> +	enum device_trust_level trust_level;
> +	enum device_trust_level trust_committed_level;
>   
>   	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
>   };
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index 9ef7538a9a7f2..ba2b5743a47cd 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -17,6 +17,7 @@
>   #include <linux/kobject.h>
>   #include <linux/klist.h>
>   #include <linux/pm.h>
> +#include <linux/device/trust.h>
>   
>   struct device_driver;
>   struct fwnode_handle;
> @@ -59,6 +60,11 @@ struct fwnode_handle;
>    * @resume:	Called to bring a device on this bus out of sleep mode.
>    * @num_vf:	Called to find out how many virtual functions a device on this
>    *		bus supports.
> + * @trust_resolve: Resolve a requested trust policy to an active trust level
> + *		immediately before driver probe. The device lock is held and
> + *		@drv is the candidate driver, which dev->driver does not name
> + *		yet. Return 0 on success or a negative errno. This callback
> + *		must not enable the device.
>    * @dma_configure:	Called to setup DMA configuration on a device on
>    *			this bus.
>    * @dma_cleanup:	Called to cleanup DMA configuration on a device on
> @@ -102,6 +108,10 @@ struct bus_type {
>   
>   	int (*num_vf)(struct device *dev);
>   
> +	int (*trust_resolve)(struct device *dev,
> +			     const struct device_driver *drv,
> +			     enum device_trust_policy policy,
> +			     enum device_trust_level *level);
>   	int (*dma_configure)(struct device *dev);
>   	void (*dma_cleanup)(struct device *dev);
>   
> diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
> new file mode 100644
> index 0000000000000..b8f5514cacec3
> --- /dev/null
> +++ b/include/linux/device/trust.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _DEVICE_TRUST_H_
> +#define _DEVICE_TRUST_H_
> +
> +#include <linux/types.h>
> +
> +struct device;
> +
> +/**
> + * enum device_trust_level - active trust level for a device
> + * @DEVICE_TRUST_DISABLED: The device cannot be operated by a driver
> + * @DEVICE_TRUST_ADVERSARY: Operate the device with adversarial restrictions
> + * @DEVICE_TRUST_FULL: Operate the device with the usual kernel privileges
> + *
> + * Active trust levels are discrete states, not an ordered privilege scale.
> + */
> +enum device_trust_level {
> +	DEVICE_TRUST_DISABLED,
> +	DEVICE_TRUST_ADVERSARY,
> +	DEVICE_TRUST_FULL,
> +};
> +
> +/**
> + * enum device_trust_policy - requested device trust policy
> + * @DEVICE_TRUST_POLICY_DEFAULT: Let the bus select the active trust level
> + * @DEVICE_TRUST_POLICY_DISABLED: Request that the device remain disabled
> + * @DEVICE_TRUST_POLICY_ADVERSARY: Request adversarial operation
> + * @DEVICE_TRUST_POLICY_FULL: Request normal operation
> + *
> + * A requested policy is resolved to an active trust level before a driver is
> + * probed.
> + */
> +enum device_trust_policy {
> +	DEVICE_TRUST_POLICY_DEFAULT,
> +	DEVICE_TRUST_POLICY_DISABLED,
> +	DEVICE_TRUST_POLICY_ADVERSARY,
> +	DEVICE_TRUST_POLICY_FULL,
> +};
> +
> +void device_trust_init(struct device *dev);
> +enum device_trust_level device_get_trust_level(const struct device *dev);
> +bool device_is_adversarial(const struct device *dev);
> +
> +#endif /* _DEVICE_TRUST_H_ */
> 

