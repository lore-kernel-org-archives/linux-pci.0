Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F45236C0C4;
	Sun,  8 Mar 2026 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772971325; cv=none; b=dVpGj7ZKq3p/q3j8J1hKywYehkfVy7WuWEokYHNkBGeVuSfuhGEbTRLrgRZ7WvMCusJrf5ZjmrLt9tDX1Ls+ycLExN1v7TfdHTB+kW3QiI9p6ySbA/jBF5Dxx9IcOUVg52ytESkSqV9JcmHi1RockLh/ApA4A3C/ZF/djvGfjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772971325; c=relaxed/simple;
	bh=Bq7Wkz/Cpwn1dgha1SO/prRohbZTrXxPYbLnSfgU+/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD7dDMpVFszWvyrcajM6dQaSWRydPCJ6VlgIzppqiaWuHkfxgCLas9vmAQMdXiOYg0o2fiR6GNTX/Ydb+dQMBwi/p3Maq/2xO3BkBXDEzeqWSqQgx7lWV+jWwkP4233ntQrqHBov6HzVUgkwoF+02u4BsCY21Y9rcSDjOZe0Fkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FFzDtZuY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FFzDtZuY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g77KuUu7tZV2EWc/eRT4uXRlFQCkO7bU5cTH+0cVCG0=; b=FFzDtZuYkC0DnUyz163rl2C0J7
	BlNREDfLbFSqsCDGG7wyqYQIkW9dVN3DggsHpt6BqHwHaaJCJYr5hlnQvXRkPPQ41ar85DzFhMEmB
	gFC6oC5eK9H+7BsTfL2Qaie+4PSNMBteqELve/Q0cUSwwEHPGq6uEDlwML0R5lJ8E5ebW00T/Vzut
	DuJXep+nuwECH8QlUkCKWVPiRO/PGZMUciO0bD5lSEzEqQr2CySIpJWpeB2FiLZRSgN1aKy5u1pjb
	388/H2D8TPVbJxV+5QHfwZsd8BBR1NJAj5Afn5lTxCrADySNQUKbR+nvc2uheAu2RvUMjRHBcPj35
	vAoAoQ0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57616)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vzCpK-000000002nH-1IFO;
	Sun, 08 Mar 2026 12:01:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vzCpF-000000003JS-0B1B;
	Sun, 08 Mar 2026 12:01:37 +0000
Date: Sun, 8 Mar 2026 12:01:36 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: vladimir.oltean@nxp.com
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 phy-next 22/24] phy: include PHY provider header (2/2)
Message-ID: <aa1lIBO3j_apIPjb@shell.armlinux.org.uk>
References: <20260308114009.2546587-1-vladimir.oltean@nxp.com>
 <20260308114009.2546587-23-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308114009.2546587-23-vladimir.oltean@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Mar 08, 2026 at 01:40:07PM +0200, vladimir.oltean@nxp.com wrote:
> diff --git a/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c b/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
> index 5b1c82459c12..4f8ffc6524ab 100644
> --- a/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
> +++ b/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
> @@ -7,10 +7,11 @@
>  #include <linux/ethtool.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  
> +#include "../phy-provider.h"
> +

As we know, this will conflict with my patch in net-next. I guess Vinod
hasn't (yet?) merged the commit that Jakub provided.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
