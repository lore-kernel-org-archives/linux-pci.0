Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13A36C9C7;
	Mon,  2 Mar 2026 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454223; cv=none; b=b9MoijIeyR1trVEYwOdq+1dGMh+ufiXx3uEd4o/Q86JSe8ychgRwi0QKd+2gPY+JbaeCMO4XidEezVyE5AtfGJGAwJ6iuF8p5u+u61JKS+gUysaWWxe/D+qZh0GlEWjXLUUt+75V9SqNPxYX4z/LcFRfxVG1UF2wCDy93GddACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454223; c=relaxed/simple;
	bh=9F5qVvxWqgllHaVQRQ186J27Mo9BDQLO2p1Y55OAssQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UAndQjlpNlb1gDRzoCg1/sgrik3KTtW7NnjYOeB/QZSEVNO30YAdHr60LTgGdbs8aVMd0GAW2+6EepspqmNFHEXbj6XUViDhDFCVJTU5jnn9sMLFN7OZQgyStJo2hDuO7rzghLrjMk68pE7H7mfDwP3YzsgABBrxLrKoML0Jqe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fPdPS5pX4zJ46xn;
	Mon,  2 Mar 2026 20:23:08 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 3222740086;
	Mon,  2 Mar 2026 20:23:40 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Mar
 2026 12:23:37 +0000
Date: Mon, 2 Mar 2026 12:23:36 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Herve Codina <herve.codina@bootlin.com>
CC: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Geert
 Uytterhoeven" <geert+renesas@glider.be>, Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, "Sascha Hauer"
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "Michael Turquette"
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Andi Shyti"
	<andi.shyti@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>, "Arnd Bergmann" <arnd@arndb.de>, Saravana
 Kannan <saravanak@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, Charles
 Keepax <ckeepax@opensource.cirrus.com>, Richard Fitzgerald
	<rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, "Linus
 Walleij" <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Mark
 Brown" <broonie@kernel.org>, Len Brown <lenb@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, "Shawn Guo" <shawnguo@kernel.org>,
	Wolfram Sang <wsa@kernel.org>, <linux-kernel@vger.kernel.org>,
	<driver-core@lists.linux.dev>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<patches@opensource.cirrus.com>, <linux-gpio@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Allan Nielsen
	<allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli
	<luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 07/28] driver core: fw_devlink: Introduce
 fw_devlink_set_device()
Message-ID: <20260302122336.00006bd8@huawei.com>
In-Reply-To: <20260227135428.783983-8-herve.codina@bootlin.com>
References: <20260227135428.783983-1-herve.codina@bootlin.com>
	<20260227135428.783983-8-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 27 Feb 2026 14:54:04 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> Setting fwnode->dev is specific to fw_devlink.
> 
> In order to avoid having a direct 'fwnode->dev = dev;' in several
> place in the kernel, introduce fw_devlink_set_device() helper to perform
> this operation.
> 
I don't mind the helper, but the description could do with a little
detail on why.  Is it just to avoid visibility of internal details, or
is there a stronger reason?

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  include/linux/fwnode.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index a921ca2fe940..a1345e274125 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -231,4 +231,10 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
>  void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode);
>  bool fw_devlink_is_strict(void);
>  
> +static inline void fw_devlink_set_device(struct fwnode_handle *fwnode,
> +					 struct device *dev)
> +{
> +	fwnode->dev = dev;
> +}
> +
>  #endif

