Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4A383C80;
	Wed, 15 Apr 2026 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291061; cv=none; b=lWifzMClCuha/Ksxp7QkaI+6ZEIFkg2TTbkGtYXMxcz7EJFYbOvRW48Wu+IjjCJlodl8Sv9gYE0KQwBgiH0/TfQxblBoAqWgugU8c/EXpKjvQKuF4JXL5mPab9OFlvWkWbe/8CZZxWXG4+JGsIPJlwouxUm8lSqgdJCM8vvTTyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291061; c=relaxed/simple;
	bh=4MjkOgWu+H/4IbKFLTcEqaA80AYv/7LFnNzAZ1Q9/eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6paiYNmS4bZJDFfti1WA+88Hw4SQ933f7rgIvZPzOXueLP98ZlLLKxlyXELeibNyftzDh9tEWYxYO7OBCBJVHtwONAXgvzH0426ypTzuZJI4IjXlXCT4KOPZtjsCtWoXKwWNs5fRZ9aEAvI2KvuQQ4Z2asBU5/utkmPGtwJfVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0G82jNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0G82jNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9759C2BCB3;
	Wed, 15 Apr 2026 22:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776291061;
	bh=4MjkOgWu+H/4IbKFLTcEqaA80AYv/7LFnNzAZ1Q9/eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0G82jNvv+WdUrzCg0FXEUgFE67KoF8lsRoHLR1Eixg/LXzBOmBt72ny96ygZ1Yh7
	 5pjtAjRmscQPZ3vzTHEJVK2X3F5iY9VBGqR24yPawyJQ/gAIlyZBVqDlxU6RxtLQOu
	 GIOuEzZ4IIVyp1JVp1Bd0caHsANeP3Y9FjSY0dKokZFCp73u2B9/2SZh9VaeNP9dKw
	 bDqy1aSrrHxSChU/DDEkPqQ/9mXmyBZFULTx7CeyP1LoiLkGahr6y7zWTmj5JAf+iF
	 LSKM2823g0Z3h0jTPv9V+xvD6mu4GBgiebxCOKq/m8zV5ubcEy7dHDB71HDaXfInaG
	 zk3lxaVX52GYQ==
Date: Wed, 15 Apr 2026 17:10:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: astewart@tektelic.com, linux-arm-kernel@lists.infradead.org,
	Mark Brown <broonie@kernel.org>, bhelgaas@google.com,
	maz@kernel.org, linux@armlinux.org.uk, kees@kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Saravana Kannan <saravanak@kernel.org>, netdev@vger.kernel.org,
	linux-serial@vger.kernel.org, davem@davemloft.net, andrew@lunn.ch,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, brgl@kernel.org,
	jirislaby@kernel.org, mani@kernel.org,
	Johan Hovold <johan@kernel.org>, linux-aspeed@lists.ozlabs.org,
	linux-pci@vger.kernel.org, kuba@kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	andriy.shevchenko@linux.intel.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alexey Kardashevskiy <aik@ozlabs.ru>, lgirdwood@gmail.com,
	andrew@codeconstruct.com.au, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
	Eric Dumazet <edumazet@google.com>, linux-usb@vger.kernel.org,
	alexander.stein@ew.tq-group.com,
	Robin Murphy <robin.murphy@arm.com>, pabeni@redhat.com,
	devicetree@vger.kernel.org, driver-core@lists.linux.dev,
	joel@jms.id.au, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 8/9] driver core: Replace dev->of_node_reused with
 dev_of_node_reused()
Message-ID: <177629105858.764226.5689083905556313606.robh@kernel.org>
References: <20260406232444.3117516-1-dianders@chromium.org>
 <20260406162231.v5.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406162231.v5.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>


On Mon, 06 Apr 2026 16:23:01 -0700, Douglas Anderson wrote:
> In C, bitfields are not necessarily safe to modify from multiple
> threads without locking. Switch "of_node_reused" over to the "flags"
> field so modifications are safe.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Not fixing any known bugs; problem is theoretical and found by code
> inspection. Change is done somewhat manually and only lightly tested
> (mostly compile-time tested).
> 
> (no changes since v4)
> 
> Changes in v4:
> - Use accessor functions for flags
> 
> Changes in v3:
> - New
> 
>  drivers/base/core.c                      | 2 +-
>  drivers/base/pinctrl.c                   | 2 +-
>  drivers/base/platform.c                  | 2 +-
>  drivers/net/pcs/pcs-xpcs-plat.c          | 2 +-
>  drivers/of/device.c                      | 6 +++---
>  drivers/pci/of.c                         | 2 +-
>  drivers/pci/pwrctrl/core.c               | 2 +-
>  drivers/regulator/bq257xx-regulator.c    | 2 +-
>  drivers/regulator/rk808-regulator.c      | 2 +-
>  drivers/tty/serial/serial_base_bus.c     | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c | 2 +-
>  include/linux/device.h                   | 7 ++++---
>  12 files changed, 17 insertions(+), 16 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

