Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A55048E0FA
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944770; cv=none; b=ZTHuYICXAq4VYTeHeYHj55+XCdBFPRCpkqPAXwI9yOTfESrgpM0gzLTDs4il+GAMG0EJ06E+0BShA8esKfw4+5/MShUDJtN9J1w1V1wqKD7xN3MxD41vIITxiRqDyhxdli8VQB6tZMh1Z+8UdgUGXYalZ2k+KvEa5opkgj3V0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944770; c=relaxed/simple;
	bh=QQV18hwqKqeENKyCH3TDO4b/Yw2a+OYX7FmnfmdULjg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2zDaVY/M5uyFJo8ojMGymzWxLd8vA/TwruOSnKvGyt+Q4suUvH+r9IBJbvdappwC1A0rPb6WHX0pO3vHdrEzdxKfFNLYeHtmTNFGB4X932gPt2d/g0av2Mey3d/QYNiREiJEBQWYaTngzd9hOXmEYeiH0OHjiaGXgwQiCoJBTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft6Gv7M/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft6Gv7M/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A4E1F00ACF
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944765;
	bh=d53tIvxM7DlaCQCzMfkFyVTgBez1OJdvd04hGN0OaWs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Ft6Gv7M/YaH9d67lwxIZI3P75Kpi6ZuktryKN6kIOoFIdWICn/cdynCTCd7R8sO98
	 PY4eFyDQFdWzX4EcBbq37210wW2nIgEvWfRVQp+gh3tNj01RVvwc2GNBVP48dg29N4
	 GiKsS2S8g8DnDcFItx8S3tNpIYD91Mwb3t1sC/DrDO7y/chiuWWRlZshxxm2ywFTy+
	 09JMQt0IYvJ1jlANn6Lz0un+5ebu052hzv/egNdoHoQUY/h6EJipTp4gVSA21AZIB0
	 5KNsydoQZJttwlTnMd2jCC/+Ynrx/2KInaF0imHTRlhuWfLm3nHxzgWAx8hxIS6X0V
	 MaoZmcY/fzD3Q==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39ca300db70so42526141fa.2
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 02:06:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByF6WmEoUGjyqJfJI3+OmxtZgPZxL9dJ2faVS/UXmnvIMNUeCvZvqpWSwJH2sbgtNBZCpsuq45whWI=@vger.kernel.org
X-Gm-Message-State: AFuF++kXfbQ8cTbnhGWo2LZQu+sP4qvu5l5Jl4ZE8NPBL4ULeWGGQtLL
	/LtXSWowRG9H32U1wICa+ALRnvOtvYaL28BhaUUCSrpoD19tsO3tN7B5yd++s7xkk5aD7AYHEey
	PWz0bRx+hKrEEUi6N2wiVqb/Tvkh/2Yu9KJkN4gbtbA==
X-Received: by 2002:a2e:bea3:0:b0:3a2:74a:6fcf with SMTP id
 38308e7fff4ca-3a371ae8322mr38461871fa.4.1788944764117; Wed, 09 Sep 2026
 02:06:04 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 02:06:02 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 9 Sep 2026 02:06:02 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260909080114.591938-4-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909080114.591938-1-herve.codina@bootlin.com> <20260909080114.591938-4-herve.codina@bootlin.com>
Date: Wed, 9 Sep 2026 02:06:02 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdPi8KbZ5pHsGKuLCWX+M6Z3qSm+9i6xwswB4ar6FNFbA@mail.gmail.com>
X-Gm-Features: AcwNN1UwJslODOCerlUuV6FoBnhy1k_5d4jjD35u2ytGcv80h-iRY_lEJIwcKkY
Message-ID: <CAMRc=MdPi8KbZ5pHsGKuLCWX+M6Z3qSm+9i6xwswB4ar6FNFbA@mail.gmail.com>
Subject: Re: [PATCH v11 03/10] pinctrl: cs42l43: Use fw_devlink_set_device()
To: Herve Codina <herve.codina@bootlin.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, Steen Hegelund <steen.hegelund@microchip.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Richard Cheng <icheng@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Len Brown <lenb@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Lizhi Hou <lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Sep 2026 10:01:02 +0200, Herve Codina <herve.codina@bootlin.com> said:
> The code set directly fwnode->dev field.
>
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> ---
>  drivers/pinctrl/cirrus/pinctrl-cs42l43.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
> index 8990fab0446c..563070aba3d8 100644
> --- a/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
> +++ b/drivers/pinctrl/cirrus/pinctrl-cs42l43.c
> @@ -576,7 +576,7 @@ static int cs42l43_pin_probe(struct platform_device *pdev)
>  				return ret;
>
>  			if (!child->dev)
> -				child->dev = priv->dev;
> +				fw_devlink_set_device(child, priv->dev);
>  			fwnode = child;
>  		}
>  	}
> --
> 2.55.0
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
